#!/bin/bash -e

cp "board/shredos/grub.cfg"                "${BINARIES_DIR}/grub.cfg"    || exit 1
cp "board/shredos/bootx64.efi"             "${BINARIES_DIR}/bootx64.efi" || exit 1
cp "${HOST_DIR}/lib/grub/i386-pc/boot.img" "${BINARIES_DIR}/boot.img"    || exit 1
rm -rf "${BUILD_DIR}/genimage.tmp"                                       || exit 1
genimage --rootpath="${TARGET_DIR}" --inputpath="${BINARIES_DIR}" --outputpath="${BINARIES_DIR}" --config="board/shredos/genimage.cfg" --tmppath="${BUILD_DIR}/genimage.tmp" || exit 1

# renaming
SUFFIXIMG=$(date +%Y%m%d)
FINAL_IMAGE_PATH="${BINARIES_DIR}/shredos-${SUFFIXIMG}.img"
mv "${BINARIES_DIR}/shredos.img" "${FINAL_IMAGE_PATH}" || exit 1

echo "File ${FINAL_IMAGE_PATH} created successfully"

exit 0
