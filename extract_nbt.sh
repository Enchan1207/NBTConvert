#!/usr/bin/env bash
#
# クライアントjarからNBTファイルを抽出する
#

# versionsを確認
VERSIONS_DIR="./versions"
if [ ! -e $VERSIONS_DIR ]; then
    echo "Please create link to versions directory of minecraft"
    exit 1
fi

# 対象のjarを取得
TARGET_VERSION=$1
if [ ! -e $VERSIONS_DIR/$TARGET_VERSION ]; then
    echo "Specified version $TARGET_VERSION not found."
    exit 1
fi
CLIENT_JAR=$VERSIONS_DIR/$TARGET_VERSION/$TARGET_VERSION.jar
if [ ! -e $CLIENT_JAR ]; then
    echo "Client jar not found. (try to find: $CLIENT_JAR)"
    exit 1
fi
echo "Target version: $TARGET_VERSION (at $(realpath $CLIENT_JAR))"

# 検索
TARGET_FILE=$2
if [ -z $TARGET_FILE ]; then
    echo "Please specify target file."
    exit 1
fi

TARGET_FILE_PATH=$(jar tf $CLIENT_JAR $TARGET_FILE | head -n 1)
if [ -z $TARGET_FILE_PATH ]; then
    echo "Specified file $TARGET_FILE not found."
    exit 1
fi

# 展開・移動
OUTPUT_DIR="extract"
mkdir -p $OUTPUT_DIR
cd $OUTPUT_DIR
jar xf ../$CLIENT_JAR $TARGET_FILE_PATH

echo "Specified file extracted to $OUTPUT_DIR/$TARGET_FILE_PATH"
