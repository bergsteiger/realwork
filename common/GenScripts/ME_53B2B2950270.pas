unit kwIsLegalPermanentFilterExists;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIsLegalPermanentFilterExists.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwPermanentFilterExists
 , FiltersUnit
;

type
 TkwIsLegalPermanentFilterExists = {final} class(TkwPermanentFilterExists)
  protected
   function GetFilters: IFiltersFromQuery; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsLegalPermanentFilterExists
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
;

function TkwIsLegalPermanentFilterExists.GetFilters: IFiltersFromQuery;
//#UC START# *53B2B2C800D6_53B2B2950270_var*
//#UC END# *53B2B2C800D6_53B2B2950270_var*
begin
//#UC START# *53B2B2C800D6_53B2B2950270_impl*
 DefDataAdapter.NativeAdapter.MakeFiltersManager.GetLegalFilters(Result);
//#UC END# *53B2B2C800D6_53B2B2950270_impl*
end;//TkwIsLegalPermanentFilterExists.GetFilters

class function TkwIsLegalPermanentFilterExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsLegalPermanentFilterExists';
end;//TkwIsLegalPermanentFilterExists.GetWordNameForRegister

initialization
 TkwIsLegalPermanentFilterExists.RegisterInEngine;
 {* Регистрация IsLegalPermanentFilterExists }
{$IfEnd} // NOT Defined(NoScripts)

end.
