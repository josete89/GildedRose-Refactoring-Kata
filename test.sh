#!/bin/bash
swift build
./.build/x86_64-apple-macosx10.10/debug/GildedRose 30 > output
diff -u output ../GildedRose-Refactoring-Kata/texttests/ThirtyDays/stdout.gr
