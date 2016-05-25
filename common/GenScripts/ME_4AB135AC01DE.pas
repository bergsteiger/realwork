unit TurnOffTimeMachine_Form;
 {* ��������� ������ ������� / �������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\TurnOffTimeMachine_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "TurnOffTimeMachine" MUID: (4AB135AC01DE)
// ��� ����: "Ten_TurnOffTimeMachine"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimTurnOffTimeMachineOptions_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_en_TurnOffTimeMachine: TvcmFormDescriptor = (rFormID : (rName : 'en_TurnOffTimeMachine'; rID : 0); rFactory : nil);
  {* ������������� ����� Ten_TurnOffTimeMachine }

type
 Ten_TurnOffTimeMachine = class;

 TurnOffTimeMachineFormDef = interface
  {* ������������� ����� TurnOffTimeMachine }
  ['{3FDF45B7-4023-4D87-A4CB-A153EBA91B78}']
 end;//TurnOffTimeMachineFormDef

 Ten_TurnOffTimeMachine = {final} class(TPrimTurnOffTimeMachineOptionsForm, TurnOffTimeMachineFormDef)
  {* ��������� ������ ������� / �������� ���� }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//Ten_TurnOffTimeMachine
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , TurnOffTimeMachineKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_TurnOffTimeMachineLocalConstants }
 str_ut_TurnOffTimeMachineCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOffTimeMachineCaption'; rValue : '��������� ������ ������� / �������� ����');
  {* ��������� ����������������� ���� "��������� ������ ������� / �������� ����" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure Ten_TurnOffTimeMachine.MakeControls;
begin
 inherited;
 with AddUsertype(ut_TurnOffTimeMachineName,
  str_ut_TurnOffTimeMachineCaption,
  str_ut_TurnOffTimeMachineCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_TurnOffTimeMachineName
end;//Ten_TurnOffTimeMachine.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_TurnOffTimeMachineCaption.Init;
 {* ������������� str_ut_TurnOffTimeMachineCaption }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(Ten_TurnOffTimeMachine);
 {* ����������� TurnOffTimeMachine }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
