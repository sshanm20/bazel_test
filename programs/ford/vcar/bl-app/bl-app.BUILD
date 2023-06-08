load("@my_custom_rules//:ghs_macros.bzl", "make_library", "make_binary")

package(default_visibility = ["//visibility:public"])

cc_library(
    name = "Appl_include",
    hdrs = [
        "@bl-app//:Appl/Include/ARMBrsHw_CortexM.h",
        "@bl-app//:Appl/Include/ARMStartup_CortexM.h",
        "@bl-app//:Appl/Include/BrsHw.h",
        "@bl-app//:Appl/Include/BrsMain.h",
        "@bl-app//:Appl/Include/BrsMainStartup.h",
        "@bl-app//:Appl/Include/Brs_MemMap.h",
        "@bl-app//:Appl/Include/CanIf_Cdd.h",
        "@bl-app//:Appl/Include/Compiler_Cfg.h",
        "@bl-app//:Appl/Include/EepCfg.h",
        "@bl-app//:Appl/Include/MemMap.h",
        "@bl-app//:Appl/Include/MemMap_Common.h",
        "@bl-app//:Appl/Include/Os.h",
        "@bl-app//:Appl/Include/SchM_Can.h",
        "@bl-app//:Appl/Include/SchM_CanIf.h",
        "@bl-app//:Appl/Include/SchM_CanTp.h",
        "@bl-app//:Appl/Include/SchM_Det.h",
        "@bl-app//:Appl/Include/SchM_Dio.h",
        "@bl-app//:Appl/Include/SchM_Gpt.h",
        "@bl-app//:Appl/Include/SchM_Mcl.h",
        "@bl-app//:Appl/Include/SchM_Mcu.h",
        "@bl-app//:Appl/Include/SchM_PduR.h",
        "@bl-app//:Appl/Include/SchM_Port_43_Fsl.h",
        "@bl-app//:Appl/Include/SchM_Spi.h",
        "@bl-app//:Appl/Include/SchM_Wdg.h",
        "@bl-app//:Appl/Include/SchM_vMemAccM.h",
        "@bl-app//:Appl/Include/VStdLib_Cfg.h",
        "@bl-app//:Appl/Include/bm_ap.h",
        "@bl-app//:Appl/Include/bm_ap_cfg.h",
        "@bl-app//:Appl/Include/bm_hdr_ap.h",
        "@bl-app//:Appl/Include/comdat.h",
        "@bl-app//:Appl/Include/fbl_ap.h",
        "@bl-app//:Appl/Include/fbl_apdi.h",
        "@bl-app//:Appl/Include/fbl_apnv.h",
        "@bl-app//:Appl/Include/fbl_apwd.h",
        "@bl-app//:Appl/Include/fbl_inc.h",
        "@bl-app//:Appl/Include/fbl_ramio_cfg.h",
        "@bl-app//:Appl/Include/fbl_secboot_ap.h",
        "@bl-app//:Appl/Include/fbl_spi_if_cfg.h",
        "@bl-app//:Appl/Include/fbl_spi_nxp_lpspi_cfg.h",
        "@bl-app//:Appl/Include/vOtaM_Appl.h",
    ],
    includes = ["Appl/Include"],
)

cc_library(
    name = "Appl_Gendata_include",
    hdrs = glob(["Appl/GenData/include/*.h"]),
    includes = ["Appl/GenData/include"],
)

cc_library(
    name = "Appl_Gendata",
    hdrs = glob(["Appl/GenData/*.h"]),
    includes = ["Appl/GenData"],
)

