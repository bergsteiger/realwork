unit evFacadeSelection;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Модуль: "w:/common/components/gui/Garant/EverestCommon/evFacadeSelection.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EverestCommon::evFacade::evFacadeSelection
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
  nevTools,
  k2TagGen,
  evCustomEditor,
  evCustomEditorWindow,
  evMemo,
  evCommonTypes
  ;

function EvGetSel(anEditor: TevCustomEditorWindow): TnevIRange;
procedure EvAssignSelection(aMemo: TevMemo;
  aPos: Integer;
  const aCurrStr: AnsiString); overload; 
function EvGetSelString(const aRange: TnevIRange): AnsiString;
function EvDeleteBlockEX(const aView: InevView;
  const Container: InevOp;
  const aBlock: InevRange): Boolean;
procedure EvSaveBlock(anEditor: TevCustomEditor;
  out aSaveBlock: TnevLocation;
  const aCheckCursor: TnevCursor = nil);
procedure EvUnselect(anEditor: TevCustomEditorWindow);
procedure EvFreeBlock(var aSaveBlock: TnevLocation);
function EvMostInnerFromBlock(const aBlock: IevCommonDataObject;
  anEditor: TevCustomEditor): InevCommonPoint;
function EvGetBottomChildBlock(const aBlock: TnevIRange;
  anEditor: TevCustomEditorWindow): InevRange;
procedure EvRangeInsertFrom(anEditor: TevCustomEditorWindow;
  aFilter: Tk2TagGenerator);
function EvGetMostInnerRange(anEditor: TevCustomEditor): InevTagSelection;
   {* Возвращает InevRange для курсора самого нижнего уровня }
procedure EvAssignSelection(aMemo: TevMemo;
  aPos: Integer;
  aLen: Integer); overload; 

implementation

uses
  l3String
  {$If defined(k2ForEditor)}
  ,
  evParaTools
  {$IfEnd} //k2ForEditor
  ,
  SysUtils,
  evRange,
  TableCell_Const,
  evdTypes,
  evOp,
  k2Tags
  ;

// unit methods

procedure EvAssignSelection(aMemo: TevMemo;
  aPos: Integer;
  aLen: Integer);
//#UC START# *5321D4830213_48EEF8240298_var*
var
 l_Block : TnevBlock;
//#UC END# *5321D4830213_48EEF8240298_var*
begin
//#UC START# *5321D4830213_48EEF8240298_impl*
 l_Block := aMemo.Selection.Cursor.MostInner.Obj.SubRange(aMemo.View, aPos, aPos + aLen);
 try
  InevSelection(aMemo.Selection).Select(l_Block, false);
 finally
  l_Block := nil;
 end;
//#UC END# *5321D4830213_48EEF8240298_impl*
end;//EvAssignSelection

function EvGetSel(anEditor: TevCustomEditorWindow): TnevIRange;
//#UC START# *48EEF86903A7_48EEF8240298_var*
//#UC END# *48EEF86903A7_48EEF8240298_var*
begin
//#UC START# *48EEF86903A7_48EEF8240298_impl*
 Result := InevSelection(anEditor.Selection).GetBlock;
//#UC END# *48EEF86903A7_48EEF8240298_impl*
end;//EvGetSel

procedure EvAssignSelection(aMemo: TevMemo;
  aPos: Integer;
  const aCurrStr: AnsiString);
//#UC START# *48EEF88901CE_48EEF8240298_var*
var
 l_Len: Integer;
//#UC END# *48EEF88901CE_48EEF8240298_var*
begin
//#UC START# *48EEF88901CE_48EEF8240298_impl*
 if aCurrStr = '' then
  l_Len := 1
 else
  l_Len := Length(aCurrStr);
 EvAssignSelection(aMemo, aPos, l_Len);
//#UC END# *48EEF88901CE_48EEF8240298_impl*
end;//EvAssignSelection

function EvGetSelString(const aRange: TnevIRange): AnsiString;
//#UC START# *48EEF8A0019A_48EEF8240298_var*
//#UC END# *48EEF8A0019A_48EEF8240298_var*
begin
//#UC START# *48EEF8A0019A_48EEF8240298_impl*
 Result := l3PCharLen2String(evAsString(aRange.Data).AsWStr);
//#UC END# *48EEF8A0019A_48EEF8240298_impl*
end;//EvGetSelString

function EvDeleteBlockEX(const aView: InevView;
  const Container: InevOp;
  const aBlock: InevRange): Boolean;
//#UC START# *48EEF92400B1_48EEF8240298_var*
var
 l_TmpBlock : InevRange;
//#UC END# *48EEF92400B1_48EEF8240298_var*
begin
//#UC START# *48EEF92400B1_48EEF8240298_impl*
 l_TmpBlock := aBlock.SolidBottomChildBlock(aView).ParentRange;
 l_TmpBlock.Modify.Delete(aView, Container);
 Result := True;
//#UC END# *48EEF92400B1_48EEF8240298_impl*
end;//EvDeleteBlockEX

procedure EvSaveBlock(anEditor: TevCustomEditor;
  out aSaveBlock: TnevLocation;
  const aCheckCursor: TnevCursor = nil);
