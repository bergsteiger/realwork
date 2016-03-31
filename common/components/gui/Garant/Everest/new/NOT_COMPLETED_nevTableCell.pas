unit NOT_COMPLETED_nevTableCell;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevTableCell.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevTableCell" MUID: (48CE0CA20003)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaList
 , nevTools
 , l3Variant
 , nevBase
;

type
 TnevTableCell = class(TnevParaList, InevTableCell)
  private
   function FindCell(const aRow: InevPara): InevPara;
  protected
   function GetMergeHead(anIgnoreMergeStatus: Boolean = False): InevTableCell;
    {* Возвращает первую ячейку в объединении. }
   function GetContinueCell(aNeedValidate: Boolean;
    aWhereFind: TnevFindCell): InevTableCell;
    {* Возвращает нижнюю ячейку объединения, если такая существует. }
   function GetContinueCellInRow(const aRow: InevPara;
    aWhereFind: TnevFindCell): InevTableCell;
   function GetHeadCellPara(anIgnoreMergeStatus: Boolean = False): InevPara;
   function GetContinueCellPara(aNeedValidate: Boolean;
    aWhereFind: TnevFindCell): InevPara;
   function CheckCellWidth(aValue: Integer;
    aOuterWidth: Integer): Integer;
   function IsEmptyCell: Boolean;
   function GetUpperCell: InevPara;
    {* Возвращает ячейку сверху. }
   function GetNeedIncludeHeight(aCheckType: Boolean): Boolean; override;
   function GetOffsetX: Integer; override;
   function GetOverlapType: TOverlapType; override;
  public
   class function Make(aTag: Tl3Variant): InevTableCell; reintroduce;
 end;//TnevTableCell
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , evdTypes
 , nevFacade
 , k2Base
 , evDef
 , l3MinMax
 , evConst
 , evTableCellUtils
 , l3UnitsTools
;

function TnevTableCell.FindCell(const aRow: InevPara): InevPara;
//#UC START# *5006717503DA_48CE0CA20003_var*
var
 l_Delta           : Integer;
 l_OffsetX         : Integer;  
 l_UpWidth         : Integer;
 l_NextCellOffsetX : Integer;

 function SumWidth(const aTag: InevPara; anIndex: TnevParaIndex): Boolean;
 var
  l_Width : Integer;
  l_Equal : Boolean;
 begin
  l_Width := aTag.AsObject.IntA[k2_tiWidth];
  l_Equal := Abs(l_UpWidth - l_Width) < evCellWidthEpsilon; // Ширина у них равна
  if l_Equal then
   l_Equal := Abs(l_NextCellOffsetX - l_OffsetX) <= l_Delta;
  Result := not l_Equal;
  if l_Equal then
   FindCell := aTag;
  Inc(l_NextCellOffsetX, l_Width);
 end;

//#UC END# *5006717503DA_48CE0CA20003_var*
begin
//#UC START# *5006717503DA_48CE0CA20003_impl*
 Result := nil;
 l_NextCellOffsetX := 0;
 l_OffsetX := pm_GetOffsetX;
 l_UpWidth := IntA[k2_tiWidth];
 l_Delta := l_UpWidth div 4;
 aRow.AsList.IterateParaF(nevL2PIA(@SumWidth));
//#UC END# *5006717503DA_48CE0CA20003_impl*
end;//TnevTableCell.FindCell

class function TnevTableCell.Make(aTag: Tl3Variant): InevTableCell;
var
 l_Inst : TnevTableCell;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevTableCell.Make

function TnevTableCell.GetMergeHead(anIgnoreMergeStatus: Boolean = False): InevTableCell;
 {* Возвращает первую ячейку в объединении. }
//#UC START# *47C7F0F50102_48CE0CA20003_var*
var
 l_MergeCell: InevPara;
//#UC END# *47C7F0F50102_48CE0CA20003_var*
begin
//#UC START# *47C7F0F50102_48CE0CA20003_impl*
 Result := nil;
 l_MergeCell := GetHeadCellPara(anIgnoreMergeStatus);
 if (l_MergeCell <> nil) and not l_MergeCell.AsObject.QT(InevTableCell, Result) then
   Assert(false);
//#UC END# *47C7F0F50102_48CE0CA20003_impl*
end;//TnevTableCell.GetMergeHead

function TnevTableCell.GetContinueCell(aNeedValidate: Boolean;
 aWhereFind: TnevFindCell): InevTableCell;
 {* Возвращает нижнюю ячейку объединения, если такая существует. }
