unit evFacadTextSource;

// Модуль: "w:\common\components\gui\Garant\EverestCommon\evFacadTextSource.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCommonTypes
 , evCustomTextSource
 , evCustomEditorWindow
 , Classes
 , l3Interfaces
;

function evGetUndoBuffer(aTextSource: TevCustomTextSource): TnevCustomUndoBuffer;
function evGetBruttoCharCount(aTextSource: TevCustomTextSource): Integer;
function evGetBruttoCharLimit(aTextSource: TevCustomTextSource): Integer;
function evGetNettoCharCount(aTextSource: TevCustomTextSource): Integer;
function evGetShowDocumentParts(anEditor: TevCustomEditorWindow): Boolean;
function evGetTextParaCount(aTextSource: TevCustomTextSource): Integer;
procedure evInsertFrom(anEditor: TevCustomEditorWindow;
 aTextSource: TevCustomTextSource);
procedure evSetBruttoCharLimit(aTextSource: TevCustomTextSource;
 aValue: Integer);
procedure evSetNettoCharCountEvent(aTextSource: TevCustomTextSource;
 aValue: TNotifyEvent);
procedure evSetShowDocumentParts(anEditor: TevCustomEditorWindow;
 aTextSource: TevCustomTextSource;
 aValue: Boolean);
procedure evSetTextParaLimit(aTextSource: TevCustomTextSource;
 aCount: Integer);
procedure evAddStringToTextSource(aTextSource: TevCustomTextSource;
 const aStr: AnsiString;
 aFormat: Tl3ClipboardFormat = cf_Text);

implementation

uses
 l3ImplUses
 , evTextSource
 , evRange
 , l3Base
 , evOp
 , evEditorInterfaces
;

function evGetUndoBuffer(aTextSource: TevCustomTextSource): TnevCustomUndoBuffer;
//#UC START# *48EEFC180229_48EEFBF70249_var*
//#UC END# *48EEFC180229_48EEFBF70249_var*
begin
//#UC START# *48EEFC180229_48EEFBF70249_impl*
 Result :=
   aTextSource.Processor.UndoBuffer;
//#UC END# *48EEFC180229_48EEFBF70249_impl*
end;//evGetUndoBuffer

