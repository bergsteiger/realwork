unit vcmUserInteractiveForm;

// ������: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.pas"
// ���������: "SimpleClass"
// ������� ������: "TvcmUserInteractiveForm" MUID: (4E01D585033A)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3Forms
 , vcmGUI
 , vcmExternalInterfaces
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 , l3ProtoObject
 {$If NOT Defined(NoVCL)}
 , l3CloseFormHelper
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 TvcmCloseFormHelper = {final} class(Tl3ProtoObject{$If NOT Defined(NoVCL)}
 , Il3CloseFormHelper
 {$IfEnd} // NOT Defined(NoVCL)
 )
  public
   {$If NOT Defined(NoVCL)}
   function Close(aControl: TWinControl): Boolean;
   {$IfEnd} // NOT Defined(NoVCL)
   class function Instance: TvcmCloseFormHelper;
    {* ����� ��������� ���������� ���������� TvcmCloseFormHelper }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TvcmCloseFormHelper

 _vcmUserInteractiveForm_Parent_ = Tl3Form;
 {$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.imp.pas}
 TvcmUserInteractiveForm = class(_vcmUserInteractiveForm_)
 end;//TvcmUserInteractiveForm
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVGScene)}
 , vcmDialogs
 {$IfEnd} // NOT Defined(NoVGScene)
 , vcmMessagesSupport
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , vcmForm
 , SysUtils
 , l3Base
;

var g_TvcmCloseFormHelper: TvcmCloseFormHelper = nil;
 {* ��������� ���������� TvcmCloseFormHelper }

procedure TvcmCloseFormHelperFree;
 {* ����� ������������ ���������� ���������� TvcmCloseFormHelper }
begin
 l3Free(g_TvcmCloseFormHelper);
end;//TvcmCloseFormHelperFree

{$If NOT Defined(NoVCL)}
function TvcmCloseFormHelper.Close(aControl: TWinControl): Boolean;
//#UC START# *A1E64DB467E3_55015117004B_var*
//#UC END# *A1E64DB467E3_55015117004B_var*
begin
//#UC START# *A1E64DB467E3_55015117004B_impl*
 if (aControl Is TvcmInterfacedForm) then
 begin
  TvcmInterfacedForm(aControl).SafeClose;
  Result := true;
 end//aControl Is TvcmInterfacedForm
 else
  Result := false;
//#UC END# *A1E64DB467E3_55015117004B_impl*
end;//TvcmCloseFormHelper.Close
{$IfEnd} // NOT Defined(NoVCL)

class function TvcmCloseFormHelper.Instance: TvcmCloseFormHelper;
 {* ����� ��������� ���������� ���������� TvcmCloseFormHelper }
begin
 if (g_TvcmCloseFormHelper = nil) then
 begin
  l3System.AddExitProc(TvcmCloseFormHelperFree);
  g_TvcmCloseFormHelper := Create;
 end;
 Result := g_TvcmCloseFormHelper;
end;//TvcmCloseFormHelper.Instance

class function TvcmCloseFormHelper.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvcmCloseFormHelper <> nil;
end;//TvcmCloseFormHelper.Exists

{$Include w:\common\components\gui\Garant\VCM\implementation\Visual\vcmUserInteractiveForm.imp.pas}

initialization
{$If NOT Defined(NoVCL)}
 Tl3CloseFormHelper.Instance.Alien := TvcmCloseFormHelper.Instance;
{$IfEnd} // NOT Defined(NoVCL)
 {* ����������� TvcmCloseFormHelper }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvcmUserInteractiveForm);
 {* ����������� TvcmUserInteractiveForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCM)

end.
