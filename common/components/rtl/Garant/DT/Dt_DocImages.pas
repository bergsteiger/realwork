unit Dt_DocImages;

{ $Id: Dt_DocImages.pas,v 1.58 2016/07/29 11:25:14 fireton Exp $ }
// $Log: Dt_DocImages.pas,v $
// Revision 1.58  2016/07/29 11:25:14  fireton
// - ����� ������ ����������� ������ ��������
//
// Revision 1.57  2016/06/20 15:04:21  fireton
// - ������������������ ������� �������� ����� ������ �� ���� � ���������
//
// Revision 1.56  2016/06/17 13:00:03  fireton
// - ������ ������
//
// Revision 1.55  2016/06/17 12:48:39  fireton
// - �������� ������� ����
//
// Revision 1.54  2016/06/16 06:51:26  fireton
// - �� ������� ����� �� ����� (������� �����!)
//
// Revision 1.53  2016/06/15 14:47:13  fireton
// - ��������� ��� ����� ��� ����������� �� ����
//
// Revision 1.52  2016/06/10 12:35:17  fireton
// - ����������� ������� ����������
//
// Revision 1.51  2016/06/09 15:14:58  fireton
// - ����������� ������� ����������
//
// Revision 1.50  2016/06/07 13:41:37  fireton
// - ����������� ������� ����������
//
// Revision 1.49  2015/11/25 14:01:48  lukyanets
// ��������� ��� ������ �������+������� ��������
//
// Revision 1.48  2015/07/02 11:41:29  lukyanets
// ��������� �������
//
// Revision 1.47  2015/07/02 07:36:07  lukyanets
// ��������� �������
//
// Revision 1.46  2015/05/20 11:51:05  fireton
// - ����������� ����������� ������� ���������� ������
//
// Revision 1.45  2015/03/04 12:08:12  lukyanets
// ������� ����������
//
// Revision 1.44  2014/11/13 11:42:12  fireton
// - ����������� ����������� ���� MDP-��������������
//
// Revision 1.43  2014/10/14 10:42:08  voba
// -bf ���������� ����������� ����������� ��������
//
// Revision 1.42  2013/04/19 14:52:19  lulin
// - ���������.
//
// Revision 1.41  2012/11/30 08:36:51  narry
// �������� ���� � ������ ������� ���������� (412167617)
//
// Revision 1.40  2012/11/01 09:42:41  lulin
// - ����� ����� � �������.
//
// Revision 1.39  2012/11/01 07:44:35  lulin
// - ������ ����������� ����������� �������� �������� �������.
//
// Revision 1.38  2012/09/26 10:26:43  fireton
// - ������ DocImageServer "on demand" (K 397280929)
//
// Revision 1.37  2012/08/15 07:23:46  fireton
// - ��������� ���������� ���������� �� ������� � ��� MDP-�������
//
// Revision 1.36  2011/12/08 14:06:20  fireton
// - ����������� ������ � ������ ������
//
// Revision 1.35  2011/11/15 12:10:13  fireton
// - bugfix: ������ ���� �� ��������� ����� � �������� :)
//
// Revision 1.34  2011/10/28 13:24:08  fireton
// - ����� ������� �������� ����������� �����
//
// Revision 1.33  2010/09/24 12:11:14  voba
// - k : 235046326
//
// Revision 1.32  2010/08/03 13:16:38  voba
// - k: 229672814
//
// Revision 1.31  2010/06/21 15:39:59  fireton
// - raise ��� ��������
//
// Revision 1.30  2009/07/22 11:27:26  narry
// - ��������� ������� � DictServer
//
// Revision 1.29  2009/06/23 07:32:59  voba
// - �������������� ������� � ���������
//
// Revision 1.28  2009/04/13 07:10:58  narry
// - ���������� ����������� ����� � ����������
//
// Revision 1.27  2008/11/10 14:32:19  fireton
// - �� ���������� �� ��������� ������� �� ��������
//
// Revision 1.26  2008/10/22 12:55:19  voba
// no message
//
// Revision 1.25  2008/10/15 09:06:57  fireton
// - ����������� ����, ���������� � �������� ���������� (��������� DocImageServer)
//
// Revision 1.24  2008/10/07 08:41:08  voba
// no message
//
// Revision 1.23  2008/10/03 10:31:36  fireton
// - ������� ��������� ������ ����� ���� �� ������ TIFF
//
// Revision 1.22  2008/10/01 11:38:16  narry
// - ���� �������
//
// Revision 1.21  2008/08/11 08:49:20  voba
// - add overload function IsImageExists
//
// Revision 1.20  2008/04/03 07:56:02  voba
// - ��������� ��� �� DocImgSup � dt_DocImages
//
// Revision 1.19  2008/01/31 14:56:16  fireton
// - TBigDictId -> TDictId
//
// Revision 1.18  2007/11/26 09:41:12  voba
// - use cUndefDictID, cUndefDocID, cUndefSubID
//
// Revision 1.17  2007/09/10 08:34:51  fireton
// - ����������� �� ������� �������� � ID ���������� �������������
//
// Revision 1.16  2007/08/14 19:31:56  lulin
// - ������������ ������� ������.
//
// Revision 1.15  2007/08/14 14:30:08  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.14  2007/03/06 14:51:26  fireton
// - ����� � ���������� ������� ����������� ���������� �������������
//
// Revision 1.13  2007/01/29 08:23:46  fireton
// - �����������
//
// Revision 1.12  2006/12/13 13:48:52  fireton
// - ��������� ������ � ���������
// - ���� "�������� �� ��������" ��� ����, ����������� ��� "�������� �� �������� 2"
//
// Revision 1.11  2006/03/15 13:41:46  voba
// - enh. � ������������ PublishedIn ���������������� ������
//
// Revision 1.10  2005/11/03 14:08:28  step
// ����� �����������
//
// Revision 1.9  2005/11/03 12:10:35  step
// ���� � ������
//
// Revision 1.8.2.1  2005/11/03 09:32:20  step
// ���������� TDocImages.ImageFullFileName
//
// Revision 1.8  2005/10/27 13:19:13  step
// ��������� ����������� ��������� �������� �������������
//
// Revision 1.7  2005/03/25 16:24:10  step
// TDocImages.Add ����� �� ������ ����������, �� � ���������� �����
//
// Revision 1.6  2005/03/24 11:51:38  step
// no message
//
// Revision 1.5  2005/03/24 11:29:47  step
// no message
//
// Revision 1.4  2005/03/24 11:27:24  step
// �����������
//
// Revision 1.3  2005/03/23 15:27:49  step
// ����������� ���� ����������� �� ��������
//
// Revision 1.2  2005/03/21 13:29:57  step
// �������� c_ImageId
//
// Revision 1.1  2005/03/15 17:16:59  step
// �������� � CVS
//