make_library(
    name = "GenMcalFblConfig",
    srcs = [
        "Appl/Source/ARMBrsHwIntTb_CortexM.c",
        "Appl/Source/ARMBrsHw_CortexM.c",
        "Appl/Source/ARMStartup_CortexM.c",
        "Appl/Source/BrsHw.c",
        "Appl/Source/BrsMainStartup.c",
        "Appl/Source/BrsMain_Callout_Stubs.c",
        "Appl/Source/DevlopmentKeyHash.c",
        "Appl/Source/bm_ap.c",
        "Appl/Source/bm_hdr_ap.c",
        "Appl/Source/fbl_ap.c",
        "Appl/Source/fbl_apdi.c",
        "Appl/Source/fbl_apnv.c",
        "Appl/Source/fbl_apwd.c",
        "Appl/Source/fbl_spi_nxp_lpspi_cfg.c",
        "Appl/Source/vOtaM_Appl.c",
        "stubs/AssertLib.c",
        "stubs/EepDrv.c",
        "stubs/EepDrv_Cfg.c",
        "stubs/Gptstub.c",
        "stubs/MemLib.c",
        "stubs/ipc.c",
        "Appl/GenData/CanIf_Lcfg.c",
        "Appl/GenData/CanIf_PBcfg.c",
        "Appl/GenData/CanTp_Lcfg.c",
        "Appl/GenData/CanTp_PBcfg.c",
        "Appl/GenData/Can_Lcfg.c",
        "Appl/GenData/Can_PBcfg.c",
        "Appl/GenData/Det_Cfg.c",
        "Appl/GenData/FblBmHdr_Lcfg.c",
        "Appl/GenData/FblBm_Lcfg.c",
        #######
        "Appl/GenData/FblCw_Lcfg.c",
        "Appl/GenData/FblCw_PBcfg.c",
        "Appl/GenData/Fbl_Fbt.c",
        "Appl/GenData/Fbl_Lbt.c",
        "Appl/GenData/PduR_Lcfg.c",
        "Appl/GenData/PduR_PBcfg.c",
        "Appl/GenData/SecMPar_DevKey.c",
        "Appl/GenData/src/CDD_Mcl_Cfg.c",
        "Appl/GenData/src/CDD_Mcl_PBcfg.c",
        "Appl/GenData/src/Dio_Cfg.c",
        "Appl/GenData/src/Gpt_Cfg.c",
        #######
        "Appl/GenData/src/Gpt_PBcfg.c",
        "Appl/GenData/src/Mcu_Cfg.c",
        "Appl/GenData/src/Mcu_PBcfg.c",
        "Appl/GenData/src/Port_Cfg.c",
        "Appl/GenData/src/Port_PBcfg.c",
        "Appl/GenData/src/Spi_Cfg.c",
        "Appl/GenData/src/Spi_PBcfg.c",
        "Appl/GenData/src/Wdg_43_Instance0_Cfg.c",
        "Appl/GenData/src/Wdg_43_Instance0_Lcfg.c",
        "Appl/GenData/src/Wdg_43_Instance0_PBcfg.c",
        "Appl/GenData/src/Wdg_43_Instance1_Cfg.c",
        "Appl/GenData/src/Wdg_43_Instance1_Lcfg.c",
        "Appl/GenData/src/Wdg_43_Instance1_PBcfg.c",
        "Appl/GenData/src/Wdg_43_Instance2_Cfg.c",
        "Appl/GenData/src/Wdg_43_Instance2_Lcfg.c",
        "Appl/GenData/src/Wdg_43_Instance2_PBcfg.c",
        "Appl/GenData/src/Wdg_CfgExt.c",
        "Appl/GenData/vLinkGen_Lcfg.c",
        "Appl/GenData/vMemAccM_Lcfg.c",
        "Appl/GenData/vOtaM_Lcfg.c",
    ],
    # hdrs = [
    #     "stubs/AssertLib.h",
    #     "stubs/Ea_Cbk.h",
    #     "stubs/EepDrv.h",
    #     "stubs/EepDrv_Cbk.h",
    #     "stubs/EepDrv_Cfg.h",
    #     "stubs/EepDrv_Types.h",
    #     "stubs/MIMX8QXP_M4.h",
    #     "stubs/MemLib.h",
    # ],
    # includes = ["stubs"],
    #visibility = ["//visibility:public"],
    deps = [
        ##########
        ":Appl_Gendata",
        ####
        ":Appl_Gendata_include",
        ####
        ":Appl_include",
        ##########
        ":Stubs",
        #####Now I commented"//programs/ford/vcar/bl-app/stubs:Stubs",
        ###mcal
        "@oem_ford//:Mcal",
        ####BSW
        #####Now I commented"//cluster-platform/turing/fbl/oem_ford/BSW:GenMcal_headers",
        ########
        "@oem_ford//:GenMcal_headers",
        ###Port
        "@oem_ford//:PortConfig",
        ###Wdg
        "@oem_ford//:WdgConfig",
        ##Dio
        "@oem_ford//:DioConfig",
        #####Mcl
        "@oem_ford//:MclConfig",
        ###Spi
        "@oem_ford//:SpiConfig",
        ## common
        "@oem_ford//:CommonConfig",
        ##
        "@oem_ford//:McuConfig",
        ###Scfw
        "@oem_ford//:ScfwConfig",

        # # ########
        # #Working"//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Base:CommonConfig",

        # # "//cluster-platform/turing/fbl/oem_ford/BSW/Det:DetConfig",
        # # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Mcl:MclConfig",

        # ###### 10/2/2023 #######
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Spi:SpiConfig",
        # ######################
        # ##Working"//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Wdg:WdgConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Base:CommonConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Mcu:McuConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Port:PortConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Dio:DioConfig",
        # #"//cluster-platform/turing/fbl/oem_ford/BSW:FblBswConfig_GenMcal",
        # #"//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Wdg:WdgConfig",

        # # #"//cluster-platform/turing/vautosar/sys/crc/src/test.harness/CRCLIB_VCAST_HT",
        # # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Scfw:ScfwConfig",

        # # ########## Dependency added #########

        # # "//programs/ford/vcar/bl-ucl-gen:BlUclVpGenGenConfig",
    ],
)

