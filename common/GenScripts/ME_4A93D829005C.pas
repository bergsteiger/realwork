unit Login_Form;
 {* ���� � ������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\Login_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "Login" MUID: (4A93D829005C)
// ��� ����: "TLoginForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimLogin_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_LoginForm: TvcmFormDescriptor = (rFormID : (rName : 'LoginForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TLoginForm }

type
 TLoginForm = class;

 LoginFormDef = interface
  {* ������������� ����� Login }
  ['{96B4FBEB-A42A-4990-BCED-2F439F4E152A}']
 end;//LoginFormDef

 TLoginForm = {final} class(TPrimLoginForm, LoginFormDef)
  {* ���� � ������� ������ }
 end;//TLoginForm

implementation

uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 , Login_ut_Login_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , LoginKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_LoginLocalConstants }
 str_ut_LoginCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_LoginCaption'; rValue : '���� � ������� ������');
  {* ��������� ����������������� ���� "���� � ������� ������" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TLoginForm);
 {* ����������� Login }
{$IfEnd} // NOT Defined(NoScripts)
 fm_LoginForm.SetFactory(TLoginForm.Make);
 {* ����������� ������� ����� Login }
 str_ut_LoginCaption.Init;
 {* ������������� str_ut_LoginCaption }

end.
