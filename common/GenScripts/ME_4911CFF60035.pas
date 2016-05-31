unit nsAdapterDeferredTree;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Folders\nsAdapterDeferredTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsAdapterDeferredTree" MUID: (4911CFF60035)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsDeferredTree
 , l3Tree_TLB
;

type
 TnsAdapterDeferredTree = {abstract} class(TnsDeferredTree)
  protected
   procedure InitFields; override;
   procedure DoSetBuildedRoot(const aNewRoot: Il3RootNode); override;
 end;//TnsAdapterDeferredTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DataAdapter
;

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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
