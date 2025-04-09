// Title: Data Analysis Using Statistical Packages: Basic Operation of Stata 
// Author: Sho Kuroda
// Last update: Apr 2025

// R版 https://kurodaecon.github.io/dasp/html/basic.html に対応

// 早大生は次のページを参照して Stata を各自のPCにインストール可能
// https://support.waseda.jp/it/s/software/stata?language=ja

***************************************************************************
* 1 Basic operating instructions / 基本的な操作
***************************************************************************

// 実行したい行またはその行の一部分を選択して 「実行 (do)」 ボタンをクリックすると実行される
// 複数行（またはその一部）を選択して一気に実行することも可
// キーボードのショートカットは 「Ctrl」 + 「D」 

// （おまけ）　実行するが結果（計算結果など）を表示させたくない場合は 「Ctrl」 + 「R」 を同時に押す

display 1 + 1
di 1 + 1  // display に対応する短縮コマンドは di

** 1.1 Basic arithmetic operations / 四則演算 

display 1 + 1  // addition 
display 2 - 3  // subtraction 
display 2 * 3  // multiplication 
display 2 / 3  // division 

** 1.2 Comment out / コメントアウト

// ← 「//」 以降はコメントアウトされる（＝実行されない）
* ← 文頭の場合は 「*」 もコメントアウトに使える
** ← 複数使ってもよい

display 1 + 2 + 10
display 1 + 2  // + 10
* display 1 + 2

** 1.3 Power, square root, log, exponent / べき乗，平方根，対数，指数

display 2 ^ 3  // 2 to the power of 3 
display sqrt(16)  // square root 
display log(10)  // natural logarithm 
display exp(1)  // exponential, e = Napier's constant 

** 1.4 Help / ヘルプ

help exp

** 1.5 Objects / オブジェクト

// 円周率などの定数は既に割り当てられている

display _pi  // 3.1415... 

// R におけるオブジェクトの概念とは互換でないものの，たとえばスカラーを保存するには以下のようにする

scalar x = 1
display x
display x + 1

** 1.6 Vectors / ベクトル

// マクロ変数を使うことで R のベクトルオブジェクトに似たものをつくることができるが，R とは想定される使用法が異なるようなので省略

** 1.7 Other tips: semicolon

// Stata に該当するものはない


***************************************************************************
* 2 Dataframe / データフレーム
***************************************************************************

** 2.1 Create data frames / データフレームを作成する

// 現時点で存在するデータ（もしあれば）を削除

clear

// Beatles データを作る

// 注: 
// 文字列変数は srt# (# = 文字列最大長) で定義する．
// 欠損値は 「.」 で表される

input str10 name     born decease height
            "John"   1940 1980    179
            "Paul"   1942 .       180
            "George" 1943 .       178
            "Ringo"  1940 .       170
end

// 表示させる

list

** 2.2 Extract a portion of the data frame / データフレームの一部を取り出す

// 1つの行だけ表示させる

list in 1

// 連続する複数の行を表示させる

list in 2/3

// 1つの変数だけ表示させる

list name // すべての行
list name in 1  // 1行目だけ
list name in 1/2  // 1-2行目だけ

// 複数の変数を表示させる

list name born // すべての行
list name born in 1  // 1行目だけ

// 特定の条件を満たすデータのみ表示させる

list if born == 1940

** 2.3 Display the structure of an object / オブジェクトの構造

describe  // d と省略してもよい

** 2.4 Change the value of the data frame / データフレームの値を変更する

list in 3
replace decease = 2001 in 3
list in 3

** 2.5 Create new variable (column) / 新しい変数（列）を追加する

// 既存の変数に基づく場合

generate age_at_debut = 1962 - born  // gen と省略してもよい
list

// 変数の削除

drop age_at_debut
list

// 既存の変数に基づかない場合

generate primary_role = ""
replace primary_role = "vocal" in 1
replace primary_role = "vocal" in 2
replace primary_role = "guitar" in 3
replace primary_role = "drum" in 4
list

