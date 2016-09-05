unit evFacadeUtils;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evFacadeUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evFacadeUtils" MUID: (48EEF98B01FF)

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
 l3IntfUses
 , evCommonTypes
 , evCustomTextSource
 , k2CustomReader
 , evCustomEditorWindow
 , k2TagGen
 , evMemo
 , evdNativeWriter
 , nevBase
;

procedure evInsertFile(aTextSource: TevCustomTextSource;
 aReader: Tk2CustomReader;
 const aCursor: TnevCursor); overload;
procedure evInsertFile(anEditor: TevCustomEditorWindow;
 aReader: Tk2CustomReader); overload;
procedure evFreeGenerator(var aGen: TevGenerator);
procedure evReadDataEX(aTextSource: TevCustomTextSource;
 G: Tk2TagGenerator);
procedure evInsertText2Memo(aMemo: TevMemo;
 const aRange: TnevIRange;
 const aText: AnsiString);
procedure evSetPlainTextFlag(aMemo: TevMemo;
 aValue: Boolean);
function evGetNewTextGenerator(aTextSource: TevCustomTextSource): TevGenerator; overload;
 {* Возвращает генератор для вствки текста. }
function evGetNewTextGenerator(anEditor: TevCustomEditorWindow): TevGenerator; overload;
 {* Возвращает генератор для вствки текста, с учетом текущего курсора. }
procedure evStoreTreeDataObject(const aWriter: TevdNativeWriter;
 const aTree: InevSimpleTree;
 aLevelTag: Integer;
 aFlag: Word);
procedure evSetExcludeWords(anEditor: TevCustomEditorWindow;
 aClear: Boolean);
 {* Устанавливает/сбрасывает флаг ev_slFoundWords (в зависимости от параметра aClear) в ExcludeSuper редактора. }
function evNeedExcludeWords(anEditor: TevCustomEditorWindow): Boolean;
 {* Проверяет установлен ли флаг ev_slFoundWords в ExcludeSuper редактора. }

implementation

uses
 l3ImplUses
 , l3String
 , evCustomEditor
 , evTreeDataObject
 , evTreeStorable
 , nevTools
 , evdTypes
 , evMsgCode
 //#UC START# *48EEF98B01FFimpl_uses*
 //#UC END# *48EEF98B01FFimpl_uses*
;

procedure evInsertFile(aTextSource: TevCustomTextSource;
 aReader: Tk2CustomReader;
 const aCursor: TnevCursor);
//#UC START# *48EEF9F20194_48EEF98B01FF_var*
//#UC END# *48EEF9F20194_48EEF98B01FF_var*
begin
//#UC START# *48EEF9F20194_48EEF98B01FF_impl*
 aTextSource.DocumentContainer.TagWriter.WriteTagEx(nil, aReader, aCursor);
//#UC END# *48EEF9F20194_48EEF98B01FF_impl*
end;//evInsertFile

procedure evInsertFile(anEditor: TevCustomEditorWindow;
 aReader: Tk2CustomReader);
//#UC START# *48EEFA2400D7_48EEF98B01FF_var*
//#UC END# *48EEFA2400D7_48EEF98B01FF_var*
begin
//#UC START# *48EEFA2400D7_48EEF98B01FF_impl*
 with anEditor do
  TextSource.DocumentContainer.TagWriter.WriteTagEx(anEditor.View, aReader, Selection.Cursor);
//#UC END# *48EEFA2400D7_48EEF98B01FF_impl*
end;//evInsertFile

procedure evFreeGenerator(var aGen: TevGenerator);
//#UC START# *48EEFB4F0184_48EEF98B01FF_var*
//#UC END# *48EEFB4F0184_48EEF98B01FF_var*
begin
//#UC START# *48EEFB4F0184_48EEF98B01FF_impl*
 aGen := nil;
//#UC END# *48EEFB4F0184_48EEF98B01FF_impl*
end;//evFreeGenerator

