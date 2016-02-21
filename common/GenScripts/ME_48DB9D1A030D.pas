unit nevTableCellFormatInfo;

// ������: "w:\common\components\gui\Garant\Everest\new\nevTableCellFormatInfo.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevListFormatInfo
 , nevTools
 , nevBase
 , nevFormatInfo
;

type
 _CellFormatInfoCommon_Parent_ = TnevListFormatInfo;
 {$Include w:\common\components\gui\Garant\Everest\new\CellFormatInfoCommon.imp.pas}
 TnevTableCellFormatInfo = class(_CellFormatInfoCommon_)
  private
   f_CellAtTop: InevPara;
   f_CellBottom: InevPara;
   f_HeadCell: InevPara;
  protected
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   function GetIsHidden: Boolean; override;
    {* ������ ������� }
   procedure ClearCache; override;
   function pm_GetlocSpacing: TnevRect; override;
  public
   function GetContinueCellAtTheTop: InevPara;
   function GetContinueCellBoottom: InevPara;
   function GetHeadCell: InevPara;
   procedure wForce(aParts: TnevRenderingInfoParts); override;
   function VerticalAlignmentMargin: Integer; override;
    {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
 end;//TnevTableCellFormatInfo

implementation

uses
 l3ImplUses
 , k2Tags
 , l3MinMax
 , k2Base
 , nevFacade
 , evdTypes
;

{$Include w:\common\components\gui\Garant\Everest\new\CellFormatInfoCommon.imp.pas}

function TnevTableCellFormatInfo.GetContinueCellAtTheTop: InevPara;
//#UC START# *5005119C02DB_48DB9D1A030D_var*
var
 l_TableCell: InevTableCell;
//#UC END# *5005119C02DB_48DB9D1A030D_var*
begin
//#UC START# *5005119C02DB_48DB9D1A030D_impl*
 if f_CellAtTop = nil then
 begin
  Obj.AsObject.QT(InevTableCell, l_TableCell);
  f_CellAtTop := l_TableCell.GetContinueCellPara(True, fc_Up);
  if f_CellAtTop = nil then
   f_CellAtTop := nev.NullPara;
 end; // if f_TopObj = nil then
 Result := f_CellAtTop;
//#UC END# *5005119C02DB_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.GetContinueCellAtTheTop

function TnevTableCellFormatInfo.GetContinueCellBoottom: InevPara;
//#UC START# *5005145503E1_48DB9D1A030D_var*
var
 l_TableCell: InevTableCell;
//#UC END# *5005145503E1_48DB9D1A030D_var*
begin
//#UC START# *5005145503E1_48DB9D1A030D_impl*
 if f_CellBottom = nil then
 begin
  Obj.AsObject.QT(InevTableCell, l_TableCell);
  f_CellBottom := l_TableCell.GetContinueCellPara(True, fc_Down);
  if f_CellBottom = nil then
   f_CellBottom := nev.NullPara;
 end; // if f_CellBottom = nil then
 Result := f_CellBottom;
//#UC END# *5005145503E1_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.GetContinueCellBoottom

function TnevTableCellFormatInfo.GetHeadCell: InevPara;
//#UC START# *50066685035C_48DB9D1A030D_var*
var
 l_TableCell: InevTableCell;
//#UC END# *50066685035C_48DB9D1A030D_var*
begin
//#UC START# *50066685035C_48DB9D1A030D_impl*
 if f_HeadCell = nil then
 begin
  Obj.AsObject.QT(InevTableCell, l_TableCell);
  f_HeadCell := l_TableCell.GetHeadCellPara;
  if (f_HeadCell = nil) then
   f_HeadCell := nev.NullPara;
 end; // if f_CellBottom = nil then
 Result := f_HeadCell;
//#UC END# *50066685035C_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.GetHeadCell

procedure TnevTableCellFormatInfo.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_48DB9D1A030D_var*
//#UC END# *479731C50290_48DB9D1A030D_var*
begin
//#UC START# *479731C50290_48DB9D1A030D_impl*
 f_CellAtTop := nil;
 f_CellBottom := nil;
 f_HeadCell := nil;
 inherited;
//#UC END# *479731C50290_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.Cleanup

procedure TnevTableCellFormatInfo.wForce(aParts: TnevRenderingInfoParts);
//#UC START# *48175C1302A3_48DB9D1A030D_var*
const
 nev_ripChildrenCnahged = [nev_ripWidth, nev_ripHeight];
 nev_ripCellParams = [nev_ripWidth, nev_ripHeight, nev_ripCellParams];
var
 l_Cell : InevTableCell;
 l_PrevCell : InevTableCell;
//#UC END# *48175C1302A3_48DB9D1A030D_var*
begin
//#UC START# *48175C1302A3_48DB9D1A030D_impl*
 inherited;
 if (Obj.OverlapType = otUpper) then
 begin
  if ((aParts = nev_ripChildrenCnahged) or (aParts = nev_ripCellParams) or (aParts = [nev_ripHeight])) then
  begin
   if not Obj.AsObject.QT(InevTableCell, l_Cell) then
    Assert(false);
   l_Cell := l_Cell.GetContinueCell(True, fc_Down);
   if l_Cell <> nil then // ������������ ������ ���� ��� ����������� �� �����������...
   begin
    while l_Cell <> nil do
    begin
     if aParts = nev_ripCellParams then
      l_Cell.Invalidate([nev_spExtent]);
     l_PrevCell := l_Cell;
     l_Cell := l_Cell.GetContinueCell(True, fc_Down);
    end; //while l_Cell <> nil do
    if aParts <> nev_ripCellParams then
     l_PrevCell.Invalidate([nev_spExtent]);
   end; // if l_Cell <> nil then
  end; //if (nev_ripHeight in aParts) and (TevMergeStatus(Obj.IntA[k2_tiMergeStatus]) = ev_msHead) then
 end
 else
  if (aParts = nev_ripCellParams) then
  begin
   if not Obj.AsObject.QT(InevTableCell, l_Cell) then
    Assert(false);
   l_PrevCell := l_Cell;
   l_Cell := l_PrevCell.GetMergeHead(True);
   if (l_Cell <> nil) and not l_Cell.AsObject.IsSame(l_PrevCell.AsObject) then
    l_Cell.Invalidate([nev_spCellExtent]);
  end; // if (Obj.OverlapType = otLower) and (aParts = nev_ripCellParams) then
//#UC END# *48175C1302A3_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.wForce

function TnevTableCellFormatInfo.GetIsHidden: Boolean;
 {* ������ ������� }
//#UC START# *4C0D27380357_48DB9D1A030D_var*
//#UC END# *4C0D27380357_48DB9D1A030D_var*
begin
//#UC START# *4C0D27380357_48DB9D1A030D_impl*
 Result :=
 {$IFDEF Nemesis}
 (Width = 0) OR
 {$ENDIF Nemesis}
 inherited GetIsHidden;
//#UC END# *4C0D27380357_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.GetIsHidden

procedure TnevTableCellFormatInfo.ClearCache;
//#UC START# *4E5E7D240227_48DB9D1A030D_var*
//#UC END# *4E5E7D240227_48DB9D1A030D_var*
begin
//#UC START# *4E5E7D240227_48DB9D1A030D_impl*
 f_CellAtTop := nil;
 f_CellBottom := nil;
 f_HeadCell := nil;
 inherited;
//#UC END# *4E5E7D240227_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.ClearCache

function TnevTableCellFormatInfo.pm_GetlocSpacing: TnevRect;
//#UC START# *4E5F3D1102B8_48DB9D1A030Dget_var*
//#UC END# *4E5F3D1102B8_48DB9D1A030Dget_var*
begin
//#UC START# *4E5F3D1102B8_48DB9D1A030Dget_impl*
 Result := inherited pm_GetLocSpacing;
 Result.Top := Max(Obj.AsObject.IntA[k2_tiSpaceBefore],
                   Tk2Prop(Tk2Type(Obj.AsObject.TagType).Prop[k2_tiSpaceBefore]).DefaultValue);
 Result.Bottom := Max(Obj.AsObject.IntA[k2_tiSpaceAfter],
                      Tk2Prop(Tk2Type(Obj.AsObject.TagType).Prop[k2_tiSpaceAfter]).DefaultValue);
//#UC END# *4E5F3D1102B8_48DB9D1A030Dget_impl*
end;//TnevTableCellFormatInfo.pm_GetlocSpacing

function TnevTableCellFormatInfo.VerticalAlignmentMargin: Integer;
 {* ���������� �������� ��������� �� ������� �������, � ����������� �� ������������� ������������. }
//#UC START# *52021CDE00B2_48DB9D1A030D_var*
//#UC END# *52021CDE00B2_48DB9D1A030D_var*
begin
//#UC START# *52021CDE00B2_48DB9D1A030D_impl*
 Result := GetVerticalAlignmentMargin;
//#UC END# *52021CDE00B2_48DB9D1A030D_impl*
end;//TnevTableCellFormatInfo.VerticalAlignmentMargin

end.
