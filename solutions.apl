#!/usr/bin/env dyalogscript
⎕IO ← 0

I←⌷⍨∘⊃⍨⍤0 99 ⍝ "sane" indexing
⎕PP←17 ⍝ print integers with up to 17 significant digits without use of scientific notation

⍝ day 1
⎕←'Day 1:'
input←⊃⎕NGET'inputs/day1.txt'1
n←'zero' 'one' 'two' 'three' 'four' 'five' 'six' 'seven' 'eight' 'nine'
⎕←+/⍎⍤1⊢↑((⊣/),(⊢/))¨input∩¨⊂⎕D ⍝ part 1
⎕←+/((10×⊣/)+(⊢/))¨0~⍨¨{(⍳⍴n)+.×(↑n∘.⍷⊂⍵)+↑⎕D∘.⍷⊂⍵}¨input ⍝ part 2

⍝ day 2
⎕←'Day 2:'
input←⊃⎕NGET'inputs/day2.txt'1
parse_num←⍎¨'(\d+)'⎕S'\1'
to_rgb←('(\d+) red' '(\d+) green' '(\d+) blue'⎕S{(parse_num ⍵.Match) × (⍵.PatternNum⊃(1 0 0)(0 1 0) (0 0 1))})
possible_game←{∧/(12 13 14)≥⊃(⌈/⍵)}¨to_rgb ¨input
⎕←possible_game +.× 1+ ⍳⍴input ⍝ part1
⎕←+/{×/⍵}¨(⊃⌈/)¨to_rgb ¨input ⍝ part 2

⍝ day 3
⎕←'Day 3:'
input←⊃⎕NGET'inputs/day3.txt'1
numbers←'\d+'⎕S{(⊃⍵.BlockNum) (⊃⍵.Offsets) (⊃⍵.Lengths) (⍎⍵.Match)}input
symbols←'[^.0-9]'⎕S{(⊃⍵.BlockNum) (⊃⍵.Offsets)}input
gears←'\*'⎕S{(⊃⍵.BlockNum) (⊃⍵.Offsets)}input
is_adjacent←{(∨/1≥|⍺[1] - ⍵[1] + ⍳⍵[2])∧(1≥|⍺[0]-⍵[0])}

⎕←+/3⌷¨(∨/⍉symbols ∘.is_adjacent numbers)/numbers ⍝ part 1
⎕←+/(2=+/gears ∘.is_adjacent numbers) /  (gears∘.is_adjacent numbers)×.{1⌈⍺×⍵[3]} numbers ⍝ part 2

⍝ day 4
⎕←'Day 4:'
input←⊃⎕nget'inputs/day4.txt'1
num_matches←'Card [ \d]+: ([ 0-9]+) \| ([ 0-9]+)'⎕S{≢↑∩/0~⍨¨{,⎕CSV⍠'Separator' ' '⊢⍵'S'3}¨⍵.(1↓Lengths↑¨Offsets↓¨⊂Block)} input
⎕←+/2*1-⍨0~⍨num_matches ⍝ part 1
⎕←+/{⍺←0 ⋄ ⍺=≢⍵:⍵ ⋄ (⍺+1)∇⍵ + (≢⍵)↑∊((⍺+1)⍴0)(num_matches[⍺]⍴⍵[⍺])((≢⍵)⍴0)}(≢num_matches)⍴1 ⍝ part 2

⍝ day 5
⎕←'Day 5:'
input←⊃⎕NGET'inputs/day5.txt'1
p←input⊆⍨,↑×⍴¨input
seeds←⍎1⊃s⊆⍨~':'⍷s←⊃⊃p
maps←({(-/)2↑[1]⍵},{1↓[1]⍵})¨{↑⍎¨1↓⍵}¨1↓p
apply_single_mapping←⊣+(⍴⊣)⍴({⍺∘.≥1⌷[1]⍵}∧{⍺∘.<+/1↓[1]⍵})(+.×){1↑[1]⍵}
apply_all_mappings ← {⊃apply_single_mapping⍨/(⊖⍵),⊂⍺}
⎕←⌊/seeds apply_all_mappings maps ⍝ part 1
batch_size←10000 ⋄ ⎕←⌊/({⍺←⌊/⍬ ⋄ ⍵[1]=0:⍺ ⋄ (⍺⌊⌊/(⍵[0] + ⍳batch_size⌊⍵[1]) apply_all_mappings maps) ∇ (⍵[0] + batch_size⌊⍵[1]) (⍵[1] - batch_size⌊⍵[1])}⍤1) ((2,2÷⍨≢)⍴⊢)seeds ⍝ part 2 - takes about 6 minutes on my machine, but good enough for now :D

⍝ day 6
⎕←'Day 6:'
input←⊃⎕NGET'inputs/day6.txt'1
solve←((((⊢×≢-⊢)⍳)¨⊣) (×.((+/,)>)) ⊢)/
⎕←solve {⍎⊃1↓⍵⊆⍨~':'⍷⍵}¨input
⎕←solve (⍎{⍵∊⎕D}(/∘⊢)⊢)¨input

