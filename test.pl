#!/usr/bin/env perl
use strict;
use warnings;
use autodie;
use v5.14;
use utf8;
$| = 1;

use warnings  qw< FATAL utf8 >;
use open      qw< :std :utf8 >;
use charnames qw< :full >;
use feature   qw< say unicode_strings >;
use Carp      qw< confess >;

use File::Basename qw< basename >;
use File::Spec::Functions;
use Data::Dumper;
use Getopt::Long;

END { close STDOUT }
local $SIG{__DIE__} = sub {
	confess "Uncaught exception: @_" unless $^S;
};


my $VAR1 = {
	'archive' => {
		'Solid' => '+',
		'Path' => '7z archive.7z',
		'Blocks' => '1',
		'Type' => '7z',
		'Physical Size' => '183',
		'Headers Size' => '171',
		'Method' => 'LZMA2:12'
	},
	'files' => [
		{
			'CRC' => 'A4901CD7',
			'Modified' => '2024-08-14 22:19:17',
			'Block' => '0',
			'Encrypted' => '-',
			'Path' => 'bar file.txt',
			'Size' => '4',
			'Packed Size' => '12',
			'Method' => 'LZMA2:12',
			'Attributes' => 'A_ -rw-r--r--'
		},
		{
			'Method' => 'LZMA2:12',
			'Attributes' => 'A_ -rw-r--r--',
			'Packed Size' => '',
			'Size' => '4',
			'CRC' => 'DE00CA96',
			'Modified' => '2024-08-14 22:19:17',
			'Block' => '0',
			'Path' => 'foo file.txt',
			'Encrypted' => '-'
		}
	]
};

sub sort_fields {
	(my $spec, $fields) = @_;
	say Dumper($spec->{archive});
}

my $spec = ({
	Path => ({
		Order => 0,
		Type  => "pathname",
	}),
	Type => ({
		Order => 1,
		Type => "string",
	}),
	PSize => ({
		Order => 2,
		Label => "Physical Size",
		Type => "uint",
	}),
	HSize => ({
		
	})
});
sort_fields $spec, $VAR1;
