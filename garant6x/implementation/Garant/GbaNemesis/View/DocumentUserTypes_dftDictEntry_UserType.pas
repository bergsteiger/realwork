unit DocumentUserTypes_dftDictEntry_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftDictEntry_UserType.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftDictEntry
//
// Текст словарной статьи
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
  DocumentUserTypes_dftRelatedSynchroView_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { Константы для типа формы dftDictEntry }
  dftDictEntryName = 'dftDictEntry';
   { Строковый идентификатор пользовательского типа "Текст словарной статьи" }
  dftDictEntry = TvcmUserType(dftRelatedSynchroView + 1);
   { Текст словарной статьи }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftDictEntry = {final scriptword} class(TtfwInteger)
   {* Слово словаря для типа формы dftDictEntry }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftDictEntry
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftDictEntry

class function Tkw_FormUserType_dftDictEntry.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'тип_формы::dftDictEntry';
end;//Tkw_FormUserType_dftDictEntry.GetWordNameForRegister

function Tkw_FormUserType_dftDictEntry.GetInteger: Integer;
 {-}
begin
 Result := dftDictEntry;
end;//Tkw_FormUserType_dftDictEntry.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_FormUserType_dftDictEntry
 Tkw_FormUserType_dftDictEntry.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.