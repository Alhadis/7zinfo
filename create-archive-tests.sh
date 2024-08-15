#!/usr/bin/env bash
# shellcheck shell=bash
set -xe

cd /tmp
mkdir archive-diff-tests && cd "$_"
git init

foo='foo file.txt'
bar='bar file.txt'
echo Foo > "$foo"
echo Bar > "$bar"
git add ./*.txt
git commit -m 'Initialise repository'
first=`git latest-hash`

echo foo > "$foo"
echo bar > "$bar"
git add ./*.txt
git commit -m 'Modify text files'

# Compressed files
for i in gzip:gz bzip2:bz2:bzipped lzma:lzma:LZMA-encoded; do
	set -- ${i//:/ }
	ext=${2:-"$1"}
	dst=${3:-"$1"ped}
	msg="Add $dst file"
	dst=${dst,,}\ file."$ext"
	
	# Create file
	"$1" -k "$foo"
	test -s "$_.$ext"
	mv -v "$_" "$dst"
	git add "$dst"
	git commit -m "$msg"
	
	# Modify file
	git show "${first}:${foo}" > "$foo"
	rm -vf "$dst"
	test ! -e "$dst"
	"$1" -k "$foo"
	test -s "$_.$ext"
	mv -v "$_" "$dst"
	git add "$dst"
	git checkout -- "$foo"
	git commit -m "${msg/Add /Modify }"
done

# Archives
dst="7z archive.7z"
7z a "$dst" "$foo" "$bar"
test -s "$dst"
git add "$_"
git commit -m 'Add 7z(1) archive'

git show "${first}:${foo}" > "$foo"
git show "${first}:${bar}" > "$bar"
rm -vf "$dst"
test ! -e "$dst"
7z a "$dst" "$foo" "$bar"
test -s "$dst"
git add "$_"
git commit -m 'Modify 7z(1) archive'
