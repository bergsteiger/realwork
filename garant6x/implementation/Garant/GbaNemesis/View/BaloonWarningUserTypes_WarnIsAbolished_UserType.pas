unit BaloonWarningUserTypes_WarnIsAbolished_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnIsAbolished_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnIsAbolished" MUID: (4DA8296501F2)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnPreActive_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки WarnIsAbolishedLocalConstants }
 str_WarnIsAbolishedCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnIsAbolishedCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы WarnIsAbolished }
 WarnIsAbolishedName = 'WarnIsAbolished';
  {* Строковый идентификатор пользовательского типа "" }
 WarnIsAbolished = TvcmUserType(WarnPreActive + 1);
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
 Tkw_FormUserType_WarnIsAbolished = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnIsAbolished }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnIsAbolished
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnIsAbolished.GetInteger: Integer;
begin
 Result := WarnIsAbolished;
end;//Tkw_FormUserType_WarnIsAbolished.GetInteger

class function Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnIsAbolished';
end;//Tkw_FormUserType_WarnIsAbolished.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarnIsAbolishedCaption.Init;
 {* Инициализация str_WarnIsAbolishedCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnIsAbolished.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnIsAbolished }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
