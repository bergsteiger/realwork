unit nevTableRowBaseLine4Print;
 {* Базовая линия для печати }

// Модуль: "w:\common\components\gui\Garant\Everest\nevTableRowBaseLine4Print.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , nevTools
 , l3Variant
 , nevBase
 , nevBasePointList
 , l3Core
 , k2TagPointer
 , k2Base
;

type
 {$Include w:\common\components\gui\Garant\Everest\nevTableRowBaseLineCommon.imp.pas}
 TnevTableRowBaseLine4Print = class(_nevTableRowBaseLineCommon_)
  {* Базовая линия для печати }
  protected
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; override;
   function CheckMaxID(aMaxID: Integer): InevBasePoint; override;
   function SimpleMode: Boolean; override;
   function GetInner4SimpleMode: InevBasePoint; override;
   procedure DoSetInner(const aValue: InevBasePoint); override;
   procedure DoMergeTo(const aView: InevView;
    const aBaseLine: InevBasePoint); override;
   procedure DoCompareWithOtherInner(const aView: InevView;
    anMaxID: Integer = -1); override;
   procedure DoCopyHeadParts(const aFrom: InevBasePoint); override;
   procedure DoAddHeadInner(const aHeadInner: InevBasePoint); override;
   function DoHasHeadPart: Boolean; override;
   function DoInnerHead(aPID: Integer): InevBasePoint; override;
  public
   class function Make(aRow: Tl3Variant): InevPoint; reintroduce;
 end;//TnevTableRowBaseLine4Print
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evdTypes
 , l3MinMax
 , nevAfterEndPoint
 , k2Tags
 , l3Base
 {$If Defined(k2ForEditor)}
 , evTableCellUtils
 {$IfEnd} // Defined(k2ForEditor)
 , SysUtils
;

{$If not Declared(_X_)}type _X_ = InevPara;{$IfEnd}

type _Instance_R_ = TnevTableRowBaseLine4Print;

{$Include w:\common\components\gui\Garant\Everest\nevTableRowBaseLineCommon.imp.pas}

class function TnevTableRowBaseLine4Print.Make(aRow: Tl3Variant): InevPoint;
var
 l_Inst : TnevTableRowBaseLine4Print;
begin
 l_Inst := Create(aRow);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevTableRowBaseLine4Print.Make

