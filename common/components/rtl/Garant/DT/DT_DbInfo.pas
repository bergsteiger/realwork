unit DT_DbInfo;

// TDbInfo работает с INI-файлами.
// С основном только читает, менять может только номера версий.
// Номера версий читает либо из файла ARCHI.VERSION (если он имеется),
// либо из файлов BASE.INI в папках семейств и папке MAIN (если отсутствует файл ARCHI.VERSION).
// Таким образом наличие-отсутствие файла ARCHI.VERSION является признаком того, где хранятся
// сведения о версиях.

// Порядок правильного использования:
// 1. Create(ArchiIniFileName)
// 2. ActiveFamily := ...
// 3. Передача объекта в другие функции

{ $Id: DT_DbInfo.pas,v 1.7 2015/04/07 07:37:09 lukyanets Exp $ }
// $Log: DT_DbInfo.pas,v $
// Revision 1.7  2015/04/07 07:37:09  lukyanets
// Изолируем HT
//
// Revision 1.6  2014/05/26 16:06:18  lulin
// {RequestLink:537249703}
//
// Revision 1.4  2014/05/26 15:59:51  lulin
// {RequestLink:537249703}
//
// Revision 1.3  2014/05/23 16:31:10  lulin
// {RequestLink:537249703}
//
// Revision 1.2  2014/02/13 10:53:57  lulin
// - рефакторим безликие списки.
//
// Revision 1.1  2011/12/12 13:58:35  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.12  2009/03/05 09:04:48  narry
// - рефакторинг
//
// Revision 1.11  2009/02/09 10:54:17  fireton
// - версия базы 131
//
// Revision 1.10  2007/04/18 11:39:42  narry
// - процедура создания произвольной пустой базы
//
// Revision 1.9  2005/12/12 08:22:36  step
// Учтено изменение версии БД
//
// Revision 1.8  2005/12/09 14:03:18  step
// new: property HomesFolder
//
// Revision 1.7  2005/09/20 14:40:21  step
// учтено изменение версии БД
//
// Revision 1.6  2005/04/07 18:49:10  step
// добавлена проверка версии БД
//
// Revision 1.5  2005/02/08 16:54:18  step
// изменен алгоритм чтения-записи номера версии
//
// Revision 1.4  2004/12/23 11:47:19  lulin
// - rename unit: User_Cfg -> l3IniFile.
//
// Revision 1.3  2004/05/26 09:57:38  step
// исправление TDbInfo.Data
//
// Revision 1.2  2004/05/25 15:44:46  step
// изменен порядок нумерации версий
//
// Revision 1.1  2004/05/07 17:43:34  step
// куча мелких исправлений
//

interface

uses
 Classes,
 Contnrs,
 SysUtils,
 l3IniFile,
 Ht_Const,

 l3ProtoObject,

 dtFamilyInfo,
 dtFamilyInfoList
 ;

type

