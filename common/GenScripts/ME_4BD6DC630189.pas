unit InpharmMainMenu_ut_mmmMain_UserType;
 {* ГАРАНТ-ИнФарм }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\InpharmMainMenu_ut_mmmMain_UserType.pas"
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
 {* Константы для типа формы ut_mmmMain }
 ut_mmmMainName = 'ut_mmmMain';
  {* Строковый идентификатор пользовательского типа "ГАРАНТ-ИнФарм" }
 ut_mmmMain = TvcmUserType(0);
  {* ГАРАНТ-ИнФарм }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_mmmMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы ut_mmmMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_mmmMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_mmmMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::ut_mmmMain';
end;//Tkw_FormUserType_ut_mmmMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_mmmMain.GetInteger: Integer;
begin
 Result := ut_mmmMain;
end;//Tkw_FormUserType_ut_mmmMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_mmmMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_ut_mmmMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
