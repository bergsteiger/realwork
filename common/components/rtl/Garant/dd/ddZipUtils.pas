unit ddZipUtils;

interface

uses Classes, ddProgressObj;

function ZipFiles(const aZipFileName: AnsiString; aFiles: TStrings; aProgressor:
    TddProgressObject = nil): Boolean; overload;

function UnZipFiles(const aZipFileName, aFolder: AnsiString; const aMask: AnsiString =
    '*.*'; aProgressor: TddProgressObject = nil; const aDescription: AnsiString =
    ''): Boolean;

function ZipFiles(const aZipFileName, aFolder: AnsiString; const aMask: AnsiString =
    '*.*'; aProgressor: TddProgressObject = nil): Boolean; overload;

type
 TddStreamProc = procedure (aStream: TStream) of object;

procedure IterateZip(const aZipFileName, aFileMask: AnsiString; aProc:
    TddStreamProc);

implementation

Uses
 ZipForge, SysUtils, l3ProtoObject, Forms, l3base, StrUtils, l3Memory;

type
 TZIPProgressObj = class(Tl3ProtoObject)
 private
  f_Description: AnsiString;
  f_Progressor: TddProgressObject;
 public
  constructor Make(aProgressor: TddProgressObject; const aDescription: AnsiString =
      '');
  procedure ProgressProc(Sender: TObject; Progress: double; Operation:
      TZFProcessOperation; ProgressPhase: TZFProgressPhase; var Cancel: boolean);
 end;

function ZipFiles(const aZipFileName: AnsiString; aFiles: TStrings; aProgressor:
    TddProgressObject = nil): Boolean;
var
 i: integer;
begin
 Result:= False;
 try
  with TZIPProgressObj.Make(aProgressor) do
  try
   with TZipForge.Create(nil) do
   try
    OnOverallProgress:= ProgressProc;
    FileName:= aZipFileName;
    Options.Recurse := False;
    OpenArchive();
    BeginUpdate;
    try
     for i:= 0 to Pred(aFiles.Count) do
     begin
      BaseDir:= ExtractFileDir(aFiles[i]);
      AddFiles(ExtractFileName(aFiles[i]));
     end;
     EndUpdate;
    except
     CancelUpdate;
     raise;
    end;
    CloseArchive;
    Result:= True;
   finally
    Free;
   end;
  finally
   Free;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Не удалось создать архив (%s)', [E.Message]);
 end;
end;

function UnZipFiles(const aZipFileName, aFolder: AnsiString; const aMask: AnsiString =
    '*.*'; aProgressor: TddProgressObject = nil; const aDescription: AnsiString =
    ''): Boolean;
begin
 Result:= False;
 try
  with TZIPProgressObj.Make(aProgressor, aDescription) do
  try
   with TZipForge.Create(nil) do
   try
    OnOverallProgress:= ProgressProc;
    FileName:= aZipFileName;
    OpenArchive();
    BaseDir:= aFolder;
    ExtractFiles(aMask);
    CloseArchive;
    Result:= True;
   finally
    Free;
   end;
  finally
   Free;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Не удалось извлечь файлы из архива (%s)', [E.Message]);
 end;
end;

function ZipFiles(const aZipFileName, aFolder: AnsiString; const aMask: AnsiString =
    '*.*'; aProgressor: TddProgressObject = nil): Boolean;
begin
 Result:= False;
 try
  with TZIPProgressObj.Make(aProgressor) do
  try
   with TZipForge.Create(nil) do
   try
    OnOverallProgress:= ProgressProc;
    FileName:= aZipFileName;
    OpenArchive();
    BaseDir:= aFolder;
    AddFiles(aMask);
    CloseArchive;
    Result:= True;
   finally
    Free;
   end;
  finally
   Free;
  end;
 except
  on E: Exception do
   l3System.Msg2Log('Не удалось создать архив (%s)', [E.Message]);
 end;
end;

procedure IterateZip(const aZipFileName, aFileMask: AnsiString; aProc: TddStreamProc);
var
 l_Item: TZFArchiveItem;
 l_Stream: TStream;
 l_Zip: TZipForge;

 procedure lp_ExtractItem(aItem: TZFArchiveItem);
 begin
  l_Stream.Seek(0, 0);
  l_Stream.Size:= 0;
  l_Zip.ExtractToStream(aItem.FileName, l_Stream);
  l_Stream.Seek(0, 0);
  aProc(l_Stream);
 end; // lp_ExtractItem

begin
 l_Zip:= TZipForge.Create(nil);
 try
  with l_Zip do
  begin
   FileName:= aZipFileName;
   Active:= True;
   if FileCount > 0 then
   begin
    l_Stream:= Tl3MemoryStream.Make;
    try
     if FindFirst(aFileMask, l_Item) then
     begin
      lp_ExtractItem(l_Item);
      while FindNext(l_Item) do
       lp_ExtractItem(l_Item);
     end;
    finally
     FreeAndNil(l_Stream);
    end;
   end; // FileCount > 0
  end; // with l_Zip
 finally
  FreeAndNil(l_Zip);
 end;
end;

constructor TZIPProgressObj.Make(aProgressor: TddProgressObject; const
    aDescription: AnsiString = '');
begin
 Create;
 f_Progressor:= aProgressor;
 f_Description:= aDescription;
end;

procedure TZIPProgressObj.ProgressProc(Sender: TObject; Progress: double;
    Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase; var
    Cancel: boolean);
begin
 // Operation: poAdd, poMove, poDelete, poUpdate, poExtract, poTest, poRename, poChangeAttr, poChangeComment, poMakeSFX, poMerge
 // Phase: ppStart, ppProcess, ppEnd
 if f_Progressor <> nil then
  case ProgressPhase of
   ppStart: f_Progressor.Start(100,
                               IfThen(f_Description = '',
                                      'Обработка '+ExtractFileName(TZipForge(Sender).FileName)+'...',
                                      f_Description)
                               );
   ppProcess: f_Progressor.ProcessUpdate(Round(Progress));
   ppEnd: f_Progressor.Stop;
  end
 else
  Application.ProcessMessages;
end;

end.
