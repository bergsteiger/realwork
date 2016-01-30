unit PrimQueryCard_utqcInpharmSearch_UserType;
 {* Поиск лекарственных средств }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimQueryCard_utqcInpharmSearch_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimQueryCard_utqcSendConsultation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы utqcInpharmSearch }
 utqcInpharmSearchName = 'utqcInpharmSearch';
  {* Строковый идентификатор пользовательского типа "Поиск лекарственных средств" }
 utqcInpharmSearch = TvcmUserType(utqcSendConsultation + 1);
  {* Поиск лекарственных средств }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcInpharmSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы utqcInpharmSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utqcInpharmSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utqcInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::utqcInpharmSearch';
end;//Tkw_FormUserType_utqcInpharmSearch.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utqcInpharmSearch.GetInteger: Integer;
begin
 Result := utqcInpharmSearch;
end;//Tkw_FormUserType_utqcInpharmSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utqcInpharmSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_utqcInpharmSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
