unit StyleEditorFont_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/StyleEditorFont_Form.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorFont
//
// Параметры шрифта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimStyleEditorFont_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  StyleEditorFont_ut_StyleEditorFont_UserType
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  vtLabel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  ElPopBtn,
  vtCheckBox,
  vtComboBoxQS,
  vtColorBox,
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
    { StyleEditorFontIDs }
   fm_StyleEditorFontForm : TvcmFormDescriptor = (rFormID : (rName : 'StyleEditorFontForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TStyleEditorFontForm }

type
 StyleEditorFontFormDef = interface(IUnknown)
  {* Идентификатор формы StyleEditorFont }
   ['{631D935A-F7C1-48C4-ACCC-923697DDB82E}']
 end;//StyleEditorFontFormDef

  TStyleEditorFontForm = {final form} class(TPrimStyleEditorFontForm, StyleEditorFontFormDef)
   {* Параметры шрифта }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TStyleEditorFontForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$R *.DFM}

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
  ,
  StyleEditorFontKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { Локализуемые строки ut_StyleEditorFontLocalConstants }
   str_ut_StyleEditorFontCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StyleEditorFontCaption'; rValue : 'Параметры шрифта');
    { Заголовок пользовательского типа "Параметры шрифта" }

// start class TStyleEditorFontForm

procedure TStyleEditorFontForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_StyleEditorFontName,
  str_ut_StyleEditorFontCaption,
  str_ut_StyleEditorFontCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_StyleEditorFontName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFont
 TtfwClassRef.Register(TStyleEditorFontForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ut_StyleEditorFontCaption
 str_ut_StyleEditorFontCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.