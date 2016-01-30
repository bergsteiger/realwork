unit PrimTreeAttributeSelect_astOneLevel_UserType;
 {* Ситуации второго уровня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astOneLevel_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astNone_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы astOneLevel }
 astOneLevelName = 'astOneLevel';
  {* Строковый идентификатор пользовательского типа "Ситуации второго уровня" }
 astOneLevel = TvcmUserType(astNone + 1);
  {* Ситуации второго уровня }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astOneLevel = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astOneLevel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astOneLevel
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astOneLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astOneLevel';
end;//Tkw_FormUserType_astOneLevel.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astOneLevel.GetInteger: Integer;
begin
 Result := astOneLevel;
end;//Tkw_FormUserType_astOneLevel.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astOneLevel.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astOneLevel }
{$IfEnd} // NOT Defined(NoScripts)

end.
