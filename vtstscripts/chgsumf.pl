eval '(exit $?0)' && eval 'exec perl -S $0 ${1+"$@"}' && eval 'exec perl -S $0 $argv:q' if 0;
#;-*- Perl -*-

use FindBin qw($Bin);
use lib "$Bin";
use Fortran::Format;

@ARGV>=2 || die "usage: chgsum.pl <CHGCAR1> <CHGCAR2> <fact1> <fact2>\n";

open (IN1,$ARGV[0]) || die ("Can't open file $!");
open (IN2,$ARGV[1]) || die ("Can't open file $!");
open (OUT,">CHGCAR_sum");

$fact1=$fact2=1.0;
if (@ARGV>2){$fact1=$ARGV[2];}
if (@ARGV>3){$fact2=$ARGV[3];}

for ($i=0;$i<5;$i++) {
   $line1=<IN1>;
   $line2=<IN2>;
   $header1.=$line1;
}

$atoms1=<IN1>;
$header1.=$atoms1;
$atoms2=<IN2>;

@atoms1=split(/\s+/,$atoms1);
@atoms2=split(/\s+/,$atoms2);

$sum1 += $_ for @atoms1;
$sum2 += $_ for @atoms2;

print "Atoms in file1: ".$sum1.", Atoms in file2: ".$sum2."\n";

for ($i=0;$i<$sum1+2;$i++) {
   $header1.=<IN1>;
}

for ($i=0;$i<$sum2+2;$i++) {
   $dummy=<IN2>;
}

$points1=<IN1>;
$header1.=$points1;
$points2=<IN2>;

@points1=split(/\s+/,$points1);
@points2=split(/\s+/,$points2);

$psum1=1;
$psum2=1;

for ($i=1;$i<@points1;$i++) {
   $psum1*=$points1[$i];
   $psum2*=$points2[$i];
}

print "Points in file1: ".$psum1.", Points in file2: ".$psum2."\n";

if ($psum1 != $psum2) {die ("Number of points not same in two files!");}

print OUT $header1;

$lines=$psum1/5; $fi=10;
for ($i=0;$i<$lines;$i++) {
   $f=100*$i/$lines;
   if($f>$fi){print "$fi\% done.\n"; $fi+=10;}
   $line1=<IN1>; $line1=~s/^\s+//g;
   $line2=<IN2>; $line2=~s/^\s+//g;
   @line1=split(/\s+/,$line1);
   @line2=split(/\s+/,$line2);
   for ($j=0;$j<@line1;$j++) {
      $line1[$j]=$fact1*$line1[$j]+$fact2*$line2[$j];}
   print OUT Fortran::Format->new('5E18.11:')->write(@line1);
}

# print any extra information in the first file (such as the augmentation charges)
while (<IN1>){print OUT $_;}

close(OUT);
close(IN2);
close(IN1);