{$I DtDefine.inc}

interface

uses SysUtils,
     HT_Const, 
     l3Base,
     l3Date,
     l3Types,

     Dt_Types,
     Dt_Const,
     dt_AttrSchema,

     Dt_aTbl,
     Dt_Dict,
     Dt_DictTypes;

type
 EDocImageError = class(Exception);

 TImgFileType   = (iftAutoDetect, iftTIFF, iftContainer);
 TImgSourceType = (istAutoDetect, istStorage, istCache, istNoSource);

 TDocImageServer = class(Tl3Base)
 private
  f_ImageStoragePath: AnsiString;
  f_ImageCachePath: AnsiString;
  f_LastSource: TPublishedUniqueKeyRec;
  f_LastSourceId : LongWord;
  f_MemorizedIgnoreDuplicated: Boolean;
  function GetPublishDataRec(aDocId: TDocId; aDocSourceId: TDictId; var theRec: TPublishDataRec): Boolean;
  function ImagesFolder(aDocId: TDocId): AnsiString;
 protected
  function ExistsFor(aDocId: TDocId; aSourceId: TDictId): Boolean;
 public
  constructor Create(const aImageStoragePath, aImageCachePath: AnsiString);
  procedure Add(aDocId: TDocId;
                const aImageFile: AnsiString;
                aSourceIds : array of TDictId; // DT#B.ID, ���� = c_GotByMail, � DT#A.ID=DT#B.Source � ��������� ������
                aPages     : AnsiString;
                aIssueNum  : AnsiString  = '';
                aStartDate : TStDate = 0;
                aEndDate   : TStDate = 0;
                aAsCopy: Boolean = True;
                aByMail: Boolean = False); overload;
  procedure AddImageFile(const aImageFile: AnsiString;
                         aSrcID : TDictID;
                         aSDate, aEDate : TStDate;
                         const aNumber : AnsiString;
                         aNonPeriodic : Boolean;
                         aDocID : TDocID = -1;
                         aAsCopy: Boolean = True); overload;
  procedure AddImageFile(const aImageFile: AnsiString; const aPubRec: PPublishDataRec; aAsCopy: Boolean = True); overload;
  function CommitImageCache(const aProgressProc: Tl3ProgressProc = nil): Boolean;
  procedure DeleteImages(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString; aNonPeriodic : Boolean);
  function GetImageFileName(aDocId: TDocId; aDocSourceId: TDictId; aImageFileType: TImgFileType = iftAutoDetect;
   aImgSource: TImgSourceType = istAutoDetect): AnsiString; overload;
  function GetImageFileName(const aRec : PPublishDataRec; aImageFileType: TImgFileType = iftAutoDetect; aImgSource:
   TImgSourceType = istAutoDetect): AnsiString; overload;
  function GetImageFileName(aSrcID : TDictID;
                           aSDate, aEDate : TStDate;
                           const aNumber : AnsiString;
                           aNonPeriodic : Boolean;
                           aDocID : TDocID = -1;
                           aImageFileType: TImgFileType = iftAutoDetect;
                           aImgSource: TImgSourceType = istAutoDetect): AnsiString; overload;
  procedure StartBatch;
  procedure StopBatch;
  function IsImageExists(const aRec : PPublishDataRec) : boolean; overload;
  function IsImageExists(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString; aNonPeriodic : Boolean; aDocID : TDocID = -1): boolean; overload;
  property ImageStoragePath: AnsiString read f_ImageStoragePath;
  property ImageCachePath: AnsiString read f_ImageCachePath;
 end;