(*  TFamilyInfo = class(Tl3ProtoObject)
   Number: Integer;
   Name: string;
   Path: string;
   DocGroup: Integer;
   Attributes: Integer;
  end;*)

  TDbInfo = class(Tl3ProtoObject)
  private
   f_ArchiIni: string;
   f_ActiveFamilyIndex: Integer;
   f_FamiliesData: TdtFamilyInfoList;
   f_MainFolderPath: string;
   f_HomesFolderPath: string;
   f_DbRootFolderPath: string;
   f_ShareFolderPath: string;

   procedure GetFamiliesData(aIniFile: TCfgList);
   procedure GetMainFolderPath(aIniFile: TCfgList);
   procedure GetHomesFolderPath(aIniFile: TCfgList);
   procedure GetDbRootPath(aIniFile: TCfgList);
   procedure GetSharePath(aIniFile: TCfgList);

   function FamilyBaseIni: string;
   function MainFolderBaseIni: string;
   function ArchiVersionIni: string;
   function GetActiveFamily: string;
   procedure SetActiveFamily(const aFamilyName: string);
   function GetFamilyFolderVersion: Integer;
   procedure SetFamilyFolderVersion(aVersionNum: Integer);
   function GetMainFolderVersion: Integer;
   procedure SetMainFolderVersion(aVersionNum: Integer);
   function GetFamilyFolder: string;
  protected
   procedure ReadAllPaths;
  public
   constructor Create(aArchiIni: string);
   constructor Make(const aBaseRootFolder: String; const aHomesFolder: String = ''; const aMainFolder: String = ''; const
       aShareFolder: String = '');
   procedure Cleanup; override;

   // сведения о текущем состоянии для показа юзеру
   function Data: string;

   // имена семейств
   procedure GetFamilyNames(aList: TStrings);

   // проверка БД на "старость"
   procedure CheckFolderVersions; // выбрасывает исключение

   // папки (только чтение)
   property RootFolder: string read f_DbRootFolderPath;
   property ShareFolder: string read f_ShareFolderPath;
   property MainFolder: string read f_MainFolderPath;
   property HomesFolder: string read f_HomesFolderPath;
   property FamilyFolder: string read GetFamilyFolder;

   // версии
   property MainFolderVersion: Integer read GetMainFolderVersion write SetMainFolderVersion;
   property FamilyFolderVersion: Integer read GetFamilyFolderVersion write SetFamilyFolderVersion;

   property ActiveFamily: string read GetActiveFamily write SetActiveFamily;
  end;

  EDBInfoError = class(Exception);

implementation

uses
 Ht_Dll,
 Windows,
 StrUtils,
 Dialogs,
 IniFiles,
 l3Base, l3FileUtils,
 daInterfaces,
 dt_Const, dt_Types;

const
 BAD_VERSION = 0;
(*
 // Версии папок БД, с которыми тулза умеет работать.
 c_DocBaseVersion   = 114;
 c_AdminBaseVersion = 113;
*)
{ TDbInfo }

constructor TDbInfo.Create(aArchiIni: string);
begin
 if FileExists(aArchiIni) then
  f_ArchiIni := aArchiIni
 else
  raise EDBInfoError.CreateFmt('Файл %s не найден.', [aArchiIni]);

 f_FamiliesData := TdtFamilyInfoList.Create;
 f_ActiveFamilyIndex := -1;

 ReadAllPaths;

 f_ActiveFamilyIndex := 0;
end;

constructor TDbInfo.Make(const aBaseRootFolder: String; const aHomesFolder: String = ''; const aMainFolder: String =
    ''; const aShareFolder: String = '');
begin
 f_FamiliesData := TdtFamilyInfoList.Create;
 f_ActiveFamilyIndex := 0;
 f_DbRootFolderPath:= aBaseRootFolder;
 f_HomesFolderPath := IfThen(aHomesFolder = '', ConcatDirName(aBaseRootFolder, 'HOMES'), aHomesFolder);
 f_MainFolderPath := IfThen(aMainFolder = '', ConcatDirName(aBaseRootFolder, 'MAIN'), aMainFolder);
 f_ShareFolderPath := IfThen(aShareFolder = '', ConcatDirName(aBaseRootFolder, 'SHARE'), aShareFolder);
 GetFamiliesData(nil);
end;

procedure TDbInfo.Cleanup;
begin
 FreeAndNil(f_FamiliesData);
 inherited;
end;

function TDbInfo.FamilyBaseIni: string;
begin
 Result := ConcatDirName(f_FamiliesData[f_ActiveFamilyIndex].Path, 'base.ini');
end;

function TDbInfo.GetFamilyFolderVersion: Integer;
var
 l_IniFile: TIniFile;
 l_IniFileName: string;
