unit PrimUnderControl_utUnderControl_UserType;
 {* Документы на контроле }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\UnderControl\Forms\PrimUnderControl_utUnderControl_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы utUnderControl }
 utUnderControlName = 'utUnderControl';
  {* Строковый идентификатор пользовательского типа "Документы на контроле" }
 utUnderControl = TvcmUserType(0);
  {* Документы на контроле }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utUnderControl = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utUnderControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utUnderControl
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utUnderControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utUnderControl';
end;//Tkw_FormUserType_utUnderControl.GetWordNameForRegister

function Tkw_FormUserType_utUnderControl.GetInteger: Integer;
begin
 Result := utUnderControl;
end;//Tkw_FormUserType_utUnderControl.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utUnderControl.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utUnderControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
