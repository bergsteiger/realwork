unit BaloonWarningUserTypes_ControlledChangingWarning_UserType;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaloonWarningUserTypes_ControlledChangingWarning_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "ControlledChangingWarning" MUID: (4DBFF6FD020F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , BaloonWarningUserTypes_OldBaseWarning_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки ControlledChangingWarningLocalConstants }
 str_ControlledChangingWarningCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ControlledChangingWarningCaption'; rValue : '');
  {* Заголовок пользовательского типа "" }
 {* Константы для типа формы ControlledChangingWarning }
 ControlledChangingWarningName = 'ControlledChangingWarning';
  {* Строковый идентификатор пользовательского типа "" }
 ControlledChangingWarning = TvcmUserType(OldBaseWarning + 1);
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
 Tkw_FormUserType_ControlledChangingWarning = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ControlledChangingWarning }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ControlledChangingWarning
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ControlledChangingWarning.GetInteger: Integer;
begin
 Result := ControlledChangingWarning;
end;//Tkw_FormUserType_ControlledChangingWarning.GetInteger

class function Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ControlledChangingWarning';
end;//Tkw_FormUserType_ControlledChangingWarning.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ControlledChangingWarningCaption.Init;
 {* Инициализация str_ControlledChangingWarningCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ControlledChangingWarning.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ControlledChangingWarning }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
