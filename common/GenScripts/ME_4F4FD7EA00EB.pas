unit FileProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\FileProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FileProcessingPack" MUID: (4F4FD7EA00EB)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , tfwScriptingInterfaces
 , l3CProtoObject
 , l3Filer
;

type
 TtfwFile = class(Tl3CProtoObject, ItfwFile)
  private
   f_Filer: Tl3CustomDosFiler;
  protected
   function ReadLn: Il3CString;
   procedure WriteLn(const aString: Il3CString);
   procedure WriteChar(aChar: AnsiChar);
   function ReadWStrLn: Tl3WString;
   procedure WriteWStrLn(const aStr: Tl3WString);
   procedure WriteWStr(const aStr: Tl3WString);
   function EOF: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor CreateRead(const aFileName: AnsiString); reintroduce;
   constructor CreateWrite(const aFileName: AnsiString); reintroduce;
   class function MakeRead(const aFileName: AnsiString): ItfwFile; reintroduce;
   class function MakeWrite(const aFileName: AnsiString): ItfwFile; reintroduce;
   constructor CreateAppend(const aFileName: AnsiString); reintroduce;
   class function MakeAppend(const aFileName: AnsiString): ItfwFile; reintroduce;
   procedure ForEach(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
   procedure ForEachBack(aLambda: TtfwWordPrim;
    const aCtx: TtfwContext);
 end;//TtfwFile
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwAxiomaticsResNameGetter
 , tfwRegisterableWord
 , TypInfo
 , tfwClassLike
 , tfwWordWorkerEx
 , tfwTypeInfo
 , l3Types
 , tfwGlobalKeyWord
 , l3String
 , SysUtils
 , l3FileUtils
 , l3Base
 , l3Stream
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 //#UC START# *23408B0EC0B1ci*
 //#UC END# *23408B0EC0B1ci*
 //#UC START# *23408B0EC0B1cit*
 //#UC END# *23408B0EC0B1cit*
 TFileProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *23408B0EC0B1publ*
 //#UC END# *23408B0EC0B1publ*
 end;//TFileProcessingPackResNameGetter

 TkwFileOpenRead = {final} class(TtfwRegisterableWord)
  {* Слово скрипта File:OpenRead
*Тип результата:* ItfwFile
*Пример:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenRead >>> l_ItfwFile
[code]  }
  private
   function OpenRead(const aCtx: TtfwContext;
    const aName: AnsiString): ItfwFile;
    {* Реализация слова скрипта File:OpenRead }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileOpenRead

 TkwFileOpenWrite = {final} class(TtfwRegisterableWord)
  {* Слово скрипта File:OpenWrite
*Тип результата:* ItfwFile
*Пример:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenWrite >>> l_ItfwFile
[code]  }
  private
   function OpenWrite(const aCtx: TtfwContext;
    const aName: AnsiString): ItfwFile;
    {* Реализация слова скрипта File:OpenWrite }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileOpenWrite

 TkwFileEOF = {final} class(TtfwClassLike)
  {* Слово скрипта File:EOF
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFile File:EOF >>> l_Boolean
[code]  }
  private
   function EOF(const aCtx: TtfwContext;
    const aFile: ItfwFile): Boolean;
    {* Реализация слова скрипта File:EOF }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileEOF

 TkwFileReadLn = {final} class(TtfwClassLike)
  {* Слово скрипта File:ReadLn
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aFile File:ReadLn >>> l_Il3CString
[code]  }
  private
   function ReadLn(const aCtx: TtfwContext;
    const aFile: ItfwFile): Il3CString;
    {* Реализация слова скрипта File:ReadLn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileReadLn

 TkwFileWriteLn = {final} class(TtfwClassLike)
  {* Слово скрипта File:WriteLn
*Пример:*
[code]
 aValue aFile File:WriteLn
[code]  }
  private
   procedure WriteLn(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: Il3CString);
    {* Реализация слова скрипта File:WriteLn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteLn

 TkwFileWriteChar = {final} class(TtfwClassLike)
  {* Слово скрипта File:WriteChar
*Пример:*
[code]
 aValue aFile File:WriteChar
[code]  }
  private
   procedure WriteChar(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    aValue: AnsiChar);
    {* Реализация слова скрипта File:WriteChar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteChar

 TkwFileWriteStr = {final} class(TtfwClassLike)
  {* Слово скрипта File:WriteStr
*Пример:*
[code]
 aValue aFile File:WriteStr
[code]  }
  private
   procedure WriteStr(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: Il3CString);
    {* Реализация слова скрипта File:WriteStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteStr

 TkwFileReadLines = {final} class(TtfwWordWorkerEx)
  {* Слово скрипта File:ReadLines
*Пример:*
[code]
 aFile File:ReadLines aWord
[code]  }
  private
   procedure ReadLines(const aCtx: TtfwContext;
    aWord: TtfwWord;
    const aFile: ItfwFile);
    {* Реализация слова скрипта File:ReadLines }
  protected
   class function GetWordNameForRegister: AnsiString; override;
  public
   function RightParamsCount(const aCtx: TtfwContext): Integer; override;
   procedure DoRun(const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileReadLines

 TkwFileWriteWStr = {final} class(TtfwClassLike)
  {* Слово скрипта File:WriteWStr
*Пример:*
[code]
 aValue aFile File:WriteWStr
[code]  }
  private
   procedure WriteWStr(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта File:WriteWStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteWStr

 TkwFileReadWStrLn = {final} class(TtfwClassLike)
  {* Слово скрипта File:ReadWStrLn
*Тип результата:* Tl3PCharLen
*Пример:*
[code]
W-STRING VAR l_Tl3PCharLen
 aFile File:ReadWStrLn >>> l_Tl3PCharLen
[code]  }
  private
   function ReadWStrLn(const aCtx: TtfwContext;
    const aFile: ItfwFile): Tl3PCharLen;
    {* Реализация слова скрипта File:ReadWStrLn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileReadWStrLn

 TkwFileWriteWStrLn = {final} class(TtfwClassLike)
  {* Слово скрипта File:WriteWStrLn
*Пример:*
[code]
 aValue aFile File:WriteWStrLn
[code]  }
  private
   procedure WriteWStrLn(const aCtx: TtfwContext;
    const aFile: ItfwFile;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта File:WriteWStrLn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileWriteWStrLn

 TkwFileOpenAppend = {final} class(TtfwRegisterableWord)
  {* Слово скрипта File:OpenAppend
*Тип результата:* ItfwFile
*Пример:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenAppend >>> l_ItfwFile
[code]  }
  private
   function OpenAppend(const aCtx: TtfwContext;
    const aName: AnsiString): ItfwFile;
    {* Реализация слова скрипта File:OpenAppend }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileOpenAppend

 TkwDeleteFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteFile
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aName DeleteFile >>> l_Boolean
[code]  }
  private
   function DeleteFile(const aCtx: TtfwContext;
    const aName: AnsiString): Boolean;
    {* Реализация слова скрипта DeleteFile }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteFile

 TkwRenameFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта RenameFile
[panel]RenameFile - переименовывает файл.
*Формат:* aOldFileName aNewFileName RenameFile
* aNewFileName - новое имя файла.
* aOldFileName - старое имя файла.
В стек помещается результат операции: true - если успешно, false - если переименование не получилось.[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anOldName aNewName RenameFile >>> l_Boolean
[code]  }
  private
   function RenameFile(const aCtx: TtfwContext;
    const aNewName: AnsiString;
    const anOldName: AnsiString): Boolean;
    {* Реализация слова скрипта RenameFile }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRenameFile

 TkwCopyFilesByMask = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CopyFilesByMask
[panel]CopyFilesByMask- копирует файлы по маске..
*Формат:* 
[code]
 aFileMask aDestDir aSourceDir  CopyFilesByMask
[code]
* aSourceDir - директория откуда копируем.
* aDestDir - директория куда копируем.
* aFileMask - маска, по которой копируем файлы.
Результат слово не возвращает. Если появляется ошибка, то будет Exception[panel]
*Пример:*
[code]
 aFileMask aDestDir aSourceDir CopyFilesByMask
[code]  }
  private
   procedure CopyFilesByMask(const aCtx: TtfwContext;
    const aSourceDir: AnsiString;
    const aDestDir: AnsiString;
    const aFileMask: AnsiString);
    {* Реализация слова скрипта CopyFilesByMask }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCopyFilesByMask

 TkwCopyFile = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CopyFile
[panel]CopyFile - копирует файл.
*Формат:*  aCopyMode aDestFile aSourceFile CopyFile
* aSourceFile - имя исходного файла
* aDestFile - имя файла, куда копируем
* aCopyMode - режим копирования файла.
Результат слово не возвращает. Если появляется ошибка, то будет Exception[panel]
*Пример:*
[code]
 aCopyMode aDestFile aSourceFile CopyFile
[code]  }
  private
   procedure CopyFile(const aCtx: TtfwContext;
    const aSourceFile: AnsiString;
    const aDestFile: AnsiString;
    aCopyMode: Integer);
    {* Реализация слова скрипта CopyFile }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCopyFile

 TkwPureDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта PureDir
[panel]PureDir - очищает директорию.
*Формат:* aDirName PureDir
* aDirName  - имя директории.[panel]
*Пример:*
[code]
 aName PureDir
[code]  }
  private
   procedure PureDir(const aCtx: TtfwContext;
    const aName: AnsiString);
    {* Реализация слова скрипта PureDir }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPureDir

 TkwDeleteFilesByMask = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteFilesByMask
[panel]DeleteFilesByMask - очищает директорию.
*Формат:* aMask aDirName DeleteFilesByMask
* aDirName  - имя директории.
* aMask - маска, по которой отбираются файлы.[panel]
*Пример:*
[code]
 aMask aDirName DeleteFilesByMask
[code]  }
  private
   procedure DeleteFilesByMask(const aCtx: TtfwContext;
    const aDirName: AnsiString;
    const aMask: AnsiString);
    {* Реализация слова скрипта DeleteFilesByMask }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDeleteFilesByMask

 TkwProcessFilesWithMask = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ProcessFilesWithMask
[panel]ProcessFilesWithMask - перебирает файлы по маске в заданной директории и вызывает для каждого найденного функцию.
*Формат:*
aProc aFileMask aDirName ProcessFilesWithMask
* aProc - функция, которая вызывается для каждого файла. В стек при вызове помещается имя файла.
* aFileMask - маска, по которой отбираются файлы, например '*.script'
* aDirName - путь, по которому ищутся файлы.
*Пример:*
[code]
: PrintFileName
 .
;

@ PrintFileName '*.script' 'w:\archi\source\projects\Archi\TestSet\Scripts\' ProcessFilesWithMask
[code]
В результате будет создан файл с имя_скрипта.prn с именами файлов с полными путями.
*Примечание:* Если ни один файл не найден, то функция не будет вызвана ни разу. Ни дирректории, ни ссылки на файлы, ни имена дисков в поиск не попадают. Поиск во вложенных директориях не прозводится. Имя файла передается с полным путем.[panel]
*Пример:*
[code]
 aProc aFileMask aDirName ProcessFilesWithMask
[code]  }
  private
   procedure ProcessFilesWithMask(const aCtx: TtfwContext;
    const aDirName: AnsiString;
    const aFileMask: AnsiString;
    aProc: TtfwWord);
    {* Реализация слова скрипта ProcessFilesWithMask }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwProcessFilesWithMask

 TkwProcessSubDirs = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ProcessSubDirs
[panel]ProcessSubDirs - перебирает директории в заданной директории и вызывает для каждого найденного функцию.
*Формат:*
aProc aDirName ProcessSubDirs
* aProc - функция, которая вызывается для каждой директории. В стек при вызове помещается имя директории.
* aDirName - путь, по которому ищутся директории.
*Пример:*
[code]
: PrintFileName
 .
;

@ PrintFileName 'w:\archi\source\projects\Archi\TestSet\' ProcessSubDirs
[code]
В результате будет создан файл с имя_скрипта.prn с именами директорий с полными путями.
*Примечание:* Если ни одна директория  не найдена, то функция не будет вызвана ни разу.[panel]
*Пример:*
[code]
 aProc aDirName ProcessSubDirs
[code]  }
  private
   procedure ProcessSubDirs(const aCtx: TtfwContext;
    const aDirName: AnsiString;
    aProc: TtfwWord);
    {* Реализация слова скрипта ProcessSubDirs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwProcessSubDirs

 TkwFileSize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта FileSize
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aFileName FileSize >>> l_Integer
[code]  }
  private
   function FileSize(const aCtx: TtfwContext;
    const aFileName: AnsiString): Integer;
    {* Реализация слова скрипта FileSize }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFileSize

 TkwCompareFiles = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CompareFiles
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aHeaderBegin aFile2 aFile1 CompareFiles >>> l_Boolean
[code]  }
  private
   function CompareFiles(const aCtx: TtfwContext;
    const aFile1: AnsiString;
    const aFile2: AnsiString;
    const aHeaderBegin: AnsiString): Boolean;
    {* Реализация слова скрипта CompareFiles }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCompareFiles

constructor TtfwFile.CreateRead(const aFileName: AnsiString);
//#UC START# *4F4FD849026C_4F4FD77B03CC_var*
//#UC END# *4F4FD849026C_4F4FD77B03CC_var*
begin
//#UC START# *4F4FD849026C_4F4FD77B03CC_impl*
 inherited Create;
 f_Filer := Tl3CustomDosFiler.Make(aFileName, l3_fmRead, false, 1000);
 f_Filer.Open;
//#UC END# *4F4FD849026C_4F4FD77B03CC_impl*
end;//TtfwFile.CreateRead

constructor TtfwFile.CreateWrite(const aFileName: AnsiString);
//#UC START# *4F4FD85F033A_4F4FD77B03CC_var*
//#UC END# *4F4FD85F033A_4F4FD77B03CC_var*
begin
//#UC START# *4F4FD85F033A_4F4FD77B03CC_impl*
 inherited Create;
 f_Filer := Tl3CustomDosFiler.Make(aFileName, l3_fmWrite, false, 1000);
 f_Filer.Open;
//#UC END# *4F4FD85F033A_4F4FD77B03CC_impl*
end;//TtfwFile.CreateWrite

class function TtfwFile.MakeRead(const aFileName: AnsiString): ItfwFile;
var
 l_Inst : TtfwFile;
begin
 l_Inst := CreateRead(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwFile.MakeRead

class function TtfwFile.MakeWrite(const aFileName: AnsiString): ItfwFile;
var
 l_Inst : TtfwFile;
begin
 l_Inst := CreateWrite(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwFile.MakeWrite

constructor TtfwFile.CreateAppend(const aFileName: AnsiString);
//#UC START# *570E70230377_4F4FD77B03CC_var*
//#UC END# *570E70230377_4F4FD77B03CC_var*
begin
//#UC START# *570E70230377_4F4FD77B03CC_impl*
 inherited Create;
 f_Filer := Tl3CustomDosFiler.Make(aFileName, l3_fmAppend, false, 1000);
 f_Filer.Open;
//#UC END# *570E70230377_4F4FD77B03CC_impl*
end;//TtfwFile.CreateAppend

class function TtfwFile.MakeAppend(const aFileName: AnsiString): ItfwFile;
var
 l_Inst : TtfwFile;
begin
 l_Inst := CreateAppend(aFileName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TtfwFile.MakeAppend

function TtfwFile.ReadLn: Il3CString;
//#UC START# *4F4E4E7E0350_4F4FD77B03CC_var*
//#UC END# *4F4E4E7E0350_4F4FD77B03CC_var*
begin
//#UC START# *4F4E4E7E0350_4F4FD77B03CC_impl*
 Result := TtfwCStringFactory.C(f_Filer.ReadLn);
//#UC END# *4F4E4E7E0350_4F4FD77B03CC_impl*
end;//TtfwFile.ReadLn

procedure TtfwFile.WriteLn(const aString: Il3CString);
//#UC START# *4F4E4EA7007D_4F4FD77B03CC_var*
//#UC END# *4F4E4EA7007D_4F4FD77B03CC_var*
begin
//#UC START# *4F4E4EA7007D_4F4FD77B03CC_impl*
 f_Filer.WriteLn(l3PCharLen(aString));
//#UC END# *4F4E4EA7007D_4F4FD77B03CC_impl*
end;//TtfwFile.WriteLn

procedure TtfwFile.WriteChar(aChar: AnsiChar);
//#UC START# *4F4FDC540264_4F4FD77B03CC_var*
//#UC END# *4F4FDC540264_4F4FD77B03CC_var*
begin
//#UC START# *4F4FDC540264_4F4FD77B03CC_impl*
 f_Filer.Write(aChar);
//#UC END# *4F4FDC540264_4F4FD77B03CC_impl*
end;//TtfwFile.WriteChar

function TtfwFile.ReadWStrLn: Tl3WString;
//#UC START# *4F4FE16A0269_4F4FD77B03CC_var*
//#UC END# *4F4FE16A0269_4F4FD77B03CC_var*
begin
//#UC START# *4F4FE16A0269_4F4FD77B03CC_impl*
 Result := f_Filer.ReadLn;
//#UC END# *4F4FE16A0269_4F4FD77B03CC_impl*
end;//TtfwFile.ReadWStrLn

procedure TtfwFile.WriteWStrLn(const aStr: Tl3WString);
//#UC START# *4F4FE19301A1_4F4FD77B03CC_var*
//#UC END# *4F4FE19301A1_4F4FD77B03CC_var*
begin
//#UC START# *4F4FE19301A1_4F4FD77B03CC_impl*
 f_Filer.WriteLn(aStr);
//#UC END# *4F4FE19301A1_4F4FD77B03CC_impl*
end;//TtfwFile.WriteWStrLn

procedure TtfwFile.WriteWStr(const aStr: Tl3WString);
//#UC START# *4F4FE1B40314_4F4FD77B03CC_var*
//#UC END# *4F4FE1B40314_4F4FD77B03CC_var*
begin
//#UC START# *4F4FE1B40314_4F4FD77B03CC_impl*
 f_Filer.Write(aStr);
//#UC END# *4F4FE1B40314_4F4FD77B03CC_impl*
end;//TtfwFile.WriteWStr

function TtfwFile.EOF: Boolean;
//#UC START# *4F50821201E7_4F4FD77B03CC_var*
//#UC END# *4F50821201E7_4F4FD77B03CC_var*
begin
//#UC START# *4F50821201E7_4F4FD77B03CC_impl*
 Result := f_Filer.EOF;
//#UC END# *4F50821201E7_4F4FD77B03CC_impl*
end;//TtfwFile.EOF

procedure TtfwFile.ForEach(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23B7A00EC_4F4FD77B03CC_var*
var
 l_S : Tl3WString;
//#UC END# *52E23B7A00EC_4F4FD77B03CC_var*
begin
//#UC START# *52E23B7A00EC_4F4FD77B03CC_impl*
 while not f_Filer.EOF do
 begin
  l_S := f_Filer.ReadLn;
  if not l3IsNil(l_S) OR not f_Filer.EOF then
  begin
  // - это чтобы не размножались пустые строки в конце файлов
   aCtx.rEngine.PushWStr(l_S);
   try
    aLambda.DoIt(aCtx);
   except
    on EtfwBreakIterator do
     break;
    on EtfwBreak do
     break;
    on EtfwContinue do
     continue;
   end;//try..except
  end;//not l3IsNil(l_S) OR not f_Filer.EOF  
 end;//not f_Filer.EOF
//#UC END# *52E23B7A00EC_4F4FD77B03CC_impl*
end;//TtfwFile.ForEach

procedure TtfwFile.ForEachBack(aLambda: TtfwWordPrim;
 const aCtx: TtfwContext);
//#UC START# *52E23BB102FA_4F4FD77B03CC_var*
//#UC END# *52E23BB102FA_4F4FD77B03CC_var*
begin
//#UC START# *52E23BB102FA_4F4FD77B03CC_impl*
 TtfwWord(aLambda).RunnerError('Перебор строк от конца файла, не реализован', aCtx);
//#UC END# *52E23BB102FA_4F4FD77B03CC_impl*
end;//TtfwFile.ForEachBack

procedure TtfwFile.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4F4FD77B03CC_var*
//#UC END# *479731C50290_4F4FD77B03CC_var*
begin
//#UC START# *479731C50290_4F4FD77B03CC_impl*
 f_Filer.Close;
 FreeAndNil(f_Filer);
 inherited;
//#UC END# *479731C50290_4F4FD77B03CC_impl*
end;//TtfwFile.Cleanup

class function TFileProcessingPackResNameGetter.ResName: AnsiString;
begin
  Result := 'FileProcessingPack';
end;//TFileProcessingPackResNameGetter.ResName

 {$R FileProcessingPack.res}

function TkwFileOpenRead.OpenRead(const aCtx: TtfwContext;
 const aName: AnsiString): ItfwFile;
 {* Реализация слова скрипта File:OpenRead }
//#UC START# *1138E576E816_E10DA0D7493D_var*
//#UC END# *1138E576E816_E10DA0D7493D_var*
begin
//#UC START# *1138E576E816_E10DA0D7493D_impl*
 Result := TtfwFile.MakeRead(aCtx.rCaller.ResolveInputFilePath(aName));
//#UC END# *1138E576E816_E10DA0D7493D_impl*
end;//TkwFileOpenRead.OpenRead

procedure TkwFileOpenRead.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushFile(OpenRead(aCtx, l_aName));
end;//TkwFileOpenRead.DoDoIt

function TkwFileOpenRead.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwFile);
end;//TkwFileOpenRead.GetResultTypeInfo

function TkwFileOpenRead.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileOpenRead.GetAllParamsCount

function TkwFileOpenRead.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileOpenRead.ParamsTypes

class function TkwFileOpenRead.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:OpenRead';
end;//TkwFileOpenRead.GetWordNameForRegister

function TkwFileOpenWrite.OpenWrite(const aCtx: TtfwContext;
 const aName: AnsiString): ItfwFile;
 {* Реализация слова скрипта File:OpenWrite }
//#UC START# *C3A7BCE24C3B_1CA3472F7177_var*
//#UC END# *C3A7BCE24C3B_1CA3472F7177_var*
begin
//#UC START# *C3A7BCE24C3B_1CA3472F7177_impl*
 Result := TtfwFile.MakeWrite(aCtx.rCaller.ResolveOutputFilePath(aName));
//#UC END# *C3A7BCE24C3B_1CA3472F7177_impl*
end;//TkwFileOpenWrite.OpenWrite

procedure TkwFileOpenWrite.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushFile(OpenWrite(aCtx, l_aName));
end;//TkwFileOpenWrite.DoDoIt

function TkwFileOpenWrite.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwFile);
end;//TkwFileOpenWrite.GetResultTypeInfo

function TkwFileOpenWrite.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileOpenWrite.GetAllParamsCount

function TkwFileOpenWrite.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileOpenWrite.ParamsTypes

class function TkwFileOpenWrite.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:OpenWrite';
end;//TkwFileOpenWrite.GetWordNameForRegister

function TkwFileEOF.EOF(const aCtx: TtfwContext;
 const aFile: ItfwFile): Boolean;
 {* Реализация слова скрипта File:EOF }
//#UC START# *509E2E3CFD11_2B33C78BBAB9_var*
//#UC END# *509E2E3CFD11_2B33C78BBAB9_var*
begin
//#UC START# *509E2E3CFD11_2B33C78BBAB9_impl*
 Result := aFile.EOF;
//#UC END# *509E2E3CFD11_2B33C78BBAB9_impl*
end;//TkwFileEOF.EOF

procedure TkwFileEOF.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(EOF(aCtx, l_aFile));
end;//TkwFileEOF.DoDoIt

function TkwFileEOF.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFileEOF.GetResultTypeInfo

function TkwFileEOF.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileEOF.GetAllParamsCount

function TkwFileEOF.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileEOF.ParamsTypes

class function TkwFileEOF.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:EOF';
end;//TkwFileEOF.GetWordNameForRegister

function TkwFileReadLn.ReadLn(const aCtx: TtfwContext;
 const aFile: ItfwFile): Il3CString;
 {* Реализация слова скрипта File:ReadLn }
//#UC START# *47F929C35E76_324E0BCF3B98_var*
//#UC END# *47F929C35E76_324E0BCF3B98_var*
begin
//#UC START# *47F929C35E76_324E0BCF3B98_impl*
 Result := aFile.ReadLn;
//#UC END# *47F929C35E76_324E0BCF3B98_impl*
end;//TkwFileReadLn.ReadLn

procedure TkwFileReadLn.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(ReadLn(aCtx, l_aFile));
end;//TkwFileReadLn.DoDoIt

function TkwFileReadLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwFileReadLn.GetResultTypeInfo

function TkwFileReadLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileReadLn.GetAllParamsCount

function TkwFileReadLn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileReadLn.ParamsTypes

class function TkwFileReadLn.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:ReadLn';
end;//TkwFileReadLn.GetWordNameForRegister

procedure TkwFileWriteLn.WriteLn(const aCtx: TtfwContext;
 const aFile: ItfwFile;
 const aValue: Il3CString);
 {* Реализация слова скрипта File:WriteLn }
//#UC START# *7E6964328B7F_D6A86D931B42_var*
//#UC END# *7E6964328B7F_D6A86D931B42_var*
begin
//#UC START# *7E6964328B7F_D6A86D931B42_impl*
 aFile.WriteLn(aValue);
//#UC END# *7E6964328B7F_D6A86D931B42_impl*
end;//TkwFileWriteLn.WriteLn

procedure TkwFileWriteLn.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
var l_aValue: Il3CString;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteLn(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteLn.DoDoIt

function TkwFileWriteLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteLn.GetResultTypeInfo

function TkwFileWriteLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwFileWriteLn.GetAllParamsCount

function TkwFileWriteLn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileWriteLn.ParamsTypes

class function TkwFileWriteLn.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:WriteLn';
end;//TkwFileWriteLn.GetWordNameForRegister

procedure TkwFileWriteChar.WriteChar(const aCtx: TtfwContext;
 const aFile: ItfwFile;
 aValue: AnsiChar);
 {* Реализация слова скрипта File:WriteChar }
//#UC START# *8B2200CCBE22_B530B64F8857_var*
//#UC END# *8B2200CCBE22_B530B64F8857_var*
begin
//#UC START# *8B2200CCBE22_B530B64F8857_impl*
 aFile.WriteChar(aValue);
//#UC END# *8B2200CCBE22_B530B64F8857_impl*
end;//TkwFileWriteChar.WriteChar

procedure TkwFileWriteChar.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
var l_aValue: AnsiChar;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopChar;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: AnsiChar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteChar(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteChar.DoDoIt

function TkwFileWriteChar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteChar.GetResultTypeInfo

function TkwFileWriteChar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwFileWriteChar.GetAllParamsCount

function TkwFileWriteChar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), TypeInfo(AnsiChar)]);
end;//TkwFileWriteChar.ParamsTypes

class function TkwFileWriteChar.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:WriteChar';
end;//TkwFileWriteChar.GetWordNameForRegister

procedure TkwFileWriteStr.WriteStr(const aCtx: TtfwContext;
 const aFile: ItfwFile;
 const aValue: Il3CString);
 {* Реализация слова скрипта File:WriteStr }
//#UC START# *BF1D3E215CF5_0016E31D4F5B_var*
//#UC END# *BF1D3E215CF5_0016E31D4F5B_var*
begin
//#UC START# *BF1D3E215CF5_0016E31D4F5B_impl*
 aFile.WriteWStr(l3PCharLen(aValue));
//#UC END# *BF1D3E215CF5_0016E31D4F5B_impl*
end;//TkwFileWriteStr.WriteStr

procedure TkwFileWriteStr.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
var l_aValue: Il3CString;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteStr(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteStr.DoDoIt

function TkwFileWriteStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteStr.GetResultTypeInfo

function TkwFileWriteStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwFileWriteStr.GetAllParamsCount

function TkwFileWriteStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileWriteStr.ParamsTypes

class function TkwFileWriteStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:WriteStr';
end;//TkwFileWriteStr.GetWordNameForRegister

procedure TkwFileReadLines.ReadLines(const aCtx: TtfwContext;
 aWord: TtfwWord;
 const aFile: ItfwFile);
 {* Реализация слова скрипта File:ReadLines }
//#UC START# *B66526463736_4D96B2094588_var*
//#UC END# *B66526463736_4D96B2094588_var*
begin
//#UC START# *B66526463736_4D96B2094588_impl*
 aFile.ForEach(aWord, aCtx);
//#UC END# *B66526463736_4D96B2094588_impl*
end;//TkwFileReadLines.ReadLines

function TkwFileReadLines.RightParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileReadLines.RightParamsCount

procedure TkwFileReadLines.DoRun(const aCtx: TtfwContext);
var l_aWord: TtfwWord;
var l_aFile: ItfwFile;
begin
 try
  l_aWord := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aWord: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ReadLines(aCtx, l_aWord, l_aFile);
end;//TkwFileReadLines.DoRun

function TkwFileReadLines.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFileReadLines.GetResultTypeInfo

function TkwFileReadLines.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwFileReadLines.GetAllParamsCount

function TkwFileReadLines.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileReadLines.ParamsTypes

class function TkwFileReadLines.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:ReadLines';
end;//TkwFileReadLines.GetWordNameForRegister

procedure TkwFileWriteWStr.WriteWStr(const aCtx: TtfwContext;
 const aFile: ItfwFile;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта File:WriteWStr }
//#UC START# *EA5DBDC19650_12D9E8420555_var*
//#UC END# *EA5DBDC19650_12D9E8420555_var*
begin
//#UC START# *EA5DBDC19650_12D9E8420555_impl*
 Case aValue.rType of
  tfw_vtStr:
   aFile.WriteWStr(aValue.AsString.AsWStr);
(*  tfw_vtWStr:
   aFile.WriteWStr(aValue.AsWString);*)
  else
   BadValueType(aValue.rType, aCtx);
 end;//Case aValue.rType
//#UC END# *EA5DBDC19650_12D9E8420555_impl*
end;//TkwFileWriteWStr.WriteWStr

procedure TkwFileWriteWStr.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
var l_aValue: TtfwStackValue;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteWStr(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteWStr.DoDoIt

function TkwFileWriteWStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteWStr.GetResultTypeInfo

function TkwFileWriteWStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwFileWriteWStr.GetAllParamsCount

function TkwFileWriteWStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiStruct]);
end;//TkwFileWriteWStr.ParamsTypes

class function TkwFileWriteWStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:WriteWStr';
end;//TkwFileWriteWStr.GetWordNameForRegister

function TkwFileReadWStrLn.ReadWStrLn(const aCtx: TtfwContext;
 const aFile: ItfwFile): Tl3PCharLen;
 {* Реализация слова скрипта File:ReadWStrLn }
//#UC START# *062B42A458F5_6F89E50D4B41_var*
//#UC END# *062B42A458F5_6F89E50D4B41_var*
begin
//#UC START# *062B42A458F5_6F89E50D4B41_impl*
 Result := Tl3PCharLen(aFile.ReadWStrLn);
//#UC END# *062B42A458F5_6F89E50D4B41_impl*
end;//TkwFileReadWStrLn.ReadWStrLn

procedure TkwFileReadWStrLn.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushWStr(ReadWStrLn(aCtx, l_aFile));
end;//TkwFileReadWStrLn.DoDoIt

function TkwFileReadWStrLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiWString;
end;//TkwFileReadWStrLn.GetResultTypeInfo

function TkwFileReadWStrLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileReadWStrLn.GetAllParamsCount

function TkwFileReadWStrLn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile)]);
end;//TkwFileReadWStrLn.ParamsTypes

