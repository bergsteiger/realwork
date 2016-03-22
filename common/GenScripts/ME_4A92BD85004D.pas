unit PrimMain_Form;
 {* ������� �����. ����� ��� ���� ���������� F1 }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimMain_Form.pas"
// ���������: "VCMMainForm"
// ������� ������: "PrimMain" MUID: (4A92BD85004D)
// ��� ����: "TPrimMainForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , MainPrim_Form
 , l3MessageID
 , l3StringIDEx
;

const
 {* ������������ ������ Local }
 str_MayExit: Tl3MessageID = (rS : -1; rLocalized : false; rKey : 'MayExit'; rValue : '�� �������, ��� ������ ������� ������� %s?');
  {* '�� �������, ��� ������ ������� ������� %s?' }
 str_ApplicationName: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ApplicationName'; rValue : '������');
  {* '������' }
 str_MayExit_CheckCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_CheckCaption'; rValue : '������ �������� ��� �������������');
 str_MayExit_SettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_SettingsCaption'; rValue : '����� �� �������');
 str_MayExit_LongHint: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_LongHint'; rValue : '������������� ��� ������ �� �������');

type
 TPrimMainForm = class(TMainPrimForm)
  {* ������� �����. ����� ��� ���� ���������� F1 }
  protected
   {$If NOT Defined(NoVCM)}
   procedure DoInit(aFromHistory: Boolean); override;
    {* ������������� �����. ��� ���������� � �������� }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function NeedTerminateOnExit: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function AskMayExit: Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCL)}
   procedure DoShow; override;
   {$IfEnd} // NOT Defined(NoVCL)
   procedure ActivateDefKeyboardLayout; override;
 end;//TPrimMainForm

implementation

uses
 l3ImplUses
 , DataAdapter
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , F1Like_FormDefinitions_Controls
 , nsCustomStyleProcessor
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* �������� ������ ��� ������� MayExit }
 str_MayExit_Choice_Exit: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_Choice_Exit'; rValue : '�����');
  {* '�����' }
 str_MayExit_Choice_Stay: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'MayExit_Choice_Stay'; rValue : '���������� ������');
  {* '���������� ������' }

{$If NOT Defined(NoVCM)}
procedure TPrimMainForm.DoInit(aFromHistory: Boolean);
 {* ������������� �����. ��� ���������� � �������� }
//#UC START# *49803F5503AA_4A92BD85004D_var*
//#UC END# *49803F5503AA_4A92BD85004D_var*
begin
//#UC START# *49803F5503AA_4A92BD85004D_impl*
 inherited;
//#UC END# *49803F5503AA_4A92BD85004D_impl*
end;//TPrimMainForm.DoInit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMainForm.NeedTerminateOnExit: Boolean;
//#UC START# *4ADDD31E0091_4A92BD85004D_var*
//#UC END# *4ADDD31E0091_4A92BD85004D_var*
begin
//#UC START# *4ADDD31E0091_4A92BD85004D_impl*
 {$IfNDef nsWithoutLogin}
 Result := not defDataAdapter.Authorization.IsServerAlive;
 {$Else   nsWithoutLogin}
 Result := false;
 {$EndIf  nsWithoutLogin}
//#UC END# *4ADDD31E0091_4A92BD85004D_impl*
end;//TPrimMainForm.NeedTerminateOnExit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TPrimMainForm.AskMayExit: Boolean;
//#UC START# *4ADDD5A30139_4A92BD85004D_var*
//#UC END# *4ADDD5A30139_4A92BD85004D_var*
begin
//#UC START# *4ADDD5A30139_4A92BD85004D_impl*
 Result := Ask(str_MayExit, [str_ApplicationName.AsCStr]);
//#UC END# *4ADDD5A30139_4A92BD85004D_impl*
end;//TPrimMainForm.AskMayExit
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCL)}
procedure TPrimMainForm.DoShow;
//#UC START# *4B321D1301DD_4A92BD85004D_var*
//#UC END# *4B321D1301DD_4A92BD85004D_var*
begin
//#UC START# *4B321D1301DD_4A92BD85004D_impl*
 inherited;
//#UC END# *4B321D1301DD_4A92BD85004D_impl*
end;//TPrimMainForm.DoShow
{$IfEnd} // NOT Defined(NoVCL)

procedure TPrimMainForm.ActivateDefKeyboardLayout;
//#UC START# *4F71FA8102BF_4A92BD85004D_var*
//#UC END# *4F71FA8102BF_4A92BD85004D_var*
begin
//#UC START# *4F71FA8102BF_4A92BD85004D_impl*
 inherited;
 defDataAdapter.ActivateDefKeyboardLayout;
//#UC END# *4F71FA8102BF_4A92BD85004D_impl*
end;//TPrimMainForm.ActivateDefKeyboardLayout

initialization
 str_MayExit_Choice_Exit.Init;
 {* ������������� str_MayExit_Choice_Exit }
 str_MayExit_Choice_Stay.Init;
 {* ������������� str_MayExit_Choice_Stay }
 str_MayExit.Init;
!!! Lost Message ini !!!
 {* ������������� str_MayExit }
 str_ApplicationName.Init;
 {* ������������� str_ApplicationName }
 str_MayExit_CheckCaption.Init;
 {* ������������� str_MayExit_CheckCaption }
 str_MayExit_SettingsCaption.Init;
 {* ������������� str_MayExit_SettingsCaption }
 str_MayExit_LongHint.Init;
 {* ������������� str_MayExit_LongHint }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TPrimMainForm);
 {* ����������� PrimMain }
{$IfEnd} // NOT Defined(NoScripts)

end.
