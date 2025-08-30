#/bin/bash
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- distclean
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- imx_v7_defconfig
make V=1 ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- -j$(nproc)


# 设置变量
DTB_FILE="arch/arm/boot/dts/imx6ull-14x14-evk-emmc.dtb"
ZIMAGE_FILE="arch/arm/boot/zImage"
OUTPUT_DIR="output"

# 创建输出目录
if [ ! -d "${OUTPUT_DIR}" ]; then
    mkdir -p "${OUTPUT_DIR}"
fi

# 检查并复制文件
if [[ -f "${DTB_FILE}" && -f "${ZIMAGE_FILE}" ]]; then
    cp "${DTB_FILE}" "${ZIMAGE_FILE}" "${OUTPUT_DIR}/"
    echo "Success: zImage and dtb are placed in \"${OUTPUT_DIR}\" directory"
    echo "Files copied:"
    ls -lh "${OUTPUT_DIR}/"
else
    echo "Error: Required files not found!"
    [[ ! -f "${DTB_FILE}" ]] && echo "Missing: ${DTB_FILE}"
    [[ ! -f "${ZIMAGE_FILE}" ]] && echo "Missing: ${ZIMAGE_FILE}"
    exit 1
fi