//#UC START# *47C7F10600AE_48CE0CA20003_var*
var
 l_MergeCell : InevPara;
//#UC END# *47C7F10600AE_48CE0CA20003_var*
begin
//#UC START# *47C7F10600AE_48CE0CA20003_impl*
 Result := nil;
 l_MergeCell := GetContinueCellPara(aNeedValidate, aWhereFind);
 if (l_MergeCell <> nil) and not l_MergeCell.AsObject.QT(InevTableCell, Result) then
  Assert(false);
//#UC END# *47C7F10600AE_48CE0CA20003_impl*
end;//TnevTableCell.GetContinueCell

function TnevTableCell.GetContinueCellInRow(const aRow: InevPara;
 aWhereFind: TnevFindCell): InevTableCell;
//#UC START# *4E785D93010B_48CE0CA20003_var*
//#UC END# *4E785D93010B_48CE0CA20003_var*
begin
//#UC START# *4E785D93010B_48CE0CA20003_impl*
 Result := Self;
 while Result <> nil do
 begin
  if Result.OwnerPara.AsObject.IsSame(aRow.AsObject) then Break;
  Result := Result.GetContinueCell(True, aWhereFind);
 end; // while Result <> nil do 
//#UC END# *4E785D93010B_48CE0CA20003_impl*
end;//TnevTableCell.GetContinueCellInRow

function TnevTableCell.GetHeadCellPara(anIgnoreMergeStatus: Boolean = False): InevPara;
//#UC START# *500670320399_48CE0CA20003_var*
var
 l_MS      : TevMergeStatus;
 l_PrevRow : InevPara;
//#UC END# *500670320399_48CE0CA20003_var*
begin
//#UC START# *500670320399_48CE0CA20003_impl*
 if not anIgnoreMergeStatus and
    (TevMergeStatus(IntA[k2_tiMergeStatus]) <> ev_msContinue) then
 begin
  Result := Self;
  Exit;
 end;//if _rAtom(k2_tiMergeStatus) <> ev_msContinue then
 l_PrevRow := OwnerPara;
 Result := nil;
 while Result = nil do
 begin
  l_PrevRow := l_PrevRow.Prev;
  {$IfDef Nemesis}
  if not l_PrevRow.IsList then
   Break;
  {$EndIf Nemesis}
  if not l_PrevRow.AsObject.IsValid or (l_PrevRow.AsObject.ChildrenCount = 0) then
   Break;
  Result := FindCell(l_PrevRow);
  if Result = nil then
   Break
  else
   begin
    l_MS := TevMergeStatus(Result.AsObject.IntA[k2_tiMergeStatus]);
    if (l_MS <> ev_msHead) then
    //  ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=272662869
    // Есть большие подозрения, что это был какой-то запил. Но истории не нашел.
    begin
     Result := nil;
     if l_MS = ev_msNone then Break;
    end; // if (Result <> nil) and (TevMergeStatus(Result.AsObject.IntA[k2_tiMergeStatus]) <> ev_msHead) then
   end;
 end;//while l_MergeCell = nil do
//#UC END# *500670320399_48CE0CA20003_impl*
end;//TnevTableCell.GetHeadCellPara

function TnevTableCell.GetContinueCellPara(aNeedValidate: Boolean;
 aWhereFind: TnevFindCell): InevPara;
//#UC START# *5006706B005B_48CE0CA20003_var*
var
 l_MergeCell   : InevPara;
 l_NextRow     : InevPara;
 l_MergeStatus : TevMergeStatus;
//#UC END# *5006706B005B_48CE0CA20003_var*
begin
//#UC START# *5006706B005B_48CE0CA20003_impl*
 Result := nil;
 if (IntA[k2_tiMergeStatus] <> Ord(ev_msNone)) or
    not aNeedValidate then
 begin
  l_NextRow := OwnerPara;
  if (aWhereFind = fc_Down) or (aWhereFind = fc_DownInternal) then
   l_NextRow := l_NextRow.Next
  else
   if aWhereFind = fc_Up then
    l_NextRow := l_NextRow.Prev;
  if (l_NextRow <> nil) and l_NextRow.AsObject.IsValid then
  begin
   {$IfDef Nemesis}
   if not l_NextRow.IsList then
    Exit;
   {$EndIf Nemesis}
   l_MergeCell := FindCell(l_NextRow);
   if (l_MergeCell <> nil) then
   begin
    l_MergeStatus := TevMergeStatus(l_MergeCell.AsObject.IntA[k2_tiMergeStatus]);
    if (l_MergeStatus = ev_msContinue) or
       ((aWhereFind = fc_Up) and (l_MergeStatus = ev_msHead)) then
     Result := l_MergeCell;  
   end;//l_MergeCell <> nil
  end;//l_NextRow <> nil..
 end;//(IntA[k2_tiMergeStatus] <> Ord(ev_msNone)) or not aNeedValidate
