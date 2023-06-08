load("//:providers.bzl", "GHSLibraryInfo")

def _impl(ctx):

    includes = []
    defines = []
    headers = []
    user_linkopts = []
    archives = []
    dynamic_lib = []
    source_files = []

    cc_info_var = [dep[CcInfo] for dep in ctx.attr.deps if CcInfo in dep]
    for x in cc_info_var:

        defines += x.compilation_context.defines.to_list()
        defines += x.compilation_context.local_defines.to_list()

        headers += x.compilation_context.headers.to_list()

        includes += x.compilation_context.system_includes.to_list()
        includes += x.compilation_context.quote_includes.to_list()
        includes += x.compilation_context.framework_includes.to_list()

    outfiles_var = [dep[OutputGroupInfo] for dep in ctx.attr.deps if OutputGroupInfo in dep]
    for lfg in outfiles_var:
        if "archive" in dir(lfg):
            print(lfg.compilation_prerequisites_INTERNAL_.to_list())
            archives += lfg.archive.to_list()
            dynamic_lib += lfg.dynamic_library.to_list()


    output_file = ctx.actions.declare_file("converted.txt")
    ctx.actions.run_shell(
        inputs = [],
        outputs = [ output_file ], 
        progress_message = "Touching a new file",
        arguments = [output_file.path],
        command = "touch $1"
    )

    return [
        DefaultInfo(files = depset([output_file] + archives + dynamic_lib)),
        GHSLibraryInfo(
            hdrs = depset(headers, transitive = [dep[GHSLibraryInfo].hdrs for dep in ctx.attr.deps if GHSLibraryInfo in dep ]),
            includes = depset(includes, transitive = [dep[GHSLibraryInfo].includes for dep in ctx.attr.deps if GHSLibraryInfo in dep ]),
            defines = depset(defines, transitive = [dep[GHSLibraryInfo].defines for dep in ctx.attr.deps if GHSLibraryInfo in dep]),
            archives = depset(archives, transitive = [dep[GHSLibraryInfo].archives for dep in ctx.attr.deps if GHSLibraryInfo in dep]),
        ),
    ]

convert_CcInfo_to_GHSCcLibraryInfo = rule(
    implementation = _impl,
    attrs = {
        "deps": attr.label_list(
        providers = [[CcInfo], [GHSLibraryInfo]],
        default = [],
        ),
    }
)

def convert_from_CcInfo(ccinfos):
    includes = []
    defines = []
    headers = []
    user_linkopts = []
    archives = []
    dynamic_lib = []
    source_files = []

    ccinfo_var = [dep[CcInfo] for dep in ccinfos]
    for x in ccinfo_var:

        defines += x.compilation_context.defines.to_list()
        defines += x.compilation_context.local_defines.to_list()

        headers += x.compilation_context.headers.to_list()

        includes += [y for y in x.compilation_context.system_includes.to_list() if not y.startswith("bazel-out")]
        # includes += x.compilation_context.quote_includes.to_list()
        # includes += x.compilation_context.framework_includes.to_list()


    outfiles_var = [dep[OutputGroupInfo] for dep in ccinfos]
    for lfg in outfiles_var:
        if "archive" in dir(lfg):
            archives += lfg.archive.to_list()
            dynamic_lib += lfg.dynamic_library.to_list()

    # default_var = [dep[DefaultInfo] for dep in ccinfos]
    # for di in default_var:
    #     print(di)

    return GHSLibraryInfo(
            hdrs = depset(headers, order="postorder"),
            includes = depset(includes, order="postorder"),
            defines = depset(defines, order="postorder"),
            archives = depset(archives, order="postorder"),
        )