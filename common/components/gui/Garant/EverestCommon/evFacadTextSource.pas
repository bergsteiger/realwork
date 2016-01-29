unit evFacadTextSource;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evFacadTextSource.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evFacadTextSource
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EverestCommon\evDefine.inc}

interface

uses
  l3Interfaces,
  Classes,
  evCustomEditorWindow,
  evCustomTextSource,
  evCommonTypes
  ;

function EvGetUndoBuffer(aTextSource: TevCustomTextSource): TnevCustomUndoBuffer;
function EvGetBruttoCharCount(aTextSource: TevCustomTextSource): Integer;
function EvGetBruttoCharLimit(aTextSource: TevCustomTextSource): Integer;
function EvGetNettoCharCount(aTextSource: TevCustomTextSource): Integer;
function EvGetShowDocumentParts(anEditor: TevCustomEditorWindow): Boolean;
function EvGetTextParaCount(aTextSource: TevCustomTextSource): Integer;
procedure EvInsertFrom(anEditor: TevCustomEditorWindow;
  aTextSource: TevCustomTextSource);
procedure EvSetBruttoCharLimit(aTextSource: TevCustomTextSource;
  aValue: Integer);
procedure EvSetNettoCharCountEvent(aTextSource: TevCustomTextSource;
  aValue: TNotifyEvent);
procedure EvSetShowDocumentParts(anEditor: TevCustomEditorWindow;
  aTextSource: TevCustomTextSource;
  aValue: Boolean);
procedure EvSetTextParaLimit(aTextSource: TevCustomTextSource;
  aCount: Integer);
procedure EvAddStringToTextSource(aTextSource: TevCustomTextSource;
  const aStr: AnsiString;
  aFormat: Tl3ClipboardFormat = cf_Text);

implementation

uses
  evTextSource,
  evRange,
  l3Base,
  evOp,
  evEditorInterfaces
  ;

// unit methods

function EvGetUndoBuffer(aTextSource: TevCustomTextSource): TnevCustomUndoBuffer;
//#UC START# *48EEFC180229_48EEFBF70249_var*
//#UC END# *48EEFC180229_48EEFBF70249_var*
begin
//#UC START# *48EEFC180229_48EEFBF70249_impl*
 Result :=
   aTextSource.Processor.UndoBuffer;
//#UC END# *48EEFC180229_48EEFBF70249_impl*
end;//EvGetUndoBuffer

function EvGetBruttoCharCount(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC5A0393_48EEFBF70249_var*
//#UC END# *48EEFC5A0393_48EEFBF70249_var*
begin
//#UC START# *48EEFC5A0393_48EEFBF70249_impl*
 Result := aTextSource.DocumentContainer.DocumentInfo.BruttoCharCount;
//#UC END# *48EEFC5A0393_48EEFBF70249_impl*
end;//EvGetBruttoCharCount

function EvGetBruttoCharLimit(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC710310_48EEFBF70249_var*
//#UC END# *48EEFC710310_48EEFBF70249_var*
begin
//#UC START# *48EEFC710310_48EEFBF70249_impl*
 Result :=
  aTextSource.DocumentContainer.DocumentLimits.BruttoCharLimit;
//#UC END# *48EEFC710310_48EEFBF70249_impl*
end;//EvGetBruttoCharLimit

function EvGetNettoCharCount(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC750348_48EEFBF70249_var*
//#UC END# *48EEFC750348_48EEFBF70249_var*
begin
//#UC START# *48EEFC750348_48EEFBF70249_impl*
 Result := aTextSource.DocumentContainer.DocumentInfo.NettoCharCount;
//#UC END# *48EEFC750348_48EEFBF70249_impl*
end;//EvGetNettoCharCount

function EvGetShowDocumentParts(anEditor: TevCustomEditorWindow): Boolean;
//#UC START# *48EEFC790248_48EEFBF70249_var*
//#UC END# *48EEFC790248_48EEFBF70249_var*
begin
//#UC START# *48EEFC790248_48EEFBF70249_impl*
 Result := anEditor.ShowDocumentParts
//#UC END# *48EEFC790248_48EEFBF70249_impl*
end;//EvGetShowDocumentParts

function EvGetTextParaCount(aTextSource: TevCustomTextSource): Integer;
//#UC START# *48EEFC7C03C9_48EEFBF70249_var*
//#UC END# *48EEFC7C03C9_48EEFBF70249_var*
begin
//#UC START# *48EEFC7C03C9_48EEFBF70249_impl*
 Result := aTextSource.DocumentContainer.DocumentInfo.TextParaCount;
//#UC END# *48EEFC7C03C9_48EEFBF70249_impl*
end;//EvGetTextParaCount

procedure EvInsertFrom(anEditor: TevCustomEditorWindow;
  aTextSource: TevCustomTextSource);
//#UC START# *48EEFC8B03E0_48EEFBF70249_var*
//#UC END# *48EEFC8B03E0_48EEFBF70249_var*
begin
//#UC START# *48EEFC8B03E0_48EEFBF70249_impl*
  anEditor.InsertFrom(aTextSource.DocumentContainer.TagReader);
//#UC END# *48EEFC8B03E0_48EEFBF70249_impl*
end;//EvInsertFrom

procedure EvSetBruttoCharLimit(aTextSource: TevCustomTextSource;
  aValue: Integer);
//#UC START# *48EEFC900196_48EEFBF70249_var*
//#UC END# *48EEFC900196_48EEFBF70249_var*
begin
//#UC START# *48EEFC900196_48EEFBF70249_impl*
  aTextSource.DocumentContainer.DocumentLimits.BruttoCharLimit := aValue;
//#UC END# *48EEFC900196_48EEFBF70249_impl*
end;//EvSetBruttoCharLimit

procedure EvSetNettoCharCountEvent(aTextSource: TevCustomTextSource;
  aValue: TNotifyEvent);
//#UC START# *48EEFC930337_48EEFBF70249_var*
//#UC END# *48EEFC930337_48EEFBF70249_var*
begin
//#UC START# *48EEFC930337_48EEFBF70249_impl*
 (aTextSource As TevTextSource).OnNettoCharCountChange := aValue;
//#UC END# *48EEFC930337_48EEFBF70249_impl*
end;//EvSetNettoCharCountEvent

procedure EvSetShowDocumentParts(anEditor: TevCustomEditorWindow;
  aTextSource: TevCustomTextSource;
  aValue: Boolean);
//#UC START# *48EEFC970100_48EEFBF70249_var*
//#UC END# *48EEFC970100_48EEFBF70249_var*
begin
//#UC START# *48EEFC970100_48EEFBF70249_impl*
 anEditor.ShowDocumentParts := aValue;
//#UC END# *48EEFC970100_48EEFBF70249_impl*
end;//EvSetShowDocumentParts

procedure EvSetTextParaLimit(aTextSource: TevCustomTextSource;
  aCount: Integer);
//#UC START# *48EEFCA80353_48EEFBF70249_var*
//#UC END# *48EEFCA80353_48EEFBF70249_var*
begin
//#UC START# *48EEFCA80353_48EEFBF70249_impl*
  aTextSource.DocumentContainer.DocumentLimits.TextParaLimit := aCount;
//#UC END# *48EEFCA80353_48EEFBF70249_impl*
end;//EvSetTextParaLimit

procedure EvAddStringToTextSource(aTextSource: TevCustomTextSource;
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
end;//EvAddStringToTextSource

end.