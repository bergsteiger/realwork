unit nsAdapterDeferredTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Folders"
// �����: �������� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Folders/nsAdapterDeferredTree.pas"
// �����: 2008/01/14 09:58:48
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 �������� ����������::Folders::Folders::Folders::TnsAdapterDeferredTree
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsDeferredTree,
  l3Tree_TLB
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsAdapterDeferredTree = {abstract} class(TnsDeferredTree)
 protected
 // overridden protected methods
   procedure InitFields; override;
   procedure DoSetBuildedRoot(const aNewRoot: Il3RootNode); override;
 end;//TnsAdapterDeferredTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DataAdapter
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsAdapterDeferredTree

procedure TnsAdapterDeferredTree.InitFields;
//#UC START# *47A042E100E2_4911CFF60035_var*
//#UC END# *47A042E100E2_4911CFF60035_var*
begin
//#UC START# *47A042E100E2_4911CFF60035_impl*
 if Assigned(defDataAdapter) then
  defDataAdapter.RegisterBuildingDefferedTree(Self);
 inherited;
//#UC END# *47A042E100E2_4911CFF60035_impl*
end;//TnsAdapterDeferredTree.InitFields

procedure TnsAdapterDeferredTree.DoSetBuildedRoot(const aNewRoot: Il3RootNode);
//#UC START# *4911C5EC0155_4911CFF60035_var*
//#UC END# *4911C5EC0155_4911CFF60035_var*
begin
//#UC START# *4911C5EC0155_4911CFF60035_impl*
 inherited;
 if Assigned(defDataAdapter) then
  defDataAdapter.RegisterBuildedDefferedTree(Self);
//#UC END# *4911C5EC0155_4911CFF60035_impl*
end;//TnsAdapterDeferredTree.DoSetBuildedRoot

{$IfEnd} //not Admin AND not Monitorings

end.