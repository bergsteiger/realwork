# ��� ������, ������� ����������� �� data.xml ��� f1shell �������� VCM-�������� 
# �� ������, ������������� � ����� key.lst
#
# ����� �������� �������, ����� �������� � ����� � ���, data.xml �� ����������� 
#�� �������� (� ������� �������� ��� ����), � ����� vcm.xml �� ����� ������, ��� f1prime.
#
#

# ������� ������ ������ 

$datafile="vcm.xml";
$keyfile="key.lst";
open(data,"$datafile") || die "Cannot open in $!\n";
open(keyf,">$keyfile") || die "Cannot open in $!\n";
foreach (<data>){
s/\0??//g;
if (/.+key=\"([a-zA-Z\-_]*)\".*/) {print keyf "$1\n";}
                      }
close(keyf);
close(data);



$keyfile="key.lst";

# ������� ������ �� ��������� ������



$datafile="data.xml";
$outfile="out.xml";

open(new,">$outfile") || die "Cannot open out $!\n";
open(keyf,"$keyfile") || die "Cannot open in $!\n";
foreach(<keyf>){
chomp($_);
$key = $_;
$nodescr=1;
open(data,"$datafile") || die "Cannot open in $!\n";
$flag=0;

foreach $temp (<data>){

		if (($flag) and index($temp,'">')!=-1) {
		   print new "$temp\n";
                   $flag=0;
                   print new "</description>\n";}

if ((index($temp,$key)!=-1) and (index($temp,'description')!=-1)){
   print new $temp;
   $flag=1;
   if (index($temp,'">')!=-1) {$flag=0; print new "</description>\n"; }
   $nodescr=0;                                                   }

                      }
close(data);
if ($nodescr) {print "$key\n";}
               }
close(keyf);
close(new);
