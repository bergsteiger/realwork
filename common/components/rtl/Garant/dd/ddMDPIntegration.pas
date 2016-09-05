unit ddMDPIntegration;

{ $Id: ddMDPIntegration.pas,v 1.83 2016/07/12 16:10:05 fireton Exp $ }

// $Log: ddMDPIntegration.pas,v $
// Revision 1.83  2016/07/12 16:10:05  fireton
// - ����������� ������
//
// Revision 1.82  2016/05/23 13:17:10  fireton
// - ������������� ������ � ������
//
// Revision 1.81  2016/05/11 06:47:15  fireton
// - merge
//
// Revision 1.80.2.1  2016/05/10 13:02:19  fireton
// - ��������� �� ������, ���� ��� ������������ ��������� �����
//
// Revision 1.80  2016/02/15 14:02:02  fireton
// - gardoc_hang + �����������
//
// Revision 1.79  2015/12/11 06:43:21  lukyanets
// �������� ��� �������
//
// Revision 1.78  2015/12/11 06:23:23  lukyanets
// �������� ��� �������
//
// Revision 1.77  2015/11/26 08:45:43  lukyanets
// ��������� ���������
//
// Revision 1.76  2015/10/19 18:18:28  lulin
// - �����������.
//
// Revision 1.75  2015/10/19 18:15:17  lulin
// - �����������.
//
// Revision 1.74  2015/10/09 13:02:25  lukyanets
// ����� � ��� �� ����� ����� ����������� ������
//
// Revision 1.73  2015/10/06 13:33:07  lukyanets
// ����� ������ ������������ �������
//
// Revision 1.72  2015/10/01 12:34:48  fireton
// - ���� �������� ������������� �� ����, � �� �� �����
//
// Revision 1.71  2015/09/09 13:27:51  lukyanets
// ��������� ������� ����������
//
// Revision 1.70  2015/08/27 11:01:52  fireton
// - ��������� �������� ������ ������ (����� � ini ��� ������� ��������� �������������)
//
// Revision 1.69  2015/07/02 07:36:05  lukyanets
// ��������� �������
//
// Revision 1.68  2015/07/01 10:18:44  fireton
// - ������������� ��������� � ����� �������� �����
//
// Revision 1.67  2015/06/04 12:25:26  fireton
// - ����� � ���, ���� ����������� ������ � ��� ������������� ���������
//
// Revision 1.66  2015/06/02 11:01:43  fireton
// - �������� ���������-�������� � ������ ������� "KART"
//
// Revision 1.65  2015/03/31 14:09:09  lukyanets
// �������� ����������� GlobalHTServer
//
// Revision 1.64  2015/01/27 08:42:04  fireton
// - ����������� �������� �������� ������ ��� �������
//
// Revision 1.63  2014/11/13 11:42:10  fireton
// - ����������� ����������� ���� MDP-��������������
//
// Revision 1.62  2014/11/11 09:51:09  fireton
// - ������� � ������ ��� �������
//
// Revision 1.61  2014/07/15 12:48:54  fireton
// - ����� ������������ ��������� ������
//
// Revision 1.60  2014/04/26 08:44:28  fireton
// - �� ����������
//
// Revision 1.59  2014/04/08 05:26:21  fireton
// - �� ����������
//
// Revision 1.58  2014/03/21 06:03:24  fireton
// - �� ����������
//
// Revision 1.57  2014/02/20 06:49:49  fireton
// - ���������� ������
//
// Revision 1.56  2014/02/11 07:11:47  fireton
// - �� ������� � ��� ���������� � ������ ������ ���������
//
// Revision 1.55  2013/11/29 09:54:45  fireton
// - �������� NSRC ��� ���������� (��� ��� ��� ����)
//
// Revision 1.54  2013/10/25 09:25:32  fireton
// - ��������� ��� ��������� � k2
//
// Revision 1.53  2013/09/23 09:03:18  fireton
// - ����� �� ������� � ��������� ����������
//
// Revision 1.52  2013/09/20 10:25:40  fireton
// - ������� � ��������� ���������
//
// Revision 1.51  2013/04/17 11:18:52  fireton
// - �� ����������
//
// Revision 1.50  2013/04/15 08:01:14  narry
// �� ����������
//
// Revision 1.49  2013/04/11 16:46:28  lulin
// - ���������� ��� XE3.
//
// Revision 1.48  2013/03/19 13:00:20  fireton
// - ������ � External Exception
//
// Revision 1.47  2013/03/15 08:40:40  fireton
// - ����� ����������
//
// Revision 1.46  2013/02/12 04:27:01  fireton
// - �� ����������
//
// Revision 1.45  2013/01/18 03:11:38  fireton
// - �� ����������
//
// Revision 1.44  2012/08/15 07:23:42  fireton
// - ��������� ���������� ���������� �� ������� � ��� MDP-�������
//
// Revision 1.43  2012/03/28 06:54:09  fireton
// - bug fix: ���� ��������� ����� ����� ��� ��������� ������� ����������
//
// Revision 1.42  2012/02/20 10:56:23  narry
// ��������� ����������
//
// Revision 1.41  2012/01/13 12:25:32  narry
// ������ �����������
//
// Revision 1.40  2012/01/13 12:04:53  fireton
// - ��������� ������� "��������" (K 321986237)
//
// Revision 1.39  2012/01/13 09:30:05  fireton
// - ��������� ������� ��������� �� ������ �� ������� FILE, �� � �� ���� (K 326776318)
//
// Revision 1.38  2012/01/12 08:13:05  narry
// ������� ��� �� ������ ��� ������������ (307790632)
//
// Revision 1.37  2011/12/26 07:04:15  fireton
// - ��� ���������� ������������� timestamp
// - ����� ��� "�����������" exceptions, ������� �� DoReport
//
// Revision 1.36  2011/12/26 05:23:16  narry
// ������� ��� �� ������ ��� ������������ (307790632)
//
// Revision 1.35  2011/12/23 12:35:12  fireton
// - ������ �������������� � ������ ������
//
// Revision 1.34  2011/12/23 04:18:03  fireton
// - ���������� Urgency � �������� ������ (� 317261251)
// - ������������� ������
//
// Revision 1.33  2011/12/21 09:29:21  narry
// ������ ������ � ���
//
// Revision 1.32  2011/12/21 09:20:06  fireton
// - ������� ������, ������� �� ������
//
// Revision 1.31  2011/12/15 13:00:46  narry
// ���������� �� ����� (319488062)
//
// Revision 1.30  2011/12/12 12:10:11  narry
// ������� �� ��������������� ����������
//
// Revision 1.29  2011/12/12 08:00:42  fireton
// - ���� ��������� ������ ������� �� ���� � ����, �� �������� ����������� ��� ������������
//
// Revision 1.28  2011/12/09 12:59:40  fireton
// - ��������� "��������" ��� � ��������� (316114798)
//
// Revision 1.27  2011/12/09 12:28:23  narry
// ��������� ��������� ������ ����� ��������� ������ ���������� (317265075)
//
// Revision 1.26  2011/12/09 10:40:17  narry
// ����������� ������ � MDP
//
// Revision 1.25  2011/12/09 10:26:09  narry
// ����������� ������ � MDP
//
// Revision 1.24  2011/12/09 09:33:10  fireton
// - ���� "�����" �������� ��� ���� � ����, �� �� ���������� (317263027)
//
// Revision 1.23  2011/12/08 14:05:48  fireton
// - �� ���������� ���� ������, ���� ����� ������ (315262237)
//
// Revision 1.22  2011/12/07 11:40:26  fireton
// - ��������� ����������� �� MDP � �������� (315261944)
//
// Revision 1.21  2011/12/06 15:17:37  fireton
// - ������
// - ������������ ������ ����� � �������� MDP
//
// Revision 1.20  2011/12/06 12:04:54  narry
// �������� ��������� (314215383)
//
// Revision 1.19  2011/12/06 09:59:39  narry
// ������� � ���� (314214467)
//
// Revision 1.18  2011/12/06 09:48:18  narry
// ������� � ���� (314214467)
//
// Revision 1.17  2011/12/05 12:25:24  fireton
// - ��������� ��� ��������� �� ��������� (� 313754761)
//
// Revision 1.16  2011/12/05 08:21:40  fireton
// - ��������� � �������� ������ �����
//
// Revision 1.15  2011/12/05 07:35:35  fireton
// - ��������� �������� �� nil ��� ������� (�� ��������� AV)
//
// Revision 1.14  2011/12/02 08:48:16  fireton
// - ����� �������� ����� � ��� ���� �����
//
// Revision 1.13  2011/12/02 08:03:35  fireton
// - ��������� ������ ���� ��� ������ ������� (K310675403)
//
// Revision 1.12  2011/11/30 10:10:55  fireton
// - ������� ��� �����
// - fix: timestamp �� ����������
//
// Revision 1.11  2011/11/29 06:29:38  fireton
// - ���������� ����� �����
//
// Revision 1.10  2011/11/28 11:31:14  fireton
// - ��������� "���" ��������� �� ���������
//
// Revision 1.9  2011/11/23 12:57:45  fireton
// - ������������ � ��������� ���������� �� MDP � ����
//
// Revision 1.8  2011/11/23 12:22:48  fireton
// - �������������� ���������� ���� ���������� ���������� � base.ini
//
// Revision 1.7  2011/11/16 13:18:33  narry
// ����������� � ��������� ����� ���������� (288786332)
//
// Revision 1.6  2011/11/15 12:15:33  fireton
// - OnResult (������������� ����� �� �������)
//
// Revision 1.5  2011/10/28 13:54:13  fireton
// - ���������� � ������ �������
//
// Revision 1.4  2011/10/28 13:25:30  fireton
// - update
//
// Revision 1.3  2011/07/28 12:13:37  fireton
// - ���������� mdp-�����
//
// Revision 1.2  2011/07/22 12:25:01  fireton
// - ���������
//
// Revision 1.1  2011/07/14 09:14:49  fireton
// - ���������� � MDP
//

