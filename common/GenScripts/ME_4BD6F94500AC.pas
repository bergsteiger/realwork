unit PrimTreeAttributeSelect_astNone_UserType;
 {* Поиск: Выбор реквизита }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\PrimTreeAttributeSelect_astNone_UserType.pas"
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
 {* Константы для типа формы astNone }
 astNoneName = 'astNone';
  {* Строковый идентификатор пользовательского типа "Поиск: Выбор реквизита" }
 astNone = TvcmUserType(0);
  {* Поиск: Выбор реквизита }

implementation

uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы astNone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_astNone
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_astNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::astNone';
end;//Tkw_FormUserType_astNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_astNone.GetInteger: Integer;
begin
 Result := astNone;
end;//Tkw_FormUserType_astNone.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_astNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_astNone }
{$IfEnd} // NOT Defined(NoScripts)

end.