//#UC END# *5006706B005B_48CE0CA20003_impl*
end;//TnevTableCell.GetContinueCellPara

function TnevTableCell.CheckCellWidth(aValue: Integer;
 aOuterWidth: Integer): Integer;
//#UC START# *502CE0A10224_48CE0CA20003_var*
//#UC END# *502CE0A10224_48CE0CA20003_var*
begin
//#UC START# *502CE0A10224_48CE0CA20003_impl*
 Result := evCheckCellWidth(aValue, aOuterWidth);
//#UC END# *502CE0A10224_48CE0CA20003_impl*
end;//TnevTableCell.CheckCellWidth

function TnevTableCell.IsEmptyCell: Boolean;
//#UC START# *5048A0DB027E_48CE0CA20003_var*
//#UC END# *5048A0DB027E_48CE0CA20003_var*
begin
//#UC START# *5048A0DB027E_48CE0CA20003_impl*
 Result := Child[0].StrA[k2_tiText] = '';
//#UC END# *5048A0DB027E_48CE0CA20003_impl*
end;//TnevTableCell.IsEmptyCell

function TnevTableCell.GetUpperCell: InevPara;
 {* Возвращает ячейку сверху. }
//#UC START# *53DF6EDF02B3_48CE0CA20003_var*
var
 l_PrevRow : InevPara;
//#UC END# *53DF6EDF02B3_48CE0CA20003_var*
begin
//#UC START# *53DF6EDF02B3_48CE0CA20003_impl*
 l_PrevRow := OwnerPara;
 Result := nil;
 l_PrevRow := l_PrevRow.Prev;
 if not l_PrevRow.AsObject.IsValid or (l_PrevRow.AsObject.ChildrenCount = 0) then Exit;
 Result := FindCell(l_PrevRow);
//#UC END# *53DF6EDF02B3_48CE0CA20003_impl*
end;//TnevTableCell.GetUpperCell

function TnevTableCell.GetNeedIncludeHeight(aCheckType: Boolean): Boolean;
//#UC START# *48CE16E30320_48CE0CA20003_var*
var
 l_MS : TevMergeStatus;
//#UC END# *48CE16E30320_48CE0CA20003_var*
begin
//#UC START# *48CE16E30320_48CE0CA20003_impl*
 if aCheckType then
 begin
  l_MS := TevMergeStatus(IntA[k2_tiMergeStatus]);
  Result := (l_MS = ev_msNone) or
            ((l_MS = ev_msHead) and (GetContinueCell(True, fc_Down) = nil));
 end // if aCheckType then
 else
  Result := GetContinueCell(False, fc_Down) = nil;
//#UC END# *48CE16E30320_48CE0CA20003_impl*
end;//TnevTableCell.GetNeedIncludeHeight

function TnevTableCell.GetOffsetX: Integer;
//#UC START# *48CE1AD90102_48CE0CA20003_var*
var
 l_PID    : Integer;
 l_Offset : Integer absolute Result;

 function CellFunc(aChild: Tl3Variant; Index: Integer): Boolean; 
 begin
  Result := Index < l_PID;
  if Result then 
   l_Offset := l_Offset + aChild.IntA[k2_tiWidth];
 end;

//#UC END# *48CE1AD90102_48CE0CA20003_var*
begin
//#UC START# *48CE1AD90102_48CE0CA20003_impl*
 l_PID := pm_GetPID;
 l_Offset := 0;
 OwnerPara.AsObject.IterateChildrenF(L2Mk2ChildrenIterateChildrenFAction(@CellFunc));
//#UC END# *48CE1AD90102_48CE0CA20003_impl*
end;//TnevTableCell.GetOffsetX

function TnevTableCell.GetOverlapType: TOverlapType;
//#UC START# *48CE1B22020E_48CE0CA20003_var*
//#UC END# *48CE1B22020E_48CE0CA20003_var*
begin
//#UC START# *48CE1B22020E_48CE0CA20003_impl*
 Result := TOverlapType(IntA[k2_tiMergeStatus]);
//#UC END# *48CE1B22020E_48CE0CA20003_impl*
end;//TnevTableCell.GetOverlapType
{$IfEnd} // Defined(k2ForEditor)

end.