function evGetBruttoCharCount(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC5A0393_48EEFBF70249_var*
//#UC END# *48EEFC5A0393_48EEFBF70249_var*
begin
//#UC START# *48EEFC5A0393_48EEFBF70249_impl*
 Result := aTextSource.DocumentContainer.DocumentInfo.BruttoCharCount;
//#UC END# *48EEFC5A0393_48EEFBF70249_impl*
end;//evGetBruttoCharCount

function evGetBruttoCharLimit(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC710310_48EEFBF70249_var*
//#UC END# *48EEFC710310_48EEFBF70249_var*
begin
//#UC START# *48EEFC710310_48EEFBF70249_impl*
 Result :=
  aTextSource.DocumentContainer.DocumentLimits.BruttoCharLimit;
//#UC END# *48EEFC710310_48EEFBF70249_impl*
end;//evGetBruttoCharLimit

function evGetNettoCharCount(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC750348_48EEFBF70249_var*
//#UC END# *48EEFC750348_48EEFBF70249_var*
begin
//#UC START# *48EEFC750348_48EEFBF70249_impl*
 Result := aTextSource.DocumentContainer.DocumentInfo.NettoCharCount;
//#UC END# *48EEFC750348_48EEFBF70249_impl*
end;//evGetNettoCharCount

function evGetShowDocumentParts(anEditor: TevCustomEditorWindow): Boolean;
//#UC START# *48EEFC790248_48EEFBF70249_var*
//#UC END# *48EEFC790248_48EEFBF70249_var*
begin
//#UC START# *48EEFC790248_48EEFBF70249_impl*
 Result := anEditor.ShowDocumentParts
//#UC END# *48EEFC790248_48EEFBF70249_impl*
end;//evGetShowDocumentParts

function evGetTextParaCount(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC7C03C9_48EEFBF70249_var*
//#UC END# *48EEFC7C03C9_48EEFBF70249_var*
begin
//#UC START# *48EEFC7C03C9_48EEFBF70249_impl*
 Result := aTextSource.DocumentContainer.DocumentInfo.TextParaCount;
//#UC END# *48EEFC7C03C9_48EEFBF70249_impl*
end;//evGetTextParaCount

procedure evInsertFrom(anEditor: TevCustomEditorWindow;
 aTextSource: TevCustomTextSource);
//#UC START# *48EEFC8B03E0_48EEFBF70249_var*
//#UC END# *48EEFC8B03E0_48EEFBF70249_var*
begin
//#UC START# *48EEFC8B03E0_48EEFBF70249_impl*
  anEditor.InsertFrom(aTextSource.DocumentContainer.TagReader);
//#UC END# *48EEFC8B03E0_48EEFBF70249_impl*
end;//evInsertFrom

procedure evSetBruttoCharLimit(aTextSource: TevCustomTextSource;
 aValue: Integer);
//#UC START# *48EEFC900196_48EEFBF70249_var*
//#UC END# *48EEFC900196_48EEFBF70249_var*
begin
//#UC START# *48EEFC900196_48EEFBF70249_impl*
  aTextSource.DocumentContainer.DocumentLimits.BruttoCharLimit := aValue;
//#UC END# *48EEFC900196_48EEFBF70249_impl*
end;//evSetBruttoCharLimit

procedure evSetNettoCharCountEvent(aTextSource: TevCustomTextSource;
 aValue: TNotifyEvent);
//#UC START# *48EEFC930337_48EEFBF70249_var*
//#UC END# *48EEFC930337_48EEFBF70249_var*
begin
//#UC START# *48EEFC930337_48EEFBF70249_impl*
 (aTextSource As TevTextSource).OnNettoCharCountChange := aValue;
//#UC END# *48EEFC930337_48EEFBF70249_impl*
end;//evSetNettoCharCountEvent

procedure evSetShowDocumentParts(anEditor: TevCustomEditorWindow;
 aTextSource: TevCustomTextSource;
 aValue: Boolean);
//#UC START# *48EEFC970100_48EEFBF70249_var*
//#UC END# *48EEFC970100_48EEFBF70249_var*
begin
//#UC START# *48EEFC970100_48EEFBF70249_impl*
 anEditor.ShowDocumentParts := aValue;
//#UC END# *48EEFC970100_48EEFBF70249_impl*
end;//evSetShowDocumentParts

procedure evSetTextParaLimit(aTextSource: TevCustomTextSource;
 aCount: Integer);
//#UC START# *48EEFCA80353_48EEFBF70249_var*
//#UC END# *48EEFCA80353_48EEFBF70249_var*
begin
//#UC START# *48EEFCA80353_48EEFBF70249_impl*
  aTextSource.DocumentContainer.DocumentLimits.TextParaLimit := aCount;
//#UC END# *48EEFCA80353_48EEFBF70249_impl*
end;//evSetTextParaLimit

procedure evAddStringToTextSource(aTextSource: TevCustomTextSource;
 const aStr: AnsiString;
 aFormat: Tl3ClipboardFormat = cf_Text);
//#UC START# *48EEFD580285_48EEFBF70249_var*
var
 l_Range  : TedRange;
 l_Cursor : InevPointTool;
//#UC END# *48EEFD580285_48EEFBF70249_var*
begin
//#UC START# *48EEFD580285_48EEFBF70249_impl*
  aTextSource.Document.QT(InevPointTool, l_Cursor);
  l_Cursor.Move(nil, ev_ocBottomRight);
  l_Range := TedRange.Create(nil, l_Cursor, aTextSource.Processor);
  try
   IedRange(l_Range).InsertString(aStr, aFormat);
  finally
   l3Free(l_Range);
  end;//try..finally
//#UC END# *48EEFD580285_48EEFBF70249_impl*
end;//evAddStringToTextSource

end.
