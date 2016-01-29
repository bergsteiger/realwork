unit DocumentUserTypes_dftMedDictEntry_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftMedDictEntry_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftMedDictEntry
//
// Описание медицинского термина
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
  DocumentUserTypes_dftTips_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftMedDictEntry }
  dftMedDictEntryName = 'dftMedDictEntry';
   { Строковый идентификатор пользовательского типа "Описание медицинского термина" }
  dftMedDictEntry = TvcmUserType(dftTips + 1);
   { Описание медицинского термина }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftMedDictEntry = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftMedDictEntry }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftMedDictEntry
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftMedDictEntry

class function Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftMedDictEntry';
end;//Tkw_FormUserType_dftMedDictEntry.GetWordNameForRegister

function Tkw_FormUserType_dftMedDictEntry.GetInteger: Integer;
 {-}
begin
 Result := dftMedDictEntry;
end;//Tkw_FormUserType_dftMedDictEntry.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftMedDictEntry
 Tkw_FormUserType_dftMedDictEntry.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.