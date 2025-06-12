// Title: Data Analysis Using Statistical Packages: Regression Analysis 
// Author: Sho Kuroda 
// Last update: Apr 2025 

// R版 https://kurodaecon.github.io/dasp/html/regression.html に対応

***************************************************************************
* 1 Simple regression analysis / 単回帰分析
***************************************************************************

** 1.1 Estimation with regress function

// R のサンプルデータ swiss (public domain) を読み込む
use "https://raw.githubusercontent.com/kurodaecon/bs/main/data/swiss.dta", clear
describe

regress Fertility Examination

** 1.2 Estimation by hand

summarize Fertility
scalar y_bar = r(mean)
display y_bar

summarize Examination
scalar x_bar = r(mean)
display x_bar

* 偏差の計算
gen x_dev = Examination - x_bar
gen y_dev = Fertility - y_bar

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
display y_bar - beta_hat * x_bar  // alpha hat 

** 1.3 Estimation by numerical calculation / 数値計算による推定

// 省略

** 1.4 Coefficient of determination / 決定係数

// Y の予測値
regress Fertility Examination
predict y_hat, xb
// generate y_hat = _b[_cons] + _b[Examination] * Examination  // same as above 

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
generate residual = Fertility - y_hat
generate resid_sq = residual^2
summarize resid_sq
scalar ssr = r(sum)  // sum of squared residuals 
display 1 - ssr / s_yy  // R^2 

** 1.5 Standard error and test / 標準誤差と検定

scalar df = _N - 2  // degree of freedom 
display df 

scalar sigma2 = ssr / df  // estimate of the error variance 
display sigma2 

scalar beta_se = sqrt(sigma2 / s_xx)  // standard error of beta 
display beta_se 

scalar t_value = beta_hat / beta_se  // t-value 
display t_value 

display 2 * t(df, t_value)  // p-value 

** 1.5.1 cf. Critical value approach / 臨界値を用いて検定を行う場合

display invt(df, 0.005)
display invt(df, 0.025)
display invt(df, 0.975)
display invt(df, 0.995)

display invt(10000, 0.975)
display invnormal(0.975)  // as reference 

***************************************************************************
* 2 Multiple regression analysis / 重回帰分析
***************************************************************************

regress Fertility Examination Education

***************************************************************************
* 3 Advanced method / 応用
***************************************************************************

** 3.1 Adding quardatic or interaction terms / 二次・交差項

generate Edu2 = Education^2
regress Fertility Examination Edu2

generate ExamEdu = Examination * Education
regress Fertility ExamEdu

regress Fertility c.Examination##c.Education

// categorical 変数の場合は i.variable 
// continuous 変数の場合は c.variable 

generate log_Fertility = log(Fertility)
regress log_Fertility Examination

** 3.2 Dummy variables ダミー変数

summarize Examination
scalar exam_mean = r(mean)
generate byte exam_dummy = (Examination > exam_mean)

regress Fertility exam_dummy

** 3.3 Categorical variables

gen region = ""
replace region = "A" in 1/6
replace region = "C" in 7/11
replace region = "B" in 12/30
replace region = "F" in 31/38
replace region = "D" in 39/44
replace region = "E" in 45/47
tabulate region

// 文字列を factor に変換
encode region, gen(region_factor)

regress Fertility Examination i.region_factor  // default: base category = A

** 3.3.1 Change the reference group

// base category を B に変更
regress Fertility Examination ib2.region_factor
regress Fertility Examination ib(2).region_factor  // same as above 

** 3.4 Multicollinearity / 多重共線性
** 3.4.1 Example of perfect multico. / 完全な多重共線性の例

generate Exam2 = 2 * Examination
correlate Examination Exam2
regress Fertility Examination Exam2

** 3.4.2 Example of imperfect multico. / 不完全な多重共線性の例

generate noise = rnormal(0, 1)
generate Exam_with_noise = Examination + noise
correlate Examination Exam_with_noise
regress Fertility Examination Exam_with_noise

regress Fertility Examination  // as reference 

** 3.4.3 Using VIF for diagnostics / VIF による診断

regress Examination Education Agriculture Catholic
display 1 / (1 - e(r2))

regress Fertility Examination Education Agriculture Catholic
vif

** 3.5 Comparing the size of the coefficients / 回帰係数の大きさを比較する

regress Fertility Examination Agriculture

** 3.5.1 Comparing the change per one SD / 1標準偏差当たりの変化量の比較

summarize Examination
display -1.195 * r(sd)

summarize Agriculture
display -0.094 * r(sd)

** 3.5.2 Standardized partial regression coefficient / 標準偏回帰係数

summarize Fertility 
generate z_Fertility    = (Fertility    - r(mean)) / r(sd)
// egen std_Fertility = std(Fertility)  // same as above 
summarize Examination 
generate z_Examination  = (Examination  - r(mean)) / r(sd)
summarize Agriculture 
generate z_Agriculture  = (Agriculture  - r(mean)) / r(sd)

regress z_Fertility z_Examination z_Agriculture

// 一番簡単な方法 （右端の列を参照）
regress Fertility Examination Agriculture, beta 

** 3.6 Model selection / モデル選択

** 3.6.1 Find AIC

regress Fertility Examination
estat ic

regress Fertility Examination Education
estat ic

regress Fertility Examination Education Agriculture Catholic
estat ic

// 注: 
// 実は R で計算する値とちょうど 2 違う （R の AIC 関数が出力する数値の方が 2 大きい）
// これは誤差分散パラメタの扱いが R と Stata で違うためらしい
// ref. https://stackoverflow.com/questions/62307197/

** 3.6.2 Stepwise model selection with AIC

// 省略


** 
** 補足：誤差項の不均一分散に頑健な標準誤差を使った回帰係数の検定
** 

regress Fertility Examination, vce(robust)
regress Fertility Examination, robust  // same as above 

// EOS 
