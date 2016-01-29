unit evAlienReg;

{ Библиотека "Эверест"    }
{ Автор: Люлин А.В. ©     }
{ Модуль: evAlienReg -    }
{ Начат: 28.06.2001 16:34 }
{ $Id: evAlienReg.pas,v 1.17 2011/03/15 16:19:45 lulin Exp $ }

// $Log: evAlienReg.pas,v $
// Revision 1.17  2011/03/15 16:19:45  lulin
// {RequestLink:228688510}.
// [$255978845].
// [$255983129].
// - не даём таскать сплиттер у толкования без перевода.
//
// Revision 1.16  2011/02/17 10:00:16  lulin
// {RequestLink:253659765}.
// - вычищаем мусорок.
//
// Revision 1.15  2008/05/15 17:31:41  lulin
// - чистка использования модулей.
// - убираем неочевидную логику скроллирования.
//
// Revision 1.14  2008/05/13 16:24:11  lulin
// - изменения в рамках <K>: 90441490.
//
// Revision 1.13  2007/12/06 12:14:49  lulin
// - используем стандартный контрол выбора цвета.
//
// Revision 1.12  2007/08/30 13:20:51  lulin
// - cleanup.
//
// Revision 1.11  2007/04/10 08:42:30  lulin
// - bug fix: отъезжали редакторы свойств (CQ OIT5-24966).
//
// Revision 1.10  2007/04/09 13:53:00  lulin
// - bug fix: отъезжали многострочные редакторы свойств (CQ OIT5-24912).
//
// Revision 1.9  2007/03/20 09:05:06  lulin
// - избавляемся от чужого редактора.
//
// Revision 1.8  2007/03/13 14:15:07  lulin
// - регистрируем только действительно используемые компоненты.
//
// Revision 1.7  2005/04/19 10:19:38  lulin
// - для тестовых приложений под Define _nsTest добавлены "правильные" директивы компиляции.
//
// Revision 1.6  2004/11/30 10:16:49  fireton
// - добавлены компоненты из Orpheus
//
// Revision 1.5  2004/03/15 14:23:24  law
// - change: переделки в связи с изменением библиотек компонентов.
//
// Revision 1.4  2002/01/03 14:19:45  law
// - добавлена регистрация TOvcNotebook.
//
// Revision 1.3  2001/09/24 11:18:07  law
// - bug fix: не обновлялись максимальные размеры вертикального скроллера.
//
// Revision 1.2  2001/08/30 16:34:45  law
// - new version: портировал на Delphi 6.
//
// Revision 1.1  2001/07/23 09:16:03  law
// - new: добавлен пакет для регистрации всех компонентов Эвереста.
//

{$Include evDefine.inc }

interface

{$R 'ElEdits.dcr'}
{$R 'ElPgCtl.dcr'}
{$R 'ElPopBtn.dcr'}

uses
  Classes,
  Controls,
  
  {$IfDef Delphi6}
  DesignIntf,
  {$Else  Delphi6}
  DsgnIntf,
  {$EndIf Delphi6}

  TB97Reg,

  OvcCmd,
  OvcBase,
  OvcCmdP0,
  OvcNbk,    {notebook component}
  OvcNbkP0,  {property editor for the notebook pages}
  OvcTable,
  OvcTCHdr,
  OvcTCBox,
  OvcTCEdt,
  OvcTCDT,

  RxSplit,
  ToolEdit,
  rxCombos,

  ElPgCtl,
  ElPopBtn,

  ElImageIndexProp,
  PgCtlProp,
  MlCapProp
  ;

procedure Register;

implementation

uses
  l3VCLStrings
  ;

procedure Register;
begin
  {register property editor for the controller}
  RegisterPropertyEditor(
    TypeInfo(TOvcCommandProcessor), nil, '', TOvcCommandProcessorProperty);

  {register component editor for the controller}
  RegisterComponentEditor(TOvcController, TOvcControllerEditor);

  {register property editors and component editor for the notebook component}
  RegisterPropertyEditor(
    TypeInfo(string), TOvcNotebook, 'ActivePageName', TOvcTabPageNameProperty);
  RegisterPropertyEditor(
    TypeInfo(TStrings), TOvcNotebook, 'Pages', TOvcTabPageListProperty);
  RegisterComponentEditor(TOvcNotebook, TOvcNotebookEditor);

  RegisterComponents('Orpheus', [TOvcController, TOvcNotebook, TOvcTable, TOvcTCColHead, TOvcTCCheckBox, TOvcTCString, TOvcTCDate]);

  RegisterComponents('Additional', [TRxSplitter, TDirectoryEdit, {TDateEdit,} TFilenameEdit, TFontComboBox]);
  
  RegisterPropertyEditor(TypeInfo(TCursor), TRxSplitter, 'Cursor', nil);

  RegisterComponents('ElPack', [{TelEdit, TElPageControl,} TElPopupButton]);

  RegisterClass(TElTabSheet);
(*  RegisterPropertyEditor(TypeInfo(TElTabSheet), TElPageControl, 'ActivePage',
    TElActivePageProperty);*)

  RegisterComponentEditor(TElCustomPageControl, TElPageControlEditor);
  RegisterComponentEditor(TElTabSheet, TElPageControlEditor);

  RegisterPropertyEditor(TypeInfo(Integer), TElPopupButton, 'ImageIndex', TElImageIndexProperty);
  RegisterPropertyEditor(TypeInfo(Integer), TElTabSheet, 'ImageIndex', TElTabSheetImageIndexProperty);
  
  RegisterPropertyEditor(TypeInfo(WideString), nil, 'Caption',
    TMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(WideString), nil, 'Hint',
    TMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(String), nil, 'Caption',
    TMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(String), nil, 'Hint',
    TMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(TCaption), nil, 'Caption',
    TMlCaptionProperty);
  RegisterPropertyEditor(TypeInfo(Tl3CustomStrings), nil, '',
    Tl3StringsProperty);
end;

end.

