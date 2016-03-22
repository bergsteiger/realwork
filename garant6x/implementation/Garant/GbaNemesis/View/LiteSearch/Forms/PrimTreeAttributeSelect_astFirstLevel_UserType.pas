unit PrimTreeAttributeSelect_astFirstLevel_UserType;
 {* Ситуации первого уровня }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astFirstLevel_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "astFirstLevel" MUID: (4BD6F97301F4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , PrimTreeAttributeSelect_astOneLevel_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы astFirstLevel }
 astFirstLevelName = 'astFirstLevel';
  {* Строковый идентификатор пользовательского типа "Ситуации первого уровня" }
 astFirstLevel = TvcmUserType(astOneLevel + 1);
  {* Ситуации первого уровня }

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_astFirstLevel = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astFirstLevel }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_astFirstLevel
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astFirstLevel.GetInteger: Integer;
begin
 Result := astFirstLevel;
end;//Tkw_FormUserType_astFirstLevel.GetInteger

class function Tkw_FormUserType_astFirstLevel.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astFirstLevel';
end;//Tkw_FormUserType_astFirstLevel.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astFirstLevel.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astFirstLevel }
{$IfEnd} // NOT Defined(NoScripts)

end.
