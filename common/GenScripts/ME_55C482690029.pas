unit tfwDefaultScriptCaller;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwDefaultScriptCaller.pas"
// Стереотип: "SimpleClass"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3ProtoObject
 , tfwScriptingInterfaces
 , l3Interfaces
;

type
 TtfwDefaultScriptCaller = class(Tl3ProtoObject, ItfwScriptCaller)
  protected
   class function DictPath: AnsiString; virtual;
   function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
   function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
   function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
   function KPage: AnsiString;
   procedure ToLog(const aSt: AnsiString);
   function CompileOnly: Boolean;
  public
   procedure DoPrint(const aStr: Tl3WString); virtual;
   constructor Create; reintroduce;
   class function Make: ItfwScriptCaller; reintroduce;
   class function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString; virtual;
   procedure CheckOutputWithInput(const aIn: AnsiString;
    const aOut: AnsiString;
    aHeaderBegin: AnsiChar;
    aEtalonNeedsComputerName: Boolean;
    aEtalonCanHaveDiff: Boolean;
    const anExtraFileName: AnsiString;
    aNeedsCheck: Boolean); overload;
   procedure Check(aCondition: Boolean;
    const aMessage: AnsiString = '');
    {* Проверяет инвариант }
   procedure Print(const aStr: Tl3WString); overload;
   procedure Print(const aStr: Il3CString); overload;
   procedure CheckWithEtalon(const aFileName: AnsiString;
    aHeaderBegin: AnsiChar);
   procedure CheckPrintEtalon(const aLogName: AnsiString;
    const aOutputName: AnsiString);
   function ShouldStop: Boolean;
   procedure CheckTimeout(aNow: Cardinal;
    aTimeout: Cardinal);
   function StartTimer: Longword;
   function StopTimer(const aSt: AnsiString = '';
    const aSubName: AnsiString = '';
    aNeedTimeToLog: Boolean = True): Longword;
   procedure CheckOutputWithInput(const aSt: AnsiString;
    aHeaderBegin: AnsiChar = #0;
    const anExtraFileName: AnsiString = '';
    aNeedsCheck: Boolean = True); overload;
   function GetIsWritingToK: Boolean;
   function GetIsFakeCVS: Boolean;
   function GetCVSPath: AnsiString;
   procedure DontRaiseIfEtalonCreated;
   procedure TimeToLog(aTime: Cardinal;
    const aSt: AnsiString;
    const aSubName: AnsiString);
   function GetTestSetFolderName: AnsiString;
   function GetEtalonSuffix: AnsiString;
   procedure CheckPictureOnly;
 end;//TtfwDefaultScriptCaller
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3FileUtils
 , l3String
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
;

procedure TtfwDefaultScriptCaller.DoPrint(const aStr: Tl3WString);
//#UC START# *55C491FC025C_55C482690029_var*
//#UC END# *55C491FC025C_55C482690029_var*
begin
//#UC START# *55C491FC025C_55C482690029_impl*
 // - ничего не делаем
//#UC END# *55C491FC025C_55C482690029_impl*
end;//TtfwDefaultScriptCaller.DoPrint

constructor TtfwDefaultScriptCaller.Create;
//#UC START# *55C4A52C01A0_55C482690029_var*
//#UC END# *55C4A52C01A0_55C482690029_var*
begin
//#UC START# *55C4A52C01A0_55C482690029_impl*
 inherited Create;
//#UC END# *55C4A52C01A0_55C482690029_impl*
end;//TtfwDefaultScriptCaller.Create

class function TtfwDefaultScriptCaller.Make: ItfwScriptCaller;
var
 l_Inst : TtfwDefaultScriptCaller;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwDefaultScriptCaller.Make

class function TtfwDefaultScriptCaller.DictPath: AnsiString;
//#UC START# *55CC867301F7_55C482690029_var*
//#UC END# *55CC867301F7_55C482690029_var*
begin
//#UC START# *55CC867301F7_55C482690029_impl*
 Result := ExtractFilePath(ParamStr(0));