begin
 Result := BAD_VERSION;

 l_IniFileName := FamilyBaseIni;
 if FileExists(l_IniFileName) then
 begin
  l_IniFile := TIniFile.Create(l_IniFileName);
  try
   Result := l_IniFile.ReadInteger('Tables', 'Version', BAD_VERSION);
  finally
   FreeAndNil(l_IniFile);
  end;
 end
 else
 begin
  l_IniFileName := ArchiVersionIni;
  if FileExists(l_IniFileName) then
  begin
   l_IniFile := TIniFile.Create(l_IniFileName);
   try
    Result := l_IniFile.ReadInteger('Version', 'Db', BAD_VERSION);
   finally
    FreeAndNil(l_IniFile);
   end;
  end;
 end;

 if Result = BAD_VERSION then
  raise EDBInfoError.Create('Не найден файл с данными о текущей версии таблиц в папке GARANT.');

end;

procedure TDbInfo.GetFamilyNames(aList: TStrings);
var
 I: Integer;
begin
 if aList = nil then
  Exit;
 aList.Clear;

 for I := 0 to f_FamiliesData.Count - 1 do
  aList.Add(f_FamiliesData[I].Name);
end;

procedure TDbInfo.GetFamiliesData(aIniFile: TCfgList);
const
 c_BadStr = '';
 c_BadNum = -1;
 c_Prefix = 'Family';
var
 l_SectionNames: TStringList;
 I: Integer;
 l_FamilyNum: Integer;
 l_FamilyInfo: TdtFamilyInfo;
