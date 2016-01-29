unit evRegComponents;

{ Библиотека ""         }
{ Автор: Люлин А.В.     }
{ Модуль: evRegComponents - модуль для регистрации визуальных компонент}
{ Начат: 20.03.97 18:59 }
{ $Id: evRegComponents.pas,v 1.15 2015/04/24 14:44:01 lulin Exp $ }

// $Log: evRegComponents.pas,v $
// Revision 1.15  2015/04/24 14:44:01  lulin
// - правильный define.
//
// Revision 1.13  2015/04/24 14:39:28  lulin
// - правильный define.
//
// Revision 1.12  2015/04/24 14:37:01  lulin
// - правильный define.
//
// Revision 1.11  2015/03/02 14:46:01  lulin
// - перетряхиваем слова.
//
// Revision 1.10  2009/07/24 08:04:15  oman
// Не собирались
//
// Revision 1.9  2008/05/16 15:54:57  lulin
// - cleanup.
//
// Revision 1.8  2007/12/04 12:47:04  lulin
// - перекладываем ветку в HEAD.
//
// Revision 1.2.8.6  2007/11/28 15:49:23  dinishev
// Совместимость с Арчи
//
// Revision 1.2.8.5  2006/12/14 10:41:03  lulin
// - cleanup.
//
// Revision 1.2.8.4  2005/07/21 13:00:34  lulin
// - писатель формата EVD переехал в папку EVD.
//
// Revision 1.2.8.3  2005/07/21 10:39:59  lulin
// - генератор plain-текста переехал в правильную папку.
//
// Revision 1.2.8.2  2005/05/24 08:48:30  lulin
// - bug fix: не компилировалось.
//
// Revision 1.2.8.1  2005/05/19 13:18:43  lulin
// - remove unit: evFont.
//
// Revision 1.2  2005/03/21 08:03:30  mmorozov
// new: для типа _TevStyleId используется редактор свойства TevStyleProperty;
//
// Revision 1.1  2004/09/16 11:30:50  lulin
// - навел подобие порядка с регистрацией компонент библиотеки.
//

{$I evDefine.inc }

interface

procedure Register;

implementation

uses
  Classes,
  {$IfDef Delphi6}
  DesignIntf,
  VCLEditors,
  {$Else   Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}
  ActnList,

  l3Types,
  l3Base,
  l3Filer,
  l3WindowsStorageFiler,

  k2Base,

  evdPlainTextWriter,
  evdWriter,

  evTypes,
  evConst,
  evTextSource,
  evTextFormatter,
  evNSRWrt,
  evSearch,

  evEvdWriter,
  evEvdRd,
  evEvdReader,
  evTxtRd,
  evSubPn,

  evAction,
  evOpProc,
  evCustomFont,

  evExtActionsRes,
  evSaveDocumentManager,
  evLoadDocumentManager,

  evDsgn,
  evdSchema // - это нужно, чтобы подтянуть таблицу тегов
  ;

procedure Register;
begin
 {evFiler}
 {$IfDef l3FilerIsComponent}
 RegisterComponents(evEverestComponentsPage, [TevDOSFiler, Tl3DOSFiler, Tl3WindowsStorageFiler]);
 {$EndIf l3FilerIsComponent}
 {evEdWnd}
 RegisterComponents(evEverestComponentsPage, [TevTextSource]);
 {evSubPn}
 RegisterComponents(evEverestComponentsPage, [TevSubDescriptors]);
 {evSearch}
 {$IfDef evSearchToolIsComponent}
 RegisterComponents(evEverestComponentsPage, [TevBMTextSearcher,
                                              TevStyleSearcher,
                                              TevNormalWordSearcher,
                                              TevRegularExpressionSearcher,
                                              TevTextReplacer, TevStyleReplacer,
                                              TevSubReplacer,
                                              TevHyperlinkSearcher,
                                              TevHyperlinkReplacer]);
 {$EndIf evSearchToolIsComponent}                                             
 {evTxtRd & evEvdRd}
 {$IfDef k2GeneratorIsComponent}
 RegisterComponents(evReaders, [TevTextParser, TevEvdReader, TevEvdStorageReader]);
 {evEvdWrt & evStrGen}
 RegisterComponents(evWriters, [TevdNativeWriter, TevEvdStorageWriter, TevdPlainTextWriter]);
 {$EndIf k2GeneratorIsComponent}
 {evFont}
 {evAction}
 {$IfDef evNeedDisp}
 RegisterActions(evEverestActionCategory, [TevAction], nil);
 {$EndIf evNeedDisp}
 {evTxtExp}
 {$IfDef k2GeneratorIsComponent}
 RegisterComponents(evWriters, [TevTextFormatter]);
 {evTxtExp}
 RegisterComponents(evWriters, [TevNSRCGenerator, TevNSRCWriter]);
 {$EndIf k2GeneratorIsComponent}
 {evOpProc}
 RegisterPropertyEditor(TypeInfo(TevStyleId), nil, '', TevStyleProperty);
 {evIntf}
 RegisterPropertyEditor(TypeInfo(String), TevCustomFont, 'Name', TFontNameProperty);
 {evSaveDocumentManager}
 RegisterComponents(evEverestComponentsPage, [TevSaveDocumentManager]);
 {evLoadDocumentManager}
 RegisterComponents(evEverestComponentsPage, [TevLoadDocumentManager]);
end;

end.

