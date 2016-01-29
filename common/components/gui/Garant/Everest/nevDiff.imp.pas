{$IfNDef nevDiff_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/nevDiff.imp.pas"
// �����: 10.04.2009 18:17
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::Everest::Cursors::nevDiff
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define nevDiff_imp}
{$If defined(evUseVisibleCursors)}
 _nevDiff_ = {mixin} class(_nevDiff_Parent_)
 public
 // realized methods
   function Diff(const aView: InevView;
     const aPoint: InevBasePoint;
     aMap: TnevFormatInfoPrim): Integer;
     {* ���������� ������ � "������" �� ���������. }
   function PartiallyVisible(const aView: InevView;
     const aPoint: InevBasePoint;
     const aMap: TnevFormatInfoPrim): Boolean;
     {* ���������� ����� �� ����� "�������� �������" ������������ ������ ����� (aPoint). ������� ��� ����������� ��������� ��������� ������ ������������ �����. }
 protected
 // protected methods
   function DoDiff(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Integer; virtual;
   function DoPartiallyVisible(const aView: InevView;
    const aPoint: InevBasePoint;
    aMap: TnevFormatInfoPrim): Boolean; virtual;
 end;//_nevDiff_
{$Else}

 _nevDiff_ = _nevDiff_Parent_;

{$IfEnd} //evUseVisibleCursors

{$Else nevDiff_imp}

{$If defined(evUseVisibleCursors)}

// start class _nevDiff_

function _nevDiff_.DoDiff(const aView: InevView;
  const aPoint: InevBasePoint;
  aMap: TnevFormatInfoPrim): Integer;
//#UC START# *4AA785540310_49DF54E500B3_var*
var
 l_Inn   : InevBasePoint;
//#UC END# *4AA785540310_49DF54E500B3_var*
begin
//#UC START# *4AA785540310_49DF54E500B3_impl*
 if (aMap = nil) then
  if not ParaX.AsObject.Owner.IsValid then
  // - �������� �������
  begin
   Result := nev_MinusDiff;
   Exit;
  end;//not Obj.Owner.IsValid
 Assert(aMap <> nil);
 if (aPoint = nil) then
  Result := nev_PlusDiff
 else
 begin
  if ParaX.AsObject.IsSame(aPoint.Obj^.AsObject) then
  begin
   if ParaX.IsVertical then
    Result := _Instance_R_(Self).VertPosition(aView, aMap) - aPoint.VertPosition(aView, aMap)
   else
    Result := 0;
   if (Result = 0) then
   begin
    l_Inn := _Instance_R_(Self).pm_GetInner;
    if not aPoint.HasInner or not aPoint.Inner.AsObject.IsValid then
    begin
     if (l_Inn <> nil) then
      Result := nev_PlusDiff;
    end//aPoint.Inner = nil
    else
    if (l_Inn <> nil) then
     Result := l_Inn.Diff(aView, aPoint.Inner, aMap.InfoForChild(l_Inn.Obj^))
    else
     Result := nev_MinusDiff;
   end;//Result = 0
  end//ParaX.IsSame(aPoint.Obj)
  else
   Result := 0;
 end;//aPoint = nil
//#UC END# *4AA785540310_49DF54E500B3_impl*
end;//_nevDiff_.DoDiff

function _nevDiff_.DoPartiallyVisible(const aView: InevView;
  const aPoint: InevBasePoint;
  aMap: TnevFormatInfoPrim): Boolean;
//#UC START# *4BBB10FB015B_49DF54E500B3_var*
//#UC END# *4BBB10FB015B_49DF54E500B3_var*
begin
//#UC START# *4BBB10FB015B_49DF54E500B3_impl*
 Result := False;
//#UC END# *4BBB10FB015B_49DF54E500B3_impl*
end;//_nevDiff_.DoPartiallyVisible

function _nevDiff_.Diff(const aView: InevView;
  const aPoint: InevBasePoint;
  aMap: TnevFormatInfoPrim): Integer;
//#UC START# *49DF51870234_49DF54E500B3_var*
//#UC END# *49DF51870234_49DF54E500B3_var*
begin
//#UC START# *49DF51870234_49DF54E500B3_impl*
 Result := DoDiff(aView, aPoint, aMap);
//#UC END# *49DF51870234_49DF54E500B3_impl*
end;//_nevDiff_.Diff

function _nevDiff_.PartiallyVisible(const aView: InevView;
  const aPoint: InevBasePoint;
  const aMap: TnevFormatInfoPrim): Boolean;
//#UC START# *4BBB0DDD026D_49DF54E500B3_var*
//#UC END# *4BBB0DDD026D_49DF54E500B3_var*
begin
//#UC START# *4BBB0DDD026D_49DF54E500B3_impl*
 Result := DoPartiallyVisible(aView, aPoint, aMap);
//#UC END# *4BBB0DDD026D_49DF54E500B3_impl*
end;//_nevDiff_.PartiallyVisible

{$IfEnd} //evUseVisibleCursors

{$EndIf nevDiff_imp}