class function TkwFileReadWStrLn.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:ReadWStrLn';
end;//TkwFileReadWStrLn.GetWordNameForRegister

procedure TkwFileWriteWStrLn.WriteWStrLn(const aCtx: TtfwContext;
 const aFile: ItfwFile;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта File:WriteWStrLn }
//#UC START# *5BB0C2B29FB4_2C287EC9B0C3_var*
//#UC END# *5BB0C2B29FB4_2C287EC9B0C3_var*
begin
//#UC START# *5BB0C2B29FB4_2C287EC9B0C3_impl*
 Case aValue.rType of
  tfw_vtStr:
   aFile.WriteWStrLn(aValue.AsString.AsWStr);
(*  tfw_vtWStr:
   aFile.WriteWStrLn(aValue.AsWString);*)
  else
   BadValueType(aValue.rType, aCtx);
 end;//Case aValue.rType
//#UC END# *5BB0C2B29FB4_2C287EC9B0C3_impl*
end;//TkwFileWriteWStrLn.WriteWStrLn

procedure TkwFileWriteWStrLn.DoDoIt(const aCtx: TtfwContext);
var l_aFile: ItfwFile;
var l_aValue: TtfwStackValue;
begin
 try
  l_aFile := aCtx.rEngine.PopFile;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile: ItfwFile : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WriteWStrLn(aCtx, l_aFile, l_aValue);
