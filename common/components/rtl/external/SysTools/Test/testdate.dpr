{*********************************************************}
{*                  TESTDATE.DPR 1.05                    *}
{*                     Test Program                      *}
{*   Copyright (c) TurboPower Software Co., 1996, 1998   *}
{*                 All rights reserved.                  *}
{*********************************************************}

program testdate;

{$I STDEFINE.INC}

{$IFDEF Win32}
 {$APPTYPE CONSOLE}
{$ENDIF}

uses
  SysUtils,
  {$IFDEF OS32}
   {$IFDEF WIN32}
  Windows,
   {$ENDIF}
  {$ELSE}
  WinTypes, WinProcs,
  WinCrt,
  {$ENDIF}
  TstUtil, StDate;

var
  d, d2 : TStDate;
  mm, dd, yy : integer;
  ymd, oldymd : longint;

begin
  OpenLog('TEST.LOG');
  try
    oldymd := 0;
    for d := 1 to 875000 do
      begin
        StDateToDMY(d, dd, mm, yy);
        ymd := (longint(yy) * 100 + mm) * 100 + dd;
        if (ymd <= oldymd) then
          WriteLog(Format('Date %d converted to DMY is not greater than previous', [d]));
        if not ValidDate(dd, mm, yy, 1950) then
          begin
            WriteLog(Format('StDateToDMY doesn''t generate good DMY for date %d', [d]));
            WriteLog(Format('...DMY = %d/%d/%d', [dd, mm, yy]));
          end;
        d2 := DMYtoStDate(dd, mm, yy, 1950);
        if (d <> d2) then
          WriteLog(Format('Original date %d and date generated from its DMY don''t match', [d]));
        d2 := IncDate(d, 28, 1, 1);
        DateDiff(d, d2, dd, mm, yy);
        if (dd <> 28) and (mm <> 1) and (yy <> 1) then
          WriteLog(Format('Problem with IncDate/DateDiff with date %d', [d]));
        if (d and $ff) = 0 then
          WriteLog(Format('Iteration %d', [d]));
        oldymd := ymd;
      end;
  finally
    CloseLog;
  end;
end.
