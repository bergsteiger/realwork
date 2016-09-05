unit msmScriptCaller;

// Модуль: "w:\common\components\gui\Garant\msm\msmScriptCaller.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmScriptCaller" MUID: (57A9D663008F)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3CProtoObject
 {$If NOT Defined(NoScripts)}
 , tfwScriptingInterfaces
 {$IfEnd} // NOT Defined(NoScripts)
 , l3Interfaces
;

type
 TmsmScriptCaller = class(Tl3CProtoObject{$If NOT Defined(NoScripts)}
 , ItfwScriptCaller
 {$IfEnd} // NOT Defined(NoScripts)
 )
  protected
   procedure DoScriptDone(const aCtx: TtfwContext); virtual;
   procedure DoScriptWillRun(const aCtx: TtfwContext); virtual;
   {$If NOT Defined(NoScripts)}
   function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function KPage: AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure ToLog(const aSt: AnsiString);
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function CompileOnly: Boolean;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure ScriptDone(const aCtx: TtfwContext);
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure ScriptWillRun(const aCtx: TtfwContext);
   {$IfEnd} // NOT Defined(NoScripts)
  public
   constructor Create; reintroduce;
   class function Make: ItfwScriptCaller; reintroduce;
   procedure CheckOutputWithInput(const aIn: AnsiString;
    const aOut: AnsiString;
    aHeaderBegin: AnsiChar;
    aEtalonNeedsComputerName: Boolean;
    aEtalonCanHaveDiff: Boolean;
    const anExtraFileName: AnsiString;
    aNeedsCheck: Boolean); overload;
   {$If NOT Defined(NoScripts)}
   procedure Check(aCondition: Boolean;
    const aMessage: AnsiString = '');
    {* Проверяет инвариант }
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure Print(const aStr: Tl3WString); overload;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure Print(const aStr: Il3CString); overload;
   {$IfEnd} // NOT Defined(NoScripts)
   procedure CheckWithEtalon(const aFileName: AnsiString;
    aHeaderBegin: AnsiChar);
   {$If NOT Defined(NoScripts)}
   procedure CheckPrintEtalon(const aLogName: AnsiString;
    const aOutputName: AnsiString);
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function ShouldStop: Boolean;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure CheckTimeout(aNow: Cardinal;
    aTimeout: Cardinal);
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function StartTimer: Longword;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function StopTimer(const aSt: AnsiString = '';
    const aSubName: AnsiString = '';
    aNeedTimeToLog: Boolean = True): Longword;
   {$IfEnd} // NOT Defined(NoScripts)
   procedure CheckOutputWithInput(const aSt: AnsiString;
    aHeaderBegin: AnsiChar = #0;
    const anExtraFileName: AnsiString = '';
    aNeedsCheck: Boolean = True); overload;
   {$If NOT Defined(NoScripts)}
   function GetIsWritingToK: Boolean;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function GetIsFakeCVS: Boolean;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function GetCVSPath: AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure DontRaiseIfEtalonCreated;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   procedure TimeToLog(aTime: Cardinal;
    const aSt: AnsiString;
    const aSubName: AnsiString);
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function GetTestSetFolderName: AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   {$If NOT Defined(NoScripts)}
   function GetEtalonSuffix: AnsiString;
   {$IfEnd} // NOT Defined(NoScripts)
   procedure CheckPictureOnly;
 end;//TmsmScriptCaller

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , msmWordsCachePack
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *57A9D663008Fimpl_uses*
 , SysUtils
 , l3Base
 , l3String
 //#UC END# *57A9D663008Fimpl_uses*
;

constructor TmsmScriptCaller.Create;
//#UC START# *57A9D6940119_57A9D663008F_var*
//#UC END# *57A9D6940119_57A9D663008F_var*
begin
//#UC START# *57A9D6940119_57A9D663008F_impl*
 inherited Create;
//#UC END# *57A9D6940119_57A9D663008F_impl*
end;//TmsmScriptCaller.Create

class function TmsmScriptCaller.Make: ItfwScriptCaller;
var
 l_Inst : TmsmScriptCaller;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TmsmScriptCaller.Make

procedure TmsmScriptCaller.DoScriptDone(const aCtx: TtfwContext);
//#UC START# *57A9E4F203B5_57A9D663008F_var*
//#UC END# *57A9E4F203B5_57A9D663008F_var*
begin
//#UC START# *57A9E4F203B5_57A9D663008F_impl*
 // - ничего не делаем
