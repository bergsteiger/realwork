unit bsListTreeData;
 {* - }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\List\bsListTreeData.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , bsInterfaces
 , DynamicDocListUnit
 , DynamicTreeUnit
 , l3TreeInterfaces
;

type
 TbsListTreeData = class(Tl3SimpleObject, IbsListTreeData)
  {* - }
  private
   f_List: IDynList;
   f_Root: INodeBase;
   f_Nodes: INodesClipboard;
   f_Node: Il3SimpleNode;
  protected
   function pm_GetList: IDynList;
   function pm_GetRoot: INodeBase;
   function pm_GetNodes: INodesClipboard;
   function pm_GetNode: Il3SimpleNode;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aList: IDynList;
    const aRoot: INodeBase;
    const aNode: Il3SimpleNode); reintroduce;
   class function Make(const aList: IDynList;
    const aRoot: INodeBase;
    const aNode: Il3SimpleNode): IbsListTreeData; reintroduce;
 end;//TbsListTreeData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

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
end;//TbsListTreeData.Make

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
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
