unit ListUserTypes_lftSimilarDocuments_UserType;
 {* Похожие документы }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftSimilarDocuments_UserType.pas"
// Стереотип: "UserType"
// Элемент модели: "lftSimilarDocuments" MUID: (4BD589E40083)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftConsultation_UserType
 , l3StringIDEx
;

const
 {* Локализуемые строки lftSimilarDocumentsLocalConstants }
 str_lftSimilarDocumentsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsCaption'; rValue : 'Похожие документы');
  {* Заголовок пользовательского типа "Похожие документы" }
 str_lftSimilarDocumentsSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftSimilarDocumentsSettingsCaption'; rValue : 'Список: Похожие документы');
  {* Заголовок пользовательского типа "Похожие документы" для настройки панелей инструментов }
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

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_lftSimilarDocuments = {final} class(TtfwInteger)
  {* Слово словаря для типа формы lftSimilarDocuments }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftSimilarDocuments
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftSimilarDocuments.GetInteger: Integer;
begin
 Result := lftSimilarDocuments;
end;//Tkw_FormUserType_lftSimilarDocuments.GetInteger

class function Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister: AnsiString;
begin
 Result := 'тип_формы::lftSimilarDocuments';
end;//Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftSimilarDocumentsCaption.Init;
 {* Инициализация str_lftSimilarDocumentsCaption }
 str_lftSimilarDocumentsSettingsCaption.Init;
 {* Инициализация str_lftSimilarDocumentsSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftSimilarDocuments.RegisterInEngine;
 {* Регистрация Tkw_FormUserType_lftSimilarDocuments }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
