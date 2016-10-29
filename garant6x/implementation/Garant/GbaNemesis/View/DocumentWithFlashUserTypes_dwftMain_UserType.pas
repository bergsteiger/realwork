unit DocumentWithFlashUserTypes_dwftMain_UserType;
 {* Схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftMain_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "dwftMain" MUID: (4BD6EE980118)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки dwftMainLocalConstants }
 str_dwftMainCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'dwftMainCaption'; rValue : 'Схема');
  {* Заголовок пользовательского типа "Схема" }
 {* Константы для типа формы dwftMain }
 dwftMainName = 'dwftMain';
  {* Строковый идентификатор пользовательского типа "Схема" }
 dwftMain = TvcmUserType(0);
  {* Схема }
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
 Tkw_FormUserType_dwftMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dwftMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_dwftMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_dwftMain.GetInteger: Integer;
begin
 Result := dwftMain;
end;//Tkw_FormUserType_dwftMain.GetInteger

class function Tkw_FormUserType_dwftMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dwftMain';
end;//Tkw_FormUserType_dwftMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_dwftMainCaption.Init;
 {* Инициализация str_dwftMainCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dwftMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
