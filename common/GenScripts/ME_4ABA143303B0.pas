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
 end;//TStyleEditorFontForm
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , StyleEditorFontKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Локализуемые строки ut_StyleEditorFontLocalConstants }
 str_ut_StyleEditorFontCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StyleEditorFontCaption'; rValue : 'Параметры шрифта');
  {* Заголовок пользовательского типа "Параметры шрифта" }

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TStyleEditorFontForm);
 {* Регистрация StyleEditorFont }
{$IfEnd} // NOT Defined(NoScripts)
 str_ut_StyleEditorFontCaption.Init;
 {* Инициализация str_ut_StyleEditorFontCaption }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
