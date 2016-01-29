unit kwShowMailMessage;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwShowMailMessage.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::Scripting::TkwShowMailMessage
//
// ShowMailWindow
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
 TkwShowMailMessage = {scriptword} class(TtfwRegisterableWord)
  {* ShowMailWindow }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwShowMailMessage
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwShowMailMessage

procedure TkwShowMailMessage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4F0C26900161_var*
//#UC END# *4DAEEDE10285_4F0C26900161_var*
begin
//#UC START# *4DAEEDE10285_4F0C26900161_impl*
 if aCtx.rEngine.IsTopInt then
  ArShowMailWindow(aCtx.rEngine.PopInt)
 else
  Assert(False, '�� ����� ����� ��������� ���������.');
//#UC END# *4DAEEDE10285_4F0C26900161_impl*
end;//TkwShowMailMessage.DoDoIt

class function TkwShowMailMessage.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'ShowMailWindow';
end;//TkwShowMailMessage.GetWordNameForRegister

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� TkwShowMailMessage
 TkwShowMailMessage.RegisterInEngine;
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts

end.