{$IFDEF MDP_TEST}
 {$DEFINE MDP_TOFILE}
{$ENDIF}

interface
uses
 k2Reader,
 l3Base,
 l3Interfaces,

 l3ProtoObject,
 l3Except,
 l3CustomString,
 l3Date,
 l3DateSt,
 l3LingLib,
 l3Variant,
 l3ObjectRefList,
 l3IniFile,


 dt_Types,
 {$IFNDEF MDP_TEST}
 daTypes,
 dt_AttrSchema,
 dt_DictIntf,
 dt_Serv,

 m3DBInterfaces,
 {$ENDIF}

 k2Interfaces,
 k2TagGen,

 GarDocsUnit,

 evNestedDocumentEliminator,

 ddTypes,
 ddProgressObj,
 ddRTFReader,
 ddNSRC_r,

 dd_lcDocImageConverter;

const
 
 cMDPCfgSection       = 'MDP';
 cMDPLastTopUpdate    = 'LastTopUpdate';
 cMDPLastNormalUpdate = 'LastNormalUpdate';

type
 TddMDPDocBatchType = (btTop, btNormal);

 TddMDPImportResultObj = class(Tl3Base)
 protected
  function OCompare(anObject: Tl3Base): Integer; override;
 public
  rIsTop   : Boolean;
  rName    : AnsiString;
  rIsNew   : Boolean;
  rDocID   : TDocID;
  rComment : AnsiString;
  rUrgency : Byte;
 end;

 TddMDPImportResultEvent = procedure (const aResult: TddMDPImportResultObj) of object;

 TddMDPReader = class(Tk2CustomReader)
 private
  f_DocList:  IGardocList;
  f_IsCrashed: Boolean;
  f_IsDocumentBodyExists: Boolean;
  f_OnError: TddErrorEvent;
  f_OnResult: TddMDPImportResultEvent;
  f_Progressor: TddProgressObject;
  f_Result: TddMDPImportResultObj;
  f_Timestamp: TDateTime;
  f_RTFReader: TddRTFReader;
  f_NSRCReader: TCustomNSRCReader;
  f_ReadingTopDocs: Boolean;
  f_ResultList: Tl3ObjectRefList;
  f_Aborted: Boolean;
  procedure AddDateNumber(const aGDRec: TGardoc);
  procedure AddDocAttributes(const aGDRec: TGardoc);
  procedure AddRelAttributes(const aGDRec: TGardoc);
  procedure AddGroups(const aGDRec: TGardoc);
  procedure AddSources(const aGDRec: TGardoc);
  procedure AddToName(const aStr: Tl3WString; aNeedSpace: Boolean = True); overload;
  procedure AddToName(const aDate: TDateTime); overload;
  procedure AddToName(const aStr: AnsiString; aNeedSpace: Boolean = True); overload;
  procedure AddType(const aGDRec: TGardoc);
  function DocHasALabel(const aGDRec: TGardoc; const aLabel: AnsiString): Boolean;
  function DetectNSRInImages(aGDRec: TGardoc): Boolean;
  procedure DoReport(const aMsg: AnsiString);
  procedure DropResult;
  procedure FlushResults;
  procedure FormName(const aGDRec: TGardoc);
  function GetTheOnlyTextImageIndex(const aGDRec: TGardoc): Integer;
  procedure ImportDocuments(const aList: IGardocList);
  function IsMainImage(const aImg: TImage): Boolean;
  //function IsTextEmpty(aIntDocID: TDocID): Boolean;
  procedure MakeDocumentHeader(const aGDRec: TGardoc);
  procedure MakeDocumentFooter;
  procedure MakeRelated(const aGDRec: TGardoc);
  procedure TranslateImageToDoc(const aFilename: AnsiString; aType: TImageType);
  {$IFNDEF MDP_TEST}
  procedure WorkupImage(const aGDRec: TGardoc; aIntDocID: TDocID);
  {$ENDIF}
 protected
  function ConvertUrgency(const aUrgency: TGardocUrgency): Byte;
  procedure Read; override;
  procedure Cleanup; override;
 public
  constructor Create(anOwner: Tk2TagGeneratorOwner = nil); override;
  procedure AbortImport;
  property OnError: TddErrorEvent read f_OnError write f_OnError;
  property OnResult: TddMDPImportResultEvent read f_OnResult write f_OnResult;
  property DocList: IGardocList read f_DocList write f_DocList;
  property IsCrashed: Boolean read f_IsCrashed;
  property Progressor: TddProgressObject read f_Progressor write f_Progressor;
  property ReadingTopDocs: Boolean read f_ReadingTopDocs write f_ReadingTopDocs;
  property Timestamp: TDateTime read f_Timestamp write f_Timestamp;
 end;

 TddMDPImportBatchEvent = procedure (aBatch: TddMDPDocBatchType) of object;

 TddMDPImporter = class(Tl3ProtoObject)
 private
  f_OnError: TddErrorEvent;
  f_Aborted: Boolean;
  f_Reader: TddMDPReader;
  {$IFNDEF MDP_TEST}
  function DoOnDictUpdate(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID; aNameAttr: Tl3Tag): Boolean;
  {$ENDIF}
  procedure DoReport(const aMsg: AnsiString);
  procedure DoSaveTimestamp(const aIni: TCfgList; const aTimestamp: TDateTime; const aBatchType: TddMDPDocBatchType);
  function GetLastTimestamp(const aBatchType: TddMDPDocBatchType): TDateTime;
  {$IFNDEF MDP_TEST}
  procedure SaveLastTimestamp(const aTimestamp: TDateTime; const aBatchType: TddMDPDocBatchType);
  {$ENDIF}
 public
  procedure Import(AllowZeroRegion: Boolean;
                   aOnError: TddErrorEvent;
                   aOnResult: TddMDPImportResultEvent;
                   aBeforeBatch: TddMDPImportBatchEvent;
                   anAfterBatchSuccess: TddMDPImportBatchEvent;
                   aProgressor: TddProgressObject;
                   const aMaxCount: Integer);
  procedure AbortImport;
 published
  property OnError: TddErrorEvent read f_OnError write f_OnError;
 end;

 EMDPImportFatalError = class(El3Error);

