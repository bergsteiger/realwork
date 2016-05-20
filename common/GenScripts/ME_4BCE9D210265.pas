unit elCustomEdit_Form;
 {* ����� ��� ������������ TelCustomEdit }

// ������: "w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_Form.pas"
// ���������: "VCMForm"
// ������� ������: "elCustomEdit" MUID: (4BCE9D210265)
// ��� ����: "TelCustomEditForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , vcmInterfaces
 , vcmEntities
 , elCustomEdit
;

const
 fm_elCustomEditForm: TvcmFormDescriptor = (rFormID : (rName : 'elCustomEditForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TelCustomEditForm }

type
 TelCustomEditForm = class;

 elCustomEditFormDef = interface
  {* ������������� ����� elCustomEdit }
  ['{83F3F220-AFBC-45DC-8C59-16D7972E06BB}']
 end;//elCustomEditFormDef

 TelCustomEditForm = {final} class(TvcmEntityForm, elCustomEditFormDef)
  {* ����� ��� ������������ TelCustomEdit }
   Entities : TvcmEntities;
  private
   f_Edit: TelCustomEdit;
  protected
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
   procedure MakeControls; override;
  public
   property Edit: TelCustomEdit
    read f_Edit;
 end;//TelCustomEditForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , elCustomEdit_ut_elCustomEdit_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , elCustomEditKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

const
 {* ������������ ������ ut_elCustomEditLocalConstants }
 str_ut_elCustomEditCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_elCustomEditCaption'; rValue : '����� ��� ������������ TelCustomEdit');
  {* ��������� ����������������� ���� "����� ��� ������������ TelCustomEdit" }

{$R *.DFM}

procedure TelCustomEditForm.InitControls;
 {* ��������� ������������� ���������. ��� ���������� � �������� }
//#UC START# *4A8E8F2E0195_4BCE9D210265_var*
//#UC END# *4A8E8F2E0195_4BCE9D210265_var*
begin
//#UC START# *4A8E8F2E0195_4BCE9D210265_impl*
 inherited;
 WindowState := wsMaximized;
 Edit.Left := 0;
 Edit.Top := 0;
//#UC END# *4A8E8F2E0195_4BCE9D210265_impl*
end;//TelCustomEditForm.InitControls

procedure TelCustomEditForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_elCustomEditName,
  str_ut_elCustomEditCaption,
  str_ut_elCustomEditCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_elCustomEditName
 f_Edit := TelCustomEdit.Create(Self);
 f_Edit.Name := 'Edit';
end;//TelCustomEditForm.MakeControls

initialization
 str_ut_elCustomEditCaption.Init;
 {* ������������� str_ut_elCustomEditCaption }
 fm_elCustomEditForm.SetFactory(TelCustomEditForm.Make);
 {* ����������� ������� ����� elCustomEdit }
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TelCustomEditForm);
 {* ����������� elCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
