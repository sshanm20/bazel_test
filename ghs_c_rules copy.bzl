load("@bazel_tools//tools/cpp:toolchain_utils.bzl", "find_cpp_toolchain", "use_cpp_toolchain")
load("@rules_cc//cc:action_names.bzl", "C_COMPILE_ACTION_NAME", "CPP_LINK_STATIC_LIBRARY_ACTION_NAME")
load("@bazel_skylib//lib:paths.bzl", "paths")
load(":common_defs.bzl", "feature_configuration", "c_compiler_path", "c_compile_variables", "command_line", "env")
load("//:providers.bzl", "GHSLibraryInfo", "OtherFilesInfo")
load("//:convertCcInfo.bzl", "convert_from_CcInfo")

def _get_transitive_files(ctx): 

    transitive_defines = []
    transitive_hdrs = []
    transitive_includes = []
    transitive_srcs = []

    for dep in ctx.attr.deps:
        if CcInfo in dep:
            converted_ccinfos = convert_from_CcInfo([dep])
            transitive_defines += ["-D" + x for x in converted_ccinfos.defines.to_list() if "-D" + x not in transitive_defines]
            transitive_includes += ["-I" + x for x in converted_ccinfos.includes.to_list() if "-I" + x not in transitive_includes]
            transitive_hdrs += [x for x in converted_ccinfos.hdrs.to_list() if x not in transitive_hdrs]
        if GHSLibraryInfo in dep:
            transitive_srcs += depset(transitive = [dep[GHSLibraryInfo].srcs], order="postorder").to_list()
            transitive_defines += depset(transitive = [dep[GHSLibraryInfo].defines], order="postorder").to_list()
            transitive_includes += depset(transitive = [dep[GHSLibraryInfo].includes], order="postorder").to_list()
            transitive_hdrs += depset(transitive = [dep[GHSLibraryInfo].hdrs], order="postorder").to_list()

    return transitive_srcs, transitive_defines, transitive_includes, transitive_hdrs

def get_dir_path(resolve_path):

    workspace_path = Label(resolve_path).workspace_root
    temp_path = resolve_path.split("//")[1]
    build_file_path, relative_path = temp_path.split(":")
    resolved_dir_path = paths.join(workspace_path, build_file_path, relative_path)

    return resolved_dir_path

def extract_string(input_string):

    output_string = ""
    copy = False
    for char in range(len(input_string)):
        if input_string[char] == "@" or input_string[char] == "//":
            copy = True
        elif input_string[char] == ")":
            break
        elif copy:
            output_string += input_string[char]

    return "@"+output_string

def _collect_files_from_deps(ctx):

    dep_files = []
    for dep in range(len(ctx.attr.deps)):
        if GHSLibraryInfo not in ctx.attr.deps[dep]:
            x = ctx.attr.deps[dep].label
            new_str = str(x)[str(x).rfind(":") + 1:].split("/")[-1]
            for y in ctx.files.deps:
                if y.basename == new_str:
                    dep_files.append(y)

    return dep_files

def _collect_headers(ctx):    

    hdrs = depset(
        ctx.files.hdrs if hasattr(ctx.files, "hdrs") else [],            
        transitive = [dep[GHSLibraryInfo].hdrs for dep in ctx.attr.deps if GHSLibraryInfo in dep],
    ).to_list()

    for src in ctx.files.srcs:
        if src.basename.endswith(".h"):
            hdrs.append(src)

    return hdrs

def _create_obj_files(ctx, src):

    source_file = src
    sep = "."
    file_name_without_extension = src.basename.split(sep)

    cc_toolchain = find_cpp_toolchain(ctx)
    featureConfiguration = feature_configuration(ctx, cc_toolchain)

    flags = ctx.attr.system_family_flags
    
    args = ctx.actions.args()
    args.add_all(flags)

    obj_file = ctx.actions.declare_file(file_name_without_extension[0] + ".obj")
    cCompileVariables = c_compile_variables(ctx, cc_toolchain, featureConfiguration, source_file, obj_file)
    ctx.actions.run(
        executable = c_compiler_path(featureConfiguration),
        tools = cc_toolchain.all_files, ## passing the toolchain binaries through tools
        use_default_shell_env = True,
        arguments = command_line(featureConfiguration, cCompileVariables) + [args],
        mnemonic = 'Compiling',
        inputs = [source_file],
        outputs = [obj_file],
    )

    return [
            DefaultInfo(
                files = depset([obj_file]),
            ),
        ]

