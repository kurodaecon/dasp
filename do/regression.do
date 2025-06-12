// Title: Data Analysis Using Statistical Packages: Regression Analysis 
// Author: Sho Kuroda 
// Last update: Jun 2025 

// R版 https://kurodaecon.github.io/dasp/html/regression.html に対応

***************************************************************************
* 1 Data 
***************************************************************************

import delimited using "https://raw.githubusercontent.com/kurodaecon/dasp/refs/heads/main/data/carsensor_ranking_of_most_popular_car_models_asof202506.csv", clear
describe

// 欠損値が NA で記録されているので，欠損値を含む変数は文字列型で読み込まれている
// 文字列型を数値型に変換　（「NA」 という文字列は欠損値扱いで 「.」 に変換される）
destring wltc ps disp, replace force

** 1.1 Summary stats 

summarize

** 1.2 Create variables 

generate accel = ps / weight
generate kei = (disp <= 660)

** 1.3 Trim dataset

keep if inrange(seat, 4, 5)
drop if inlist(maker, "BMW", "Jeep", "Mercedes-Benz", "Porsche")
keep if price <= 1000
keep if electric == 0
drop electric

***************************************************************************
* 2 Simple regression analysis / 単回帰分析
***************************************************************************

** 2.1 Estimation with regress function

regress price weight

reghdfe price weight  // same as above 

** 2.2 Estimation by hand

summarize price
scalar y_bar = r(mean)
display y_bar

summarize weight
scalar x_bar = r(mean)
display x_bar

* 偏差の計算
gen x_dev = weight - x_bar
gen y_dev = price - y_bar

* S_XX: 偏差二乗和
gen x_dev_sq = x_dev^2
summarize x_dev_sq
scalar s_xx = r(sum)
display s_xx

* S_XY: 偏差積和
gen xy_dev = x_dev * y_dev
summarize xy_dev
scalar s_xy = r(sum)
display s_xy

* 回帰係数の計算
display s_xy / s_xx  // beta hat 
display y_bar - (s_xy / s_xx) * x_bar  // alpha hat 

** 2.3 Estimation by numerical calculation / 数値計算による推定

// 省略

** 2.4 Coefficient of determination / 決定係数

// Y の予測値
regress price weight
predict y_hat, xb
// generate y_hat = _b[_cons] + _b[weight] * weight  // same as above 

// S_YY: Y の全変動
generate y_dev_sq = y_dev^2
summarize y_dev_sq
scalar s_yy = r(sum)
display s_yy

// hat(Y) の変動 （S_YHYH） を使って計算する場合
generate yhat_dev = y_hat - y_bar
generate yhat_dev_sq = yhat_dev^2
summarize yhat_dev_sq
scalar s_yhyh = r(sum)
display s_yhyh
display s_yhyh / s_yy  // R^2 

// 残差を使って計算する場合
generate residual = price - y_hat
generate resid_sq = residual^2
summarize resid_sq
scalar ssr = r(sum)  // sum of squared residuals 
display 1 - ssr / s_yy  // R^2 

** 2.5 Standard error and test / 標準誤差と検定

scalar df = _N - 2  // degree of freedom 
display df 

scalar sigma2 = ssr / df  // estimate of the error variance 
display sigma2 

scalar beta_se = sqrt(sigma2 / s_xx)  // standard error of beta 
display beta_se 

scalar t_value = (s_xy / s_xx) / beta_se  // t-value 
display t_value 

display 2 * (1 - t(df, t_value))  // p-value 

** 2.5.1 cf. Critical value approach / 臨界値を用いて検定を行う場合

display invt(df, 0.005)
display invt(df, 0.025)
display invt(df, 0.975)
display invt(df, 0.995)

display invt(10000, 0.975)
display invnormal(0.975)  // as reference 

** 2.5.2 MC Simulation

// 省略

** 2.5.3 Robust standard error / 頑健な標準誤差

regress price weight, robust

** 2.5.4 Cluster-robust standard error / クラスター頑健標準誤差

regress price weight, vce(cluster maker)

***************************************************************************
* 3 Multiple regression analysis / 重回帰分析
***************************************************************************

regress price weight ps

