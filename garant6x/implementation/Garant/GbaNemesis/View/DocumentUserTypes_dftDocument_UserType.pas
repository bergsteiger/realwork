unit DocumentUserTypes_dftDocument_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftDocument_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftDocument
//
// Текст
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
  DocumentUserTypes_dftNone_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftDocument }
  dftDocumentName = 'dftDocument';
   { Строковый идентификатор пользовательского типа "Текст" }
  dftDocument = TvcmUserType(dftNone + 1);
   { Текст }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftDocument = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftDocument }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftDocument
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftDocument

class function Tkw_FormUserType_dftDocument.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftDocument';
end;//Tkw_FormUserType_dftDocument.GetWordNameForRegister

function Tkw_FormUserType_dftDocument.GetInteger: Integer;
 {-}
begin
 Result := dftDocument;
end;//Tkw_FormUserType_dftDocument.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftDocument
 Tkw_FormUserType_dftDocument.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.