function IsTIFF(aFileName: AnsiString): Boolean;


procedure SetDocImagePath(const aPath, aCachePath: AnsiString);
function DocImageServer: TDocImageServer;

implementation

uses
 l3FileUtils,
 l3IniFile,
 l3String,
 l3Except,

 daTypes,
 daSchemeConsts,

 HT_DLL,
 Dt_Table, dt_Record,

 Dt_LinkServ,
 Dt_Err,
 dt_ImgContainer,

 DateUtils, dt_DictConst,

 ddFileIterator,
 ddUtils, vtDebug;

const
 cImageContainerExt = '.aic';   // Archi Image Container
 cTIFFImageExt      = '.tif';

const
 gDocImageServer: TDocImageServer = nil;
 gDocImagePath     : AnsiString = '';
 gDocImageCachePath: AnsiString = '';

{ TDocImages }

procedure SetDocImagePath(const aPath, aCachePath: AnsiString);
var
 l_Changed: Boolean;
 l_NewCachePath: AnsiString;
begin
 l_Changed := False;
 if gDocImagePath <> aPath then
 begin
  gDocImagePath := aPath;
  l_Changed := True;
 end;
 if UpperCase(ExcludeTrailingPathDelimiter(aCachePath)) = UpperCase(ExcludeTrailingPathDelimiter(aPath)) then
  l_NewCachePath := ''
 else
  l_NewCachePath := aCachePath;
 if gDocImageCachePath <> l_NewCachePath then
 begin
  gDocImageCachePath := l_NewCachePath;
  l_Changed := True;
 end;
 if l_Changed then
 begin
  FreeAndNil(gDocImageServer);
 end;
end;

function DocImageServer: TDocImageServer;
var
 l_CachePathDefined: Boolean;
 l_CachePathValid: Boolean;
 l_ImagePathValid: Boolean;
begin
 if gDocImageServer = nil then
 begin
  l_ImagePathValid := SysUtils.DirectoryExists(gDocImagePath);
  l_CachePathDefined   := (gDocImageCachePath <> '');
  if l_CachePathDefined then
   l_CachePathValid := SysUtils.DirectoryExists(gDocImageCachePath)
  else
   l_CachePathValid := False;
  if not l_ImagePathValid then
   l3System.Msg2Log('������: �������� ���� � ������ ������� ���������� ("%s")!. ���������� � ��������������', [gDocImagePath]);
  if l_CachePathDefined and not l_CachePathValid then
   l3System.Msg2Log('������: �������� ���� � ���� ������� ���������� ("%s")!. ���������� � ��������������', [gDocImageCachePath]);
  if ((not l_ImagePathValid) and (not l_CachePathDefined)) or (l_CachePathDefined and (not l_CachePathValid)) then
   raise El3Error.Create('������ � �������� ����������! ������������ ���������!');
  gDocImageServer := TDocImageServer.Create(gDocImagePath, gDocImageCachePath);
 end;
 Result := gDocImageServer;
end;

procedure TDocImageServer.Add(aDocId: TDocId;
                         const aImageFile: AnsiString;
                         aSourceIds : array of TDictId;
                         aPages     : AnsiString;
                         aIssueNum  : AnsiString = '';
                         aStartDate : TStDate = 0;
                         aEndDate   : TStDate = 0;
                         aAsCopy    : Boolean = True;
                         aByMail    : Boolean = False);