//#UC END# *55CC867301F7_55C482690029_impl*
end;//TtfwDefaultScriptCaller.DictPath

class function TtfwDefaultScriptCaller.DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *55D34AD90105_55C482690029_var*
//#UC END# *55D34AD90105_55C482690029_var*
begin
//#UC START# *55D34AD90105_55C482690029_impl*
 if (ExtractFilePath(aFile) <> '') then
  Result := aFile
 else
  Result := ConcatDirName(DictPath, aFile);
//#UC END# *55D34AD90105_55C482690029_impl*
end;//TtfwDefaultScriptCaller.DoResolveIncludedFilePath

procedure TtfwDefaultScriptCaller.CheckOutputWithInput(const aIn: AnsiString;
 const aOut: AnsiString;
 aHeaderBegin: AnsiChar;
 aEtalonNeedsComputerName: Boolean;
 aEtalonCanHaveDiff: Boolean;
 const anExtraFileName: AnsiString;
 aNeedsCheck: Boolean);
//#UC START# *4CAEDCF9006A_55C482690029_var*
//#UC END# *4CAEDCF9006A_55C482690029_var*
begin
//#UC START# *4CAEDCF9006A_55C482690029_impl*
 Assert(false);
//#UC END# *4CAEDCF9006A_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CheckOutputWithInput

procedure TtfwDefaultScriptCaller.Check(aCondition: Boolean;
 const aMessage: AnsiString = '');
 {* Проверяет инвариант }
//#UC START# *4DAF1A280116_55C482690029_var*
//#UC END# *4DAF1A280116_55C482690029_var*
begin
//#UC START# *4DAF1A280116_55C482690029_impl*
 EtfwCheck.IsTrue(aCondition, aMessage);
//#UC END# *4DAF1A280116_55C482690029_impl*
end;//TtfwDefaultScriptCaller.Check

procedure TtfwDefaultScriptCaller.Print(const aStr: Tl3WString);
//#UC START# *4DB173AA005A_55C482690029_var*
//#UC END# *4DB173AA005A_55C482690029_var*
begin
//#UC START# *4DB173AA005A_55C482690029_impl*
 DoPrint(aStr);
//#UC END# *4DB173AA005A_55C482690029_impl*
end;//TtfwDefaultScriptCaller.Print

procedure TtfwDefaultScriptCaller.Print(const aStr: Il3CString);
//#UC START# *4DB1785F011A_55C482690029_var*
//#UC END# *4DB1785F011A_55C482690029_var*
begin
//#UC START# *4DB1785F011A_55C482690029_impl*
 DoPrint(l3PCharLen(aStr));
//#UC END# *4DB1785F011A_55C482690029_impl*
end;//TtfwDefaultScriptCaller.Print

function TtfwDefaultScriptCaller.ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DC2E1470046_55C482690029_var*
//#UC END# *4DC2E1470046_55C482690029_var*
begin
//#UC START# *4DC2E1470046_55C482690029_impl*
 Result := DoResolveIncludedFilePath(aFile);
//#UC END# *4DC2E1470046_55C482690029_impl*
end;//TtfwDefaultScriptCaller.ResolveIncludedFilePath

function TtfwDefaultScriptCaller.ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DCA915C0120_55C482690029_var*
//#UC END# *4DCA915C0120_55C482690029_var*
begin
//#UC START# *4DCA915C0120_55C482690029_impl*
 Result := aFile;
//#UC END# *4DCA915C0120_55C482690029_impl*
end;//TtfwDefaultScriptCaller.ResolveOutputFilePath

procedure TtfwDefaultScriptCaller.CheckWithEtalon(const aFileName: AnsiString;
 aHeaderBegin: AnsiChar);
//#UC START# *4DD533BF023D_55C482690029_var*
//#UC END# *4DD533BF023D_55C482690029_var*
begin
//#UC START# *4DD533BF023D_55C482690029_impl*
 Assert(false);
//#UC END# *4DD533BF023D_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CheckWithEtalon

