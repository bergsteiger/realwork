unit TurnOnTimeMachine_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/TurnOnTimeMachine_Form.pas"
// �����: 05.02.2009 19:28
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::TurnOnTimeMachine
//
// �������� ������ �������
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
  PrimTurnOnTimeMachineOptions_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  TurnOnTimeMachine_ut_TurnOnTimeMachine_UserType,
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
    { TurnOnTimeMachineIDs }
   fm_en_TurnOnTimeMachine : TvcmFormDescriptor = (rFormID : (rName : 'en_TurnOnTimeMachine'; rID : 0); rFactory : nil);
    { ������������� ����� Ten_TurnOnTimeMachine }

type
 TurnOnTimeMachineFormDef = interface(IUnknown)
  {* ������������� ����� TurnOnTimeMachine }
   ['{A410D5AE-D083-4A07-A820-B7E6DCB07A55}']
 end;//TurnOnTimeMachineFormDef

  Ten_TurnOnTimeMachine = {final form} class(TPrimTurnOnTimeMachineOptionsForm, TurnOnTimeMachineFormDef)
   {* �������� ������ ������� }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//Ten_TurnOnTimeMachine

  TTurnOnTimeMachineForm = Ten_TurnOnTimeMachine;
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
  TurnOnTimeMachineKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { ������������ ������ ut_TurnOnTimeMachineLocalConstants }
   str_ut_TurnOnTimeMachineCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TurnOnTimeMachineCaption'; rValue : '�������� ������ �������');
    { ��������� ����������������� ���� "�������� ������ �������" }

// start class Ten_TurnOnTimeMachine

procedure Ten_TurnOnTimeMachine.MakeControls;
begin
 inherited;
 with AddUsertype(ut_TurnOnTimeMachineName,
  str_ut_TurnOnTimeMachineCaption,
  str_ut_TurnOnTimeMachineCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_TurnOnTimeMachineName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� TurnOnTimeMachine
 TtfwClassRef.Register(Ten_TurnOnTimeMachine);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_TurnOnTimeMachineCaption
 str_ut_TurnOnTimeMachineCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.