procedure evReadDataEX(aTextSource: TevCustomTextSource;
 G: Tk2TagGenerator);
//#UC START# *48EEFCDD03A9_48EEF98B01FF_var*
//#UC END# *48EEFCDD03A9_48EEF98B01FF_var*
begin
//#UC START# *48EEFCDD03A9_48EEF98B01FF_impl*
  aTextSource.DocumentContainer.TagReader.ReadTagEx(G);
//#UC END# *48EEFCDD03A9_48EEF98B01FF_impl*
end;//evReadDataEX

procedure evInsertText2Memo(aMemo: TevMemo;
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
end;//evInsertText2Memo

procedure evSetPlainTextFlag(aMemo: TevMemo;
 aValue: Boolean);
//#UC START# *48EEFDA30103_48EEF98B01FF_var*
//#UC END# *48EEFDA30103_48EEF98B01FF_var*
begin
//#UC START# *48EEFDA30103_48EEF98B01FF_impl*
 aMemo.PlainText := aValue;
//#UC END# *48EEFDA30103_48EEF98B01FF_impl*
end;//evSetPlainTextFlag

function evGetNewTextGenerator(aTextSource: TevCustomTextSource): TevGenerator;
 {* Возвращает генератор для вствки текста. }
//#UC START# *48EF2BA000E0_48EEF98B01FF_var*
//#UC END# *48EF2BA000E0_48EEF98B01FF_var*
begin
//#UC START# *48EF2BA000E0_48EEF98B01FF_impl*
 Result := aTextSource.GetGenerator(nil, nil);
//#UC END# *48EF2BA000E0_48EEF98B01FF_impl*
end;//evGetNewTextGenerator

function evGetNewTextGenerator(anEditor: TevCustomEditorWindow): TevGenerator;
 {* Возвращает генератор для вствки текста, с учетом текущего курсора. }
//#UC START# *48EF2BC503A1_48EEF98B01FF_var*
//#UC END# *48EF2BC503A1_48EEF98B01FF_var*
begin
//#UC START# *48EF2BC503A1_48EEF98B01FF_impl*
 Result := anEditor.TextSource.GetGenerator(anEditor.View, anEditor.Selection.Cursor);
//#UC END# *48EF2BC503A1_48EEF98B01FF_impl*
end;//evGetNewTextGenerator

procedure evStoreTreeDataObject(const aWriter: TevdNativeWriter;
 const aTree: InevSimpleTree;
 aLevelTag: Integer;
 aFlag: Word);
//#UC START# *492E544E0315_48EEF98B01FF_var*
//#UC END# *492E544E0315_48EEF98B01FF_var*
begin
//#UC START# *492E544E0315_48EEF98B01FF_impl*
    (TevTreeDataObject.MakeStorable(TevTreeStorableData_C(aTree, aLevelTag, aFlag))).Store(nil, aWriter);
//#UC END# *492E544E0315_48EEF98B01FF_impl*
end;//evStoreTreeDataObject

procedure evSetExcludeWords(anEditor: TevCustomEditorWindow;
 aClear: Boolean);
 {* Устанавливает/сбрасывает флаг ev_slFoundWords (в зависимости от параметра aClear) в ExcludeSuper редактора. }
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
end;//evSetExcludeWords

function evNeedExcludeWords(anEditor: TevCustomEditorWindow): Boolean;
 {* Проверяет установлен ли флаг ev_slFoundWords в ExcludeSuper редактора. }
//#UC START# *4BB320970039_48EEF98B01FF_var*
//#UC END# *4BB320970039_48EEF98B01FF_var*
begin
//#UC START# *4BB320970039_48EEF98B01FF_impl*
 with anEditor do
 Result := not (ev_slFoundWords in ExcludeSuper);
//#UC END# *4BB320970039_48EEF98B01FF_impl*
end;//evNeedExcludeWords

end.
