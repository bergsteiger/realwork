unit kwPermanentFilterExists;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Words"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwPermanentFilterExists.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 Поддержка тестов::F1 Words::Words::PermanentFilterExists
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
  FiltersUnit,
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _kwPermanentFilterExistsUses_Parent_ = TtfwRegisterableWord;
 {$Include ..\F1_Words\kwPermanentFilterExistsUses.imp.pas}
 TkwPermanentFilterExists = {abstract scriptword} class(_kwPermanentFilterExistsUses_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // protected methods
   function GetFilters: IFiltersFromQuery; virtual; abstract;
 end;//TkwPermanentFilterExists
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  DataAdapter
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\F1_Words\kwPermanentFilterExistsUses.imp.pas}

// start class TkwPermanentFilterExists

procedure TkwPermanentFilterExists.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53B2B1460348_var*
var
 l_Filters: IFiltersFromQuery;
 l_Filter: IFilterFromQuery;
 l_Result: Boolean;
 I: Integer;
//#UC END# *4DAEEDE10285_53B2B1460348_var*
begin
//#UC START# *4DAEEDE10285_53B2B1460348_impl*
 l_Result := False;
 l_Filters := GetFilters;
 try
  for I := l_Filters.Count - 1 downto 0 do
  begin
   l_Filters.pm_GetItem(I, l_Filter);
   try
    if l_Filter.GetPermanent then
    begin
     l_Result := True;
     Break;
    end;
   finally
    l_Filter := nil;
   end; 
  end;
 finally
  l_Filters := nil;
 end;
 aCtx.rEngine.PushBool(l_Result);
//#UC END# *4DAEEDE10285_53B2B1460348_impl*
end;//TkwPermanentFilterExists.DoDoIt

{$IfEnd} //not NoScripts

end.