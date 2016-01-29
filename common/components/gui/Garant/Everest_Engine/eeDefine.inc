{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: eeDefine.inc - файл переменных условной компиляции библиотеки }
{ Начат: 28.05.2003 18:36 }
{ $Id: eeDefine.inc,v 1.3 2015/01/20 11:54:23 lulin Exp $ }

// $Log: eeDefine.inc,v $
// Revision 1.3  2015/01/20 11:54:23  lulin
// - правим зависимости.
//
// Revision 1.1  2014/12/09 14:16:03  kostitsin
// {requestlink: 580710238 }
//
// Revision 1.5  2007/12/04 12:47:33  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.4.24.1  2005/12/14 11:08:04  lulin
// - cleanup.
//
// Revision 1.4  2004/05/26 19:38:29  law
// - убран ненужный define.
//
// Revision 1.3  2004/04/27 16:38:26  law
// - change: в eeDefine.inc вставлена директива vtOutlinerKnowsInterface.
//
// Revision 1.2  2004/03/18 12:21:00  law
// - более корректно описаны Define.
//
// Revision 1.1  2003/05/28 16:15:20  law
// - change: отрезал ee.dll.
//

{$Include evDefine.inc}

{$IfDef DesignTimeLibrary}
 {$Define eeNotNeedOvc}
{$EndIf DesignTimeLibrary}

{$IfNDef eeNotNeedOvc}
 {$Define eeNeedOvc}
{$EndIf  eeNotNeedOvc}
