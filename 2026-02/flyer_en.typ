// FOSS4G Hiroshima 2026 Flyer (English)

#let image_path = "../assets/img9228.jpg"
#let logo_path  = "../assets/logo-02.svg"
#let img_height = 183mm  // 8:5 ratio (8/13 of A4 height)
#let content = toml("../content_en.toml")

#set page(paper: "a4", margin: 0pt)
#set text(font: ("Helvetica Neue", "Arial", "Helvetica"), lang: "en")

// ─────────────────────────────────────────────────────────────
// Top: Full-width image + title overlay (~70% of A4)
// ─────────────────────────────────────────────────────────────

// Background image (no margin, full width)
#place(
  top + left,
  image(image_path, width: 100%, height: img_height, fit: "cover"),
)

// Gradient overlay for text readability (transparent top → dark bottom)
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

// Title (positioned in the lower portion of the image)
#place(
  top + center,
  dy: 25mm,
  block(width: 100%)[
    #align(center)[
      #box[
        // Shadow (black text)
        #place(dx: 2pt, dy: 2pt)[
          #text(fill: rgb(0, 0, 0, 30%), size: 40pt, weight: "bold",
            tracking: 0.5pt)[FOSS4G Hiroshima 2026]
        ]
        // Main text (white)
        #text(fill: white, size: 40pt, weight: "bold",
          tracking: 0.5pt)[FOSS4G Hiroshima 2026]
      ]
      #v(4pt)
    ]
  ],
)

// Skip past the image in the document flow
#v(img_height)

// ─────────────────────────────────────────────────────────────
// Bottom: Event details (~30% of A4)
// ─────────────────────────────────────────────────────────────

#block(
  width: 100%,
  inset: (x: 24pt, top: 18pt, bottom: 42pt),
)[
  // Two-column layout: Schedule | Registration
  #let column_height = 110pt
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 20pt,
    align: (top, top),

    // ── Left column: Schedule ──
    block(height: column_height)[
      #text(size: 12pt, weight: "bold")[Schedule]
      #set text(size: 10pt)
      #grid(
        columns: (auto, 1fr),
        column-gutter: 8pt,
        row-gutter: 16pt,

        [*#content.workshop.at(0).name*],
        [#content.workshop.at(0).date_start – #content.workshop.at(0).date_end \ #text(size: 8.5pt)[#content.workshop.at(0).venue]],

        [*#content.conference.at(0).name*],
        [#content.conference.at(0).date_start – #content.conference.at(0).date_end \ #text(size: 8.5pt)[#content.conference.at(0).venue]],

        [*#content.communitysprint.at(0).name*],
        [#content.communitysprint.at(0).date_start – #content.communitysprint.at(0).date_end]
      )
    ],

    // ── Right column: Registration ──
    block(height: column_height)[
      #text(size: 12pt, weight: "bold")[Registration ]#text(size: 9pt, weight: "bold")[(Excluding Tax)]
      #set text(size: 10pt)
      #grid(
        columns: (1fr, auto),
        column-gutter: 8pt,
        row-gutter: 8pt,
        align: (left, right),

        ..content.registration.tickets.map(ticket => {
          let details = if "note" in ticket and "deadline" in ticket {
            text(size: 8pt, fill: luma(50%))[#ticket.note — #ticket.deadline]
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
      #text(size: 8pt, fill: luma(50%))[Japanese VAT 10% will be added at checkout]
    ],
  )

  #v(16pt)
  #line(length: 100%, stroke: 0.8pt + luma(180))
  #v(4pt)

  // Footer: organizer, website, contact
  #align(center)[
    #set text(size: 10pt)
    #text(weight: "bold", size: 10pt)[#content.footer.organizer]
    #v(-2pt)
    #text(size: 8pt)[#link(content.url)[#content.url]]
    #text(size: 8pt)[Contact: #link("mailto:" + content.footer.contact)[#content.footer.contact]]
  ]
]

// Logo (absolute placement, bottom-right)
#place(
  bottom + right,
  dx: -24pt,
  dy: -16pt,
  image(logo_path, height: 30mm),
)

// QR code (absolute placement, bottom-left)
#place(
  bottom + left,
  dx: 14pt,
  dy: -10pt,
  grid(
    columns: (auto, auto),
    column-gutter: 8pt,
    align: (center, horizon),
    image("../assets/foss4g-2026-en.svg", height: 35mm),
    text(size: 9pt)[#content.footer.qr_caption]
  )
)
