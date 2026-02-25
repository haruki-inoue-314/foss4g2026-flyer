// FOSS4G Hiroshima 2026 チラシ（日本語版）

#let image_path = "../assets/img9228.jpg"
#let logo_path  = "../assets/logo-02.svg"
#let img_height = 183mm  // 8:5 ratio (8/13 of A4 height)
#let content = toml("../content_ja.toml")

#set page(paper: "a4", margin: 0pt)
#set text(
  font: ("Hiragino Sans", "Hiragino Kaku Gothic Pro", "Hiragino Kaku Gothic ProN"),
  lang: "ja",
)

// ─────────────────────────────────────────────────────────────
// 上部：フル幅画像 ＋ タイトルオーバーレイ（A4の約70%）
// ─────────────────────────────────────────────────────────────

// 背景画像（縁なし・フル幅）
#place(
  top + left,
  image(image_path, width: 100%, height: img_height, fit: "cover"),
)

// テキスト可読性のためのグラデーションオーバーレイ（上部：透明 → 下部：暗）
#place(
  top + left,
  rect(
    width: 100%,
    height: img_height,
    fill: gradient.linear(
      (rgb(0, 0, 0, 0%), 0%),
      (rgb(0, 0, 0, 0%), 25%),
      (rgb(0, 0, 0, 62%), 100%),
      angle: 90deg,
    ),
  ),
)

// タイトル（画像の下寄りに配置）
#place(
  top + center,
  dy: 25mm,
  block(width: 100%)[
    #align(center)[
      #box[
        // 影（黒いテキスト）
        #place(dx: 2pt, dy: 2pt)[
          #text(fill: rgb(0, 0, 0, 30%), size: 40pt, weight: "bold",
            tracking: 0.5pt, font: "Helvetica Neue")[FOSS4G Hiroshima 2026]
        ]
        // メインテキスト（白）
        #text(fill: white, size: 40pt, weight: "bold",
          tracking: 0.5pt, font: "Helvetica Neue")[FOSS4G Hiroshima 2026]
      ]
      #v(4pt)
    ]
  ],
)

// 画像エリアをフロー上でスキップ
#v(img_height)

// ─────────────────────────────────────────────────────────────
// 下部：イベント詳細（A4の約30%）
// ─────────────────────────────────────────────────────────────

#block(
  width: 100%,
  inset: (x: 24pt, top: 18pt, bottom: 42pt),
)[
  // スケジュールと参加費の2段組
  #let column_height = 96pt
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 20pt,
    align: (top, top),

    // ── 左列：スケジュール ──
    block(height: column_height)[
      #text(size: 12pt, weight: "bold")[スケジュール]
      #set text(size: 10pt)
      #grid(
        columns: (auto, 1fr),
        column-gutter: 8pt,
        row-gutter: 16pt,

        [*#content.workshop.at(0).name*],
        [#content.workshop.at(0).date_start 〜 #content.workshop.at(0).date_end \ #text(size: 8.5pt)[#content.workshop.at(0).venue]],

        [*#content.conference.at(0).name*],
        [#content.conference.at(0).date_start 〜 #content.conference.at(0).date_end \ #text(size: 8.5pt)[#content.conference.at(0).venue]],

        [*#content.communitysprint.at(0).name*],
        [#content.communitysprint.at(0).date_start 〜 #content.communitysprint.at(0).date_end]
      )
    ],

    // ── 右列：参加費 ──
    block(height: column_height)[
      #text(size: 12pt, weight: "bold")[参加費]#text(size: 9pt, weight: "bold")[(税抜)]
      #set text(size: 10pt)
      #v(-4pt)
      #grid(
        columns: (1fr, auto),
        column-gutter: 8pt,
        row-gutter: 8pt,
        align: (left, right),

        ..content.registration.tickets.map(ticket => {
          let details = if "note" in ticket and "deadline" in ticket {
            text(size: 8pt, fill: luma(50%))[#ticket.note #ticket.deadline]
          } else if "deadline" in ticket {
            text(size: 8pt, fill: luma(50%))[#ticket.deadline]
          } else if "note" in ticket {
            text(size: 8pt, fill: luma(50%))[#ticket.note]
          } else {
            []
          }

          (
            [#ticket.name #if details != [] {[#details]}],
            [*#ticket.price*]
          )
        }).flatten()
      )
    ],
  )

  #v(14pt)
  #line(length: 100%, stroke: 0.8pt + luma(180))
  #v(10pt)

  // フッター：主催・URL・連絡先
  #align(center)[
    #set text(size: 10pt)
    #text(weight: "bold", size: 11pt)[#content.footer.organizer]
    #v(0pt)
    #text(size: 10.5pt)[#link(content.url)[#content.url]]
    #h(16pt)
    #text(size: 10.5pt)[問い合わせ：#link("mailto:" + content.footer.contact)[#content.footer.contact]]
  ]
]

// ロゴ（右下に絶対配置）
#place(
  bottom + right,
  dx: -24pt,
  dy: -16pt,
  image(logo_path, height: 30mm),
)

// QRコード（左下に絶対配置）
#place(
  bottom + left,
  dx: 14pt,
  dy: -10pt,
  grid(
    columns: (auto, auto),
    column-gutter: 8pt,
    align: (center, horizon),
    image("../assets/foss4g-2026-ja.svg", height: 35mm),
    text(size: 9pt)[#content.footer.qr_caption]
  )
)
