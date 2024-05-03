# Data Analysis Using Statistical Packages 

Graduate School of Commerce and Graduate School of Accountancy, Waseda University 

「統計ソフトによるデータ解析」（早稲田大学商学研究科・会計研究科）

## Main materials 

* [Basic Operation of R / Rの基本的な操作](https://kurodaecon.github.io/dasp/html/basic.html)
   * 演算，オブジェクト，ベクトル，データフレーム，描画，CSVファイルからのデータ読み込み，関数，繰り返し処理，行列
* [Descriptive Statistics / 記述統計](https://kurodaecon.github.io/dasp/html/descriptive_stat.html)
   * 質的データ：度数分布表，棒グラフ，円グラフ，分割表
   * 量的データ：ヒストグラム，平均，分位点・中央値，分散・標準偏差，散布図，共分散・相関係数
* [Organizing and Visualizing Data / データのハンドリングと可視化](https://kurodaecon.github.io/dasp/html/organizing_data.html)
   * `dplyr` パッケージを用いたデータのハンドリング：`filter`, `mutate`, `group_by`, etc.
   * `ggplot2` パッケージを用いたデータの可視化：散布図，ヒストグラム，棒グラフ，箱ひげ図
* [Inferential Statistics / 推測統計学](https://kurodaecon.github.io/dasp/html/inferential_stat.html)
   * 確率：確率変数の期待値と分散，乱数の生成，中心極限定理
   * 信頼区間（母平均，母比率），統計的仮説検定（母平均，多重検定の問題に関するシミュレーション）
* [Regression Analysis / 回帰分析](https://kurodaecon.github.io/dasp/html/regression.html)
   * 基礎：最小二乗法 … `lm` 関数による推定，`lm` 関数を利用しない推定（数値計算による最適化および行列演算を含む）
   * 応用：二次項・交差項の利用，ダミー変数の利用，結合有意性検定，頑健な標準誤差，加重最小二乗法
* [Discrete Regression Analysis / 離散回帰分析](https://kurodaecon.github.io/dasp/html/discrete_regression.html)
   * 最尤法：ベルヌーイ分布，正規分布，線形回帰モデル
   * 離散回帰モデル：二項プロビット・モデル（数値計算による最適化を含む），二項ロジット・モデル，限界効果
* [Panel Data Analysis and DID / パネルデータ分析とDID](https://kurodaecon.github.io/dasp/html/did.html)
   * パネルデータ分析：個体固定効果（Within 推定，LSDV 推定，First difference 推定），個体・時間固定効果，パネルデータの Long ⇔ Wide の変換
   * DID（差分の差分法）：DID table の作成，回帰モデルの推定による DID 分析，Event study 
* [Instrumental Variables / 操作変数法](https://kurodaecon.github.io/dasp/html/iv.html)
   * IV推定，2SLS（二段階最小二乗法），モンテカルロシミュレーション
* [Regression Discontinuity Design / 回帰不連続デザイン](https://kurodaecon.github.io/dasp/html/rdd.html)
   * RDD 用のパッケージを使用しない推定，`rdrobust` パッケージを用いた推定，McCrary の密度検定
* Reproduction 
   * [Bertrand and Mullainathan (AER 2004)](https://kurodaecon.github.io/dasp/html/bertrand2004.html)
      * 手法：記述統計，母比率の検定，離散回帰（プロビット・モデル）
   * [Miller et al. (AJPS 2016)](https://kurodaecon.github.io/dasp/html/miller2016.html)
      * 手法：記述統計，t 検定，回帰分析（交差項を含む）
   * [Card and Krueger (AER 1994)](https://kurodaecon.github.io/dasp/html/card1994.html)
      * 手法：記述統計，t 検定，DID（差分の差分法），回帰分析

注：講義スライドは Moodle の授業ページからアクセスしてください．履修者以外（学外者を含む）で講義スライドをご覧になりたい方は黒田までお問い合わせください．

## Learning resources for R programming, focusing on statistics and causal inference, developed by others 

* 分寺 [統計的方法論特殊研究（多変量解析）（神戸大学大学院経営学研究科）](https://www2.kobe-u.ac.jp/~bunji/resource.html)
   * 心理尺度を用いたアンケート調査データに対して因子分析および構造方程式モデリングを適用．2024年度は本授業でこのトピックを扱わないため，R での実装に興味がある方はこの資料で勉強してください．R での実装ではなく手法そのものに興味がある方には，小杉『[言葉と数式で理解する多変量解析入門](https://www.kitaohji.com/book/b580216.html)』（北大路書房）がお薦めです．
* Kabacoff (2024) [Modern Data Visualization with R](https://rkabacoff.github.io/datavis/)
* Heiss (2020) [Using R for Introductory Econometrics](https://www.urfie.net/)
* Carilli (2021) [R Companion to Real Econometrics](https://bookdown.org/carillitony/bailey/)
* Bauer (2020) [Applied Causal Analysis (with R)](https://bookdown.org/paul/applied-causal-analysis/)
* Oswald, Viers, Robin, Villedieu, and Kenedi (2020) [Introduction to Econometrics with R](https://scpoecon.github.io/ScPoEconometrics/)
* Nguyen (2020) [A Guide on Data Analysis](https://bookdown.org/mike/data_analysis/)
* 川田恵介 (2022) [Rによる比較・予測・因果推論入門 ver0.2](https://tetokawata.github.io/R_JPN/)
* 宋財泫 (2023) [方法論特殊講義III](https://www.jaysong.net/kobe-ci/)
* 安藤道人，三田匡能 (2024) [Rで学ぶ計量経済学と機械学習](https://michihito-ando.github.io/econome_ml_with_R/)
* 矢内勇生 (2023) [計量経済学応用](https://yukiyanai.github.io/jp/classes/econometrics2/contents/)
* 浅野正彦 (2023) [早稲田大学「計量分析（政治）」補助教材](https://www.asanoucla.com/%E8%A8%88%E9%87%8F%E5%88%86%E6%9E%90-%E8%A3%9C%E5%8A%A9%E6%95%99%E6%9D%90-r/)
