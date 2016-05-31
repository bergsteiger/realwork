unit PrimTreeAttributeFirstLevel_flSituation_UserType;
 {* Ситуации первого уровня (вкладка) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "flSituation" MUID: (4BD71C0000AE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки flSituationLocalConstants }
 str_flSituationCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'flSituationCaption'; rValue : 'Ситуации первого уровня (вкладка)');
  {* Заголовок пользовательского типа "Ситуации первого уровня (вкладка)" }
 str_flSituationSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'flSituationSettingsCaption'; rValue : 'Поиск: Ситуации первого уровня (вкладка)');
  {* Заголовок пользовательского типа "Ситуации первого уровня (вкладка)" для настройки панелей инструментов }
 {* Константы для типа формы flSituation }
 flSituationName = 'flSituation';
  {* Строковый идентификатор пользовательского типа "Ситуации первого уровня (вкладка)" }
 flSituation = TvcmUserType(0);
  {* Ситуации первого уровня (вкладка) }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_flSituation = {final} class(TtfwInteger)
  {* Слово словаря для типа формы flSituation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_flSituation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_flSituation.GetInteger: Integer;
begin
 Result := flSituation;
end;//Tkw_FormUserType_flSituation.GetInteger

class function Tkw_FormUserType_flSituation.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::flSituation';
end;//Tkw_FormUserType_flSituation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_flSituationCaption.Init;
 {* Инициализация str_flSituationCaption }
 str_flSituationSettingsCaption.Init;
 {* Инициализация str_flSituationSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_flSituation.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_flSituation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
