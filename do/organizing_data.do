// Title: Data Analysis Using Statistical Packages: Organizing Data 
// Author: Sho Kuroda 
// Last update: Apr 2025 

// R版 https://kurodaecon.github.io/dasp/html/organizing_data.html に対応

***************************************************************************
* 1 Packages in R
***************************************************************************

// 省略

***************************************************************************
* 2 Example of The Beatles data frame
***************************************************************************

** 2.1 Create data frame 

clear
input str6 name born decease height
      "John"    1940 1980    179
      "Paul"    1942 .       180
      "George"  1943 .       178
      "Ringo"   1940 .       170
end

// 今後何度か使うので dta として保存しておこう
cd "c:/ws_stat"
save beatles, replace // replace で上書き

// 使うときは use でロードする
use beatles, clear 

** 2.2 keep rows (filter in R) 

// 見るだけ
list if born >= 1941
list if born >= 1941 & height < 180

// データセットを更新
keep if born >= 1941
list

** 2.3 keep columns (select in R) 

// データセットを更新してしまったので元に戻す
use beatles, clear 

// 見るだけ
list name
list name born

// データセットを更新 
keep name born
list

drop born
list

** 2.4 create new variable (mutate in R) 

// データセットを更新してしまったので元に戻す
use beatles, clear 

generate primary_role = ""

replace primary_role = "vocal" if name == "John"
replace primary_role = "vocal" if name == "Paul"
replace primary_role = "guitar" if name == "George"
replace primary_role = "drum" if name == "Ringo"
list

// 注: 上のコードを実行するとデータセットは更新される

// 既存の変数を利用する場合

generate age_at_debut = 1962 - born 
list

** 2.5 rename 

rename born birth_year
list

** 2.6 merge (left_join in R) 

// データ保存

// 別のデータを作成して dta として保存

clear
input str6 name str6 primary_role
      "John"    "vocal"
      "Paul"    "vocal"
      "George"  "guitar"
      "Ringo"   "drum"
end
save roledata

// メインデータをロード
use beatles, clear 
merge 1:1 name using roledata
list

drop _merge
list

** 2.7 summarise

summarize height, detail

** 2.8 collapse (group_by in R) 

collapse (mean) mean_height = height (sd) std_dev_height = height /// 
   (count) sample_size = height, by(born)
list

** 2.9 Scatter plot

use beatles, clear 

twoway scatter height born

// 軸のラベルを変更

twoway scatter height born, xtitle("Year of birth")

// キャンバスのテーマを変える

twoway scatter height born, scheme(s1color)


// 以下省略

// EOS 
