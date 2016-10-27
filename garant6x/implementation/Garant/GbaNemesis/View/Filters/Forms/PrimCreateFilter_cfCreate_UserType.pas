unit PrimCreateFilter_cfCreate_UserType;
 {* Создать фильтр }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\Forms\PrimCreateFilter_cfCreate_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "cfCreate" MUID: (4CB6D9AE0083)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки cfCreateLocalConstants }
 str_cfCreateCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cfCreateCaption'; rValue : 'Создать фильтр');
  {* Заголовок пользовательского типа "Создать фильтр" }
 {* Константы для типа формы cfCreate }
 cfCreateName = 'cfCreate';
  {* Строковый идентификатор пользовательского типа "Создать фильтр" }
 cfCreate = TvcmUserType(0);
  {* Создать фильтр }
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
 Tkw_FormUserType_cfCreate = {final} class(TtfwInteger)
  {* Слово словаря для типа формы cfCreate }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_cfCreate
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_cfCreate.GetInteger: Integer;
begin
 Result := cfCreate;
end;//Tkw_FormUserType_cfCreate.GetInteger

class function Tkw_FormUserType_cfCreate.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::cfCreate';
end;//Tkw_FormUserType_cfCreate.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_cfCreateCaption.Init;
 {* Инициализация str_cfCreateCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_cfCreate.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_cfCreate }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
