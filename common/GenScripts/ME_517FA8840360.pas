unit kwDisableMergedCellFilter;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwDisableMergedCellFilter.pas"
// Стереотип: "ScriptKeyword"
// Элемент модели: "DisableMergedCellFilter" MUID: (517FA8840360)
// Имя типа: "TkwDisableMergedCellFilter"

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
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
 end;//TkwDisableMergedCellFilter
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , evCommonUtils
;

class function TkwDisableMergedCellFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'DisableMergedCellFilter';
end;//TkwDisableMergedCellFilter.GetWordNameForRegister

procedure TkwDisableMergedCellFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_517FA8840360_var*
//#UC END# *4DAEEDE10285_517FA8840360_var*
begin
//#UC START# *4DAEEDE10285_517FA8840360_impl*
 g_DisableMergeCellFilter := True;
//#UC END# *4DAEEDE10285_517FA8840360_impl*
end;//TkwDisableMergedCellFilter.DoDoIt

initialization
 TkwDisableMergedCellFilter.RegisterInEngine;
 {* Регистрация DisableMergedCellFilter }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