// Stata では変数に対して label を付けることができる
// label は図の軸タイトルなどに利用される

label variable name "first name"  // clear や drop なしで上書き可能
label variable born "birth year"
describe

// カテゴリー変数を indicator 化して記録している場合などには 「値ラベル」 が使える

drop primary_role
generate primary_role = 0
replace primary_role = 1 in 3
replace primary_role = 2 in 4
label define pr_label 0 "vocal" 1 "guiter" 2 "drum"
label values primary_role pr_label
list  // ラベルで表示されるが，データそのものは {0, 1, 2} で記録されている
describe

// Stata では dta 形式でデータを保存できる

cd "c:/ws_stat"  // change directory 
pwd  // path of the current working directory 
save beatles, replace  // replace は上書き（同名のファイルがなければ新規作成）

// 呼び出す

use beatles, clear

** 2.6 Sample data "auto" / サンプルデータ

sysuse auto, clear  // カンマの後はオプション．clear は既存データがあれば削除するオプション
describe
summarize  // 要約統計量


***************************************************************************
* 3 Plot / 描画
***************************************************************************

// データ読み込み

sysuse auto, clear

// 散布図
// 注：変数に variable label が定義されていれば，軸のラベルには変数名そのものではなくラベルが使われる

scatter mpg weight

// デフォルトのテーマを変えるとよい

set scheme s1color
scatter mpg weight // どのように変わったかを確認

// 散布図をカスタマイズ

scatter mpg weight, msymbol(S) mcolor(blue) title("Fuel Efficiency vs. Weight") xtitle("Weight (lbs)") title("Miles per Gallon (mpg)")
// msymbol = marker symbol, "S" = Square 
// mcolor = marker color 

// 上のコマンドは長くて見にくいので /// を使って改行しながら一つのコマンドを記述できる

scatter mpg weight, ///
    msymbol(S) mcolor(blue) /// msymbol = marker symbol, "S" = Square 
    title("Fuel Efficiency vs. Weight") ///
    xtitle("Weight (lbs)") ///
    ytitle("Miles per Gallon (mpg)")

// 複数行にわたって適用できるコメントアウト /* ... */ を使ってもよい

scatter mpg weight, /*　この中の部分がコメントアウトされる
    */ msymbol(S) mcolor(blue) /*
    */ title("Fuel Efficiency vs. Weight") /*
    */ xtitle("Weight (lbs)") /*
    */ ytitle("Miles per Gallon (mpg)")

// 複数の図を並べる

scatter mpg weight, title("MPG vs. Weight") name(graph1, replace)
scatter mpg price, title("MPG vs. Price") name(graph2, replace)
graph combine graph1 graph2



***************************************************************************
* 4 Loading CSV file / CSVファイルを読み込む
***************************************************************************

** 4.1 import 

cd "c:/ws_stat"
import delimited "titanic3_csv.csv", clear

** 4.3 import from the external URL link 

import delimited using "https://raw.githubusercontent.com/kurodaecon/bs/main/data/titanic3_csv.csv", clear

** 4.4 Data overview / データの概観

describe
list in 1/10

** 4.5 Output file / ファイルを出力

// データセットの一部だけを残す
keep in 1/6 

// 出力

export delimited using "titanic_first_6_rows.csv", replace 

// 注：元のデータを保持しながら 「データセットの一部を切り出してそれを保存」 を行うなら preserve と restore を組み合わせて使う


***************************************************************************
* 5 Custom functions / 自作の関数
***************************************************************************

program define return_squared
    args x  // taking input as a scalar (local macro)
    display `x'^2
end

return_squared 5

program drop return_squared // erase program 
program drop _all // erase all programs 

** 補足： Local macro について
// see https://www.stata.com/manuals13/u18.pdf 

// 使い方1: 数値の例
// Local macro を定義
local localmacro1 123
// Single-quote 「`」 と 「'」 を使って定義した local macro を使う
display `localmacro1' + 10000

// 注: 
// local macro の定義と，定義した macro の使用は，一度に実行されないといけない
// テクニカルに言うと，local macro は private な変数として定義されるため
// program の中で定義した local macro をプログラム外から参照したりましてや変更することはできない

// 使い方2: 文字列の例
local localmacro2 Aa Bb Cc
display "`localmacro2'"

