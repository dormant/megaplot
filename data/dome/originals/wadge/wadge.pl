#!/usr/bin/env perl

open( FH, 'wadge-99-03.txt' );

@lines = <FH>;

$iline = 0;
foreach $line (@lines) {
	$iline++;
	chomp $line;
	$line =~ s/\t/      /g;
	if ($iline eq 1 ) {
		$line =~ s/\s+/, /g;
		$line =~ s/Day,\s+//;
		print $line, "\n";
	} elsif ($iline gt 2 ) {
		$day1 = substr( $line, 0, 6 );
		$day2 = substr( $line, 12, 6 );
		$domvol = substr( $line, 24, 6 );
		$pfvol = substr( $line, 42, 6 );
		$totvol = substr( $line, 54, 7 );
		if ( $day2 eq '      ' ) {
			$day2 = $day1;
		}
		print "$day2,$domvol,$pfvol,$totvol\n";
	}
}