end;//TkwFileWriteWStrLn.DoDoIt

function TkwFileWriteWStrLn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwFileWriteWStrLn.GetResultTypeInfo

function TkwFileWriteWStrLn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwFileWriteWStrLn.GetAllParamsCount

function TkwFileWriteWStrLn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiStruct]);
end;//TkwFileWriteWStrLn.ParamsTypes

class function TkwFileWriteWStrLn.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:WriteWStrLn';
end;//TkwFileWriteWStrLn.GetWordNameForRegister

function TkwFileOpenAppend.OpenAppend(const aCtx: TtfwContext;
 const aName: AnsiString): ItfwFile;
 {* Реализация слова скрипта File:OpenAppend }
//#UC START# *B8708CE49928_7185464C1BEA_var*
//#UC END# *B8708CE49928_7185464C1BEA_var*
begin
//#UC START# *B8708CE49928_7185464C1BEA_impl*
 Result := TtfwFile.MakeAppend(aCtx.rCaller.ResolveOutputFilePath(aName));
//#UC END# *B8708CE49928_7185464C1BEA_impl*
end;//TkwFileOpenAppend.OpenAppend

procedure TkwFileOpenAppend.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushFile(OpenAppend(aCtx, l_aName));
end;//TkwFileOpenAppend.DoDoIt

