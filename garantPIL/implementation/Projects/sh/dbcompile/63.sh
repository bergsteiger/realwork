#!/bin/sh

short_sys_name=`uname -s`
target=""
taoace_target=""
case ${short_sys_name} in
	*Linux*)
		target="i686_pc_linux_gnu_gcc_server_debug"
		taoace_target="i686_pc_linux_gnu_gcc"
		;;
	*FreeBSD*)
		target="i686_pc_freebsd_gcc_server_debug"
		taoace_target="i686_pc_freebsd_gcc"
		;;
esac
if test "$target" = "" ; then
echo "mpcxc_full_rebuild_ace: FATAL: OS = $short_sys_name not supported."
exit
fi	  

export MPCXC_ROOT="/mnt/windows/work/pilotcvs"

future_scripts_path=$MPCXC_ROOT/src/garant6x/implementation/Projects/sh/build
export MPCXC_SH=$future_scripts_path
ace_config_path=$MPCXC_ROOT/src/common/templates/mpc/make/TAOACE
export MPCXC_CONFIG="" # ensure no config
export MPCXC_TARGET=$target

export TAOACE_MPCXC_ROOT=$MPCXC_ROOT
export TAOACE_MPCXC_TARGET=$taoace_target

export ACE_ROOT=$TAOACE_MPCXC_ROOT/src
export TAO_ROOT=$ACE_ROOT/TAO

export LOKI_ROOT="/home2/grigorio/samba2/2005-10-11"
export XERCES_ROOT="/home/grigorio/tuning/xerces-c-src_2_6_0"


export PATH=/usr/local/gcc402/bin:/usr/local/gcc344/bin:/usr/local/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc402/lib:/usr/local/gcc344/lib:/usr/local/lib:$MPCXC_ROOT/out/$MPCXC_TARGET/lib:$TAOACE_MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/lib:$XERCES_ROOT/lib:$LD_LIBRARY_PATH


cd ..

testbase_dir=$PWD

#date 24/09/2004

