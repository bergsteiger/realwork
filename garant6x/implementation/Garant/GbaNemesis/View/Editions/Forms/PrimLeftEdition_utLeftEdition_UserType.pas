unit PrimLeftEdition_utLeftEdition_UserType;
 {* Предыдущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimLeftEdition_utLeftEdition_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utLeftEdition" MUID: (4BD7056800D3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3StringIDEx
;

const
 {* Локализуемые строки utLeftEditionLocalConstants }
 str_utLeftEditionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utLeftEditionCaption'; rValue : 'Предыдущая редакция');
  {* Заголовок пользовательского типа "Предыдущая редакция" }
 {* Константы для типа формы utLeftEdition }
 utLeftEditionName = 'utLeftEdition';
  {* Строковый идентификатор пользовательского типа "Предыдущая редакция" }
 utLeftEdition = TvcmUserType(0);
  {* Предыдущая редакция }
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
 Tkw_FormUserType_utLeftEdition = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utLeftEdition }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utLeftEdition
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utLeftEdition.GetInteger: Integer;
begin
 Result := utLeftEdition;
end;//Tkw_FormUserType_utLeftEdition.GetInteger

class function Tkw_FormUserType_utLeftEdition.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utLeftEdition';
end;//Tkw_FormUserType_utLeftEdition.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utLeftEditionCaption.Init;
 {* Инициализация str_utLeftEditionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utLeftEdition.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utLeftEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
