unit DocumentUserTypes_dftAnnotation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAnnotation_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAnnotation
//
// Аннотация
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
  DocumentUserTypes_dftDictSubEntry_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftAnnotation }
  dftAnnotationName = 'dftAnnotation';
   { Строковый идентификатор пользовательского типа "Аннотация" }
  dftAnnotation = TvcmUserType(dftDictSubEntry + 1);
   { Аннотация }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAnnotation = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftAnnotation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAnnotation
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAnnotation

class function Tkw_FormUserType_dftAnnotation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftAnnotation';
end;//Tkw_FormUserType_dftAnnotation.GetWordNameForRegister

function Tkw_FormUserType_dftAnnotation.GetInteger: Integer;
 {-}
begin
 Result := dftAnnotation;
end;//Tkw_FormUserType_dftAnnotation.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftAnnotation
 Tkw_FormUserType_dftAnnotation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.