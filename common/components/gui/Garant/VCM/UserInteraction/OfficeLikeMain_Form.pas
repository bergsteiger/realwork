unit OfficeLikeMain_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "UserInteraction"
// ������: "w:/common/components/gui/Garant/VCM/UserInteraction/OfficeLikeMain_Form.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMMainForm::Class>> Shared Delphi Operations::OfficeLike::UserInteraction::OfficeLike::OfficeLikeMain
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces,
  OfficeLike_Usual_Controls,
  vcmMainForm,
  Classes,
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TOfficeLikeMainForm = {form} class(TvcmMainForm)
 protected
  procedure InitEntities; override;
 protected
 // realized methods
   procedure Common_Exit_Test(const aParams: IvcmTestParamsPrim);
   procedure Common_Exit_Execute(const aParams: IvcmExecuteParamsPrim);
   procedure History_Back_Test(const aParams: IvcmTestParamsPrim);
     {* ����� }
   procedure History_Back_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ����� }
   procedure History_Forward_Test(const aParams: IvcmTestParamsPrim);
     {* ����� }
   procedure History_Forward_Execute(const aParams: IvcmExecuteParamsPrim);
     {* ����� }
 public
 // overridden public methods
   constructor Create(AOwner: TComponent); override;
 protected
 // protected methods
   procedure DoBack(const aParams: IvcmExecuteParamsPrim); virtual;
   procedure DoForward(const aParams: IvcmExecuteParamsPrim); virtual;
   function NeedTerminateOnExit: Boolean; virtual;
   function AskMayExit: Boolean; virtual;
 end;//TOfficeLikeMainForm

 TvcmMainFormRef = TOfficeLikeMainForm;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Windows,
  vcmBaseOperationsCollectionItem,
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  StdRes {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TOfficeLikeMainForm

procedure TOfficeLikeMainForm.DoBack(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDE6B01A6_4ADDD3030251_var*
//#UC END# *4C8DDE6B01A6_4ADDD3030251_var*
begin
//#UC START# *4C8DDE6B01A6_4ADDD3030251_impl*
 Self.History.Back(aParams);
//#UC END# *4C8DDE6B01A6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoBack

procedure TOfficeLikeMainForm.DoForward(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4C8DDEA5007E_4ADDD3030251_var*
//#UC END# *4C8DDEA5007E_4ADDD3030251_var*
begin
//#UC START# *4C8DDEA5007E_4ADDD3030251_impl*
 Self.History.Forward(aParams);
//#UC END# *4C8DDEA5007E_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.DoForward

function TOfficeLikeMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4ADDD3030251_var*
//#UC END# *4ADDD31E0091_4ADDD3030251_var*
begin
//#UC START# *4ADDD31E0091_4ADDD3030251_impl*
 Result := false;
//#UC END# *4ADDD31E0091_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.NeedTerminateOnExit

function TOfficeLikeMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4ADDD3030251_var*
//#UC END# *4ADDD5A30139_4ADDD3030251_var*
begin
//#UC START# *4ADDD5A30139_4ADDD3030251_impl*
 Result := true;
//#UC END# *4ADDD5A30139_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.AskMayExit

procedure TOfficeLikeMainForm.Common_Exit_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4ADDD377028F_4ADDD3030251test_var*
//#UC END# *4ADDD377028F_4ADDD3030251test_var*
begin
//#UC START# *4ADDD377028F_4ADDD3030251test_impl*
 // - ������ �� ������
//#UC END# *4ADDD377028F_4ADDD3030251test_impl*
end;//TOfficeLikeMainForm.Common_Exit_Test

procedure TOfficeLikeMainForm.Common_Exit_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ADDD377028F_4ADDD3030251exec_var*
//#UC END# *4ADDD377028F_4ADDD3030251exec_var*
begin
//#UC START# *4ADDD377028F_4ADDD3030251exec_impl*
 if not NeedTerminateOnExit then
 begin
  if AskMayExit then
   DoExitApplication;
 end//not NeedTerminateOnExit
 else
  TerminateProcess(GetCurrentProcess, 255);
//#UC END# *4ADDD377028F_4ADDD3030251exec_impl*
end;//TOfficeLikeMainForm.Common_Exit_Execute

procedure TOfficeLikeMainForm.History_Back_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4ADDDC550118_4ADDD3030251test_var*
var
 l_History: IvcmHistory;
//#UC END# *4ADDDC550118_4ADDD3030251test_var*
begin
//#UC START# *4ADDDC550118_4ADDD3030251test_impl*
 l_History := Self.History;
 aParams.Op.Flag[vcm_ofEnabled] := l_History.CanBack;
 l_History.GetBackStrings(aParams);
//#UC END# *4ADDDC550118_4ADDD3030251test_impl*
end;//TOfficeLikeMainForm.History_Back_Test

procedure TOfficeLikeMainForm.History_Back_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ADDDC550118_4ADDD3030251exec_var*
//#UC END# *4ADDDC550118_4ADDD3030251exec_var*
begin
//#UC START# *4ADDDC550118_4ADDD3030251exec_impl*
 DoBack(aParams);
//#UC END# *4ADDDC550118_4ADDD3030251exec_impl*
end;//TOfficeLikeMainForm.History_Back_Execute

procedure TOfficeLikeMainForm.History_Forward_Test(const aParams: IvcmTestParamsPrim);
//#UC START# *4ADDDC630097_4ADDD3030251test_var*
var
 l_History: IvcmHistory;
//#UC END# *4ADDDC630097_4ADDD3030251test_var*
begin
//#UC START# *4ADDDC630097_4ADDD3030251test_impl*
 l_History := Self.History;
 aParams.Op.Flag[vcm_ofEnabled] := l_History.CanForward;
 l_History.GetForwardStrings(aParams);
//#UC END# *4ADDDC630097_4ADDD3030251test_impl*
end;//TOfficeLikeMainForm.History_Forward_Test

procedure TOfficeLikeMainForm.History_Forward_Execute(const aParams: IvcmExecuteParamsPrim);
//#UC START# *4ADDDC630097_4ADDD3030251exec_var*
//#UC END# *4ADDDC630097_4ADDD3030251exec_var*
begin
//#UC START# *4ADDDC630097_4ADDD3030251exec_impl*
 DoForward(aParams);
//#UC END# *4ADDDC630097_4ADDD3030251exec_impl*
end;//TOfficeLikeMainForm.History_Forward_Execute

constructor TOfficeLikeMainForm.Create(AOwner: TComponent);
//#UC START# *47D1602000C6_4ADDD3030251_var*
//#UC END# *47D1602000C6_4ADDD3030251_var*
begin
//#UC START# *47D1602000C6_4ADDD3030251_impl*
 // http://mdp.garant.ru/pages/viewpage.action?pageId=470847610
{$If defined(Admin)}
 with dmStdRes.MenuManager.GetItemByName('enHistory') do
 begin
  with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opBack')) do
   Options := Options - [vcm_ooShowInMainMenu, vcm_ooShowInMainToolbar];
  with TvcmBaseOperationsCollectionItem(Operations.FindItemByName('opForward')) do
   Options := Options - [vcm_ooShowInMainMenu, vcm_ooShowInMainToolbar];
 end;
{$IfEnd defined(Admin)}
 inherited;
//#UC END# *47D1602000C6_4ADDD3030251_impl*
end;//TOfficeLikeMainForm.Create

procedure TOfficeLikeMainForm.InitEntities;
begin
 inherited;
 with Entities.Entities do
 begin
  PublishFormEntity(en_Common, nil);
  PublishFormEntity(en_History, nil);
  PublishOp(en_Common, op_Exit, Common_Exit_Execute, Common_Exit_Test, nil);
  PublishOp(en_History, op_Back, History_Back_Execute, History_Back_Test, nil);
  PublishOp(en_History, op_Forward, History_Forward_Execute, History_Forward_Test, nil);
 end;//with Entities.Entities
end;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// ����������� OfficeLikeMain
 TtfwClassRef.Register(TOfficeLikeMainForm);
{$IfEnd} //not NoScripts AND not NoVCM

end.