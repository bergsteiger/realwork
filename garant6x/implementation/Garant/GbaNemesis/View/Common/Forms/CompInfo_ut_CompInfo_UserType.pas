unit CompInfo_ut_CompInfo_UserType;
 {* Информация о комплекте }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\CompInfo_ut_CompInfo_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ut_CompInfo" MUID: (A462190E3592)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки ut_CompInfoLocalConstants }
 str_ut_CompInfoCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_CompInfoCaption'; rValue : 'Информация о комплекте');
  {* Заголовок пользовательского типа "Информация о комплекте" }
 {* Константы для типа формы ut_CompInfo }
 ut_CompInfoName = 'ut_CompInfo';
  {* Строковый идентификатор пользовательского типа "Информация о комплекте" }
 ut_CompInfo = TvcmUserType(0);
  {* Информация о комплекте }
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
 Tkw_FormUserType_ut_CompInfo = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_CompInfo }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_CompInfo
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_CompInfo.GetInteger: Integer;
begin
 Result := ut_CompInfo;
end;//Tkw_FormUserType_ut_CompInfo.GetInteger

class function Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_CompInfo';
end;//Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_CompInfoCaption.Init;
 {* Инициализация str_ut_CompInfoCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_CompInfo.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_CompInfo }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