function TkwFileOpenAppend.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwFile);
end;//TkwFileOpenAppend.GetResultTypeInfo

function TkwFileOpenAppend.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileOpenAppend.GetAllParamsCount

function TkwFileOpenAppend.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwFile), @tfw_tiString]);
end;//TkwFileOpenAppend.ParamsTypes

class function TkwFileOpenAppend.GetWordNameForRegister: AnsiString;
begin
 Result := 'File:OpenAppend';
end;//TkwFileOpenAppend.GetWordNameForRegister

function TkwDeleteFile.DeleteFile(const aCtx: TtfwContext;
 const aName: AnsiString): Boolean;
 {* Реализация слова скрипта DeleteFile }
//#UC START# *8A54E0B1468F_01A4D246A0C9_var*
//#UC END# *8A54E0B1468F_01A4D246A0C9_var*
begin
//#UC START# *8A54E0B1468F_01A4D246A0C9_impl*
 Result := SysUtils.DeleteFile(aName);
//#UC END# *8A54E0B1468F_01A4D246A0C9_impl*
end;//TkwDeleteFile.DeleteFile

procedure TkwDeleteFile.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(DeleteFile(aCtx, l_aName));
end;//TkwDeleteFile.DoDoIt

function TkwDeleteFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwDeleteFile.GetResultTypeInfo

function TkwDeleteFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDeleteFile.GetAllParamsCount

function TkwDeleteFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwDeleteFile.ParamsTypes

class function TkwDeleteFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'DeleteFile';
end;//TkwDeleteFile.GetWordNameForRegister

function TkwRenameFile.RenameFile(const aCtx: TtfwContext;
 const aNewName: AnsiString;
 const anOldName: AnsiString): Boolean;
 {* Реализация слова скрипта RenameFile }
//#UC START# *4B30612C1E84_269C162F0F47_var*
//#UC END# *4B30612C1E84_269C162F0F47_var*
begin
//#UC START# *4B30612C1E84_269C162F0F47_impl*
 Result := SysUtils.RenameFile(anOldName, aNewName);
//#UC END# *4B30612C1E84_269C162F0F47_impl*
end;//TkwRenameFile.RenameFile

procedure TkwRenameFile.DoDoIt(const aCtx: TtfwContext);
var l_aNewName: AnsiString;
var l_anOldName: AnsiString;
begin
 try
  l_aNewName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOldName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOldName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(RenameFile(aCtx, l_aNewName, l_anOldName));
end;//TkwRenameFile.DoDoIt

function TkwRenameFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwRenameFile.GetResultTypeInfo

function TkwRenameFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwRenameFile.GetAllParamsCount

function TkwRenameFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwRenameFile.ParamsTypes

class function TkwRenameFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'RenameFile';
end;//TkwRenameFile.GetWordNameForRegister

procedure TkwCopyFilesByMask.CopyFilesByMask(const aCtx: TtfwContext;
 const aSourceDir: AnsiString;
 const aDestDir: AnsiString;
 const aFileMask: AnsiString);
 {* Реализация слова скрипта CopyFilesByMask }
//#UC START# *B545E742BFBB_5478B1531C0E_var*
//#UC END# *B545E742BFBB_5478B1531C0E_var*
begin
//#UC START# *B545E742BFBB_5478B1531C0E_impl*
 l3FileUtils.CopyFilesByMask(aSourceDir, aDestDir, aFileMask);
//#UC END# *B545E742BFBB_5478B1531C0E_impl*
end;//TkwCopyFilesByMask.CopyFilesByMask

procedure TkwCopyFilesByMask.DoDoIt(const aCtx: TtfwContext);
var l_aSourceDir: AnsiString;
var l_aDestDir: AnsiString;
var l_aFileMask: AnsiString;
begin
 try
  l_aSourceDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSourceDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDestDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDestDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileMask := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileMask: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CopyFilesByMask(aCtx, l_aSourceDir, l_aDestDir, l_aFileMask);
end;//TkwCopyFilesByMask.DoDoIt

function TkwCopyFilesByMask.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCopyFilesByMask.GetResultTypeInfo

function TkwCopyFilesByMask.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwCopyFilesByMask.GetAllParamsCount

function TkwCopyFilesByMask.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwCopyFilesByMask.ParamsTypes

class function TkwCopyFilesByMask.GetWordNameForRegister: AnsiString;
begin
 Result := 'CopyFilesByMask';
end;//TkwCopyFilesByMask.GetWordNameForRegister

procedure TkwCopyFile.CopyFile(const aCtx: TtfwContext;
 const aSourceFile: AnsiString;
 const aDestFile: AnsiString;
 aCopyMode: Integer);
 {* Реализация слова скрипта CopyFile }
//#UC START# *7B442954EEE8_C4E46637B80B_var*
//#UC END# *7B442954EEE8_C4E46637B80B_var*
begin
//#UC START# *7B442954EEE8_C4E46637B80B_impl*
 l3FileUtils.CopyFile(aSourceFile, aDestFile, aCopyMode);
//#UC END# *7B442954EEE8_C4E46637B80B_impl*
end;//TkwCopyFile.CopyFile