implementation
uses
 SysUtils,
 DateUtils,
 ArchiAdapter,
 IOUnit,

 l3Const,
 l3IString,
 // - ��� �������� ����� ��������
 l3String,
 l3DateTimeBox,
 l3Stream,
 l3Filer,
 l3FileUtils,
 l3Types,
 l3Nodes,
 l3Tree_TLB,
 l3Bits,

 m2COMLib,

 k2Tags,
 Document_Const,
 DictItem_Const,
 NumAndDate_Const,
 TextPara_Const,

 daDataProvider,
 daSchemeConsts,

 DT_Const,
 {$IFNDEF MDP_TEST}
 DT_Doc,
 DT_DocImages,
 DT_LinkServ,
 Dt_ReNum,
 Dt_Dict,
 DT_Log,
 //ddMDPIntegrationTestData,
 {$ENDIF}

 {$IFDEF MDP_TOFILE}
 evdWriter,
 {$ENDIF}

 {$IFNDEF MDP_TEST}
 ddImportPipeKernel,
 {$ENDIF}

 StrUtils, Math, Classes;

const
 cVerboseMsgLevel = 1;
 c_MinDocSize     = 150;
 cSuccessEventStr = 'save_or_update';

resourcestring
 sNoDocIDRangeError        = '�� �������� �������� ��� ��������� ������� �������';
 sEmptyPublishNameError    = '������ ��� ��������� �������������';
 sPublishNameNotFoundError = '�������� ������������� �� ������: %s';

constructor TddMDPReader.Create(anOwner: Tk2TagGeneratorOwner = nil);
begin
 inherited;
 f_RTFReader := TddRTFReader.Create(nil);
 f_RTFReader.LiteVersion := False;
 f_NSRCReader := TCustomNSRCReader.Create(nil);
 f_NSRCReader.StrictFormat := False;
 f_ResultList := Tl3ObjectRefList.MakeSorted(l3_dupAccept);
end;

procedure TddMDPReader.AddDateNumber(const aGDRec: TGardoc);
var
 l_PubDate: TStDate;
 l_MUDate: TStDate;
 l_PubNum: Il3CString;
 l_MUNum: Il3CString;
begin
 // Dates and Nums
 l_PubNum := l3CStr(aGDRec.rNumber);
 l_PubDate := l3BoxToStDate(aGDRec.rDate);
 l_MUNum := l3CStr(aGDRec.rMuNumber);
 l_MUDate := l3BoxToStDate(aGDRec.rMuDate);
 if (not l3IsNil(l_PubNum)) or (l_PubDate <> 0) or (not l3IsNil(l_MUNum)) or (l_MUDate <> 0) then
 begin
  StartTag(k2_tiNumANDDates);
  try
   if (not l3IsNil(l_PubNum)) or (l_PubDate <> 0) then
   begin
    StartChild(k2_typNumAndDate);
    try
     AddIntegerAtom(k2_tiType, Ord(dnPublish));
     if not l3IsNil(l_PubNum) then
      AddStringAtom(k2_tiNumber, l_PubNum.AsWStr);
     if l_PubDate <> 0 then
      AddIntegerAtom(k2_tiStart, l_PubDate);
    finally
     Finish;
    end;
   end;

   if (not l3IsNil(l_MUNum)) or (l_MUDate <> 0) then
   begin
    StartChild(k2_typNumAndDate);
    try
     AddIntegerAtom(k2_tiType, Ord(dnMU));
     if not l3IsNil(l_MUNum) then
      AddStringAtom(k2_tiNumber, l_MUNum.AsWStr);
     if l_MUDate <> 0 then
      AddIntegerAtom(k2_tiStart, l_MUDate);
    finally
     Finish;
    end;
   end;
  finally
   Finish;
  end;
 end;
end;

procedure TddMDPReader.AddDocAttributes(const aGDRec: TGardoc);
var
 l_Status: Integer;
begin
 AddIntegerAtom(k2_tiExternalHandle, aGDRec.rTopic);
 if aGDRec.rRelated <> 0 then
  AddIntegerAtom(k2_tiRelExternalHandle, aGDRec.rRelated);
 AddStringAtom(k2_tiName, f_Result.rName);
 AddStringAtom(k2_tiNameComment, f_Result.rComment);
 AddInt64Atom(k2_tiMDPPageID, aGDRec.rConfluenceId);
 AddIntegerAtom(k2_tiUrgency, f_Result.rUrgency);

 l_Status := 0;
 if aGDRec.rIsInternet then
  l3SetMask(l_Status, dstatInternet);
 if DocHasALabel(aGDRec, 'GARDOC_HANG') then
  l3SetMask(l_Status, dstatHang);
 if l_Status <> 0 then 
  AddIntegerAtom(k2_tiPriceLevel, l_Status);
end;

procedure TddMDPReader.AddRelAttributes(const aGDRec: TGardoc);
begin
 AddIntegerAtom(k2_tiExternalHandle, aGDRec.rRelated);
 AddIntegerAtom(k2_tiType, Ord(dtRelText));
