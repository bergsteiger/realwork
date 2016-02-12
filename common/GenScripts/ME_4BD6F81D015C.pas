unit PrimAttributeSelect_utAttributeSelect_UserType;
 {* Выбор значения атрибута }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimAttributeSelect_utAttributeSelect_UserType.pas"
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
 {* Константы для типа формы utAttributeSelect }
 utAttributeSelectName = 'utAttributeSelect';
  {* Строковый идентификатор пользовательского типа "Выбор значения атрибута" }
 utAttributeSelect = TvcmUserType(0);
  {* Выбор значения атрибута }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAttributeSelect = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utAttributeSelect }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utAttributeSelect
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utAttributeSelect';
end;//Tkw_FormUserType_utAttributeSelect.GetWordNameForRegister

function Tkw_FormUserType_utAttributeSelect.GetInteger: Integer;
begin
 Result := utAttributeSelect;
end;//Tkw_FormUserType_utAttributeSelect.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utAttributeSelect.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utAttributeSelect }
{$IfEnd} // NOT Defined(NoScripts)

end.
