{$IfNDef nscDefine}
 {$Define nscDefine}
{ Библиотека "Nemesis Controls" }
{ Автор: Люлин А.В. c           }
{ Модуль: nscDefine.inc - файл переменных условной компиляции библиотеки }
{ Начат: 17.11.2004 21:12       }
{ $Id: nscDefine.inc,v 1.6 2012/10/25 13:46:10 kostitsin Exp $ }

// $Log: nscDefine.inc,v $
// Revision 1.6  2012/10/25 13:46:10  kostitsin
// [$296635114]
//
// Revision 1.5  2008/05/21 17:05:12  lulin
// - <K>: 90441490.
//
// Revision 1.4  2008/05/14 19:05:04  lulin
// - <K>: 90446006.
//
// Revision 1.3  2007/09/07 12:27:27  lulin
// - cleanup.
//
// Revision 1.2  2006/04/11 14:49:25  mmorozov
// - new behaviour: при переходе по истории не вызываем событие _Changed;
//
// Revision 1.1  2004/11/17 18:19:20  lulin
// - new library folder: Nemesis.
//

 {$Include evDefine.inc}
 {$Include vtDefine.inc}
 
 {$IfDef DesignTimeLibrary}
  {$Undef HideFieldVgSceneStyle}
 {$Else DesignTimeLibrary}
  {$Define HideFieldVgSceneStyle}
 {$EndIf DesignTimeLibrary}
 
{$EndIf nscDefine}