end;

procedure TddMDPReader.AddGroups(const aGDRec: TGardoc);
var
 J: Integer;
 l_Str: IString;
 l_IsCard : Boolean;
 
 l_CStr: Il3CString;
begin
 l_IsCard := DocHasALabel(aGDRec, 'GARDOC_KART'); // ��������, ��� ��������-������ �������� � �������� ������ ������� KART, ����� ���
 if l_IsCard then
 begin
  StartTag(k2_tiAccGroups);
  try
   StartChild(k2_typDictItem);
   try
    AddStringAtom(k2_tiShortName, 'KART');
   finally
    Finish; // k2_typDictItem
   end;
  finally
   Finish; // k2_tiAccGroups
  end;
 end;

 if aGDRec.rBlocks <> nil then
 begin
  if aGDRec.rBlocks.Count > 0 then
  begin
   StartTag(k2_tiGroups);
   try
    for J := 0 to aGDRec.rBlocks.Count - 1 do
    begin
     aGDRec.rBlocks.pm_GetItem(J, l_Str);
     try
      StartChild(k2_typDictItem);
      try
       AddStringAtom(k2_tiShortName, l3CStr(l_Str).AsWStr);
      finally
       Finish;
      end;
     finally
      l_Str := nil;
     end;
    end;
   finally
    Finish;
   end;
   if not l_IsCard then // ���� ��� �� ���������� ������ ������� KART
   begin
    // ��������� ������ ���� ��� ������ �������
    StartTag(k2_tiAccGroups);
    try
     aGDRec.rBlocks.pm_GetItem(0, l_Str);
     try
      StartChild(k2_typDictItem);
      try
       AddStringAtom(k2_tiShortName, l3CStr(l_Str).AsWStr);
      finally
       Finish;
      end;
     finally
      l_Str := nil;
     end;
    finally
     Finish;
    end;
   end; //  if not l_IsCard
  end;
 end;
end;

procedure TddMDPReader.AddSources(const aGDRec: TGardoc);
var
 J: Integer;
 l_Str: IString;
begin
 if aGDRec.rOgvList <> nil then
 begin
  if aGDRec.rOgvList.Count > 0 then
  begin
   StartTag(k2_tiSources);
   try
    for J := 0 to aGDrec.rOgvList.Count - 1 do
    begin
     aGDRec.rOgvList.pm_GetItem(J, l_Str);
     try
      StartChild(k2_typDictItem);
      try
       AddStringAtom(k2_tiName, l3CStr(l_Str).AsWStr);
      finally
       Finish;
      end;
     finally
      l_Str := nil;
     end;
    end;
   finally
    Finish;
   end;
  end;
 end;
end;

procedure TddMDPReader.AddToName(const aStr: Tl3WString; aNeedSpace: Boolean = True);
begin
 AddToName(l3Str(aStr), aNeedSpace);
end;

procedure TddMDPReader.AddToName(const aDate: TDateTime);
begin
 AddToName(l3DateToStr(aDate, 'dd mmmm yyyy �.'));
end;

procedure TddMDPReader.AddToName(const aStr: AnsiString; aNeedSpace: Boolean = True);
begin
 if aNeedSpace and (f_Result.rName <> '') then
  f_Result.rName := f_Result.rName + ' ';
 f_Result.rName := f_Result.rName + aStr;
end;

procedure TddMDPReader.AddType(const aGDRec: TGardoc);
begin
 StartTag(k2_tiTypes);
 try
  StartChild(k2_typDictItem);
  try
   AddStringAtom(k2_tiName, l3CStr(aGDRec.rType).AsWStr);
  finally
   Finish;
  end;
 finally
  Finish;
 end;
end;

procedure TddMDPReader.Cleanup;
begin
 FreeAndNil(f_RTFReader);
 FreeAndNil(f_NSRCReader);
 FreeAndNil(f_ResultList);
 inherited;
end;