//#UC END# *57A9E4F203B5_57A9D663008F_impl*
end;//TmsmScriptCaller.DoScriptDone

procedure TmsmScriptCaller.DoScriptWillRun(const aCtx: TtfwContext);
//#UC START# *57A9FED102C4_57A9D663008F_var*
//#UC END# *57A9FED102C4_57A9D663008F_var*
begin
//#UC START# *57A9FED102C4_57A9D663008F_impl*
 // - ничего не делаем
//#UC END# *57A9FED102C4_57A9D663008F_impl*
end;//TmsmScriptCaller.DoScriptWillRun

procedure TmsmScriptCaller.CheckOutputWithInput(const aIn: AnsiString;
 const aOut: AnsiString;
 aHeaderBegin: AnsiChar;
 aEtalonNeedsComputerName: Boolean;
 aEtalonCanHaveDiff: Boolean;
 const anExtraFileName: AnsiString;
 aNeedsCheck: Boolean);
//#UC START# *4CAEDCF9006A_57A9D663008F_var*
//#UC END# *4CAEDCF9006A_57A9D663008F_var*
begin
//#UC START# *4CAEDCF9006A_57A9D663008F_impl*
 Assert(false);
//#UC END# *4CAEDCF9006A_57A9D663008F_impl*
end;//TmsmScriptCaller.CheckOutputWithInput

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.Check(aCondition: Boolean;
 const aMessage: AnsiString = '');
 {* Проверяет инвариант }
//#UC START# *4DAF1A280116_57A9D663008F_var*
//#UC END# *4DAF1A280116_57A9D663008F_var*
begin
//#UC START# *4DAF1A280116_57A9D663008F_impl*
 Assert(false);
//#UC END# *4DAF1A280116_57A9D663008F_impl*
end;//TmsmScriptCaller.Check
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.Print(const aStr: Tl3WString);
//#UC START# *4DB173AA005A_57A9D663008F_var*
//#UC END# *4DB173AA005A_57A9D663008F_var*
begin
//#UC START# *4DB173AA005A_57A9D663008F_impl*
 l3System.Msg2Log(l3Str(aStr));
//#UC END# *4DB173AA005A_57A9D663008F_impl*
end;//TmsmScriptCaller.Print
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.Print(const aStr: Il3CString);
//#UC START# *4DB1785F011A_57A9D663008F_var*
//#UC END# *4DB1785F011A_57A9D663008F_var*
begin
//#UC START# *4DB1785F011A_57A9D663008F_impl*
 Print(l3PCharLen(aStr));
//#UC END# *4DB1785F011A_57A9D663008F_impl*
end;//TmsmScriptCaller.Print
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DC2E1470046_57A9D663008F_var*
//#UC END# *4DC2E1470046_57A9D663008F_var*
begin
//#UC START# *4DC2E1470046_57A9D663008F_impl*
 Result := aFile;
//#UC END# *4DC2E1470046_57A9D663008F_impl*
end;//TmsmScriptCaller.ResolveIncludedFilePath
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DCA915C0120_57A9D663008F_var*
//#UC END# *4DCA915C0120_57A9D663008F_var*
begin
//#UC START# *4DCA915C0120_57A9D663008F_impl*
 Result := aFile;
 Assert(ExtractFilePath(aFile) <> '');
//#UC END# *4DCA915C0120_57A9D663008F_impl*
end;//TmsmScriptCaller.ResolveOutputFilePath
{$IfEnd} // NOT Defined(NoScripts)

procedure TmsmScriptCaller.CheckWithEtalon(const aFileName: AnsiString;
 aHeaderBegin: AnsiChar);
//#UC START# *4DD533BF023D_57A9D663008F_var*
//#UC END# *4DD533BF023D_57A9D663008F_var*
begin
//#UC START# *4DD533BF023D_57A9D663008F_impl*
 Assert(false);
//#UC END# *4DD533BF023D_57A9D663008F_impl*
end;//TmsmScriptCaller.CheckWithEtalon

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.ResolveInputFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *4DECF57B02D2_57A9D663008F_var*
//#UC END# *4DECF57B02D2_57A9D663008F_var*
begin
//#UC START# *4DECF57B02D2_57A9D663008F_impl*
 Result := aFile;
 Assert(false);
