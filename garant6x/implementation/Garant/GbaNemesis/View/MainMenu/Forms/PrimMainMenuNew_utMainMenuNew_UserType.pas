unit PrimMainMenuNew_utMainMenuNew_UserType;
 {* Основное меню }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\PrimMainMenuNew_utMainMenuNew_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utMainMenuNew" MUID: (4BDAF8340011)

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
 {* Локализуемые строки utMainMenuNewLocalConstants }
 str_utMainMenuNewCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utMainMenuNewCaption'; rValue : 'Основное меню');
  {* Заголовок пользовательского типа "Основное меню" }
 {* Константы для типа формы utMainMenuNew }
 utMainMenuNewName = 'utMainMenuNew';
  {* Строковый идентификатор пользовательского типа "Основное меню" }
 utMainMenuNew = TvcmUserType(0);
  {* Основное меню }
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
 Tkw_FormUserType_utMainMenuNew = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utMainMenuNew }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utMainMenuNew
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utMainMenuNew.GetInteger: Integer;
begin
 Result := utMainMenuNew;
end;//Tkw_FormUserType_utMainMenuNew.GetInteger

class function Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utMainMenuNew';
end;//Tkw_FormUserType_utMainMenuNew.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utMainMenuNewCaption.Init;
 {* Инициализация str_utMainMenuNewCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainMenuNew.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utMainMenuNew }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
