unit TextLoad_Form;
 {* ����� ��� �������� ��������� }

// ������: "w:\common\components\gui\Garant\Daily\Forms\TextLoad_Form.pas"
// ���������: "VCMForm"
// ������� ������: "TextLoad" MUID: (4B30C7E800EE)
// ��� ����: "TTextLoadForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 , evEditor
 , evTextSource
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
;

const
 fm_TextLoadForm: TvcmFormDescriptor = (rFormID : (rName : 'TextLoadForm'; rID : 0); rFactory : nil);
  {* ������������� ����� TTextLoadForm }

type
 TextLoadFormDef = interface
  {* ������������� ����� TextLoad }
  ['{0D52D59A-6EBD-46A6-AA44-2467ABBFDC5C}']
 end;//TextLoadFormDef

 TTextLoadForm = {final} class(TPrimTextLoadForm, TextLoadFormDef)
  {* ����� ��� �������� ��������� }
  private
   f_Text: TevEditor;
    {* ���� ��� �������� Text }
   f_TextSource: TevTextSource;
    {* ���� ��� �������� TextSource }
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
  public
   property Text: TevEditor
    read f_Text;
   property TextSource: TevTextSource
    read f_TextSource;
 end;//TTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmStringIDExHelper
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , TextLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ������������ ������ ut_TextLoadLocalConstants }
 str_ut_TextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TextLoadCaption'; rValue : '����� ��� �������� ���������');
  {* ��������� ����������������� ���� "����� ��� �������� ���������" }

function TTextLoadForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4B30C7E800EEget_var*
//#UC END# *4C9B21D20187_4B30C7E800EEget_var*
begin
//#UC START# *4C9B21D20187_4B30C7E800EEget_impl*
 Result := Self.TextSource;
//#UC END# *4C9B21D20187_4B30C7E800EEget_impl*
end;//TTextLoadForm.pm_GetTextSource

function TTextLoadForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4B30C7E800EEget_var*
//#UC END# *4C9B21E400A4_4B30C7E800EEget_var*
begin
//#UC START# *4C9B21E400A4_4B30C7E800EEget_impl*
 Result := Self.Text;
//#UC END# *4C9B21E400A4_4B30C7E800EEget_impl*
end;//TTextLoadForm.pm_GetText

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TTextLoadForm);
 {* ����������� TextLoad }
{$IfEnd} // NOT Defined(NoScripts)
 fm_TextLoadForm.SetFactory(TTextLoadForm.Make);
 {* ����������� ������� ����� TextLoad }
 str_ut_TextLoadCaption.Init;
 {* ������������� str_ut_TextLoadCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
