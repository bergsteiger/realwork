unit PrimSelectedAttributes_utSelectedAttributes_UserType;
 {* Поиск: Выбранные значения реквизита }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimSelectedAttributes_utSelectedAttributes_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

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
 {* Константы для типа формы utSelectedAttributes }
 utSelectedAttributesName = 'utSelectedAttributes';
  {* Строковый идентификатор пользовательского типа "Поиск: Выбранные значения реквизита" }
 utSelectedAttributes = TvcmUserType(0);
  {* Поиск: Выбранные значения реквизита }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSelectedAttributes = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utSelectedAttributes }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utSelectedAttributes
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utSelectedAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utSelectedAttributes';
end;//Tkw_FormUserType_utSelectedAttributes.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utSelectedAttributes.GetInteger: Integer;
begin
 Result := utSelectedAttributes;
end;//Tkw_FormUserType_utSelectedAttributes.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utSelectedAttributes.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utSelectedAttributes }
{$IfEnd} // NOT Defined(NoScripts)

end.
