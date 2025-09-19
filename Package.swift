// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FFmpegKit",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_15),
        .tvOS(.v11)
    ],
    products: [
        .library(
            name: "FFmpegKit",
            targets: ["FFmpegKit", "libavcodec", "libavdevice", "libavfilter", "libavformat", "libavutil", "libswresample", "libswscale"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "FFmpegKit",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/ffmpegkit.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_FFMPEGKIT"
        ),
        .binaryTarget(
            name: "libavcodec",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libavcodec.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBAVCODEC"
        ),
        .binaryTarget(
            name: "libavdevice",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libavdevice.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBAVDEVICE"
        ),
        .binaryTarget(
            name: "libavfilter",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libavfilter.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBAVFILTER"
        ),
        .binaryTarget(
            name: "libavformat",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libavformat.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBAVFORMAT"
        ),
        .binaryTarget(
            name: "libavutil",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libavutil.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBAVUTIL"
        ),
        .binaryTarget(
            name: "libswresample",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libswresample.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBSWRESAMPLE"
        ),
        .binaryTarget(
            name: "libswscale",
            url: "https://github.com/thalesfp/ffmpeg-kit/releases/download/v7.0/libswscale.xcframework.zip",
            checksum: "PLACEHOLDER_CHECKSUM_LIBSWSCALE"
        ),
    ]
)