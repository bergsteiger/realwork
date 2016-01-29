unit FileProcessingPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , l3Types
 , tfwTypeInfo
 , l3CProtoObject
 , l3Filer
 , tfwAxiomaticsResNameGetter
 , tfwRegisterableWord
 , TypInfo
 , tfwClassLike
 , tfwWordWorkerEx
 , tfwGlobalKeyWord
;

type
 TtfwFile = class(Tl3CProtoObject, ItfwFile)
  procedure CreateRead(const aFileName: AnsiString);
  procedure CreateWrite(const aFileName: AnsiString);
  function MakeRead(const aFileName: AnsiString): ItfwFile;
  function MakeWrite(const aFileName: AnsiString): ItfwFile;
  function ReadLn: Il3CString;
  procedure WriteLn(const aString: Il3CString);
  procedure WriteChar(aChar: AnsiChar);
  function ReadWStrLn: Tl3WString;
  procedure WriteWStrLn(const aStr: Tl3WString);
  procedure WriteWStr(const aStr: Tl3WString);
  function EOF: Boolean;
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
 end;//TtfwFile
 
implementation

uses
 l3ImplUses
 , l3String
 , SysUtils
 , l3FileUtils
 , l3Base
 , l3Stream
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TFileProcessingPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TFileProcessingPackResNameGetter
 
 TkwFileOpenRead = class(TtfwRegisterableWord)
  {* Слово скрипта File:OpenRead
*Тип результата:* ItfwFile
*Пример:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenRead >>> l_ItfwFile
[code]  }
  function OpenRead(const aCtx: TtfwContext;
   const aName: AnsiString): ItfwFile;
   {* Реализация слова скрипта File:OpenRead }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileOpenRead
 
 TkwFileOpenWrite = class(TtfwRegisterableWord)
  {* Слово скрипта File:OpenWrite
*Тип результата:* ItfwFile
*Пример:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenWrite >>> l_ItfwFile
[code]  }
  function OpenWrite(const aCtx: TtfwContext;
   const aName: AnsiString): ItfwFile;
   {* Реализация слова скрипта File:OpenWrite }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileOpenWrite
 
 TkwFileEOF = class(TtfwClassLike)
  {* Слово скрипта File:EOF
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFile File:EOF >>> l_Boolean
[code]  }
  function EOF(const aCtx: TtfwContext;
   const aFile: ItfwFile): Boolean;
   {* Реализация слова скрипта File:EOF }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileEOF
 
 TkwFileReadLn = class(TtfwClassLike)
  {* Слово скрипта File:ReadLn
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aFile File:ReadLn >>> l_Il3CString
[code]  }
  function ReadLn(const aCtx: TtfwContext;
   const aFile: ItfwFile): Il3CString;
   {* Реализация слова скрипта File:ReadLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileReadLn
 
 TkwFileWriteLn = class(TtfwClassLike)
  {* Слово скрипта File:WriteLn
*Пример:*
[code]
 aValue aFile File:WriteLn
[code]  }
  procedure WriteLn(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: Il3CString);
   {* Реализация слова скрипта File:WriteLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteLn
 
 TkwFileWriteChar = class(TtfwClassLike)
  {* Слово скрипта File:WriteChar
*Пример:*
[code]
 aValue aFile File:WriteChar
[code]  }
  procedure WriteChar(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   aValue: AnsiChar);
   {* Реализация слова скрипта File:WriteChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteChar
 
 TkwFileWriteStr = class(TtfwClassLike)
  {* Слово скрипта File:WriteStr
*Пример:*
[code]
 aValue aFile File:WriteStr
[code]  }
  procedure WriteStr(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: Il3CString);
   {* Реализация слова скрипта File:WriteStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteStr
 
 TkwFileReadLines = class(TtfwWordWorkerEx)
  {* Слово скрипта File:ReadLines
*Пример:*
[code]
 aFile File:ReadLines aWord
[code]  }
  procedure ReadLines(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aFile: ItfwFile);
   {* Реализация слова скрипта File:ReadLines }
 end;//TkwFileReadLines
 
 TkwFileWriteWStr = class(TtfwClassLike)
  {* Слово скрипта File:WriteWStr
*Пример:*
[code]
 aValue aFile File:WriteWStr
[code]  }
  procedure WriteWStr(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта File:WriteWStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteWStr
 
 TkwFileReadWStrLn = class(TtfwClassLike)
  {* Слово скрипта File:ReadWStrLn
*Тип результата:* Tl3PCharLen
*Пример:*
[code]
W-STRING VAR l_Tl3PCharLen
 aFile File:ReadWStrLn >>> l_Tl3PCharLen
[code]  }
  function ReadWStrLn(const aCtx: TtfwContext;
   const aFile: ItfwFile): Tl3PCharLen;
   {* Реализация слова скрипта File:ReadWStrLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileReadWStrLn
 
 TkwFileWriteWStrLn = class(TtfwClassLike)
  {* Слово скрипта File:WriteWStrLn
*Пример:*
[code]
 aValue aFile File:WriteWStrLn
[code]  }
  procedure WriteWStrLn(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта File:WriteWStrLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteWStrLn
 
 TkwDeleteFile = class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteFile
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aName DeleteFile >>> l_Boolean
[code]  }
  function DeleteFile(const aCtx: TtfwContext;
   const aName: AnsiString): Boolean;
   {* Реализация слова скрипта DeleteFile }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDeleteFile
 
 TkwRenameFile = class(TtfwGlobalKeyWord)
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
  function RenameFile(const aCtx: TtfwContext;
   const aNewName: AnsiString;
   const anOldName: AnsiString): Boolean;
   {* Реализация слова скрипта RenameFile }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRenameFile
 
 TkwCopyFilesByMask = class(TtfwGlobalKeyWord)
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
  procedure CopyFilesByMask(const aCtx: TtfwContext;
   const aSourceDir: AnsiString;
   const aDestDir: AnsiString;
   const aFileMask: AnsiString);
   {* Реализация слова скрипта CopyFilesByMask }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCopyFilesByMask
 
 TkwCopyFile = class(TtfwGlobalKeyWord)
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
  procedure CopyFile(const aCtx: TtfwContext;
   const aSourceFile: AnsiString;
   const aDestFile: AnsiString;
   aCopyMode: Integer);
   {* Реализация слова скрипта CopyFile }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCopyFile
 
 TkwPureDir = class(TtfwGlobalKeyWord)
  {* Слово скрипта PureDir
[panel]PureDir - очищает директорию.
*Формат:* aDirName PureDir
* aDirName  - имя директории.[panel]
*Пример:*
[code]
 aName PureDir
[code]  }
  procedure PureDir(const aCtx: TtfwContext;
   const aName: AnsiString);
   {* Реализация слова скрипта PureDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPureDir
 
 TkwDeleteFilesByMask = class(TtfwGlobalKeyWord)
  {* Слово скрипта DeleteFilesByMask
[panel]DeleteFilesByMask - очищает директорию.
*Формат:* aMask aDirName DeleteFilesByMask
* aDirName  - имя директории.
* aMask - маска, по которой отбираются файлы.[panel]
*Пример:*
[code]
 aMask aDirName DeleteFilesByMask
[code]  }
  procedure DeleteFilesByMask(const aCtx: TtfwContext;
   const aDirName: AnsiString;
   const aMask: AnsiString);
   {* Реализация слова скрипта DeleteFilesByMask }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDeleteFilesByMask
 
 TkwProcessFilesWithMask = class(TtfwGlobalKeyWord)
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
  procedure ProcessFilesWithMask(const aCtx: TtfwContext;
   const aDirName: AnsiString;
   const aFileMask: AnsiString;
   aProc: TtfwWord);
   {* Реализация слова скрипта ProcessFilesWithMask }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwProcessFilesWithMask
 
 TkwProcessSubDirs = class(TtfwGlobalKeyWord)
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
  procedure ProcessSubDirs(const aCtx: TtfwContext;
   const aDirName: AnsiString;
   aProc: TtfwWord);
   {* Реализация слова скрипта ProcessSubDirs }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwProcessSubDirs
 
 TkwFileSize = class(TtfwGlobalKeyWord)
  {* Слово скрипта FileSize
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aFileName FileSize >>> l_Integer
[code]  }
  function FileSize(const aCtx: TtfwContext;
   const aFileName: AnsiString): Integer;
   {* Реализация слова скрипта FileSize }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileSize
 
 TkwCompareFiles = class(TtfwGlobalKeyWord)
  {* Слово скрипта CompareFiles
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aHeaderBegin aFile2 aFile1 CompareFiles >>> l_Boolean
[code]  }
  function CompareFiles(const aCtx: TtfwContext;
   const aFile1: AnsiString;
   const aFile2: AnsiString;
   const aHeaderBegin: AnsiString): Boolean;
   {* Реализация слова скрипта CompareFiles }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompareFiles
 
end.
