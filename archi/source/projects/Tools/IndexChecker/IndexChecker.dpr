program IndexChecker;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,
  l3Base,
  l3FileUtils,
  m2COMLib,
  m3StorageInterfaces,
  m3DBInterfaces,
  m3DBActions,
  m3DB,
  m3StorageHolderList,
  m4DB,
  l3Interfaces,
  m4DBInterfaces,
  l3Stream,
  l3CRT,
  vtDebug,
  l3Filer,
  l3Types
  ;
    
const
 cFileName = 'bserv001';

var
 lDirName   : TFileName;
 lBaseName  : TFileName;
 lLogName   : TFileName;

const
 cPhaseSample = 'Check : %s';
 cPhasePercentage = '%d/%d';

var
 lPhaseStr : string;

procedure Log(const S : String);
begin
 dbgAppendToLogLN(lLogName, S);
end;

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
  piCurrent :
   //if (aValue mod 500) = 0 then
   if (aValue mod 100) = 0 then
    CRT.ReWrite(Format(lPhaseStr, [aValue, lMaxCount]));
 end;
end;

procedure TProgressor.FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
begin
 CRT.ReWrite(Format(lPhaseStr, [aCurrentID, aMaxID]));
end;

const
 cPartName : array [Tm3DocPartSelector] of string = ('Main', 'Anno', 'Info', 'Object');

procedure DoCheck{(aCheckForEmpty : boolean; aCheckForBroken : boolean)};
var
 lProgressor : TProgressor;
var
 l_DB : Im4DB;
begin
 lProgressor := TProgressor.Create;
 try
   lPhaseStr := Format(cPhaseSample, [cPhasePercentage]);
   l_DB := Tm4DB.Make(ConcatDirName(lDirName, lBaseName),
                      nil,//Yield,
                      nil,//FileMeter.ProgressProc_ev,
                      lProgressor.ProgressProc,//FilesMeter.ProgressProc_ev,
                      nil,//FilesProcessed,
                      nil //
                      //lProgressor.FilesProcessedExProc//FilesProcessedEx
                     );
   try
    l_DB.DeleteIndexDelta;
    l_DB.Start(m3_saReadWrite);
    try
     l_DB.UpdateIndex;
     l_DB.Update(true, false);
    finally
     l_DB.Finish;
    end;//try..finally
    Tm3StorageHolderList.DropAll;
    l_DB.DeleteVersion;
   finally
    l_DB := nil;
   end;//try..finally
 finally
  l3Free(lProgressor);
 end;//try..finally
end;

var
 lParamStr : String;
 I : integer;
begin
 lBaseName := ParamStr(1);

 if lBaseName = '' then lBaseName := cFileName;
 lDirName := ExtractDirName(ExpandFileName(lBaseName));
 lBaseName := ExtractOnlyFileName(lBaseName);
 if lBaseName = '' then lBaseName := cFileName;
 WriteLN('Storage : ', ConcatDirName(lDirName, lBaseName));

 lLogName := ChangeFileExt(ConcatDirName(lDirName, lBaseName),'.result');

 DoCheck;

 Writeln('All done. Press <Enter>');
 ReadLN;

end.