var
 l_LinkRec: TPublishLinkRec;
 l_AlreadyExists: Boolean;
 l_FileSize: Int64;
 l_PubRecNum: Longint;
 l_PubRec   : TPublishedDictRec;
 l_PubKey   : TPublishedUniqueKeyRec;
 l_PubDataRec: TPublishDataRec;
 l_Elapsed: Double;
 l_Str: AnsiString;
 l_Time: Int64;

 procedure RetrieveSourceIdFromDB;
 var
  l_SourceId: TDictID;
 begin
  l_PubRecNum := DictServer(CurrentFamily).DictTbl[da_dlPublisheds].GetRecordIDByUniq(piUniqKeyNum, l_PubKey);
  if l_PubRecNum > 0 then
  begin
   with DictServer(CurrentFamily).DictTbl[da_dlPublisheds] do
   begin
    GetFullRec(l_PubRecNum, False);
    GetFromFullRec(piIDFld, l_SourceId);
    aSourceIDs[0] := l_SourceId;
   end;
  end
  else
  begin
   // �� ������� ����� ������, ���� �������...
   l3FillChar(l_PubRec, SizeOf(l_PubRec), 0);
   with l_PubRec do
   begin
    ID := cUndefDictID;
    Sour := aSourceIds[0];
    SDate := aStartDate;
    EDate := aEndDate;
    l3StringToArray(Num, SizeOf(Num), aIssueNum);
   end;
   DictServer(CurrentFamily).Tbl[da_dlPublisheds].AddData(l_PubRec.ID, @l_PubRec.Sour);
   aSourceIDs[0] := l_PubRec.ID;
  end;
 end;

begin
 // ���� �� "�������� �� ��������", �� ���� ����� ���������� ����� �������,
 // � ���� ��� ���, �� �������
 if not aByMail then
 begin
  with l_PubKey do
  begin
   Sour := aSourceIds[0];
   SDate := aStartDate;
   EDate := aEndDate;
   l3StringToArray(Num, SizeOf(Num), aIssueNum);
  end;
  if not CompareMem(@f_LastSource, @l_PubKey, SizeOf(TPublishedUniqueKeyRec)) then
  begin
   RetrieveSourceIdFromDB;
   f_LastSource := l_PubKey;
   f_LastSourceId := aSourceIds[0];
  end
  else
   aSourceIds[0] := f_LastSourceId;
 end;

 l_AlreadyExists := ExistsFor(aDocId, aSourceIds[0]);
 if aByMail and l_AlreadyExists and (Length(aSourceIds) > 1) and (aSourceIds[1] <> 0) then
 begin
  aSourceIds[0] := aSourceIds[1];
  l_AlreadyExists := ExistsFor(aDocId, aSourceIds[0]);
 end;

 if not l_AlreadyExists then
 begin
  l3FillChar(l_LinkRec, SizeOf(l_LinkRec), 0);
  l_LinkRec.Doc_ID := aDocId;
  l_LinkRec.Dict_ID := aSourceIds[0];
  l3StringToArray(l_LinkRec.Pages, SizeOf(l_LinkRec.Pages), aPages);
  LinkServer(CurrentFamily).Links[da_dlPublisheds].AddNodeEx(@l_LinkRec);
 end;

 if aImageFile = '' then // ���������� ���� ����� �� ������, ���� ���� ������ �������� ������
  Exit;

 if GetPublishDataRec(aDocId, aSourceIds[0], l_PubDataRec) then
 begin
  l_FileSize := GetFileSize(aImageFile);
  l_Str := Bytes2Str(l_FileSize);
  l3System.Msg2Log('������ ����� ������ ��������� (%s)', [l_Str], 1);
  l_Time := dbgStartTimeCounter;
  AddImageFile(aImageFile, @l_PubDataRec, aAsCopy);
  l_Time := dbgGetElapsed(l_Time);
  l_Elapsed :=  l_Time / 1000; // ��������� ����� � ��������
  if l_Elapsed > 0 then
   l_Str := Bytes2Str(Trunc(l_FileSize / l_Elapsed))
  else
   l_Str := '�������������';
  l3System.Msg2Log('����� ������� �� ��������� %s/���', [l_Str], 1);
 end
 else
  l3System.Msg2Log(Format('������ �� ������������� �� �������, ���� ������ �� �������! DocID = %d, SourceID = %d',
     [aDocId, aSourceIds[0]]), 1);

end;

constructor TDocImageServer.Create(const aImageStoragePath, aImageCachePath: AnsiString);
begin
 inherited Create;
 f_ImageStoragePath := NormalizedPath(aImageStoragePath);
 f_ImageCachePath := NormalizedPath(aImageCachePath);

 {if not DirectoryExists(f_ImageStoragePath) then
  raise EDocImage.Create(SysUtils.Format('����� �������� ImageStoragePath: %s',
                                         [f_ImageStoragePath]));
 }
 
 l3FillChar(f_LastSource, SizeOf(f_LastSource), 0);
 f_LastSourceId := 0;
