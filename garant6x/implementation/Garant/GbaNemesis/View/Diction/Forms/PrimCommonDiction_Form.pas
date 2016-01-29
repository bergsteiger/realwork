unit PrimCommonDiction_Form;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimCommonDiction_Form.pas"
// Начат: 27.01.2009 12:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMForm::Class>> F1 Встроенные продукты::Diction::View::Diction::PrimCommonDiction
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
  CommonDictionInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  l3StringIDEx,
  PrimCommonDiction_utTips_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  DocumentAndListInterfaces,
  vcmExternalInterfaces {a},
  vcmInterfaces {a},
  vcmEntityForm {a},
  vcmControllers {a},
  PrimCommonDiction_utMedicDiction_UserType
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _BaseDocument_Parent_ = TvcmEntityForm;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}
 TPrimCommonDictionForm = {form} class(_BaseDocument_)
 protected
  procedure SignalDataSourceChanged(const anOld : IvcmViewAreaController;
                                const aDsNew : IvcmViewAreaController); override;
  procedure MakeControls; override;
 protected
 // overridden protected methods
   procedure FinishDataUpdate; override;
    {$If not defined(NoVCM)}
   function IsAcceptable(aDataUpdate: Boolean): Boolean; override;
     {* Можно ли открывать форму в текущих условиях (например, на текущей базе) }
    {$IfEnd} //not NoVCM
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   function NeedDrawCaption: Boolean; override;
     {* Нужно ли рисовать заголовок зоны }
   {$IfEnd} //not NoVCM
 protected
 // protected fields
   dsCommonDiction : IdsCommonDiction;
 end;//TPrimCommonDictionForm
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Common_FormDefinitions_Controls,
  DataAdapter
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  ,
  l3MessageID
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils {a},
  StdRes {a}
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\BaseDocument.imp.pas}

var
   { Локализуемые строки utTipsLocalConstants }
  str_utTipsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utTipsCaption'; rValue : 'Совет дня');
   { Заголовок пользовательского типа "Совет дня" }
  str_utTipsSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utTipsSettingsCaption'; rValue : 'Совет дня: Список советов (вкладка)');
   { Заголовок пользовательского типа "Совет дня" для настройки панелей инструментов }

var
   { Локализуемые строки utMedicDictionLocalConstants }
  str_utMedicDictionCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMedicDictionCaption'; rValue : 'Словарь медицинских терминов');
   { Заголовок пользовательского типа "Словарь медицинских терминов" }
  str_utMedicDictionSettingsCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMedicDictionSettingsCaption'; rValue : 'Словарь медицинских терминов: Список терминов (вкладка)');
   { Заголовок пользовательского типа "Словарь медицинских терминов" для настройки панелей инструментов }

// start class TPrimCommonDictionForm

procedure TPrimCommonDictionForm.FinishDataUpdate;
//#UC START# *47EA4E9002C6_497ED770029D_var*
//#UC END# *47EA4E9002C6_497ED770029D_var*
begin
//#UC START# *47EA4E9002C6_497ED770029D_impl*
 if not IsAcceptable(True) then
  if vcmDispatcher.History.CanBack then
   vcmDispatcher.History.Back(True);
//#UC END# *47EA4E9002C6_497ED770029D_impl*
end;//TPrimCommonDictionForm.FinishDataUpdate

{$If not defined(NoVCM)}
function TPrimCommonDictionForm.NeedDrawCaption: Boolean;
//#UC START# *4A84183701B9_497ED770029D_var*
//#UC END# *4A84183701B9_497ED770029D_var*
begin
//#UC START# *4A84183701B9_497ED770029D_impl*
 Result := false;
//#UC END# *4A84183701B9_497ED770029D_impl*
end;//TPrimCommonDictionForm.NeedDrawCaption
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
function TPrimCommonDictionForm.IsAcceptable(aDataUpdate: Boolean): Boolean;
//#UC START# *55127A5401DE_497ED770029D_var*
//#UC END# *55127A5401DE_497ED770029D_var*
begin
//#UC START# *55127A5401DE_497ED770029D_impl*
 Result := dsCommonDiction.IsDataAvailable;
//#UC END# *55127A5401DE_497ED770029D_impl*
end;//TPrimCommonDictionForm.IsAcceptable
{$IfEnd} //not NoVCM

procedure TPrimCommonDictionForm.SignalDataSourceChanged(const anOld : IvcmViewAreaController;
 const aDsNew : IvcmViewAreaController);
begin
 inherited;
 if (aDsNew = nil) then
 begin
  dsCommonDiction := nil;
 end//aDsNew = nil
 else
 begin
  Supports(aDsNew, IdsCommonDiction, dsCommonDiction);
 end;//aDsNew = nil
end;

procedure TPrimCommonDictionForm.MakeControls;
begin
 inherited;
 with AddUsertype(utTipsName,
  str_utTipsCaption,
  str_utTipsSettingsCaption,
  true,
  175,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(utTipsName
 with AddUsertype(utMedicDictionName,
  str_utMedicDictionCaption,
  str_utMedicDictionSettingsCaption,
  true,
  182,
  -1,
  '',
  nil,
  nil,
  nil,
  vcm_ccDisable) do
 begin
 end;//with AddUsertype(utMedicDictionName
end;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utTipsCaption
 str_utTipsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utTipsSettingsCaption
 str_utTipsSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utMedicDictionCaption
 str_utMedicDictionCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings)}
// Инициализация str_utMedicDictionSettingsCaption
 str_utMedicDictionSettingsCaption.Init;
{$IfEnd} //not Admin AND not Monitorings
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация PrimCommonDiction
 TtfwClassRef.Register(TPrimCommonDictionForm);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.