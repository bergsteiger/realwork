unit csSpellCorrectTask;

interface
{$I CsDefine.inc}

uses
 csProcessTask,
 Classes,
 ddProgressObj,
 daTypes,

 csSpellCorrectTaskPrim
 ;

type
 TcsSpellCorrectTask = class(TcsSpellCorrectTaskPrim)
(* private
  f_ReplacementFile: AnsiString;*)
 protected
  function GetDescription: AnsiString; override;
  procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
 public
  constructor Create(aUserID: TdaUserID); override;
  function HasFilesToTransfer: Boolean; override;
  function TransferFiles(const aService: IcsFileTransferServices): Boolean; override;
  function ExpandTransferFileName(const aFileName: String; out theBasePath, theFileName: String): Boolean; override;
  procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
(*  property ReplacementFile: AnsiString read f_ReplacementFile write f_ReplacementFile;*)
 end;//TcsSpellCorrectTask

implementation

uses
 csTaskTypes,
 l3FileUtils,
 SysUtils, StrUtils;

{
******************************** TddProcessTask ********************************
}
constructor TcsSpellCorrectTask.Create(aUserID: TdaUserID);
begin
 inherited;
 //TaskType := cs_ttSpellCheck;
 Self.StatusW := cs_tsDelayed;
end;

function TcsSpellCorrectTask.GetDescription: AnsiString;
begin
 Result := 'Исправление опечаток по файлу ' + ExtractFileName(ReplacementFile.Name);
end;

procedure TcsSpellCorrectTask.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
var
  l_S: AnsiString;
begin
 inherited;
 if (Status <> cs_tsDone) then
 begin
  ReadFileFrom(aStream, TaskFolder);
  ReadString(aStream, l_S);
  ReplacementFile.Name := ConcatDirName(TaskFolder, l_S);
 end;//Status <> cs_tsDone
end;

procedure TcsSpellCorrectTask.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
var
 l_Filename: AnsiString;
begin
 inherited;
 if (Status <> cs_tsDone) then
 begin
  l_FileName:= ExtractFileName(ReplacementFile.Name);
  if DirectoryExists(ReplacementFile.Name) then
  // - это не файл, а директория - надо пока записать "пустышку"
   WriteFileTo(aStream, '', l_FileName)
  else
   WriteFileTo(aStream, ReplacementFile.Name, l_FileName);
  WriteString(aStream, l_FileName);
 end;//Status <> cs_tsDone
end;


function TcsSpellCorrectTask.HasFilesToTransfer: Boolean;
begin
 Result := True;
end;

function TcsSpellCorrectTask.TransferFiles(
  const aService: IcsFileTransferServices): Boolean;
var
 l_Name: AnsiString;
begin
 l_Name := ExtractFileName(ReplacementFile.Name);
 Result := aService.TransferFile(TaskFolder, ReplacementFile.Name, l_Name);
 ReplacementFile.Name := ConcatDirName(TaskFolder, l_Name);
end;

function TcsSpellCorrectTask.ExpandTransferFileName(const aFileName: String; out theBasePath, theFileName: String): Boolean;
begin
 Result := l3IsSameFileName(aFileName, ReplacementFile.Name);
 if Result then
 begin
  theFileName := ReplacementFile.Name;
  theBasePath := IncludeTrailingPathDelimiter(ExtractFilePath(ReplacementFile.Name));
 end;
end;

end.
