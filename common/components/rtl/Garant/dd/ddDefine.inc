//..........................................................................................................................................................................................................................................................
{ Библиотека "DD"      }
{ Автор:  ©            }
{ Модуль: ddDefine.inc - файл переменных условной компиляции библиотеки }
{ Начат: 19.04.2003    }
{ $Id: ddDefine.inc,v 1.10 2015/04/13 10:25:18 lulin Exp $ }

// $Log: ddDefine.inc,v $
// Revision 1.10  2015/04/13 10:25:18  lulin
// - пытаемся собрать библиотеку.
//
// Revision 1.9  2013/05/31 07:20:43  lulin
// - портируем под XE4.
//
// Revision 1.8  2013/05/14 09:46:33  lulin
// - разборки с упавшими тестами.
//
// Revision 1.7  2010/03/10 13:57:24  narry
// - не собиралось
//
// Revision 1.6  2007/11/29 05:26:59  narry
// - отказ от расчета времени процесса от Сереги
//
// Revision 1.5  2005/02/16 17:10:41  narry
// - update: Delphi 2005
//
// Revision 1.4  2004/07/26 11:41:10  law
// - убрана директива J+.
//
// Revision 1.3  2004/04/09 12:17:35  narry
// - new: преобразование форматов картинок, не поддерживаемых MS Word в png
//
// Revision 1.2  2003/07/10 08:15:55  narry
// - update: объединение с основной веткой
//
// Revision 1.1  2003/04/19 12:30:36  law
// - new file: ddDefine.inc.
//

{$I evDefine.inc}

{$IfDef DesignTimeLibrary}
 {$Define NoZIP}
{$EndIf DesignTimeLibrary}

{.$J+}
{$DEFINE IEINCLUDEPNG}
{.$DEFINE usel3TimeEstimation}
{.$DEFINE Win7}

{$IfDef Nemesis}
 {$Define ddUseVTSpin}
{$EndIf Nemesis}

{$IfDef RxLibrary}
 {$Define ddUseVTSpin}
{$EndIf RxLibrary}
