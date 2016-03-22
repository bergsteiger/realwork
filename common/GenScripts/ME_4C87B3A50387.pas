unit PrimSelectedAttributesOptions_Form;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributesOptions_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "PrimSelectedAttributesOptions" MUID: (4C87B3A50387)
// Имя типа: "TPrimSelectedAttributesOptionsForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimSelectedAttributes_Form
 {$If NOT Defined(NoVCM)}
 , OfficeLike_Usual_Controls
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TPrimSelectedAttributesOptionsForm = class(TPrimSelectedAttributesForm)
  public
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
    {* Удалить }
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TPrimSelectedAttributesOptionsForm

implementation

uses
 l3ImplUses
 , l3TreeInterfaces
 , DynamicTreeUnit
 , SysUtils
 , l3Nodes
 , SearchLite_Strange_Controls
 , l3Tree_TLB
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoVCM)}
procedure TPrimSelectedAttributesOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C87B3A50387test_var*
var
 l_Node   : INodeBase;
 l_l3Node : Il3SimpleNode;
//#UC END# *4C7D0CC90052_4C87B3A50387test_var*
begin
//#UC START# *4C7D0CC90052_4C87B3A50387test_impl*
 l_l3Node := SelectedTree.GetCurrentNode;
 try
  if Supports(l_l3Node, INodeBase, l_Node) then
   try
    aParams.Op.Flag[vcm_ofEnabled] := True
   finally
    l_Node := nil;
   end
  else
   aParams.Op.Flag[vcm_ofEnabled] := False;
 finally
  l_l3Node := nil;
 end;
//#UC END# *4C7D0CC90052_4C87B3A50387test_impl*
end;//TPrimSelectedAttributesOptionsForm.Edit_Delete_Test
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure TPrimSelectedAttributesOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
 {* Удалить }
//#UC START# *4C7D0CC90052_4C87B3A50387exec_var*
var
 l_l3Node: Il3Node;
 l_Node: INodeBase;

 function DeleteNode(const aNode: Il3SimpleNode): Boolean;
 var
  l_NodeBase: INodeBase;
 begin
  Result := False;
  if not aNode.HasChild and
     Supports(aNode, INodeBase, l_NodeBase) then
   op_AttributeTree_DropLogicSelection.Call(Aggregate, l_NodeBase);
 end;

//#UC END# *4C7D0CC90052_4C87B3A50387exec_var*
begin
//#UC START# *4C7D0CC90052_4C87B3A50387exec_impl*
 if (SelectedTree.Current >= 0) then
 begin
  l_l3Node := SelectedTree.CurrentCNode;
  if (l_l3Node <> nil) then
  begin
   SelectedTree.Changing;
   try
    if (Aggregate <> nil) and
       Supports(l_l3Node, INodeBase, l_Node) then
    begin
     if l_l3Node.HasChild then
      l_l3Node.IterateF(l3L2NA(@DeleteNode))
     else
      op_AttributeTree_DropLogicSelection.Call(Aggregate, l_Node);
     DeleteElement(l_l3Node, True);
    end;
   finally
    SelectedTree.Changed;
   end;//try..finally
  end;//l_l3Node <> nil
 end;//SelectedTree.Current >= 0
//#UC END# *4C7D0CC90052_4C87B3A50387exec_impl*
end;//TPrimSelectedAttributesOptionsForm.Edit_Delete_Execute
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimSelectedAttributesOptionsForm);
 {* Регистрация PrimSelectedAttributesOptions }
{$IfEnd} // NOT Defined(NoScripts)

end.