begin
 f_FamiliesData.Clear;
 if aIniFile <> nil then
 begin
  // ищем секции [FamilyN] в  Archi.ini(ServerConfin.ini)
  // Если такие найдутся, то данные по базам документов берем оттуда
  l_SectionNames := TStringList.Create;
  try
   aIniFile.GetSectionNameList(l_SectionNames);
   for I := 0 to l_SectionNames.Count - 1 do
   begin
    if AnsiStartsText(c_Prefix, l_SectionNames[I]) then
    begin
     l_FamilyNum := StrToIntDef(Copy(l_SectionNames[I],
                                     Length(c_Prefix) + 1,
                                     MaxInt),
                                c_BadNum);
     if l_FamilyNum <> c_BadNum then
     begin
      aIniFile.Section := l_SectionNames[I];

      l_FamilyInfo := TdtFamilyInfo.Create;
      try
       l_FamilyInfo.Number     := l_FamilyNum;
       l_FamilyInfo.Name       := aIniFile.ReadParamStrDef('Name', c_BadStr);
       l_FamilyInfo.Path       := aIniFile.ReadParamStrDef('Path', c_BadStr);
       l_FamilyInfo.DocGroup   := aIniFile.ReadParamIntDef('DocGroup', c_BadNum);
       l_FamilyInfo.Attributes := aIniFile.ReadParamIntDef('Attributes', c_BadNum);

       if (l_FamilyInfo.Name = c_BadStr)
        or (l_FamilyInfo.Path = c_BadStr)
        or (l_FamilyInfo.DocGroup = c_BadNum)
        or (l_FamilyInfo.Attributes = c_BadNum)
       then
        FreeAndNil(l_FamilyInfo)
       else
        f_FamiliesData.Add(l_FamilyInfo);
      finally
       FreeAndNil(l_FamilyInfo);
      end;//try..finally
     end;
    end;
   end;
  finally
   FreeAndNil(l_SectionNames);
  end;
 end; // aIniFile <> nil
 // Если же секции [FamilyN] в Archi.ini(ServerConfin.ini) не найдены,
 // то данные по базам документов берутся из таблицы Family. Но поскольку
 // содердимое этой таблицы уже окаменело, то можно использовать константы.
 if f_FamiliesData.Count = 0 then
 begin
  l_FamilyInfo := TdtFamilyInfo.Create;
  try
   l_FamilyInfo.Number     := 1;
   l_FamilyInfo.Name       := 'Garant';
   l_FamilyInfo.Path       := ConcatDirName(f_DbRootFolderPath, 'Garant\');
   l_FamilyInfo.DocGroup   := 1;
   l_FamilyInfo.Attributes := 1;

   f_FamiliesData.Add(l_FamilyInfo);
  finally
   FreeAndNil(l_FamilyInfo);
  end;//try..finally
 end;
end;

function TDbInfo.MainFolderBaseIni: string;
begin
 Result := ConcatDirName(f_MainFolderPath, 'base.ini');
end;

procedure TDbInfo.ReadAllPaths;
const
 c_BadStr = '';
var
 l_CfgList: TCfgList;
 l_ServerCfgIni: string;
begin
 // сначала читаем локальный инишник
 l_CfgList := TCfgList.Create(f_ArchiIni);
 try
  l_CfgList.InitSubsts('FamilyConst');

  l_CfgList.Section := 'ServerConfig';
  l_ServerCfgIni := l_CfgList.ReadParamStrDef('ServerConfigINI', c_BadStr);

  // если локальный инишник содержит сведения о сетевом инишнике, то переключаем на сетевой
  if l_ServerCfgIni <> c_BadStr then
  begin
   l3Free(l_CfgList);

   l_CfgList := TCfgList.Create(l_ServerCfgIni);
   l_CfgList.InitSubsts('FamilyConst');
  end;

  // собственно refresh
  GetDbRootPath(l_CfgList);
  GetFamiliesData(l_CfgList);
  GetSharePath(l_CfgList);
  GetMainFolderPath(l_CfgList);
  GetHomesFolderPath(l_CfgList);

 finally
  l3Free(l_CfgList);
 end;
end;

procedure TDbInfo.GetMainFolderPath(aIniFile: TCfgList);
const
 c_BadStr = '';
begin
 aIniFile.Section := 'BaseDocPath';

 f_MainFolderPath := aIniFile.ReadParamStrDef('TablePath', c_BadStr);
 if f_MainFolderPath = c_BadStr then
  raise EDBInfoError.Create('Не указан путь к папке Main.');
 if not DirectoryExists(f_MainFolderPath) then
  raise EDBInfoError.CreateFmt('Папка %s не найдена.', [f_MainFolderPath]);
end;

procedure TDbInfo.GetDbRootPath(aIniFile: TCfgList);
const
 c_BadStr = '';
begin
 aIniFile.Section := 'FamilyConst';

 f_DbRootFolderPath := aIniFile.ReadParamStrDef('FamilyPath', c_BadStr);
 if f_DbRootFolderPath = c_BadStr then
  raise EDBInfoError.Create('Не указана FamilyConst.');
 if not DirectoryExists(f_DbRootFolderPath) then
  raise EDBInfoError.CreateFmt('Папка %s не найдена.', [f_DbRootFolderPath]);
end;

function TDbInfo.ArchiVersionIni: string;
begin
 Result := ConcatDirName(f_DbRootFolderPath, 'archi.version');
end;

function TDbInfo.GetFamilyFolder: string;
begin
 Result := f_FamiliesData[f_ActiveFamilyIndex].Path;
end;

procedure TDbInfo.SetFamilyFolderVersion(aVersionNum: Integer);
var
 l_IniFile: TIniFile;
begin
 l_IniFile := TIniFile.Create(FamilyBaseIni);
 try
  l_IniFile.WriteInteger('Tables', 'Version', aVersionNum);
 finally
  FreeAndNil(l_IniFile);
 end;
end;

procedure TDbInfo.GetSharePath(aIniFile: TCfgList);
const
 c_BadStr = '';
begin
 aIniFile.Section := 'BaseDocPath';

 f_ShareFolderPath := aIniFile.ReadParamStrDef('LockPath', c_BadStr);
 if f_ShareFolderPath = c_BadStr then
  raise EDBInfoError.Create('Не указан LockPath.');
 if not DirectoryExists(f_ShareFolderPath) then
  raise EDBInfoError.CreateFmt('Папка %s не найдена.', [f_ShareFolderPath]);
end;

function TDbInfo.GetActiveFamily: string;
begin
 Result := f_FamiliesData[f_ActiveFamilyIndex].Name;
end;

procedure TDbInfo.SetActiveFamily(const aFamilyName: string);
var
 I: Integer;
 l_Found: Integer;
begin
 l_Found := -1;
 for I := 0 to f_FamiliesData.Count - 1 do
  if AnsiCompareText(aFamilyName, f_FamiliesData[I].Name) = 0 then
  begin
   l_Found := I;
   Break;
  end;
 if l_Found > -1 then
  f_ActiveFamilyIndex := l_Found
 else
  raise EDBInfoError.CreateFmt('Неверное имя семейства: %s', [aFamilyName]);
end;

function TDbInfo.GetMainFolderVersion: Integer;
var
 l_IniFile: TIniFile;
 l_IniFileName: string;
begin
 Result := BAD_VERSION;

 l_IniFileName := MainFolderBaseIni;
 if FileExists(l_IniFileName) then
 begin
  l_IniFile := TIniFile.Create(l_IniFileName);
  try
   Result := l_IniFile.ReadInteger('Tables', 'Version', BAD_VERSION);
  finally
   FreeAndNil(l_IniFile);
  end;
 end
 else
 begin
  l_IniFileName := ArchiVersionIni;
  if FileExists(l_IniFileName) then
  begin
   l_IniFile := TIniFile.Create(l_IniFileName);
   try
    Result := l_IniFile.ReadInteger('Version', 'Db', BAD_VERSION);
   finally
    FreeAndNil(l_IniFile);
   end;
  end;
 end;

 if Result = BAD_VERSION then
  raise EDBInfoError.Create('Не найден файл с данными о текущей версии таблиц в папке MAIN.');

end;

procedure TDbInfo.SetMainFolderVersion(aVersionNum: Integer);
var
 l_IniFile: TIniFile;
begin
 l_IniFile := TIniFile.Create(MainFolderBaseIni);
 try
  l_IniFile.WriteInteger('Tables', 'Version', aVersionNum);
 finally
  FreeAndNil(l_IniFile);
 end;
end;

function TDbInfo.Data: string;
begin
 Result :=
  'База документов:' + #13#10 +
  '  Расположение: ' + FamilyFolder + #13#10 +
  '  Версия: ' + IntToStr(FamilyFolderVersion) + #13#10 +
  'Административная база:' + #13#10 +
  '  Расположение: '+ MainFolder + #13#10 +
  '  Версия: ' + IntToStr(MainFolderVersion);
end;

procedure TDbInfo.CheckFolderVersions;
const
 c_ErrMessage = 'Папка %s содержит данные версии %d.'#13#10 +
                'Программа может обрабатывать данные только версии %d.';
begin
 if (FamilyFolderVersion <> c_DocBaseVersion) then
  raise EDBInfoError.CreateFmt(c_ErrMessage, [FamilyFolder, FamilyFolderVersion, c_DocBaseVersion]);

 if (MainFolderVersion <> c_AdminBaseVersion) then
  raise EDBInfoError.CreateFmt(c_ErrMessage, [MainFolder, MainFolderVersion, c_AdminBaseVersion]);
end;

procedure TDbInfo.GetHomesFolderPath(aIniFile: TCfgList);
const
 c_BadStr = '';
begin
 aIniFile.Section := 'BaseDocPath';

 f_HomesFolderPath := aIniFile.ReadParamStrDef('HomeDirPath', c_BadStr);
 if f_HomesFolderPath = c_BadStr then
  raise EDBInfoError.Create('Не указан путь к папке Homes.');
 if not DirectoryExists(f_HomesFolderPath) then
  raise EDBInfoError.CreateFmt('Папка %s не найдена.', [f_HomesFolderPath]);
end;

end.
