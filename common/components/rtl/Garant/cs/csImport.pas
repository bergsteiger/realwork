unit csImport;

interface

uses
 Classes,
 csProcessTask,
 DT_types,
 l3Base,
 csMessageManager,

 csImportTaskPrim
 ;

type
  TcsImportTaskItem = class(TcsImportTaskPrim)
  private
//    f_DeleteIncluded: Boolean;
//    f_IsAnnotation: Boolean;
//    f_IsRegion: Boolean;
//    f_MessageManager: TcsMessageManager;
//    f_SourceDir: AnsiString;
//    f_SourceFiles: TStrings;
    procedure LoadSourceFolderFrom(aStream: TStream);
(*    procedure pm_SetSourceFiles(const Value: TStrings);*)
    procedure SaveSourceFolderTo(aStream: TStream);
  protected
    procedure Cleanup; override;
    function GetDescription: AnsiString; override;
    procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
    function pm_GetTaskFolder: AnsiString; override;
  public
    constructor Create(aUserID: TUserID); override;
    function HasFilesToTransfer: Boolean; override;
    function TransferFiles(const aService: IcsFileTransferServices): Boolean; override;
    function ExpandTransferFileName(const aFileName: String; out theBasePath, theFileName: String): Boolean; override;
    procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
(*    property DeleteIncluded: Boolean read f_DeleteIncluded write
            f_DeleteIncluded;
    property IsAnnotation: Boolean read f_IsAnnotation write f_IsAnnotation;
    property IsRegion: Boolean read f_IsRegion write f_IsRegion;*)
(*    property MessageManager: TcsMessageManager read f_MessageManager write
        f_MessageManager;*)
(*    property SourceDir: AnsiString read f_SourceDir write f_SourceDir;*)
//    property SourceFiles: TStrings read f_SourceFiles write pm_SetSourceFiles;
  end;//TcsImportTaskItem

implementation

uses
 csTaskTypes, SysUtils,
 l3FileUtils, ddUtils, StrUtils, l3Types,
 l3Stream, ddFileIterator,
 csTasksHelpers,

 k2Tags,
 Task_Const
 ;


{
****************************** TcsImportTaskItem *******************************
}
constructor TcsImportTaskItem.Create(aUserID: TUserID);
begin
 inherited;
 //f_SourceFiles := TStringList.Create;
 //TaskType := cs_ttImport;
end;

procedure TcsImportTaskItem.Cleanup;
begin
 //l3Free(f_SourceFiles);
 inherited;
end;

function TcsImportTaskItem.GetDescription: AnsiString;
var
 i: Integer;
 l_Mask, l_Descript: AnsiString;
 l_Total, l_Count: Int64;
begin
 if (SourceFiles.Count > 0) and (TaggedData.StrA[k2_attrDescription] = '') then
 begin
  case CheckFileType(SourceFiles, IsAnnotation) of
    dd_itGarant:
     begin
      l_Descript:= 'гарант';
      l_Mask := '*.nsr';
     end;
    dd_itEverest,
    dd_itEverestInternal:
     begin
      l_Descript:= 'эверест';
      l_Mask := '*.evd';
     end;
    dd_itRTFAnnotation :
     begin
      l_Descript := 'ms word'; // ddDocReader
      l_Mask := '*.doc';
     end;
    dd_itTXTAnnotation :
     begin
      l_Descript := 'текст'; // evPlainText
      l_Mask := '*.txt';
     end;
  else
   begin
    l_Descript := 'формат неизвестен';
    l_Mask := '*.*';
   end;
  end;
  l_Count:= 0; l_Total:= 0;
  for i := 0 to Pred(SourceFiles.Count) do
  begin
   Inc(l_Total, SizeofFile(SourceFiles.Strings[i]));
   Inc(l_Count);
  end;
  Result:= Format('Импорт файлов %s: %d (%s)', [l_Descript, l_Count, Bytes2Str(l_Total)]);
 end
 else
  Result:= TaggedData.StrA[k2_attrDescription];
end;

procedure TcsImportTaskItem.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
begin
  inherited;
  DeleteIncluded := ReadBoolean(aStream);
  IsAnnotation := ReadBoolean(aStream);
  IsRegion := ReadBoolean(aStream);
  SourceDir := ReadString(aStream);
  if aIsPipe then
   LoadSourceFolderFrom(aStream);
end;

procedure TcsImportTaskItem.LoadSourceFolderFrom(aStream: TStream);
var
 i, l_Count: Integer;
begin
 l_Count := ReadInteger(aStream);
 for i:= 0 to Pred(l_Count) do
  ReadFileFrom(aStream, TaskFolder);
 // Заполнить список
 with TddFileIterator.Make(TaskFolder, '*.*') do
 try
  SourceFiles.CopyFrom(FileList);
 finally
  Free;
 end;
end;

(*procedure TcsImportTaskItem.pm_SetSourceFiles(const Value: TStrings);
begin
 if f_SourceFiles <> Value then
 begin
  f_SourceFiles.Assign(Value);
 end;
end;*)

