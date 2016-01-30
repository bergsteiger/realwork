unit elCustomEdit_Form;
 {* ����� ��� ������������ TelCustomEdit }

// ������: "w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_Form.pas"
// ���������: "VCMForm"

{$Include sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmEntityForm
 , elCustomEdit
 , l3StringIDEx
 , vcmInterfaces
;

const
 fm_elCustomEditForm: TvcmFormDescriptor = (rFormID : (rName : 'elCustomEditForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TelCustomEditForm }

type
 elCustomEditFormDef = interface
  {* ������������� ����� elCustomEdit }
  ['{83F3F220-AFBC-45DC-8C59-16D7972E06BB}']
 end;//elCustomEditFormDef

 TelCustomEditForm = {final} class(TvcmEntityForm, elCustomEditFormDef)
  {* ����� ��� ������������ TelCustomEdit }
  private
   f_Edit: TelCustomEdit;
    {* ���� ��� �������� Edit }
  protected
   procedure InitControls; override;
    {* ��������� ������������� ���������. ��� ���������� � �������� }
  public
   property Edit: TelCustomEdit
    read f_Edit;
 end;//TelCustomEditForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , elCustomEditKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_elCustomEditLocalConstants }
 str_ut_elCustomEditCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_elCustomEditCaption'; rValue : '����� ��� ������������ TelCustomEdit');
  {* ��������� ����������������� ���� "����� ��� ������������ TelCustomEdit" }

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

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TelCustomEditForm);
 {* ����������� elCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
 fm_elCustomEditForm.SetFactory(TelCustomEditForm.Make);
 {* ����������� ������� ����� elCustomEdit }
 str_ut_elCustomEditCaption.Init;
 {* ������������� str_ut_elCustomEditCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
