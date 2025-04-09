// Title: Data Analysis Using Statistical Packages: Basics of Inferential Statistics 
// Author: Sho Kuroda 
// Last update: Apr 2025 

// R版 https://kurodaecon.github.io/dasp/html/inferential_stat.html に対応

***************************************************************************
* 1 Probability / 確率
***************************************************************************

** 1.1 Expectation and Variance of random variable
** 1.1.1 Example: Dice roll

clear
set obs 6
generate dice = _n
generate prob = 1/6

// 期待値

generate expected = dice * prob
egen expected_value = total(expected)
display expected_value

// 分散

summarize dice, meanonly
scalar mean_dice = r(mean)

generate deviation_sq = (dice - mean_dice)^2
generate weighted_dev = deviation_sq * prob

egen variance = total(weighted_dev)
display variance

** 1.2 Z score

display normal(1.96)

display invnormal(0.975)

display normalden(1.96)

twoway function normalden(x), range(-5 5)

** 1.3 Generating random numbers / 乱数の生成

clear
set obs 5

generate u1 = runiform()

set seed 0
generate u2 = runiform()

set seed 0
generate u3 = runiform()

generate n = rnormal(0, 10)

list

** 1.3.1 Expectation and variance: Random variables from the uniform distribution

// 省略

***************************************************************************
* 2 Central limit theorem / 中心極限定理
***************************************************************************

** 2.1 n=1 

clear
set obs 10000
gen x_bar = runiform()
histogram x_bar, bin(50)

** 2.2 n=2 

clear
set obs 10000
gen x1 = runiform()
gen x2 = runiform()
gen x_bar = (x1 + x2) / 2
histogram x_bar, bin(50)

** 2.3 n=10 

clear
set obs 10000
forvalues i = 1/10 {
    gen x`i' = runiform()
}
gen x_bar = (x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10) / 10
histogram x_bar, bin(50)

***************************************************************************
* 3 Confidence interval / 信頼区間
***************************************************************************

** 3.1 Population mean with known σ / 母集団の標準偏差が既知の場合の母平均

display invnormal(0.025)  // P(Z<z) = 0.025
display invnormal(0.975)  // P(Z<z) = 0.975

display 100 + invnormal(0.025) * 2 / sqrt(100)  // lower limit 
display 100 + invnormal(0.975) * 2 / sqrt(100)  // upper limit 

** 3.2 Population mean with unknown σ / 母集団の標準偏差が未知の場合の母平均

display invt(99, 0.025)  // P(T<t) = 0.025 
display 100 + invt(99, 0.025) * 2 / sqrt(100)  // lower limit 
display 100 + invt(99, 0.975) * 2 / sqrt(100)  // upper limit 

** 3.3 Population proportion / 母比率

scalar n1 = 148
scalar n0 = 382
scalar p = n1 / n0
display p
scalar se = sqrt(p * (1 - p) / n0)
display se

display p + invnormal(0.025) * se  // lower limit of 95% CI 
display p + invnormal(0.975) * se  // upper limit 

***************************************************************************
* 4 Statistical hypothesis testing / 統計的仮説検定
***************************************************************************

** 4.1 One-sample t test for population mean / 1標本の母平均の t 検定
** 4.1.1 Calculation from the sample mean and sd of the data / データの標本平均・標準偏差から計算

scalar t_value = (1230 - 1100) / (170.3 / sqrt(10))
display t_value

display t(t_value, 9)  // # Pr(T <= t) 
display ttail(9, t_value)  // one sided p value ... p = Pr(T > t) 
display 2 * ttail(9, t_value)  // two sided p value 

** 4.1.2 Calculation from the data itself / データそのものから計算 

clear
input wage
1000
1200
1300
1200
1150
1000
1450
1500
1150
1350
end

summarize wage, detail

ttest wage = 1100

** 4.2 Two-sample t test for population mean / 2標本の母平均の t 検定
** 4.2.1 Independent t test
** 4.2.1.1 Example of "wage" data

clear
input group wage
1 1000
1 1200
1 1300
1 1200
1 1150
1 1000
1 1450
1 1500
1 1150
1 1350
2  900
2 1300
2 1200
2  800
2 1600
2  850
2 1000
2  950
end

ttest wage, by(group) unequal  // 等分散を仮定しない

// 注: 
// 自由度の近似に関する "welch" という option があるが，初心者は一切気にしなくてよい

ttest wage, by(group)  // 等分散を仮定する

** 4.2.1.2 Titanic data

import delimited "https://raw.githubusercontent.com/kurodaecon/bs/main/data/titanic3_csv.csv", clear

ttest age, by(sex) unequal

ttest age if pclass == 1, by(sex) unequal

** 4.2.2 Paired (dependent) t test

clear
input wage_w wage_h
1000  900
1200 1300
1300 1200
1200  800
1150 1600
1000  850
1450 1000
1500  950
1150 1200
1350 1400
end

ttest wage_w = wage_h

** 4.3 Multiple testing problem: Simulation / 多重検定の問題に関するシミュレーション 

clear
set obs 1000

generate p_value = .
forvalues i = 1/1000 {
    preserve
    clear
	quietly {  // 結果を出力させない
		set obs 100
		generate x = rnormal(0, 1)
		ttest x = 0
	}
    global p = r(p)
    restore
    quietly replace p_value = $p in `i'
}

histogram p_value, bin(20)

** 4.3.1 Multiple tests performed independently

generate rejected = p_value <= 0.05
tabulate rejected

// 以下省略

// EOS 
