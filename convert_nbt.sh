#!/usr/bin/env bash
#
# NBT-SNBT相互変換
#

# versionsを確認
VERSIONS_DIR="./versions"
if [ ! -e $VERSIONS_DIR ]; then
    echo "Please create link to versions directory of minecraft"
    exit 1
fi

# 対象のjsonを取得
TARGET_VERSION=$1
if [ -z $TARGET_VERSION ]; then
    echo "Please specify version"
    exit 1
fi
if [ ! -e $VERSIONS_DIR/$TARGET_VERSION ]; then
    echo "Specified version $TARGET_VERSION not found."
    exit 1
fi
CLIENT_JSON=$VERSIONS_DIR/$TARGET_VERSION/$TARGET_VERSION.json
if [ ! -e $CLIENT_JSON ]; then
    echo "Client json not found. (try to find: $CLIENT_JSON)"
    exit 1
fi
echo "Target client version: $TARGET_VERSION (at $(realpath $CLIENT_JSON))"

# サーバjarを確認
SERVERS_ROOT="servers"
mkdir -p $SERVERS_ROOT
SERVER_JAR=$SERVERS_ROOT/server-${TARGET_VERSION}.jar
if [ ! -e $SERVER_JAR ]; then
    echo "Server jar not found (try to find: $SERVER_JAR)"

    # ないならjsonを読み出して取得
    which jq > /dev/null
    if [ $? -ne 0 ]; then
        echo "Please install jq"
        exit 1
    fi
    SERVER_JAR_URL=$(cat $CLIENT_JSON | jq -r ".downloads.server.url")
    wget $SERVER_JAR_URL -O $SERVER_JAR
fi
echo "Target server version: $TARGET_VERSION (at $(realpath $SERVER_JAR))"

# 対象のファイルを取得
TARGET_FILE=$2
if [ -z $TARGET_FILE ]; then
    echo "Please specify target file"
    exit 1
fi
if [ ! -e $TARGET_FILE ]; then
    echo "Specified file $TARGET_FILE not found."
    exit 1
fi

# 変換の方向を取得
TARGET_FILE_EXT=${TARGET_FILE##*.}
CONVERT_MODE="--dev"
if [ $TARGET_FILE_EXT = "snbt" ]; then
    CONVERT_MODE="--server"
fi

# データジェネレータを起動
GENERATOR_OUTPUT=convert
GENERATOR_TEMP=_generator_work
mkdir -p $GENERATOR_TEMP
mkdir -p $GENERATOR_OUTPUT
cd $GENERATOR_TEMP
java -DbundlerMainClass=net.minecraft.data.Main -jar ../$SERVER_JAR $CONVERT_MODE --input $(dirname ../$TARGET_FILE) --output ../$GENERATOR_OUTPUT
