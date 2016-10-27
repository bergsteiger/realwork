unit DocumentUserTypes_dftChronology_UserType;
 {* Хронология судебного дела }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftChronology_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftChronology" MUID: (53BFD2E400A4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftAACContentsRight_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки dftChronologyLocalConstants }
 str_dftChronologyCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologyCaption'; rValue : 'Хронология судебного дела');
  {* Заголовок пользовательского типа "Хронология судебного дела" }
 str_dftChronologySettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftChronologySettingsCaption'; rValue : 'Документ: Хронология судебного дела');
  {* Заголовок пользовательского типа "Хронология судебного дела" для настройки панелей инструментов }
 {* Константы для типа формы dftChronology }
 dftChronologyName = 'dftChronology';
  {* Строковый идентификатор пользовательского типа "Хронология судебного дела" }
 dftChronology = TvcmUserType(dftAACContentsRight + 1);
  {* Хронология судебного дела }
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
 Tkw_FormUserType_dftChronology = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftChronology }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftChronology
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftChronology.GetInteger: Integer;
begin
 Result := dftChronology;
end;//Tkw_FormUserType_dftChronology.GetInteger

class function Tkw_FormUserType_dftChronology.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftChronology';
end;//Tkw_FormUserType_dftChronology.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftChronologyCaption.Init;
 {* Инициализация str_dftChronologyCaption }
 str_dftChronologySettingsCaption.Init;
 {* Инициализация str_dftChronologySettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftChronology.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftChronology }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
