unit ddFileIterator;

interface
Uses
 l3Base,
 Classes, SysUtils,
 l3Types, l3ProtoObject;

type
 TddIterateProc = function (const aFileName: AnsiString): Boolean;
 TddObjIterateProc = function (const aFileName: AnsiString): Boolean of Object;
 TddFileIterator = class(Tl3ProtoObject)
 private
  f_AsFolders: Boolean;
  f_FileList : TStrings;
  f_TotalSize: Int64;
  f_FileAttr : word;
  f_FileMask : AnsiString;
  f_Directory: AnsiString;
  f_ExcludeMasks: TStrings;
  f_IterateStatus: Boolean;
  f_MaxFileCount: Integer;
  f_OnProgress: Tl3ProgressProc;
  f_ProgressValue: Integer;
  f_WithSubDir: Boolean;
 private
  procedure AddFileName(const aFileName: AnsiString);
  procedure GenerateExcludeMasks(const Value: AnsiString);
  function pm_GetCount: Integer;
  function pm_GetEmpty: Boolean;
  function pm_GetExcludeMask: AnsiString;
  procedure pm_SetExcludeMask(const Value: AnsiString);
  procedure pm_SetMaxFileCount(const Value: Integer);
  procedure Progress(aState : Byte; aValue : Long; const aMsg : AnsiString = '');
 protected
  procedure Cleanup; override;
  procedure LoadOneMask(const aRoot, theFileMask: AnsiString); virtual;
 public
  constructor Create;
  constructor Make(aDirectory, aFileMask: AnsiString; aProgressProc: Tl3ProgressProc
      = nil; aWithSubDir: Boolean = False; aFileAttr: Word = faAnyFile);
  constructor MakeFolders(aDirectory, aFolderMask: AnsiString; aProgressProc: Tl3ProgressProc = nil;
      aWithSubDir: Boolean = False);
  procedure AddExcludeMask(const aMask: AnsiString);
  procedure LoadFiles;
  { Загрузка файлов из указанной папки в соответствии с маской и атрибутами }
  procedure IterateFiles(aProc: TddIterateProc; aStart: Integer = 0; aFinish: Integer = -1); overload;
  { Загрузка файлов из указанной папки в соответствии с маской и атрибутами }
  procedure IterateFiles(aProc: TddObjIterateProc; aStart: Integer = 0; aFinish: Integer = -1);
      overload;
  class procedure SplitFileMask(theFileMask: AnsiString; theList: TStrings);
  function ValidFileName(const aFileName: AnsiString): Boolean;
  { перебирает список файлов }
 public
  property AsFolders: Boolean read f_AsFolders write f_AsFolders;
  property Count: Integer read pm_GetCount;
  property FileList: TStrings
   read f_FileList;

  property TotalSize: Int64
   read f_TotalSize;

  property FileMask: AnsiString
   read f_FileMask
   write f_FileMask;

  property FileAttr: word
   read f_FileAttr
   write f_FileAttr;

  property Directory: AnsiString
   read f_Directory
   write f_Directory;
  property WithSubDir: Boolean read f_WithSubDir write f_WithSubDir;

  property Empty: Boolean read pm_GetEmpty;
  property ExcludeMask: AnsiString read pm_GetExcludeMask write pm_SetExcludeMask;
  property MaxFileCount: Integer read f_MaxFileCount write pm_SetMaxFileCount;
  property OnProgress: Tl3ProgressProc read f_OnProgress write f_OnProgress;
 published
  property IterateStatus: Boolean read f_IterateStatus;
 end;

function L2IterateFilesProc(aFunc: Pointer): TddIterateProc; register;
procedure FreeIterateFilesProc(var theStub: TddIterateProc); register;

implementation

Uses
 l3FileUtils,
 StrUtils,
 //IdBaseComponent,
 Masks, Math;

constructor TddFileIterator.Create;
begin
 inherited;
 f_FileList:= TStringList.Create;
 with TStringList(f_FileList) do
 begin
  CaseSensitive:= False;
  Sorted:= True;
 end; // with TStringList(f_FileList)
 f_FileAttr:= faAnyFile;
 f_FileMask := '*.*';
 f_WithSubDir:= False;
 f_ExcludeMasks := TStringList.Create;
 f_AsFolders:= False;
end;

procedure TddFileIterator.Cleanup;
begin
 FreeAndNil(f_FileList);
 FreeAndNil(f_ExcludeMasks);
 inherited;
end;

procedure TddFileIterator.LoadFiles;
var
 l_MaskList : TStrings;
 i: Integer;
begin
 f_FileList.Clear;
 f_TotalSize:= 0;
 f_ProgressValue:= 0;
 l_MaskList := TStringList.Create;
 try
  Progress(0, 100, 'Поиск файлов');
  SplitFileMask(f_FileMask, l_MaskList);
  for i:= 0 to Pred(l_MaskList.Count) do
   LoadOneMask(f_Directory, l_MaskList.Strings[i]);
  Progress(2, 100, 'Поиск файлов завершен');
 finally
  l_MaskList.Free;
 end;
