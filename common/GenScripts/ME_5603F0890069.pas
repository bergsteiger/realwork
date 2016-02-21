unit ddExportFilerDispatcher;

// Модуль: "w:\common\components\rtl\Garant\dd\PipeOut\ddExportFilerDispatcher.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3Interfaces
 , ddExportFilerMap
 , ddPipeOutInterfaces
 , l3Filer
 , dt_Types
;

type
 TddFileMaskArray = array [TddExportDocPart] of Il3CString;

 TddExportDivideByArray = array [TddExportDocPart] of TddExportDivideBySet;

 TddCurrentFilesArray = array [TddExportDocPart] of IUnknown;

 TddExportFilerDispatcher = class(Tl3ProtoObject)
  private
   f_FileMask: TddFileMaskArray;
   f_Map: TddExportFilerMap;
   f_DivideBy: TddExportDivideByArray;
   f_SingleFiler: Tl3CustomFiler;
   f_CurrentFiles: TddCurrentFilesArray;
   f_CurrentTopic: TDocID;
   f_CodePage: LongInt;
    {* Поле для свойства CodePage }
   f_ExportDate: TDateTime;
    {* Поле для свойства ExportDate }
   f_FilePartSize: Integer;
    {* Поле для свойства FilePartSize }
   f_TargetFolder: AnsiString;
    {* Поле для свойства TargetFolder }
   f_FileExt: AnsiString;
    {* Поле для свойства FileExt }
   f_LowcaseFilenames: Boolean;
    {* Поле для свойства LowcaseFilenames }
   f_IsDirByMain: Boolean;
    {* Поле для свойства IsDirByMain }
   f_UpdateFiles: Boolean;
    {* Поле для свойства UpdateFiles }
  private
   procedure DropCurrentFilesData;
  protected
   function pm_GetFileMask(aPart: TddExportDocPart): Il3CString; virtual;
   procedure pm_SetFileMask(aPart: TddExportDocPart;
    const aValue: Il3CString); virtual;
   function pm_GetDivideBy(aPart: TddExportDocPart): TddExportDivideBySet; virtual;
   procedure pm_SetDivideBy(aPart: TddExportDocPart;
    aValue: TddExportDivideBySet); virtual;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   function GetFiler(aTopic: TDocID;
    aPart: TddExportDocPart;
    const aAccGroup: Il3CString): Tl3CustomFiler;
   procedure Start;
    {* Корректирует маски файлов и DivideBy, обнуляет файлеры }
   procedure Finish;
    {* Закрывает все открытые файлеры }
   procedure RollBack;
    {* Удаляет уже вылитые данные текущего топика (случай аварийного отката) }
   function GetActualDir(const aMain: AnsiString): AnsiString;
  public
   property CodePage: LongInt
    read f_CodePage
    write f_CodePage;
   property FileMask[aPart: TddExportDocPart]: Il3CString
    read pm_GetFileMask
    write pm_SetFileMask;
   property DivideBy[aPart: TddExportDocPart]: TddExportDivideBySet
    read pm_GetDivideBy
    write pm_SetDivideBy;
   property ExportDate: TDateTime
    read f_ExportDate
    write f_ExportDate;
   property FilePartSize: Integer
    read f_FilePartSize
    write f_FilePartSize;
   property TargetFolder: AnsiString
    read f_TargetFolder
    write f_TargetFolder;
   property FileExt: AnsiString
    read f_FileExt
    write f_FileExt;
   property LowcaseFilenames: Boolean
    read f_LowcaseFilenames
    write f_LowcaseFilenames;
   property IsDirByMain: Boolean
    read f_IsDirByMain;
   property UpdateFiles: Boolean
    read f_UpdateFiles
    write f_UpdateFiles;
 end;//TddExportFilerDispatcher

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Chars
 , ddExportFilerDispatcherElem
 , l3FileUtils
 , l3Types
 , ddUtils
 , l3String
 , l3Const
 , l3Base
 , Classes
;

