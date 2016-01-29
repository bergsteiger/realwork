unit Login_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/PrimCommon/Forms/Login_Form.pas"
// �����: 21.08.2009 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 ������� ����������� ���������� �������::F1 Application Template::View::PrimCommon::PrimCommon::Login
//
// ���� � ������� ������
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
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimLogin_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  Login_ut_Login_UserType,
  vtGroupBox,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  
  {$If defined(Nemesis)}
  ,
  nscComboBoxWithReadOnly
  {$IfEnd} //Nemesis
  
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtFocusLabel,
  vtCheckBox,
  ElPopBtn,
  vtPanel,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;

const
    { LoginIDs }
   fm_LoginForm : TvcmFormDescriptor = (rFormID : (rName : 'LoginForm'; rID : 0); rFactory : nil);
    { ������������� ����� TLoginForm }

type
 LoginFormDef = interface(IUnknown)
  {* ������������� ����� Login }
   ['{96B4FBEB-A42A-4990-BCED-2F439F4E152A}']
 end;//LoginFormDef

  TLoginForm = {final form} class(TPrimLoginForm, LoginFormDef)
   {* ���� � ������� ������ }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TLoginForm

implementation

{$R *.DFM}

uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  LoginKeywordsPack
  {$IfEnd} //not NoScripts
  
  ;

var
    { ������������ ������ ut_LoginLocalConstants }
   str_ut_LoginCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LoginCaption'; rValue : '���� � ������� ������');
    { ��������� ����������������� ���� "���� � ������� ������" }

// start class TLoginForm

procedure TLoginForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_LoginName,
  str_ut_LoginCaption,
  str_ut_LoginCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_LoginName
end;

initialization
{$If not defined(NoScripts)}
// ����������� Login
 TtfwClassRef.Register(TLoginForm);
{$IfEnd} //not NoScripts
// ����������� ������� ����� Login
 fm_LoginForm.SetFactory(TLoginForm.Make);
// ������������� str_ut_LoginCaption
 str_ut_LoginCaption.Init;

end.