def _create_o_files(ctx):
    ################ creating object files ################

    impl_includes = []
    impl_hdrs = []
    impl_srcs = []

    if ctx.attr.implementation_deps:
        for x in ctx.attr.implementation_deps:
            impl_includes += x[GHSLibraryInfo].includes.to_list()
            impl_hdrs += x[GHSLibraryInfo].hdrs.to_list()
            impl_srcs += x[GHSLibraryInfo].srcs.to_list()

    # ccinfos = [dep for dep in ctx.attr.deps if CcInfo in dep]
    # converted_ccinfos = convert_from_CcInfo(ccinfos)
    transitive_srcs, transitive_defines, transitive_includes, transitive_hdrs = _get_transitive_files(ctx)
    # transitive_includes += ["-I" + x for x in converted_ccinfos.includes.to_list() if "-I" + x not in transitive_includes]
    new_defines = ["-D" + x for x in ctx.attr.defines] + transitive_defines
    hdrs = _collect_headers(ctx) + transitive_hdrs

    
    cc_toolchain = find_cpp_toolchain(ctx)
    featureConfiguration = feature_configuration(ctx, cc_toolchain)

    include_paths = [] 
    for x in ctx.attr.includes:
        include_paths.append("-I" + ctx.label.workspace_root + "/" + x)
    include_paths += transitive_includes
    total_arguments = new_defines + ctx.attr.copts + include_paths + impl_includes

    args = ctx.actions.args()
    args.add_all(total_arguments)

    objs = []

    for src in ctx.files.srcs:

        source_file = src
        sep = "."
        file_name_without_extension = src.basename.split(sep)

        flags_and_defines_specific_to_o_files = ["-c99", "-DDEBUG_ASSERT_ON", "-DPROJ_VAR=V710_ED3", '-DBAZEL_CURRENT_REPOSITORY="oem_ford"', '-DVCONST=const', "-DBRS_CPU_CORE_CORTEX_M4", "-DBRS_PROGRAM_CODE_LOCATION_RAM", "-DBRS_VECTOR_TABLE_LOCATION_RAM", "-DDemoFbl", "-DBRS_COMP_GHS", "-DBRS_DERIVATIVE_IMX8QXP", "-DBRS_OS_USECASE_OS", "-DIOHWAB_TASK_TEST_ENABLE", '-DSEC_KEY_USED=1']

        obj_file = ctx.actions.declare_file(file_name_without_extension[0] + ".o")
        cCompileVariables = c_compile_variables(ctx, cc_toolchain, featureConfiguration, source_file, obj_file)
        input_files = [source_file] + hdrs + transitive_srcs + impl_hdrs
        ctx.actions.run(
            executable = c_compiler_path(featureConfiguration),
            tools = cc_toolchain.all_files, ## passing the toolchain binaries through tools
            use_default_shell_env = True,
            arguments = ctx.attr.system_family_flags + flags_and_defines_specific_to_o_files + command_line(featureConfiguration, cCompileVariables) + [args],
            inputs = input_files,
            mnemonic = 'Compiling',
            outputs = [obj_file],
        )

        objs.append(obj_file)

    if not objs:
        fail("No c source files given")   

    return objs

