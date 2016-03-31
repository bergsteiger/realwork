{$IfNDef atIterateThroughFilesAddOn_imp}

// Модуль: "w:\quality\test\garant6x\AdapterTest\Operations\atIterateThroughFilesAddOn.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "atIterateThroughFilesAddOn" MUID: (502A769902EE)
// Имя типа: "_atIterateThroughFilesAddOn_"

{$Define atIterateThroughFilesAddOn_imp}

 _atIterateThroughFilesAddOn_ = class(_atIterateThroughFilesAddOn_Parent_)
  private
   f_FileList: TatStringFileReader;
  private
   function InitFileList: Boolean; virtual;
   procedure IterateThroughFiles; virtual;
  protected
   function OnFile(const aFileName: AnsiString): Boolean; virtual; abstract;
   procedure ExecuteSelf; override;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitParamList; override;
 end;//_atIterateThroughFilesAddOn_

{$Else atIterateThroughFilesAddOn_imp}

{$IfNDef atIterateThroughFilesAddOn_imp_impl}

{$Define atIterateThroughFilesAddOn_imp_impl}

function _atIterateThroughFilesAddOn_.InitFileList: Boolean;
//#UC START# *502A64880035_502A769902EE_var*
  var
    l_Strings : TStringList;
    l_SyncFile, l_BaseDir, l_FileMask, l_DataFile : String;
    l_IsRecursive : Boolean;
//#UC END# *502A64880035_502A769902EE_var*
begin
//#UC START# *502A64880035_502A769902EE_impl*
  Result := true;
  l_SyncFile := Parameters['files.sync_file'].AsStr;
  l_BaseDir := Parameters['files.base_dir'].AsStr;
  l_FileMask := Parameters['files.mask'].AsStr;
  l_IsRecursive := Parameters['files.is_recursive'].AsBool;
  //
  if l_SyncFile <> '' then
    l_DataFile := l_SyncFile + '.data_file'
  else
    l_DataFile := '';
  //
  if Assigned(f_FileList) then
  begin
    if l_SyncFile = '' then
      f_FileList.Reset;
  end
  else
    with TatFileInitializer.Create(l_DataFile) do
    try
      if TryInit then
      try
        l_Strings := TStringList.Create;
        try
          // составляем список полных имен всех файлов удовлетворяющих параметрам
          with TatFileIterator.Create(l_BaseDir, l_FileMask, l_IsRecursive) do
          try
            while NOT AtEnd do
            begin
              l_Strings.Add(FullPath);
              MoveNext;
            end;
          finally
            Free;
          end;
          //
          if l_Strings.Count = 0 then
          begin
            Logger.Error('Не найдено ни одного файла с указанными параметрами!');
            Result := false;
            Exit;
          end;
          // инициализируем файл
          Stream.Seek(0, soFromBeginning);
          l_Strings.SaveToStream(Stream);
        finally
          FreeAndNil(l_Strings);
        end;
      finally
        FinishInit;
      end;
      //
      if l_SyncFile = '' then
        f_FileList := TatStringFileReader.Create(FileName) // FileName показывает на временный файл
      else
        f_FileList := TatSyncedStringFileReader.Create(FileName, l_SyncFile);

      f_FileList.Looped := Parameters['files.is_looped'].AsBool;
      f_FileList.Random := Parameters['files.is_random'].AsBool;
    finally
      Free;
    end;
//#UC END# *502A64880035_502A769902EE_impl*
end;//_atIterateThroughFilesAddOn_.InitFileList

procedure _atIterateThroughFilesAddOn_.IterateThroughFiles;
//#UC START# *502A794E002F_502A769902EE_var*
  var
    l_FileName : String;
    l_FilesLeft : Integer;
//#UC END# *502A794E002F_502A769902EE_var*
begin
//#UC START# *502A794E002F_502A769902EE_impl*
  l_FilesLeft := Parameters['files.max_count'].AsInt;
  //
  while ((l_FilesLeft = -1) OR (l_FilesLeft > 0)) AND f_FileList.AcquireNext(l_FileName) do
  begin
    if NOT FileExists(l_FileName) then
      Logger.Error('Файл %s не найден к моменту открытия!', [l_FileName])
    else
    begin
      Logger.Info('Обрабатываем файл ' + l_FileName);

      Env.EnvVar[ENV_CURRENT_FILE_PATH] := l_FileName;
      
      if NOT OnFile(l_FileName) then
      begin
        Logger.Info('Обработка файлов прервана.');
        break;
      end;
    end;
    //
    if l_FilesLeft <> -1 then
      Dec(l_FilesLeft);
  end;
//#UC END# *502A794E002F_502A769902EE_impl*
end;//_atIterateThroughFilesAddOn_.IterateThroughFiles

procedure _atIterateThroughFilesAddOn_.ExecuteSelf;
//#UC START# *48089F460352_502A769902EE_var*
//#UC END# *48089F460352_502A769902EE_var*
begin
//#UC START# *48089F460352_502A769902EE_impl*
  inherited;
  //
  if InitFileList then
    IterateThroughFiles;
//#UC END# *48089F460352_502A769902EE_impl*
end;//_atIterateThroughFilesAddOn_.ExecuteSelf

procedure _atIterateThroughFilesAddOn_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_502A769902EE_var*
//#UC END# *479731C50290_502A769902EE_var*
begin
//#UC START# *479731C50290_502A769902EE_impl*
  FreeAndNil(f_FileList);
  inherited;
//#UC END# *479731C50290_502A769902EE_impl*
end;//_atIterateThroughFilesAddOn_.Cleanup

procedure _atIterateThroughFilesAddOn_.InitParamList;
//#UC START# *48089F3701B4_502A769902EE_var*
//#UC END# *48089F3701B4_502A769902EE_var*
begin
//#UC START# *48089F3701B4_502A769902EE_impl*
  inherited;
  with f_ParamList do
  begin
    Add( ParamType.Create('files.base_dir', 'Корневая папка откуда будем обрабатывать файлы', '') );
    Add( ParamType.Create('files.mask', 'Маска обрабатываемых файлов', '*') );
    Add( ParamType.Create('files.is_recursive', 'Обрабатывать файлы в подкаталогах?', 'false') );
    Add( ParamType.Create('files.sync_file', 'Файл синхронизации, если обработка файлов должна быть синхронизирована между разныи клиентами', '') );
    Add( ParamType.Create('files.is_looped', 'Открывать файлы по кругу?', 'false') );
    Add( ParamType.Create('files.is_random', 'Открывать файлы в случайном порядке?', 'false') );
    Add( ParamType.Create('files.max_count', 'Открывать не больще заданного количества файлов', '-1') );
  end;
//#UC END# *48089F3701B4_502A769902EE_impl*
end;//_atIterateThroughFilesAddOn_.InitParamList

{$EndIf atIterateThroughFilesAddOn_imp_impl}

{$EndIf atIterateThroughFilesAddOn_imp}

