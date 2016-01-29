unit adEngine;

{ $Id: adEngine.pas,v 1.8 2014/10/20 09:48:04 fireton Exp $ }

interface

uses
 l3Types,
 l3Interfaces,
 l3ProtoObject,
 l3StringList,
 l3Except,
 l3ProtoObjectRefList,

 JclSimpleXML;

type
 TadItem = class(Tl3ProtoObject)
 private
  f_Alias: AnsiString;
  f_Changed: Boolean;
  f_Name: AnsiString;
  f_Files: Tl3StringList;
  f_IsValid: Boolean;
  f_TargetFolder: AnsiString;
  f_ValidityArr: array of Boolean;
  function pm_GetFiles(aIndex: Integer): AnsiString;
  function pm_GetFilesCount: Integer;
  function pm_GetIsFileValid(aIndex: Integer): Boolean;
  procedure pm_SetName(const Value: AnsiString);
  procedure pm_SetTargetFolder(const Value: AnsiString);
  procedure RefreshValidity;
 protected
  procedure Cleanup; override;
 public
  constructor Create;
  function AddFile(const aFileName: AnsiString): Integer;
  procedure ClearFiles;
  procedure DeleteFile(aIndex: Integer);
  procedure Distribute;
  procedure Load(const aBox: TJclSimpleXMLElem);
  procedure Save(const aBox: TJclSimpleXMLElem);
  function CheckDistribution(const aErrorList: Tl3StringList = nil): Boolean;
  property Alias: AnsiString read f_Alias write f_Alias;
  property Changed: Boolean read f_Changed write f_Changed;
  property Files[aIndex: Integer]: AnsiString read pm_GetFiles;
  property FilesCount: Integer read pm_GetFilesCount;
  property IsFileValid[aIndex: Integer]: Boolean read pm_GetIsFileValid;
  property IsValid: Boolean read f_IsValid;
  property Name: AnsiString read f_Name write pm_SetName;
  property TargetFolder: AnsiString read f_TargetFolder write pm_SetTargetFolder;
 end;

 TadManager = class(Tl3ProtoObject)
 private
  f_Filename: AnsiString;
  f_IsValid: Boolean;
  f_Items: Tl3ProtoObjectRefList;
 private
  function pm_GetItemCount: Integer;
  function pm_GetItems(aIndex: Integer): TadItem;
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aFilename: AnsiString);
  procedure AddItem(const anItem: TadItem);
  procedure Archive(const aZipName: AnsiString; const aProgressProc: Tl3ProgressProc);
  function CheckDistribution(const aErrorList: Tl3StringList = nil): Boolean;
  function CheckArchive(const aArchiveFileName: AnsiString; const aErrorList: Tl3StringList = nil): Boolean;
  procedure DeleteItem(anIndex: Integer);
  procedure Distribute(const aProgressProc: Tl3ProgressProc);
  procedure Load;
  procedure RefreshValidity;
  procedure Save;
  property IsValid: Boolean read f_IsValid;
  property ItemCount: Integer read pm_GetItemCount;
  property Items[aIndex: Integer]: TadItem read pm_GetItems;
 end;

 EadLoadError = class(El3Error);

implementation

uses
 Classes,
 SysUtils,

 l3Base,
 l3String,
 l3StringListPrim,
 l3Stream,
 l3Variant,
 l3FileUtils,

 ZipForge;

const
 cLoadErrorStr = 'Ошибка загрузки элемента из XML'; 

constructor TadItem.Create;
begin
 inherited Create;
 f_Files := Tl3StringList.MakeSorted;
end;

function TadItem.AddFile(const aFileName: AnsiString): Integer;
begin
 Result := f_Files.Add(l3CStr(aFileName));
 RefreshValidity;
end;

function TadItem.CheckDistribution(const aErrorList: Tl3StringList = nil): Boolean;
 function CheckOneFile(Data: Pointer; Index: Long): Bool;
 var
  l_FN: AnsiString;
  l_TargetFileName: AnsiString;
  l_FHandle: Integer;
 begin
  Result := True;
  l_FN := Tl3PrimString(Data^).AsString;
  l_TargetFileName := ConcatDirName(TargetFolder, ExtractFileName(l_FN));
  if FileExists(l_TargetFileName) then
  begin
   l_FHandle := FileOpen(l_TargetFileName, fmShareExclusive);
   if l_FHandle < 0 then
   begin
    CheckDistribution := False;
    aErrorList.Add(l_TargetFileName);
   end
   else
    FileClose(l_FHandle);
  end;
 end;
var
 l_IA: Tl3IteratorAction;
begin
 Result := True;
 l_IA := l3L2IA(@CheckOneFile);
 f_Files.IterateAllF(l_IA);
end;

procedure TadItem.DeleteFile(aIndex: Integer);
begin
 f_Files.Delete(aIndex);
 RefreshValidity;
end;


