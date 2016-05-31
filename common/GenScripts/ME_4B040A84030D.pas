unit DocumentUserTypes_dftRelatedDoc_UserType;
 {* Справка }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentUserTypes_dftRelatedDoc_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dftRelatedDoc" MUID: (4B040A84030D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentUserTypes_dftDocument_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dftRelatedDocLocalConstants }
 str_dftRelatedDocCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocCaption'; rValue : 'Справка');
  {* Заголовок пользовательского типа "Справка" }
 str_dftRelatedDocSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dftRelatedDocSettingsCaption'; rValue : 'Документ: Справка к документу');
  {* Заголовок пользовательского типа "Справка" для настройки панелей инструментов }
 {* Константы для типа формы dftRelatedDoc }
 dftRelatedDocName = 'dftRelatedDoc';
  {* Строковый идентификатор пользовательского типа "Справка" }
 dftRelatedDoc = TvcmUserType(dftDocument + 1);
  {* Справка }
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
 Tkw_FormUserType_dftRelatedDoc = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dftRelatedDoc }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dftRelatedDoc
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dftRelatedDoc.GetInteger: Integer;
begin
 Result := dftRelatedDoc;
end;//Tkw_FormUserType_dftRelatedDoc.GetInteger

class function Tkw_FormUserType_dftRelatedDoc.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dftRelatedDoc';
end;//Tkw_FormUserType_dftRelatedDoc.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dftRelatedDocCaption.Init;
 {* Инициализация str_dftRelatedDocCaption }
 str_dftRelatedDocSettingsCaption.Init;
 {* Инициализация str_dftRelatedDocSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dftRelatedDoc.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dftRelatedDoc }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
