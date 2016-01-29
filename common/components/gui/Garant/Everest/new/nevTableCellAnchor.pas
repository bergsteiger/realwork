unit nevTableCellAnchor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ������ �.�.
// ������: "w:/common/components/gui/Garant/Everest/new/nevTableCellAnchor.pas"
// �����: 2009/04/28 09:56:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Anchors::TnevTableCellAnchor
//
// ����� ��� ������ �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\new\nevDefine.inc}

interface

{$If defined(k2ForEditor)}
uses
  nevParaListAnchor,
  nevTools
  {$If defined(evUseVisibleCursors)}
  ,
  nevParaListAnchorModifyTypes
  {$IfEnd} //evUseVisibleCursors
  
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}
type
 TnevTableCellAnchor = class(TnevParaListAnchor)
  {* ����� ��� ������ ������� }
 protected
 // overridden property methods
   function pm_GetHasInner: Boolean; override;
 protected
 // overridden protected methods
   {$If defined(evUseVisibleCursors)}
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; override;
   {$IfEnd} //evUseVisibleCursors
   procedure ClearInnerInFire; override;
 end;//TnevTableCellAnchor
{$IfEnd} //k2ForEditor

implementation

{$If defined(k2ForEditor)}
uses
  evdTypes,
  k2Tags
  ;
{$IfEnd} //k2ForEditor

{$If defined(k2ForEditor)}

// start class TnevTableCellAnchor

function TnevTableCellAnchor.pm_GetHasInner: Boolean;
//#UC START# *4A58BA550111_4A5D82380323get_var*
//#UC END# *4A58BA550111_4A5D82380323get_var*
begin
//#UC START# *4A58BA550111_4A5D82380323get_impl*
 Result := TevMergeStatus(IntA[k2_tiMergeStatus]) <> ev_msContinue;
 if Result then
  Result := inherited pm_GetHasInner;
//#UC END# *4A58BA550111_4A5D82380323get_impl*
end;//TnevTableCellAnchor.pm_GetHasInner

{$If defined(evUseVisibleCursors)}
function TnevTableCellAnchor.DoIncLine(const aView: InevView;
  var theLine: Integer;
  aSmall: Boolean;
  const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4A5D82380323_var*
//#UC END# *4B1D18650208_4A5D82380323_var*
begin
//#UC START# *4B1D18650208_4A5D82380323_impl*
 if TevMergeStatus(IntA[k2_tiMergeStatus]) = ev_msContinue then
  Result := 0
 else
  Result := inherited DoIncLine(aView, theLine, aSmall, aChildrenInfo);
//#UC END# *4B1D18650208_4A5D82380323_impl*
end;//TnevTableCellAnchor.DoIncLine
{$IfEnd} //evUseVisibleCursors

procedure TnevTableCellAnchor.ClearInnerInFire;
//#UC START# *55376B1B00F8_4A5D82380323_var*
//#UC END# *55376B1B00F8_4A5D82380323_var*
begin
//#UC START# *55376B1B00F8_4A5D82380323_impl*
 // ��������� �: http://mdp.garant.ru/pages/viewpage.action?pageId=597332678
 // ���� ������������ ������������, �� ����� ������, ��� ��� ������ Inner ����� ������������� ������������, �.�. ������� ����� �� �������.
 // ��� � ����� ����� �����������. � �������� ����� ������������, �.�. ��������� ����������� ���������. 
//#UC END# *55376B1B00F8_4A5D82380323_impl*
end;//TnevTableCellAnchor.ClearInnerInFire

{$IfEnd} //k2ForEditor

end.