unit nevTableRow;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevTableRow.pas"
// Начат: 14.07.2006 15:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParagraphsImplementation::TnevTableRow
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevTools,
  nevParaList,
  l3Variant,
  nevBase
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevTableRow = class(TnevParaList, InevTableRow)
 protected
 // realized methods
   function FindCell(aStart: Integer;
     aWidth: Integer;
     aRight: Boolean = False): TnevParaIndex;
     {* Пытается найти ячейку по смещению и по ширине. }
 protected
 // overridden protected methods
   procedure CheckPrev(const anOp: InevOp;
    aPara: Tl3Variant;
    aPID: Integer); override;
   function DoGetBackColor: TnevColor; override;
 public
 // public methods
   class function Make(aTag: Tl3Variant): InevTableRow; reintroduce;
 end;//TnevTableRow
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  k2Tags,
  k2Base,
  nevFacade,
  evdTypes,
  evConst,
  l3UnitsTools,
  evTableCellUtils,
  k2Const
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevTableRow

class function TnevTableRow.Make(aTag: Tl3Variant): InevTableRow;
var
 l_Inst : TnevTableRow;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnevTableRow.FindCell(aStart: Integer;
  aWidth: Integer;
  aRight: Boolean = False): TnevParaIndex;
//#UC START# *47C7F168011D_48CE2103031C_var*
var
 l_OffsetX : Integer;
 l_UpRight : Integer;

 function SumWidth(aTag: Tl3Variant; anIndex: Integer): Boolean;
 var
  l_Found      : Boolean;
  l_RightBound : Integer;
 begin
  l_RightBound := l_OffsetX + aTag.IntA[k2_tiWidth];
  if aWidth = 0 then
  begin
   Result := l_RightBound < aStart;
   if Result and aRight then
    Result := (l_RightBound - aStart) < -evEpsilon;
   if (evEqualOffset(l_RightBound, aStart) or not Result) and (anIndex > 0) then
    FindCell := anIndex;
  end // if aWidth = 0 then
  else
  begin
   Result := True;
   if aRight then
    l_Found := (evMoreOrEqualOffset(aStart, l_OffsetX) and evMoreOrEqualOffset(l_RightBound, l_UpRight)) or (evMoreOrEqualOffset(aStart, l_OffsetX) and evMoreOrEqualOffset(l_UpRight, l_RightBound))
   else
    l_Found := evMoreOrEqualOffset(l_OffsetX, aStart) and evMoreOrEqualOffset(l_UpRight, l_RightBound);
   if l_Found then
    FindCell := anIndex;
  end;
  l_OffsetX := l_RightBound;
 end;

//#UC END# *47C7F168011D_48CE2103031C_var*
begin
//#UC START# *47C7F168011D_48CE2103031C_impl*
 l_UpRight := aStart + aWidth;
 l_OffsetX := 0;
 Result := 0;
 IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@SumWidth));
//#UC END# *47C7F168011D_48CE2103031C_impl*
end;//TnevTableRow.FindCell

procedure TnevTableRow.CheckPrev(const anOp: InevOp;
  aPara: Tl3Variant;
  aPID: Integer);
//#UC START# *4C8DE3B00073_48CE2103031C_var*
var
 l_Cell      : InevTableCell;
 l_NewCell   : Il3TagRef;
 l_PrevCell  : InevTableCell;
 l_Neighbour : Tl3Variant;
//#UC END# *4C8DE3B00073_48CE2103031C_var*
begin
//#UC START# *4C8DE3B00073_48CE2103031C_impl*
 l_Neighbour := TagInst.Child[aPID];
 if TevMergeStatus(l_Neighbour.IntA[k2_tiMergeStatus]) = ev_msHead then
 begin
  l_Neighbour.QT(InevTableCell, l_Cell);
  l_Cell := l_Cell.GetContinueCell(True, fc_Down);
  while l_Cell <> nil do
  begin
   l_NewCell := evCloneCell(anOp, aPara);
   l_PrevCell := l_Cell; // http://mdp.garant.ru/pages/viewpage.action?pageId=597332678. Только одну строчку правильно исправляем. Т.к. после вставки будут другие смещения у ячеек.
   l_Cell := l_Cell.GetContinueCell(True, fc_Down);
   l_PrevCell.AsObject.Owner.InsertChildTag(l_PrevCell.PID, l_NewCell.AsObject, anOp);
  end; // while l_Cell <> nil do
 end; // if TevMergeStatus(l_Neighbour.IntA[k2_tiMergeStatus]) = ev_msHead then
//#UC END# *4C8DE3B00073_48CE2103031C_impl*
end;//TnevTableRow.CheckPrev

function TnevTableRow.DoGetBackColor: TnevColor;
//#UC START# *52B29B2E013C_48CE2103031C_var*
var
 l_HasMerged: Boolean;

 function lp_CheckCell(aCell: Tl3Variant; Index: LongInt): Boolean;
 begin
  Result := TevMergeStatus(aCell.IntA[k2_tiMergeStatus]) <> ev_msContinue;
  if not Result then
   l_HasMerged := True;
 end;

//#UC END# *52B29B2E013C_48CE2103031C_var*
begin
//#UC START# *52B29B2E013C_48CE2103031C_impl*
 Result := inherited DoGetBackColor;
 if (Result = nevDefaultColor) then
 begin
  with OwnerPara.AsObject.Attr[k2_tiStyle].Attr[k2_tiFont] do
  begin
   if HasSubAtom(k2_tiBackColor) then
   begin
    l_HasMerged := False;
    Self.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@lp_CheckCell));
    if l_HasMerged then
     Result := GetPrev.BackColor
    else
     if not Odd(GetPID) then
     begin
      Result := IntA[k2_tiBackColor];
      if (Result = k2_TransparentValue) then
       Result := nevDefaultColor;
     end;//if not Odd(GetPID) then
   end;//HasSubAtom(k2_tiBackColor)
  end;//Attr[k2_tiStyle].Attr[k2_tiFont]
 end;//Result = nevDefaultColor  
//#UC END# *52B29B2E013C_48CE2103031C_impl*
end;//TnevTableRow.DoGetBackColor

{$IfEnd} //k2ForEditor

end.