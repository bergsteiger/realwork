unit nscTasksPanelOperationNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Nemesis"
// ������: "w:/common/components/gui/Garant/Nemesis/nscTasksPanelOperationNode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Nemesis::TasksPanel::TnscTasksPanelOperationNode
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
  l3Interfaces
  {$If not defined(NoVCM)}
  ,
  vcmTaskPanelInterfaces
  {$IfEnd} //not NoVCM
  ,
  nscTaskPanelInterfaces,
  nscTasksPanelActionLink,
  l3NodesModelPart
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TnscTasksPanelOperationNode = class(Tl3UsualNode, Il3ItemNotifyRecipient, InscOperationNode)
 private
 // private fields
   f_Op : IvcmCustOpsGroupOperation;
    {* ���� ��� �������� Op}
   f_Link : TnscTasksPanelActionLink;
    {* ���� ��� �������� Link}
 protected
 // realized methods
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
     {* ������ ��������. }
   procedure CaptionChanged;
     {* ���������� �������� �������� }
   function pm_GetOp: IvcmCustOpsGroupOperation;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
   procedure ClearFields; override;
     {* ��������� ������ ClearFields }
 public
 // public methods
   constructor Create(const aOp: IvcmCustOpsGroupOperation); reintroduce;
   class function Make(const aOp: IvcmCustOpsGroupOperation): InscOperationNode; reintroduce;
     {* ��������� ������� TnscTasksPanelOperationNode.Make }
 public
 // public properties
   property Op: IvcmCustOpsGroupOperation
     read f_Op
     write f_Op;
   property Link: TnscTasksPanelActionLink
     read f_Link
     write f_Link;
 end;//TnscTasksPanelOperationNode
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  l3Base,
  SysUtils,
  l3Tree_TLB
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}

// start class TnscTasksPanelOperationNode

constructor TnscTasksPanelOperationNode.Create(const aOp: IvcmCustOpsGroupOperation);
//#UC START# *508FE2F30143_508EBDA900AE_var*
//#UC END# *508FE2F30143_508EBDA900AE_var*
begin
//#UC START# *508FE2F30143_508EBDA900AE_impl*
 inherited Create;
 Op := aOp;
 if (Op <> nil) then
  Op.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self));
 CaptionChanged;
//#UC END# *508FE2F30143_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.Create

class function TnscTasksPanelOperationNode.Make(const aOp: IvcmCustOpsGroupOperation): InscOperationNode;
var
 l_Inst : TnscTasksPanelOperationNode;
begin
 l_Inst := Create(aOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TnscTasksPanelOperationNode.Notify(const aNotifier: Il3ChangeNotifier;
  aOperation: Integer;
  aIndex: Integer);
//#UC START# *46A4504B03C4_508EBDA900AE_var*
//#UC END# *46A4504B03C4_508EBDA900AE_var*
begin
//#UC START# *46A4504B03C4_508EBDA900AE_impl*
 case TvcmTaskPanelOperation(aOperation) of
  cvcm_tpOperationRemove:
  begin
   l3Free(f_Link);
    // - �������� ����� � Action, �.�. ��� �������� Action ����� ���������
    //   ���������� � ������ ����� Caption � �.�., � ��������� ��� ����� ������
    //   (CQ: OIT5-26549);
   if (Op <> nil) then
    Op.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
   Remove;
  end;//cvcm_tpOperationRemove
  cvcm_tpOpPosChanged:
  begin
   ParentNode.SortChilds;
   CaptionChanged;
  end;//cvcm_tpOpPosChanged
  cvcm_tpOpCaptionChanged:
   CaptionChanged;
 end;//case aOperation of
//#UC END# *46A4504B03C4_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.Notify

procedure TnscTasksPanelOperationNode.CaptionChanged;
//#UC START# *499C1A5C03B4_508EBDA900AE_var*
//#UC END# *499C1A5C03B4_508EBDA900AE_var*
begin
//#UC START# *499C1A5C03B4_508EBDA900AE_impl*
 {$IfDef nscTasksPanelShowPosition}
  Text := l3PCharLen(vcmCat(vcmCat(Op.Caption, ' ('), IntToStr(Op.Position) + ')'));
 {$Else nscTasksPanelShowPosition}
  Text := Op.Caption.AsWStr;
 {$EndIf nscTasksPanelShowPosition}
//#UC END# *499C1A5C03B4_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.CaptionChanged

function TnscTasksPanelOperationNode.pm_GetOp: IvcmCustOpsGroupOperation;
//#UC START# *499C1AA001FF_508EBDA900AEget_var*
//#UC END# *499C1AA001FF_508EBDA900AEget_var*
begin
//#UC START# *499C1AA001FF_508EBDA900AEget_impl*
 Result := f_Op;
//#UC END# *499C1AA001FF_508EBDA900AEget_impl*
end;//TnscTasksPanelOperationNode.pm_GetOp

procedure TnscTasksPanelOperationNode.Cleanup;
//#UC START# *479731C50290_508EBDA900AE_var*
//#UC END# *479731C50290_508EBDA900AE_var*
begin
//#UC START# *479731C50290_508EBDA900AE_impl*
 if (Op <> nil) then
  Op.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 Op := nil;
 l3Free(f_Link);
 inherited;
//#UC END# *479731C50290_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.Cleanup

procedure TnscTasksPanelOperationNode.ClearFields;
 {-}
begin
 {$If defined(Nemesis)}
 Op := nil;
 {$IfEnd} //Nemesis
 inherited;
end;//TnscTasksPanelOperationNode.ClearFields

{$IfEnd} //Nemesis

end.