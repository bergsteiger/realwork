unit DocumentUserTypes_dftDrug_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftDrug_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftDrug
//
// Описание препарата
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
  DocumentUserTypes_dftAutoreferat_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftDrug }
  dftDrugName = 'dftDrug';
   { Строковый идентификатор пользовательского типа "Описание препарата" }
  dftDrug = TvcmUserType(dftAutoreferat + 1);
   { Описание препарата }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftDrug = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftDrug }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftDrug
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftDrug

class function Tkw_FormUserType_dftDrug.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftDrug';
end;//Tkw_FormUserType_dftDrug.GetWordNameForRegister

function Tkw_FormUserType_dftDrug.GetInteger: Integer;
 {-}
begin
 Result := dftDrug;
end;//Tkw_FormUserType_dftDrug.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftDrug
 Tkw_FormUserType_dftDrug.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.