program testBaseBuilder;

{$APPTYPE CONSOLE}

uses
  JwaWinBase,
  Windows,

  SysUtils,

  l3FileUtils,
  l3IniFile,

  m3StorageHolderList,

  ddHTInit,
  ddClientBaseEngine,
  ddImportPipe,

  dt_Const,
  dt_Types,
  dt_Serv,

  m4DBInterfaces,
  m4DB,

  ZipForge;

const
 cEmptybaseArchiveFN    = 'emptybase.zip';
 cImportDocumentsFolder = 'W:\archi\source\projects\ImportExportTest\ForTestBase';
 cTestBaseArchiveName   = 'testbase.zip';
 cUnpackedBaseFolder    = 'TESTBASE';

function FromCurrent(const aFilename: AnsiString): AnsiString;
begin
 Result := ConcatDirName(ExtractDirName(ParamStr(0)), aFileName);
end;

procedure UnpackEmptyBase;
var
 l_Zip: TZipForge;
begin
 Writeln('Unpacking empty base');
 l_Zip := TZipForge.Create(nil);
 try
  l_Zip.FileName := cEmptybaseArchiveFN;
  l_Zip.OpenArchive;
  ForceDirectories(FromCurrent(cUnpackedBaseFolder));
  l_Zip.BaseDir := FromCurrent(cUnpackedBaseFolder);
  l_Zip.ExtractFiles('*.*');
 finally
  FreeAndNil(l_Zip);
 end;
end;

procedure ConnectToDatabase;
begin
 Writeln('Connecting to database');
 InitStationAndServerConfig;
 if not InitBaseEngine(FromCurrent(cUnpackedBaseFolder), 'fireton', 'pyro', True{aQuietMode}) then
  raise Exception.Create('Can''t connect to DB');
end;

procedure ImportDocuments;
var
 l_Pipe: TddImportPipe;
begin
 Writeln('Importing documents to database');
 l_Pipe := TddImportPipe.Create(CurrentFamily);
 try
  l_Pipe.InputFileType := dd_itAutoDetect;
  //l_Pipe.OnTopicStart := TopicEvent;
  l_Pipe.CheckDocuments:= False;
  l_Pipe.NeedLockBase := True;
  l_Pipe.WorkDir := cImportDocumentsFolder;
  l_Pipe.PictureDir := cImportDocumentsFolder;
  l_Pipe.NotUpdatableDicts:= [];
  l_Pipe.NeedFork:= True;
  l_Pipe.UserID := 0;
  l_Pipe.AddNewToLog := false;
  if not l_Pipe.Execute then
   raise Exception.Create('Import is not performed');
 finally
  FreeAndNil(l_Pipe);
 end;
end;

procedure PackTestBaseToArchive;
var
 l_Zip: TZipForge;
begin
 Writeln('Packing result database to arhive ('+cTestBaseArchiveName+')');
 DeleteFile(FromCurrent(cTestBaseArchiveName));
 l_Zip := TZipForge.Create(nil);
 try
  l_Zip.BaseDir := FromCurrent(cUnpackedBaseFolder);
  l_Zip.FileName := FromCurrent(cTestBaseArchiveName);
  l_Zip.OpenArchive;
  l_Zip.Options.Recurse := True;
  l_Zip.AddFiles('*.*'); 
 finally
  FreeAndNil(l_Zip);
 end;
end;

procedure DisconnectFromDatabase;
begin
 Writeln('Disconnectiong from database');
 DoneClientBaseEngine;
 Tm3StorageHolderList.DropAll; // иначе хранилище будет залочено
end;

procedure DeleteUnpackedEmptyBase;
begin
 Writeln('Deleting DB folder');
 DelDir(FromCurrent(cUnpackedBaseFolder));
end;

procedure UpdateDatabase;
var
 l_Storage: Im4DB;
begin
 Writeln('Updating database');
 GlobalHtServer.UpdateAllTbl(CurrentFamily);
 l_Storage := Tm4DB.Make(FromCurrent(cUnpackedBaseFolder+'\garant\bserv001'));
 if not l_Storage.Update then
  raise Exception.Create('DBUpdate is not performed');
 l_Storage.DeleteVersion;
end;

begin
 Writeln('[Import/Export test database builder]');
 try
  UnpackEmptyBase;
  try
   ConnectToDatabase;
   try
    ImportDocuments;
    UpdateDatabase;
    PackTestBaseToArchive;
   finally
    DisconnectFromDatabase;
   end;
  finally
   DeleteUnpackedEmptyBase;
  end;
  Writeln('Done!');
 except
  on E: Exception do
  begin
   Writeln('ERROR: ' + E.Message);
   if IsDebuggerPresent then
   begin
    Write('<Press ENTER>');
    Readln;
   end; 
  end;
 end;
end.