end;

procedure TDocImageServer.AddImageFile(const aImageFile: AnsiString;
                                       aSrcID : TDictID;
                                       aSDate, aEDate : TStDate;
                                       const aNumber : AnsiString;
                                       aNonPeriodic: Boolean;
                                       aDocID : TDocID = -1;
                                       aAsCopy: Boolean = True);
var
 l_FullFileName: AnsiString;
 l_AtlImgFN: AnsiString;
 l_ImgContainer: TdtImgContainerFile;

 procedure GenerateImgFileName(aImageType: TImgFileType);
 var
  l_Src: TImgSourceType;
 begin
  if f_ImageCachePath <> '' then
   l_Src := istCache
  else
   l_Src := istStorage;
  l_FullFileName := GetImageFileName(aSrcID, aSDate, aEDate, aNumber, aNonPeriodic, aDocID, aImageType, l_Src);
  if l_FullFileName = '' then
   raise EDocImageError.CreateFmt('�� ������� ��������� �������������� ������ (�������� Id=%d, �������� Id=%d).',
                                         [aDocID, aSrcID]);
  MakeDir(ExtractFilePath(l_FullFileName));
 end;

begin
 if (not FileExists(aImageFile)) then
  raise EDocImageError.CreateFmt('�������� ���� ������ �� ������: %s', [aImageFile]);
 if GetFileSize(aImageFile) = 0 then
  raise EDocImageError.CreateFmt('�������� ���� ������ ����: %s', [aImageFile]);
 if IsTIFF(aImageFile) then // ���� ��� TIF, �� ���� �������� ���
 begin
  GenerateImgFileName(iftTIFF);
  if aAsCopy then
  begin
   CopyFile(aImageFile, l_FullFileName, cmWriteOver+cmNoBakCopy);
   if GetFileSize(aImageFile) <> GetFileSize(l_FullFileName) then
    raise EInOutError.CreateFmt('������ ����������� ����� %s', [ExtractFileName(aImageFile)]);
  end
  else
   if not RenameFile(aImageFile, l_FullFileName) then
   begin
    CopyFile(aImageFile, l_FullFileName, cmWriteOver+cmNoBakCopy);
    if GetFileSize(aImageFile) <> GetFileSize(l_FullFileName) then
     raise EInOutError.CreateFmt('������ ����������� ����� %s', [aImageFile]);
    DeleteFile(aImageFile);
   end;

  // ���� ��� ��� �����-���������, �� ��� ���� ��������
  l_AtlImgFN := ChangeFileExt(l_FullFileName, cImageContainerExt);
  if FileExists(l_AtlImgFN) then
   DeleteFile(l_AtlImgFN);
 end
 else
 begin
  GenerateImgFileName(iftContainer);
  l_ImgContainer := TdtImgContainerFile.Create(l_FullFileName);
  try
   l_ImgContainer.WrapFile(aImageFile);
  finally
   l3Free(l_ImgContainer);
  end;

  if not aAsCopy then
   DeleteFile(aImageFile);

  // ���� ��� ��� ����� � ����������� .tif, �� ��� ���� ��������
  l_AtlImgFN := ChangeFileExt(l_FullFileName, cTIFFImageExt);
  if FileExists(l_AtlImgFN) then
   DeleteFile(l_AtlImgFN);
 end;

 {$IFDEF ReportImageName}
 l3System.Msg2Log('���� ������: %s', [l_FullFileName]);
 if not FileExists(l_FullFileName) then
  l3System.Msg2Log('������: ���� �� ��� ������ �� ������� �������!');
 {$ENDIF}
end;

procedure TDocImageServer.AddImageFile(const aImageFile: AnsiString; const aPubRec: PPublishDataRec; aAsCopy: Boolean = True);
begin
 with aPubRec^ do
   AddImageFile(aImageFile, SourID, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), (IsNonperiodic = 1), DocId, aAsCopy);
end;