cc_library(
    name = "Stubs",
    hdrs = [
        "stubs/AssertLib.h",
        "stubs/Ea_Cbk.h",
        "stubs/EepDrv.h",
        "stubs/EepDrv_Cbk.h",
        "stubs/EepDrv_Cfg.h",
        "stubs/EepDrv_Types.h",
        "stubs/MIMX8QXP_M4.h",
        "stubs/MemLib.h",
    ],
    includes = ["stubs"],
    # visibility = [
    #     "//programs/ford/vcar/bl-app:__pkg__",
    # ],
)

make_binary(
    name = "v710_BL.elf",
    srcs = ["Appl/Source/BrsMain.c"],
    defines = ['BAZEL_CURRENT_REPOSITORY="bl-app"'],
    #additional_linker_inputs = ["//programs/ford/my2023/v710/bl-build/tgt:linker_OS_TCM_APP_NOR.ld"],
    linkopts = [
        # "-nostartfiles",
        "-entry=brsStartupEntry",
        # "-g",
        # "-dual_debug",
        # "-pragma_asm_inline",
        # "-strict_overlap_check",
        # "-Olink",
        # "-Mx",
        # "-delete",
        # "-no_codefactor",
        # "--no_link_once_templates",
        # "-linker_warnings",
        # "--preprocess_linker_directive_full",
        # "-map",
        # "$(execpath @bl-build//:tgt/linker_OS_TCM_APP_NOR.ld)",
        # "$(location @bl-build//:tgt/linker_OS_TCM_APP_NOR.ld)",
        # "@bl-build//:tgt/linker_OS_TCM_APP_NOR.ld",
        #"$(location //cluster-platform/turing/fbl/oem_ford/BSW:SecMod/SecMod.a)",
        "-O0",
        "-DNDEBUG",
    ],
    deps = [
        ######libraries
        #"//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Base:CommonConfig",
        "@oem_ford//:DioConfig",
        "@oem_ford//:MclConfig",
        "@oem_ford//:McuConfig",
        "@oem_ford//:PortConfig",
        "@oem_ford//:SpiConfig",
        "@oem_ford//:WdgConfig",
        "@oem_ford//:FblBswConfig_new",
        "@oem_ford//:RteConfig",
        "@bl-ucl-gen//:BlUclVpGenGenConfig",
        "@oem_ford//:ScfwConfig",
        "@oem_ford//:GptConfig",
        ":GenMcalFblConfig",
        "@bl-build//:tgt/linker_OS_TCM_APP_NOR.ld",
        ###linking scripts and library
        "@oem_ford//:sec_lib",
        # #"//cluster-platform/turing/fbl/oem_ford/BSW/Det:DetConfig",
        # #"//cluster-platform/turing/fbl/oem_ford/BSW/FblAsrStubs",

        # #"//cluster-platform/turing/vautosar/sys/crc/src/test.harness/CRCLIB_VCAST_HT",
        # #"//programs/ford/vcar/bl-app/Appl/GenData:Appl_Gendata",
        # #"//programs/ford/vcar/bl-app/Appl/Include:Appl_include",
        # ########## Dependency added #########

        # ":GenMcalFblConfig",
        # "//programs/ford/my2023/v710/bl-build/tgt:linker_OS_TCM_APP_NOR.ld",
        # "//cluster-platform/turing/fbl/oem_ford/BSW:sec_lib",
        # "//cluster-platform/turing/fbl/oem_ford/BSW:FblBswConfig_new",
        # #"//cluster-platform/turing/fbl/oem_ford/BSW/Det:DetConfig",
        # #"//cluster-platform/turing/fbl/oem_ford/BSW/FblAsrStubs",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Base:CommonConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Dio:DioConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Mcl:MclConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Mcu:McuConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Port:PortConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Spi:SpiConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Wdg:WdgConfig",
        # #"//cluster-platform/turing/vautosar/sys/crc/src/test.harness/CRCLIB_VCAST_HT",
        # #"//programs/ford/vcar/bl-app/Appl/GenData:Appl_Gendata",
        # #"//programs/ford/vcar/bl-app/Appl/Include:Appl_include",
        # ########## Dependency added #########
        # "//programs/ford/vcar/bl-ucl-gen:BlUclVpGenGenConfig",
        # "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Scfw:ScfwConfig",
    ],
)