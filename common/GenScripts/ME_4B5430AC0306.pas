unit SelfInfo_Form;
 {* ��������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\SelfInfo_Form.pas"
// ���������: "VCMFinalForm"
// ������� ������: "SelfInfo" MUID: (4B5430AC0306)
// ��� ����: "TSelfInfoForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimSelfInfo_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_SelfInfoForm: TvcmFormDescriptor = (rFormID : (rName : 'SelfInfoForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TSelfInfoForm }

type
 TSelfInfoForm = class;

 SelfInfoFormDef = interface
  {* ������������� ����� SelfInfo }
  ['{58609172-F191-4A45-BABF-5983A3CBE791}']
 end;//SelfInfoFormDef

 TSelfInfoForm = {final} class(TPrimSelfInfoForm, SelfInfoFormDef)
  {* ��������������� ������ }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TSelfInfoForm
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
 , SelfInfo_ut_SelfInfo_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , SelfInfoKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_SelfInfoLocalConstants }
 str_ut_SelfInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_SelfInfoCaption'; rValue : '��������������� ������');
  {* ��������� ����������������� ���� "��������������� ������" }

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TSelfInfoForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_SelfInfoName,
  str_ut_SelfInfoCaption,
  str_ut_SelfInfoCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_SelfInfoName
end;//TSelfInfoForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_SelfInfoCaption.Init;
 {* ������������� str_ut_SelfInfoCaption }
 fm_SelfInfoForm.SetFactory(TSelfInfoForm.Make);
 {* ����������� ������� ����� SelfInfo }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TSelfInfoForm);
 {* ����������� SelfInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
