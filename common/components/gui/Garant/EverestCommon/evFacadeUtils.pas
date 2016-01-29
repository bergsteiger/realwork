unit evFacadeUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evFacadeUtils.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evFacadeUtils
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  nevBase,
  k2TagGen,
  evCustomEditorWindow,
  evCustomTextSource,
  k2CustomReader,
  evdNativeWriter,
  evMemo,
  evCommonTypes
  ;

procedure EvInsertFile(aTextSource: TevCustomTextSource;
  aReader: Tk2CustomReader;
  const aCursor: TnevCursor); overload; 
procedure EvInsertFile(anEditor: TevCustomEditorWindow;
  aReader: Tk2CustomReader); overload; 
procedure EvFreeGenerator(var aGen: TevGenerator);
procedure EvReadDataEX(aTextSource: TevCustomTextSource;
  G: Tk2TagGenerator);
procedure EvInsertText2Memo(aMemo: TevMemo;
  const aRange: TnevIRange;
  const aText: AnsiString);
procedure EvSetPlainTextFlag(aMemo: TevMemo;
  aValue: Boolean);
function EvGetNewTextGenerator(aTextSource: TevCustomTextSource): TevGenerator; overload; 
   {* Возвращает генератор для вствки текста. }
function EvGetNewTextGenerator(anEditor: TevCustomEditorWindow): TevGenerator; overload; 
   {* Возвращает генератор для вствки текста, с учетом текущего курсора. }
procedure EvStoreTreeDataObject(const aWriter: TevdNativeWriter;
  const aTree: InevSimpleTree;
  aLevelTag: Integer;
  aFlag: Word);
procedure EvSetExcludeWords(anEditor: TevCustomEditorWindow;
  aClear: Boolean);
   {* Устанавливает/сбрасывает флаг ev_slFoundWords (в зависимости от параметра aClear) в ExcludeSuper редактора. }
function EvNeedExcludeWords(anEditor: TevCustomEditorWindow): Boolean;
   {* Проверяет установлен ли флаг ev_slFoundWords в ExcludeSuper редактора. }

implementation

uses
  l3String,
  evCustomEditor,
  evTreeDataObject,
  evTreeStorable,
  nevTools,
  evdTypes,
  evMsgCode
  ;

// unit methods

procedure EvInsertFile(aTextSource: TevCustomTextSource;
  aReader: Tk2CustomReader;
  const aCursor: TnevCursor);
//#UC START# *48EEF9F20194_48EEF98B01FF_var*
//#UC END# *48EEF9F20194_48EEF98B01FF_var*
begin
//#UC START# *48EEF9F20194_48EEF98B01FF_impl*
 aTextSource.DocumentContainer.TagWriter.WriteTagEx(nil, aReader, aCursor);
//#UC END# *48EEF9F20194_48EEF98B01FF_impl*
end;//EvInsertFile

procedure EvInsertFile(anEditor: TevCustomEditorWindow;
  aReader: Tk2CustomReader);
//#UC START# *48EEFA2400D7_48EEF98B01FF_var*
//#UC END# *48EEFA2400D7_48EEF98B01FF_var*
begin
//#UC START# *48EEFA2400D7_48EEF98B01FF_impl*
 with anEditor do
  TextSource.DocumentContainer.TagWriter.WriteTagEx(anEditor.View, aReader, Selection.Cursor);
//#UC END# *48EEFA2400D7_48EEF98B01FF_impl*
end;//EvInsertFile

procedure EvFreeGenerator(var aGen: TevGenerator);
//#UC START# *48EEFB4F0184_48EEF98B01FF_var*
//#UC END# *48EEFB4F0184_48EEF98B01FF_var*
begin
//#UC START# *48EEFB4F0184_48EEF98B01FF_impl*
 aGen := nil;
//#UC END# *48EEFB4F0184_48EEF98B01FF_impl*
end;//EvFreeGenerator

procedure EvReadDataEX(aTextSource: TevCustomTextSource;
  G: Tk2TagGenerator);
//#UC START# *48EEFCDD03A9_48EEF98B01FF_var*
//#UC END# *48EEFCDD03A9_48EEF98B01FF_var*
begin
//#UC START# *48EEFCDD03A9_48EEF98B01FF_impl*
  aTextSource.DocumentContainer.TagReader.ReadTagEx(G);