function TddMDPReader.ConvertUrgency(const aUrgency: TGardocUrgency): Byte;
begin
 case aUrgency of
 	guInVersion: Result := 2;  // � ������
	 guQuickly  : Result := 1   // �������
 else
	{, guOrdinary // �������
	, guUnknown // ���������� }
  Result:= 0;
 end;
end;

function TddMDPReader.DetectNSRInImages(aGDRec: TGardoc): Boolean;
var
 I, J : Integer;
 l_Img: TImage;
 l_Str: IString;
 l_L3Str: Il3CString;
begin
 // ���� ����������, ���� �� NSRC ����� ������������ ������� � �������� �� �� �������
 Result := False;
 if aGDRec.rImages <> nil then
 begin
  for I := 0 to aGDRec.rImages.Count - 1 do
  begin
   aGDrec.rImages.pm_GetItem(I, l_Img);
   try
    if l_Img.rType = giNSR then
    begin
     Result := (aGDRec.rImages.Count = 1) or IsMainImage(l_Img);
     if Result then
      Break;
    end;
   finally
    Finalize(l_Img);
   end;
  end;
 end;
end;

procedure TddMDPReader.DoReport(const aMsg: AnsiString);
var
 l_ReportStr: AnsiString;
begin
 if f_Result <> nil then
  l_ReportStr := Format('%d: %s', [f_Result.rDocID, aMsg])
 else
  l_ReportStr := aMsg;
 if Assigned(f_OnError) then
  f_OnError(l_ReportStr)
 else
  l3System.Msg2Log(l_ReportStr);
end;

procedure TddMDPReader.DropResult;
begin
 f_Result:= TddMDPImportResultObj.Create;
end;

procedure TddMDPReader.FlushResults;
var
 I: Integer;
begin
 if Assigned(f_OnResult) then
 begin
  for I := 0 to f_ResultList.Count - 1 do
   f_OnResult(TddMDPImportResultObj(f_ResultList[I]));
 end;
 f_ResultList.Clear;
end;

procedure TddMDPReader.FormName(const aGDRec: TGardoc);
var
 J: Integer;
 l_Name: AnsiString;
 l_NameStr: Il3CString;
 l_PubDate: TDateTime;
 l_PubNum: Il3CString;
 l_Str: IString;
begin
 AddToName(l3CStr(aGDRec.rType).AsWStr);
 if aGDRec.rOgvList <> nil then
 begin
  for J := 0 to aGDRec.rOgvList.Count - 1 do
  begin
   if J > 0 then
    AddToName(',', False);
   aGDRec.rOgvList.pm_GetItem(J, l_Str);
   try
    l_Name := l3Str(l3GetSuffix(l3CStr(l_Str).AsWStr, '\'));
    l_Name := mlmaRusDeclensionStr(l_Name, rdRodit);
    AddToName(l_Name);
   finally
    l_Str := nil;
   end;
  end;
 end;
 l_PubDate := l3BoxToDateTime(aGDRec.rDate);
 if l_PubDate <> 0 then
 begin
  AddToName(l3PCharLen('��'));
  AddToName(l_PubDate);
 end;
 l_PubNum := l3CStr(aGDRec.rNumber);
 if not l3IsNil(l_PubNum) then
 begin
  AddToName(l3PCharLen('�'));
  AddToName(l_PubNum.AsWStr, False);
 end;
 l_NameStr := l3CStr(aGDRec.rTitle);
 if not l3IsNil(l_NameStr) then
  AddToName(l3Cat([l3CStr('"'), l_NameStr, l3CStr('"')]).AsWStr);
end;

procedure TddMDPReader.ImportDocuments(const aList: IGardocList);
var
 I: Integer;
 l_GD: TGardoc;
 l_IntTopic: TDocID;
 l_NeedCreateDoc: Boolean;
begin
 // ��� ������������. ����� � ���.
 l3System.Msg2Log('�������� %d ����������:', [aList.Count]);
 try
  for I := 0 to Pred(aList.Count) do
  begin
   if f_Aborted then
    Abort;
   aList.pm_GetItem(I, l_GD);
   try
    if l_GD.rTopic <> 0 then
    begin
     DropResult;
     try
      l3System.Msg2Log('%3d ID:%10d (K:%10d TS:%.2d.%.2d.%4d %.2d:%.2d:%.2d)',[
       Succ(I),
       l_GD.rTopic,
       l_GD.rConfluenceId,
       l_GD.rTimeStamp.rDay,
       l_GD.rTimestamp.rMounth,
       l_GD.rTimestamp.rYear,
       l_GD.rTimestamp.rHour,
       l_GD.rTimestamp.rMinute,
       l_GD.rTimestamp.rSecond
      ]);

      if l_GD.rTopic <> 0 then
      begin
      // DropResult;
       FormName(l_GD);
       f_Result.rComment := l3Str(l3CStr(l_GD.rComment));
       f_Result.rUrgency := ConvertUrgency(l_GD.rUrgency);
       f_Result.rIsTop := f_ReadingTopDocs;
       {$IFNDEF MDP_TEST}
       // ���� ��� - ����������, �� ���� ��������� ������� ������ � ����
       // ���� ������ ������ ���, �� ���� ��� ������� �������������
       if l_GD.rState = gsUPDATED then
       begin
        l_IntTopic := LinkServer(CurrentFamily).Renum.ConvertToRealNumber(l_GD.rTopic);
        if l_IntTopic > 0 then
        begin
         if not DocumentServer(CurrentFamily).CheckDocEx(l_IntTopic) then
          l_GD.rState := gsNEW;
        end
        else
         l_GD.rState := gsNEW;
       end;

       f_Result.rDocID := l_GD.rTopic;
       if l_GD.rState = gsNEW then
       begin
        l_IntTopic  := l_GD.rTopic;
        LinkServer(CurrentFamily).Renum.GetRNumber(l_IntTopic);
        // ���� "������" ��������� ��� � ���� ����...
        if not DocumentServer(CurrentFamily).CheckDocEx(l_IntTopic) then
        begin
         // �������
         MakeRelated(l_GD);
        end
        else
        begin
         // ���� ��������, ���������� ��� �����, ���� � ����...
         l_GD.rState := gsUPDATED; // - �� �������, � �� MDP ����� ������ ���������� ���������
         DoReport('�������� ��� ����������');
        end;
       end; // if l_GD.rState = gsNEW then
       {$ENDIF}

       f_Result.rIsNew := l_GD.rState = gsNEW;

       l_NeedCreateDoc := f_Result.rIsNew and (not DetectNSRInImages(l_GD));
       f_IsDocumentBodyExists := False;
       // ������������ ���������� �� �������
       if l_NeedCreateDoc then
        MakeDocumentHeader(l_GD);
       try
        {$IFNDEF MDP_TEST}
        WorkupImage(l_GD, l_IntTopic);
        {$ENDIF}
       finally
        if l_NeedCreateDoc then
         MakeDocumentFooter;
       end;
       f_TimeStamp := l3BoxToDateTime(l_GD.rTimestamp);
       (* �������� ���
       if not f_ReadingTopDocs then
        raise Exception.Create('TEST EXCEPTION');
       *)
      end // if l_GD.rTopic <> 0 then
      else
       DoReport('������������ ����� ���������');
      f_ResultList.Add(f_Result);
     finally
      FreeAndNil(f_Result);
     end;
    end; // l_GD.rTopic <> 0
   finally
    Finalize(l_GD);
   end;
   if Progressor <> nil then
    Progressor.ProcessUpdate(i);
  end; // for i;
  FlushResults;
 except
  on E: EAbort do
  begin
   DoReport('������ ' + IfThen(f_ReadingTopDocs, '�������', '�������') + ' �������!');
   l3System.Msg2Log('������ ' + IfThen(f_ReadingTopDocs, '�������', '�������') + ' �������!');
   f_IsCrashed := True;
  end;
  on E: Exception do
  begin
   DoReport('����������� ������ ��� ������� ' + IfThen(f_ReadingTopDocs, '�������', '�������') + ' ����������!');
   DoReport(E.Message);
   DoReport('��������� �� �������������. ����������� ��. � ����.');
   l3System.Exception2Log(E);
   f_IsCrashed := True;
  end;
 end;
end;

function TddMDPReader.IsMainImage(const aImg: TImage): Boolean;
var
 J: Integer;
 l_Str: IString;
 l_L3Str: Il3CString;
begin
 Result := False;
 if aImg.rLabels <> nil then
 begin
  for J := 0 to aImg.rLabels.Count-1 do
  begin
   aImg.rLabels.pm_GetItem(J, l_Str);
   try
    l_L3Str := l3CStr(l_Str);
    if l3Same(l_L3Str, 'gardoc_image_main', True) then
    begin
     Result := True;
     Exit;
    end;
   finally
    l_Str := nil;
   end;
  end;
 end;
end;

(*
function TddMDPReader.IsTextEmpty(aIntDocID: TDocID): Boolean;
var
 l_DB: Im3DB;
 l_Doc: Im3DBDocument;
 l_Stream: IStream;
 l_Pos: Int64;
begin
 Result := True;
 l_DB := dtGetDB(CurrentFamily);
 try
  l_Doc := l_DB.GetDocument(aIntDocID);
  try
   l_Stream := l_Doc.Open;
   Result := (l_Stream = nil);
   if not Result then
    Result := (m2COMGetSize(l_Stream) <= c_MinDocSize);
  finally
   l_Doc := nil;
  end;
 finally
  l_DB := nil;
 end;
end;
*)

procedure TddMDPReader.MakeDocumentHeader(const aGDRec: TGardoc);
begin
 l3System.Msg2Log(' �������� ���������...');
 StartChild(k2_typDocument);
 AddDocAttributes(aGDRec);
 // Type
 AddType(aGDRec);
 // Sources
 AddSources(aGDRec);
 // ����-������
 AddDateNumber(aGDRec);
 // Groups (belongs)
 AddGroups(aGDRec);
 l3System.Msg2Log('  ��������� �������');
end;

procedure TddMDPReader.MakeDocumentFooter;
begin
 if not f_IsDocumentBodyExists then
 begin
  // ���� �� ���������� ��������, �� ��������� ������ ��������
  StartChild(k2_typTextPara);
  Finish;
 end;
 Finish; // document
 l3System.Msg2Log(' �������� ������');
end;

procedure TddMDPReader.MakeRelated(const aGDRec: TGardoc);
begin
 if aGDRec.rRelated <> 0 then
 begin
  l3System.Msg2Log(' �������� �������...');
  StartChild(k2_typDocument);
  try
   AddRelAttributes(aGDRec);
   StartChild(k2_typTextPara);
   Finish;
  finally
   Finish; // document
  end;
  l3System.Msg2Log(' ������� �������');
 end;
end;

procedure TddMDPReader.Read;
begin
 f_IsCrashed := False;
 if f_DocList <> nil then
 begin
  if Progressor <> nil then
   Progressor.Start(f_DocList.Count, '�������� ����������');
  Start;
  try
   //l3System.Msg2Log('ImportDocuments...');
   ImportDocuments(f_DocList);
   //l3System.Msg2Log('...done');
  finally
   Finish;
  end;
  if Progressor <> nil then
   Progressor.Stop;
 end; // f_DocList <> nil
end;

procedure TddMDPReader.TranslateImageToDoc(const aFilename: AnsiString; aType: TImageType);
var
 l_Filer: Tl3DOSFiler;
 l_Stream: TStream;
begin
 l_Filer := Tl3DOSFiler.Make(aFilename, l3_fmRead, False);
 try
  l_Filer.Open;
  case aType of
   giDOC, giRTF:
    begin
     l3IStream2Stream(l_Filer as IStream, l_Stream);
     try
      ddTranslateImage(l_Stream, Self, f_RTFReader);
      f_IsDocumentBodyExists := True;
     finally
      FreeAndNil(l_Stream);
      f_RTFReader.Generator := nil;
     end;
    end;

   giNSR:
    begin
     f_NSRCReader.Generator := Self;
     f_NSRCReader.Filer := l_Filer;
     try
      f_NSRCReader.Read;
      f_IsDocumentBodyExists := True;
      f_NSRCReader.Filer := nil;
     finally
      f_NSRCReader.Generator := nil;
     end;
    end;
  end; // case
 finally
  FreeAndNil(l_Filer);
 end;
end;

{$IFNDEF MDP_TEST}
procedure TddMDPReader.WorkupImage(const aGDRec: TGardoc; aIntDocID: TDocID);
var
 J, l_Idx: Integer;
 l_DocTextEmpty: Boolean;
 l_Img: TImage;
 l_IsImageValidForText: Boolean;
 l_PDict: TDictionary;
 l_TempFN: AnsiString;
 l_Pages: AnsiString;
 l_Tr: Int64;
 l_Tw: Int64;
 l_StreamSize: Int64;
 l_IStream: IStream;
 l_L3Str: Il3CString;
 l_Node: Il3Node;
 l_PubSource: TDictID;
 l_WStr: Tl3WString;
 l_Str: IString;
 l_Log: TLogBookTbl;
 l_Num: AnsiString;
 l_OnlyTextImage: Integer;

const
 c_ImgTypeStr: array [TImageType] of string = ('ZIP','TIFF','DOC','RTF','NSR');
 c_ImgExtStr: array [TImageType] of string = ('.zip','.tif','.doc','.rtf','.nsr');

begin
 l3System.Msg2Log(' ��������� ������...');
 l_Log := LinkServer(CurrentFamily).LogBook;
 l_Log.Table.StartCaching;
 try
  if aGDRec.rImages <> nil then
  begin
   l_PDict := DictServer(CurrentFamily).Dict[da_dlCorSources];
   l3System.Msg2Log('  ���������� ������� ���������: %d', [aGDRec.rImages.Count]);
   l_OnlyTextImage := GetTheOnlyTextImageIndex(aGDRec);
   for J := 0 to aGDRec.rImages.Count - 1 do
   begin
    l_DocTextEmpty := (aGDRec.rState = gsNEW) and (not f_IsDocumentBodyExists); // or IsTextEmpty(aIntDocID); - ��������� � �������!
    aGDrec.rImages.pm_GetItem(J, l_Img);
    try
     l3System.Msg2Log('  ����� #%d (%s)', [J+1, c_ImgTypeStr[l_Img.rType]]);
     // ��� ������ �������� �������� �������������
     l_L3Str := l3CStr(l_Img.rSrcTitle);
     if not l3IsNil(l_L3Str) then
     begin
      l_WStr := l_L3Str.AsWStr;
      l_Node := l3SearchByPath(l_PDict.RootNode, l_WStr);
      if l_Node = nil then
       l_Node := l3SearchByName(l_PDict.RootNode, l_WStr);
      if l_Node <> nil then
      begin
       l_PubSource := (l_Node as IDictItem).Handle;
       l3System.Msg2Log('   �������� �������������: %s', [l3Str(l_L3Str)]);
      end
      else
      begin
       DoReport(Format(sPublishNameNotFoundError, [l3Str(l_L3Str)]));
       l3System.Msg2Log(Format(sPublishNameNotFoundError, [l3Str(l_L3Str)]), cVerboseMsgLevel);
       Continue;
      end;
     end
     else
     begin
      DoReport(sEmptyPublishNameError);
      l3System.Msg2Log(sEmptyPublishNameError, cVerboseMsgLevel);
      Continue;
     end;

     // ������ �������� ����� � ����, ������ ����� ��� ���������
     if l_Img.rData <> nil then
     begin
      l_TempFN := l3GetTempFileName('img');
      DeleteFile(l_TempFN);
      l_TempFN := ChangeFileExt(l_TempFN, c_ImgExtStr[l_Img.rType]);
      l_IStream := Tl3FileStream.Make(l_TempFN, l3_fmWrite);
      try
       l_StreamSize := MaxInt;
       l_Img.rData.CopyTo(l_IStream, l_StreamSize, l_Tr, l_Tw);
      finally
       l_IStream := nil;
      end;
      if l_Tr = 0 then
      begin
       // ���� ����� ������, �� �� ���� ���������� �����, � ���� ������ �������� published
       l3System.Msg2Log('����� ������, ����� �� ����� �������, ������ published', cVerboseMsgLevel);
       DeleteFile(l_TempFN);
       l_TempFN := '';
      end
      else
      begin
       // ����� �������� ��� �������������� ��� � ����� ��������� � ������:
       //  1. ��������� ����� ������������ ��������� � ������
       //  2. ��������� ����� ���� ������� ��� ������� (����� gardoc_image_main)
       l_IsImageValidForText := (J = l_OnlyTextImage) or IsMainImage(l_Img);
       if (l_Img.rType in [giDOC, giRTF, giNSR]) and l_DocTextEmpty and l_IsImageValidForText then
       begin
        l3System.Msg2Log('����������� ����� ������ � ����� ���������', cVerboseMsgLevel);
        TranslateImageToDoc(l_TempFN, l_Img.rType);
       end;
      end;
     end
     else                                                                       
     begin
      l_TempFN := '';
      l3System.Msg2Log('�������� ������ ������ (nil)', cVerboseMsgLevel);
      //DoReport('��������: ������ ����� ���������!');
     end;

     if DocImageServer <> nil then
     begin
      l_Pages := l3Str(l3CStr(l_Img.rSrcPage));
      l_Num := l3Str(l3CStr(l_Img.rSrcNumber));
      l3System.Msg2Log('   �����: %s     ���: %s', [l_Num, l_Pages]);
      l3System.Msg2Log('��������� ������ �� ������������� � ���� (� �����)', cVerboseMsgLevel);
      DocImageServer.Add(aIntDocID, l_TempFN, [l_PubSource], l_Pages,
                         l_Num, l3BoxToStDate(l_Img.rSrcDateStart),
                         l3BoxToStDate(l_Img.rSrcDateEnd), False);
      l_Log.PutLogRec(aIntDocID, acPublInWork);
      // ���� ������. ��� ������ �������� � ����, ���� ���� �������� �����. �� ��� ��� � evd ������ ��� ������� ����, ��
      // ��� ��� �� ��������� ��� ������� evd ������ ����� ������ �������... ��� ���� ����� � ����.
     end;
    finally
     Finalize(l_Img);
    end;
   end;
  end;
 finally
  l_Log.Table.StopCaching;
 end;
 l3System.Msg2Log(' ����� ���������');
end;
{$ENDIF}

procedure TddMDPImporter.AbortImport;
begin
 f_Aborted := True;
 if Assigned(f_Reader) then
  f_Reader.AbortImport;
end;

{$IFNDEF MDP_TEST}
function TddMDPImporter.DoOnDictUpdate(aDictType: TdaDictionaryType; aDocID, aSubID: TSubID; aNameAttr: Tl3Tag): Boolean;
var
 l_AttrName: AnsiString;
begin
 Result := False;
 l_AttrName := cAttrPassport[DLType2AttrID(aDictType)].rName;
 DoReport(Format('������: �� ������� �������� "%s"� ������� "%s"!', [aNameAttr.AsString, l_AttrName]));
end;
{$ENDIF}

procedure TddMDPImporter.DoReport(const aMsg: AnsiString);
begin
 if Assigned(OnError) then
  OnError(aMsg);
end;

procedure TddMDPImporter.DoSaveTimestamp(const aIni: TCfgList; const aTimestamp: TDateTime; const aBatchType:
 TddMDPDocBatchType);
begin
 case aBatchType of
  btTop    : aIni.WriteParamDateTime(cMDPLastTopUpdate, aTimeStamp);
  btNormal : aIni.WriteParamDateTime(cMDPLastNormalUpdate, aTimeStamp);
 end;
end;

function TddMDPImporter.GetLastTimestamp(const aBatchType: TddMDPDocBatchType): TDateTime;
var
 l_Ini: TCfgList;
begin
 {$IFNDEF MDP_TEST}
 l_Ini := TCfgList.Create(ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, 'base.ini'));
 try
  l_Ini.Section := cMDPCfgSection;
  case aBatchType of
   btTop   : Result := l_Ini.ReadParamDateTimeDef(cMDPLastTopUpdate, 0);
   btNormal: Result := l_Ini.ReadParamDateTimeDef(cMDPLastNormalUpdate, 0);
  end;
  if Result = 0 then
   DoSaveTimestamp(l_Ini, Now, aBatchType); // ������� ������� ���� � �����, ��������� �������� ����� ������������ � ���
 finally
  FreeAndNil(l_Ini);
 end;
{$ELSE}
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'Debug';
  Result :=  IncHour(Now, -l_Ini.ReadParamIntDef('HoursPrior', 1));
 finally
  FreeAndNil(l_Ini);
 end;
{$ENDIF}
end;

procedure TddMDPImporter.Import(AllowZeroRegion: Boolean;
                                aOnError: TddErrorEvent;
                                aOnResult: TddMDPImportResultEvent;
                                aBeforeBatch: TddMDPImportBatchEvent;
                                anAfterBatchSuccess: TddMDPImportBatchEvent;
                                aProgressor: TddProgressObject;
                                const aMaxCount: Integer);
var
 l_DateSt: AnsiString;
 {$IFDEF MDP_TOFILE}
 l_Pipe  : TevdNativeWriter;
 l_Filer : Tl3DosFiler;
 {$ELSE}
 l_Pipe  : TddImportPipeFilter;
 {$ENDIF}
 l_Timestamp: TDateTime;
 l_DLL: IArchiAdapterDll;
 l_Searcher: ISearcher2;
 l_Date: TDateTimeBox;
// l_Listener: IArchiEventsListener;
// l_SuccStr : IString;
 l_List: IGardocList;
 l_TStamp: TDateTime;
 l_NDE: TevNestedDocumentEliminator;
 l_Batch: TddMDPDocBatchType;
 l_MaxCount: Integer;
 l_Region: AnsiString;
 {$IFDEF MDP_EXACTDOC}
 l_TopicList: ILongList;
 l_Getter   : IGardocGetter;
 {$ENDIF}

const
 c_BatchType: array[TddMDPDocBatchType] of AnsiString = ('�������','�������');

begin
 //l3System.Msg2Log('TArchiAdapterDll.Make...');
 l_DLL := TArchiAdapterDll.Make;
 //l3System.Msg2Log('...done');
 try
  if l_DLL <> nil then
  begin
   //l3System.Msg2Log('l_DLL.GetSearcher...');
   l_Searcher := l_DLL.GetSearcher2;
   //l3System.Msg2Log('...done');
   //l3System.Msg2Log('l_DLL.GetArchiEventsListener...');
//   l_Listener := l_DLL.GetArchiEventsListener;
   //l3System.Msg2Log('...done');
//  l_SuccStr := l_DLL.MakeString(cSuccessEventStr);
   try
    if l_Searcher <> nil then
    begin
     l_MaxCount := aMaxCount;
     {$IFNDEF MDP_TEST}
     l_Region := IntToStr(GlobalDataProvider.RegionID);
     if (l_Region = '0') and not AllowZeroRegion then
      raise Exception.Create('������ ������������� ��������� �� ������ ��� �������� �������'); 
     {$ELSE}
     l_Region := '0';
     {$ENDIF}
     for l_Batch := btTop to btNormal do
     begin
      if f_Aborted then
       Abort;
      if l_MaxCount > 0 then
      begin
       if Assigned(aBeforeBatch) then
        aBeforeBatch(l_Batch);
       l_TStamp := GetLastTimestamp(l_Batch);
       if l_TStamp = 0 then
        Continue; // ���� �� ����, ������ ����������� �������, ������ ����� ��� (���� �� ��� ��������� �� ��������� ������������)
       l3DateTimeToBox(l_TStamp, l_Date);
       try
        with l_Date do
         l3System.Msg2Log('������������� %s ���������� (��� ������� %s) � MDP � %s',
                          [c_BatchType[l_Batch], l_Region, Format('%.2d.%.2d.%4d %.2d:%.2d', [rDay, rMounth, rYear, rHour, rMinute])]);

        {$IFDEF MDP_EXACTDOC}
        if l_Batch = btTop then
        begin
         l_Getter := l_DLL.GetGardocGetter;
         try
          l_TopicList := l_DLL.MakeLongList;
          try
           l_TopicList.Add(46350046); // �����, ������� ����� ��������
           l_Getter.GardocsByTopicList(l_TopicList, l_List);
          finally
           l_TopicList := nil;
          end;
         finally
          l_Getter := nil;
         end;
        end
        else
         l_List := nil;
        {$ELSE}
        //l3System.Msg2Log('l_Searcher.GetRecentlyCreatedSince...');
        case l_Batch of
         btTop   : l_Searcher.GetTopCreatedSince(l_Date, l_MaxCount, PAnsiChar(l_Region), l_List);
         btNormal: l_Searcher.GetNotopCreatedSince(l_Date, l_MaxCount, PAnsiChar(l_Region), l_List);
        end;
        //l3System.Msg2Log('...done');
        {$ENDIF}

        try
         if f_Aborted then
          Abort;

         if (l_List <> nil) and (l_List.Count > 0) then
         begin
          f_Reader := TddMDPReader.Create;
          try
           f_Reader.Timestamp := l_TStamp;
           f_Reader.DocList:= l_List;
           f_Reader.OnError := aOnError;
           f_Reader.OnResult := aOnResult;
           f_Reader.Progressor:= aProgressor;
           f_Reader.ReadingTopDocs := (l_Batch = btTop);
           {$IFDEF MDP_TOFILE}
           l_Pipe := TevdNativeWriter.Create;
           l_Filer := Tl3DOSFiler.Make('mdp_import.evd', l3_fmWrite);
           try
            l_Pipe.Filer := l_Filer;
           finally
            FreeAndNil(l_Filer);
           end;
           {$ELSE}
           l_Pipe := TddImportPipeFilter.Create(CurrentFamily);
           l_Pipe.OnDictionaryUpdate := DoOnDictUpdate;
           {$ENDIF}
           try
            l_NDE := TevNestedDocumentEliminator.Create;
            try
             f_Reader.Generator := l_NDE;
             l_NDE.Generator := l_Pipe;
             try
              f_Reader.Execute;
             except
              on E: EMDPImportFatalError do
               l3System.Exception2Log(E);
             end;
             if not f_Reader.IsCrashed then
             begin
              {$IFNDEF MDP_TEST}
              SaveLastTimestamp(f_Reader.Timestamp, l_Batch);
              {$ENDIF}
              l_MaxCount := l_MaxCount - l_List.Count;
              l3System.Msg2Log('��������� ������������� %s ���������� � MDP � %s', [c_BatchType[l_Batch], DateTimeToStr(f_Reader.Timestamp)]);
              if Assigned(anAfterBatchSuccess) then
               anAfterBatchSuccess(l_Batch);
             end;
            finally
             FreeAndNil(l_NDE);
            end;
           finally
            FreeAndNil(l_Pipe);
           end;
          finally
           FreeAndNil(f_Reader);
          end;
         end // l_List.Count > 0
         else
          l3System.Msg2Log('���������� ���');
        finally
         l_List := nil;
        end;
        l3System.Msg2Log('������������� ���������');
       except
        on E: EAbort do
        begin
         DoReport('������ ' + c_BatchType[l_Batch] + ' �������!');
         l3System.Msg2Log('������ ' + c_BatchType[l_Batch] + ' �������!');
        end;
        on ECommunicationFailure do
         DoReport('������ ����� � �������� MDP');
        on  ECantFindServer do
         DoReport('�� ������ ������ MDP');
       end; // try
      end; // if l_MaxCount > 0
     end; // for l_Batch := btTop to btNormal do
    end;
   finally
   end;
  end;
 finally
  l_DLL := nil;
 end;
end;

{$IFNDEF MDP_TEST}
procedure TddMDPImporter.SaveLastTimestamp(const aTimestamp: TDateTime; const aBatchType: TddMDPDocBatchType);
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create(ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, 'base.ini'));
 try
  l_Ini.Section := cMDPCfgSection;
  DoSaveTimestamp(l_Ini, aTimestamp, aBatchType);
 finally
  FreeAndNil(l_Ini);
 end;
end;
{$ENDIF}

function TddMDPImportResultObj.OCompare(anObject: Tl3Base): Integer;
begin
(*
  rName    : AnsiString;
  rIsNew   : Boolean;
  rDocID   : TDocID;
  rComment : AnsiString;
  rUrgency : Byte;
*)
 (*
 if rUrgency < TddMDPImportResultObj(anObject).rUrgency then
  Result:= 1
 else
 if rUrgency > TddMDPImportResultObj(anObject).rUrgency then
  Result:= -1
 else
 *)
 if rIsTop <> TddMDPImportResultObj(anObject).rIsTop then
  Result:= IfThen(rIsTop, -1, 1)
 else
 if rIsNew <> TddMDPImportResultObj(anObject).rIsNew then
  Result:= IfThen(rIsNew, 1, -1)
 else
  Result:= AnsiCompareText(rComment, TddMDPImportResultObj(anObject).rComment);
end;

procedure TddMDPReader.AbortImport;
begin
 f_Aborted := True;
end;

function TddMDPReader.DocHasALabel(const aGDRec: TGardoc; const aLabel: AnsiString): Boolean;
var
 I, J: Integer;
 l_Img: TImage;
 l_IStr: IString;
 l_Str: Il3CString;
begin
 Result := False;
 if aGDRec.rImages <> nil then
  for I := 0 to aGDRec.rImages.Count - 1 do
  begin
   aGDRec.rImages.pm_GetItem(I, l_Img);
   try
    if l_Img.rLabels <> nil then
     for J := 0 to l_Img.rLabels.Count - 1 do
     begin
      l_Img.rLabels.pm_GetItem(J, l_IStr);
      try
       l_Str := l3CStr(l_IStr);
       Result := l3Same(aLabel, l_Str, True);
       if Result then
        Break;
      finally
       l_IStr := nil;
      end;
     end;
   finally
    Finalize(l_Img);
   end;
   if Result then
    Break;
  end;
end;

function TddMDPReader.GetTheOnlyTextImageIndex(const aGDRec: TGardoc): Integer;
var
 I: Integer;
 l_Img: TImage;
begin
 // ���������� ������ ������������� ���������� ������ � ������ �������. ���� ������ ��� ���
 // ��������� ������� ���������, �� ���������� -1.
 Result := -1;
 for I := 0 to aGDRec.rImages.Count - 1 do
 begin
  aGDrec.rImages.pm_GetItem(I, l_Img);
  if l_Img.rType in [giDOC, giRTF, giNSR] then
  begin
   if Result < 0 then
    Result := I // ������ ������ ��������� �����
   else
   begin
    // ��� ��� �� ������ ��������� �����, ��������
    Result := -1;
    Break;
   end;
  end;
 end;
end;

end.