function TddExportFilerDispatcher.pm_GetFileMask(aPart: TddExportDocPart): Il3CString;
//#UC START# *5603FBF902CB_5603F0890069get_var*
//#UC END# *5603FBF902CB_5603F0890069get_var*
begin
//#UC START# *5603FBF902CB_5603F0890069get_impl*
 Result := f_FileMask[aPart];
//#UC END# *5603FBF902CB_5603F0890069get_impl*
end;//TddExportFilerDispatcher.pm_GetFileMask

procedure TddExportFilerDispatcher.pm_SetFileMask(aPart: TddExportDocPart;
 const aValue: Il3CString);
//#UC START# *5603FBF902CB_5603F0890069set_var*
//#UC END# *5603FBF902CB_5603F0890069set_var*
begin
//#UC START# *5603FBF902CB_5603F0890069set_impl*
 f_FileMask[aPart] := aValue;
//#UC END# *5603FBF902CB_5603F0890069set_impl*
end;//TddExportFilerDispatcher.pm_SetFileMask

function TddExportFilerDispatcher.pm_GetDivideBy(aPart: TddExportDocPart): TddExportDivideBySet;
//#UC START# *560A4EE9011B_5603F0890069get_var*
//#UC END# *560A4EE9011B_5603F0890069get_var*
begin
//#UC START# *560A4EE9011B_5603F0890069get_impl*
 Result := f_DivideBy[aPart];
//#UC END# *560A4EE9011B_5603F0890069get_impl*
end;//TddExportFilerDispatcher.pm_GetDivideBy

procedure TddExportFilerDispatcher.pm_SetDivideBy(aPart: TddExportDocPart;
 aValue: TddExportDivideBySet);
//#UC START# *560A4EE9011B_5603F0890069set_var*
//#UC END# *560A4EE9011B_5603F0890069set_var*
begin
//#UC START# *560A4EE9011B_5603F0890069set_impl*
 f_DivideBy[aPart] := aValue;
//#UC END# *560A4EE9011B_5603F0890069set_impl*
end;//TddExportFilerDispatcher.pm_SetDivideBy

constructor TddExportFilerDispatcher.Create;
//#UC START# *560A4BA903C9_5603F0890069_var*
//#UC END# *560A4BA903C9_5603F0890069_var*
begin
//#UC START# *560A4BA903C9_5603F0890069_impl*
 inherited;
 f_Map := TddExportFilerMap.Create;
 f_CodePage := CP_OEMLite;
//#UC END# *560A4BA903C9_5603F0890069_impl*
end;//TddExportFilerDispatcher.Create

function TddExportFilerDispatcher.GetFiler(aTopic: TDocID;
 aPart: TddExportDocPart;
 const aAccGroup: Il3CString): Tl3CustomFiler;
//#UC START# *560A4C0F00CA_5603F0890069_var*
var
 l_FileName: AnsiString;
 l_Folder: AnsiString;
 l_IFileName: Il3CString;
 l_Index: TddFilerDispatcherMapKeyRecord;
 l_FilerHolder: IddExportFilerDispatcherElem;
 l_DateStr: AnsiString;
 l_FilePartSize: Integer;
