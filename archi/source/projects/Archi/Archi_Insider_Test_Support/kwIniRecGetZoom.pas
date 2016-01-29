unit kwIniRecGetZoom;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwIniRecGetZoom.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwIniRecGetZoom
//
// IniRec:GetZoom
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
 TkwIniRecGetZoom = {scriptword} class(TtfwRegisterableWord)
  {* IniRec:GetZoom }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwIniRecGetZoom
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwIniRecGetZoom

procedure TkwIniRecGetZoom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E8307CE0359_var*
//#UC END# *4DAEEDE10285_4E8307CE0359_var*
begin
//#UC START# *4DAEEDE10285_4E8307CE0359_impl*
 aCtx.rEngine.PushInt(ArIniRecGetZoom);
//#UC END# *4DAEEDE10285_4E8307CE0359_impl*
end;//TkwIniRecGetZoom.DoDoIt

class function TkwIniRecGetZoom.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'IniRec:GetZoom';
end;//TkwIniRecGetZoom.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwIniRecGetZoom
 TkwIniRecGetZoom.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.