def _binary_impl(ctx):

    ###
    cc_toolchain = find_cpp_toolchain(ctx)
    featureConfiguration = feature_configuration(ctx, cc_toolchain)
    ###

    # ccinfos = [dep for dep in ctx.attr.deps if CcInfo in dep]
    # converted_ccinfos = convert_from_CcInfo(ccinfos)

    transitive_srcs, transitive_defines, transitive_includes, transitive_hdrs = _get_transitive_files(ctx)
    # transitive_defines += ["-D" + x for x in converted_ccinfos.defines.to_list() if "-D" + x not in transitive_defines]
    # transitive_includes += ["-I" + x for x in converted_ccinfos.includes.to_list() if "-I" + x not in transitive_includes]
    # transitive_hdrs += [x for x in converted_ccinfos.hdrs.to_list() if x not in transitive_hdrs]

    objs = _create_o_files(ctx)

    objs += depset(transitive = [dep[GHSLibraryInfo].archives for dep in ctx.attr.deps if GHSLibraryInfo in dep]).to_list()

    extra_linkopts = []

    for x in ctx.attr.linkopts: 
        if x[0] == '$':
            new_string = extract_string(x)
            final_string = get_dir_path(new_string)
            extra_linkopts.append(final_string)
        else:
            extra_linkopts.append(x)

    extra_files_from_deps = _collect_files_from_deps(ctx)    
    objs += extra_files_from_deps + depset(transitive = [dep[OtherFilesInfo].files_from_deps for dep in ctx.attr.deps if OtherFilesInfo in dep]).to_list()

    executable = ctx.actions.declare_file(ctx.label.name)
    args = ctx.actions.args()
    args.add("-o", executable)
    args.add_all(objs)
    args.add_all(extra_linkopts)
    args.add_all(ctx.attr.system_family_flags)

    ctx.actions.run(
        executable = c_compiler_path(featureConfiguration),
        tools = cc_toolchain.all_files, ## passing the toolchain binaries through tools
        use_default_shell_env = True,
        arguments = [args],
        inputs = depset(objs),
        mnemonic = 'Linking',
        outputs = [executable],
    )

    # BSAIMSHU -- reminder to add the executable field to the GHSLibraryInfo provider based on the need

    return  [
        DefaultInfo(files = depset([executable])),
        GHSLibraryInfo(
            hdrs = depset(ctx.files.hdrs, transitive = [depset(transitive_hdrs)], order="postorder"),
            srcs = depset(ctx.files.srcs, transitive = [dep[GHSLibraryInfo].srcs for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
            archives = depset(transitive = [dep[GHSLibraryInfo].archives for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
            defines = depset(ctx.attr.defines, transitive = [depset(transitive_defines)], order="postorder"),
        ),
        OtherFilesInfo(
            files_from_deps = depset(extra_files_from_deps, transitive = [dep[OtherFilesInfo].files_from_deps for dep in ctx.attr.deps if OtherFilesInfo in dep], order="postorder")
        )
    ]

binary = rule(
    implementation = _binary_impl,
    attrs = {
        "srcs": attr.label_list(
            allow_files = [".h", ".c", ".ld"],
            doc = "Source files to compile for this binary",
        ),
        "hdrs":  attr.label_list(
            allow_files = [".h"],
        ),
        "deps": attr.label_list(
            allow_files = True, 
            providers = [[GHSLibraryInfo], [OtherFilesInfo], [CcInfo]]
        ),
        "data": attr.label_list(
            allow_files = [".arm"]
        ),
        "implementation_deps": attr.label_list(
            allow_files = True,
            providers = [[GHSLibraryInfo], [OtherFilesInfo]]
        ),
        "defines": attr.string_list(),
        "copts": attr.string_list(),
        "linkopts": attr.string_list(),
        "includes": attr.string_list(),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
        "system_family_flags": attr.string_list(),
    },
    toolchains = use_cpp_toolchain(),
    fragments = ["cpp"],
)

def _library_impl(ctx):        

    # ccinfos = [dep for dep in ctx.attr.deps if CcInfo in dep]
    # converted_ccinfos = convert_from_CcInfo(ccinfos)

    transitive_srcs, transitive_defines, transitive_includes, transitive_hdrs = _get_transitive_files(ctx)
    if not ctx.attr.srcs:
        extra_files_from_deps = _collect_files_from_deps(ctx)

        archives = []
        for arch in ctx.files.archives:
            archives.append(arch)

        return [
            GHSLibraryInfo(
                archives = depset(archives, transitive = [dep[GHSLibraryInfo].archives for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
                hdrs = depset(transitive = [dep[GHSLibraryInfo].hdrs for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
                srcs = depset(transitive = [dep[GHSLibraryInfo].srcs for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
                includes = depset(transitive = [dep[GHSLibraryInfo].includes for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
                defines = depset(transitive = [dep[GHSLibraryInfo].defines for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
            ),
            OtherFilesInfo(
                files_from_deps = depset(extra_files_from_deps, transitive = [dep[OtherFilesInfo].files_from_deps for dep in ctx.attr.deps if OtherFilesInfo in dep], order="postorder")
            )
        ]

    else:
        cc_toolchain = find_cpp_toolchain(ctx)
        featureConfiguration = feature_configuration(ctx, cc_toolchain)

        total_other_objs = []

        if ctx.files.data:  
            for x in ctx.files.data:
                print(x)
                get_other_objs = _create_obj_files(ctx, x)
                y = get_other_objs[0].files
                total_other_objs += y.to_list()

        ################ create a binary out of object files and archive files ################
        objs = _create_o_files(ctx)

        objs += depset(transitive = [dep[GHSLibraryInfo].archives for dep in ctx.attr.deps if GHSLibraryInfo in dep]).to_list()
        extra_files_from_deps = _collect_files_from_deps(ctx)

        include_paths = [] 
        for x in ctx.attr.includes:
            include_paths.append("-I" + ctx.label.workspace_root + "/" + x)
        include_paths += transitive_includes
        # depset_includes = depset(include_paths)

        static_library = ctx.actions.declare_file("lib" + ctx.label.name + ".a")

        args = ctx.actions.args()
        args.add("-archive")
        args.add("-o", static_library)
        args.add_all(objs)
        args.add_all(ctx.attr.system_family_flags)

        ctx.actions.run(
            executable = c_compiler_path(featureConfiguration),
            tools = cc_toolchain.all_files, ## passing the toolchain binaries through tools
            use_default_shell_env = True,
            arguments = [args],
            inputs = objs,
            mnemonic = 'Archiving',
            outputs = [static_library],
        )

        total_outs = [static_library] + total_other_objs
        # print(total_outs)
        # print(ctx.attr.name)
        # print(sorted(include_paths+ [x for x in transitive_includes if x not in include_paths]))
        # print(sorted(ctx.files.hdrs+transitive_hdrs))
        # print(ctx.attr.defines+transitive_defines)

        return [
            DefaultInfo(
                files = depset(total_outs, order="postorder")
            ),
            GHSLibraryInfo(
                hdrs = depset(ctx.files.hdrs, transitive = [depset(transitive_hdrs)], order="postorder"),
                srcs = depset(ctx.files.srcs, transitive = [dep[GHSLibraryInfo].srcs for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
                archives = depset([static_library], transitive = [dep[GHSLibraryInfo].archives for dep in ctx.attr.deps if GHSLibraryInfo in dep], order="postorder"),
                includes = depset(include_paths, transitive = [depset(transitive_includes)], order="postorder"),
                defines = depset([ "-D" + x for x in ctx.attr.defines ], transitive = [depset(transitive_defines)], order="postorder"),
            ),
            OtherFilesInfo(
                files_from_deps = depset(extra_files_from_deps, transitive = [dep[OtherFilesInfo].files_from_deps for dep in ctx.attr.deps if OtherFilesInfo in dep], order="postorder")
            )
        ]
    
library = rule(
    implementation = _library_impl,
    attrs = {
        "hdrs": attr.label_list(
            allow_files = [".h", ".def", ".imp", ".a"],
            doc = "Public header files for this static library",
        ),
        "srcs": attr.label_list(
            allow_files = [".c", ".h", ".a"],
            doc = "Source files to compile for this binary",
        ),
        ##BSAIMSHU - I doubt the need for this member when we can pass archive files in srcs/hdrs

        "archives": attr.label_list(
            allow_files = [".a"],
        ),
        "deps": attr.label_list(
            allow_files = True,
            providers = [[GHSLibraryInfo], [OtherFilesInfo], [CcInfo]]
        ),
        "data": attr.label_list(
            allow_files = [".arm"]
        ),
        "implementation_deps": attr.label_list(
            allow_files = True,
            providers = [[GHSLibraryInfo], [OtherFilesInfo]]
        ),
        "defines": attr.string_list(),
        "local_defines": attr.string_list(),
        "copts": attr.string_list(),
        "linkopts": attr.string_list(),
        "includes": attr.string_list(),
        "_cc_toolchain": attr.label(default = Label("@bazel_tools//tools/cpp:current_cc_toolchain")),
        "system_family_flags": attr.string_list(),
    },
    toolchains = use_cpp_toolchain(),
    fragments = ["cpp"],
)