function TDocImageServer.CommitImageCache(const aProgressProc: Tl3ProgressProc = nil): Boolean;
var
 l_FI: TddFileIterator;
 l_IterFunc: TddIterateProc;
 l_Success : Boolean;
 l_Time: Int64;
 l_Elapsed: Double;
 l_Str: AnsiString;
 l_Num: Integer;

 // ��� ����������� ������� �����������, ��� ��������� ������ � ��������������
 // �������� �� ������������ �������� ������ � �������� ���������� � ������� ����������� ������
 procedure MoveImageFile(const aFromFN, aToFN: AnsiString);
 const
  cBufSize = 1024 * 256; // 256 ��������
 var
  l_Buf: Pointer;
  l_FileAge, l_FileAttr: Longint;
  l_HFrom, l_HTo: Integer;
  l_FileSize, l_TotalWritten: Int64;
  l_NumRead, l_NumWritten: Integer;
  l_ErrStr: AnsiString;
 begin
  l3System.GetLocalMem(l_Buf, cBufSize);
  try
   l_FileAttr := FileGetAttr(aFromFN);
   l_HFrom := FileOpen(aFromFN, fmShareDenyWrite);
   if l_HFrom < 0 then
    raise EInOutError.CreateFmt('�� ���� ������� ��� ������ ���� %s', [aFromFN]);
   try
    l_FileAge := FileGetDate(l_HFrom);
    MakeDir(ExtractFilePath(aToFN));
    l_HTo := FileCreate(aToFN);
    if l_HTo < 0 then
     raise EInOutError.CreateFmt('�� ���� ������� ��� ������ ���� %s', [aToFN]);
    try
     l_FileSize := GetFileSize(aFromFN);
     l_TotalWritten := 0;
     repeat
      l_NumRead := FileRead(l_HFrom, l_Buf^, cBufSize);
      if l_NumRead < 0 then
      begin
       l_ErrStr := SysErrorMessage(GetLastError);
       raise EInOutError.CreateFmt('������ ������ ����� %s (%s)', [aFromFN, l_ErrStr]);
      end;
      l_NumWritten := FileWrite(l_HTo, l_Buf^, l_NumRead);
      if l_NumWritten < 0 then
      begin
       l_ErrStr := SysErrorMessage(GetLastError);
       raise EInOutError.CreateFmt('������ ������ ����� %s (%s)', [aToFN, l_ErrStr]);
      end;
      Inc(l_TotalWritten, l_NumWritten);
     until (l_NumRead = 0) or (l_NumWritten < l_NumRead);
     FileSetDate(l_HTo, l_FileAge);
    finally
     FileClose(l_HTo);
    end;
    if l_TotalWritten <> l_FileSize then
    begin
     DeleteFile(aToFN);
     raise EInOutError.CreateFmt('������ �����������, �� ��������� ������ ������ %s (%d) � %s (%d). ����� �������.',
        [aFromFN, l_FileSize, aToFN, l_TotalWritten]);
    end;
    FileSetAttr(aToFN, l_FileAttr);
   finally
    FileClose(l_HFrom);
   end;
   DeleteFile(aFromFN);
  finally
   l3System.FreeLocalMem(l_Buf);
  end;
 end;

 function MoveOne(const aFileName: AnsiString): Boolean;
 var
  l_DestFN: AnsiString;
  l_LocalFN: AnsiString;
  l_FS : Int64;
 begin
  Result := True;
  try
   Inc(l_Num);
   l_LocalFN := ExtractRelativePath(IncludeTrailingBackslash(f_ImageCachePath), aFileName);
   l_FS := GetFileSize(aFileName);
   l3System.Msg2Log('  [%d �� %d] %s (%s)', [l_Num, l_FI.Count, l_LocalFN, Bytes2Str(l_FS)]);
   l_DestFN := ConcatDirName(f_ImageStoragePath, l_LocalFN);
   DeleteFile(ChangeFileExt(l_DestFN, cTIFFImageExt)); // ����� ������� �� ������, ������� ��� ���� � ���������
   DeleteFile(ChangeFileExt(l_DestFN, cImageContainerExt)); // ������� �� ����� - ������! (������� �����, ���� ����� ������, ��� �����)
   //CopyFileEx(aFileName, l_DestFN, nil, cmWriteOver + cmNoBakCopy + cmDeleteSource, True);
   MoveImageFile(aFileName, l_DestFN);
  except
   on E: Exception do
   begin
    l3System.Msg2Log('������ ����������� ����� %s (%s)', [aFileName, E.Message]);
    l_Success := False;
    Result := False;
   end;
  end;
 end;