function TcsImportTaskItem.pm_GetTaskFolder: AnsiString;
begin
 Result := ConcatDirName(TaggedData.StrA[k2_attrTaskFolder], 'Import\' + TaskID);
end;

procedure TcsImportTaskItem.SaveSourceFolderTo(aStream: TStream);
var
  l_FilesIDX: Integer;
  l_AdditionalIDX: Integer;
  l_Additional: AdditionalFilesHelper;
  l_Count, j: Integer;
  l_BaseFileName: AnsiString;
  l_AddFileName: AnsiString;
//  l_FileName: AnsiString;
//  l_LocalFile: AnsiString;
//  l_LocalFolder: AnsiString;
begin
 l_Count := SourceFiles.Count;
 for l_FilesIDX:= 0 to Pred(SourceFiles.Count) do
  Inc(l_Count, SourceFiles.AdditionalFiles[l_FilesIDX].Count);
 aStream.Write(l_Count, SizeOf(Integer));
 for l_FilesIDX:= 0 to Pred(SourceFiles.Count) do
 begin
  l_BaseFileName := SourceFiles.Strings[l_FilesIDX];
{  l_FileName := SourceFiles.Strings[l_FilesIDX];
  if AnsiStartsText('###', l_FileName) then
  begin
   Delete(l_FileName, 1, 3);
   l_LocalFile := ExtractFileName(l_FileName);
   l_LocalFolder := ExtractFilePath(l_FileName);
   Assert(AnsiStartsText(SourceDir, l_LocalFolder), 'В !OBJTOPIC могут быть только относительные пути!');
   Delete(l_LocalFolder, 1, Length(SourceDir));
   if l_LocalFolder[1] = '\' then
    Delete(l_LocalFolder, 1, 1);
   l_LocalFile := ConcatDirName(l_LocalFolder, l_LocalFile);
  end
  else
   l_LocalFile := '';
  WriteFileTo(aStream, l_FileName, l_LocalFile);
}
  WriteFileTo(aStream, l_BaseFileName, '');
  l_Additional := SourceFiles.AdditionalFiles[l_FilesIDX];
  for l_AdditionalIDX := 0 to l_Additional.Count - 1 do
  begin
   l_AddFileName := l_Additional.Strings[l_AdditionalIDX];
   WriteFileTo(aStream, l_AddFileName, ExtractRelativePath(ExtractFilePath(l_BaseFileName), l_AddFileName));
  end;
 end;
end;

procedure TcsImportTaskItem.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
begin
  inherited;
  WriteBoolean(aStream, DeleteIncluded);
  WriteBoolean(aStream, IsAnnotation);
  WriteBoolean(aStream, IsRegion);
  WriteString(aStream, SourceDir);
  if aIsPipe then
   SaveSourceFolderTo(aStream);
end;

function TcsImportTaskItem.HasFilesToTransfer: Boolean;
begin
 Result := True;
end;

function TcsImportTaskItem.TransferFiles(
  const aService: IcsFileTransferServices): Boolean;
var
 l_SourceIDX: Integer;
 l_SourceFiles: SourceFilesHelper;
 l_AdditionalIDX: Integer;
 l_AdditionalFiles: AdditionalFilesHelper;
 l_BasePath: AnsiString;
 l_Name: AnsiString;
begin
 Result := False;
 l_SourceFiles := SourceFiles;
 try
  for l_SourceIDX := 0 to l_SourceFiles.Count - 1 do
  begin
   l_Name := ExtractFileName(l_SourceFiles.Strings[l_SourceIDX]);
   if not aService.TransferFile(TaskFolder, l_SourceFiles.Strings[l_SourceIDX], l_Name) then
    Exit;
   l_BasePath := ExtractFilePath(l_SourceFiles[l_SourceIDX]);
   l_SourceFiles.ChangeName(l_SourceIDX, ConcatDirName(TaskFolder, l_Name));
   l_AdditionalFiles := l_SourceFiles.AdditionalFiles[l_SourceIDX];
   for l_AdditionalIDX := 0 to l_AdditionalFiles.Count - 1 do
   begin
    l_Name := ExtractRelativePath(l_BasePath, l_AdditionalFiles[l_AdditionalIDX]);
    if not aService.TransferFile(TaskFolder, l_AdditionalFiles[l_AdditionalIDX], l_Name) then
     Exit;
    l_AdditionalFiles.ChangeName(l_AdditionalIDX, ConcatDirName(TaskFolder, l_Name));
   end;
  end;
 finally
  l_SourceFiles := nil;
 end;
 Result := True;
end;

function TcsImportTaskItem.ExpandTransferFileName(const aFileName: String; out theBasePath, theFileName: String): Boolean;
var
 l_SourceIDX: Integer;
 l_SourceFiles: SourceFilesHelper;
 l_AdditionalIDX: Integer;
 l_AdditionalFiles: AdditionalFilesHelper;
 l_BasePath: AnsiString;
 l_Name: AnsiString;
begin
 l_Name := aFileName;
 Assert(l_Name <> '');
 if (Pos(DriveDelim, l_Name) < 1) and (l_Name[1] <> PathDelim) then
  l_Name := PathDelim + l_Name;
 Result := False;
 l_SourceFiles := SourceFiles;
 try
  for l_SourceIDX := 0 to l_SourceFiles.Count - 1 do
  begin
   l_BasePath := IncludeTrailingPathDelimiter(ExtractFilePath(l_SourceFiles[l_SourceIDX]));
   if AnsiEndsText(l_Name, l_SourceFiles.Strings[l_SourceIDX]) then
   begin
    Result := True;
    theBasePath := l_BasePath;
    theFileName := l_SourceFiles.Strings[l_SourceIDX];
    Exit;
   end;
   l_AdditionalFiles := l_SourceFiles.AdditionalFiles[l_SourceIDX];
   for l_AdditionalIDX := 0 to l_AdditionalFiles.Count - 1 do
   begin
    if AnsiEndsText(l_Name, l_AdditionalFiles[l_AdditionalIDX]) then
    begin
     Result := True;
     theBasePath := l_BasePath;
     theFileName := l_AdditionalFiles[l_AdditionalIDX];
     Exit;
    end;
   end;
  end;
 finally
  l_SourceFiles := nil;
 end;
end;

end.
