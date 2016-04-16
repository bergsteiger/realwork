unit nscTasksPanelActionLink;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelActionLink.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscTasksPanelActionLink" MUID: (508EBD970342)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ActnList
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , nscTaskPanelInterfaces
 , Classes
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TnscTasksPanelActionLink = class({$If NOT Defined(NoVCL)}
 TActionLink
 {$IfEnd} // NOT Defined(NoVCL)
 )
  private
   f_Op: Integer;
   f_Tree: TControl;
  private
   procedure ValidateCaption(const aValue: AnsiString);
  protected
   function pm_GetOp: InscOperationNode;
   {$If NOT Defined(NoVCL)}
   procedure SetCaption(const Value: String); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetEnabled(Value: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetImageIndex(Value: Integer); override;
   {$IfEnd} // NOT Defined(NoVCL)
   {$If NOT Defined(NoVCL)}
   procedure SetVisible(Value: Boolean); override;
   {$IfEnd} // NOT Defined(NoVCL)
  public
   constructor Create(const aAction: TBasicAction;
    aTree: TControl;
    const aOp: InscOperationNode); reintroduce;
  protected
   property Tree: TControl
    read f_Tree;
   property Op: InscOperationNode
    read pm_GetOp;
 end;//TnscTasksPanelActionLink

const
 c_ComboOperations = [vcm_otCombo, vcm_otButtonCombo, vcm_otMenuButtonCombo, vcm_otButtonPopup];
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Tree_TLB
 , l3String
 , nscTasksPanelView
;

{$If NOT Defined(NoVCL)}
function TnscTasksPanelActionLink.pm_GetOp: InscOperationNode;
//#UC START# *508F9BA30314_508EBD970342get_var*
//#UC END# *508F9BA30314_508EBD970342get_var*
begin
//#UC START# *508F9BA30314_508EBD970342get_impl*
 Result := InscOperationNode(f_Op);
//#UC END# *508F9BA30314_508EBD970342get_impl*
end;//TnscTasksPanelActionLink.pm_GetOp

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
 // Если операция переименована или является операцией с выпадающим списком, то
 // название не меняется:
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

procedure TnscTasksPanelActionLink.SetCaption(const Value: String);
//#UC START# *508F991B003B_508EBD970342_var*
//#UC END# *508F991B003B_508EBD970342_var*
begin
//#UC START# *508F991B003B_508EBD970342_impl*
 inherited;
 ValidateCaption(Value);
//#UC END# *508F991B003B_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetCaption

procedure TnscTasksPanelActionLink.SetEnabled(Value: Boolean);
//#UC START# *508F99340058_508EBD970342_var*
//#UC END# *508F99340058_508EBD970342_var*
begin
//#UC START# *508F99340058_508EBD970342_impl*
 inherited;
 Tree.Invalidate;
//#UC END# *508F99340058_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetEnabled

procedure TnscTasksPanelActionLink.SetImageIndex(Value: Integer);
//#UC START# *508F997C0142_508EBD970342_var*
//#UC END# *508F997C0142_508EBD970342_var*
begin
//#UC START# *508F997C0142_508EBD970342_impl*
 inherited;
 Tree.Invalidate;
//#UC END# *508F997C0142_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetImageIndex

procedure TnscTasksPanelActionLink.SetVisible(Value: Boolean);
//#UC START# *508F99970386_508EBD970342_var*
//#UC END# *508F99970386_508EBD970342_var*
begin
//#UC START# *508F99970386_508EBD970342_impl*
 inherited;
 Tree.Invalidate;
//#UC END# *508F99970386_508EBD970342_impl*
end;//TnscTasksPanelActionLink.SetVisible
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // Defined(Nemesis)
end.
