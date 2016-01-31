#!/usr/bin/perl

open $inFile,'< tmp.txt';
$line = readline $inFile;
close $inFile;
chomp $line;



open $outFile,'>>pathdef.m';
print $outFile "     '".$line."/HspiceToolbox:', ...\n";
print $outFile "     '".$line."/HspiceToolbox/rcroman:', ...\n";
print $outFile "%%% END ENTRIES %%%\n";
print $outFile "     ...\n";
print $outFile "];\n";
print $outFile "\n";
print $outFile "p = [userpath,p];\n";
close $outFile;
