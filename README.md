`7zinfo(1)`
===========
Verbosely list contents of archive formats recognised by [`7z(1)`][].

Work-in-progress.


Comparison with `7z l -slt`
---------------------------
The subcommand to list an archive's contents only supports two output styles:
the default tabular layout (compact and human-readable, but incomplete) and a
“technical mode” enabled with `-slt` (**S**et **l**ist **t**echnical-mode).

This latter lists everything there is to know about an archive's contents but it
omits the aforementioned tabular layout, obstructing quick and casual perusal by
readers. This becomes a problem when you'd like the best of both worlds… say, to
generate a textual representation of an archive for [`git-diff(1)`][] drivers:

~~~console
$ echo Foo > foo.txt
$ echo Bar > bar.txt
$ 7z a archive.7z *.txt
$ 7zinfo archive.7z
~~~

<details><summary>Output</summary>

<pre>7-Zip [64] 17.04 : Copyright (c) 1999-2021 Igor Pavlov : 2017-08-28
p7zip Version 17.04 (locale=utf8,Utf16=on,HugeFiles=on,64 bits,16 CPUs x64)

Scanning the drive for archives:
1 file, 179 bytes (1 KiB)

Listing archive: archive.7z

--
Path = archive.7z
Type = 7z
Physical Size = 179
Headers Size = 167
Method = LZMA2:12
Solid = +
Blocks = 1

   Date      Time    Attr         Size   Compressed  Name
------------------- ----- ------------ ------------  ------------------------
2024-08-15 13:28:35 ....A            4           12  bar.txt
2024-08-15 13:28:33 ....A            4               foo.txt
------------------- ----- ------------ ------------  ------------------------
2024-08-15 13:28:35                  8           12  2 files

----------
Path = bar.txt
Size = 4
Packed Size = 12
Modified = 2024-08-15 13:28:35
Attributes = A_ -rw-r--r--
CRC = A4901CD7
Encrypted = -
Method = LZMA2:12
Block = 0

Path = foo.txt
Size = 4
Packed Size =
Modified = 2024-08-15 13:28:33
Attributes = A_ -rw-r--r--
CRC = DE00CA96
Encrypted = -
Method = LZMA2:12
Block = 0
</pre>

(The tabular version could also do with more columns for normally-hidden fields)
</details>


<!-- Referenced links --------------------------------------------------------->
[`7z(1)`]: https://manned.org/man/7z.1
[`git-diff(1)`]: https://bit.ly/3X2yrdg