end;

procedure TddFileIterator.IterateFiles(aProc: TddIterateProc; aStart: Integer = 0; aFinish: Integer
    = -1);
var
 i: Integer;
 l_Finish: Integer;
begin
 l_Finish:= IfThen(aFinish = -1, f_FileList.Count, aFinish);
 if InRange(aStart, 0, l_Finish) and InRange(l_Finish, aStart, f_FileList.Count) then
 begin
  f_IterateStatus:= True;
  Progress(0, l_Finish-aStart, 'Начинается обработка файлов');
  for i:= aStart to Pred(l_Finish) do
  begin
   Progress(1, i, f_FileList.Strings[i]);
   if not aProc(f_FileList.Strings[i]) then
   begin
    f_IterateStatus:= False;
    break;
   end; // not aProc(f_FileList.Strings[i])
  end; // for i
  Progress(2, l_Finish-aStart, 'Обработка файлов завершена');
 end;
end;

procedure TddFileIterator.IterateFiles(aProc: TddObjIterateProc; aStart: Integer = 0; aFinish:
    Integer = -1);
var
 i: Integer;
 l_Finish: Integer;
begin
 l_Finish:= IfThen(aFinish = -1, f_FileList.Count, aFinish);
 if InRange(aStart, 0, l_Finish) and InRange(l_Finish, aStart, f_FileList.Count) then
 begin
  f_IterateStatus:= True;
  Progress(0, l_Finish-aStart, 'Начинается обработка файлов');
  for i:= aStart to Pred(l_Finish) do
  begin
   Progress(1, i, f_FileList.Strings[i]);
   if not aProc(f_FileList.Strings[i]) then
   begin
    f_IterateStatus:= False;
    break;
   end; // not aProc(f_FileList.Strings[i])
  end; // for i
  Progress(2, l_Finish-aStart, 'Обработка файлов завершена');
 end; // InRange(aStart, 0, l_Finish) and InRange(l_Finish, aStart, f_FileList.Count)
end;

procedure TddFileIterator.LoadOneMask(const aRoot, theFileMask: AnsiString);
var
 l_SR: TSearchRec;
 l_SubDir: AnsiString;
begin
  if FindFirst(ConcatDirName(aRoot, theFileMask), f_FileAttr, l_SR) = 0 then
  repeat
   if (AsFolders and (l_SR.Attr and faDirectory = faDirectory)) or
      (not AsFolders and (l_SR.Attr and (faDirectory or faVolumeID) = 0)) then
   begin
    if ValidFileName(l_SR.Name) then
    begin
     Inc(f_TotalSize, Longword(l_SR.Size)); // Для файлов больше 2Гб
     AddFileName(ConcatDirName(aRoot, l_SR.Name));
    end; // ValidFileName 
   end;
  until FindNext(l_SR) <> 0;
  FindClose(l_SR);

  if f_WithSubDir then
  begin
   if FindFirst(ConcatDirName(aRoot, '*.*'), faDirectory	, l_SR) = 0 then
   repeat
    if (l_SR.Attr and faDirectory <> 0) and (l_SR.Name[1] <> '.') then
    begin
     l_SubDir := ConcatDirName(aRoot, l_SR.Name);
     LoadOneMask(l_SubDir, theFileMask);
    end;
   until FindNext(l_SR) <> 0;
   FindClose(l_SR);
  end;
end;

constructor TddFileIterator.Make(aDirectory, aFileMask: AnsiString; aProgressProc:
    Tl3ProgressProc = nil; aWithSubDir: Boolean = False; aFileAttr: Word =
    faAnyFile);
begin
 Create;
 Directory:= aDirectory;
 FileMask:= aFileMask;
 FileAttr:= aFileAttr;
 WithSubDir:= aWithSubDir;
 OnProgress:= aProgressProc;
 LoadFiles;
end;

constructor TddFileIterator.MakeFolders(aDirectory, aFolderMask: AnsiString; aProgressProc:
    Tl3ProgressProc = nil; aWithSubDir: Boolean = False);
begin
 Create;
 Directory:= aDirectory;
 FileMask:= aFolderMask;
 FileAttr:= faDirectory;
 WithSubDir:= aWithSubDir;
 OnProgress:= aProgressProc;
 AsFolders:= True;
 LoadFiles;
end;

procedure TddFileIterator.AddExcludeMask(const aMask: AnsiString);
begin
 f_ExcludeMasks.Add(aMask);
end;

procedure TddFileIterator.AddFileName(const aFileName: AnsiString);
begin
 f_FileList.Add(aFileName);
 if f_ProgressValue = 100 then
  f_ProgressValue:= 0;
 Inc(f_ProgressValue);
 Progress(1, f_ProgressValue); 
