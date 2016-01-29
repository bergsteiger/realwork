unit RememberPassword_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/RememberPassword_Form.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Core::Common::View::Common::PrimF1Common::RememberPassword
//
// ������ ������?
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
  PrimRememberPassword_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  RememberPassword_ut_RememberPassword_UserType,
  vtLabel,
  ElPopBtn
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
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
    { RememberPasswordIDs }
   fm_RememberPasswordForm : TvcmFormDescriptor = (rFormID : (rName : 'RememberPasswordForm'; rID : 0); rFactory : nil);
    { ������������� ����� TRememberPasswordForm }

type
 RememberPasswordFormDef = interface(IUnknown)
  {* ������������� ����� RememberPassword }
   ['{332C1743-EA95-4386-9F6E-677BF58FAE7D}']
 end;//RememberPasswordFormDef

  TRememberPasswordForm = {final form} class(TPrimRememberPasswordForm, RememberPasswordFormDef)
   {* ������ ������? }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TRememberPasswordForm
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
  RememberPasswordKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { ������������ ������ ut_RememberPasswordLocalConstants }
   str_ut_RememberPasswordCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_RememberPasswordCaption'; rValue : '������ ������?');
    { ��������� ����������������� ���� "������ ������?" }

// start class TRememberPasswordForm

procedure TRememberPasswordForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_RememberPasswordName,
  str_ut_RememberPasswordCaption,
  str_ut_RememberPasswordCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_RememberPasswordName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� RememberPassword
 TtfwClassRef.Register(TRememberPasswordForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_ut_RememberPasswordCaption
 str_ut_RememberPasswordCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.