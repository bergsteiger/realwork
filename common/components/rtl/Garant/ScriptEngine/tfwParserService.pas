unit tfwParserService;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwParserService.pas"
// Стереотип: "Service"
// Элемент модели: "TtfwParserService" MUID: (57726B250063)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3StringList
 , tfwParserServiceFileNameToFileNameMap
;

 (*
 MtfwParserService = interface
  {* Контракт сервиса TtfwParserService }
  function MakeCompiledCodeName(const aFileName: AnsiString;
   const anExt: AnsiString): AnsiString;
  function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  procedure AddIncludePath(const aPath: AnsiString);
 end;//MtfwParserService
 *)

type
 ItfwParserService = interface
  {* Интерфейс сервиса TtfwParserService }
  function MakeCompiledCodeName(const aFileName: AnsiString;
   const anExt: AnsiString): AnsiString;
  function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  procedure AddIncludePath(const aPath: AnsiString);
 end;//ItfwParserService

 TtfwParserService = {final} class(Tl3ProtoObject)
  private
   f_CoFileDir: AnsiString;
   f_IncludePaths: Tl3StringList;
   f_FileNameToFileNameMap: TtfwParserServiceFileNameToFileNameMap;
   f_Alien: ItfwParserService;
    {* Внешняя реализация сервиса ItfwParserService }
  protected
   procedure pm_SetAlien(const aValue: ItfwParserService);
   procedure LoadIncludePaths;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   function MakeCompiledCodeName(const aFileName: AnsiString;
    const anExt: AnsiString): AnsiString;
   function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
   procedure AddIncludePath(const aPath: AnsiString);
   class function Instance: TtfwParserService;
    {* Метод получения экземпляра синглетона TtfwParserService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ItfwParserService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ItfwParserService }
 end;//TtfwParserService

implementation

uses
 l3ImplUses
 , SysUtils
 , IniFiles
 , l3FileUtils
 , StrUtils
 , l3Base
 //#UC START# *57726B250063impl_uses*
 , Classes
 //#UC END# *57726B250063impl_uses*
;

var g_TtfwParserService: TtfwParserService = nil;
 {* Экземпляр синглетона TtfwParserService }

procedure TtfwParserServiceFree;
 {* Метод освобождения экземпляра синглетона TtfwParserService }
begin
 l3Free(g_TtfwParserService);
end;//TtfwParserServiceFree

