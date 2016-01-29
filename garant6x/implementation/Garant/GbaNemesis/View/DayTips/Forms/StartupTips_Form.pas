unit StartupTips_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DayTips/Forms/StartupTips_Form.pas"
// Начат: 04.09.2009 12:52
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Интерфейсные элементы::DayTips::View::DayTips::DayTips::StartupTips
//
// Совет дня
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
  PrimStartupTips_Form,
  l3StringIDEx
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  StartupTips_ut_StartupTips_UserType,
  vtPanel
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtLabel,
  vtFocusLabel,
  vtCheckBox,
  ElPopBtn,
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
    { StartupTipsIDs }
   fm_efStartupTips : TvcmFormDescriptor = (rFormID : (rName : 'efStartupTips'; rID : 0); rFactory : nil);
    { Идентификатор формы TefStartupTips }

type
 StartupTipsFormDef = interface(IUnknown)
  {* Идентификатор формы StartupTips }
   ['{69581B33-5C00-46C8-8723-A5DE81DDD577}']
 end;//StartupTipsFormDef

  TefStartupTips = {final form} class(TPrimStartupTipsForm, StartupTipsFormDef)
   {* Совет дня }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TefStartupTips

  TStartupTipsForm = TefStartupTips;
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
  StartupTipsKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { Локализуемые строки ut_StartupTipsLocalConstants }
   str_ut_StartupTipsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_StartupTipsCaption'; rValue : 'Совет дня');
    { Заголовок пользовательского типа "Совет дня" }

// start class TefStartupTips

procedure TefStartupTips.MakeControls;
begin
 inherited;
 with AddUsertype(ut_StartupTipsName,
  str_ut_StartupTipsCaption,
  str_ut_StartupTipsCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_StartupTipsName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StartupTips
 TtfwClassRef.Register(TefStartupTips);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы StartupTips
 fm_efStartupTips.SetFactory(TefStartupTips.Make);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ut_StartupTipsCaption
 str_ut_StartupTipsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.