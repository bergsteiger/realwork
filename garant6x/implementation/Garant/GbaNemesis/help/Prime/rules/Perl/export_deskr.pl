# Это скрипт, который выдергивает из data.xml для f1shell описания VCM-объектов 
# по списку, передаваемому в файле key.lst
#
# Перед запуском скрипта, нужно положить в папку с ним, data.xml от руководства 
#по оболочке (в котором описания уже есть), а также vcm.xml из папки правил, для f1prime.
#
#

# выборка нужных ключей 

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

# выборка данных по выбранным ключам



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
