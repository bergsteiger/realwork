unit DocumentUserTypes_dftDrugSynchroView_UserType;
 {* Описание препарата (синхронный просмотр) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftDrugSynchroView_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftDrugSynchroView" MUID: (4B0410A102E1)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftMedicFirmSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dftDrugSynchroViewLocalConstants }
 str_dftDrugSynchroViewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewCaption'; rValue : 'Описание препарата (синхронный просмотр)');
  {* Заголовок пользовательского типа "Описание препарата (синхронный просмотр)" }
 str_dftDrugSynchroViewSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftDrugSynchroViewSettingsCaption'; rValue : 'Синхронный просмотр: Описание препарата');
  {* Заголовок пользовательского типа "Описание препарата (синхронный просмотр)" для настройки панелей инструментов }
 {* Константы для типа формы dftDrugSynchroView }
 dftDrugSynchroViewName = 'dftDrugSynchroView';
  {* Строковый идентификатор пользовательского типа "Описание препарата (синхронный просмотр)" }
 dftDrugSynchroView = TvcmUserType(dftMedicFirmSynchroView + 1);
  {* Описание препарата (синхронный просмотр) }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_dftDrugSynchroView = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftDrugSynchroView }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftDrugSynchroView
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftDrugSynchroView.GetInteger: Integer;
begin
 Result := dftDrugSynchroView;
end;//Tkw_FormUserType_dftDrugSynchroView.GetInteger

class function Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftDrugSynchroView';
end;//Tkw_FormUserType_dftDrugSynchroView.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftDrugSynchroViewCaption.Init;
 {* Инициализация str_dftDrugSynchroViewCaption }
 str_dftDrugSynchroViewSettingsCaption.Init;
 {* Инициализация str_dftDrugSynchroViewSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftDrugSynchroView.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftDrugSynchroView }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