//#UC END# *48EEFCDD03A9_48EEF98B01FF_impl*
end;//EvReadDataEX

procedure EvInsertText2Memo(aMemo: TevMemo;
  const aRange: TnevIRange;
  const aText: AnsiString);
//#UC START# *48EEFD9903E1_48EEF98B01FF_var*
//#UC END# *48EEFD9903E1_48EEF98B01FF_var*
begin
//#UC START# *48EEFD9903E1_48EEF98B01FF_impl*
 // удаляем выделенный блок
 aRange.Modify.Delete(aMemo.View, aMemo.StartOp(ev_msgDeletePara));
 // вставляем текст
 aMemo.InsertBuf(l3PCharLen(aText));
//#UC END# *48EEFD9903E1_48EEF98B01FF_impl*
end;//EvInsertText2Memo

procedure EvSetPlainTextFlag(aMemo: TevMemo;
  aValue: Boolean);
//#UC START# *48EEFDA30103_48EEF98B01FF_var*
//#UC END# *48EEFDA30103_48EEF98B01FF_var*
begin
//#UC START# *48EEFDA30103_48EEF98B01FF_impl*
 aMemo.PlainText := aValue;
//#UC END# *48EEFDA30103_48EEF98B01FF_impl*
end;//EvSetPlainTextFlag

function EvGetNewTextGenerator(aTextSource: TevCustomTextSource): TevGenerator;
//#UC START# *48EF2BA000E0_48EEF98B01FF_var*
//#UC END# *48EF2BA000E0_48EEF98B01FF_var*
begin
//#UC START# *48EF2BA000E0_48EEF98B01FF_impl*
 Result := aTextSource.GetGenerator(nil, nil);
//#UC END# *48EF2BA000E0_48EEF98B01FF_impl*
end;//EvGetNewTextGenerator

function EvGetNewTextGenerator(anEditor: TevCustomEditorWindow): TevGenerator;
//#UC START# *48EF2BC503A1_48EEF98B01FF_var*
//#UC END# *48EF2BC503A1_48EEF98B01FF_var*
begin
//#UC START# *48EF2BC503A1_48EEF98B01FF_impl*
 Result := anEditor.TextSource.GetGenerator(anEditor.View, anEditor.Selection.Cursor);
//#UC END# *48EF2BC503A1_48EEF98B01FF_impl*
end;//EvGetNewTextGenerator

procedure EvStoreTreeDataObject(const aWriter: TevdNativeWriter;
  const aTree: InevSimpleTree;
  aLevelTag: Integer;
  aFlag: Word);
//#UC START# *492E544E0315_48EEF98B01FF_var*
//#UC END# *492E544E0315_48EEF98B01FF_var*
begin
//#UC START# *492E544E0315_48EEF98B01FF_impl*
    (TevTreeDataObject.MakeStorable(TevTreeStorableData_C(aTree, aLevelTag, aFlag))).Store(nil, aWriter);
//#UC END# *492E544E0315_48EEF98B01FF_impl*
end;//EvStoreTreeDataObject

procedure EvSetExcludeWords(anEditor: TevCustomEditorWindow;
  aClear: Boolean);
//#UC START# *4BB3202300B5_48EEF98B01FF_var*
//#UC END# *4BB3202300B5_48EEF98B01FF_var*
begin
//#UC START# *4BB3202300B5_48EEF98B01FF_impl*
 with anEditor do
 if aClear then
  ExcludeSuper := ExcludeSuper - [ev_slFoundWords]
 else
  ExcludeSuper := ExcludeSuper + [ev_slFoundWords]
//#UC END# *4BB3202300B5_48EEF98B01FF_impl*
end;//EvSetExcludeWords

function EvNeedExcludeWords(anEditor: TevCustomEditorWindow): Boolean;
//#UC START# *4BB320970039_48EEF98B01FF_var*
//#UC END# *4BB320970039_48EEF98B01FF_var*
begin
//#UC START# *4BB320970039_48EEF98B01FF_impl*
 with anEditor do
 Result := not (ev_slFoundWords in ExcludeSuper);
//#UC END# *4BB320970039_48EEF98B01FF_impl*
end;//EvNeedExcludeWords

end.