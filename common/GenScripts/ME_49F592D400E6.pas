unit bsUserTreeData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Admin\bsUserTreeData.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 , l3SimpleObject
 , bsInterfaces
 , l3TreeInterfaces
;

type
 TbsUserTreeData = class(Tl3SimpleObject, IbsUserTreeData)
  private
   f_Users: IbsSelectedUsers;
   f_Node: Il3SimpleNode;
  protected
   function pm_GetNode: Il3SimpleNode;
   function pm_GetUsers: IbsSelectedUsers;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aTree: Il3ExpandedSimpleTree;
    const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aTree: Il3ExpandedSimpleTree;
    const aNode: Il3SimpleNode): IbsUserTreeData; reintroduce;
 end;//TbsUserTreeData
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
 , bsSelectedUsers
 , SecurityUnit
 , SysUtils
 , nsTypes
 , DynamicTreeUnit
 , l3Nodes
;

constructor TbsUserTreeData.Create(const aTree: Il3ExpandedSimpleTree;
 const aNode: Il3SimpleNode);
//#UC START# *49F59364009C_49F592D400E6_var*
 function lpIterator(const aNode: Il3SimpleNode): Boolean;
 var
  l_Node: IProfileNode;
 begin
  if Supports(aNode, IProfileNode, l_Node) then
   f_Users.AddUser(nsCStr(aNode.Text), l_Node.GetUid);
  Result := False;
 end;
//#UC END# *49F59364009C_49F592D400E6_var*
begin
//#UC START# *49F59364009C_49F592D400E6_impl*
 inherited Create;
 f_Node := aNode;
 f_Users := TbsSelectedUsers.Make;
 aTree.FlagIterateF(l3L2SNA(@lpIterator), FM_SELECTION);
//#UC END# *49F59364009C_49F592D400E6_impl*
end;//TbsUserTreeData.Create

class function TbsUserTreeData.Make(const aTree: Il3ExpandedSimpleTree;
 const aNode: Il3SimpleNode): IbsUserTreeData;
var
 l_Inst : TbsUserTreeData;
begin
 l_Inst := Create(aTree, aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsUserTreeData.Make

function TbsUserTreeData.pm_GetNode: Il3SimpleNode;
//#UC START# *49F17C070091_49F592D400E6get_var*
//#UC END# *49F17C070091_49F592D400E6get_var*
begin
//#UC START# *49F17C070091_49F592D400E6get_impl*
 Result := f_Node;
//#UC END# *49F17C070091_49F592D400E6get_impl*
end;//TbsUserTreeData.pm_GetNode

function TbsUserTreeData.pm_GetUsers: IbsSelectedUsers;
//#UC START# *49F1AE1D02A4_49F592D400E6get_var*
//#UC END# *49F1AE1D02A4_49F592D400E6get_var*
begin
//#UC START# *49F1AE1D02A4_49F592D400E6get_impl*
 Result := f_Users;
//#UC END# *49F1AE1D02A4_49F592D400E6get_impl*
end;//TbsUserTreeData.pm_GetUsers

procedure TbsUserTreeData.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_49F592D400E6_var*
//#UC END# *479731C50290_49F592D400E6_var*
begin
//#UC START# *479731C50290_49F592D400E6_impl*
 f_Users := nil;
 f_Node := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49F592D400E6_impl*
end;//TbsUserTreeData.Cleanup
{$IfEnd} // Defined(Admin)

end.