procedure TadItem.Load(const aBox: TJclSimpleXMLElem);
var
 I: Integer;
 l_List: TJclSimpleXMLElem;
 l_Tag: TJclSimpleXMLElem;

 procedure CheckTag;
 begin
  if l_Tag = nil then
   raise EadLoadError.Create(cLoadErrorStr);
 end;

begin
 f_Files.Clear;
 l_Tag := aBox.Items.ItemNamed['alias'];
 CheckTag;
 f_Alias := l_Tag.Value;
 l_Tag := aBox.Items.ItemNamed['name'];
 CheckTag;
 f_Name := l_Tag.Value;
 l_Tag := aBox.Items.ItemNamed['target'];
 CheckTag;
 f_TargetFolder := l_Tag.Value;
 l_Tag := aBox.Items.ItemNamed['files'];
 CheckTag;
 l_List := l_Tag;
 for I := 0 to l_List.Items.Count - 1 do
 begin
  l_Tag :=l_List.Items.Item[I];
  f_Files.Add(l3CStr(l_Tag.Value));
 end;
 RefreshValidity;
end;


procedure TadItem.Cleanup;
begin
 FreeAndNil(f_Files);
 inherited;
end;

procedure TadItem.ClearFiles;
begin
 f_Files.Clear;
end;

procedure TadItem.Distribute;

 function DoOneFile(Data: Pointer; Index: Long): Bool;
 var
  l_FN: AnsiString;
  l_TargetFileName: AnsiString;
 begin
  Result := True;
  l_FN := Tl3PrimString(Data^).AsString;
  l_TargetFileName := ConcatDirName(TargetFolder, ExtractFileName(l_FN));
  CopyFile(l_FN, l_TargetFileName, cmWriteOver + cmNoBakCopy);
 end;

var
 l_IA: Tl3IteratorAction;
begin
 l_IA := l3L2IA(@DoOneFile);
 f_Files.IterateAllF(l_IA)
end;

function TadItem.pm_GetFiles(aIndex: Integer): AnsiString;
begin
 Result := l3Str(f_Files.ItemW[aIndex]);
end;

function TadItem.pm_GetFilesCount: Integer;
begin
 Result := f_Files.Count;
end;

function TadItem.pm_GetIsFileValid(aIndex: Integer): Boolean;
begin
 if (Length(f_ValidityArr) = 0) then
  RefreshValidity;
 Result := f_ValidityArr[aIndex];
end;

procedure TadItem.pm_SetName(const Value: AnsiString);
begin
 f_Name := Value;
 f_Changed := True;
end;

procedure TadItem.pm_SetTargetFolder(const Value: AnsiString);
begin
 f_TargetFolder := Value;
 f_Changed := True;
end;

procedure TadItem.RefreshValidity;
var
 I: Integer;
begin
 SetLength(f_ValidityArr, FilesCount);
 if FilesCount > 0 then
 begin
  f_IsValid := True;
  for I := 0 to FilesCount - 1 do
  begin
   f_ValidityArr[I] := FileExists(Files[I]);
   if not f_ValidityArr[I] then
    f_IsValid := False;
  end;
 end
 else
  f_IsValid := False;
 f_IsValid := f_IsValid and DirectoryExists(f_TargetFolder); 
end;

procedure TadItem.Save(const aBox: TJclSimpleXMLElem);
var
 I: Integer;
 l_List : TJclSimpleXMLElem;
 l_Tag  : TJclSimpleXMLElem;
begin
 l_Tag := aBox.Items.Add('alias');
 l_Tag.Value := f_Alias;
 l_Tag := aBox.Items.Add('name');
 l_Tag.Value := f_Name;
 l_Tag := aBox.Items.Add('target');
 l_Tag.Value := f_TargetFolder;
 l_List := aBox.Items.Add('files');
 for I := 0 to FilesCount - 1 do
 begin
  l_Tag := l_List.Items.Add('file');
  l_Tag.Value := Files[I];
 end;
end;

constructor TadManager.Create(const aFilename: AnsiString);
begin
 inherited Create;
 f_Filename := aFilename;
 f_Items := Tl3ProtoObjectRefList.Make;
end;

procedure TadManager.AddItem(const anItem: TadItem);
begin
 f_Items.Add(anItem);
 Save;
end;

procedure TadManager.Archive(const aZipName: AnsiString; const aProgressProc: Tl3ProgressProc);
var
 I, J: Integer;
 l_Zip: TZipForge;
 l_Dir: AnsiString;
 l_FS : Tl3FileStream;
 l_DT : TDateTime;
 l_FN: AnsiString;
