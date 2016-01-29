program StgUpdate;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils,  
  l3Base,  
  l3FileUtils,  
  m3StorageInterfaces,  
  m3DBInterfaces,  
  m3DBActions,  
  m3DB,  
  m4DB,  
  l3Interfaces,  
  m4DBInterfaces,  
  l3Stream,  
  l3CRT;  
    //M3define.inc
const  
 cFileName = 'bserv001';

var 
 lDirName   : TFileName;
 lBaseName  : TFileName; 
 lBaseCName : TFileName; 

const 
 cPhaseSample = 'Update : %s';
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

procedure DoCheck;
var
 lDB       : Im4DB;
 lProgressor : TProgressor; 
begin
 lProgressor := TProgressor.Create;
 try 
  lDB := Tm4DB.Make(ConcatDirName(lDirName, lBaseName),
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
    //update
     lDB.Update(False);
     CRT.ReWrite('Delete version storage...');
     lDB.DeleteVersion;
     CRT.ReWrite('Delete version storage : done');
     WriteLN;
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

begin
 lBaseName := ParamStr(1);
 if lBaseName = '' then lBaseName := cFileName; 
 lDirName := ExtractDirName(ExpandFileName(lBaseName));
 lBaseName := ExtractOnlyFileName(lBaseName);
 if lBaseName = '' then lBaseName := cFileName;
 WriteLN('Storage : ', ConcatDirName(lDirName, lBaseName));

 DoCheck; 

 Writeln('All done. Press <Enter>'); 
 ReadLN; 

end. 