function TtfwDefaultScriptCaller.ResolveInputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DECF57B02D2_55C482690029_var*
//#UC END# *4DECF57B02D2_55C482690029_var*
begin
//#UC START# *4DECF57B02D2_55C482690029_impl*
 Result := aFile;
//#UC END# *4DECF57B02D2_55C482690029_impl*
end;//TtfwDefaultScriptCaller.ResolveInputFilePath

procedure TtfwDefaultScriptCaller.CheckPrintEtalon(const aLogName: AnsiString;
 const aOutputName: AnsiString);
//#UC START# *4F0D7AC900FA_55C482690029_var*
//#UC END# *4F0D7AC900FA_55C482690029_var*
begin
//#UC START# *4F0D7AC900FA_55C482690029_impl*
 Assert(false);
//#UC END# *4F0D7AC900FA_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CheckPrintEtalon

function TtfwDefaultScriptCaller.ShouldStop: Boolean;
//#UC START# *4F0D8B740186_55C482690029_var*
//#UC END# *4F0D8B740186_55C482690029_var*
begin
//#UC START# *4F0D8B740186_55C482690029_impl*
 Result := false;
//#UC END# *4F0D8B740186_55C482690029_impl*
end;//TtfwDefaultScriptCaller.ShouldStop

procedure TtfwDefaultScriptCaller.CheckTimeout(aNow: Cardinal;
 aTimeout: Cardinal);
//#UC START# *4F0D8C360085_55C482690029_var*
//#UC END# *4F0D8C360085_55C482690029_var*
begin
//#UC START# *4F0D8C360085_55C482690029_impl*
 Assert(false);
//#UC END# *4F0D8C360085_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CheckTimeout

function TtfwDefaultScriptCaller.StartTimer: Longword;
//#UC START# *4F0D8C5A01A2_55C482690029_var*
//#UC END# *4F0D8C5A01A2_55C482690029_var*
begin
//#UC START# *4F0D8C5A01A2_55C482690029_impl*
 Assert(false);
//#UC END# *4F0D8C5A01A2_55C482690029_impl*
end;//TtfwDefaultScriptCaller.StartTimer

function TtfwDefaultScriptCaller.StopTimer(const aSt: AnsiString = '';
 const aSubName: AnsiString = '';
 aNeedTimeToLog: Boolean = True): Longword;
//#UC START# *4F0D8CB0015D_55C482690029_var*
//#UC END# *4F0D8CB0015D_55C482690029_var*
begin
//#UC START# *4F0D8CB0015D_55C482690029_impl*
 Assert(false);
//#UC END# *4F0D8CB0015D_55C482690029_impl*
end;//TtfwDefaultScriptCaller.StopTimer

function TtfwDefaultScriptCaller.KPage: AnsiString;
//#UC START# *4F0D91AA0080_55C482690029_var*
//#UC END# *4F0D91AA0080_55C482690029_var*
begin
//#UC START# *4F0D91AA0080_55C482690029_impl*
 Assert(false);
//#UC END# *4F0D91AA0080_55C482690029_impl*
end;//TtfwDefaultScriptCaller.KPage

procedure TtfwDefaultScriptCaller.ToLog(const aSt: AnsiString);
//#UC START# *4F0DA2A7024A_55C482690029_var*
//#UC END# *4F0DA2A7024A_55C482690029_var*
begin
//#UC START# *4F0DA2A7024A_55C482690029_impl*
 Assert(false);
//#UC END# *4F0DA2A7024A_55C482690029_impl*
end;//TtfwDefaultScriptCaller.ToLog

procedure TtfwDefaultScriptCaller.CheckOutputWithInput(const aSt: AnsiString;
 aHeaderBegin: AnsiChar = #0;
 const anExtraFileName: AnsiString = '';
 aNeedsCheck: Boolean = True);
//#UC START# *4F5F3C61023E_55C482690029_var*
//#UC END# *4F5F3C61023E_55C482690029_var*
begin
//#UC START# *4F5F3C61023E_55C482690029_impl*
 Assert(false);
