# NBTファイルを取り出して解析する

## Overview

NBTファイルをクライアントjarから抽出して解析する

## Usage

### 1. `versions` ディレクトリの特定

簡単のため `ln -s "/path/to/minecraft/versions" versions` を実行し、クライアントjarのルートディレクトリへのリンクを張っておく

### 2. NBTファイルの抽出

対象バージョンのクライアントjarから対象のNBTを探す

たとえば: イグルー

```zsh
jar tf ./versions/1.18.2/1.18.2.jar | grep igloo
```

取得したパスをもとに、jarからNBTファイルを抽出

```zsh
./extract_nbt.sh 1.18.2 path/to/target.nbt
```

抽出されたファイルは `extract` ディレクトリに書き出される

### 3. SNBTへの変換

NBTはそのままでは扱いづらいのでSNBTに変換する

```zsh
./convert_nbt.sh 1.18.2 path/to/target.nbt
```

変換されたファイルは `convert` ディレクトリに書き出される (`_generator_work` はデータジェネレータの作業ディレクトリ)

## Lisence

This repository is published under [MIT License](LICENSE).
