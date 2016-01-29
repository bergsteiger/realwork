unit kwIsLegalPermanentFilterExists;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwIsLegalPermanentFilterExists.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::IsLegalPermanentFilterExists
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  kwPermanentFilterExists,
  FiltersUnit
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TkwIsLegalPermanentFilterExists = {final scriptword} class(TkwPermanentFilterExists)
 protected
 // realized methods
   function GetFilters: IFiltersFromQuery; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsLegalPermanentFilterExists
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwIsLegalPermanentFilterExists

function TkwIsLegalPermanentFilterExists.GetFilters: IFiltersFromQuery;
//#UC START# *53B2B2C800D6_53B2B2950270_var*
//#UC END# *53B2B2C800D6_53B2B2950270_var*
begin
//#UC START# *53B2B2C800D6_53B2B2950270_impl*
 DefDataAdapter.NativeAdapter.MakeFiltersManager.GetLegalFilters(Result);
//#UC END# *53B2B2C800D6_53B2B2950270_impl*
end;//TkwIsLegalPermanentFilterExists.GetFilters

class function TkwIsLegalPermanentFilterExists.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsLegalPermanentFilterExists';
end;//TkwIsLegalPermanentFilterExists.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация IsLegalPermanentFilterExists
 TkwIsLegalPermanentFilterExists.RegisterInEngine;
{$IfEnd} //not NoScripts

end.