procedure TkwCopyFile.DoDoIt(const aCtx: TtfwContext);
var l_aSourceFile: AnsiString;
var l_aDestFile: AnsiString;
var l_aCopyMode: Integer;
begin
 try
  l_aSourceFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSourceFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDestFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDestFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCopyMode := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCopyMode: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 CopyFile(aCtx, l_aSourceFile, l_aDestFile, l_aCopyMode);
end;//TkwCopyFile.DoDoIt

function TkwCopyFile.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwCopyFile.GetResultTypeInfo

function TkwCopyFile.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwCopyFile.GetAllParamsCount

function TkwCopyFile.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, TypeInfo(Integer)]);
end;//TkwCopyFile.ParamsTypes

class function TkwCopyFile.GetWordNameForRegister: AnsiString;
begin
 Result := 'CopyFile';
end;//TkwCopyFile.GetWordNameForRegister

procedure TkwPureDir.PureDir(const aCtx: TtfwContext;
 const aName: AnsiString);
 {* Реализация слова скрипта PureDir }
//#UC START# *4475F8181332_C77B92459A8E_var*
//#UC END# *4475F8181332_C77B92459A8E_var*
begin
//#UC START# *4475F8181332_C77B92459A8E_impl*
 l3FileUtils.PureDir(aName);
//#UC END# *4475F8181332_C77B92459A8E_impl*
end;//TkwPureDir.PureDir

procedure TkwPureDir.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 PureDir(aCtx, l_aName);
end;//TkwPureDir.DoDoIt

function TkwPureDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPureDir.GetResultTypeInfo

function TkwPureDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPureDir.GetAllParamsCount

function TkwPureDir.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwPureDir.ParamsTypes

class function TkwPureDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'PureDir';
end;//TkwPureDir.GetWordNameForRegister

procedure TkwDeleteFilesByMask.DeleteFilesByMask(const aCtx: TtfwContext;
 const aDirName: AnsiString;
 const aMask: AnsiString);
 {* Реализация слова скрипта DeleteFilesByMask }
//#UC START# *4757446F5D1B_E5B04DD6635F_var*
//#UC END# *4757446F5D1B_E5B04DD6635F_var*
begin
//#UC START# *4757446F5D1B_E5B04DD6635F_impl*
 l3FileUtils.DeleteFilesByMask(aDirName, aMask);
//#UC END# *4757446F5D1B_E5B04DD6635F_impl*
end;//TkwDeleteFilesByMask.DeleteFilesByMask

procedure TkwDeleteFilesByMask.DoDoIt(const aCtx: TtfwContext);
var l_aDirName: AnsiString;
var l_aMask: AnsiString;
begin
 try
  l_aDirName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDirName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMask := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMask: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 DeleteFilesByMask(aCtx, l_aDirName, l_aMask);
end;//TkwDeleteFilesByMask.DoDoIt

function TkwDeleteFilesByMask.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwDeleteFilesByMask.GetResultTypeInfo

function TkwDeleteFilesByMask.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwDeleteFilesByMask.GetAllParamsCount

function TkwDeleteFilesByMask.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwDeleteFilesByMask.ParamsTypes

class function TkwDeleteFilesByMask.GetWordNameForRegister: AnsiString;
begin
 Result := 'DeleteFilesByMask';
end;//TkwDeleteFilesByMask.GetWordNameForRegister

procedure TkwProcessFilesWithMask.ProcessFilesWithMask(const aCtx: TtfwContext;
 const aDirName: AnsiString;
 const aFileMask: AnsiString;
 aProc: TtfwWord);
 {* Реализация слова скрипта ProcessFilesWithMask }
//#UC START# *332776E818ED_F43FC392309A_var*
var
 l_SearchRec  : TSearchRec;
 l_FindResult : Integer;
//#UC END# *332776E818ED_F43FC392309A_var*
begin
//#UC START# *332776E818ED_F43FC392309A_impl*
 if not DirectoryExists(aDirName) then
 begin
  Assert(False, Format('Директория %s не существует', [aDirName]));
  Exit;
 end; // if not DirectoryExists(aDirName) then
 l_FindResult := FindFirst(ConcatDirName(aDirName, aFileMask),
                           faAnyFile,
                           l_SearchRec);
 try
  while (l_FindResult = 0) do
  begin
   if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   begin
    aCtx.rEngine.PushString(ConcatDirName(aDirName, l_SearchRec.Name));
    aProc.DoIt(aCtx);
   end; // if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   l_FindResult := FindNext(l_SearchRec);
  end; // while l_FindResult = 0 do
 finally
  SysUtils.FindClose(l_SearchRec);
 end;//try..finally
//#UC END# *332776E818ED_F43FC392309A_impl*
end;//TkwProcessFilesWithMask.ProcessFilesWithMask

procedure TkwProcessFilesWithMask.DoDoIt(const aCtx: TtfwContext);
var l_aDirName: AnsiString;
var l_aFileMask: AnsiString;
var l_aProc: TtfwWord;
begin
 try
  l_aDirName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDirName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFileMask := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileMask: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aProc := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aProc: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ProcessFilesWithMask(aCtx, l_aDirName, l_aFileMask, l_aProc);
end;//TkwProcessFilesWithMask.DoDoIt

function TkwProcessFilesWithMask.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwProcessFilesWithMask.GetResultTypeInfo

function TkwProcessFilesWithMask.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwProcessFilesWithMask.GetAllParamsCount

function TkwProcessFilesWithMask.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, TypeInfo(TtfwWord)]);
end;//TkwProcessFilesWithMask.ParamsTypes

class function TkwProcessFilesWithMask.GetWordNameForRegister: AnsiString;
begin
 Result := 'ProcessFilesWithMask';
end;//TkwProcessFilesWithMask.GetWordNameForRegister

procedure TkwProcessSubDirs.ProcessSubDirs(const aCtx: TtfwContext;
 const aDirName: AnsiString;
 aProc: TtfwWord);
 {* Реализация слова скрипта ProcessSubDirs }
//#UC START# *3A2CA042D20F_4D6340E72B1A_var*
var
 l_SearchRec : TSearchRec;
 l_FindResult: Integer;
//#UC END# *3A2CA042D20F_4D6340E72B1A_var*
begin
//#UC START# *3A2CA042D20F_4D6340E72B1A_impl*
 if not DirectoryExists(aDirName) then
 begin
  Assert(False, Format('Директория %s не существует', [aDirName]));
  Exit;
 end; // if not DirectoryExists(l_DirName) then
 l_FindResult := FindFirst(ConcatDirName(aDirName, '*.*'),
                           faDirectory ,
                           l_SearchRec);
 try
  while (l_FindResult = 0) do
  begin
   if ((l_SearchRec.Attr and faDirectory) <> 0) and (l_SearchRec.Name <> '.') and (l_SearchRec.Name <> '..') then
   begin
    aCtx.rEngine.PushString(ConcatDirName(aDirName, l_SearchRec.Name));
    aProc.DoIt(aCtx);
   end; // if (l_SearchRec.Attr and (faDirectory or faVolumeID or faSymLink)) = 0 then
   l_FindResult := FindNext(l_SearchRec);
  end; // while l_FindResult = 0 do
 finally
  SysUtils.FindClose(l_SearchRec);
 end;//try..finally
