unit alcuZipUtils;
{ Обертки для упаковки-распаковки }

{ $Id: alcuZipUtils.pas,v 1.2 2014/08/05 06:30:30 lukyanets Exp $ }
// $Log: alcuZipUtils.pas,v $
// Revision 1.2  2014/08/05 06:30:30  lukyanets
// {Requestlink:558466572}. Правильные Define
//
// Revision 1.1  2014/07/28 15:18:16  lukyanets
// {Requestlink:557844282}. Используем правильный ProjectDefine.inc
//
// Revision 1.10  2014/07/16 15:35:48  lulin
// - вычищаем ненужное.
//
// Revision 1.9  2012/10/02 07:36:33  narry
// Обновление
//
// Revision 1.8  2012/09/10 07:58:12  narry
// Добавление команд CVS
//


interface
{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
 Classes, ddProgressObj;

function ZipFiles(const aZipFileName: string; aFiles: TStrings; aProgressor:
    TddProgressObject = nil): Boolean; overload;

function UnZipFiles(const aZipFileName, aFolder: String; const aMask: String =
    '*.*'; aProgressor: TddProgressObject = nil): Boolean;

function ZipFiles(const aZipFileName, aFolder: String; const aMask: String = '*.*'; aWithSubDir:
    Boolean = False; aProgressor: TddProgressObject = nil): Boolean; overload;

function ZipFilesA(const aZipFileName, aFolder: String; const aMask: String = '*.*'; aWithSubDir:
    Boolean = False; aProgressor: TddProgressObject = nil): Boolean; overload;

implementation

Uses
 ZipForge, SysUtils, l3ProtoObject, Forms, l3base;

type
 TZIPProgressObj = class(Tl3ProtoObject)
 private
  f_Progressor: TddProgressObject;
 public
  constructor Make(aProgressor: TddProgressObject);
  procedure ProgressProc(Sender: TObject; Progress: double; Operation:
      TZFProcessOperation; ProgressPhase: TZFProgressPhase; var Cancel: boolean);
 end;

function ZipFiles(const aZipFileName: string; aFiles: TStrings; aProgressor:
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
    Options.Recurse:= False;
    Zip64Mode:= zmAlways;
    OnOverallProgress:= ProgressProc;
    FileName:= aZipFileName;
    OpenArchive();
    for i:= 0 to Pred(aFiles.Count) do
    begin
     BaseDir:= ExtractFileDir(aFiles[i]);
     AddFiles(ExtractFileName(aFiles[i]));
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

function UnZipFiles(const aZipFileName, aFolder: String; const aMask: String =
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

function ZipFiles(const aZipFileName, aFolder: String; const aMask: String = '*.*'; aWithSubDir:
    Boolean = False; aProgressor: TddProgressObject = nil): Boolean;
begin
 Result:= False;
 try
  with TZIPProgressObj.Make(aProgressor) do
  try
   with TZipForge.Create(nil) do
   try
    Zip64Mode:= zmAlways;
    Options.Recurse:= aWithSubDir;
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

function ZipFilesA(const aZipFileName, aFolder: String; const aMask: String = '*.*'; aWithSubDir:
    Boolean = False; aProgressor: TddProgressObject = nil): Boolean;
begin
 Result:= False;
 try
  with TZIPProgressObj.Make(aProgressor) do
  try
   with TZipForge.Create(nil) do
   try
    Zip64Mode:= zmAuto;
    Options.Recurse:= aWithSubDir;
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

constructor TZIPProgressObj.Make(aProgressor: TddProgressObject);
begin
 Create;
 f_Progressor:= aProgressor;
end;

procedure TZIPProgressObj.ProgressProc(Sender: TObject; Progress: double;
    Operation: TZFProcessOperation; ProgressPhase: TZFProgressPhase; var
    Cancel: boolean);
begin
 // Operation: poAdd, poMove, poDelete, poUpdate, poExtract, poTest, poRename, poChangeAttr, poChangeComment, poMakeSFX, poMerge
 // Phase: ppStart, ppProcess, ppEnd
 if f_Progressor <> nil then
  case ProgressPhase of
   ppStart: f_Progressor.Start(100);
   ppProcess: f_Progressor.ProcessUpdate(Round(Progress));
   ppEnd: f_Progressor.Stop;
  end
 else
  Application.ProcessMessages;
end;

end.
