unit PrimRightEdition_utRightEdition_UserType;
 {* Текущая редакция }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\Forms\PrimRightEdition_utRightEdition_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "utRightEdition" MUID: (4BD705A001E0)

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
 {* Локализуемые строки utRightEditionLocalConstants }
 str_utRightEditionCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utRightEditionCaption'; rValue : 'Текущая редакция');
  {* Заголовок пользовательского типа "Текущая редакция" }
 {* Константы для типа формы utRightEdition }
 utRightEditionName = 'utRightEdition';
  {* Строковый идентификатор пользовательского типа "Текущая редакция" }
 utRightEdition = TvcmUserType(0);
  {* Текущая редакция }
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
 Tkw_FormUserType_utRightEdition = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utRightEdition }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utRightEdition
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utRightEdition.GetInteger: Integer;
begin
 Result := utRightEdition;
end;//Tkw_FormUserType_utRightEdition.GetInteger

class function Tkw_FormUserType_utRightEdition.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utRightEdition';
end;//Tkw_FormUserType_utRightEdition.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utRightEditionCaption.Init;
 {* Инициализация str_utRightEditionCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utRightEdition.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utRightEdition }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
