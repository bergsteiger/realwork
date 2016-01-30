unit ListUserTypes_lftSimilarDocumentsToFragment_UserType;
 {* Похожие к фрагменту }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocumentsToFragment_UserType.pas"
// Стереотип: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftRToPart_UserType
 , ListUserTypes_lftSimilarDocuments_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* Константы для типа формы lftSimilarDocumentsToFragment }
 lftSimilarDocumentsToFragmentName = 'lftSimilarDocumentsToFragment';
  {* Строковый идентификатор пользовательского типа "Похожие к фрагменту" }
 lftSimilarDocumentsToFragment = TvcmUserType(lftRToPart + 1);
  {* Похожие к фрагменту }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocumentsToFragment = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftSimilarDocumentsToFragment }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftSimilarDocumentsToFragment
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftSimilarDocumentsToFragment.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftSimilarDocumentsToFragment';
end;//Tkw_FormUserType_lftSimilarDocumentsToFragment.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSimilarDocumentsToFragment.GetInteger: Integer;
begin
 Result := lftSimilarDocumentsToFragment;
end;//Tkw_FormUserType_lftSimilarDocumentsToFragment.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocumentsToFragment.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftSimilarDocumentsToFragment }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