// 使い方3: 変数名
sysuse auto, clear
local localmacro3 price mpg
list `localmacro3' in 1/6
list price mpg in 1/6 // same as above

// 使い方4: コマンド名
local localmacro4 list
`localmacro4' price in 1/6
list price in 1/6 // same as above

** 補足： Global macro について

// Glocal macro を定義
global globalmacro1 123
// ドルマーク 「$」 を使って定義した global macro を使う
display $globalmacro1 + 10000

// 注: 
// Global macro は local macro と異なり public な macro なので，定義と使用は別々に実行可能

macro drop globalmacro1 // erase macro 
macro drop _all // erase all macros 


** 5.1 Example: Examine whether it is a leap year or not / 閏年の判定

display mod(2024, 4)  // 2024 を 4 で割った余り

program define examine_leap
    args year
    if mod(`year', 4) == 0 {
        if mod(`year', 100) == 0 & mod(`year', 400) != 0 {
            display "Not leap year"
        }
        else {
            display "Leap year"
        }
    }
    else {
        display "Not leap year"
    }
end

examine_leap 2024
examine_leap 2100
examine_leap 2400


***************************************************************************
* 6 Iterative calculations / 繰り返し計算
***************************************************************************

// 数値を使ってループを回す場合は forvalues

forvalues i = 1/3 {
    display `i'
}

// foreach は文字列も適用可

foreach i in 1 2 3 {
    display `i'
}

foreach i in aa bb cc {
    display "`i'"  // ダブルクオーテーションが必要
}

** 6.1 Combine with a custom function

program define is_leap, rclass
    args year
    if mod(`year', 4) == 0 & !(mod(`year', 100) == 0 & mod(`year', 400) != 0) {
        return scalar is_leap = 1
    }
    else {
        return scalar is_leap = 0
    }
end

forvalues y = 2090/2110 {
    is_leap `y'
    if r(is_leap) == 1 {
        display `y'
    }
}


***************************************************************************
* 7 Matrix / 行列
***************************************************************************

matrix M = (1, 5) \ (2, 6) \ (3, 7)
matrix list M

** 7.1 Transposed matrix / 転置行列

matrix tM = M'
matrix list tM

** 7.2 Matrix product / 行列の積

matrix M2 = (0.1, 0.2, 0.3) \ (0.5, 0.6, 0.7)
matrix prod_M_M2 = M * M2
matrix list prod_M_M2

** 7.3 Inverse matrix / 逆行列

matrix M3 = (1, 3) \ (2, 4)
matrix M3_inv = inv(M3)
matrix list M3_inv

// 単位行列になっているかどうかを確認

matrix product_M3_M3_inv = M3 * M3_inv
matrix list product_M3_M3_inv


***************************************************************************
* Appendix. capture command 
***************************************************************************

// R には直接対応するものがない関数として capture がある
// capture をコマンドの前に付けることで，エラーが出ても処理が中止されず次のコマンドに移ってくれる

// たとえば，試行錯誤しながらコーディングしている場合を考えよう
// generate をつかった変数の生成は同一変数名に対して繰り返し使えない（自動的に上書きされない）ので，generate の前に cap drop しておくとよい

sysuse auto, clear
cap drop price_transformed
generate price_transformed = log(price)

// あるいは，複数人からなる分析プロジェクトで1つの do ファイルを共有している際に，各人固有の作業ディレクトリパスを指定することもできる
// こうしておけば，何も考えずに上からすべて実行することができる

capture cd "c:/ws_stat"  // 1人目のメンバーの作業ディレクトリ
capture cd "c:/project_abc"  // 2人目のメンバーの作業ディレクトリ

// EOS 
