#let page_margin = (top: 14mm, bottom: 14mm, left: 16mm, right: 16mm)

#set page(
  paper: "a4",
  margin: page_margin,
)

#set text(font: "Noto Sans CJK JP", size: 10.5pt)

#image("logo-02.svg", width: 100%)

#let url = "https://2026.foss4g.org/"

// ちょっとだけ見た目を整えるための共通スタイル
#let smallcaps(t) = text(size: 9pt)[#t]
#let h1(t) = text(size: 22pt, weight: "bold")[#t]
#let h2(t) = text(size: 12.5pt)[#t]

#align(center)[
  #h1("Bridging Geospatial Technology and Humanity")
  #v(2mm)
  #h2("FOSS4Gは、OSGeo財団が主催するオープンソース地理空間ソフトウェアに特化した世界最大の国際会議です。2026年、そのFOSS4Gが広島にて日本初開催されます。")
]

#v(8mm)

#grid(
  columns: (1fr, auto),
  column-gutter: 10mm,
  align: (left, top),
  [
    #text(weight: "bold", size: 12pt)[
      = ハンズオンデイ
      2026年8月30日 〜 2026年8月31日 RCC文化センター
    ]
    #v(2mm)
    #text(weight: "bold", size: 12pt)[
      = コアデイ
      2026年9月1日 〜 2026年9月3日 広島国際会議場
    ]
    #v(2mm)
    #text(weight: "bold", size: 12pt)[
      = コミュニティスプリント
      2026年9月4日 〜 2026年9月5日 広島で予定
    ]
    #text(size: 12pt)[
      = 参加費
      参加費は申し込みタイミングで変動します。お早めに！
    ]
    #v(2mm)
    - Super Early Bird: ¥40,000 (100枚限定) (〜2026年3月7日)
    - Early Bird: ¥50,000 (〜2026年4月21日)
    - Regular: ¥80,000 (〜当日)
    - 学生: ¥30,000
    - 国内: ¥40,000 (学生以外の国内在住者向け)
    - 各ハンズオン: ¥7,500
    - 詳細はWebサイトをチェック！

    #v(2mm)
    #text(weight: "bold", size: 12pt)[
      = 詳細・参加登録は以下の公式サイトから

      #url
    ]
  ],
  [
    // QRブロック
    #box(
      inset: 6pt,
      radius: 8pt,
      stroke: 0.8pt,
      [
        #image("qr.png", width: 50mm, height: 50mm, fit: "stretch"),
        #align(center)[#smallcaps("Webページはこちら")]
      ],
    )
  ],
)

// フッター（任意）
#v(6mm)
#align(center)[
  #smallcaps("主催：FOSS4G Hiroshima 2026 LOC / OSGeo.JP / OSGeo財団 / お問い合わせ：info@foss4g.org")
]
