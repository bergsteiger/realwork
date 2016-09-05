unit NOT_FINISHED_eeVirtualNode;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eeVirtualNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TeeVirtualNode" MUID: (4ADDF343009C)

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

uses
 l3IntfUses
 , l3VirtualNode
 , eeInterfaces
 , l3Interfaces
;

type
 TeeVirtualNode = class(Tl3VirtualFlagsNode, IeeNode)
  protected
   function Get_Text: Il3CString;
   procedure Set_Text(const aValue: Il3CString);
   function Get_ID: Integer;
   procedure Set_ID(aValue: Integer);
   function Get_HasChild: Boolean;
   function Get_ChildNode: IeeNode;
   function Get_ParentNode: IeeNode;
   function Get_NextNode: IeeNode;
   function Get_PrevNode: IeeNode;
   function Get_AllChildrenCount: Integer;
   function Get_ThisChildrenCount: Integer;
   function InsertChild(const aNode: IeeNode): IeeNode;
   function InsertChildBefore(const aNextChild: IeeNode;
    const aChild: IeeNode): IeeNode;
   procedure Changing;
   procedure Changed;
   procedure Remove;
   procedure Delete;
   procedure RemoveChildren;
   function Move(aDirection: TeeDirection): Boolean;
   procedure RelocateChild(const aChild: IeeNode);
    {* перемещает указанного ребенка, руководствуясь критериями сортировки относительно других детей (в пределах одного уровня) }
   procedure SortChilds;
   function GetLevelForParent(const aParent: IeeNode): Integer;
    {* Рассчитывает уровень текущей ноды относительно заданного Paretnt'а }
   function Iterate(anAction: TeeNodeAction;
    anIterMode: Integer = 0;
    const aFromNode: IeeNode = nil): IeeNode;
    {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
   function IterateF(anAction: TeeNodeAction;
    anIterMode: Integer = 0;
    const aFromNode: IeeNode = nil): IeeNode;
    {* перебрать все дочерние узлы и освободить заглушку для Action }
   function IsSameNode(const aNode: IeeNode): Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
 end;//TeeVirtualNode

implementation

uses
 l3ImplUses
 , eeNodeUtils
 , SysUtils
 , eeNode
 //#UC START# *4ADDF343009Cimpl_uses*
 //#UC END# *4ADDF343009Cimpl_uses*
;

function TeeVirtualNode.Get_Text: Il3CString;
//#UC START# *5481A1AD011A_4ADDF343009Cget_var*
//#UC END# *5481A1AD011A_4ADDF343009Cget_var*
begin
//#UC START# *5481A1AD011A_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1AD011A_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_Text

procedure TeeVirtualNode.Set_Text(const aValue: Il3CString);
//#UC START# *5481A1AD011A_4ADDF343009Cset_var*
//#UC END# *5481A1AD011A_4ADDF343009Cset_var*
begin
//#UC START# *5481A1AD011A_4ADDF343009Cset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1AD011A_4ADDF343009Cset_impl*
end;//TeeVirtualNode.Set_Text

function TeeVirtualNode.Get_ID: Integer;
//#UC START# *5481A1C0038D_4ADDF343009Cget_var*
//#UC END# *5481A1C0038D_4ADDF343009Cget_var*
begin
//#UC START# *5481A1C0038D_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1C0038D_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_ID

procedure TeeVirtualNode.Set_ID(aValue: Integer);
//#UC START# *5481A1C0038D_4ADDF343009Cset_var*
//#UC END# *5481A1C0038D_4ADDF343009Cset_var*
begin
//#UC START# *5481A1C0038D_4ADDF343009Cset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1C0038D_4ADDF343009Cset_impl*
end;//TeeVirtualNode.Set_ID

function TeeVirtualNode.Get_HasChild: Boolean;
//#UC START# *5481A1D103AF_4ADDF343009Cget_var*
//#UC END# *5481A1D103AF_4ADDF343009Cget_var*
begin
//#UC START# *5481A1D103AF_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1D103AF_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_HasChild

function TeeVirtualNode.Get_ChildNode: IeeNode;
//#UC START# *5481A22C010D_4ADDF343009Cget_var*
//#UC END# *5481A22C010D_4ADDF343009Cget_var*
begin
//#UC START# *5481A22C010D_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A22C010D_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_ChildNode

function TeeVirtualNode.Get_ParentNode: IeeNode;
//#UC START# *5481A2410045_4ADDF343009Cget_var*
//#UC END# *5481A2410045_4ADDF343009Cget_var*
begin
//#UC START# *5481A2410045_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2410045_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_ParentNode

function TeeVirtualNode.Get_NextNode: IeeNode;
//#UC START# *5481A2510256_4ADDF343009Cget_var*
//#UC END# *5481A2510256_4ADDF343009Cget_var*
begin
//#UC START# *5481A2510256_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2510256_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_NextNode

function TeeVirtualNode.Get_PrevNode: IeeNode;
//#UC START# *5481A26001CF_4ADDF343009Cget_var*
//#UC END# *5481A26001CF_4ADDF343009Cget_var*
begin
//#UC START# *5481A26001CF_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A26001CF_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_PrevNode

function TeeVirtualNode.Get_AllChildrenCount: Integer;
//#UC START# *5481A29002A5_4ADDF343009Cget_var*
//#UC END# *5481A29002A5_4ADDF343009Cget_var*
begin
//#UC START# *5481A29002A5_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A29002A5_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_AllChildrenCount

function TeeVirtualNode.Get_ThisChildrenCount: Integer;
//#UC START# *5481A2990264_4ADDF343009Cget_var*
//#UC END# *5481A2990264_4ADDF343009Cget_var*
begin
//#UC START# *5481A2990264_4ADDF343009Cget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2990264_4ADDF343009Cget_impl*
end;//TeeVirtualNode.Get_ThisChildrenCount

function TeeVirtualNode.InsertChild(const aNode: IeeNode): IeeNode;
//#UC START# *5481A2AF0022_4ADDF343009C_var*
//#UC END# *5481A2AF0022_4ADDF343009C_var*
begin
//#UC START# *5481A2AF0022_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2AF0022_4ADDF343009C_impl*
end;//TeeVirtualNode.InsertChild

function TeeVirtualNode.InsertChildBefore(const aNextChild: IeeNode;
 const aChild: IeeNode): IeeNode;
//#UC START# *5481A2C20167_4ADDF343009C_var*
//#UC END# *5481A2C20167_4ADDF343009C_var*
begin
//#UC START# *5481A2C20167_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2C20167_4ADDF343009C_impl*
end;//TeeVirtualNode.InsertChildBefore

procedure TeeVirtualNode.Changing;
//#UC START# *5481A2D702C7_4ADDF343009C_var*
//#UC END# *5481A2D702C7_4ADDF343009C_var*
begin
//#UC START# *5481A2D702C7_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2D702C7_4ADDF343009C_impl*
end;//TeeVirtualNode.Changing

procedure TeeVirtualNode.Changed;
//#UC START# *5481A2DF0031_4ADDF343009C_var*
//#UC END# *5481A2DF0031_4ADDF343009C_var*
begin
//#UC START# *5481A2DF0031_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2DF0031_4ADDF343009C_impl*
end;//TeeVirtualNode.Changed

procedure TeeVirtualNode.Remove;
//#UC START# *5481A2E8004B_4ADDF343009C_var*
//#UC END# *5481A2E8004B_4ADDF343009C_var*
begin
//#UC START# *5481A2E8004B_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2E8004B_4ADDF343009C_impl*
end;//TeeVirtualNode.Remove

procedure TeeVirtualNode.Delete;
//#UC START# *5481A2F3014C_4ADDF343009C_var*
//#UC END# *5481A2F3014C_4ADDF343009C_var*
begin
//#UC START# *5481A2F3014C_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2F3014C_4ADDF343009C_impl*
end;//TeeVirtualNode.Delete

procedure TeeVirtualNode.RemoveChildren;
//#UC START# *5481A2FC0099_4ADDF343009C_var*
//#UC END# *5481A2FC0099_4ADDF343009C_var*
begin
//#UC START# *5481A2FC0099_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A2FC0099_4ADDF343009C_impl*
end;//TeeVirtualNode.RemoveChildren

function TeeVirtualNode.Move(aDirection: TeeDirection): Boolean;
//#UC START# *5481A30602F5_4ADDF343009C_var*
//#UC END# *5481A30602F5_4ADDF343009C_var*
begin
//#UC START# *5481A30602F5_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A30602F5_4ADDF343009C_impl*
end;//TeeVirtualNode.Move

procedure TeeVirtualNode.RelocateChild(const aChild: IeeNode);
 {* перемещает указанного ребенка, руководствуясь критериями сортировки относительно других детей (в пределах одного уровня) }
//#UC START# *5481A3190230_4ADDF343009C_var*
//#UC END# *5481A3190230_4ADDF343009C_var*
begin
//#UC START# *5481A3190230_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A3190230_4ADDF343009C_impl*
end;//TeeVirtualNode.RelocateChild

procedure TeeVirtualNode.SortChilds;
//#UC START# *5481A34602C4_4ADDF343009C_var*
//#UC END# *5481A34602C4_4ADDF343009C_var*
begin
//#UC START# *5481A34602C4_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A34602C4_4ADDF343009C_impl*
end;//TeeVirtualNode.SortChilds

function TeeVirtualNode.GetLevelForParent(const aParent: IeeNode): Integer;
 {* Рассчитывает уровень текущей ноды относительно заданного Paretnt'а }
//#UC START# *5481A3590043_4ADDF343009C_var*
//#UC END# *5481A3590043_4ADDF343009C_var*
begin
//#UC START# *5481A3590043_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A3590043_4ADDF343009C_impl*
end;//TeeVirtualNode.GetLevelForParent

function TeeVirtualNode.Iterate(anAction: TeeNodeAction;
 anIterMode: Integer = 0;
 const aFromNode: IeeNode = nil): IeeNode;
 {* перебрать все дочерние узлы. IterMode см. imExpandOnly etc. }
//#UC START# *5481A3900306_4ADDF343009C_var*
//#UC END# *5481A3900306_4ADDF343009C_var*
begin
//#UC START# *5481A3900306_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A3900306_4ADDF343009C_impl*
end;//TeeVirtualNode.Iterate

function TeeVirtualNode.IterateF(anAction: TeeNodeAction;
 anIterMode: Integer = 0;
 const aFromNode: IeeNode = nil): IeeNode;
 {* перебрать все дочерние узлы и освободить заглушку для Action }
//#UC START# *5481A3D0039F_4ADDF343009C_var*
//#UC END# *5481A3D0039F_4ADDF343009C_var*
begin
//#UC START# *5481A3D0039F_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A3D0039F_4ADDF343009C_impl*
end;//TeeVirtualNode.IterateF

function TeeVirtualNode.IsSameNode(const aNode: IeeNode): Boolean;
//#UC START# *5481B02B03C1_4ADDF343009C_var*
//#UC END# *5481B02B03C1_4ADDF343009C_var*
begin
//#UC START# *5481B02B03C1_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481B02B03C1_4ADDF343009C_impl*
end;//TeeVirtualNode.IsSameNode

procedure TeeVirtualNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADDF343009C_var*
//#UC END# *479731C50290_4ADDF343009C_var*
begin
//#UC START# *479731C50290_4ADDF343009C_impl*
 !!! Needs to be implemented !!!
//#UC END# *479731C50290_4ADDF343009C_impl*
end;//TeeVirtualNode.Cleanup

end.
