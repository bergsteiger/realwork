unit kwIsPharmPermanentFilterExists;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwIsPharmPermanentFilterExists.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "IsPharmPermanentFilterExists" MUID: (53B2B2730077)
// Имя типа: "TkwIsPharmPermanentFilterExists"

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , kwPermanentFilterExists
 , FiltersUnit
;

type
 TkwIsPharmPermanentFilterExists = {final} class(TkwPermanentFilterExists)
  protected
   function GetFilters: IFiltersFromQuery; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIsPharmPermanentFilterExists
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
;

function TkwIsPharmPermanentFilterExists.GetFilters: IFiltersFromQuery;
//#UC START# *53B2B2C800D6_53B2B2730077_var*
//#UC END# *53B2B2C800D6_53B2B2730077_var*
begin
//#UC START# *53B2B2C800D6_53B2B2730077_impl*
 DefDataAdapter.NativeAdapter.MakeFiltersManager.GetPharmFilters(Result);
//#UC END# *53B2B2C800D6_53B2B2730077_impl*
end;//TkwIsPharmPermanentFilterExists.GetFilters

class function TkwIsPharmPermanentFilterExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsPharmPermanentFilterExists';
end;//TkwIsPharmPermanentFilterExists.GetWordNameForRegister

initialization
 TkwIsPharmPermanentFilterExists.RegisterInEngine;
 {* Регистрация IsPharmPermanentFilterExists }
{$IfEnd} // NOT Defined(NoScripts)

end.
