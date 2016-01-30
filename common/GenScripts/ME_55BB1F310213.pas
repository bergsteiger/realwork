unit ddRTFExpandedTextWriter;

// Модуль: "w:\common\components\rtl\Garant\dd\ddRTFExpandedTextWriter.pas"
// Стереотип: "SimpleClass"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
 , ddRTFSegmentWriter
 , l3Variant
 , k2Interfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 TddBlockInfo = class(Tl3ProtoDataContainer)
  {* Свойства блока, нужные для выливки. }
  private
   f_StyleID: Integer;
    {* Поле для свойства StyleID }
   f_Collapsed: Boolean;
    {* Поле для свойства Collapsed }
   f_ParaID: Integer;
    {* Поле для свойства ParaID }
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   property StyleID: Integer
    read f_StyleID
    write f_StyleID;
   property Collapsed: Boolean
    read f_Collapsed
    write f_Collapsed;
   property ParaID: Integer
    read f_ParaID
    write f_ParaID;
 end;//TddBlockInfo

 _ItemType_ = TddBlockInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TddBlockInfoStack = {final} class(_l3UncomparabeObjectRefList_)
 end;//TddBlockInfoStack

 TddSyleEnum = (
  dd_wsNone
  , dd_wsCheckCollapsed
  , dd_wsOtherStyle
  , dd_wsExpandedText
 );//TddSyleEnum

 TddRTFExpandedTextWriter = class(TddRTFSegmentWriter)
  private
   f_BlockStack: TddBlockInfoStack;
   f_StyledSpace: LongInt;
   f_FindStyle: TddSyleEnum;
   f_AddBlockStyle: Boolean;
  private
   function NeedCheckCollapsed(aStyle: Integer): Boolean;
   function NeedCorrectIndent(aStyle: Integer): Boolean;
   function GetStyleLeftIndent(aStyleID: Integer): Integer;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure StartChild(TypeID: Tl3Type); override;
   procedure DoStartBlock; override;
   procedure DoCloseBlock; override;
   procedure Apply2Sub(AtomIndex: LongInt;
    const Value: Tk2Variant); override;
   procedure DoStartDocument; override;
   function BlockIndent: Integer; override;
    {* Ручки "наружу" для Writer'а. Отступ для дочернего параграфа. }
   function NeedWritePara: Boolean; override;
    {* Ручки "наружу" для Writer'а. Писать или не писать параграф в зависимости от стиля. }
   function IgnoreLeftIndent: Boolean; override;
   procedure CheckFilterPara(aFromFilter: Boolean); override;
 end;//TddRTFExpandedTextWriter

implementation

uses
 l3ImplUses
 , SysUtils
 , k2Tags
 , k2VariantImpl
 , evdStyles
 , ddTypes
 , ddRTFProperties
 , l3Base
 , l3MinMax
 , RTLConsts
;

procedure TddBlockInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55BB29ED03B6_var*
//#UC END# *479731C50290_55BB29ED03B6_var*
begin
//#UC START# *479731C50290_55BB29ED03B6_impl*
 f_StyleID := 0;
 f_Collapsed := False;
 f_ParaID := 0;
 inherited;
//#UC END# *479731C50290_55BB29ED03B6_impl*
end;//TddBlockInfo.Cleanup

procedure TddBlockInfo.InitFields;
//#UC START# *47A042E100E2_55BB29ED03B6_var*
//#UC END# *47A042E100E2_55BB29ED03B6_var*
begin
//#UC START# *47A042E100E2_55BB29ED03B6_impl*
 f_StyleID := 0;
 f_Collapsed := False;
 f_ParaID := 0;
//#UC END# *47A042E100E2_55BB29ED03B6_impl*
end;//TddBlockInfo.InitFields

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_55BB2AA70029_var*
//#UC END# *47B2C42A0163_55BB2AA70029_var*
begin
//#UC START# *47B2C42A0163_55BB2AA70029_impl*
 Assert(False);
//#UC END# *47B2C42A0163_55BB2AA70029_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_55BB2AA70029_var*
//#UC END# *47B99D4503A2_55BB2AA70029_var*
begin
//#UC START# *47B99D4503A2_55BB2AA70029_impl*
 Result := 0;
 Assert(False);
//#UC END# *47B99D4503A2_55BB2AA70029_impl*
end;//CompareExistingItems

type _Instance_R_ = TddBlockInfoStack;

{$Include l3UncomparabeObjectRefList.imp.pas}

function TddRTFExpandedTextWriter.NeedCheckCollapsed(aStyle: Integer): Boolean;
//#UC START# *55BB652A0311_55BB1F310213_var*
//#UC END# *55BB652A0311_55BB1F310213_var*
begin
//#UC START# *55BB652A0311_55BB1F310213_impl*
 Result := aStyle = ev_saExpandedText;
//#UC END# *55BB652A0311_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.NeedCheckCollapsed

function TddRTFExpandedTextWriter.NeedCorrectIndent(aStyle: Integer): Boolean;
//#UC START# *55BB65F40177_55BB1F310213_var*
//#UC END# *55BB65F40177_55BB1F310213_var*
begin
//#UC START# *55BB65F40177_55BB1F310213_impl*
 Result := aStyle = ev_saExpandedText;
//#UC END# *55BB65F40177_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.NeedCorrectIndent

function TddRTFExpandedTextWriter.GetStyleLeftIndent(aStyleID: Integer): Integer;
//#UC START# *55BF76DD00EB_55BB1F310213_var*
var
 l_Style : TddStyleEntry;
//#UC END# *55BF76DD00EB_55BB1F310213_var*
begin
//#UC START# *55BF76DD00EB_55BB1F310213_impl*
 l_Style := Document.StyleTable[f_BlockStack.Last.StyleID];
 if l_Style = nil then
 begin
  f_AddBlockStyle := True;
  try
   l_Style := AddEvStyle(f_BlockStack.Last.StyleID);
  finally
   f_AddBlockStyle := False;
  end;
 end; // if l_Style = nil then
 Result := l_Style.PAP.xaLeft;
//#UC END# *55BF76DD00EB_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.GetStyleLeftIndent

procedure TddRTFExpandedTextWriter.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_55BB1F310213_var*
//#UC END# *479731C50290_55BB1F310213_var*
begin
//#UC START# *479731C50290_55BB1F310213_impl*
 f_AddBlockStyle := False;
 FreeAndNil(f_BlockStack);
 inherited;
//#UC END# *479731C50290_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.Cleanup

procedure TddRTFExpandedTextWriter.StartChild(TypeID: Tl3Type);
//#UC START# *4836D4650177_55BB1F310213_var*
//#UC END# *4836D4650177_55BB1F310213_var*
begin
//#UC START# *4836D4650177_55BB1F310213_impl*
 if not  f_AddBlockStyle and InBlock then
  f_BlockStack.Last.ParaID := f_BlockStack.Last.ParaID + 1;
 inherited;
//#UC END# *4836D4650177_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.StartChild

procedure TddRTFExpandedTextWriter.DoStartBlock;
//#UC START# *55BB1FC300A2_55BB1F310213_var*
var
 l_StyleRec: TddBlockInfo;
//#UC END# *55BB1FC300A2_55BB1F310213_var*
begin
//#UC START# *55BB1FC300A2_55BB1F310213_impl*
 inherited;
 l_StyleRec := TddBlockInfo.Create;
 try
  f_BlockStack.Add(l_StyleRec);
 finally
  FreeAndNil(l_StyleRec);
 end;
 f_FindStyle := dd_wsNone;
//#UC END# *55BB1FC300A2_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.DoStartBlock

procedure TddRTFExpandedTextWriter.DoCloseBlock;
//#UC START# *55BB200700A0_55BB1F310213_var*
//#UC END# *55BB200700A0_55BB1F310213_var*
begin
//#UC START# *55BB200700A0_55BB1F310213_impl*
 inherited;
 if InBlock and (f_BlockStack.Count > 0) then
 begin
  if NeedCorrectIndent(f_BlockStack.Last.StyleID) then
   f_StyledSpace := f_StyledSpace - GetStyleLeftIndent(f_BlockStack.Last.StyleID);
  f_BlockStack.DeleteLast;
 end; // if (CurrentType = k2_typBlock) then
//#UC END# *55BB200700A0_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.DoCloseBlock

procedure TddRTFExpandedTextWriter.Apply2Sub(AtomIndex: LongInt;
 const Value: Tk2Variant);
//#UC START# *55BB2C2E01BD_55BB1F310213_var*
//#UC END# *55BB2C2E01BD_55BB1F310213_var*
begin
//#UC START# *55BB2C2E01BD_55BB1F310213_impl*
 if InBlock then
 begin
  if (AtomIndex = k2_tiStyle) then
  begin
   f_BlockStack.Last.StyleID := Value.AsInteger;
   if NeedCheckCollapsed(Value.AsInteger) then
   begin
    f_StyledSpace := f_StyledSpace + GetStyleLeftIndent(Value.AsInteger);
    f_FindStyle := dd_wsCheckCollapsed;
   end // if f_BlockStack.Last.rStyle = ev_saExpandedText then
   else
    f_FindStyle := dd_wsOtherStyle;
  end; // if (CurrentType = k2_typBlock) and (AtomIndex = k2_tiStyle) then
  if (f_FindStyle = dd_wsCheckCollapsed) and (AtomIndex = k2_tiCollapsed) then
  begin
   f_BlockStack.Last.Collapsed := Boolean(Value.AsInteger);
   f_FindStyle := dd_wsExpandedText;
  end; // if InBlock and (AtomIndex = k2_tiCollapsed) and (f_FindSyle := dd_wsCheckCollapsed) then
 end; // if InBlock then
 inherited;
//#UC END# *55BB2C2E01BD_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.Apply2Sub

procedure TddRTFExpandedTextWriter.DoStartDocument;
//#UC START# *55BB394E0074_55BB1F310213_var*
//#UC END# *55BB394E0074_55BB1F310213_var*
begin
//#UC START# *55BB394E0074_55BB1F310213_impl*
 inherited;
 if f_BlockStack = nil then
 begin
  f_AddBlockStyle := False;
  f_StyledSpace := 0;
  f_BlockStack := TddBlockInfoStack.Create;
 end; // if f_BlockStack = nil then
//#UC END# *55BB394E0074_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.DoStartDocument

function TddRTFExpandedTextWriter.BlockIndent: Integer;
 {* Ручки "наружу" для Writer'а. Отступ для дочернего параграфа. }
//#UC START# *55BB58F60134_55BB1F310213_var*
//#UC END# *55BB58F60134_55BB1F310213_var*
begin
//#UC START# *55BB58F60134_55BB1F310213_impl*
 Result := propUndefined;
 if (f_BlockStack.Count > 0) and NeedCorrectIndent(f_BlockStack.Last.StyleID) then
  if (f_BlockStack.Last.ParaID = 1) then
   Result := f_StyledSpace - GetStyleLeftIndent(f_BlockStack.Last.StyleID)
  else
   Result := f_StyledSpace;
//#UC END# *55BB58F60134_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.BlockIndent

function TddRTFExpandedTextWriter.NeedWritePara: Boolean;
 {* Ручки "наружу" для Writer'а. Писать или не писать параграф в зависимости от стиля. }
//#UC START# *55BB59B0034D_55BB1F310213_var*

 function lp_Visible: Boolean;
 var
  i: Integer;
 begin
  Result := f_BlockStack.Count < 2;
  if not Result then
  begin
   Result := True;
   for i := f_BlockStack.Count - 2 downto 0 do
    if NeedCheckCollapsed(f_BlockStack.Items[i].StyleID) then
    begin
     Result := not f_BlockStack.Items[i].Collapsed;
     Break;
    end; // if NeedCheckCollapsed(f_BlockStack.Items[i].StyleID) then
  end; // if Result then
 end;

//#UC END# *55BB59B0034D_55BB1F310213_var*
begin
//#UC START# *55BB59B0034D_55BB1F310213_impl*
 Result := (f_BlockStack.Count = 0);
 if not Result then
 begin
  Result := not NeedCheckCollapsed(f_BlockStack.Last.StyleID);
  if not Result then
  begin
   Result := lp_Visible;
   if Result then
    if f_BlockStack.Last.Collapsed then
     Result := (f_BlockStack.Last.ParaID = 1)
  end; // if not Result then
 end; // if not Result then
//#UC END# *55BB59B0034D_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.NeedWritePara

function TddRTFExpandedTextWriter.IgnoreLeftIndent: Boolean;
//#UC START# *55C092BD009D_55BB1F310213_var*
//#UC END# *55C092BD009D_55BB1F310213_var*
begin
//#UC START# *55C092BD009D_55BB1F310213_impl*
 Result := inherited IgnoreLeftIndent;
 if (f_BlockStack.Count > 0) and NeedCorrectIndent(f_BlockStack.Last.StyleID) and (f_BlockStack.Last.ParaID = 1) then
  Result := True;
//#UC END# *55C092BD009D_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.IgnoreLeftIndent

procedure TddRTFExpandedTextWriter.CheckFilterPara(aFromFilter: Boolean);
//#UC START# *55E97B4602E4_55BB1F310213_var*
//#UC END# *55E97B4602E4_55BB1F310213_var*
begin
//#UC START# *55E97B4602E4_55BB1F310213_impl*
 if aFromFilter and (f_BlockStack <> nil) and (f_BlockStack.Count > 0) and (f_BlockStack.Last.ParaID = 1) then
  f_BlockStack.Last.ParaID := 0;
//#UC END# *55E97B4602E4_55BB1F310213_impl*
end;//TddRTFExpandedTextWriter.CheckFilterPara

end.
