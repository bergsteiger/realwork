unit BaloonWarningUserTypes_remListFiltered_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_remListFiltered_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "remListFiltered" MUID: (4DB97E8001AE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_remListModified_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки remListFilteredLocalConstants }
 str_remListFilteredCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'remListFilteredCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы remListFiltered }
 remListFilteredName = 'remListFiltered';
  {* Строковый идентификатор пользовательского типа "" }
 remListFiltered = TvcmUserType(remListModified + 1);
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
 Tkw_FormUserType_remListFiltered = {final} class(TtfwInteger)
  {* Слово словаря для типа формы remListFiltered }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_remListFiltered
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_remListFiltered.GetInteger: Integer;
begin
 Result := remListFiltered;
end;//Tkw_FormUserType_remListFiltered.GetInteger

class function Tkw_FormUserType_remListFiltered.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::remListFiltered';
end;//Tkw_FormUserType_remListFiltered.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_remListFilteredCaption.Init;
 {* Инициализация str_remListFilteredCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_remListFiltered.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_remListFiltered }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
