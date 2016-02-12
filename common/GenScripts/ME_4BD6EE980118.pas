unit DocumentWithFlashUserTypes_dwftMain_UserType;
 {* Схема }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DocumentWithFlashUserTypes_dwftMain_UserType.pas"
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
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftMain = {final} class(TtfwInteger)
  {* Слово словаря для типа формы dwftMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_dwftMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_dwftMain.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::dwftMain';
end;//Tkw_FormUserType_dwftMain.GetWordNameForRegister

function Tkw_FormUserType_dwftMain.GetInteger: Integer;
begin
 Result := dwftMain;
end;//Tkw_FormUserType_dwftMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_dwftMain.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_dwftMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
