unit ListUserTypes_lftSimilarDocumentsToFragment_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftSimilarDocumentsToFragment_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftSimilarDocumentsToFragment
//
// Похожие к фрагменту
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
  ListUserTypes_lftSimilarDocuments_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  ListUserTypes_lftRToPart_UserType
  ;

const
   { Константы для типа формы lftSimilarDocumentsToFragment }
  lftSimilarDocumentsToFragmentName = 'lftSimilarDocumentsToFragment';
   { Строковый идентификатор пользовательского типа "Похожие к фрагменту" }
  lftSimilarDocumentsToFragment = TvcmUserType(lftRToPart + 1);
   { Похожие к фрагменту }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftSimilarDocumentsToFragment = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы lftSimilarDocumentsToFragment }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftSimilarDocumentsToFragment
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftSimilarDocumentsToFragment

class function Tkw_FormUserType_lftSimilarDocumentsToFragment.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::lftSimilarDocumentsToFragment';
end;//Tkw_FormUserType_lftSimilarDocumentsToFragment.GetWordNameForRegister

function Tkw_FormUserType_lftSimilarDocumentsToFragment.GetInteger: Integer;
 {-}
begin
 Result := lftSimilarDocumentsToFragment;
end;//Tkw_FormUserType_lftSimilarDocumentsToFragment.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_lftSimilarDocumentsToFragment
 Tkw_FormUserType_lftSimilarDocumentsToFragment.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.