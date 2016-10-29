unit BaloonWarningUserTypes_WarnOnControl_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_WarnOnControl_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "WarnOnControl" MUID: (4DA8297800F7)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_WarnIsAbolished_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* Локализуемые строки WarnOnControlLocalConstants }
 str_WarnOnControlCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'WarnOnControlCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы WarnOnControl }
 WarnOnControlName = 'WarnOnControl';
  {* Строковый идентификатор пользовательского типа "" }
 WarnOnControl = TvcmUserType(WarnIsAbolished + 1);
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
 Tkw_FormUserType_WarnOnControl = {final} class(TtfwInteger)
  {* Слово словаря для типа формы WarnOnControl }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_WarnOnControl
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_WarnOnControl.GetInteger: Integer;
begin
 Result := WarnOnControl;
end;//Tkw_FormUserType_WarnOnControl.GetInteger

class function Tkw_FormUserType_WarnOnControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::WarnOnControl';
end;//Tkw_FormUserType_WarnOnControl.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_WarnOnControlCaption.Init;
 {* Инициализация str_WarnOnControlCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_WarnOnControl.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_WarnOnControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
