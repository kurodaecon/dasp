# Data Analysis Using Statistical Packages

Graduate School of Commerce and Graduate School of Accountancy, Waseda University

「統計ソフトによるデータ解析」（早稲田大学商学研究科・会計研究科）

## Main materials

* [Basic Operation of R / Rの基本的な操作](https://kurodaecon.github.io/dasp/basic.html)
   * 演算，オブジェクト，ベクトル，データフレーム，描画，CSVファイルからのデータ読み込み，関数，繰り返し処理，行列
* [Descriptive statistics / 記述統計](https://kurodaecon.github.io/dasp/descriptive_stat.html)
   * 質的データ：度数分布表，棒グラフ，円グラフ，分割表
   * 量的データ：ヒストグラム，平均，分位点・中央値，分散・標準偏差，散布図，共分散・相関係数
* [Organizing and Visualizing Data / データのハンドリングと可視化](https://kurodaecon.github.io/dasp/organizing_data.html)
   * `tydyverse` パッケージを用いたデータのハンドリング：`filter`, `mutate`, `group_by`, etc.
   * `ggplot2` パッケージを用いたデータの可視化：散布図，ヒストグラム，棒グラフ，箱ひげ図
* [Regression Analysis / 回帰分析](https://kurodaecon.github.io/dasp/regression.html)
   * 基礎：最小二乗法 … `lm` 関数による推定，`lm` 関数を利用しない推定（数値計算による最適化および行列演算を含む）
   * 応用：二次項・交差項の利用，ダミー変数の利用，結合有意性検定，頑健な標準誤差，加重最小二乗法
* Replication
   * [Bertrand and Mullainathan (AER 2004)](https://kurodaecon.github.io/dasp/bertrand2004.html)
      * 手法：記述統計，母比率の検定，プロビット回帰（演習では扱わない）
   * [Miller et al. (AJPS 2016)](https://kurodaecon.github.io/dasp/bertrand2004.html)
      * 手法：記述統計，t 検定，回帰分析（交差項を含む）

注：講義スライドは Moodle の授業ページからアクセスしてください．履修者以外（学外者を含む）で講義スライドをご覧になりたい方は黒田までお問い合わせください．
