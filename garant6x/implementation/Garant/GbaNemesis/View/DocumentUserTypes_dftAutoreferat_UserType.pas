unit DocumentUserTypes_dftAutoreferat_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAutoreferat_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAutoreferat
//
// ПРАЙМ. Моя новостная лента
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
  DocumentUserTypes_dftMedDictEntry_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftAutoreferat }
  dftAutoreferatName = 'dftAutoreferat';
   { Строковый идентификатор пользовательского типа "ПРАЙМ. Моя новостная лента" }
  dftAutoreferat = TvcmUserType(dftMedDictEntry + 1);
   { ПРАЙМ. Моя новостная лента }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAutoreferat = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftAutoreferat }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAutoreferat
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAutoreferat

class function Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftAutoreferat';
end;//Tkw_FormUserType_dftAutoreferat.GetWordNameForRegister

function Tkw_FormUserType_dftAutoreferat.GetInteger: Integer;
 {-}
begin
 Result := dftAutoreferat;
end;//Tkw_FormUserType_dftAutoreferat.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftAutoreferat
 Tkw_FormUserType_dftAutoreferat.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.