unit NOT_FINISHED_evNode;

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_FINISHED_evNode.pas"
// Стереотип: "UtilityPack"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevBase
 , l3Variant
 , l3NodesModelPart
 , l3TreeInterfaces
 , l3Tree_TLB
 , l3Interfaces
 , k2BaseTypes
 , l3Types
;

type
 _k2TagHolder_Parent_ = Tl3PlaceNode;
 {$Include k2TagHolder.imp.pas}
 _k2TagBox_Parent_ = _k2TagHolder_;
 {$Include k2TagBox.imp.pas}
 TevCustomNode = class(_k2TagBox_, Il3HandleNode)
  protected
   function Get_Handle: Integer;
   procedure Set_Handle(aValue: Integer);
   procedure Remove;
    {* удалить узел из дерева. }
   function Get_AllChildrenCount: Integer;
   function Get_NextNode: Il3Node;
   function Get_PrevNode: Il3Node;
   function Get_ParentNode: Il3Node;
   function Get_ChildNode: Il3Node;
 end;//TevCustomNode

function FindNodeByTag(const Parent: InevNode;
 Param: Tl3Tag;
 FindMode: Byte = 0): InevNode;

implementation

uses
 l3ImplUses
 , SysUtils
 , k2NullTagImpl
 , k2Tags
 , k2Base
 , k2InterfaceFactory
;

function FindNodeByTag(const Parent: InevNode;
 Param: Tl3Tag;
 FindMode: Byte = 0): InevNode;
//#UC START# *47F259C00067_47F259A300DA_var*
//#UC END# *47F259C00067_47F259A300DA_var*
begin
//#UC START# *47F259C00067_47F259A300DA_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F259C00067_47F259A300DA_impl*
end;//FindNodeByTag

{$Include k2TagHolder.imp.pas}

type _Instance_R_ = TevCustomNode;

{$Include k2TagBox.imp.pas}

function TevCustomNode.Get_Handle: Integer;
//#UC START# *46827CAF03CD_4A573D87036Dget_var*
//#UC END# *46827CAF03CD_4A573D87036Dget_var*
begin
//#UC START# *46827CAF03CD_4A573D87036Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *46827CAF03CD_4A573D87036Dget_impl*
end;//TevCustomNode.Get_Handle

procedure TevCustomNode.Set_Handle(aValue: Integer);
//#UC START# *46827CAF03CD_4A573D87036Dset_var*
//#UC END# *46827CAF03CD_4A573D87036Dset_var*
begin
//#UC START# *46827CAF03CD_4A573D87036Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *46827CAF03CD_4A573D87036Dset_impl*
end;//TevCustomNode.Set_Handle

procedure TevCustomNode.Remove;
 {* удалить узел из дерева. }
//#UC START# *47710C6002AA_4A573D87036D_var*
//#UC END# *47710C6002AA_4A573D87036D_var*
begin
//#UC START# *47710C6002AA_4A573D87036D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710C6002AA_4A573D87036D_impl*
end;//TevCustomNode.Remove

function TevCustomNode.Get_AllChildrenCount: Integer;
//#UC START# *47710E730361_4A573D87036Dget_var*
//#UC END# *47710E730361_4A573D87036Dget_var*
begin
//#UC START# *47710E730361_4A573D87036Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *47710E730361_4A573D87036Dget_impl*
end;//TevCustomNode.Get_AllChildrenCount

function TevCustomNode.Get_NextNode: Il3Node;
//#UC START# *4771102F01C3_4A573D87036Dget_var*
//#UC END# *4771102F01C3_4A573D87036Dget_var*
begin
//#UC START# *4771102F01C3_4A573D87036Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771102F01C3_4A573D87036Dget_impl*
end;//TevCustomNode.Get_NextNode

function TevCustomNode.Get_PrevNode: Il3Node;
//#UC START# *477110580184_4A573D87036Dget_var*
//#UC END# *477110580184_4A573D87036Dget_var*
begin
//#UC START# *477110580184_4A573D87036Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110580184_4A573D87036Dget_impl*
end;//TevCustomNode.Get_PrevNode

function TevCustomNode.Get_ParentNode: Il3Node;
//#UC START# *4771108100D0_4A573D87036Dget_var*
//#UC END# *4771108100D0_4A573D87036Dget_var*
begin
//#UC START# *4771108100D0_4A573D87036Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4771108100D0_4A573D87036Dget_impl*
end;//TevCustomNode.Get_ParentNode

function TevCustomNode.Get_ChildNode: Il3Node;
//#UC START# *477110A2026C_4A573D87036Dget_var*
//#UC END# *477110A2026C_4A573D87036Dget_var*
begin
//#UC START# *477110A2026C_4A573D87036Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *477110A2026C_4A573D87036Dget_impl*
end;//TevCustomNode.Get_ChildNode

end.