begin
 // ���������� ���������� ���� � �������� ���������
 l_FI := TddFileIterator.Make(f_ImageCachePath, '*.*', aProgressProc, True);
 try
  if l_FI.Count > 0 then
  begin
   l3System.Msg2Log('�������: %s ����� ������� %s. ������ �����������.',
    [NumSuffix(l_FI.Count, '��������', '���������', '����������'),
    Bytes2Str(l_FI.TotalSize)]);
   l_IterFunc := L2IterateFilesProc(@MoveOne);
   try
    l_Success := True;
    l_Num := 0;
    l_Time := dbgStartTimeCounter;
    l_FI.IterateFiles(l_IterFunc);
    if l_Success then
    begin
     l_Time := dbgGetElapsed(l_Time);
     l_Elapsed :=  l_Time / 1000; // ��������� ����� � ��������
     if l_Elapsed > 0 then
      l_Str := Bytes2Str(Trunc(l_FI.TotalSize / l_Elapsed))  
     else
      l_Str := '�������������';
     l3System.Msg2Log('��������� ��������� �� %s, ����� ����������� �� ��������� %s/���.', [TimeSec2Str(Trunc(l_Elapsed)), l_Str]);
     PureDir(f_ImageCachePath);
    end;
    Result := l_Success;
   finally
    FreeIterateFilesProc(l_IterFunc);
   end;
  end
  else
  begin
   l3System.Msg2Log('��� ������� ����, ��������� �� ���������.');
   Result := True;
  end;
 finally
  FreeAndNil(l_FI);
 end;
end;

procedure TDocImageServer.DeleteImages(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString;
 aNonPeriodic : Boolean);
var
 l_Mask: AnsiString;
begin
 l_Mask := ChangeFileExt(GetImageFileName(aSrcID, aSDate, aEDate, aNumber, aNonPeriodic, -1, iftTIFF, istNoSource), '.*');
 DeleteFilesByMask(f_ImageCachePath, l_Mask);
 DeleteFilesByMask(f_ImageStoragePath, l_Mask);
end;

function TDocImageServer.ExistsFor(aDocId: TDocId; aSourceId: TDictId): Boolean;
type
 TLinkRec = packed record
  rDocId  : TDocID;
  rDictId : TDictID;
 end;
var
 lPack : TLinkRec;
begin
 with lPack do
 begin
  rDocId  := aDocId;
  rDictId := aSourceId;
 end;

 Result := LinkServer(CurrentFamily)[atPublisheds].Table.HasUniqRec(lPack);

 //Result := LinkServer.LinkExists(da_dlPublisheds, aDocId, aSourceId);
{
 // �������� �� ������� ���������������� �����
 if Result then
  if not FileExists(ImageFullFileName(aDocId)) then
   raise EDocImage.Create(SysUtils.Format('�� ������ ����� ��������� %d', [aDocId]));
}
end;

function TDocImageServer.GetImageFileName(aDocId: TDocId; aDocSourceId: TDictId; aImageFileType: TImgFileType =
    iftAutoDetect; aImgSource: TImgSourceType = istAutoDetect): AnsiString;
var
 l_PublishDataRec: TPublishDataRec;
begin
 Result := '';
 if GetPublishDataRec(aDocId, aDocSourceId, l_PublishDataRec) then
  Result := GetImageFileName(@l_PublishDataRec, aImageFileType, aImgSource);
end;

function TDocImageServer.GetImageFileName(const aRec : PPublishDataRec; aImageFileType: TImgFileType = iftAutoDetect;
                                          aImgSource: TImgSourceType = istAutoDetect):AnsiString;
begin
 with aRec^ do
  Result := GetImageFileName(SourID, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), (IsNonperiodic = 1), DocId, aImageFileType, aImgSource)
end;

function TDocImageServer.ImagesFolder(aDocId: TDocId): AnsiString;
begin
 // �������� aDocId ����� ������������ � ������� ��� ����������� �����
 Result := f_ImageStoragePath;
end;

procedure TDocImageServer.StartBatch;
begin
 f_MemorizedIgnoreDuplicated := LinkServer(CurrentFamily)[atPublisheds].Table.IgnoreDuplicates;
 LinkServer(CurrentFamily)[atPublisheds].Table.IgnoreDuplicates := True;
 LinkServer(CurrentFamily)[atPublisheds].Table.StartCaching;
end;

procedure TDocImageServer.StopBatch;
begin
 LinkServer(CurrentFamily)[atPublisheds].Table.StopCaching;
 LinkServer(CurrentFamily)[atPublisheds].Table.IgnoreDuplicates := f_MemorizedIgnoreDuplicated;
end;

function TDocImageServer.GetImageFileName(aSrcID : TDictID;
                          aSDate, aEDate : TStDate;
                          const aNumber : AnsiString;
                          aNonPeriodic : Boolean;
                          aDocID : TDocID = -1;
                          aImageFileType: TImgFileType = iftAutoDetect;
                          aImgSource: TImgSourceType = istAutoDetect): AnsiString;
var
 D1, M1, Y1,
 D2, M2, Y2 : Integer;
 l_TempName: AnsiString;
 l_TempNameCache: AnsiString;
 l_TempNameStorage: AnsiString;

 function GetDocIDStr : AnsiString;
 begin
  if aDocID >=0 then
   Result := Format('%d', [aDocID])
  else
   Result := '*';
 end;

