unit F1LikeTextLoad_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Forms"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Daily/Forms/F1LikeTextLoad_Form.pas"
// Начат: 23.09.2010 14:51
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::F1LikeTextLoad
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
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  F1LikeTextLoad_ut_F1LikeTextLoad_UserType,
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
   { F1LikeTextLoadIDs }
  fm_F1LikeTextLoadForm : TvcmFormDescriptor = (rFormID : (rName : 'F1LikeTextLoadForm'; rID : 0); rFactory : nil);
   { Идентификатор формы TF1LikeTextLoadForm }

type
 F1LikeTextLoadFormDef = interface(IUnknown)
  {* Идентификатор формы F1LikeTextLoad }
   ['{FAAC10AB-4EAF-4B43-B184-7BFAADA53CAD}']
 end;//F1LikeTextLoadFormDef

 TF1LikeTextLoadForm = {final form} class(TPrimTextLoadForm, F1LikeTextLoadFormDef)
  Entities : TvcmEntities;
 private
 // private fields
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
 public
 // public properties
   property Text: TeeEditorExport
     read f_Text;
   property TextSource: TeeTextSourceExport
     read f_TextSource;
 end;//TF1LikeTextLoadForm
{$IfEnd} //nsTest AND not NoVCM

implementation

{$R *.DFM}

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
  ,
  F1LikeTextLoadKeywordsPack
  {$IfEnd} //nsTest AND not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //nsTest AND not NoVCM

{$If defined(nsTest) AND not defined(NoVCM)}

var
   { Локализуемые строки ut_F1LikeTextLoadLocalConstants }
  str_ut_F1LikeTextLoadCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_F1LikeTextLoadCaption'; rValue : 'F1LikeTextLoad');
   { Заголовок пользовательского типа "F1LikeTextLoad" }

// start class TF1LikeTextLoadForm

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

procedure TF1LikeTextLoadForm.MakeControls;
begin
 inherited;
 f_Text := TeeEditorExport.Create(Self);
 f_Text.Name := 'Text';
 f_Text.Parent := Self;
 f_TextSource := TeeTextSourceExport.Create(Self);
 f_TextSource.Name := 'TextSource';
 with AddUsertype(ut_F1LikeTextLoadName,
  str_ut_F1LikeTextLoadCaption,
  str_ut_F1LikeTextLoadCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_F1LikeTextLoadName
end;

{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация F1LikeTextLoad
 TtfwClassRef.Register(TF1LikeTextLoadForm);
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Регистрация фабрики формы F1LikeTextLoad
 fm_F1LikeTextLoadForm.SetFactory(TF1LikeTextLoadForm.Make);
{$IfEnd} //nsTest AND not NoVCM
{$If defined(nsTest) AND not defined(NoVCM)}
// Инициализация str_ut_F1LikeTextLoadCaption
 str_ut_F1LikeTextLoadCaption.Init;
{$IfEnd} //nsTest AND not NoVCM

end.