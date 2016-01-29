unit nscTasksPanelActionLink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/nscTasksPanelActionLink.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanelActionLink
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmExternalInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ActnList
  {$IfEnd} //not NoVCL
  ,
  nscTaskPanelInterfaces
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
const
 c_ComboOperations = [vcm_otCombo, vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup];

type
 TnscTasksPanelActionLink = class(TActionLink)
 private
 // private fields
   f_Op : Integer;
   f_Tree : TControl;
    {* ���� ��� �������� Tree}
 private
 // private methods
   procedure ValidateCaption(const aValue: AnsiString);
 protected
 // property methods
   function pm_GetOp: InscOperationNode;
 protected
 // overridden protected methods
    {$If not defined(NoVCL)}
   procedure SetCaption(const Value: String); override;
    {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure SetEnabled(Value: Boolean); override;
    {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure SetImageIndex(Value: Integer); override;
    {$IfEnd} //not NoVCL
    {$If not defined(NoVCL)}
   procedure SetVisible(Value: Boolean); override;
    {$IfEnd} //not NoVCL
 public
 // public methods
   constructor Create(const aAction: TBasicAction;
     aTree: TControl;
     const aOp: InscOperationNode); reintroduce;
 protected
 // protected properties
   property Tree: TControl
     read f_Tree;
   property Op: InscOperationNode
     read pm_GetOp;
 end;//TnscTasksPanelActionLink
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  SysUtils
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3Tree_TLB,
  l3String,
  nscTasksPanelView
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTasksPanelActionLink

procedure TnscTasksPanelActionLink.ValidateCaption(const aValue: AnsiString);
//#UC START# *508F9BB7012D_508EBD970342_var*
 function lp_CanChangeCaption(const aOp: IvcmCustOpsGroupOperation): Boolean;
 var
  l_OpDef: IvcmOperationDef;
 begin
  if Supports(Op.Op.RepOp, IvcmOperationDef, l_OpDef) then
  try
   Result := l_OpDef.OperationType in c_ComboOperations + [vcm_otDate];
  finally
   l_OpDef := nil;
  end//try..finally
  else
   Result := False;
 end;//lp_IsComboOperation

var
 l_Node: Il3Node;
//#UC END# *508F9BB7012D_508EBD970342_var*
begin
//#UC START# *508F9BB7012D_508EBD970342_impl*
 // ���� �������� ������������� ��� �������� ��������� � ���������� �������, ��
 // �������� �� ��������:
 if (Op.Op <> nil) and Op.Op.IsDefaultCaption and
  not lp_CanChangeCaption(Op.Op) and Supports(Op, Il3Node, l_Node) then
 try
  l_Node.Text := l3PCharLen(aValue);
  Tree.Invalidate;
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *508F9BB7012D_508EBD970342_impl*
end;//TnscTasksPanelActionLink.ValidateCaption

constructor TnscTasksPanelActionLink.Create(const aAction: TBasicAction;
  aTree: TControl;
  const aOp: InscOperationNode);
//#UC START# *508F9B3C00DE_508EBD970342_var*
//#UC END# *508F9B3C00DE_508EBD970342_var*
begin
//#UC START# *508F9B3C00DE_508EBD970342_impl*
 inherited Create(nil);
 f_Tree := aTree;
 f_Op := Integer(aOp);
 Action := aAction;
 if aAction is TCustomAction then
  ValidateCaption(TCustomAction(aAction).Caption);
//#UC END# *508F9B3C00DE_508EBD970342_impl*
end;//TnscTasksPanelActionLink.Create

function TnscTasksPanelActionLink.pm_GetOp: InscOperationNode;
//#UC START# *508F9BA30314_508EBD970342get_var*
//#UC END# *508F9BA30314_508EBD970342get_var*
begin
//#UC START# *508F9BA30314_508EBD970342get_impl*
 Result := InscOperationNode(f_Op);
//#UC END# *508F9BA30314_508EBD970342get_impl*
end;//TnscTasksPanelActionLink.pm_GetOp

{$If not defined(NoVCL)}
procedure TnscTasksPanelActionLink.SetCaption(const Value: String);
//#UC START# *508F991B003B_508EBD970342_var*
//#UC END# *508F991B003B_508EBD970342_var*
begin
//#UC START# *508F991B003B_508EBD970342_impl*
 inherited;
 ValidateCaption(Value);
//#UC END# *508F991B003B_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetCaption
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TnscTasksPanelActionLink.SetEnabled(Value: Boolean);
//#UC START# *508F99340058_508EBD970342_var*
//#UC END# *508F99340058_508EBD970342_var*
begin
//#UC START# *508F99340058_508EBD970342_impl*
 inherited;
 Tree.Invalidate;
//#UC END# *508F99340058_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetEnabled
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TnscTasksPanelActionLink.SetImageIndex(Value: Integer);
//#UC START# *508F997C0142_508EBD970342_var*
//#UC END# *508F997C0142_508EBD970342_var*
begin
//#UC START# *508F997C0142_508EBD970342_impl*
 inherited;
 Tree.Invalidate;
//#UC END# *508F997C0142_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetImageIndex
{$IfEnd} //not NoVCL

{$If not defined(NoVCL)}
procedure TnscTasksPanelActionLink.SetVisible(Value: Boolean);
//#UC START# *508F99970386_508EBD970342_var*
//#UC END# *508F99970386_508EBD970342_var*
begin
//#UC START# *508F99970386_508EBD970342_impl*
 inherited;
 Tree.Invalidate;
//#UC END# *508F99970386_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetVisible
{$IfEnd} //not NoVCL

{$IfEnd} //Nemesis

end.