begin
 l_Zip := TZipForge.Create(nil);
 try
  aProgressProc(piStart, ItemCount, 'Создаём архив дистрибутива');
  l_Zip.FileName := aZipName;
  l_Zip.OpenArchive(fmCreate);
  l_Zip.BeginUpdate;
  try
   for I := 0 to ItemCount - 1 do
   begin
    aProgressProc(piCurrent, I+1, 'Архивируем '+Items[I].Name);
    l_Dir := Items[I].Alias + '\';
    for J := 0 to Items[I].FilesCount - 1 do
    begin
     if FileExists(Items[I].Files[J]) then
     begin
      l_DT := FileDateToDateTime(FileAge(Items[I].Files[J]));
      l_FS := Tl3FileStream.Create(Items[I].Files[J], l3_fmRead);
      try
       l_FN := ExtractFileName(Items[I].Files[J]);
       l_Zip.AddFromStream(l_Dir + l_FN, l_FS, True, 0, 0, faArchive, l_DT);
      finally
       FreeAndNil(l_FS);
      end;
     end;
    end;
   end;
  finally
   l_Zip.EndUpdate;
   aProgressProc(piEnd, 0, '');
  end;
 finally
  FreeAndNil(l_Zip);
 end;
end;

function TadManager.CheckArchive(const aArchiveFileName: AnsiString; const aErrorList: Tl3StringList = nil): Boolean;
var
 l_Zip: TZipForge;
begin
 Result := False;
 l_Zip := TZipForge.Create(nil);
 try
  l_Zip.FileName := aArchiveFileName;
  l_Zip.OpenArchive;
  //l_Zip.
 finally
  FreeAndNil(l_Zip);
 end;
end;

function TadManager.CheckDistribution(const aErrorList: Tl3StringList = nil): Boolean;
 function DoOne(Data: Pointer; Index: Long): Bool;
 begin
  Result := True;
  if not TadItem(Data^).CheckDistribution(aErrorList) then
   CheckDistribution := False;
 end;
var
 l_IA: Tl3IteratorAction;
begin
 Result := True;
 l_IA := l3L2IA(@DoOne);
 f_Items.IterateAllF(l_IA);
end;

procedure TadManager.Cleanup;
begin
 FreeAndNil(f_Items);
 inherited;
end;

procedure TadManager.DeleteItem(anIndex: Integer);
begin
 f_Items.Delete(anIndex);
 Save;
end;

procedure TadManager.Distribute(const aProgressProc: Tl3ProgressProc);

 function DoOne(Data: Pointer; Index: Long): Bool;
 begin
  Result := True;
  TadItem(Data^).Distribute;
  aProgressProc(piCurrent, Index+1, 'Подкладываем' + TadItem(Data^).Name);
 end;

var
 l_IA: Tl3IteratorAction;
begin
 aProgressProc(piStart, f_Items.Count, 'Подкладываем дистрибутив');
 try
  l_IA := l3L2IA(@DoOne);
  f_Items.IterateAllF(l_IA);
 finally
  aProgressProc(piEnd, 0);
 end;
end;

procedure TadManager.Load;
var
 I: Integer;
 l_AdItem: TadItem;
 l_XML: TJclSimpleXml;
 l_ListTag: TJclSimpleXMLElem;
 l_Tag    : TJclSimpleXMLElem;
begin
 if FileExists(f_Filename) then
 begin
  l_XML := TJclSimpleXml.Create;
  try
   l_XML.LoadFromFile(f_Filename);
   f_Items.Clear;
   l_ListTag := l_XML.Root.Items.ItemNamed['items'];
   for I := 0 to l_ListTag.Items.Count-1 do
   begin
    l_AdItem := TadItem.Create;
    try
     l_AdItem.Load(l_ListTag.Items[I]);
     f_Items.Add(l_AdItem);
    finally
     FreeAndNil(l_AdItem);
    end;
   end;
  finally
   FreeAndNil(l_XML);
  end;
 end;
 RefreshValidity;
end;

function TadManager.pm_GetItemCount: Integer;
begin
 Result := f_Items.Count;
end;

function TadManager.pm_GetItems(aIndex: Integer): TadItem;
begin
 Result := TadItem(f_Items.Items[aIndex]);
end;

procedure TadManager.RefreshValidity;
 function DoOne(Data: Pointer; Index: Long): Bool;
 begin
  Result := True;
  TadItem(Data^).RefreshValidity;
  if not TadItem(Data^).IsValid then
   f_IsValid := False;
 end;
var
 l_IA : Tl3IteratorAction;
begin
 l_IA := l3L2IA(@DoOne);
 f_IsValid := True;
 f_Items.IterateAllF(l_IA);
end;

procedure TadManager.Save;
var
 I: Integer;
 l_XML: TJclSimpleXml;
 l_ListTag: TJclSimpleXMLElem;
 l_Tag    : TJclSimpleXMLElem;
begin
 l_XML := TJclSimpleXml.Create;
 try
  l_XML.Prolog.Encoding := 'utf-8';
  l_XML.Root.Name := 'root';
  l_ListTag := l_XML.Root.Items.Add('items');
  for I := 0 to ItemCount - 1 do
  begin
   l_Tag := l_ListTag.Items.Add('item');
   Items[I].Save(l_Tag);
  end;
  l_XML.SaveToFile(f_Filename);
 finally
  FreeAndNil(l_XML);
 end;
end;

end.