function TnevTableRowBaseLine4Print.DoDiff(const aView: InevView;
 const aPoint: InevBasePoint;
 aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4DDA86730300_4DD77A940374_var*
var
 l_Child      : InevPara;
 l_PointInner : InevBasePoint;
 l_Inner      : InevBasePoint;
 l_NotInHead  : Boolean;

 function lp_CheckCellPoints: Integer;
 begin
  if l_PointInner = nil then
   if l_Inner = nil then
    Result := 0
   else
    Result := nev_PlusDiff
  else
  if l_PointInner.AfterEnd then
  begin
   if l_Inner = nil then
    Result := nev_MinusDiff
   else
    if l_Inner.AfterEnd then
     Result := 0{nev_MinusDiff}
    // http://mdp.garant.ru/pages/viewpage.action?pageId=219124975
    // http://mdp.garant.ru/pages/viewpage.action?pageId=219124975&focusedCommentId=219125595#comment-219125595
    else
     Result := nev_MinusDiff{nev_PlusDiff}
    // http://mdp.garant.ru/pages/viewpage.action?pageId=219124975&focusedCommentId=219125601#comment-219125601
  end//l_PointInner.AfterEnd
  else
  begin
   if (l_Inner = nil) or l_Inner.AfterEnd then
    Result := nev_MinusDiff
   else
   if l_NotInHead then
    Result := l_Inner.Diff(aView, l_PointInner, aMap.InfoForChild(l_Child))
   else
    Result := l_Inner.Diff(aView, l_PointInner, aView.FormatInfoByPara(l_PointInner.Obj^));
  end;//l_PointInner.AfterEnd
 end;

var
 i        : Integer;
 l_Line   : InevBasePoint;
 l_List   : InevParaList;
 l_Real   : InevBasePoint;
 l_MaxPID : Integer;
//#UC END# *4DDA86730300_4DD77A940374_var*
begin
//#UC START# *4DDA86730300_4DD77A940374_impl*
 Result := nev_PlusDiff;
 l_Line := aPoint;
 if (l_Line <> nil) then
 begin
  l_MaxPID := aMap.GreatestObjPID;
  l_List := ParaX.AsList;
  l_Child := l_List.Para[l_MaxPID];
  l_NotInHead := TevMergeStatus(l_Child.AsObject.IntA[k2_tiMergeStatus]) <> ev_msContinue;
  if (f_Children.Count > l_MaxPID) and (l_NotInHead or (l_MaxPID < f_HeadCells.Count)) then
  begin
   l_PointInner := l_Line.InnerFor(l_Child, l_Real);
   if l_NotInHead then
    l_Inner := f_Children[l_MaxPID]
   else
   begin
    l_PointInner := l_Real;
    l_Inner := f_HeadCells[l_MaxPID];
   end;
   Result := lp_CheckCellPoints;
  end
  else
  // V - все что ниже надо бы "грохнуть", но при печати вполне можем сюда попасть...
  begin
   l_NotInHead := False;
   for i := 0 to f_Children.Count - 1 do
   begin
    l_Child := l_List.Para[i];
    l_PointInner := l_Line.InnerFor(l_Child, l_Real);
    l_Inner := f_Children[i];
    Result := lp_CheckCellPoints;
    if Result <> 0 then Break;
   end; // for i := 0 to f_Children.Count - 1 do
  end;
 end;//l_Line <> nil
//#UC END# *4DDA86730300_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoDiff

function TnevTableRowBaseLine4Print.CheckMaxID(aMaxID: Integer): InevBasePoint;
//#UC START# *4DDB9A1802A3_4DD77A940374_var*
//#UC END# *4DDB9A1802A3_4DD77A940374_var*
begin
//#UC START# *4DDB9A1802A3_4DD77A940374_impl*
 if (aMaxID >= f_Children.Count) or (aMaxID < 0) then
 begin
  Result := nil;
  Exit;
 end // if (l_MaxID >= f_Children.Count) or (l_MaxID < 0) then
 else
  Result := f_Children[aMaxID];
//#UC END# *4DDB9A1802A3_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.CheckMaxID

function TnevTableRowBaseLine4Print.SimpleMode: Boolean;
//#UC START# *502A1AD60269_4DD77A940374_var*
//#UC END# *502A1AD60269_4DD77A940374_var*
begin
//#UC START# *502A1AD60269_4DD77A940374_impl*
 Result := False;
//#UC END# *502A1AD60269_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.SimpleMode

function TnevTableRowBaseLine4Print.GetInner4SimpleMode: InevBasePoint;
//#UC START# *502A1B0D0231_4DD77A940374_var*
//#UC END# *502A1B0D0231_4DD77A940374_var*
begin
//#UC START# *502A1B0D0231_4DD77A940374_impl*
 Result := nil;
 Assert(False);
//#UC END# *502A1B0D0231_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.GetInner4SimpleMode

procedure TnevTableRowBaseLine4Print.DoSetInner(const aValue: InevBasePoint);
//#UC START# *4DD795FA0114_4DD77A940374_var*
var
 l_Index : Integer;
//#UC END# *4DD795FA0114_4DD77A940374_var*
begin
//#UC START# *4DD795FA0114_4DD77A940374_impl*
 l_Index := aValue.Obj.PID;
 if (f_Children.Count <= l_Index) then
  f_Children.Count := l_Index + 1;
 f_Children[l_Index] := aValue;
 if (TevMergeStatus(aValue.AsObject.IntA[k2_tiMergeStatus]) = ev_msContinue) then
  f_HasMergedCell := True
//#UC END# *4DD795FA0114_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoSetInner

procedure TnevTableRowBaseLine4Print.DoMergeTo(const aView: InevView;
 const aBaseLine: InevBasePoint);
//#UC START# *4DD79C030322_4DD77A940374_var*
var
 i : Integer;

 procedure lp_CheckHead;
 var
  l_Head : InevBasePoint;
 begin
  if (i < f_HeadCells.Count) then
   l_Head := f_HeadCells[i];
  if l_Head <> nil then
   aBaseLine.AddHeadInner(l_Head);
 end; // procedure lp_CheckHead;

var
 l_Count : Integer;
//#UC END# *4DD79C030322_4DD77A940374_var*
begin
//#UC START# *4DD79C030322_4DD77A940374_impl*
 if ParaX.PID < aBaseLine.Obj^.PID then
 begin
  l_Count := ParaX.AsObject.ChildrenCount - 1;
  for i := f_Children.Count to l_Count do
  begin
   aBaseLine.Inner := f_Children[i].ClonePoint(aView);
   lp_CheckHead;
  end; // for i := f_Children.Count to l_Count do
  Exit;
 end; // if ParaX.PID < aBaseLine.Obj^.PID then
 Assert(ParaX.AsObject.IsSame(aBaseLine.Obj^.AsObject));
 l_Count := Max(f_HeadCells.Count - 1, f_Children.Count - 1);
 for i := 0 to l_Count do
 begin
  if i < f_Children.Count - 1 then
   aBaseLine.Inner := f_Children[i].ClonePoint(aView);
  lp_CheckHead;
 end; // for i := 0 to l_Count do
//#UC END# *4DD79C030322_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoMergeTo

procedure TnevTableRowBaseLine4Print.DoCompareWithOtherInner(const aView: InevView;
 anMaxID: Integer = -1);
//#UC START# *4DD79DA50099_4DD77A940374_var*
var
 i          : Integer;
 l_List     : InevParaList;
 l_Point    : InevBasePoint;
 l_NotStart : InevBasePoint;
 l_Count    : Integer;
 l_Start    : Integer;                                    
//#UC END# *4DD79DA50099_4DD77A940374_var*
begin
//#UC START# *4DD79DA50099_4DD77A940374_impl*
 l_List := ParaX.AsList;
 if f_Children.Count < ParaX.AsObject.ChildrenCount then
 begin
  l_Start := f_Children.Count;
  l_Count := ParaX.AsObject.ChildrenCount - 1;
  f_Children.Count := l_Count + 1;
  for i := l_Start to l_Count do
   f_Children[i] := TnevAfterEndPoint.DoMake(l_List[i].MakePoint);
 end; // if f_Children.Count < ParaX.Count then
//#UC END# *4DD79DA50099_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoCompareWithOtherInner

procedure TnevTableRowBaseLine4Print.DoCopyHeadParts(const aFrom: InevBasePoint);
//#UC START# *4DD7A0C30353_4DD77A940374_var*
var
 i       : Integer;
 l_Head  : InevBasePoint;
 l_Count : Integer;
//#UC END# *4DD7A0C30353_4DD77A940374_var*
begin
//#UC START# *4DD7A0C30353_4DD77A940374_impl*
 l_Count := aFrom.Obj^.AsObject.ChildrenCount - 1;
 for i := 0 to l_Count do
 begin
  l_Head := aFrom.InnerHead(i);
  if (l_Head <> nil) and not l_Head.AfterEnd then
   AddHeadInner(l_Head);
 end; // for i := 0 to l_Count do
//#UC END# *4DD7A0C30353_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoCopyHeadParts

procedure TnevTableRowBaseLine4Print.DoAddHeadInner(const aHeadInner: InevBasePoint);
//#UC START# *4DD7A0E30148_4DD77A940374_var*
var
 l_Cell  : InevTableCell;
 l_Index : Integer;

 procedure lp_CheckHeadCells;
 begin
  if f_HeadCells.Count <= l_Index then
   f_HeadCells.Count := l_Index + 1;
  f_HeadCells[l_Index] := aHeadInner;
 end;

//#UC END# *4DD7A0E30148_4DD77A940374_var*
begin
//#UC START# *4DD7A0E30148_4DD77A940374_impl*
 if (aHeadInner <> nil) then
  if aHeadInner.AfterEnd then
  begin
   l_Index := aHeadInner.Obj.PID;
   lp_CheckHeadCells;
  end // if aHeadInner.AfterEnd then
  else
   if aHeadInner.HasInner and not aHeadInner.Inner.AfterEnd then
   begin
    if aHeadInner.AsObject.Owner.IsSame(ParaX.AsObject) then
     l_Index := aHeadInner.Obj.PID
    else
    begin
     aHeadInner.Obj^.AsObject.QT(InevTableCell, l_Cell);
     l_Cell := l_Cell.GetContinueCellInRow(ParaX, fc_Down);
     if l_Cell = nil then Exit;
     l_Index := l_Cell.PID;
    end;
    lp_CheckHeadCells;
   end; // if aHeadInner <> nil then
//#UC END# *4DD7A0E30148_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoAddHeadInner

function TnevTableRowBaseLine4Print.DoHasHeadPart: Boolean;
//#UC START# *4DD7A1010342_4DD77A940374_var*
//#UC END# *4DD7A1010342_4DD77A940374_var*
begin
//#UC START# *4DD7A1010342_4DD77A940374_impl*
 Result := f_HeadCells.Count > 0;
//#UC END# *4DD7A1010342_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoHasHeadPart

function TnevTableRowBaseLine4Print.DoInnerHead(aPID: Integer): InevBasePoint;
//#UC START# *4DD7A1390112_4DD77A940374_var*
//#UC END# *4DD7A1390112_4DD77A940374_var*
begin
//#UC START# *4DD7A1390112_4DD77A940374_impl*
 if (aPID < f_HeadCells.Count) then
  Result := f_HeadCells[aPID]
 else
  Result := nil;
//#UC END# *4DD7A1390112_4DD77A940374_impl*
end;//TnevTableRowBaseLine4Print.DoInnerHead
{$IfEnd} // Defined(evUseVisibleCursors)

end.
