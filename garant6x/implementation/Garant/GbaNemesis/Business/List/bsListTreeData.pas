unit bsListTreeData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/List/bsListTreeData.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Business::ListDataObjects::TbsListTreeData
//
// -
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicDocListUnit,
  DynamicTreeUnit,
  l3TreeInterfaces,
  l3SimpleObject,
  bsInterfaces
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TbsListTreeData = class(Tl3SimpleObject, IbsListTreeData)
  {* - }
 private
 // private fields
   f_List : IDynList;
   f_Root : INodeBase;
   f_Nodes : INodesClipboard;
   f_Node : Il3SimpleNode;
 protected
 // realized methods
   function pm_GetList: IDynList;
   function pm_GetRoot: INodeBase;
   function pm_GetNodes: INodesClipboard;
   function pm_GetNode: Il3SimpleNode;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(const aList: IDynList;
    const aRoot: INodeBase;
    const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aList: IDynList;
    const aRoot: INodeBase;
    const aNode: Il3SimpleNode): IbsListTreeData; reintroduce;
 end;//TbsListTreeData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TbsListTreeData

constructor TbsListTreeData.Create(const aList: IDynList;
  const aRoot: INodeBase;
  const aNode: Il3SimpleNode);
//#UC START# *48F87C29002F_47F4D3AC0029_var*
//#UC END# *48F87C29002F_47F4D3AC0029_var*
begin
//#UC START# *48F87C29002F_47F4D3AC0029_impl*
 inherited Create;
 f_List := aList;
 f_Root := aRoot;
 f_Root.CopyNodes(FM_SELECTION, f_Nodes);
 f_Node := aNode;
//#UC END# *48F87C29002F_47F4D3AC0029_impl*
end;//TbsListTreeData.Create

class function TbsListTreeData.Make(const aList: IDynList;
  const aRoot: INodeBase;
  const aNode: Il3SimpleNode): IbsListTreeData;
var
 l_Inst : TbsListTreeData;
begin
 l_Inst := Create(aList, aRoot, aNode);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TbsListTreeData.pm_GetList: IDynList;
//#UC START# *48F876A900AF_47F4D3AC0029get_var*
//#UC END# *48F876A900AF_47F4D3AC0029get_var*
begin
//#UC START# *48F876A900AF_47F4D3AC0029get_impl*
 Result := f_List;
//#UC END# *48F876A900AF_47F4D3AC0029get_impl*
end;//TbsListTreeData.pm_GetList

function TbsListTreeData.pm_GetRoot: INodeBase;
//#UC START# *48F876C701BD_47F4D3AC0029get_var*
//#UC END# *48F876C701BD_47F4D3AC0029get_var*
begin
//#UC START# *48F876C701BD_47F4D3AC0029get_impl*
 Result := f_Root;
//#UC END# *48F876C701BD_47F4D3AC0029get_impl*
end;//TbsListTreeData.pm_GetRoot

function TbsListTreeData.pm_GetNodes: INodesClipboard;
//#UC START# *48F876DA0247_47F4D3AC0029get_var*
//#UC END# *48F876DA0247_47F4D3AC0029get_var*
begin
//#UC START# *48F876DA0247_47F4D3AC0029get_impl*
 Result := f_Nodes;
//#UC END# *48F876DA0247_47F4D3AC0029get_impl*
end;//TbsListTreeData.pm_GetNodes

function TbsListTreeData.pm_GetNode: Il3SimpleNode;
//#UC START# *48F876F10193_47F4D3AC0029get_var*
//#UC END# *48F876F10193_47F4D3AC0029get_var*
begin
//#UC START# *48F876F10193_47F4D3AC0029get_impl*
 Result := f_Node;
//#UC END# *48F876F10193_47F4D3AC0029get_impl*
end;//TbsListTreeData.pm_GetNode

procedure TbsListTreeData.Cleanup;
//#UC START# *479731C50290_47F4D3AC0029_var*
//#UC END# *479731C50290_47F4D3AC0029_var*
begin
//#UC START# *479731C50290_47F4D3AC0029_impl*
 f_Nodes := nil;
 f_Root := nil;
 f_List := nil;
 inherited;
//#UC END# *479731C50290_47F4D3AC0029_impl*
end;//TbsListTreeData.Cleanup

{$IfEnd} //not Admin AND not Monitorings

end.