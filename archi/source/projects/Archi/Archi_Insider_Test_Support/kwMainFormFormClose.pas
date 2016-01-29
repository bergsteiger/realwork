unit kwMainFormFormClose;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/kwMainFormFormClose.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::MainForm_FormClose
//
// ��������� ���������� FormClose ������� �����, �������� ����� ���������� ��� � �������� ���������.
// ������:
// {code}
// MainForm:FormClose
// {code}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
type
 TkwMainFormFormClose = {final scriptword} class(TtfwRegisterableWord)
  {* ��������� ���������� FormClose ������� �����, �������� ����� ���������� ��� � �������� ���������.
������: 
[code]
MainForm:FormClose
[code] }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwMainFormFormClose
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  arArchiTestAdapter2
  ;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}

// start class TkwMainFormFormClose

procedure TkwMainFormFormClose.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_53EB19070285_var*
//#UC END# *4DAEEDE10285_53EB19070285_var*
begin
//#UC START# *4DAEEDE10285_53EB19070285_impl*
 AcMainFormFormClose;
//#UC END# *4DAEEDE10285_53EB19070285_impl*
end;//TkwMainFormFormClose.DoDoIt

class function TkwMainFormFormClose.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'MainForm:FormClose';
end;//TkwMainFormFormClose.GetWordNameForRegister

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� MainForm_FormClose
 TkwMainFormFormClose.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.