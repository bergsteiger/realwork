unit DocumentUserTypes_dftMedicFirm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftMedicFirm_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftMedicFirm
//
// Описание фирмы
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
  DocumentUserTypes_dftDrug_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftMedicFirm }
  dftMedicFirmName = 'dftMedicFirm';
   { Строковый идентификатор пользовательского типа "Описание фирмы" }
  dftMedicFirm = TvcmUserType(dftDrug + 1);
   { Описание фирмы }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftMedicFirm = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftMedicFirm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftMedicFirm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftMedicFirm

class function Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftMedicFirm';
end;//Tkw_FormUserType_dftMedicFirm.GetWordNameForRegister

function Tkw_FormUserType_dftMedicFirm.GetInteger: Integer;
 {-}
begin
 Result := dftMedicFirm;
end;//Tkw_FormUserType_dftMedicFirm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftMedicFirm
 Tkw_FormUserType_dftMedicFirm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.