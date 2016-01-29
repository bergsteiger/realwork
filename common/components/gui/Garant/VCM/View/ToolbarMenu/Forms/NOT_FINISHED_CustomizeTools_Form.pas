unit NOT_FINISHED_CustomizeTools_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/View/ToolbarMenu/Forms/NOT_FINISHED_CustomizeTools_Form.pas"
// Начат: 13.09.2010 19:27
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> Shared Delphi Operations::VCMCustomization::View::ToolbarMenu::PrimToolbarMenu::CustomizeTools
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\sdoDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmUserControls,
  l3StringIDEx,
  PrimCustomizeTools_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  CustomizeTools_ut_CustomizeTools_UserType,
  Classes {a},
  l3InterfacedComponent {a},
  vcmComponent {a},
  vcmBaseEntities {a},
  vcmEntities {a},
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a}
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
  TCustomizeToolsForm = {final form} class(TPrimCustomizeToolsForm)
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TCustomizeToolsForm
{$IfEnd} //not NoVCM

implementation

{$R *.DFM}

{$If not defined(NoVCM)}
uses
  SysUtils
  {$If defined(Nemesis)}
  ,
  eeShortCutEdit
  {$IfEnd} //Nemesis
  
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3MessageID
  {$If not defined(NoScripts) AND not defined(NoVCM)}
  ,
  CustomizeToolsKeywordsPack
  {$IfEnd} //not NoScripts AND not NoVCM
  
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

var
    { Локализуемые строки ut_CustomizeToolsLocalConstants }
   str_ut_CustomizeToolsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CustomizeToolsCaption'; rValue : 'CustomizeTools');
    { Заголовок пользовательского типа "CustomizeTools" }

// start class TCustomizeToolsForm

procedure TCustomizeToolsForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_CustomizeToolsName,
  str_ut_CustomizeToolsCaption,
  str_ut_CustomizeToolsCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_CustomizeToolsName
end;

{$IfEnd} //not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoVCM)}
// Регистрация CustomizeTools
 TtfwClassRef.Register(TCustomizeToolsForm);
{$IfEnd} //not NoScripts AND not NoVCM
{$If not defined(NoVCM)}
// Инициализация str_ut_CustomizeToolsCaption
 str_ut_CustomizeToolsCaption.Init;
{$IfEnd} //not NoVCM

end.