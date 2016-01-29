program StgSplit;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  l3Base,
  l3FileUtils,
  l3Interfaces,
  l3Stream,
  l3CRT,
  m3SplittedFileStream;

const
 cFileName = 'bserv001';

var
 lDirName   : TFileName;
 lBaseName  : TFileName;
 lBaseCName : TFileName;

const
 cPhaseSample = 'Split : %s';
 cPhasePercentage = '%d/%d';

var
 //lPhaseCnt : byte = 1;
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
           CRT.ReWrite(Format(cPhaseSample, ['done']));
           WriteLN;
          end;
  piCurrent : CRT.ReWrite(Format(lPhaseStr, [aValue, lMaxCount]));

 end;
end;

procedure TProgressor.FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
begin
 CRT.ReWrite(Format(lPhaseStr, [aCurrentID, aMaxID]));
end;

procedure DoSplit;
var
 lSrcFile : IStream;
 lOutFile : IStream;
 lFileName : TFileName;
 cbRead: Int64;
 cbWritten: Int64;
 //lProgressor : TProgressor;
begin
 lFileName := ConcatDirName(lDirName, lBaseName)+'.stg';
 lSrcFile := Tl3FileStream.Make(lFileName);
 lOutFile := Tm3SplittedFileStream.Make(lFileName, GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL);
 lSrcFile.CopyTo(lOutFile, High(Int64), cbRead, cbWritten);
end;

begin
 lBaseName := ParamStr(1);
 if lBaseName = '' then lBaseName := cFileName;
 lDirName := ExtractDirName(ExpandFileName(lBaseName));
 lBaseName := ExtractOnlyFileName(lBaseName);
 WriteLN('Storage : ', ConcatDirName(lDirName, lBaseName));

 DoSplit;

 Writeln('All done. Press <Enter>');
 ReadLN;

end.
















































































































































