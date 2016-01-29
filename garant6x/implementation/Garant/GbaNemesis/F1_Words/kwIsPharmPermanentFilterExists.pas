unit kwIsPharmPermanentFilterExists;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwIsPharmPermanentFilterExists.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::IsPharmPermanentFilterExists
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
 TkwIsPharmPermanentFilterExists = {final scriptword} class(TkwPermanentFilterExists)
 protected
 // realized methods
   function GetFilters: IFiltersFromQuery; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsPharmPermanentFilterExists
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TkwIsPharmPermanentFilterExists

function TkwIsPharmPermanentFilterExists.GetFilters: IFiltersFromQuery;
//#UC START# *53B2B2C800D6_53B2B2730077_var*
//#UC END# *53B2B2C800D6_53B2B2730077_var*
begin
//#UC START# *53B2B2C800D6_53B2B2730077_impl*
 DefDataAdapter.NativeAdapter.MakeFiltersManager.GetPharmFilters(Result);
//#UC END# *53B2B2C800D6_53B2B2730077_impl*
end;//TkwIsPharmPermanentFilterExists.GetFilters

class function TkwIsPharmPermanentFilterExists.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IsPharmPermanentFilterExists';
end;//TkwIsPharmPermanentFilterExists.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация IsPharmPermanentFilterExists
 TkwIsPharmPermanentFilterExists.RegisterInEngine;
{$IfEnd} //not NoScripts

end.