#REM Копируем в каталог NSRC изменяющиеся для документов на контроле NSRы
cp -af nsrc/original/* ./nsrc/
cp -af nsrc/original/dict/* ./nsrc/dict/

$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gm -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/hisync -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsplit -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetname -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt -z
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gctx -z

mkdir -p $testbase_dir/../tools.63/linux/convertor/
cp -f $MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/EndtConvertor $testbase_dir/../tools.63/linux/convertor/

### make garant db 'g63_mybase' ###

#REM Компилируем базу g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -6 ini/gc_mybase.ini g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixnames g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev g63_mybase -r:24/09/2004
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/enumparas g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newrefs g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -w g63_mybase

#REM конвертим базу g63_mybase
mkdir -p before_convert/temp
mkdir -p after_convert/temp
cp -f g63_mybase.* before_convert/temp/
cp -f g63_mybase.* after_convert/temp/

#REM переносим базу g63_mybase. Потом понадобится для enumparas
mkdir -p before_convert/enumparas
cp -f g63_mybase.* before_convert/enumparas
rm -f g63_mybase.*

cp -f sh/convertor_old.g63_mybase.ini $testbase_dir/../tools.63/linux/convertor/convertor.ini
cd $testbase_dir/../tools.63/linux/convertor/
./EndtConvertor -type all

#rem pause

cp -f $testbase_dir/after_convert/temp/g63_mybase.* $testbase_dir/
rm -f $testbase_dir/after_convert/temp/g63_mybase.*
cd $testbase_dir/
#rename temp.* g63_mybase.*

### make garant db 'g63_all' ###

#REM Компилируем базу g63_all
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -6 ini/gc_all.ini g63_all
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixnames g63_all
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev g63_all -r:24/09/2004
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev g63_all
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/enumparas g63_all
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newrefs g63_all
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -w g63_all

#REM конвертим базу g63_all
mkdir -p before_convert/temp2
mkdir -p after_convert/temp2
cp -f g63_all.* before_convert/temp2/
cp -f g63_all.* after_convert/temp2/


#REM переносим базу g63_all. Потом понадобится для enumparas
mkdir -p before_convert/enumparas
cp -f g63_all.* before_convert/enumparas
rm -f g63_all.*


cp -f sh/convertor_old.g63_all.ini $testbase_dir/../tools.63/linux/convertor/convertor.ini
cd $testbase_dir/../tools.63/linux/convertor/
./EndtConvertor -type all

cp -f $testbase_dir/after_convert/temp2/g63_all.* $testbase_dir/
rm -f $testbase_dir/after_convert/temp2/g63_all.*
cd $testbase_dir/
#rename temp.* g63_all.*

### make garant db 'g63_win' as merge of 'g63_all' and 'g63_mybase' ###

#REM Объединяем базы и получаем g63_win
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/hisync g63_all g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gm -o g63_win g63_all g63_mybase
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixannos g63_win 
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newcorrs2 g63_win
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -a g63_win
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/calcpara g63_win

$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gctx -m 300 g63_win
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gchange g63_win ini/add236.rul -g
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev g63_win -s:24/09/2004

echo GARANT_DEBUG copying to ./debug/before_gsplit1/
mkdir -p ./debug/before_gsplit1
cp -f g63_win.* ./debug/before_gsplit1/

#REM выливаем базу old63
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsplit -f ini/split_or_g63.ini g63_win
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixbases old63
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl old63 gl_old63.log
cp -f old63.* result/
rm -f old63.*


#REM ТЕПЕРЬ ДЕЛАЕМ БАЗУ НА КОНТРОЛЕ

#date 27/09/2004


#REM Копируем в каталог NSRC изменяющиеся для документов на контроле NSRы
cp -af ./nsrc/control/* ./nsrc/
cp -af ./nsrc/control/dict/* ./nsrc/dict/

### make garant db 'g63_mybase_new' ###

#REM Компилируем базу g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -6 ini/gc_mybase_new.ini g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixnames g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev g63_mybase_new -r:27/09/2004
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/enumparas before_convert/enumparas/g63_mybase g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newrefs g63_mybase_new

#REM конвертим базу g63_mybase_new
mkdir -p before_convert/temp3
mkdir -p after_convert/temp3
cp -f g63_mybase_new.* before_convert/temp3/
cp -f g63_mybase_new.* after_convert/temp3/

mkdir -p before_convert/enumparas
cp -f g63_mybase_new.* before_convert/enumparas/
rm -f g63_mybase_new.*

cp -f sh/convertor_new.g63_mybase_new.ini $testbase_dir/../tools.63/linux/convertor/convertor.ini
cd $testbase_dir/../tools.63/linux/convertor/
./EndtConvertor -type all

cp -f $testbase_dir/after_convert/temp3/g63_mybase_new.* $testbase_dir/
rm -f $testbase_dir/after_convert/temp3/g63_mybase_new.*
cd $testbase_dir/
#rename temp.* g63_mybase_new.*

### make garant db 'g63_all_new' ###

#REM Компилируем базу g63_all_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gc -6 ini/gc_all_new.ini g63_all_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixnames g63_all_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl g63_all_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev g63_all_new -r:27/09/2004
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetrev g63_all_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/enumparas before_convert/enumparas/g63_all g63_all_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newrefs g63_all_new

#REM конвертим базу g63_all_new
mkdir -p before_convert/temp4
mkdir -p after_convert/temp4
cp -f g63_all_new.* before_convert/temp4/
cp -f g63_all_new.* after_convert/temp4/

mkdir -p before_convert/enumparas
cp -f g63_all_new.* before_convert/enumparas/
rm -f g63_all_new.*

cp -f sh/convertor_new.g63_all_new.ini $testbase_dir/../tools.63/linux/convertor/convertor.ini
cd $testbase_dir/../tools.63/linux/convertor/
./EndtConvertor -type all

cp -f $testbase_dir/after_convert/temp4/g63_all_new.* $testbase_dir/
rm -f $testbase_dir/after_convert/temp4/g63_all_new.*
cd $testbase_dir/
#rename temp.* g63_all_new.*


### make garant db 'g63_win_new' as merge of 'g63_all_new' and 'g63_mybase_new' ###

#REM СОХРАНИ БАЗЫ new!!!

#REM Объединяем базы и получаем g63_win_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/hisync g63_all_new g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gm -o g63_win_new g63_all_new g63_mybase_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixannos g63_win_new >fixannos_new.log
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/newcorrs2 g63_win_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl -a -w g63_win_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/calcpara g63_win_new

$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gctx -m 300 g63_win_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gchange g63_win_new ini/add236.rul -g
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev g63_win_new -s:27/09/2004

echo GARANT_DEBUG copying to ./debug/before_gsplit2/
mkdir -p ./debug/before_gsplit2
cp -f g63_win_new.* ./debug/before_gsplit2/

#REM Выливаем базу new62
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsplit -f ini/split_con_g63.ini g63_win_new
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/fixbases new63
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gl new63 gl_new63.log
cp -f new63.* result/
rm -f new63.*
#rem cравнить Key Count  в Newcorrs и Correspondent

#REM копируем логи
mkdir -p ./logs/
cp -f *.log logs/
rm -f *.log
cp -f *.rev logs/
rm -f *.rev

#rem pause

#REM удаляем промежуточные базы
rm -f g*.*
rm -rf ./before_convert/*
rm -rf ./after_convert/*

#rem попытка поменять имя
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetname -w result/old63 ini/name.txt
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gsetname -w result/new63 ini/name.txt

#REM Получение дельт
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev result/old63 result/new63
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/grev result/old63 result/new63 -c:27/9/2004
#REM $MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 0 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 11 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 13 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 18 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 21 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 22 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 26 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 29 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 33 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 198 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 202 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 211 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 235 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 236 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 237 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdlt result/old63 result/new63 999 -T:1
$MPCXC_ROOT/out/$TAOACE_MPCXC_TARGET/bin/gdm delta 11240904.D03 13240904.D03 18240904.D03 21240904.D03 22240904.D03 26240904.D03 29240904.D03 33240904.D03 j8240904.D03 k2240904.D03 l1240904.D03 n5240904.D03 n6240904.D03 n7240904.D03 С9240904.D03

mkdir -p ./result/
cp -f *.D03 ./result/
rm -f *.D03
cp -f *.L03 ./result/
rm -f *.L03
mkdir -p ./logs/
cp -f *.rev ./logs/
rm -f *.rev