begin
 Result := '';
 if aSrcID = 0 then
  Result := Format('@\[#%s]',[GetDocIDStr])
 else
  if aNonperiodic then
   Result := Format('%d\[%d] [#%s]',[aSrcID, aSrcID, GetDocIDStr])
  else
  begin
   Result := Format('%d\[%d]',[aSrcID, aSrcID]);

   if aSDate <> BlankDate then
   begin
    StDateToDMY(aSDate, D1, M1, Y1);
    If aSDate = aEDate then
     Result:= Result + Format(' %d_%d_%d', [D1, M1, Y1])
    else
    begin
     StDateToDMY(aEDate, D2, M2, Y2);
     if (Y1 = Y2) and (M1 = M2) and (D1 = 1) and (D2 = DaysInAMonth(Y1, M1)) then
      Result:= Result + Format(' %d_%d', [M1, Y1])
     else
      if (Y1 = Y2) and (M1 = 1) and (M2 = 12) and (D1 = 1) and (D2 = 31) then
       Result := Result + Format(' %d', [Y1])
      else
       Result := Result + Format(' %d_%d_%d-%d_%d_%d', [D1, M1, Y1, D2, M2, Y2]);
    end;
   end;
  end; //IsNonperiodic > 0

 if Length(aNumber) > 0 then Result := Result + Format(' #%S', [aNumber]);


 l_TempNameCache   := ConcatDirName(f_ImageCachePath, Result);
 l_TempNameStorage := ConcatDirName(f_ImageStoragePath, Result);

 case aImgSource of
  istAutoDetect, istCache : l_TempName := l_TempNameCache;
  istStorage              : l_TempName := l_TempNameStorage;
  istNoSource             : l_TempName := Result; // ��� ����������� ������������
 end;

 while True do
 begin
  case aImageFileType of
   iftAutoDetect:
    begin
     Assert(aImgSource <> istNoSource);
     Result := l_TempName + cTIFFImageExt;
     if not FileExists(Result) then
      Result := ChangeFileExt(Result, cImageContainerExt);
    end;
   iftTIFF     : Result := l_TempName + cTIFFImageExt;
   iftContainer: Result := l_TempName + cImageContainerExt;
  end;
  if (not FileExists(Result)) and (aImgSource = istAutoDetect) and (l_TempName = l_TempNameCache) then
   l_TempName := l_TempNameStorage
  else
   Break;
 end; // while
end;

function TDocImageServer.GetPublishDataRec(aDocId: TDocId; aDocSourceId: TDictId; var theRec: TPublishDataRec): Boolean;
var
 lRec : TdtRecord;
begin
 Result := False;

 lRec := DictServer(CurrentFamily).Tbl[da_dlPublisheds].GetRecordByUniq(aDocSourceId);
 if not lRec.WasFound then Exit;
 l3FillChar(theRec, SizeOf(theRec), 0);
 lRec.GetTo(@theRec);

 theRec.DocId := aDocId;

 lRec := DictServer(CurrentFamily).Tbl[da_dlCorSources].GetRecordByUniq(theRec.SourId);
 if not lRec.WasFound then Exit;

 lRec.GetCharArrayField(dtShNameFld, theRec.ShName);
 lRec.GetField(dtIsPrivate, theRec.IsPrivate);
 lRec.GetField(dtIsNonperiodic, theRec.IsNonperiodic);

 Result := True;
end;

function TDocImageServer.IsImageExists(const aRec : PPublishDataRec): boolean;
begin
 with aRec^ do
  Result := IsImageExists(SourID, SDate, EDate, l3ArrayToString(Num, SizeOf(Num)), (IsNonperiodic = 1), DocId);
end;

function TDocImageServer.IsImageExists(aSrcID : TDictID; aSDate, aEDate : TStDate; const aNumber : AnsiString; aNonPeriodic : Boolean; aDocID : TDocID = -1): boolean;
var
 l_FN: AnsiString;
begin
 l_FN := GetImageFileName(aSrcID, aSDate, aEDate, aNumber, aNonPeriodic, aDocID);
 Result := FileExists(l_FN);
end;


function IsTIFF(aFileName: AnsiString): Boolean;
var
 l_Ext: AnsiString;
begin
 l_Ext := Lowercase(ExtractFileExt(aFileName));
 Result := (l_Ext = '.tif') or (l_Ext = '.tiff');
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\Dt_DocImages.pas initialization enter'); {$EndIf}
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\DT\Dt_DocImages.pas initialization leave'); {$EndIf}
finalization
 FreeAndNil(gDocImageServer);
end.
