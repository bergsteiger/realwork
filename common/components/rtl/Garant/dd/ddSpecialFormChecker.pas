unit ddSpecialFormChecker;

{ $Id: ddSpecialFormChecker.pas,v 1.7 2013/04/15 05:59:22 narry Exp $ }

// $Log: ddSpecialFormChecker.pas,v $
// Revision 1.7  2013/04/15 05:59:22  narry
// Не собиралось
//
// Revision 1.6  2013/04/11 16:46:29  lulin
// - отлаживаем под XE3.
//
// Revision 1.5  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.4  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.3  2012/10/26 07:27:27  narry
// Залить новую партию НСРов (406126937)
//
// Revision 1.2  2012/01/24 11:01:04  fireton
// - итеративный поиск префиксов в слове
//
// Revision 1.1  2012/01/24 10:12:14  fireton
// - проверка слов с помощью префиксов, стоп-слов и словаря заведомо валидных слов (К 321986535)
//

interface        
uses
 l3Interfaces,
 l3Base,
 l3ProtoObject,
 l3String,
 l3StringList,
 l3Filer,

 ddSearchTree,

 ZipForge;

const
 cMaxCharBufLen = 255;

type
 TddSpecialFormChecker = class(Tl3ProtoObject)
 private
  f_Badwords : Tl3StringList;
  f_Goodwords: Tl3StringList;
  f_Prefixes : TddSearchTree;
  function CheckByGoodwords(const aWord: Tl3WString): Boolean;
  function CheckByPrefixes(const aWord: Tl3WString): Boolean;
  procedure LoadBadwords(const aZip: TZipForge);
  procedure LoadFileToList(const aFiler: Tl3CustomFiler; const aList: Tl3StringList);
  procedure LoadGoodwords(const aZip: TZipForge);
  procedure LoadPrefixes(const aZip: TZipForge);
 protected
  procedure Cleanup; override;
 public
  constructor Create(const aBaseDir: AnsiString);
  function Check(const aWord: Tl3WString): Boolean;
 end;

function SFChecker: TddSpecialFormChecker;

const
 gSFChecker: TddSpecialFormChecker = nil;


implementation
uses
 SysUtils,
 Classes,

 l3StringListPrim,
 l3LingLib,
 l3Memory,
 l3FileUtils, dt_Serv, dt_Const;

const
 cZipName = 'scdata.zip';
 cBadwordsFN  = 'stop.txt';
 cGoodwordsFN = 'goodwords.txt';
 cPrefixesFN  = 'prefix.txt';

function SFChecker: TddSpecialFormChecker;
begin
 if gSFChecker = nil then
  gSFChecker := TddSpecialFormChecker.Create(GlobalHtServer.FamilyTbl.FamilyPath(CurrentFamily));
 Result := gSFChecker;
end;


type
 IddStrLenHolder = interface
  ['{3FF6F3A0-A8B4-460C-B36C-A90A0F9881C2}']
  function pm_GetStrLen: Integer;
  property StrLen: Integer read pm_GetStrLen;
 end;

 TddStrLenHolderObj = class(Tl3ProtoObject, IddStrLenHolder)
  private
   f_StrLen: Integer;
   function pm_GetStrLen: Integer;
  public
   constructor Create(const aStrLen: Integer);
   class function Make(const aStrLen: Integer): IddStrLenHolder;
 end;

function GetMemotyStreamFromZip(const aZip: TZipForge; const aFileName: AnsiString): Tl3MemoryStream;
begin
 Result := Tl3MemoryStream.Create;
 aZip.ExtractToStream(aFileName, Result);
 Result.Seek(0, soFromBeginning);
end;


constructor TddSpecialFormChecker.Create(const aBaseDir: AnsiString);
var
 l_Zip: TZipForge;
 l_ZipFN: AnsiString;
begin
 inherited Create;
 f_Goodwords := Tl3StringList.MakeSorted;
 f_Badwords := Tl3StringList.MakeSorted;
 f_Prefixes := TddSearchTree.Create;
 l_ZipFN := ConcatDirName(aBaseDir, cZipName);
 if FileExists(l_ZipFN) then
 begin
  l_Zip := TZipForge.Create(nil);
  try
   l_Zip.FileName := l_ZipFN;
   l_Zip.Password := 'Run-time error 216';
   l_Zip.OpenArchive;
   LoadGoodwords(l_Zip);
   LoadBadwords(l_Zip);
   LoadPrefixes(l_Zip);
  finally
   FreeAndNil(l_Zip);
  end;
 end;
end;

function TddSpecialFormChecker.Check(const aWord: Tl3WString): Boolean;
var
 l_Str: Il3CString;
begin
 l_Str := l3Lower(l3CStr(aWord));
 Result := CheckByGoodwords(l_Str.AsWStr);
 if not Result then
  Result := CheckByPrefixes(l_Str.AsWStr);
end;

function TddSpecialFormChecker.CheckByGoodwords(const aWord: Tl3WString): Boolean;
begin
 Result := f_Goodwords.IndexOf(aWord) >= 0;
end;

