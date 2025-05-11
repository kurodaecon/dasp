# Data Analysis Using Statistical Packages 

Graduate School of Commerce and Graduate School of Accountancy, Waseda University 

「統計ソフトによるデータ解析」（早稲田大学商学研究科・会計研究科）

## Main materials 

* [Basic Operation of R / Rの基本的な操作](https://kurodaecon.github.io/dasp/html/basic.html) / [Stata do file](https://github.com/kurodaecon/dasp/blob/main/do/basic.do)
   * 演算，オブジェクト，ベクトル，データフレーム，描画，CSVファイルからのデータ読み込み，関数，繰り返し処理，行列
* [Descriptive Statistics / 記述統計](https://kurodaecon.github.io/dasp/html/descriptive_stat.html) / [Stata do file](https://github.com/kurodaecon/dasp/blob/main/do/descriptive_stat.do)
   * 質的データ：度数分布表，棒グラフ，円グラフ，分割表
   * 量的データ：ヒストグラム，平均，分位点・中央値，分散・標準偏差，散布図，共分散・相関係数
* [Organizing and Visualizing Data / データのハンドリングと可視化](https://kurodaecon.github.io/dasp/html/organizing_data.html) / [Stata do file](https://github.com/kurodaecon/dasp/blob/main/do/organizing_data.do)
   * `dplyr` パッケージを用いたデータのハンドリング：`filter`, `mutate`, `group_by`, etc.
   * `ggplot2` パッケージを用いたデータの可視化：散布図，ヒストグラム，棒グラフ，箱ひげ図
* [Inferential Statistics / 推測統計学](https://kurodaecon.github.io/dasp/html/inferential_stat.html) / [Stata do file](https://github.com/kurodaecon/dasp/blob/main/do/inferential_stat.do)
   * 確率：確率変数の期待値と分散，乱数の生成，中心極限定理
   * 信頼区間（母平均，母比率），統計的仮説検定（母平均，多重検定の問題に関するシミュレーション）
* [Regression Analysis / 回帰分析](https://kurodaecon.github.io/dasp/html/regression.html) / [Stata do file](https://github.com/kurodaecon/dasp/blob/main/do/regression.do)
   * 基礎：最小二乗法 … `lm` 関数による推定，`lm` 関数を利用しない推定（数値計算による最適化を含む）
   * 応用：二次項・交差項の利用，ダミー変数の利用
* [Regression Analysis in Econometrics / 回帰分析（計量経済学）](https://kurodaecon.github.io/dasp/html/regression_econom.html)
   * 計量経済学の論点にウェイトを置いた回帰分析 （結合有意性検定，頑健な標準誤差，加重最小二乗法，etc.）
* [Discrete Regression Analysis / 離散回帰分析](https://kurodaecon.github.io/dasp/html/discrete_regression.html)
   * 最尤法：ベルヌーイ分布，正規分布，線形回帰モデル
   * 離散回帰モデル：二項プロビット・モデル（数値計算による最適化を含む），二項ロジット・モデル，限界効果
* [Time Series Analysis / 時系列分析](https://kurodaecon.github.io/dasp/html/time_series.html)
   * 自己相関，定常性の検定，自己回帰モデル（最小二乗法および最尤法による推定），移動平均モデル（最尤法による推定）
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

<!--
注：講義スライドは Moodle の授業ページからアクセスしてください．履修者以外（学外者を含む）で講義スライドをご覧になりたい方は黒田までお問い合わせください．
-->

## Learning resources for R programming, focusing on statistics and causal inference, developed by others 

因果推論に関する内容あり

* Cunningham (2021) [Causal Inference: The Mixtape](https://mixtape.scunning.com/)
* Heiss (2020) [Using R for Introductory Econometrics](https://www.urfie.net/) ... Wooldridge’s “Introductory Econometrics” に対応
* Fernandez (2024) [Econometrics for Business Analytics](https://bookdown.org/cuborican/RE_STAT/) ... 因果推論・多項選択・需要推定・制限従属変数モデル・生存分析・時系列まで幅広くカバー
* Carilli (2021) [R Companion to Real Econometrics](https://bookdown.org/carillitony/bailey/) ... 二項選択・時系列もカバー
* Bauer (2020) [Applied Causal Analysis (with R)](https://bookdown.org/paul/applied-causal-analysis/)
* Oswald, Viers, Robin, Villedieu, and Kenedi (2020) [Introduction to Econometrics with R](https://scpoecon.github.io/ScPoEconometrics/)
* Nguyen (2020) [A Guide on Data Analysis](https://bookdown.org/mike/data_analysis/)
* Hanck, Arnold, Gerber, and Schmelzer (2024) [Introduction to Econometrics with R](https://www.econometrics-with-r.org/)  ... 時系列もカバー
* Chabé-Ferret (2024) [Statistical Tools for Causal Inference](https://chabefer.github.io/STCI/) ... 2024年8月時点で中身が空のセクションがある
* Gow and Ding (2024) [Empirical Research in Accounting: Tools and Methods](http://iangow.me/far_2021/)
* Gerstenberg (2024) [Psych 252: Statistical Methods for Behavioral and Social Sciences](https://psych252.github.io/psych252book/)
* 川田 (2022) [Rによる比較・予測・因果推論入門 ver0.2](https://tetokawata.github.io/R_JPN/)
* 宋 (2023) [方法論特殊講義III](https://www.jaysong.net/kobe-ci/)
* 安藤・三田 (2024) [Rで学ぶ計量経済学と機械学習](https://michihito-ando.github.io/econome_ml_with_R/)
* 矢内 (2020s) [計量経済学](https://yukiyanai.github.io/econometrics/) and [計量経済学応用](https://yukiyanai.github.io/jp/classes/econometrics2/contents/)
* 浅野 (2023) [早稲田大学「計量分析（政治）」補助教材](https://www.asanoucla.com/%E8%A8%88%E9%87%8F%E5%88%86%E6%9E%90-%E8%A3%9C%E5%8A%A9%E6%95%99%E6%9D%90-r/)

それ以外

* Dalpiaz [Applied Statistics with R](https://book.stat420.org/) ... 確率からロジット回帰までカバー
* Thulin (2021) [Modern Statistics with R](https://modernstatisticswithr.com/) ... 生存分析・構造方程式モデリング・機械学習までカバー
* Kabacoff (2024) [Modern Data Visualization with R](https://rkabacoff.github.io/datavis/) ... ggplot2 を用いた可視化
* Buteikis (2024) Practical Econometrics & Data Science, [Book 0: Prerequisites](https://web.vu.lt/mif/a.buteikis/wp-content/uploads/PE_B0/) and [Book I: Cross-sectional data](https://web.vu.lt/mif/a.buteikis/wp-content/uploads/PE_B1/)
* McNulty (2024) [Handbook of Regression Modeling in People Analytics: With Examples in R, Python and Julia](https://peopleanalytics-regression-book.org/) ... 多項選択・生存分析までカバー
* McNulty (2024) [Handbook of Graphs and Networks in People Analytics: With Examples in R and Python](https://ona-book.org/)
* Brughmans and Peeples (2023) [Network Science in Archaeology](https://book.archnetworks.net/) ... 考古学関係なくネットワーク分析の入門用教材として有用
* Dauber (2024) [R for Non-Programmers: A Guide for Social Scientists](https://bookdown.org/daniel_dauber_io/r4np_book/)
* McDermott (2021) [Data science for economists](https://github.com/uo-ec607/lectures) (graduate course at the University of Oregon) ... Git, Data wrangling & tidying, Webscraping, Parallel programming, Docker, etc. 
* 分寺 [統計的方法論特殊研究（多変量解析）（神戸大学大学院経営学研究科）](https://www2.kobe-u.ac.jp/~bunji/resource.html)
   * 心理尺度を用いたアンケート調査データに対して因子分析および構造方程式モデリングを適用．2024・25年度は本授業でこのトピックを扱わないため，R での実装に興味がある方はこの資料で勉強してください．R での実装ではなく手法そのものに興味がある方には，小杉『[言葉と数式で理解する多変量解析入門](https://www.kitaohji.com/book/b580216.html)』（北大路書房）がお薦めです．
* 麦山 (2024) [Rによる社会調査データ分析の手引き](https://ryotamugiyama.github.io/seminar_sociology_r/)
* 田頭 (2024) [マーケティングリサーチ講義ノート：Rを使ったリサーチ基礎固め](https://tak-tag.github.io/MktRes_Lecture/) ... 因子分析・価格感度分析までカバー
* 土井 (2024) [R/Pythonで計量政治学入門](https://shohei-doi.github.io/quant_polisci/)
* 津田 (2020) [Rによる統計入門](https://htsuda.net/stats/) ... 回帰分析と因子分析がメイン
* 森 (2021) [卒業論文のためのR入門](https://tomoecon.github.io/R_for_graduate_thesis/)
* 宋・矢内 (2024) [私たちのR―ベストプラクティスの探求](https://www.jaysong.net/RBook/)
* 岩田 [Rによる地理空間データの可視化](https://shinichiro-iwata.github.io/geospatial-data-visualization/)

## Python 

* Py4DS Community (Turrell et al.) (2022) [Python for Data Science](https://aeturrell.github.io/python4DS/welcome.html)
* Turrell (2022) [Coding for Economists](https://aeturrell.github.io/coding-for-economists/intro.html)
* 東京大学 (2023) [Pythonプログラミング入門](https://utokyo-ipp.github.io/)
* 三谷 (2021) [Python ゼロからはじめるプログラミング](https://mitani.cs.tsukuba.ac.jp/book_support/python/) （翔泳社から出版された書籍の副教材）
* 友原（2024）『[文系のためのPythonデータ分析](https://www.yuhikaku.co.jp/books/detail/9784641166363)』有斐閣．
* 春山 (2020) [Pythonで学ぶ入門計量経済学](https://py4etrics.github.io/)

## Julia 

* 裏 RjpWiki (2022) [Julia で統計解析](https://blog.goo.ne.jp/r-de-r/e/c7bbfac7ef96e99d98d903d8b3b959bf)
