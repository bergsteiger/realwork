unit F1LikeFormWithBS_Form;
 {* Форма с текстовым редактором с базовым поиском. }

// Модуль: "w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_Form.pas"
// Стереотип: "VCMForm"
// Элемент модели: "F1LikeFormWithBS" MUID: (4D6CB4B7035F)
// Имя типа: "TF1LikeFormWithBSForm"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , PrimTextLoad_Form
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations
 {$IfEnd} // Defined(Nemesis)
 , eeEditorExport
 {$If Defined(Nemesis)}
 , eeTextSourceExport
 {$IfEnd} // Defined(Nemesis)
 , evCustomTextSource
 , evCustomEditor
 , vcmInterfaces
;

const
 fm_F1LikeFormWithBSForm: TvcmFormDescriptor = (rFormID : (rName : 'F1LikeFormWithBSForm'; rID : 0); rFactory : nil);
  {* Идентификатор формы TF1LikeFormWithBSForm }

type
 TF1LikeFormWithBSForm = class;

 F1LikeFormWithBSFormDef = interface
  {* Идентификатор формы F1LikeFormWithBS }
  ['{08697FEC-7252-4923-BCAD-60B3AD27EC1F}']
 end;//F1LikeFormWithBSFormDef

 TF1LikeFormWithBSForm = {final} class(TPrimTextLoadForm, F1LikeFormWithBSFormDef)
  {* Форма с текстовым редактором с базовым поиском. }
  private
   f_BaseSearchControl: TnscTreeComboWithHistoryAndOperations;
    {* Поле для свойства BaseSearchControl }
   f_Text: TeeEditorExport;
    {* Поле для свойства Text }
   f_TextSource: TeeTextSourceExport;
    {* Поле для свойства TextSource }
  protected
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
   procedure InitControls; override;
    {* Процедура инициализации контролов. Для перекрытия в потомках }
  public
   property BaseSearchControl: TnscTreeComboWithHistoryAndOperations
    read f_BaseSearchControl;
   property Text: TeeEditorExport
    read f_Text;
   property TextSource: TeeTextSourceExport
    read f_TextSource;
 end;//TF1LikeFormWithBSForm
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
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 , l3MessageID
 {$If NOT Defined(NoScripts)}
 , F1LikeFormWithBSKeywordsPack
 {$IfEnd} // NOT Defined(NoScripts)
 , F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType
;

const
 {* Локализуемые строки ut_F1LikeFormWithBSLocalConstants }
 str_ut_F1LikeFormWithBSCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_F1LikeFormWithBSCaption'; rValue : 'Форма с текстовым редактором с базовым поиском.');
  {* Заголовок пользовательского типа "Форма с текстовым редактором с базовым поиском." }

function TF1LikeFormWithBSForm.pm_GetTextSource: TevCustomTextSource;
//#UC START# *4C9B21D20187_4D6CB4B7035Fget_var*
//#UC END# *4C9B21D20187_4D6CB4B7035Fget_var*
begin
//#UC START# *4C9B21D20187_4D6CB4B7035Fget_impl*
 Result := TextSource;
//#UC END# *4C9B21D20187_4D6CB4B7035Fget_impl*
end;//TF1LikeFormWithBSForm.pm_GetTextSource

function TF1LikeFormWithBSForm.pm_GetText: TevCustomEditor;
//#UC START# *4C9B21E400A4_4D6CB4B7035Fget_var*
//#UC END# *4C9B21E400A4_4D6CB4B7035Fget_var*
begin
//#UC START# *4C9B21E400A4_4D6CB4B7035Fget_impl*
 Result := Text;
//#UC END# *4C9B21E400A4_4D6CB4B7035Fget_impl*
end;//TF1LikeFormWithBSForm.pm_GetText

procedure TF1LikeFormWithBSForm.InitControls;
 {* Процедура инициализации контролов. Для перекрытия в потомках }
//#UC START# *4A8E8F2E0195_4D6CB4B7035F_var*
//#UC END# *4A8E8F2E0195_4D6CB4B7035F_var*
begin
//#UC START# *4A8E8F2E0195_4D6CB4B7035F_impl*
 WindowState := wsMaximized;
 f_BaseSearchControl.Align := alTop;
 Text.Align := alClient;
 f_BaseSearchControl.Visible := False;
 Text.WebStyle := true;
 Text.TextSource := Self.TextSource;
//#UC END# *4A8E8F2E0195_4D6CB4B7035F_impl*
end;//TF1LikeFormWithBSForm.InitControls

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TF1LikeFormWithBSForm);
 {* Регистрация F1LikeFormWithBS }
{$IfEnd} // NOT Defined(NoScripts)
 fm_F1LikeFormWithBSForm.SetFactory(TF1LikeFormWithBSForm.Make);
 {* Регистрация фабрики формы F1LikeFormWithBS }
 str_ut_F1LikeFormWithBSCaption.Init;
 {* Инициализация str_ut_F1LikeFormWithBSCaption }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
