program StgRecover;

{$APPTYPE CONSOLE}
{$I ProjectDefine.inc}

uses
  Windows,
  SysUtils,
  l3Base,
  l3FileUtils,
  m3StorageInterfaces, m3DBInterfaces,
  m3DB,
  m4DB,
  l3Interfaces,
  m4DBInterfaces,
  l3CRT;

const
 cFileName = 'bserv001';

var
 lDirName   : TFileName;
 lBaseName  : TFileName;
 lBaseCName : TFileName;

function RenametoBackup(const aFileName: string; aData: Pointer): Boolean;
var
 lBakName : TFileName;
begin
 lBakName := aFileName+'.bak';
 if FileExists(lBakName) then DeleteFile(lBakName);
 RenameFile(aFileName, lBakName);
 Result := True;
end;

function RenametoOrigin(const aFileName: string; aData: Pointer): Boolean;
var
 lOriginName : TFileName;
begin
 lOriginName := ConcatDirName(lDirName, ChangeFileExt(lBaseName, ExtractFileExt(aFileName)));
 RenameFile(aFileName, lOriginName);
 Result := True;
end;

function RenametoOrigin_bkp(const aFileName: string; aData: Pointer): Boolean;
var
 lOriginName : TFileName;
begin
 lOriginName := ConcatDirName(lDirName, ChangeFileExt(lBaseName+'_bkp', ExtractFileExt(aFileName)));
 RenameFile(aFileName, lOriginName);
 Result := True;
end;

const
 cPhaseSample = 'Phase %d : %s';
 cPhasePercentage = '%d/%d';

var
 lPhaseCnt : byte = 1;
 lPhaseStr : string;

 //lPhaseStr := Format(cPhaseSample, [lPhaseCnt, cPhasePercentage]);

type
 TProgressor = class(Tl3Base)
 private
  lMaxCount : Longint;
 public
  procedure FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
  procedure ProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
 end;

procedure TProgressor.ProgressProc(aState: Byte; aValue: Longint; const aMsg: String);
begin
 case aState of
  piStart : lMaxCount := aValue;
  piEnd : begin
           CRT.ReWrite(Format(cPhaseSample, [lPhaseCnt, 'done']));
           WriteLN;
          end;
  piCurrent : CRT.ReWrite(Format(lPhaseStr, [aValue, lMaxCount]));

 end;
end;

procedure TProgressor.FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
begin
 CRT.ReWrite(Format(lPhaseStr, [aCurrentID, aMaxID]));
end;

procedure DoRecover;
var
 lDB       : Im3DB;
 lDBCopy   : Im3DB;
 lProgressor : TProgressor;
begin
 lProgressor := TProgressor.Create;
 try
  lDB := Tm3DB.Make(ConcatDirName(lDirName, lBaseName),
                      //cbMakeCopy.Checked AND cbFromOld.Checked,
                      nil,//Yield,
                      nil,//FileMeter.ProgressProc_ev,
                      lProgressor.ProgressProc,//FilesMeter.ProgressProc_ev,
                      nil,//FilesProcessed,
                      nil //lProgressor.FilesProcessedExProc//FilesProcessedEx
                      );

  try
   lDB.Start(m3_saReadWrite);
   try
    lBaseCName := lBaseName+'_C';

    lDBCopy := Tm3DB.Make(ConcatDirName(lDirName, lBaseCName),
                      //cbMakeCopy.Checked AND cbFromOld.Checked,
                      nil,//Yield,
                      nil,//FileMeter.ProgressProc_ev,
                      lProgressor.ProgressProc,//FilesMeter.ProgressProc_ev,
                      nil,//FilesProcessed,
                      nil//FilesProcessedEx
                      );

    try
     lPhaseStr := Format(cPhaseSample, [lPhaseCnt, cPhasePercentage]);
     try
      lDB.AllFiles.CopyTo(lDBCopy);
     except
      on E : Exception do
      begin
       Writeln('Exeptions : '+E.Message);
       Exit;
      end;
     end;

     Inc(lPhaseCnt);
     lPhaseStr := Format(cPhaseSample, [lPhaseCnt, cPhasePercentage]);
     try
      lDBCopy.Update(False);
      lDBCopy.DeleteVersion;
     except
      on E : Exception do
      begin
       Writeln('Exeptions : '+E.Message);
       Exit;
      end;
     end;
     Inc(lPhaseCnt);
     lPhaseStr := Format(cPhaseSample, [lPhaseCnt, cPhasePercentage]);
     try
      lDB.ModifiedFiles(True{notEmptyOnly}).CopyTo(lDBCopy);
     except
      on E : Exception do
      begin
       Writeln('Exeptions : '+E.Message);
       Exit;
      end;
     end;
     lDB.Finish;
     CRT.ReWrite('Rename ...');
     lDB.Rename(lBaseName+'_bak');
     lDBCopy.Rename(lBaseName);
     CRT.ReWrite('Rename done');
     Writeln;
    finally
     lDBCopy := nil;
    end;//try..finally
   finally
    if lDB.InProcess then
     lDB.Finish;
   end;//try..finally
  finally
   lDB := nil;
  end;//try..finally
 finally
  l3Free(lProgressor);
 end;//try..finally
end;

begin
 lBaseName := ParamStr(1);
 if lBaseName = '' then lBaseName := cFileName;
 lDirName := ExtractDirName(ExpandFileName(lBaseName));
 lBaseName := ExtractOnlyFileName(lBaseName);
 WriteLN('Storage : ', ConcatDirName(lDirName, lBaseName));

 DoRecover;

 Writeln('All done. Press <Enter>');
 ReadLN;

end.