//#UC END# *560A4C0F00CA_5603F0890069_var*
begin
//#UC START# *560A4C0F00CA_5603F0890069_impl*
 if (aTopic <> f_CurrentTopic) and (aPart in [edpDocument, edpAnnotation]) then
 begin
  DropCurrentFilesData;
  f_CurrentTopic := aTopic;
 end;

 l_Folder := GetActualDir(l3Str(aAccGroup));
 ForceDirectories(l_Folder);

 if edbTopic in DivideBy[aPart] then
 begin
  // делим по топикам, маска и другое просто не имеет значения
  l_FileName := IntToStr(aTopic);
  if aPart = edpAnnotation then
   l_FileName := l_FileName + 'a';
  l_FileName := ConcatDirName(l_Folder, l_FileName + f_FileExt);
  FreeAndNil(f_SingleFiler);
  try
   f_SingleFiler := Tl3DOSFiler.Make(l_FileName, l3_fmWrite);
   f_SingleFiler.Open;
   f_SingleFiler.CodePage := f_CodePage;
  except
   on E: Exception do
    l3System.Msg2Log(cFilerOpenErrorMsg, [E.Message, l_FileName]);
  end;
  f_CurrentFiles[aPart] := l3CStr(l_FileName);
  Result := f_SingleFiler;
 end
 else
 begin
  l_Index.rPart := aPart;
  if (edbAccGroup in DivideBy[aPart]) or f_IsDirByMain then
   l_Index.rAccGroup := aAccGroup
  else
   l_Index.rAccGroup := l3CStr(''); // если мейнов в маске нет, то незачем плодить файлеры
  if f_Map.Has(l_Index) then
   l_FilerHolder := f_Map.ValueByKey(l_Index)
  else
  begin
   l_IFileName := l3StringReplace(FileMask[aPart], cExportFileMaskPatterns[eptAccGroup], aAccGroup.AsWStr, [rfReplaceAll, rfIgnoreCase]);
   l_DateStr := ddUtils.DateToString(f_ExportDate);
   l_IFileName := l3StringReplace(l_IFileName, cExportFileMaskPatterns[eptExportDate], l3PCharLen(l_DateStr), [rfReplaceAll, rfIgnoreCase]);
   l_FileName := ConcatDirName(l_Folder, ChangeFileExt(l3Str(l_IFileName), f_FileExt));
   l_IFileName := l3CStr(l_FileName);
   if f_LowcaseFilenames then
    l_IFileName := l3Lower(l_IFileName);
   if edbSize in DivideBy[aPart] then
    l_FilePartSize := f_FilePartSize
   else
    l_FilePartSize := 0;
   l_FilerHolder := TddExportFilerDispatcherElem.Make(l_IFileName, f_CodePage, l_FilePartSize, f_UpdateFiles);
   f_Map.Add(l_Index, l_FilerHolder);
  end;
  f_CurrentFiles[aPart] := l_FilerHolder;
  Result := l_FilerHolder.Filer;
 end;
//#UC END# *560A4C0F00CA_5603F0890069_impl*
end;//TddExportFilerDispatcher.GetFiler

procedure TddExportFilerDispatcher.Start;
 {* Корректирует маски файлов и DivideBy, обнуляет файлеры }
//#UC START# *560A5979037E_5603F0890069_var*
var
 l_DocPart: TddExportDocPart;

 procedure CorrectByPattern(aDocPart: TddExportDocPart; aPattern: TddExportFileMaskPatternType; aDivideBy: TddExportDivideBySet);
 begin
  if l3Pos(FileMask[aDocPart], cExportFileMaskPatterns[aPattern], False) <> l3NotFound then
   DivideBy[aDocPart] := DivideBy[aDocPart] + aDivideBy;
 end;

 procedure CorrectByDivideBy(aDocPart: TddExportDocPart; aDivideBy: TddExportDivideBy; aPattern: TddExportFileMaskPatternType);
 var
  l_Ext: AnsiString;
  l_FilePart: Il3CString;
 begin
  if (aDivideBy in DivideBy[aDocPart]) and (l3Pos(FileMask[aDocPart], cExportFileMaskPatterns[aPattern], False) = l3NotFound) then
  begin
   l_Ext := ExtractFileExt(l3Str(FileMask[aDocPart]));
   l_FilePart := l3Copy(FileMask[aDocPart], 0, FileMask[aDocPart].AsWStr.SLen - Length(l_Ext));
   FileMask[aDocPart] := l3Cat([l_FilePart, l3CStr('_'), l3CStr(cExportFileMaskPatterns[aPattern]), l3CStr(l_Ext)]);
  end;
 end;

