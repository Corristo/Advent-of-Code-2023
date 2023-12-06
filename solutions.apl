#!/usr/bin/env dyalogscript
⎕IO ← 0

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
