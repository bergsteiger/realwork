unit tfwScriptEngine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// �����: ����� �.�.
// ������: "tfwScriptEngine.pas"
// �����: 20.04.2011 18:16
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine::Scripting Axiomatics::TtfwScriptEngine
//
// ������ ��� ���������� ��������. ������� �����.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwStreamFactory,
  tfwFileStreamFactory,
  tfwStringStreamFactory
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 TtfwScriptEngine = class
  {* ������ ��� ���������� ��������. ������� �����. }
 public
 // public methods
   class procedure Script(aStream: TtfwStreamFactory;
     const aCaller: ItfwScriptCaller); overload; 
   class procedure Script(const aString: AnsiString;
     const aCaller: ItfwScriptCaller); overload; 
   class procedure ScriptFromFile(const aFileName: AnsiString;
     const aCaller: ItfwScriptCaller);
 end;//TtfwScriptEngine
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  SysUtils,
  l3Chars,
  TypInfo,
  l3String,
  l3Types,
  kwEmitString,
  kwTryFinally,
  kwMain,
  kwCompiledWord,
  l3Base,
  tfwAutoregisteredDiction,
  tfwParser
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class TtfwScriptEngine

class procedure TtfwScriptEngine.Script(aStream: TtfwStreamFactory;
  const aCaller: ItfwScriptCaller);
//#UC START# *4DAEEB9602CF_4DAEEA9E0049_var*
var
 l_Main : TkwMain;
//#UC END# *4DAEEB9602CF_4DAEEA9E0049_var*
begin
//#UC START# *4DAEEB9602CF_4DAEEA9E0049_impl*
 l_Main := TkwMain.Create;
 try
  l_Main.Script(aStream, aCaller);
 finally
  FreeAndNil(l_Main);
 end;//try..finally
//#UC END# *4DAEEB9602CF_4DAEEA9E0049_impl*
end;//TtfwScriptEngine.Script

class procedure TtfwScriptEngine.Script(const aString: AnsiString;
  const aCaller: ItfwScriptCaller);
//#UC START# *4DAEEBC90028_4DAEEA9E0049_var*
//#UC END# *4DAEEBC90028_4DAEEA9E0049_var*
var
 l_SS : TtfwStringStreamFactory;
begin
//#UC START# *4DAEEBC90028_4DAEEA9E0049_impl*
 l_SS := TtfwStringStreamFactory.Create(aString);
 try
  Script(l_SS, aCaller);
 finally
  FreeAndNil(l_SS);
 end;//try..finally
//#UC END# *4DAEEBC90028_4DAEEA9E0049_impl*
end;//TtfwScriptEngine.Script

class procedure TtfwScriptEngine.ScriptFromFile(const aFileName: AnsiString;
  const aCaller: ItfwScriptCaller);
//#UC START# *4DB02B590048_4DAEEA9E0049_var*
//#UC END# *4DB02B590048_4DAEEA9E0049_var*
var
 l_FS : TtfwFileStreamFactory;
begin
//#UC START# *4DB02B590048_4DAEEA9E0049_impl*
 //l_FS := Tl3FileStream.Create(aFileName, l3_fmRead);
 l_FS := TtfwFileStreamFactory.Create(aFileName);
 try
  Script(l_FS, aCaller);
 finally
  FreeAndNil(l_FS);
 end;//try..finally
//#UC END# *4DB02B590048_4DAEEA9E0049_impl*
end;//TtfwScriptEngine.ScriptFromFile

{$IfEnd} //not NoScripts

end.