⍝ day 7
⎕←'Day 7:'
p←{⎕CSV⍠'Separator' ' '⊢⍵⍬(1 2)}'inputs/day7.txt'
solve←{+/({1+⍳≢⍵}×⊢) ∊1↓[1](⍋I⊢)(((,type⊃) ⍤1⊢){⍺ (1↓[1]((⍒{(≢card_values)⊥card_values∘⍳⊃⍵}⍤1) I ⊢)⍵)}⌸⊢)⍵}
⍝ part 1
card_values←'AKQJT98765432'
type←{⍸(1 1 1 1 1)(2 1 1 1)(2 2 1)(3 1 1)(3 2)(4 1)(5,⍬)⍷⍨,/{⍴¨⍵[⍒⍴¨⍵]}{s⊆⍨1,1++\~2 =/ s←⍵[⍋card_values⍳⍵]}⍵}
⎕←solve p
⍝ part 2
card_values←'AKQT98765432J'
type←{⍵≡'JJJJJ': 6 ⋄ ⍸(1 1 1 1 1)(2 1 1 1)(2 2 1)(3 1 1)(3 2)(4 1)(5,⍬)⍷⍨{⊂(5-+/⍵)(+@0)⍵}⊃,/{⍴¨⍵[⍒⍴¨⍵]}{s⊆⍨1,1++\~2 =/ s←'J'~⍨⍵[⍋card_values⍳⍵]}⍵}
⎕←solve p

⍝ day 8
⎕←'Day 8:'
input←⊃⎕NGET'inputs/day8.txt'1
instructions←⊃input
p←↑{0 2 4 I{6⍴⎕CSV⍠'Widths'(3 4 3 2 3 1)⊢⍵'S'1}⍵}¨ 2↓input
nodes←,1↑[1]p
L←(⍳⍴nodes) ∘.{nodes[⍺]≡⍵ 1 ⌷p} ⍳⍴nodes
R←(⍳⍴nodes) ∘.{nodes[⍺]≡⍵ 2 ⌷p} ⍳⍴nodes
S←(⊃(+.×)/{'R'≡⍵:R ⋄ ⍵≡'L':L}¨⌽instructions)
⎕←(≢instructions) × {⍺←0 ⋄ ⍵[⍸'ZZZ'∘≡¨nodes]: ⍺ ⋄ ⍺+1 ∇ S+.×⍵}'AAA'∘≡¨nodes                             ⍝ part 1
⎕←∧/(≢instructions) × {⍺←0 ⋄ 0≡+/⍵[⍸~('Z'∘=⊢/)¨nodes]: ⍺ ⋄ ⍺+1 ∇ S+.×⍵}¨{(⍳≢nodes)=⍵}¨⍸('A'∘=⊢/)¨nodes  ⍝ part 2

⍝ day 9
⎕←'Day 9:'
input←⊃⎕NGET'inputs/day9.txt'1
p←{⍎('¯'@((⍸'-'∘=)⍵))⍵}¨input
f←({⍵⍪⊂2-⍨/⊃¯1↑⍵}⍣{∧/0=⊃¯1↑⍺})
⎕←+/{+/⊢/¨f⊂⍵}¨p ⍝ part 1
⎕←+/{-/⊣/¨f⊂⍵}¨p ⍝ part 2

⍝ day 10
⎕←'Day 10:'
input←↑⊃⎕NGET'inputs/day10.txt'1
d←↑('F' ((0 1)(1 0)))('-' ((0 ¯1)(0 1)))('|' ((¯1 0)(1 0)))('L' ((¯1 0)(0 1)))('J'((0 ¯1)(¯1 0)))('7'((0 ¯1)(1 0)))('.' ((0 0)(0 0)))(' ' ((0 0)(0 0)))
f←{⊃(¯1↑[1]d)I⍨⊃⊃⍸(1↑[1]d)⍷⍨⍵}
S←(⍸,{∧/((¯1∘×¨{m[⍸(1 1)∘≡¨(2 2 2 2/⍵)+m←,↑f¨⍵I ⊃((⍸'S'∘≡¨) I ({⊂⍵}⌺3 3)) input]}(0 1)(1 0)(1 2)(2 1)))∊⍵}¨¯1↑[1]d) 0 ⌷ d
p←(S@(⍸'S'∘≡¨input))input
c←({⍵,⊂i+⊃(-/¯2↑⍵)~⍨f{⍵⌷p}i←⊃¯1↑⍵}⍣{(⊃⊣/⍺)≡⊃⊢/⍺})⍸'S'∘≡¨input
⎕←⌊2÷⍨≢c
p2←('.'@((,(⍳⊣/⍴input) ∘.{⍺ ⍵} (⍳⊢/⍴input))~c))p
⎕←+/{2|+/'|'=⊃{(((⊃⍵)≡'7')∨((⊃⍵)≡'J'))∧⍺≡'-': ⍵ ⋄ ((⊃⍵)≡'7')∧⍺≡'L': '|'⍪1↓⍵ ⋄ ((⊃⍵)≡'J')∧⍺≡'F': '|'⍪1↓⍵ ⋄ ⍺⍪⍵}/(⊢/⍵)↓(⊣/⍵) I p2}¨⍸'.'=p2

⍝ day 11
⎕←'Day 11:'
input←↑⊃⎕NGET'inputs/day11.txt'1
empty_rows←empty_rows←⍸∧/'.'=input
empty_columns←⍸∧⌿'.'=input
stretch_factor←1000000
dist←{r←((⊃⍺)(⊃⍵))⋄c←((1⊃⍺)(1⊃⍵)) ⋄ dr←r[⍒r] ⋄ dc←c[⍒c] ⋄((-/dc) + (stretch_factor-1)×+/{(dc[0]>⍵)∧⍵>dc[1]}¨empty_columns) + ((-/dr) + (stretch_factor-1)×+/{(dr[0]>⍵)∧⍵>dr[1]}¨empty_rows)}
f←({⍺←0 ⋄ 1=≢⍵: ⍺ ⋄ (⍺+ +/⊃+/(((⊃⍵)∘dist))¨1↓⍵) ∇ 1↓⍵}{⍸'#'= ⍵})

stretch_factor←2
⎕←f input

stretch_factor←1000000
⎕←f input ⍝ part 1
