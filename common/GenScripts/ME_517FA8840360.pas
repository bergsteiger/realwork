unit kwDisableMergedCellFilter;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDisableMergedCellFilter.pas"
// Стереотип: "ScriptKeyword"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
;

type
 TkwDisableMergedCellFilter = {final} class(TtfwRegisterableWord)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDisableMergedCellFilter
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCommonUtils
;

procedure TkwDisableMergedCellFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_517FA8840360_var*
//#UC END# *4DAEEDE10285_517FA8840360_var*
begin
//#UC START# *4DAEEDE10285_517FA8840360_impl*
 g_DisableMergeCellFilter := True;
//#UC END# *4DAEEDE10285_517FA8840360_impl*
end;//TkwDisableMergedCellFilter.DoDoIt

class function TkwDisableMergedCellFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'DisableMergedCellFilter';
end;//TkwDisableMergedCellFilter.GetWordNameForRegister

initialization
 TkwDisableMergedCellFilter.RegisterInEngine;
 {* Регистрация DisableMergedCellFilter }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
