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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TFileProcessingPackResNameGetter
 
 TkwFileOpenRead = class(TtfwRegisterableWord)
  {* ����� ������� File:OpenRead
*��� ����������:* ItfwFile
*������:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenRead >>> l_ItfwFile
[code]  }
  function OpenRead(const aCtx: TtfwContext;
   const aName: AnsiString): ItfwFile;
   {* ���������� ����� ������� File:OpenRead }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileOpenRead
 
 TkwFileOpenWrite = class(TtfwRegisterableWord)
  {* ����� ������� File:OpenWrite
*��� ����������:* ItfwFile
*������:*
[code]
FILE VAR l_ItfwFile
 aName File:OpenWrite >>> l_ItfwFile
[code]  }
  function OpenWrite(const aCtx: TtfwContext;
   const aName: AnsiString): ItfwFile;
   {* ���������� ����� ������� File:OpenWrite }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileOpenWrite
 
 TkwFileEOF = class(TtfwClassLike)
  {* ����� ������� File:EOF
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFile File:EOF >>> l_Boolean
[code]  }
  function EOF(const aCtx: TtfwContext;
   const aFile: ItfwFile): Boolean;
   {* ���������� ����� ������� File:EOF }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileEOF
 
 TkwFileReadLn = class(TtfwClassLike)
  {* ����� ������� File:ReadLn
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aFile File:ReadLn >>> l_Il3CString
[code]  }
  function ReadLn(const aCtx: TtfwContext;
   const aFile: ItfwFile): Il3CString;
   {* ���������� ����� ������� File:ReadLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileReadLn
 
 TkwFileWriteLn = class(TtfwClassLike)
  {* ����� ������� File:WriteLn
*������:*
[code]
 aValue aFile File:WriteLn
[code]  }
  procedure WriteLn(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: Il3CString);
   {* ���������� ����� ������� File:WriteLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteLn
 
 TkwFileWriteChar = class(TtfwClassLike)
  {* ����� ������� File:WriteChar
*������:*
[code]
 aValue aFile File:WriteChar
[code]  }
  procedure WriteChar(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   aValue: AnsiChar);
   {* ���������� ����� ������� File:WriteChar }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteChar
 
 TkwFileWriteStr = class(TtfwClassLike)
  {* ����� ������� File:WriteStr
*������:*
[code]
 aValue aFile File:WriteStr
[code]  }
  procedure WriteStr(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: Il3CString);
   {* ���������� ����� ������� File:WriteStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteStr
 
 TkwFileReadLines = class(TtfwWordWorkerEx)
  {* ����� ������� File:ReadLines
*������:*
[code]
 aFile File:ReadLines aWord
[code]  }
  procedure ReadLines(const aCtx: TtfwContext;
   aWord: TtfwWord;
   const aFile: ItfwFile);
   {* ���������� ����� ������� File:ReadLines }
 end;//TkwFileReadLines
 
 TkwFileWriteWStr = class(TtfwClassLike)
  {* ����� ������� File:WriteWStr
*������:*
[code]
 aValue aFile File:WriteWStr
[code]  }
  procedure WriteWStr(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� File:WriteWStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteWStr
 
 TkwFileReadWStrLn = class(TtfwClassLike)
  {* ����� ������� File:ReadWStrLn
*��� ����������:* Tl3PCharLen
*������:*
[code]
W-STRING VAR l_Tl3PCharLen
 aFile File:ReadWStrLn >>> l_Tl3PCharLen
[code]  }
  function ReadWStrLn(const aCtx: TtfwContext;
   const aFile: ItfwFile): Tl3PCharLen;
   {* ���������� ����� ������� File:ReadWStrLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileReadWStrLn
 
 TkwFileWriteWStrLn = class(TtfwClassLike)
  {* ����� ������� File:WriteWStrLn
*������:*
[code]
 aValue aFile File:WriteWStrLn
[code]  }
  procedure WriteWStrLn(const aCtx: TtfwContext;
   const aFile: ItfwFile;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� File:WriteWStrLn }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileWriteWStrLn
 
 TkwDeleteFile = class(TtfwGlobalKeyWord)
  {* ����� ������� DeleteFile
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aName DeleteFile >>> l_Boolean
[code]  }
  function DeleteFile(const aCtx: TtfwContext;
   const aName: AnsiString): Boolean;
   {* ���������� ����� ������� DeleteFile }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDeleteFile
 
 TkwRenameFile = class(TtfwGlobalKeyWord)
  {* ����� ������� RenameFile
[panel]RenameFile - ��������������� ����.
*������:* aOldFileName aNewFileName RenameFile
* aNewFileName - ����� ��� �����.
* aOldFileName - ������ ��� �����.
� ���� ���������� ��������� ��������: true - ���� �������, false - ���� �������������� �� ����������.[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOldName aNewName RenameFile >>> l_Boolean
[code]  }
  function RenameFile(const aCtx: TtfwContext;
   const aNewName: AnsiString;
   const anOldName: AnsiString): Boolean;
   {* ���������� ����� ������� RenameFile }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRenameFile
 
 TkwCopyFilesByMask = class(TtfwGlobalKeyWord)
  {* ����� ������� CopyFilesByMask
[panel]CopyFilesByMask- �������� ����� �� �����..
*������:* 
[code]
 aFileMask aDestDir aSourceDir  CopyFilesByMask
[code]
* aSourceDir - ���������� ������ ��������.
* aDestDir - ���������� ���� ��������.
* aFileMask - �����, �� ������� �������� �����.
��������� ����� �� ����������. ���� ���������� ������, �� ����� Exception[panel]
*������:*
[code]
 aFileMask aDestDir aSourceDir CopyFilesByMask
[code]  }
  procedure CopyFilesByMask(const aCtx: TtfwContext;
   const aSourceDir: AnsiString;
   const aDestDir: AnsiString;
   const aFileMask: AnsiString);
   {* ���������� ����� ������� CopyFilesByMask }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCopyFilesByMask
 
 TkwCopyFile = class(TtfwGlobalKeyWord)
  {* ����� ������� CopyFile
[panel]CopyFile - �������� ����.
*������:*  aCopyMode aDestFile aSourceFile CopyFile
* aSourceFile - ��� ��������� �����
* aDestFile - ��� �����, ���� ��������
* aCopyMode - ����� ����������� �����.
��������� ����� �� ����������. ���� ���������� ������, �� ����� Exception[panel]
*������:*
[code]
 aCopyMode aDestFile aSourceFile CopyFile
[code]  }
  procedure CopyFile(const aCtx: TtfwContext;
   const aSourceFile: AnsiString;
   const aDestFile: AnsiString;
   aCopyMode: Integer);
   {* ���������� ����� ������� CopyFile }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCopyFile
 
 TkwPureDir = class(TtfwGlobalKeyWord)
  {* ����� ������� PureDir
[panel]PureDir - ������� ����������.
*������:* aDirName PureDir
* aDirName  - ��� ����������.[panel]
*������:*
[code]
 aName PureDir
[code]  }
  procedure PureDir(const aCtx: TtfwContext;
   const aName: AnsiString);
   {* ���������� ����� ������� PureDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPureDir
 
 TkwDeleteFilesByMask = class(TtfwGlobalKeyWord)
  {* ����� ������� DeleteFilesByMask
[panel]DeleteFilesByMask - ������� ����������.
*������:* aMask aDirName DeleteFilesByMask
* aDirName  - ��� ����������.
* aMask - �����, �� ������� ���������� �����.[panel]
*������:*
[code]
 aMask aDirName DeleteFilesByMask
[code]  }
  procedure DeleteFilesByMask(const aCtx: TtfwContext;
   const aDirName: AnsiString;
   const aMask: AnsiString);
   {* ���������� ����� ������� DeleteFilesByMask }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwDeleteFilesByMask
 
 TkwProcessFilesWithMask = class(TtfwGlobalKeyWord)
  {* ����� ������� ProcessFilesWithMask
[panel]ProcessFilesWithMask - ���������� ����� �� ����� � �������� ���������� � �������� ��� ������� ���������� �������.
*������:*
aProc aFileMask aDirName ProcessFilesWithMask
* aProc - �������, ������� ���������� ��� ������� �����. � ���� ��� ������ ���������� ��� �����.
* aFileMask - �����, �� ������� ���������� �����, �������� '*.script'
* aDirName - ����, �� �������� ������ �����.
*������:*
[code]
: PrintFileName
 .
;

@ PrintFileName '*.script' 'w:\archi\source\projects\Archi\TestSet\Scripts\' ProcessFilesWithMask
[code]
� ���������� ����� ������ ���� � ���_�������.prn � ������� ������ � ������� ������.
*����������:* ���� �� ���� ���� �� ������, �� ������� �� ����� ������� �� ����. �� �����������, �� ������ �� �����, �� ����� ������ � ����� �� ��������. ����� �� ��������� ����������� �� �����������. ��� ����� ���������� � ������ �����.[panel]
*������:*
[code]
 aProc aFileMask aDirName ProcessFilesWithMask
[code]  }
  procedure ProcessFilesWithMask(const aCtx: TtfwContext;
   const aDirName: AnsiString;
   const aFileMask: AnsiString;
   aProc: TtfwWord);
   {* ���������� ����� ������� ProcessFilesWithMask }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwProcessFilesWithMask
 
 TkwProcessSubDirs = class(TtfwGlobalKeyWord)
  {* ����� ������� ProcessSubDirs
[panel]ProcessSubDirs - ���������� ���������� � �������� ���������� � �������� ��� ������� ���������� �������.
*������:*
aProc aDirName ProcessSubDirs
* aProc - �������, ������� ���������� ��� ������ ����������. � ���� ��� ������ ���������� ��� ����������.
* aDirName - ����, �� �������� ������ ����������.
*������:*
[code]
: PrintFileName
 .
;

@ PrintFileName 'w:\archi\source\projects\Archi\TestSet\' ProcessSubDirs
[code]
� ���������� ����� ������ ���� � ���_�������.prn � ������� ���������� � ������� ������.
*����������:* ���� �� ���� ����������  �� �������, �� ������� �� ����� ������� �� ����.[panel]
*������:*
[code]
 aProc aDirName ProcessSubDirs
[code]  }
  procedure ProcessSubDirs(const aCtx: TtfwContext;
   const aDirName: AnsiString;
   aProc: TtfwWord);
   {* ���������� ����� ������� ProcessSubDirs }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwProcessSubDirs
 
 TkwFileSize = class(TtfwGlobalKeyWord)
  {* ����� ������� FileSize
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aFileName FileSize >>> l_Integer
[code]  }
  function FileSize(const aCtx: TtfwContext;
   const aFileName: AnsiString): Integer;
   {* ���������� ����� ������� FileSize }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFileSize
 
 TkwCompareFiles = class(TtfwGlobalKeyWord)
  {* ����� ������� CompareFiles
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aHeaderBegin aFile2 aFile1 CompareFiles >>> l_Boolean
[code]  }
  function CompareFiles(const aCtx: TtfwContext;
   const aFile1: AnsiString;
   const aFile2: AnsiString;
   const aHeaderBegin: AnsiString): Boolean;
   {* ���������� ����� ������� CompareFiles }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwCompareFiles
 
end.
