unit kwPermanentFilterExists;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\kwPermanentFilterExists.pas"
// Стереотип: "ScriptKeyword"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , FiltersUnit
 , tfwScriptingInterfaces
;

type
 _kwPermanentFilterExistsUses_Parent_ = TtfwRegisterableWord;
 {$Include kwPermanentFilterExistsUses.imp.pas}
 TkwPermanentFilterExists = {abstract} class(_kwPermanentFilterExistsUses_)
  protected
   function GetFilters: IFiltersFromQuery; virtual; abstract;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwPermanentFilterExists
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DataAdapter
;

{$Include kwPermanentFilterExistsUses.imp.pas}

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
{$IfEnd} // NOT Defined(NoScripts)

end.