//#UC END# *4F5F3C61023E_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CheckOutputWithInput

function TtfwDefaultScriptCaller.GetIsWritingToK: Boolean;
//#UC START# *4F72CEFE016D_55C482690029_var*
//#UC END# *4F72CEFE016D_55C482690029_var*
begin
//#UC START# *4F72CEFE016D_55C482690029_impl*
 Result := false;
//#UC END# *4F72CEFE016D_55C482690029_impl*
end;//TtfwDefaultScriptCaller.GetIsWritingToK

function TtfwDefaultScriptCaller.GetIsFakeCVS: Boolean;
//#UC START# *4F72CF27029A_55C482690029_var*
//#UC END# *4F72CF27029A_55C482690029_var*
begin
//#UC START# *4F72CF27029A_55C482690029_impl*
 Result := false;
//#UC END# *4F72CF27029A_55C482690029_impl*
end;//TtfwDefaultScriptCaller.GetIsFakeCVS

function TtfwDefaultScriptCaller.GetCVSPath: AnsiString;
//#UC START# *4F72CF78027D_55C482690029_var*
//#UC END# *4F72CF78027D_55C482690029_var*
begin
//#UC START# *4F72CF78027D_55C482690029_impl*
 Assert(false);
//#UC END# *4F72CF78027D_55C482690029_impl*
end;//TtfwDefaultScriptCaller.GetCVSPath

procedure TtfwDefaultScriptCaller.DontRaiseIfEtalonCreated;
//#UC START# *4F851D7B0399_55C482690029_var*
//#UC END# *4F851D7B0399_55C482690029_var*
begin
//#UC START# *4F851D7B0399_55C482690029_impl*
 Assert(false);
//#UC END# *4F851D7B0399_55C482690029_impl*
end;//TtfwDefaultScriptCaller.DontRaiseIfEtalonCreated

procedure TtfwDefaultScriptCaller.TimeToLog(aTime: Cardinal;
 const aSt: AnsiString;
 const aSubName: AnsiString);
//#UC START# *511BC7C60063_55C482690029_var*
//#UC END# *511BC7C60063_55C482690029_var*
begin
//#UC START# *511BC7C60063_55C482690029_impl*
 Assert(false);
//#UC END# *511BC7C60063_55C482690029_impl*
end;//TtfwDefaultScriptCaller.TimeToLog

function TtfwDefaultScriptCaller.GetTestSetFolderName: AnsiString;
//#UC START# *513866B10237_55C482690029_var*
//#UC END# *513866B10237_55C482690029_var*
begin
//#UC START# *513866B10237_55C482690029_impl*
 Assert(false);
//#UC END# *513866B10237_55C482690029_impl*
end;//TtfwDefaultScriptCaller.GetTestSetFolderName

function TtfwDefaultScriptCaller.GetEtalonSuffix: AnsiString;
//#UC START# *5138790002FF_55C482690029_var*
//#UC END# *5138790002FF_55C482690029_var*
begin
//#UC START# *5138790002FF_55C482690029_impl*
 Assert(false);
//#UC END# *5138790002FF_55C482690029_impl*
end;//TtfwDefaultScriptCaller.GetEtalonSuffix

function TtfwDefaultScriptCaller.CompileOnly: Boolean;
//#UC START# *52EBC5BB0300_55C482690029_var*
//#UC END# *52EBC5BB0300_55C482690029_var*
begin
//#UC START# *52EBC5BB0300_55C482690029_impl*
 Result := false;
//#UC END# *52EBC5BB0300_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CompileOnly

procedure TtfwDefaultScriptCaller.CheckPictureOnly;
//#UC START# *536A15F901DA_55C482690029_var*
//#UC END# *536A15F901DA_55C482690029_var*
begin
//#UC START# *536A15F901DA_55C482690029_impl*
 Assert(false);
//#UC END# *536A15F901DA_55C482690029_impl*
end;//TtfwDefaultScriptCaller.CheckPictureOnly
{$IfEnd} // NOT Defined(NoScripts)

end.
