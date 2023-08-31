# MEMOapp
MEMOappはメモを保存したり編集できるアプリです。

## How to use
1. 必要なgemfileをインストールするために`bundle install`を実行する。
2. メモを保存するためにMEMOappディレクトリの配下に`public/memos.json`を作成。
1行目に`{}`ハッシュのみ記載する。
```json
{}
```
3. アプリを起動する際にはターミナル上に以下のコマンドを打ち込み開始できる。
```bash
$ bundle exec ruby memo.rb
```
4. アプリを終了したときにはターミナル上`ctrl + c`で終了できる。