end;

procedure TddFileIterator.GenerateExcludeMasks(const Value: AnsiString);
var
 l_Start, l_Finish: AnsiString;
 l_StartPos, l_FinishPos: Integer;
 l_VarStart, l_VarFinish: AnsiString;
 i, j: Integer;
 l_VarStartInt, l_VarFinishInt: Integer;
begin
 l_StartPos:= Pos('[', Value);
 l_FinishPos:= Pos(']', Value);
 l_Start:= Copy(Value, Succ(l_StartPos), Pred(l_FinishPos-l_StartPos));
 l_StartPos:= PosEx('[', Value, l_FinishPos);
 l_FinishPos:= PosEx(']', Value, Succ(l_FinishPos));
 l_Finish:= Copy(Value, Succ(l_StartPos), Pred(l_FinishPos-l_StartPos));
 // Теперь пытаемся найти фрагмент, который меняется, чтобы сформировать набор масок...
 l_VarStart:= '';
 l_VarFinish:= '';
 l_StartPos:= 1;
 // Ищем начало различия
 while (l_Start[l_StartPos] = l_Finish[l_StartPos]) and
       ((l_StartPos < Length(l_Start)) and (l_StartPos < Length(l_Finish))) do Inc(l_StartPos);
 // Ищем окончание различия
 i:= Length(l_Start);
 j:= Length(l_Finish);
 while L_Start[i] = l_Finish[j] do
 begin
  Dec(i);
  Dec(j);
 end;
 // Вдруг пропустили символ
 while (l_Start[Succ(i)] in ['0'..'9']) and (l_Start[Succ(i)] = l_Finish[Succ(j)]) do
 begin
  Inc(i);
  Inc(j);
 end;
 l_VarStart:= Copy(l_Start, l_StartPos, i-l_StartPos+1);
 l_VarFinish:= Copy(l_Finish, l_StartPos, j-l_StartPos+1);
 // Начинаем строить массив
 l_VarStartInt:= StrToIntDef(l_VarStart, -1);
 l_VarFinishInt:= StrToIntDef(l_VarFinish, -1);
 if (l_VarStartInt <> -1) and (l_VarFinishInt <> -1) then
 begin
  // Хорошо бы сначала удалить шаблон, а потом вставлять
  Delete(l_Start, l_StartPos, i-l_StartPos+1);
  for i:= l_VarStartInt to l_VarFinishInt do
  begin
   l_Finish:= l_Start;
   Insert(IntToStr(i), l_Finish, l_StartPos);
   AddExcludeMask(l_Finish);
  end 
 end
 else
 begin
  AddExcludeMask(l_Start);
  AddExcludeMask(l_Finish);
 end;
end;

function TddFileIterator.pm_GetCount: Integer;
begin
 Result := f_FileList.Count;
end;

function TddFileIterator.pm_GetEmpty: Boolean;
begin
 Result := Count = 0;
end;

function TddFileIterator.pm_GetExcludeMask: AnsiString;
begin
 if f_ExcludeMasks.Count > 0 then
  Result := f_ExcludeMasks[0]
 else
  Result:= '';
end;

procedure TddFileIterator.pm_SetExcludeMask(const Value: AnsiString);
begin
 if AnsiStartsStr('[', Value) then
  GenerateExcludeMasks(Value)
 else
  AddExcludeMask(Value);
end;

procedure TddFileIterator.pm_SetMaxFileCount(const Value: Integer);
begin
 f_MaxFileCount := Value;
end;

procedure TddFileIterator.Progress(aState : Byte; aValue : Long; const aMsg : AnsiString = '');
begin
 if Assigned(f_OnProgress) then
  f_OnProgress(aState, aValue, aMsg);
end;

class procedure TddFileIterator.SplitFileMask(theFileMask: AnsiString; theList: TStrings);
var
 i, j, k: Integer;
begin
 j:= 1;
 repeat
  i:= PosEx(';', theFileMask, j);
  if i = 0 then
   i:= PosEx(',', theFileMask, j);
  if i = 0 then
   k := Length(theFileMask)
  else
   k := Pred(i);
  theList.Add(Trim(Copy(theFileMask, j, k)));
  j := Succ(i);
 until i = 0;
end;

function TddFileIterator.ValidFileName(const aFileName: AnsiString): Boolean;
var
 i: Integer;
begin
 Result:= True;
 for i:= 0 to Pred(f_ExcludeMasks.Count) do
  if MatchesMask(aFileName, f_ExcludeMasks[i]) then
  begin
   Result:= False;
   break;
  end;
end;

function L2IterateFilesProc(aFunc: Pointer): TddIterateProc; register;
asm
 jmp l3LocalStub
end;

procedure FreeIterateFilesProc(var theStub: TddIterateProc); register;
asm
 jmp l3FreeLocalStub
end;

end.
