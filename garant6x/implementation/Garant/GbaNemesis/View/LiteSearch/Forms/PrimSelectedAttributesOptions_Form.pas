unit PrimSelectedAttributesOptions_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/LiteSearch/Forms/PrimSelectedAttributesOptions_Form.pas"
// �����: 08.09.2010 20:03
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 ������� ����������� ���������� �������::SearchLite::View::LiteSearch::PrimSelectedAttributesOptions
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Usual_Controls
  {$IfEnd} //not NoVCM
  ,
  PrimSelectedAttributes_Form,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;

type
 TPrimSelectedAttributesOptionsForm = {form} class(TPrimSelectedAttributesForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
     {* ������� }
   {$IfEnd} //not NoVCM
   {$If not defined(NoVCM)}
   procedure Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ������� }
   {$IfEnd} //not NoVCM
 end;//TPrimSelectedAttributesOptionsForm

 TvcmEntityFormRef = TPrimSelectedAttributesOptionsForm;

implementation

uses
  l3TreeInterfaces,
  DynamicTreeUnit,
  SysUtils,
  l3Nodes,
  SearchLite_Strange_Controls,
  l3Tree_TLB
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;

// start class TPrimSelectedAttributesOptionsForm

{$If not defined(NoVCM)}
procedure TPrimSelectedAttributesOptionsForm.Edit_Delete_Test(const aParams: IvcmTestParamsPrim);
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
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
procedure TPrimSelectedAttributesOptionsForm.Edit_Delete_Execute(const aParams: IvcmExecuteParamsPrim);
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
{$IfEnd} //not NoVCM

procedure TPrimSelectedAttributesOptionsForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Edit, nil);
  {$If not defined(NoVCM)}
  PublishOp(en_Edit, op_Delete, Edit_Delete_Execute, Edit_Delete_Test, nil);
  ShowInContextMenu(en_Edit, op_Delete, true);
  ShowInToolbar(en_Edit, op_Delete, true);
  {$IfEnd} //not NoVCM

 end;//with Entities.Entities
end;

initialization
{$If not defined(NoScripts)}
// ����������� PrimSelectedAttributesOptions
 TtfwClassRef.Register(TPrimSelectedAttributesOptionsForm);
{$IfEnd} //not NoScripts

end.