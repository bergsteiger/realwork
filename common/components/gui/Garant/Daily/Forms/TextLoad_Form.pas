unit TextLoad_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/TextLoad_Form.pas"
// Начат: 22.12.2009 16:32
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::TextLoad
//
// Форма для загрузки документа
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
  vcmInterfaces,
  evTextSource,
  evEditor,
  vcmUserControls,
  l3StringIDEx,
  PrimTextLoad_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  TextLoad_ut_TextLoad_UserType,
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
   { TextLoadIDs }
  fm_TextLoadForm : TvcmFormDescriptor = (rFormID : (rName : 'TextLoadForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TTextLoadForm }

type
 TextLoadFormDef = interface(IUnknown)
  {* Идентификатор формы TextLoad }
   ['{0D52D59A-6EBD-46A6-AA44-2467ABBFDC5C}']
 end;//TextLoadFormDef

 TTextLoadForm = {final form} class(TPrimTextLoadForm, TextLoadFormDef)
  {* Форма для загрузки документа }
  Entities : TvcmEntities;
 private
 // private fields
   f_Text : TevEditor;
    {* Поле для свойства Text}
   f_TextSource : TevTextSource;
    {* Поле для свойства TextSource}
 protected
  procedure MakeControls; override;
 protected
 // realized methods
   function pm_GetTextSource: TevCustomTextSource; override;
   function pm_GetText: TevCustomEditor; override;
 public
 // public properties
   property Text: TevEditor
     read f_Text;
   property TextSource: TevTextSource
     read f_TextSource;
 end;//TTextLoadForm
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
  ,
  vcmStringIDExHelper
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  TextLoadKeywordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

var
   { Локализуемые строки ut_TextLoadLocalConstants }
  str_ut_TextLoadCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_TextLoadCaption'; rValue : 'Форма для загрузки документа');
   { Заголовок пользовательского типа "Форма для загрузки документа" }

// start class TTextLoadForm

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

procedure TTextLoadForm.MakeControls;
begin
 inherited;
 f_Text := TevEditor.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 f_TextSource := TevTextSource.Create(Self);
 f_TextSource.Name := 'TextSource';
 with AddUsertype(ut_TextLoadName,
  str_ut_TextLoadCaption,
  str_ut_TextLoadCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_TextLoadName
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация TextLoad
 TtfwClassRef.Register(TTextLoadForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Регистрация фабрики формы TextLoad
 fm_TextLoadForm.SetFactory(TTextLoadForm.Make);
{$IfEnd} //nsTest AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Инициализация str_ut_TextLoadCaption
 str_ut_TextLoadCaption.Init;
{$IfEnd} //nsTest AND not NoVCM

end.