//#UC END# *560A5979037E_5603F0890069_var*
begin
//#UC START# *560A5979037E_5603F0890069_impl*
 f_Map.Clear; // на всякий случай
 FreeAndNil(f_SingleFiler);

 Assert(f_TargetFolder <> '', 'Пустое имя папки экспорта');

 for l_DocPart := edpDocument to edpAnnotation do
 begin
  if l3IsNil(FileMask[l_DocPart]) then
   FileMask[l_DocPart] := l3CStr(cDefaultFileMask[l_DocPart])
  else
  begin
   CorrectByPattern(l_DocPart, eptAccGroup, [edbAccGroup]);
   CorrectByPattern(l_DocPart, eptPartNum, [edbSize]);
  end;
  CorrectByDivideBy(l_DocPart, edbAccGroup, eptAccGroup);
  CorrectByDivideBy(l_DocPart, edbSize, eptPartNum);
  if edbSize in DivideBy[l_DocPart] then
   Assert(FilePartSize > 0, 'Ошибка! Требуется разделение по размеру, но не указан требуемый размер!');
 end;
 f_IsDirByMain := l3Pos(l3CStr(f_TargetFolder), cExportFileMaskPatterns[eptAccGroup], False) <> l3NotFound;
 DropCurrentFilesData;
//#UC END# *560A5979037E_5603F0890069_impl*
end;//TddExportFilerDispatcher.Start

procedure TddExportFilerDispatcher.Finish;
 {* Закрывает все открытые файлеры }
//#UC START# *560BA6EA03BC_5603F0890069_var*
//#UC END# *560BA6EA03BC_5603F0890069_var*
begin
//#UC START# *560BA6EA03BC_5603F0890069_impl*
 f_Map.Clear;
 FreeAndNil(f_SingleFiler);
 DropCurrentFilesData;
//#UC END# *560BA6EA03BC_5603F0890069_impl*
end;//TddExportFilerDispatcher.Finish

procedure TddExportFilerDispatcher.RollBack;
 {* Удаляет уже вылитые данные текущего топика (случай аварийного отката) }
//#UC START# *5617725803A8_5603F0890069_var*
var
 l_Part: TddExportDocPart;
 l_Str: Il3CString;
 l_Elem: IddExportFilerDispatcherElem;
//#UC END# *5617725803A8_5603F0890069_var*
begin
//#UC START# *5617725803A8_5603F0890069_impl*
 for l_Part := edpDocument to edpAnnotation do
 begin
  FreeAndNil(f_SingleFiler);
  if f_CurrentFiles[l_Part] <> nil then
  begin
   if Supports(f_CurrentFiles[l_Part], IddExportFilerDispatcherElem, l_Elem) then
    l_Elem.RollBack
   else
   if Supports(f_CurrentFiles[l_Part], Il3CString, l_Str) then
   begin
    DeleteFile(l3Str(l_Str));
   end
   else
    Assert(False, 'Что-то непонятное в данных о текущем топике!');
  end;
 end;
//#UC END# *5617725803A8_5603F0890069_impl*
end;//TddExportFilerDispatcher.RollBack

procedure TddExportFilerDispatcher.DropCurrentFilesData;
//#UC START# *5617897D0210_5603F0890069_var*
var
 l_Part: TddExportDocPart;
//#UC END# *5617897D0210_5603F0890069_var*
begin
//#UC START# *5617897D0210_5603F0890069_impl*
 for l_Part := edpDocument to edpAnnotation do
  f_CurrentFiles[l_Part] := nil;
//#UC END# *5617897D0210_5603F0890069_impl*
end;//TddExportFilerDispatcher.DropCurrentFilesData

function TddExportFilerDispatcher.GetActualDir(const aMain: AnsiString): AnsiString;
//#UC START# *561BA41E0388_5603F0890069_var*
//#UC END# *561BA41E0388_5603F0890069_var*
begin
//#UC START# *561BA41E0388_5603F0890069_impl*
 if f_IsDirByMain then
  Result := l3Str(l3StringReplace(l3CStr(f_TargetFolder), cExportFileMaskPatterns[eptAccGroup],
            l3CStr(aMain).AsWStr, [rfReplaceAll, rfIgnoreCase]))
 else
  Result := f_TargetFolder; 
//#UC END# *561BA41E0388_5603F0890069_impl*
end;//TddExportFilerDispatcher.GetActualDir

procedure TddExportFilerDispatcher.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5603F0890069_var*
//#UC END# *479731C50290_5603F0890069_var*
begin
//#UC START# *479731C50290_5603F0890069_impl*
 FreeAndNil(f_Map);
 inherited;
//#UC END# *479731C50290_5603F0890069_impl*
end;//TddExportFilerDispatcher.Cleanup

end.