//#UC START# *48EEFCF1031C_48EEF8240298_var*
//#UC END# *48EEFCF1031C_48EEF8240298_var*
begin
//#UC START# *48EEFCF1031C_48EEF8240298_impl*
  if anEditor.Selection.FoundBlock <> nil then
   IevRange(anEditor.Selection).AssignSel(anEditor.View, anEditor.Selection.FoundBlock);
  aSaveBlock := anEditor.Selection.SaveBlock(aCheckCursor);
//#UC END# *48EEFCF1031C_48EEF8240298_impl*
end;//EvSaveBlock

procedure EvUnselect(anEditor: TevCustomEditorWindow);
//#UC START# *48EEFCFD0192_48EEF8240298_var*
//#UC END# *48EEFCFD0192_48EEF8240298_var*
begin
//#UC START# *48EEFCFD0192_48EEF8240298_impl*
 InevSelection(anEditor.Selection).Unselect;
//#UC END# *48EEFCFD0192_48EEF8240298_impl*
end;//EvUnselect

procedure EvFreeBlock(var aSaveBlock: TnevLocation);
//#UC START# *48EEFD3B00D0_48EEF8240298_var*
//#UC END# *48EEFD3B00D0_48EEF8240298_var*
begin
//#UC START# *48EEFD3B00D0_48EEF8240298_impl*
 aSaveBlock := nil;
//#UC END# *48EEFD3B00D0_48EEF8240298_impl*
end;//EvFreeBlock

function EvMostInnerFromBlock(const aBlock: IevCommonDataObject;
  anEditor: TevCustomEditor): InevCommonPoint;
//#UC START# *48F2F0CA02E4_48EEF8240298_var*
var
 l_PID   : Integer;
 lStart  : InevCommonPoint;
 lFinish : InevCommonPoint;
 l_Inner : InevCommonPoint;
 l_Parent: InevCommonPoint;
//#UC END# *48F2F0CA02E4_48EEF8240298_var*
begin
//#UC START# *48F2F0CA02E4_48EEF8240298_impl*
 if aBlock = nil then
  if (anEditor.Selection <> nil) and (anEditor.Selection.Cursor <> nil) then
   Result := anEditor.Selection.Cursor.MostInner
  else
   Result := nil
 else // получаем l_Sub из lBlock
 begin
  (aBlock As InevRange).GetBorderPoints(lStart, lFinish);
  Result := lStart.MostInner;
 end;
 if (Result <> nil) then
 begin
  l_PID := Result.Obj.PID;
  l_Parent := Result.ParentPoint;
  while (Result <> nil) and Result.AsObject.IsKindOf(k2_typTableCell) do
  begin
   Inc(l_PID);
   if l_PID >= l_Parent.AsObject.ChildrenCount then
   begin
    Result := nil;
    Break;
   end // if l_PID >= l_Parent.ChildrenCount then
   else
   begin
    l_Inner := l_Parent.Obj^.AsPara.AsList.Para[l_PID].MakePoint(l_Parent);
    l_Parent.Inner := l_Inner;
    l_Inner.Move(anEditor.View, ev_ocBottomRight);
   end;
   if TevMergeStatus(l_Inner.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue then
    Continue;
   Result := l_Inner.MostInner;
  end; // while (Result <> nil) and Result.IsKindOf(k2_typTableCell) do
 end; // if (Result <> nil) then
//#UC END# *48F2F0CA02E4_48EEF8240298_impl*
end;//EvMostInnerFromBlock

function EvGetBottomChildBlock(const aBlock: TnevIRange;
  anEditor: TevCustomEditorWindow): InevRange;
//#UC START# *49B0D2EC01FC_48EEF8240298_var*
//#UC END# *49B0D2EC01FC_48EEF8240298_var*
begin
//#UC START# *49B0D2EC01FC_48EEF8240298_impl*
 Result := aBlock.BottomChildBlock(anEditor.View);
//#UC END# *49B0D2EC01FC_48EEF8240298_impl*
end;//EvGetBottomChildBlock

procedure EvRangeInsertFrom(anEditor: TevCustomEditorWindow;
  aFilter: Tk2TagGenerator);
//#UC START# *4BEBBCE00119_48EEF8240298_var*
//#UC END# *4BEBBCE00119_48EEF8240298_var*
begin
//#UC START# *4BEBBCE00119_48EEF8240298_impl*
  TedRange.Make(anEditor.View, anEditor.Document.Range, anEditor.TextSource.Processor, anEditor.TextPara).InsertFrom(
    anEditor.TextSource.DocumentContainer.TagReader, aFilter);
 anEditor.TextSource.Modified := true;
//#UC END# *4BEBBCE00119_48EEF8240298_impl*
end;//EvRangeInsertFrom

function EvGetMostInnerRange(anEditor: TevCustomEditor): InevTagSelection;
//#UC START# *4C332D2F008B_48EEF8240298_var*
//#UC END# *4C332D2F008B_48EEF8240298_var*
begin
//#UC START# *4C332D2F008B_48EEF8240298_impl*
 Result := anEditor.Selection.Cursor.MostInner.Obj.Range;
//#UC END# *4C332D2F008B_48EEF8240298_impl*
end;//EvGetMostInnerRange

end.