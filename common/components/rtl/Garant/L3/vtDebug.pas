unit vtDebug;

{$I vtDefine.inc }

{.$Define OutToConsole}
{$IfNDef vtOutToFile}
 {$Define OutToLOG}
{$EndIf vtOutToFile}

interface
 uses
  Sysutils;

 Type
  TvtDebugException = class(Exception);

 procedure dbgAppendToLogLN(const aFileName : TFileName; const aText : String); overload;
 procedure dbgAppendToLogLN(const aText : String); overload;

 procedure dbgAppendToLog(const aFileName : TFileName; const aText : String);   overload;
 procedure dbgAppendToLog(const aText : String);   overload;

 function dbgStartTimeCounter : Cardinal;
 function dbgFinishTimeCounter(aStartTime : Cardinal; const aFormat : String = '') : String;
 function dbgGetElapsed(aStartTime : Cardinal) : Int64;

implementation

uses
 Windows,

 {$IFDEF OutToLOG}
  l3Base
 {$ELSE}
  vtLogFile
 {$ENDIF}
  ;

const
 DbgExt = '.dbg';

var
 DbgIsFirstTime : Boolean = True;

 dbgDefFileName : TFileName;

procedure AppendToLog(aFileName : TFileName; aText : String);
begin
 {$IFDEF OutToLOG}
  l3System.Msg2Log(aText, 10);
 {$ELSE}
 if DbgIsFirstTime then
 begin
  DbgIsFirstTime := False;
  vtLogFile.AppendToLog(aFileName, ' -'#4'- Start Debug ' + DateTimeToStr(Now) + #13#10);
 end;

 vtLogFile.AppendToLog(aFileName, aText);
 {$ENDIF}
end;

function dbgStartTimeCounter : Cardinal;
begin
 Result := GetTickCount;
end;

function dbgGetElapsed(aStartTime : Cardinal) : Int64;
var
 lFinishTime : Cardinal;
begin
 lFinishTime := GetTickCount;
 Result := Int64(lFinishTime) - Int64(aStartTime);

 if Result < 0 then
  Result := Result + High(Cardinal);
end;

function dbgFinishTimeCounter(aStartTime : Cardinal; const aFormat : String = '') : String;
var
 lElapsedTime : Int64;
begin
 lElapsedTime := dbgGetElapsed(aStartTime);

 if aFormat = '' then
  Result := Format('Elapsed time %d ms', [lElapsedTime])
 else
  Result := Format(aFormat,[lElapsedTime]);
end;

procedure dbgAppendToLogLN(const aFileName : TFileName; const aText : String);
begin
 AppendToLog(aFileName, aText+#13#10);
end;

procedure dbgAppendToLogLN(const aText : String);
begin
 //{$Ifdef Console}
 // WriteLN(aText);
 //{$else}
  AppendToLog(dbgDefFileName, aText+#13#10);
 //{$Endif}
end;

procedure dbgAppendToLog(const aFileName : TFileName; const aText : String);
begin
 AppendToLog(aFileName, aText);
end;

procedure dbgAppendToLog(const aText : String);
begin
 //{$Ifdef Console}
 // Write(aText);
 //{$else}
  AppendToLog(dbgDefFileName, aText);
 //{$endif}
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtDebug.pas initialization enter'); {$EndIf}
//uses Forms;

dbgDefFileName := ChangeFileExt(ParamStr(0), DbgExt);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\gui\Garant\VT\vtDebug.pas initialization leave'); {$EndIf}
end.
