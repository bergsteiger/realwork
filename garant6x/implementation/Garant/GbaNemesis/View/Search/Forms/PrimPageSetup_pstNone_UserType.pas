unit PrimPageSetup_pstNone_UserType;
 {* Настройка страницы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimPageSetup_pstNone_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "pstNone" MUID: (4C93316D02C8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы pstNone }
 pstNoneName = 'pstNone';
  {* Строковый идентификатор пользовательского типа "Настройка страницы" }
 pstNone = TvcmUserType(0);
  {* Настройка страницы }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_pstNone = {final} class(TtfwInteger)
  {* Слово словаря для типа формы pstNone }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_pstNone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_pstNone.GetInteger: Integer;
begin
 Result := pstNone;
end;//Tkw_FormUserType_pstNone.GetInteger

class function Tkw_FormUserType_pstNone.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::pstNone';
end;//Tkw_FormUserType_pstNone.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pstNone.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_pstNone }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
