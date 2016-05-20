unit NOT_COMPLETED_Main_Form;
 {* �� ���� }

// ������: "w:\MDProcess\NewGen\NOT_COMPLETED_Main_Form.pas"
// ���������: "VCMMainForm"
// ������� ������: "Main" MUID: (4F6AEAE5007B)
// ��� ����: "TMainForm"

{$Include w:\MDProcess\NewGen\ngDefine.inc}

interface

{$If Defined(NewGen)}
uses
 l3IntfUses
 , NewGenMainPrim_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_MainForm: TvcmFormDescriptor = (rFormID : (rName : 'MainForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TMainForm }

type
 TMainForm = class;

 MainFormDef = interface
  {* ������������� ����� Main }
  ['{45D03D24-01B1-4C43-89B5-AF75285241AE}']
 end;//MainFormDef

 TMainForm = {final} class(TNewGenMainPrimForm, MainFormDef)
  {* �� ���� }
   Entities : TvcmEntities;
  protected
   procedure InitFields; override;
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TMainForm
{$IfEnd} // Defined(NewGen)

implementation

{$If Defined(NewGen)}
uses
 l3ImplUses
 , l3StringIDEx
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , Main_ut_Main_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , MainKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_MainLocalConstants }
 str_ut_MainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_MainCaption'; rValue : '�� ����');
  {* ��������� ����������������� ���� "�� ����" }

{$R *.DFM}

procedure TMainForm.InitFields;
//#UC START# *47A042E100E2_4F6AEAE5007B_var*
//#UC END# *47A042E100E2_4F6AEAE5007B_var*
begin
//#UC START# *47A042E100E2_4F6AEAE5007B_impl*
 inherited;
//#UC END# *47A042E100E2_4F6AEAE5007B_impl*
end;//TMainForm.InitFields

{$If NOT Defined(NoVCM)}
procedure TMainForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_MainName,
  str_ut_MainCaption,
  str_ut_MainCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_MainName
end;//TMainForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
 str_ut_MainCaption.Init;
 {* ������������� str_ut_MainCaption }
 fm_MainForm.SetFactory(TMainForm.Make);
 {* ����������� ������� ����� Main }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TMainForm);
 {* ����������� Main }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(NewGen)

end.
