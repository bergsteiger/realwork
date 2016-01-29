{*********************************************************}
{*                   TSTUTIL.PAS 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

unit tstutil;

interface

{$I STDEFINE.INC}

{$IFDEF OS32}
uses
  SysUtils;
{$ELSE}
uses
  SysUtils, WinCrt;
{$ENDIF}

procedure OpenLog(Name : string);
procedure CloseLog;
procedure WriteLog(S : string);
procedure WriteLogStrDump(S : string);

function RandomStr(Len : integer) : String;

implementation

var
  F : System.Text;

procedure OpenLog(Name : string);
  begin
    Assign(F, Name);
    Rewrite(F);
    {$IFNDEF OS32}
    InitWinCrt;
    {$ENDIF}
    WriteLog('---Start of test---');
  end;
procedure CloseLog;
  begin
    WriteLog('---End of test---');
    Close(F);
    writeln('File ', TTextRec(F).Name, ' created. Press <Enter> to end');
    readln;
    {$IFNDEF OS32}
    DoneWinCrt;
    {$ENDIF}
  end;
procedure WriteLog(S : string);
  begin
    writeln(F, S);
    writeln(S);
  end;
procedure WriteLogStrDump(S : string);
  var
    i : integer;
  begin
    WriteLog('String dump - start');
    for i := 1 to length(S) do
      if (32 < ord(S[i])) and (ord(S[i]) <= 127) then
        begin
          write(F, S[i]);
          write(S[i]);
        end
      else
        begin
          write(F, '[', ord(S[i]), ']');
          write('[', ord(S[i]), ']');
        end;
    writeln(F, '');
    writeln('');
    WriteLog('String dump - end');
  end;

function RandomStr(Len : integer) : string;
  var
    i : integer;
    j : integer;
  begin
    {$IFNDEF Win32}
    Result[0] := char(Len);
    {$ELSE}
    SetLength(Result, Len);
    {$ENDIF}
    for i := 1 to len do
      begin
        j := Random(52);
        if (j < 26) then
          Result[i] := char(j + ord('A'))
        else
          Result[i] := char(j - 26 + ord('a'))
      end;
  end;

end.