** 3.1 Multicollinearity / 多重共線性
** 3.1.1 Example of perfect multico. / 完全な多重共線性の例

generate weight2 = 2 * weight
correlate weight weight2
regress price weight weight2

** 3.4.2 Example of imperfect multico. / 不完全な多重共線性の例

correlate price weight length width

regress price weight
regress price length
regress price width
regress price weight length width

** 3.4.3 Using VIF for diagnostics / VIF による診断

regress length weight width 
display 1 / (1 - e(r2))

regress price weight length width
vif

** 3.2 Comparing the size of the coefficients / 回帰係数の大きさを比較する

regress price weight ps

** 3.5.1 Comparing the change per one SD / 1標準偏差当たりの変化量の比較

summarize weight
display .24 * r(sd)

summarize ps
display .78 * r(sd)

** 3.5.2 Standardized partial regression coefficient / 標準偏回帰係数

summarize price 
generate z_price = (price - r(mean)) / r(sd)
// egen std_price = std(price)  // same as above 
summarize weight 
generate z_weight = (weight  - r(mean)) / r(sd)
summarize ps 
generate z_ps = (ps - r(mean)) / r(sd)

regress z_price z_weight z_ps

// 一番簡単な方法 （右端の列を参照）
regress price weight ps, beta 

***************************************************************************
* 4 Variable transformation / 変数変換
***************************************************************************

** 4.1 Dummy variables / ダミー変数

tabulate hybrid

regress price hybrid

summarize price if hybrid == 0
summarize price if hybrid == 1

generate recent = (year >= 2022)
regress price weight recent

** 4.2 Adding quardatic or interaction terms / 二次・交差項

generate ps2 = ps^2
regress price ps ps2

generate wh = weight * hybrid
regress price weight hybrid wh

regress price c.weight##i.hybrid

// categorical 変数の場合は i.variable 
// continuous 変数の場合は c.variable 

** 4.3 Log-linear model

generate log_price = log(price)
regress log_price weight

** 4.4 Log-log model

generate log_weight = log(weight)
regress log_price log_weight

** 4.5 Categorical variables

generate Honda  = (maker == "Honda")
generate Mazda  = (maker == "Mazda")
generate Nissan = (maker == "Nissan")
generate Subaru = (maker == "Subaru")
generate Suzuki = (maker == "Suzuki")
generate Toyota = (maker == "Toyota")

list maker Honda Mazda Nissan Subaru Suzuki Toyota in 1/6

regress price weight Honda Mazda Nissan Subaru Suzuki Toyota

encode maker, gen(maker_id)
regress price weight i.maker_id

** 4.5.1 Change the reference group

// base category を Honda に変更
regress price weight ib2.maker_id
regress price weight ib(2).maker_id  // same as above 

***************************************************************************
* 5 Prediction / 予測
***************************************************************************

regress price weight ps
generate pred0 = _b[_cons] + _b[weight] * weight + _b[ps] * ps
list model price pred0 in 1/3

** 5.1 predict function

predict pred1, xb
list model price pred0 pred1 in 1/3

** 5.2 Inverse transformation of log outcomes

regress log_price weight ps
predict yhat, xb
predict res, resid
gen sigma2 = res^2
egen mean_sigma2 = mean(sigma2)  // 本当は残差二乗和を (n-k-1) で割るべきだが．．．
gen pred_correct = exp(yhat + mean_sigma2/2)
gen pred_incorrect = exp(yhat)

list model price pred_correct pred_incorrect in 1/3


***************************************************************************
* 6 Model selection / モデル選択
***************************************************************************

** 6.1 AIC

drop if missing(wltc, ps, disp)

regress price weight
estat ic

regress price weight ps
estat ic

regress price weight ps length width
estat ic

// 注: 
// 実は R で計算する値とちょうど 2 違う （R の AIC 関数が出力する数値の方が 2 大きい）
// これは誤差分散パラメタの扱いが R と Stata で違うためらしい
// ref. https://stackoverflow.com/questions/62307197/

** 3.6.2 Stepwise model selection with AIC

// 省略

** 6.3 Cross validation / 交差検証

// 省略

// EOS 
