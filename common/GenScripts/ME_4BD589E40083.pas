unit ListUserTypes_lftSimilarDocuments_UserType;
 {* Похожие документы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocuments_UserType.pas"
// Стереотип: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftConsultation_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* Константы для типа формы lftSimilarDocuments }
 lftSimilarDocumentsName = 'lftSimilarDocuments';
  {* Строковый идентификатор пользовательского типа "Похожие документы" }
 lftSimilarDocuments = TvcmUserType(lftConsultation + 1);
  {* Похожие документы }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocuments = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftSimilarDocuments }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_lftSimilarDocuments
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftSimilarDocuments';
end;//Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister

function Tkw_FormUserType_lftSimilarDocuments.GetInteger: Integer;
begin
 Result := lftSimilarDocuments;
end;//Tkw_FormUserType_lftSimilarDocuments.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocuments.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftSimilarDocuments }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
