unit DocumentUserTypes_dftRelatedDoc_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftRelatedDoc_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftRelatedDoc
//
// Справка
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
  DocumentUserTypes_dftDocument_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftRelatedDoc }
  dftRelatedDocName = 'dftRelatedDoc';
   { Строковый идентификатор пользовательского типа "Справка" }
  dftRelatedDoc = TvcmUserType(dftDocument + 1);
   { Справка }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftRelatedDoc = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftRelatedDoc }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftRelatedDoc
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftRelatedDoc

class function Tkw_FormUserType_dftRelatedDoc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftRelatedDoc';
end;//Tkw_FormUserType_dftRelatedDoc.GetWordNameForRegister

function Tkw_FormUserType_dftRelatedDoc.GetInteger: Integer;
 {-}
begin
 Result := dftRelatedDoc;
end;//Tkw_FormUserType_dftRelatedDoc.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftRelatedDoc
 Tkw_FormUserType_dftRelatedDoc.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.