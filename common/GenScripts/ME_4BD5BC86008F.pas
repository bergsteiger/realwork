unit PrimSaveLoadUserTypes_slqtInpharmSearch_UserType;
 {* Поиск лекарственных средств }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtInpharmSearch_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtConsult_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы slqtInpharmSearch }
 slqtInpharmSearchName = 'slqtInpharmSearch';
  {* Строковый идентификатор пользовательского типа "Поиск лекарственных средств" }
 slqtInpharmSearch = TvcmUserType(slqtConsult + 1);
  {* Поиск лекарственных средств }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtInpharmSearch = {final} class(TtfwInteger)
  {* Слово словаря для типа формы slqtInpharmSearch }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtInpharmSearch
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::slqtInpharmSearch';
end;//Tkw_FormUserType_slqtInpharmSearch.GetWordNameForRegister

function Tkw_FormUserType_slqtInpharmSearch.GetInteger: Integer;
begin
 Result := slqtInpharmSearch;
end;//Tkw_FormUserType_slqtInpharmSearch.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtInpharmSearch.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_slqtInpharmSearch }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
