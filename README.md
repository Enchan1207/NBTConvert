# NBTファイルを取り出して解析する

## Overview

NBTファイルをクライアントjarから抽出して解析する

## Usage

### 1. `versions` ディレクトリの特定

簡単のため `ln -s "/path/to/minecraft/versions" versions` を実行し、クライアントjarのルートディレクトリへのリンクを張っておく

### 2. サーバjarのダウンロード

NBTコンバータ(`net.minecraft.data.Main`)はクライアントjarには同梱されていないため、サーバjarを[ダウンロード](https://www.minecraft.net/ja-jp/download/server)する

```zsh
wget https://example.com/server.jar
```

### 3. NBTファイルの抽出

対象バージョンのクライアントjarから対象のNBTを探す

たとえば: イグルー

```zsh
jar tf ./versions/1.18.2/1.18.2.jar | grep igloo
```

取得したパスをもとに、jarからNBTファイルを抽出 ここはユーティリティスクリプトを用意した

```zsh
./extract_nbt.sh 1.18.2 path/to/target.nbt
```
