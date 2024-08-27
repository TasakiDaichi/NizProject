# Flutterの書き方紹介

## Widgetについて
- Widgetは画面を構成するパーツ
- 基本的にMaterial系統のWidgetを使うこと
- Widgetはパラメータを持っており、その中にさらにWidgetを追加する形式
- WidgetはUpperCamel,パラメータはLowerCamelで使い分け

## Widget例
- Scaffold : 画面のレイアウト用Widget（頻出）
    - appBer ：アプリのタイトル部分
        - AppBer
            - backgroundColor : タイトル部分の背景色を変える
            - title : タイトルの文字列を変える
            - actions : インタラクト可能なIconを生成する
 - body : アプリの本文部分
    - Center
        - child
            - Column : 縦に複数のWidgetを並べて配置するときに使用（頻出）
                - mainAxisAlignment : 画面のどこに寄せて配置するか
                - children : Columnsが複数要素を並べるものなので複数系で指定する
                    - Text
            - Row : Columnとは違い、横に複数のWidgetを配置するときに使用
 - floatingActionButton：アクションボタン部分

- Padding : 指定した部分の周りに余白を付ける
- Container : 指定した部分を囲む（背景色も選択可）
- ElevatedButton : ボタンを生成する
    - onPressed : ボタンが押されたときに呼ばれる部分
- TextStyle : テキストの装飾に使う
    - fontSize
    - color
    - fontWeight : 文字の太さ
    - decoration : アンダーラインの追加

# 作業例一覧

## 画面遷移したい
- main.dart
    - onPressedなどアクションにより実行される部分を用意
        - onPressed : (){
            Naavigator.push(
                context,
                MaterialPageRoute(builder: (context) => NextPage()),
            );
        }, ... 

- next_page.dart
    - class作成
        - class NextPage extends StatelessWigdet{}
        - StatelessWidget準拠のNextPageクラスの意味
    - overrideを作成
        - build関数が自動で生成される（Widgetを定義する関数）

## 画面遷移時に値を渡したい
- next_page.dart
    - class内にイニシャライザを挿入
        - NextPage(this.name);
          String name;

## 入力Formを作成したい
- TextFieldを使用する（cookbook参照）
    - onChangedで入力を取得できる

