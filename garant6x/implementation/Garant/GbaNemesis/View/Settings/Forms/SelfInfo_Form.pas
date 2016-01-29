unit SelfInfo_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/Forms/SelfInfo_Form.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMFinalForm::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::SelfInfo
//
// Регистрационные данные
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
  l3StringIDEx,
  PrimSelfInfo_Form
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  SelfInfo_ut_SelfInfo_UserType,
  vtPanel,
  vtLabel
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  ElPopBtn
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtFocusLabel,
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
    { SelfInfoIDs }
   fm_SelfInfoForm : TvcmFormDescriptor = (rFormID : (rName : 'SelfInfoForm'; rID : 0); rFactory : nil);
    { Идентификатор формы TSelfInfoForm }

type
 SelfInfoFormDef = interface(IUnknown)
  {* Идентификатор формы SelfInfo }
   ['{58609172-F191-4A45-BABF-5983A3CBE791}']
 end;//SelfInfoFormDef

  TSelfInfoForm = {final form} class(TPrimSelfInfoForm, SelfInfoFormDef)
   {* Регистрационные данные }
  Entities : TvcmEntities;
  protected
   procedure MakeControls; override;
  end;//TSelfInfoForm
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
  SelfInfoKeywordsPack
  {$IfEnd} //not Admin AND not Monitorings AND not NoScripts
  
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

var
    { Локализуемые строки ut_SelfInfoLocalConstants }
   str_ut_SelfInfoCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_SelfInfoCaption'; rValue : 'Регистрационные данные');
    { Заголовок пользовательского типа "Регистрационные данные" }

// start class TSelfInfoForm

procedure TSelfInfoForm.MakeControls;
begin
 inherited;
 with AddUsertype(ut_SelfInfoName,
  str_ut_SelfInfoCaption,
  str_ut_SelfInfoCaption,
  false,
  -1,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccNone) do
 begin
 end;//with AddUsertype(ut_SelfInfoName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация SelfInfo
 TtfwClassRef.Register(TSelfInfoForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings)}
// Регистрация фабрики формы SelfInfo
 fm_SelfInfoForm.SetFactory(TSelfInfoForm.Make);
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_ut_SelfInfoCaption
 str_ut_SelfInfoCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.