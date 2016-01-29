unit ListUserTypes_lftSimilarDocuments_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftSimilarDocuments_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftSimilarDocuments
//
// Похожие документы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ListUserTypes_lftConsultation_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы lftSimilarDocuments }
  lftSimilarDocumentsName = 'lftSimilarDocuments';
   { Строковый идентификатор пользовательского типа "Похожие документы" }
  lftSimilarDocuments = TvcmUserType(lftConsultation + 1);
   { Похожие документы }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftSimilarDocuments = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftSimilarDocuments }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftSimilarDocuments
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftSimilarDocuments

class function Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftSimilarDocuments';
end;//Tkw_FormUserType_lftSimilarDocuments.GetWordNameForRegister

function Tkw_FormUserType_lftSimilarDocuments.GetInteger: Integer;
 {-}
begin
 Result := lftSimilarDocuments;
end;//Tkw_FormUserType_lftSimilarDocuments.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftSimilarDocuments
 Tkw_FormUserType_lftSimilarDocuments.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.