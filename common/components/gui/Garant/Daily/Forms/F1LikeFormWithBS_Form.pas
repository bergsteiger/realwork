unit F1LikeFormWithBS_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/F1LikeFormWithBS_Form.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::F1LikeFormWithBS
//
// Форма с текстовым редактором с базовым поиском.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  vcmInterfaces
  {$If defined(Nemesis)}
  ,
  eeTextSourceExport
  {$IfEnd} //Nemesis
  ,
  eeEditorExport,
  vcmUserControls,
  l3StringIDEx,
  PrimTextLoad_Form
  {$If defined(Nemesis)}
  ,
  nscTreeComboWithHistoryAndOperations
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType,
  evCustomTextSource,
  evCustomEditor,
  evLoadDocumentManager,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}
const
   { F1LikeFormWithBSIDs }
  fm_F1LikeFormWithBSForm : TvcmFormDescriptor = (rFormID : (rName : 'F1LikeFormWithBSForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TF1LikeFormWithBSForm }

type
 F1LikeFormWithBSFormDef = interface(IUnknown)
  {* Идентификатор формы F1LikeFormWithBS }
   ['{08697FEC-7252-4923-BCAD-60B3AD27EC1F}']
 end;//F1LikeFormWithBSFormDef

 TF1LikeFormWithBSForm = {final form} class(TPrimTextLoadForm, F1LikeFormWithBSFormDef)
  {* Форма с текстовым редактором с базовым поиском. }
  Entities : TvcmEntities;
 private
 // private fields
   f_BaseSearchControl : TnscTreeComboWithHistoryAndOperations;
    {* Поле для свойства BaseSearchControl}
   f_Text : TeeEditorExport;
    {* Поле для свойства Text}
   f_TextSource : TeeTextSourceExport;
    {* Поле для свойства TextSource}
 protected
  procedure MakeControls; override;
 protected
 // realized methods
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
 protected
 // overridden protected methods
   procedure InitControls; override;
     {* Процедура инициализации контролов. Для перекрытия в потомках }
 public
 // public properties
   property BaseSearchControl: TnscTreeComboWithHistoryAndOperations
     read f_BaseSearchControl;
   property Text: TeeEditorExport
     read f_Text;
   property TextSource: TeeTextSourceExport
     read f_TextSource;
 end;//TF1LikeFormWithBSForm
{$IfEnd} //nsTest AND not NoVCM

implementation

{$R *.DFM}

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SysUtils
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  F1LikeFormWithBSKeywordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

var
   { Локализуемые строки ut_F1LikeFormWithBSLocalConstants }
  str_ut_F1LikeFormWithBSCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_F1LikeFormWithBSCaption'; rValue : 'Форма с текстовым редактором с базовым поиском.');
   { Заголовок пользовательского типа "Форма с текстовым редактором с базовым поиском." }

// start class TF1LikeFormWithBSForm

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

procedure TF1LikeFormWithBSForm.MakeControls;
begin
 inherited;
 f_BaseSearchControl := TnscTreeComboWithHistoryAndOperations.Create(Self);
 f_BaseSearchControl.Name := 'BaseSearchControl';
 f_BaseSearchControl.Parent := Self;
 f_Text := TeeEditorExport.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 f_TextSource := TeeTextSourceExport.Create(Self);
 f_TextSource.Name := 'TextSource';
 with AddUsertype(ut_F1LikeFormWithBSName,
  str_ut_F1LikeFormWithBSCaption,
  str_ut_F1LikeFormWithBSCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_F1LikeFormWithBSName
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация F1LikeFormWithBS
 TtfwClassRef.Register(TF1LikeFormWithBSForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Регистрация фабрики формы F1LikeFormWithBS
 fm_F1LikeFormWithBSForm.SetFactory(TF1LikeFormWithBSForm.Make);
{$IfEnd} //nsTest AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Инициализация str_ut_F1LikeFormWithBSCaption
 str_ut_F1LikeFormWithBSCaption.Init;
{$IfEnd} //nsTest AND not NoVCM

end.