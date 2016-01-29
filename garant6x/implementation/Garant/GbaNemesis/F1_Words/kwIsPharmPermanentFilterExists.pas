unit kwIsPharmPermanentFilterExists;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwIsPharmPermanentFilterExists.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::IsPharmPermanentFilterExists
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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
// ����������� IsPharmPermanentFilterExists
 TkwIsPharmPermanentFilterExists.RegisterInEngine;
{$IfEnd} //not NoScripts

end.