//#UC END# *4DECF57B02D2_57A9D663008F_impl*
end;//TmsmScriptCaller.ResolveInputFilePath
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.CheckPrintEtalon(const aLogName: AnsiString;
 const aOutputName: AnsiString);
//#UC START# *4F0D7AC900FA_57A9D663008F_var*
//#UC END# *4F0D7AC900FA_57A9D663008F_var*
begin
//#UC START# *4F0D7AC900FA_57A9D663008F_impl*
 Assert(false);
//#UC END# *4F0D7AC900FA_57A9D663008F_impl*
end;//TmsmScriptCaller.CheckPrintEtalon
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.ShouldStop: Boolean;
//#UC START# *4F0D8B740186_57A9D663008F_var*
//#UC END# *4F0D8B740186_57A9D663008F_var*
begin
//#UC START# *4F0D8B740186_57A9D663008F_impl*
 Result := false;
 Assert(false);
//#UC END# *4F0D8B740186_57A9D663008F_impl*
end;//TmsmScriptCaller.ShouldStop
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.CheckTimeout(aNow: Cardinal;
 aTimeout: Cardinal);
//#UC START# *4F0D8C360085_57A9D663008F_var*
//#UC END# *4F0D8C360085_57A9D663008F_var*
begin
//#UC START# *4F0D8C360085_57A9D663008F_impl*
 Assert(false);
//#UC END# *4F0D8C360085_57A9D663008F_impl*
end;//TmsmScriptCaller.CheckTimeout
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.StartTimer: Longword;
//#UC START# *4F0D8C5A01A2_57A9D663008F_var*
//#UC END# *4F0D8C5A01A2_57A9D663008F_var*
begin
//#UC START# *4F0D8C5A01A2_57A9D663008F_impl*
 Result := 0;
 Assert(false);
//#UC END# *4F0D8C5A01A2_57A9D663008F_impl*
end;//TmsmScriptCaller.StartTimer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.StopTimer(const aSt: AnsiString = '';
 const aSubName: AnsiString = '';
 aNeedTimeToLog: Boolean = True): Longword;
//#UC START# *4F0D8CB0015D_57A9D663008F_var*
//#UC END# *4F0D8CB0015D_57A9D663008F_var*
begin
//#UC START# *4F0D8CB0015D_57A9D663008F_impl*
 Result := 0;
 Assert(false);
//#UC END# *4F0D8CB0015D_57A9D663008F_impl*
end;//TmsmScriptCaller.StopTimer
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.KPage: AnsiString;
//#UC START# *4F0D91AA0080_57A9D663008F_var*
//#UC END# *4F0D91AA0080_57A9D663008F_var*
begin
//#UC START# *4F0D91AA0080_57A9D663008F_impl*
 Result := '';
 Assert(false);
//#UC END# *4F0D91AA0080_57A9D663008F_impl*
end;//TmsmScriptCaller.KPage
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.ToLog(const aSt: AnsiString);
//#UC START# *4F0DA2A7024A_57A9D663008F_var*
//#UC END# *4F0DA2A7024A_57A9D663008F_var*
begin
//#UC START# *4F0DA2A7024A_57A9D663008F_impl*
 l3System.Msg2Log(aSt);
//#UC END# *4F0DA2A7024A_57A9D663008F_impl*
end;//TmsmScriptCaller.ToLog
{$IfEnd} // NOT Defined(NoScripts)

procedure TmsmScriptCaller.CheckOutputWithInput(const aSt: AnsiString;
 aHeaderBegin: AnsiChar = #0;
 const anExtraFileName: AnsiString = '';
 aNeedsCheck: Boolean = True);
//#UC START# *4F5F3C61023E_57A9D663008F_var*
//#UC END# *4F5F3C61023E_57A9D663008F_var*
begin
//#UC START# *4F5F3C61023E_57A9D663008F_impl*
 Assert(false);
//#UC END# *4F5F3C61023E_57A9D663008F_impl*
end;//TmsmScriptCaller.CheckOutputWithInput

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.GetIsWritingToK: Boolean;
//#UC START# *4F72CEFE016D_57A9D663008F_var*
//#UC END# *4F72CEFE016D_57A9D663008F_var*
begin
//#UC START# *4F72CEFE016D_57A9D663008F_impl*
 Result := false;
 Assert(false);
