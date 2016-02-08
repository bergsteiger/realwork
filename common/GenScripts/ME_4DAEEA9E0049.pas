unit tfwScriptEngine;
 {* Машина для исполнения скриптов. Базовый класс. }

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwScriptEngine.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwStreamFactory
 , tfwScriptingInterfaces
 , tfwStringStreamFactory
 , tfwFileStreamFactory
;

type
 TtfwScriptEngine = class
  {* Машина для исполнения скриптов. Базовый класс. }
  public
   class procedure Script(aStream: TtfwStreamFactory;
    const aCaller: ItfwScriptCaller); overload;
   class procedure Script(const aString: AnsiString;
    const aCaller: ItfwScriptCaller); overload;
   class procedure ScriptFromFile(const aFileName: AnsiString;
    const aCaller: ItfwScriptCaller);
 end;//TtfwScriptEngine
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3String
 , kwEmitString
 , kwTryFinally
 , kwMain
 , kwCompiledWord
 , l3Base
 , tfwAutoregisteredDiction
 , tfwParser
 , SysUtils
 , l3Chars
 , TypInfo
 , l3Types
;

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
var l_SS: TtfwStringStreamFactory;
//#UC START# *4DAEEBC90028_4DAEEA9E0049_var*
//#UC END# *4DAEEBC90028_4DAEEA9E0049_var*
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
var l_FS: TtfwFileStreamFactory;
//#UC START# *4DB02B590048_4DAEEA9E0049_var*
//#UC END# *4DB02B590048_4DAEEA9E0049_var*
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
{$IfEnd} // NOT Defined(NoScripts)

end.