//#UC END# *3A2CA042D20F_4D6340E72B1A_impl*
end;//TkwProcessSubDirs.ProcessSubDirs

procedure TkwProcessSubDirs.DoDoIt(const aCtx: TtfwContext);
var l_aDirName: AnsiString;
var l_aProc: TtfwWord;
begin
 try
  l_aDirName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDirName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aProc := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aProc: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ProcessSubDirs(aCtx, l_aDirName, l_aProc);
end;//TkwProcessSubDirs.DoDoIt

function TkwProcessSubDirs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwProcessSubDirs.GetResultTypeInfo

function TkwProcessSubDirs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwProcessSubDirs.GetAllParamsCount

function TkwProcessSubDirs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, TypeInfo(TtfwWord)]);
end;//TkwProcessSubDirs.ParamsTypes

class function TkwProcessSubDirs.GetWordNameForRegister: AnsiString;
begin
 Result := 'ProcessSubDirs';
end;//TkwProcessSubDirs.GetWordNameForRegister

function TkwFileSize.FileSize(const aCtx: TtfwContext;
 const aFileName: AnsiString): Integer;
 {* Реализация слова скрипта FileSize }
//#UC START# *DEA5A01CE3B1_E2551B3D7813_var*
//#UC END# *DEA5A01CE3B1_E2551B3D7813_var*
begin
//#UC START# *DEA5A01CE3B1_E2551B3D7813_impl*
 Result := l3FileUtils.GetFileSize(afileName);
//#UC END# *DEA5A01CE3B1_E2551B3D7813_impl*
end;//TkwFileSize.FileSize

procedure TkwFileSize.DoDoIt(const aCtx: TtfwContext);
var l_aFileName: AnsiString;
begin
 try
  l_aFileName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFileName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(FileSize(aCtx, l_aFileName));
end;//TkwFileSize.DoDoIt

function TkwFileSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwFileSize.GetResultTypeInfo

function TkwFileSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFileSize.GetAllParamsCount

function TkwFileSize.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwFileSize.ParamsTypes

class function TkwFileSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'FileSize';
end;//TkwFileSize.GetWordNameForRegister

function TkwCompareFiles.CompareFiles(const aCtx: TtfwContext;
 const aFile1: AnsiString;
 const aFile2: AnsiString;
 const aHeaderBegin: AnsiString): Boolean;
 {* Реализация слова скрипта CompareFiles }
//#UC START# *6C5EFAFC54B2_CF832D7F4CA1_var*
//#UC END# *6C5EFAFC54B2_CF832D7F4CA1_var*
begin
//#UC START# *6C5EFAFC54B2_CF832D7F4CA1_impl*
 if (aHeaderBegin = '') then
  Result := l3Stream.l3CompareFiles(aFile1, aFile2, #0)
 else
  Result := l3Stream.l3CompareFiles(aFile1, aFile2, aHeaderBegin[1]);
//#UC END# *6C5EFAFC54B2_CF832D7F4CA1_impl*
end;//TkwCompareFiles.CompareFiles

procedure TkwCompareFiles.DoDoIt(const aCtx: TtfwContext);
var l_aFile1: AnsiString;
var l_aFile2: AnsiString;
var l_aHeaderBegin: AnsiString;
begin
 try
  l_aFile1 := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile1: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aFile2 := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFile2: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aHeaderBegin := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHeaderBegin: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(CompareFiles(aCtx, l_aFile1, l_aFile2, l_aHeaderBegin));
end;//TkwCompareFiles.DoDoIt

function TkwCompareFiles.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwCompareFiles.GetResultTypeInfo

function TkwCompareFiles.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwCompareFiles.GetAllParamsCount

function TkwCompareFiles.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwCompareFiles.ParamsTypes

class function TkwCompareFiles.GetWordNameForRegister: AnsiString;
begin
 Result := 'CompareFiles';
end;//TkwCompareFiles.GetWordNameForRegister

initialization
 TFileProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwFileOpenRead.RegisterInEngine;
 {* Регистрация File_OpenRead }
 TkwFileOpenWrite.RegisterInEngine;
 {* Регистрация File_OpenWrite }
 TkwFileEOF.RegisterInEngine;
 {* Регистрация File_EOF }
 TkwFileReadLn.RegisterInEngine;
 {* Регистрация File_ReadLn }
 TkwFileWriteLn.RegisterInEngine;
 {* Регистрация File_WriteLn }
 TkwFileWriteChar.RegisterInEngine;
 {* Регистрация File_WriteChar }
 TkwFileWriteStr.RegisterInEngine;
 {* Регистрация File_WriteStr }
 TkwFileReadLines.RegisterInEngine;
 {* Регистрация File_ReadLines }
 TkwFileWriteWStr.RegisterInEngine;
 {* Регистрация File_WriteWStr }
 TkwFileReadWStrLn.RegisterInEngine;
 {* Регистрация File_ReadWStrLn }
 TkwFileWriteWStrLn.RegisterInEngine;
 {* Регистрация File_WriteWStrLn }
 TkwFileOpenAppend.RegisterInEngine;
 {* Регистрация File_OpenAppend }
 TkwDeleteFile.RegisterInEngine;
 {* Регистрация DeleteFile }
 TkwRenameFile.RegisterInEngine;
 {* Регистрация RenameFile }
 TkwCopyFilesByMask.RegisterInEngine;
 {* Регистрация CopyFilesByMask }
 TkwCopyFile.RegisterInEngine;
 {* Регистрация CopyFile }
 TkwPureDir.RegisterInEngine;
 {* Регистрация PureDir }
 TkwDeleteFilesByMask.RegisterInEngine;
 {* Регистрация DeleteFilesByMask }
 TkwProcessFilesWithMask.RegisterInEngine;
 {* Регистрация ProcessFilesWithMask }
 TkwProcessSubDirs.RegisterInEngine;
 {* Регистрация ProcessSubDirs }
 TkwFileSize.RegisterInEngine;
 {* Регистрация FileSize }
 TkwCompareFiles.RegisterInEngine;
 {* Регистрация CompareFiles }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwFile));
 {* Регистрация типа ItfwFile }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiChar));
 {* Регистрация типа Char }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(@tfw_tiWString);
 {* Регистрация типа Tl3PCharLen }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