procedure TtfwParserService.pm_SetAlien(const aValue: ItfwParserService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TtfwParserService.pm_SetAlien

procedure TtfwParserService.LoadIncludePaths;
//#UC START# *57CD20D1028F_57726B250063_var*
var
 l_IniName : String;
 l_IncludeName : String;
 l_Strings : TStrings;
 l_Index : Integer;
//#UC END# *57CD20D1028F_57726B250063_var*
begin
//#UC START# *57CD20D1028F_57726B250063_impl*
 if (f_IncludePaths = nil) then
 begin
  f_IncludePaths := Tl3StringList.Create;
  l_IncludeName := '.';
  l_IniName := ChangeFileExt(ParamStr(0), '.ini');
  if FileExists(l_IniName) then
  begin
   with TIniFile.Create(l_IniName) do
    try
     l_IncludeName := ReadString('SCRIPT', 'IncludeFile', '.');
    finally
     Free;
    end;
  end;//FileExists(l_IniName)
  if (l_IncludeName = '.') then
  begin
   l_IncludeName := ConcatDirName(GetCurrentDir, ExtractFileName(ChangeFileExt(ParamStr(0), '.include.ini')));
  end//l_IncludeName = '.'
  else
  begin
   if (ExtractFilePath(l_IncludeName) = '') then
   begin
    l_IncludeName := ConcatDirName(ExtractFilePath(ParamStr(0)), l_IncludeName);
   end;//ExtractFilePath(l_IncludeName) = ''
  end;//l_IncludeName = '.'
  if FileExists(l_IncludeName) then
  begin
   l_Strings := TStringList.Create;
   try
    with TIniFile.Create(l_IncludeName) do
     try
      ReadSectionValues('INCLUDE', l_Strings);
     finally
      Free;
     end;
     for l_Index := 0 to Pred(l_Strings.Count) do
      f_IncludePaths.Add(l_Strings.Values[l_Strings.Names[l_Index]]);
   finally
    FreeAndNil(l_Strings);
   end;//try..finally
  end;//FileExists(l_IncludeName)
 end;//f_IncludePaths = nil
//#UC END# *57CD20D1028F_57726B250063_impl*
end;//TtfwParserService.LoadIncludePaths

function TtfwParserService.MakeCompiledCodeName(const aFileName: AnsiString;
 const anExt: AnsiString): AnsiString;
//#UC START# *57726B410203_57726B250063_var*
const
 cDefaultDir = 'C:\Temp';
 //cDefaultDir = '.';
var
 l_Path : String;
 l_IniName : String;
//#UC END# *57726B410203_57726B250063_var*
begin
//#UC START# *57726B410203_57726B250063_impl*
 if (f_Alien <> nil) then
  Result := MakeCompiledCodeName(aFileName, anExt)
 else
 begin
  if (f_CoFileDir = '') then
  begin
   l_IniName := ChangeFileExt(ParamStr(0), '.ini');
   if FileExists(l_IniName) then
   begin
    with TIniFile.Create(l_IniName) do
     try
      f_CoFileDir := ReadString('SCRIPT', 'CoFileDir', cDefaultDir);
     finally
      Free;
     end;
   end;//FileExists(l_IniName)
   if (f_CoFileDir = '') then
    f_CoFileDir := cDefaultDir;
  end;//f_CoFileDir = ''
  if (f_CoFileDir = '.') then
   Result := aFileName + anExt
  else
  begin
   l_Path := ExtractFilePath(aFileName);
   if (l_Path = '') OR (l_Path = '.\') then
    l_Path := GetCurrentDir;
   l_Path := AnsiReplaceStr(l_Path, ':', '');
   l_Path := AnsiReplaceStr(l_Path, '\\', '\');
   Result := ConcatDirName(f_CoFileDir, ConcatDirName(l_Path, ExtractFileName(aFileName) + anExt));
   l_Path := ExtractFilePath(Result);
//   if (l_Path = 'C:\Temp\') then
//    l_Path := ExtractFilePath(Result);
   ForceDirectories(l_Path);
  end;//f_CoFileDir = '.'
 end;//f_Alien <> nil
//#UC END# *57726B410203_57726B250063_impl*
end;//TtfwParserService.MakeCompiledCodeName

function TtfwParserService.ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
//#UC START# *57A9967B0182_57726B250063_var*

 procedure DoResolve;
 var
  l_Index : Integer;
  l_FileName : String;
  l_ResultFileName : String;
  l_ItemIndex : Integer;
 begin//DoResolve
  Result := aFile;
  if not AnsiStartsText('axiom:', Result) then
  begin
   if (f_FileNameToFileNameMap = nil) then
    f_FileNameToFileNameMap := TtfwParserServiceFileNameToFileNameMap.Create;
   f_FileNameToFileNameMap.Lock;
   try
    begin
     l_ItemIndex := f_FileNameToFileNameMap.IndexByKey(Result);
     if (l_ItemIndex >= 0) then
     begin
      Result := f_FileNameToFileNameMap.ValueByIndex(l_ItemIndex);
      Exit;
     end//f_FileNameToFileNameMap.Has(Result)
     else
     if (f_FileNameToFileNameMap.Count > 5000) then
      f_FileNameToFileNameMap.Clear;
    end;//f_FileNameToFileNameMap = nil
    if not FileExists(Result) then
    begin
     LoadIncludePaths;
     if (f_IncludePaths <> nil) then
     begin
      l_FileName := ExtractFileName(Result);
      for l_Index := 0 to Pred(f_IncludePaths.Count) do
      begin
       l_ResultFileName := ConcatDirName(f_IncludePaths[l_Index].AsString, l_FileName);
       if FileExists(l_ResultFileName) then
       begin
        f_FileNameToFileNameMap.Add(Result, l_ResultFileName);
        Result := l_ResultFileName;
        Exit;
       end;//FileExists(l_ResultFileName)
      end;//for l_Index
      f_FileNameToFileNameMap.Add(Result, Result);
     end;//f_IncludePaths <> nil
    end//not FileExists(Result)
    else
     f_FileNameToFileNameMap.Add(Result, Result);
   finally
    f_FileNameToFileNameMap.Unlock;
   end;//try..finally
  end;//not AnsiStartsText('axiom:', Result)
 end;//DoResolve

//#UC END# *57A9967B0182_57726B250063_var*
begin
//#UC START# *57A9967B0182_57726B250063_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.ResolveIncludedFilePath(aFile)
 else
  DoResolve;
//#UC END# *57A9967B0182_57726B250063_impl*
end;//TtfwParserService.ResolveIncludedFilePath

procedure TtfwParserService.AddIncludePath(const aPath: AnsiString);
//#UC START# *57CD20F100D7_57726B250063_var*
//#UC END# *57CD20F100D7_57726B250063_var*
begin
//#UC START# *57CD20F100D7_57726B250063_impl*
 if (f_Alien <> nil) then
  f_Alien.AddIncludePath(aPath)
 else
 begin
  LoadIncludePaths;
  Assert(f_IncludePaths <> nil);
  if (f_IncludePaths.IndexOf(aPath) < 0) then
   f_IncludePaths.Add(aPath);
 end;//f_Alien <> nil
//#UC END# *57CD20F100D7_57726B250063_impl*
end;//TtfwParserService.AddIncludePath

class function TtfwParserService.Instance: TtfwParserService;
 {* Метод получения экземпляра синглетона TtfwParserService }
begin
 if (g_TtfwParserService = nil) then
 begin
  l3System.AddExitProc(TtfwParserServiceFree);
  g_TtfwParserService := Create;
 end;
 Result := g_TtfwParserService;
end;//TtfwParserService.Instance

class function TtfwParserService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TtfwParserService <> nil;
end;//TtfwParserService.Exists

procedure TtfwParserService.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57726B250063_var*
//#UC END# *479731C50290_57726B250063_var*
begin
//#UC START# *479731C50290_57726B250063_impl*
 FreeAndNil(f_IncludePaths);
 FreeAndNil(f_FileNameToFileNameMap);
 inherited;
//#UC END# *479731C50290_57726B250063_impl*
end;//TtfwParserService.Cleanup

procedure TtfwParserService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TtfwParserService.ClearFields

end.