function TddSpecialFormChecker.CheckByPrefixes(const aWord: Tl3WString): Boolean;

 function l_DoOnePrefix(const aData: IUnknown): Boolean;
 var
  l_Action: TllAddStrProc;
  l_Tail : Tl3WString;
  l_SH : IddStrLenHolder;
  l_NoStopWords: Boolean;

  procedure LemmActionProc(aLemma : PAnsiChar; aWordLen : integer);
  begin
   if l_NoStopWords and (f_Badwords.IndexOf(l3PCharLen(aLemma, aWordLen)) >= 0) then
    l_NoStopWords := False;
  end;

 begin
  Result := False;
  if Supports(aData, IddStrLenHolder, l_SH) then
  begin
   l_Tail := l3Copy(aWord, l_SH.StrLen);
   if l_Tail.SLen >= 3 then
   begin
    l_Action := L2llAddStrProc(@LemmActionProc);
    try
     l_NoStopWords := True;
     Result := mlmaLemmatize(l_Tail, maIgnoreCapitals, l_Action) and l_NoStopWords;
     if (not Result) and l_NoStopWords then
      Result := CheckByPrefixes(l_Tail);
    finally
     FreellAddStrProc(l_Action);
    end;
   end;
  end;
 end;

begin
 Result := f_Prefixes.ScanPrefixesF(aWord, ddL2PPF(@l_DoOnePrefix));
end;

procedure TddSpecialFormChecker.Cleanup;
begin
 inherited;
 FreeAndNil(f_Goodwords);
 FreeAndNil(f_Prefixes);
 FreeAndNil(f_Badwords);
end;

procedure TddSpecialFormChecker.LoadBadwords(const aZip: TZipForge);
var
 l_MS    : Tl3MemoryStream;
 l_Filer : Tl3CustomFiler;
begin
 l_MS := GetMemotyStreamFromZip(aZip, cBadwordsFN);
 try
  l_Filer := Tl3CustomFiler.Create;
  try
   l_Filer.Stream := l_MS;
   try
    LoadFileToList(l_Filer, f_Badwords);
   finally
    l_Filer.Stream := nil;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
 finally
  FreeAndNil(l_MS);
 end;
end;

procedure TddSpecialFormChecker.LoadFileToList(const aFiler: Tl3CustomFiler; const aList: Tl3StringList);
var
 l_Str: Tl3WString;
begin
 while not aFiler.EOF do
 begin
  l_Str := l3Trim(aFiler.ReadLn);
  if not l3IsNil(l_Str) then
   aList.Add(l3Lower(l_Str));
 end;
end;

procedure TddSpecialFormChecker.LoadGoodwords(const aZip: TZipForge);
var
 l_MS    : Tl3MemoryStream;
 l_Filer : Tl3CustomFiler;
 l_FN    : AnsiString;
begin
 l_MS := GetMemotyStreamFromZip(aZip, cGoodwordsFN);
 try
  l_Filer := Tl3CustomFiler.Create;
  try
   l_Filer.Stream := l_MS;
   try
    LoadFileToList(l_Filer, f_Goodwords);
   finally
    l_Filer.Stream := nil;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
 finally
  FreeAndNil(l_MS);
 end;

 // теперь загрузим словарь не из зипа - пользовательский
 l_FN := ConcatDirName(ExtractFilePath(aZip.FileName), cGoodwordsFN); // файл лежит рядом с зипом
 if FileExists(l_FN) then
 begin
  l_Filer := Tl3DOSFiler.Make(l_FN);
  try
   l_Filer.Open;
   try
    LoadFileToList(l_Filer, f_Goodwords);
   finally
    l_Filer.Stream := nil;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
 end;
end;

procedure TddSpecialFormChecker.LoadPrefixes(const aZip: TZipForge);
var
 l_MS    : Tl3MemoryStream;
 l_Filer : Tl3CustomFiler;
 l_Str: Tl3WString;
begin
 l_MS := GetMemotyStreamFromZip(aZip, cPrefixesFN);
 try
  l_Filer := Tl3CustomFiler.Create;
  try
   l_Filer.Stream := l_MS;
   try
    while not l_Filer.EOF do
    begin
     l_Str := l3Trim(l_Filer.ReadLn);
     if not l3IsNil(l_Str) then
      f_Prefixes.AddString(l3Lower(l_Str), TddStrLenHolderObj.Make(l_Str.SLen));
    end;
   finally
    l_Filer.Stream := nil;
   end;
  finally
   FreeAndNil(l_Filer);
  end;
 finally
  FreeAndNil(l_MS);
 end;
end;

constructor TddStrLenHolderObj.Create(const aStrLen: Integer);
begin
 inherited Create;
 f_StrLen := aStrLen;
end;

class function TddStrLenHolderObj.Make(const aStrLen: Integer): IddStrLenHolder;
var
 l_SH: TddStrLenHolderObj;
begin
 l_SH := TddStrLenHolderObj.Create(aStrLen);
 try
  Result := l_SH;
 finally
  FreeAndNil(l_SH);
 end;
end;

function TddStrLenHolderObj.pm_GetStrLen: Integer;
begin
 Result := f_StrLen;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddSpecialFormChecker.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddSpecialFormChecker.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(gSFChecker);
end.
