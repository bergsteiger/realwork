unit kwDisableMergedCellFilter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwDisableMergedCellFilter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::EverestArchiWords::DisableMergedCellFilter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwDisableMergedCellFilter = {final scriptword} class(TtfwRegisterableWord)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwDisableMergedCellFilter
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  evCommonUtils
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwDisableMergedCellFilter

procedure TkwDisableMergedCellFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_517FA8840360_var*
//#UC END# *4DAEEDE10285_517FA8840360_var*
begin
//#UC START# *4DAEEDE10285_517FA8840360_impl*
 g_DisableMergeCellFilter := True;
//#UC END# *4DAEEDE10285_517FA8840360_impl*
end;//TkwDisableMergedCellFilter.DoDoIt

class function TkwDisableMergedCellFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'DisableMergedCellFilter';
end;//TkwDisableMergedCellFilter.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� DisableMergedCellFilter
 TkwDisableMergedCellFilter.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.