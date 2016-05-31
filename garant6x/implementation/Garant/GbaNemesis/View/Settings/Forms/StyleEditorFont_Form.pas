unit StyleEditorFont_Form;
 {* Параметры шрифта }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\Forms\StyleEditorFont_Form.pas"
// Стереотип: "VCMFinalForm"
// Элемент модели: "StyleEditorFont" MUID: (4ABA143303B0)
// Имя типа: "TStyleEditorFontForm"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , PrimStyleEditorFont_Form
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmEntities
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 fm_StyleEditorFontForm: TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorFontForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TStyleEditorFontForm }

type
 TStyleEditorFontForm = class;

 StyleEditorFontFormDef = interface
  {* Идентификатор формы StyleEditorFont }
  ['{631D935A-F7C1-48C4-ACCC-923697DDB82E}']
 end;//StyleEditorFontFormDef

 TStyleEditorFontForm = {final} class(TPrimStyleEditorFontForm, StyleEditorFontFormDef)
  {* Параметры шрифта }
   Entities : TvcmEntities;
  protected
   {$If NOT Defined(NoVCM)}
   procedure MakeControls; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TStyleEditorFontForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , StyleEditorFont_ut_StyleEditorFont_UserType
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , StyleEditorFontKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

{$R *.DFM}

{$If NOT Defined(NoVCM)}
procedure TStyleEditorFontForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_StyleEditorFontName,
  str_ut_StyleEditorFontCaption,
  str_ut_StyleEditorFontCaption,
  False,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_StyleEditorFontName
end;//TStyleEditorFontForm.MakeControls
{$IfEnd} // NOT Defined(NoVCM)

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorFontForm);
 {* Регистрация StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
