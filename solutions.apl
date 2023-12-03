#!/usr/bin/env dyalogscript
⎕IO ← 0

⍝ day 1
⎕←'Day 1:'
input←⊃⎕NGET'inputs/day1.txt'1
⎕←+/⍎⍤1⊢↑((⊣/),(⊢/))¨input∩¨⊂⎕D ⍝ part 1
⎕←+/((10×⊣/)+(⊢/))¨0~⍨¨((('one'∘⍷¨input)+('1'∘⍷¨input))+(2×(('two'∘⍷¨input)+('2'∘⍷¨input)))+(3×(('three'∘⍷¨input)+('3'∘⍷¨input)))+(4×(('four'∘⍷¨input)+('4'∘⍷¨input)))+(5×(('five'∘⍷¨input)+('5'∘⍷¨input)))+(6×(('six'∘⍷¨input)+('6'∘⍷¨input)))+(7×(('seven'∘⍷¨input)+('7'∘⍷¨input)))+(8×(('eight'∘⍷¨input)+('8'∘⍷¨input)))+(9×(('nine'∘⍷¨input)+('9'∘⍷¨input)))) ⍝ part 2

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
