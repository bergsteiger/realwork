unit TurnOffTimeMachine_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/TurnOffTimeMachine_Form.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Core::Common::View::Common::PrimF1Common::TurnOffTimeMachine
//
// ��������� ������ ������� / �������� ����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimTurnOffTimeMachineOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  TurnOffTimeMachine_ut_TurnOffTimeMachine_UserType,
  vtRadioButton,
  vtDblClickDateEdit
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtLabel,
  vtButton,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
    { TurnOffTimeMachineIDs }
   fm_en_TurnOffTimeMachine : TvcmFormDescriptor = (rFormID : (rName : 'en_TurnOffTimeMachine'; rID : 0); rFactory : nil);
    { ������������� ����� Ten_TurnOffTimeMachine }

type
 TurnOffTimeMachineFormDef = interface(IUnknown)
  {* ������������� ����� TurnOffTimeMachine }
   ['{3FDF45B7-4023-4D87-A4CB-A153EBA91B78}']
 end;//TurnOffTimeMachineFormDef

  Ten_TurnOffTimeMachine = {final form} class(TPrimTurnOffTimeMachineOptionsForm, TurnOffTimeMachineFormDef)
   {* ��������� ������ ������� / �������� ���� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//Ten_TurnOffTimeMachine

  TTurnOffTimeMachineForm = Ten_TurnOffTimeMachine;
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  TurnOffTimeMachineKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { ������������ ������ ut_TurnOffTimeMachineLocalConstants }
   str_ut_TurnOffTimeMachineCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOffTimeMachineCaption'; rValue : '��������� ������ ������� / �������� ����');
    { ��������� ����������������� ���� "��������� ������ ������� / �������� ����" }

// start class Ten_TurnOffTimeMachine

procedure Ten_TurnOffTimeMachine.MakeControls;
begin
 inherited;
 with AddUsertype(ut_TurnOffTimeMachineName,
  str_ut_TurnOffTimeMachineCaption,
  str_ut_TurnOffTimeMachineCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_TurnOffTimeMachineName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� TurnOffTimeMachine
 TtfwClassRef.Register(Ten_TurnOffTimeMachine);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_TurnOffTimeMachineCaption
 str_ut_TurnOffTimeMachineCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.