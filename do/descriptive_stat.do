// Title: Data Analysis Using Statistical Packages: Descriptive Statistics 
// Author: Sho Kuroda 
// Last update: May 2025 

// R版 https://kurodaecon.github.io/dasp/html/descriptive_stat.html に対応

***************************************************************************
* 1 Loading data / データの読み込み
***************************************************************************

import delimited using "https://raw.githubusercontent.com/kurodaecon/bs/main/data/titanic3_csv.csv", clear
describe

***************************************************************************
* 2 Qualitative data / 質的データ
***************************************************************************

list sex in 1/6

** 2.1 Frequency distribution table / 度数分布表

tabulate sex

** 2.1.1 Count missing values / 欠損値をカウントする

tabulate sex, missing // no missing obs

** 2.2 Bar chart / 棒グラフ

set scheme s1color

graph bar, over(sex)  // proportion 
graph bar (count), over(sex)  // frequency 

** 2.3 Pie chart / 円グラフ

graph pie, over(sex)

** 2.3.1 Add percentage to labels

graph pie, over(sex) plabel(_all percent) 

** 2.4 Contingency table / 分割表

tabulate sex survived

count if sex == "female" & survived == 0
count if sex == "female" & survived == 1
count if sex == "male" & survived == 0
count if sex == "male" & survived == 1

** 2.5 Mode / 最頻値

tabulate sex, sort  // 一番上が最頻値


***************************************************************************
* 3 Quantitative data / 量的データ
***************************************************************************

list age in 1/6

tabulate age, missing

count if missing(age)
count if age == .

** 3.1 Histogram / ヒストグラム

histogram age
histogram age, bin(50)

// カーネル密度の重ね描き

histogram age, addplot(kdensity age)

** 3.2 Frequency distribution table of quantitative data / 数量データの度数分布表

egen age_group = cut(age), at(0, 20, 40, 60, 100)
tabulate age_group

tabulate age_group survived

** 3.3 Mean / 平均

display (1+2+6)/3

** 3.3.1 Example of age variable of Titanic data / タイタニック号乗客データの年齢変数

mean age

summarize age

** 3.4 Quantiles, median / 分位数，中央値

summarize age, detail

_pctile age, percentiles(1 5 10 15 20 25)
return list

** 3.5 Maximum, Minimum, Range / 最大値，最小値，範囲

summarize age, detail

** 3.6 Variance and standard deviation / 分散と標準偏差

** 3.6.1 Example of age variable of Titanic data / タイタニック号乗客データの年齢変数

summarize age
display r(sd)  // summarize の後に実行しないといけない
display r(sd)^2  // summarize で計算された sd を利用して計算

** 3.6.2 Why is the denominator of the sample variance n-1? 

// ローカルマクロなどを使って計算することはできるが Stata には向かないので省略

** 3.6.3 Box plot / 箱ひげ図

graph box age

// 男女別

graph box age, over(sex) 

** 3.7 Scatter plot / 散布図

scatter fare age  // R とはx軸とy軸の指定の順番が異なる点に注意

** 3.7.2 Non-linear relationship

scatter fare age if fare > 0, yscale(log)  // R と違って fare = 0 を除外する必要がある点に注意

** 3.7.3 Data points overlap: 透過度を指定してプロット

scatter fare age, mcolor(%30 green)

** 3.7.4 Scatter plot with jitter: データポイントをずらしてプロット

// original 

scatter parch pclass

// jitter

scatter parch pclass, jitter(5) msize(.2)

** 3.7.5 Binned scatter plot: Bin ごとの平均値をプロット

preserve  // 以下のコマンドでデータセットを不可逆に加工してしまうため，描画が終わったら元に戻す

gen age_bin = floor(age / 5) * 5
collapse survived, by(age_bin)
scatter survived age_bin

restore  // ここで元に戻す

** 3.7.6 Scatterplot Matrix / 散布図行列

graph matrix survived age fare sibsp parch

** 3.8 Covariance and correlation / 共分散と相関係数

// （略）

** 3.8.3 Example of age variable of Titanic data / タイタニック号乗客データの年齢変数

// 次の2つのコマンドは欠損値がある場合の処理の仕方が異なる

correlate age fare parch  // listwise deletion 

pwcorr age fare parch  // pairwise deletion

** 3.8.3.1 Simpson's paradox

correlate age fare if pclass == 1
correlate age fare if pclass == 2
correlate age fare if pclass == 3

summarize age fare if pclass == 1
summarize age fare if pclass == 2
summarize age fare if pclass == 3


** 
** Stata 独自の便利な関数
** 

inspect age // Display simple summary of data's attributes 
codebook age // Describe data contents 

// EOS 
