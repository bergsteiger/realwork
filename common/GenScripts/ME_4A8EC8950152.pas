unit ShutDown_Form;
 {* �������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\Forms\ShutDown_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "ShutDown" MUID: (4A8EC8950152)
// ��� ����: "TShutDownForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimShutDown_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_ShutDownForm: TvcmFormDescriptor = (rFormID : (rName : 'ShutDownForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TShutDownForm }

type
 ShutDownFormDef = interface
  {* ������������� ����� ShutDown }
  ['{30C1FF00-6CA8-4565-BDC9-191E8237EFAD}']
 end;//ShutDownFormDef

 TShutDownForm = {final} class(TPrimShutDownForm, ShutDownFormDef)
  {* �������������� }
 end;//TShutDownForm

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ShutDownKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TShutDownForm);
 {* ����������� ShutDown }
{$IfEnd} // NOT Defined(NoScripts)
 fm_ShutDownForm.SetFactory(TShutDownForm.Make);
 {* ����������� ������� ����� ShutDown }

end.
