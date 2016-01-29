program StgChecker;

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
  m4DB,
  l3Interfaces,
  m4DBInterfaces,
  l3Stream,
  l3CRT,
  vtDebug;
    //M3
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
 //lPhaseCnt : byte = 1;
 lPhaseStr : string;

 //lPhaseStr := Format(cPhaseSample, [lPhaseCnt, cPhasePercentage]);

procedure Log(const S : String);
begin
 //Writeln(
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
   if (aValue mod 500) = 0 then
    CRT.ReWrite(Format(lPhaseStr, [aValue, lMaxCount]));
 end;
end;

procedure TProgressor.FilesProcessedExProc(aCurrentID : Longint; aMaxID : Longint; aTime : TDateTime);
begin
 CRT.ReWrite(Format(lPhaseStr, [aCurrentID, aMaxID]));
end;

const
 cPartName : array [Tm3DocPartSelector] of string = ('Main', 'Anno', 'Info', 'Object');

procedure DoCheck(aCheckForEmpty : boolean; aCheckForBroken : boolean);
var
 lDB       : Im3DB;
 lProgressor : TProgressor;

 function DoDoc(const aDoc: Im3DBDocumentPart; const anIndex: Tm3DBStreamIndex): Boolean;
  var
   l_S : IStream;
   l_NullStream : Tl3NullStream;
   l_Read, l_Written : Int64;
  begin//DoDoc
   Result := true;
   try
    l_S := aDoc.Open(m3_saRead, anIndex.rPart, anIndex.rIdx);
    try
      if aCheckForEmpty then
      begin
       if (l_S <> nil) then
        if (m2COMGetSize(l_S) <= 200) {or ((anIndex.rId mod 1000) = 0)} then
        Log(Format('Empty : %d (%s)',[anIndex.rId, cPartName[anIndex.rPart]]));
        //out about empty
      end;

      if aCheckForBroken then
      begin
       l_NullStream := Tl3NullStream.Create;
       try
        l_S.CopyTo(l_NullStream, High(Int64), l_Read, l_Written);
       finally
        FreeAndNil(l_NullStream);
       end;//try..finally
      end;
    finally
     l_S := nil;
    end;//try..finally
    //l_Filer.WriteLn(Format('%d %d', [aFiler.Handle, aFiler.Size]));
   except
    on E : Exception do
    Log(Format('Exception on doc: %d(%s) "%s"', [anIndex.rId, cPartName[anIndex.rPart], E.Message]));
   end;

 end;//DoDoc

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
    lPhaseStr := Format(cPhaseSample, [cPhasePercentage]);   
    try    
     //Tm3DocumentAction    
     lDB.AllFiles.IterateF(m3L2DocumentAction(@DoDoc), [m3_dsMain]);

     //update
     //lDB.Update(False);
    except     
     on E : Exception do    
     writeln('Exeptions : '+E.Message);     
    end;     
   finally
    lDB.Finish;   
   end;//try..finally    
  finally   
   lDB := nil;  
  end;//try..finally   

 finally  
  l3Free(lProgressor); 
 end;//try..finally  

end;

var
 lCheckForEmpty : boolean = false;
 lCheckForBroken : boolean = false;
 lParamStr : String;
 I : integer;
begin
 for I := 1 to ParamCount do
 begin
  lParamStr := ParamStr(I);
  if lParamStr = '/e' then
   lCheckForEmpty := True
  else
   if lParamStr = '/b' then
    lCheckForBroken := True
   else
    lBaseName := lParamStr;
 end;

 //если ничего не включили, то делаем все
 if not (lCheckForEmpty or lCheckForBroken) then
 begin
  lCheckForEmpty := True;
  lCheckForBroken := True;
 end;

 if lBaseName = '' then lBaseName := cFileName;
 lDirName := ExtractDirName(ExpandFileName(lBaseName));
 lBaseName := ExtractOnlyFileName(lBaseName);
 if lBaseName = '' then lBaseName := cFileName;
 WriteLN('Storage : ', ConcatDirName(lDirName, lBaseName));

 lLogName := ChangeFileExt(ConcatDirName(lDirName, lBaseName),'.result');

 DoCheck(lCheckForEmpty, lCheckForBroken);

 Writeln('All done. Press <Enter>');
 ReadLN;

end.
