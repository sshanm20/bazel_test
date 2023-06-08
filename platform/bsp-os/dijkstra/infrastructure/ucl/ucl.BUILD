load("@my_custom_rules//:ghs_macros.bzl", "make_library")


package(default_visibility = ["//visibility:public"])

cc_library(
    name = "Common",
    #  srcs = ["src/EcuM.c"],
    hdrs = [
        "src/Common/Ucl.h",
        "src/Common/UclBufferPool.h",
        "src/Common/UclCmnRingBuffer.h",
        "src/Common/UclCmnSerialize.h",
        "src/Common/UclCrc.h",
        "src/Common/UclVmfMsgQueue.h",
        "src/Common/Ucl_Types.h",
    ],
    includes = ["src/Common"],
)

cc_library(
    name = "UclDLConfig",
    #  srcs = ["src/EcuM.c"],
    hdrs = glob([
        "src/DataLayer/Common/*.h",
        "src/DataLayer/UclDL/*.h",
    ]),
    includes = [
        "src/DataLayer/Common",
        "src/DataLayer/UclDL",
    ],
)

cc_library(
    name = "UclSysCommonConfig",
    #  srcs = ["src/EcuM.c"],
    hdrs = [
        "src/System/Common/UclSys.h",
        "src/System/Common/UclSys_Types.h",
    ],
    includes = ["src/System/Common"],
    #  deps = [
    #        "//cluster-platform/turing/fbl/oem_ford/BSW:FblBswConfig",
    #"//cluster-platform/turing/vautosar/sys/crc/src/test.harness/CRCLIB_VCAST_HT:Crclib_vcast_ht",
    #    "//cluster-platform/turing/fbl/oem_ford/mcal/imx8-package1/plugins/Base:CommonConfig",
    #"//cluster-platform/turing/fbl/oem_ford/BSW/FblAsrStubs",
    # ],
)

cc_library(
    name = "UciiLCommonConfig",
    hdrs = glob([
        "src/InterfaceLayer/Common/*.h",
    ]),
    includes = [
        "src/InterfaceLayer/Common",
    ],
)

cc_library(
    name = "UclDL_Impl",
    hdrs = glob(["src/DataLayer/UclDL/*.h"]),
    includes = ["src/DataLayer/UclDL"],
)

cc_library(
    name = "UclAlDebugNull_Impl",
    hdrs = glob(["src/Abstraction/Debug/Null/*.h"]),
    includes = ["src/Abstraction/Debug/Null"],
)

cc_library(
    name = "UclAlOsASR_Impl",
    hdrs = glob(["src/Abstraction/Os/ASR/*.h"]),
    includes = ["src/Abstraction/Os/ASR"],
)

cc_library(
    name = "UclALPhyMuASR_Impl",
    hdrs = glob(["src/Abstraction/Phy/MuASR/*.h"]),
    includes = ["src/Abstraction/Phy/MuASR"],
)

cc_library(
    name = "UclSysDL_Impl",
    hdrs = glob(["src/System/UclSysDL/*.h"]),
    includes = ["src/System/UclSysDL"],
)

cc_library(
    name = "ucl_src_Common",
    hdrs = glob([
        "src/Common/*.h",
        "src/Abstraction/Common/*.h",
        "src/Adapters/Common/*.h",
    ]),
    includes = [
        "src/Abstraction/Common/",
        "src/Adapters/Common/",
        "src/Common",
    ],
)

cc_library(
    name = "UclSys_Impl",
    hdrs = glob(["src/System/UclSys/*.h"]),
    includes = ["src/System/UclSys"],
)

exports_files(
    glob([
        "**/*.c",
    ]),
)