//#UC END# *4F72CEFE016D_57A9D663008F_impl*
end;//TmsmScriptCaller.GetIsWritingToK
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.GetIsFakeCVS: Boolean;
//#UC START# *4F72CF27029A_57A9D663008F_var*
//#UC END# *4F72CF27029A_57A9D663008F_var*
begin
//#UC START# *4F72CF27029A_57A9D663008F_impl*
 Result := false;
 Assert(false);
//#UC END# *4F72CF27029A_57A9D663008F_impl*
end;//TmsmScriptCaller.GetIsFakeCVS
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.GetCVSPath: AnsiString;
//#UC START# *4F72CF78027D_57A9D663008F_var*
//#UC END# *4F72CF78027D_57A9D663008F_var*
begin
//#UC START# *4F72CF78027D_57A9D663008F_impl*
 Result := '';
 Assert(false);
//#UC END# *4F72CF78027D_57A9D663008F_impl*
end;//TmsmScriptCaller.GetCVSPath
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.DontRaiseIfEtalonCreated;
//#UC START# *4F851D7B0399_57A9D663008F_var*
//#UC END# *4F851D7B0399_57A9D663008F_var*
begin
//#UC START# *4F851D7B0399_57A9D663008F_impl*
 Assert(false);
//#UC END# *4F851D7B0399_57A9D663008F_impl*
end;//TmsmScriptCaller.DontRaiseIfEtalonCreated
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.TimeToLog(aTime: Cardinal;
 const aSt: AnsiString;
 const aSubName: AnsiString);
//#UC START# *511BC7C60063_57A9D663008F_var*
//#UC END# *511BC7C60063_57A9D663008F_var*
begin
//#UC START# *511BC7C60063_57A9D663008F_impl*
 Assert(false);
//#UC END# *511BC7C60063_57A9D663008F_impl*
end;//TmsmScriptCaller.TimeToLog
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.GetTestSetFolderName: AnsiString;
//#UC START# *513866B10237_57A9D663008F_var*
//#UC END# *513866B10237_57A9D663008F_var*
begin
//#UC START# *513866B10237_57A9D663008F_impl*
 Result := '';
 Assert(false);
//#UC END# *513866B10237_57A9D663008F_impl*
end;//TmsmScriptCaller.GetTestSetFolderName
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.GetEtalonSuffix: AnsiString;
//#UC START# *5138790002FF_57A9D663008F_var*
//#UC END# *5138790002FF_57A9D663008F_var*
begin
//#UC START# *5138790002FF_57A9D663008F_impl*
 Result := '';
 Assert(false);
//#UC END# *5138790002FF_57A9D663008F_impl*
end;//TmsmScriptCaller.GetEtalonSuffix
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function TmsmScriptCaller.CompileOnly: Boolean;
//#UC START# *52EBC5BB0300_57A9D663008F_var*
//#UC END# *52EBC5BB0300_57A9D663008F_var*
begin
//#UC START# *52EBC5BB0300_57A9D663008F_impl*
 Result := false;
//#UC END# *52EBC5BB0300_57A9D663008F_impl*
end;//TmsmScriptCaller.CompileOnly
{$IfEnd} // NOT Defined(NoScripts)

procedure TmsmScriptCaller.CheckPictureOnly;
//#UC START# *536A15F901DA_57A9D663008F_var*
//#UC END# *536A15F901DA_57A9D663008F_var*
begin
//#UC START# *536A15F901DA_57A9D663008F_impl*
 Assert(false);
//#UC END# *536A15F901DA_57A9D663008F_impl*
end;//TmsmScriptCaller.CheckPictureOnly

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.ScriptDone(const aCtx: TtfwContext);
//#UC START# *57A9DF60030B_57A9D663008F_var*
//#UC END# *57A9DF60030B_57A9D663008F_var*
begin
//#UC START# *57A9DF60030B_57A9D663008F_impl*
 DoScriptDone(aCtx);
//#UC END# *57A9DF60030B_57A9D663008F_impl*
end;//TmsmScriptCaller.ScriptDone
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
procedure TmsmScriptCaller.ScriptWillRun(const aCtx: TtfwContext);
//#UC START# *57A9F99A01C4_57A9D663008F_var*
//#UC END# *57A9F99A01C4_57A9D663008F_var*
begin
//#UC START# *57A9F99A01C4_57A9D663008F_impl*
 DoScriptWillRun(aCtx);
//#UC END# *57A9F99A01C4_57A9D663008F_impl*
end;//TmsmScriptCaller.ScriptWillRun
{$IfEnd} // NOT Defined(NoScripts)

end.
