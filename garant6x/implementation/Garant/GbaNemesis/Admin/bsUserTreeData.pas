unit bsUserTreeData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Admin"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Admin/bsUserTreeData.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Администратор::Admin::Admin::UsersDataObjects::TbsUserTreeData
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin)}
uses
  l3TreeInterfaces,
  l3SimpleObject,
  bsInterfaces
  ;
{$IfEnd} //Admin

{$If defined(Admin)}
type
 TbsUserTreeData = class(Tl3SimpleObject, IbsUserTreeData)
 private
 // private fields
   f_Users : IbsSelectedUsers;
   f_Node : Il3SimpleNode;
 protected
 // realized methods
   function pm_GetNode: Il3SimpleNode;
   function pm_GetUsers: IbsSelectedUsers;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aTree: Il3ExpandedSimpleTree;
    const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aTree: Il3ExpandedSimpleTree;
    const aNode: Il3SimpleNode): IbsUserTreeData; reintroduce;
 end;//TbsUserTreeData
{$IfEnd} //Admin

implementation

{$If defined(Admin)}
uses
  bsSelectedUsers,
  SecurityUnit,
  SysUtils,
  nsTypes,
  DynamicTreeUnit,
  l3Nodes
  ;
{$IfEnd} //Admin

{$If defined(Admin)}

// start class TbsUserTreeData

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
end;

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
//#UC START# *479731C50290_49F592D400E6_var*
//#UC END# *479731C50290_49F592D400E6_var*
begin
//#UC START# *479731C50290_49F592D400E6_impl*
 f_Users := nil;
 f_Node := nil;
 inherited Cleanup;
//#UC END# *479731C50290_49F592D400E6_impl*
end;//TbsUserTreeData.Cleanup

{$IfEnd} //Admin

end.