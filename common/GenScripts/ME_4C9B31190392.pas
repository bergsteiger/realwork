unit F1LikeTextLoad_Form;

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeTextLoad_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "F1LikeTextLoad" MUID: (4C9B31190392)
// Имя типа: "TF1LikeTextLoadForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 , eeEditorExport
 {$If Defined(Nemesis)}
 , eeTextSourceExport
 {$IfEnd} // Defined(Nemesis)
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
;

const
 fm_F1LikeTextLoadForm: TvcmFormDescriptor = (rFormID : (rName : 'F1LikeTextLoadForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TF1LikeTextLoadForm }

type
 TF1LikeTextLoadForm = class;

 F1LikeTextLoadFormDef = interface
  {* Идентификатор формы F1LikeTextLoad }
  ['{FAAC10AB-4EAF-4B43-B184-7BFAADA53CAD}']
 end;//F1LikeTextLoadFormDef

 TF1LikeTextLoadForm = {final} class(TPrimTextLoadForm, F1LikeTextLoadFormDef)
  private
   f_Text: TeeEditorExport;
    {* Поле для свойства Text }
   f_TextSource: TeeTextSourceExport;
    {* Поле для свойства TextSource }
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
  public
   property Text: TeeEditorExport
    read f_Text;
   property TextSource: TeeTextSourceExport
    read f_TextSource;
 end;//TF1LikeTextLoadForm
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3StringIDEx
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , F1LikeTextLoadKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , F1LikeTextLoad_ut_F1LikeTextLoad_UserType
;

const
 {* Локализуемые строки ut_F1LikeTextLoadLocalConstants }
 str_ut_F1LikeTextLoadCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_F1LikeTextLoadCaption'; rValue : 'F1LikeTextLoad');
  {* Заголовок пользовательского типа "F1LikeTextLoad" }

function TF1LikeTextLoadForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4C9B31190392get_var*
//#UC END# *4C9B21D20187_4C9B31190392get_var*
begin
//#UC START# *4C9B21D20187_4C9B31190392get_impl*
 Result := TextSource;
//#UC END# *4C9B21D20187_4C9B31190392get_impl*
end;//TF1LikeTextLoadForm.pm_GetTextSource

function TF1LikeTextLoadForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4C9B31190392get_var*
//#UC END# *4C9B21E400A4_4C9B31190392get_var*
begin
//#UC START# *4C9B21E400A4_4C9B31190392get_impl*
 Result := Text;
//#UC END# *4C9B21E400A4_4C9B31190392get_impl*
end;//TF1LikeTextLoadForm.pm_GetText

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TF1LikeTextLoadForm);
 {* Регистрация F1LikeTextLoad }
{$IfEnd} // NOT Defined(NoScripts)
 fm_F1LikeTextLoadForm.SetFactory(TF1LikeTextLoadForm.Make);
 {* Регистрация фабрики формы F1LikeTextLoad }
 str_ut_F1LikeTextLoadCaption.Init;
 {* Инициализация str_ut_F1LikeTextLoadCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
