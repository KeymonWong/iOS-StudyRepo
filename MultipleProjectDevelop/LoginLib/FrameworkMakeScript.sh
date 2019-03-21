#!/bin/sh

#  FrameworkMakeScript.sh
#  LoginLib
#
#  Created by keymon on 2019/3/21.
#  Copyright © 2019 ok. All rights reserved.


# 要build的target名
echo "start build target"
TARGET_NAME=${PROJECT_NAME}
if [[ $1 ]]
then
TARGET_NAME=$1
fi
UNIVERSAL_OUTPUT_FOLDER="${SRCROOT}/${PROJECT_NAME}/"

# 创建输出目录，并删除之前的framework文件
echo "创建输出目录"
mkdir -p "${UNIVERSAL_OUTPUT_FOLDER}"
rm -rf "${UNIVERSAL_OUTPUT_FOLDER}/${TARGET_NAME}.framework"

# 分别编译模拟器和真机的Framework
echo "Compiling framework for simulator & device"
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphoneos BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build
xcodebuild -target "${TARGET_NAME}" ONLY_ACTIVE_ARCH=NO -configuration ${CONFIGURATION} -sdk iphonesimulator BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}" clean build

# 拷贝framework到univer目录
cp -R "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${TARGET_NAME}.framework" "${UNIVERSAL_OUTPUT_FOLDER}"

# 合并framework，输出最终的framework到build目录
lipo -create -output "${UNIVERSAL_OUTPUT_FOLDER}/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${TARGET_NAME}.framework/${TARGET_NAME}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${TARGET_NAME}.framework/${TARGET_NAME}"

# 删除编译之后生成的无关的配置文件
dir_path="${UNIVERSAL_OUTPUT_FOLDER}/${TARGET_NAME}.framework/"
for file in ls $dir_path
do
if [[ ${file} =~ ".xcconfig" ]]
then
rm -f "${dir_path}/${file}"
fi
done
# 判断build文件夹是否存在，存在则删除
if [ -d "${SRCROOT}/build" ]
then
rm -rf "${SRCROOT}/build"
fi
rm -rf "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator" "${BUILD_DIR}/${CONFIGURATION}-iphoneos"
# 打开合并后的文件夹
open "${UNIVERSAL_OUTPUT_FOLDER}"

echo "all well done!"


# 于是我们编写了一个shell script，在Framework项目编译完成之后把生成的文件copy到Demo项目中。
# 这样就可以在每次编译时更新Demo项目中的Framework和资源文件。

#! /bin/bash
#FRAMEWORK_PATH="${TARGET_BUILD_DIR}/${FULL_PRODUCT_NAME}"
#echo $FRAMEWORK_PATH
#cp -r $FRAMEWORK_PATH "${PROJECT_DIR}/../${PROJECT}Demo/"
#cp -r "${FRAMEWORK_PATH}/${PROJECT}.bundle" "${PROJECT_DIR}/../${PROJECT}Demo/"

# 同时我们在Demo项目的Build Phases中也添加一个脚本，并放在Compile Source之前执行
#FRAMEWORK_DIR="${PROJECT_DIR}/../${FRAMEWORK_NAME}/"
#if [ -d "$FRAMEWORK_DIR" ]; then
#echo "Compiling Framework Project..."
#cd "${PROJECT_DIR}/../${FRAMEWORK_NAME}/"
#xcodebuild -project "${FRAMEWORK_NAME}.xcodeproj" -target ${FRAMEWORK_NAME} -configuration ${CONFIGURATION} -sdk ${SDK_DIR}
#fi
# 这样每次在编译Demo项目之前，都会编译一次Framework项目，并更新Framework。
