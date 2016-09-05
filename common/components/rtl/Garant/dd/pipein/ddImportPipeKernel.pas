//..........................................................................................................................................................................................................................................................
unit ddImportPipeKernel;
{ ���������� ����� �����, ������� ������ �� ����� � ������� ������. }
{ ������ 12.05.2003 }

{ $Id: ddImportPipeKernel.pas,v 1.104 2016/06/16 05:40:08 lukyanets Exp $ }

// $Log: ddImportPipeKernel.pas,v $
// Revision 1.104  2016/06/16 05:40:08  lukyanets
// ������������ UserManager �� ����� ������
//
// Revision 1.103  2015/11/25 14:01:49  lukyanets
// ��������� ��� ������ �������+������� ��������
//
// Revision 1.102  2015/11/17 13:47:04  fireton
// - ���������� ����������� TddNullDocFilter
//
// Revision 1.101  2015/11/11 13:16:46  fireton
// - ���������� ����������� ������ ��� ��������
// - ������� ������ ���������, ������� � ��������� ���������
//
// Revision 1.100  2015/07/02 07:36:08  lukyanets
// ��������� �������
//
// Revision 1.99  2015/05/20 14:02:23  lulin
// - ������ �� ������.
//
// Revision 1.98  2015/05/19 13:23:23  lulin
// - ������ �� ������.
//
// Revision 1.97  2015/04/07 07:37:08  lukyanets
// ��������� HT
//
// Revision 1.96  2014/10/08 13:25:25  voba
//  k:565492100
//
// Revision 1.95  2014/10/03 11:25:56  dinishev
// �������� �������� anExclusive �� �������� ������� ���������.
//
// Revision 1.94  2014/08/06 14:21:03  voba
// - rename _Tm3DBFiler.Index -> _Tm3DBFiler.ObjectIndex
//
// Revision 1.93  2014/04/21 11:09:49  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.92  2014/04/07 06:53:37  dinishev
// Bug fix: �� ��������������� �������.
//
// Revision 1.91  2014/03/20 14:18:38  voba
//  k:236721575 (�������� � EVD)
//
// Revision 1.90  2014/02/28 14:54:31  lulin
// - ������������� ����������.
//
// Revision 1.89  2013/12/03 09:55:05  voba
// - ���������� �� ������������ ����������
//
// Revision 1.88  2013/10/30 10:36:38  voba
// - ����� �� fSrchList
//
// Revision 1.87  2013/10/21 15:43:18  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.86  2013/10/21 10:31:06  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.85  2013/10/18 15:39:02  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.84  2013/05/17 15:56:58  voba
// - K:455105818
//
// Revision 1.83  2013/04/26 10:21:32  fireton
// - "�������� ������" ��� �������� �������
//
// Revision 1.82  2013/04/11 17:15:27  lulin
// - ���������� ��� XE3.
//
// Revision 1.81  2013/04/11 16:46:46  lulin
// - ���������� ��� XE3.
//
// Revision 1.80  2013/03/26 09:16:49  narry
// ��������� �������
//
// Revision 1.79  2013/02/15 12:21:56  narry
// ������������� ��������� ��������� (430743967)
//
// Revision 1.78  2012/10/02 08:12:25  narry
// ����������
//
// Revision 1.77  2011/11/07 09:07:49  narry
// �� �������� ������ ���������� (296632243)
//
// Revision 1.76  2011/11/07 06:57:54  narry
// ���������� ������� TddNullDocFilter
//
// Revision 1.75  2011/10/13 08:43:35  narry
// ������������ ���������
//
// Revision 1.74  2011/04/21 08:20:11  narry
// - ������� �����
//
// Revision 1.73  2011/04/18 13:44:49  voba
// - k : 236721575
//
// Revision 1.72  2010/09/24 12:10:50  voba
// - k : 235046326
//
// Revision 1.71  2010/09/21 11:06:52  fireton
// - ��������� ������� � PAnsiChar �� Tl3WString
//
// Revision 1.70  2010/03/10 13:57:26  narry
// - �� ����������
//
// Revision 1.69  2009/12/02 08:31:05  fireton
// - �������������� �������� ����������
//
// Revision 1.68  2009/07/31 11:34:52  narry
// - ������������� ����������
//
// Revision 1.67  2009/06/23 07:33:41  voba
// - �������������� ������� � ���������
//
// Revision 1.66  2009/04/13 07:12:59  narry
// - ���������� ����������� ����� � ����������
//
// Revision 1.65  2009/03/23 08:29:06  lulin
// - ��������� ����, ����� ��� ����� �� ����� �� ����� � ��� �� �����.
//
// Revision 1.64  2009/03/13 15:14:28  narry
// - ��������� ������ � ���� ���������� �� �������� ����� � ����������
//
// Revision 1.63  2009/03/04 16:25:58  lulin
// - <K>: 137470629. Bug fix: �� ��������� ����������.
//
// Revision 1.62  2009/01/14 14:06:50  narry
// - ������
//
// Revision 1.61  2008/09/24 12:42:24  fireton
// - bugfix: ���� �������� ������� �������
//
// Revision 1.60  2008/09/23 12:17:52  fireton
// - ������/������� ������ ��������� ����
//
// Revision 1.59  2008/09/04 08:39:37  narry
// - ����������
//
// Revision 1.58  2008/09/04 08:27:34  narry
// - �����������
//
// Revision 1.57  2008/09/03 13:03:53  narry
// - ��������� ��� �������������� ������������� �������������
//
// Revision 1.56  2008/06/10 14:02:03  narry
// - ������� ���������� � InternalHandle = 0
//
// Revision 1.55  2008/06/06 12:00:04  fireton
// - ��������� �������� ��������� � ������� ID
//
// Revision 1.54  2008/05/29 09:14:33  fireton
// - ���� ������ ��� ������, �� ��� ���� ���-�� ������� (������ � �������� ���������)
//
// Revision 1.53  2008/05/14 12:59:03  fireton
// - binary = true (� ����� ������� ���� false - ����� �����������)
//
// Revision 1.52  2008/05/14 11:28:50  narry
// - ����������
//
// Revision 1.51  2008/05/08 14:04:10  fireton
// - ������� �������� � ������� �� �����
//
// Revision 1.50  2008/04/30 06:33:27  voba
// - add property FastAddAttr
//
// Revision 1.49  2008/04/17 14:49:43  narry
// - � ����������� ������ ����� ������ � ���� ���������
//
// Revision 1.48  2008/03/20 09:48:31  lulin
// - cleanup.
//
// Revision 1.47  2008/02/19 16:01:03  narry
// - ����������� �� �������� ������ � �������
//
// Revision 1.46  2007/08/09 18:05:23  lulin
// - ����������� �� ��������� ������������� �����������, �.�. ������������� ����� ���� ���������� ������� ��������.
//
// Revision 1.45  2007/08/09 17:17:07  lulin
// - bug fix: �� ��������� ����������.
//
// Revision 1.44  2007/08/09 11:19:19  lulin
// - cleanup.
//
// Revision 1.43  2007/07/19 07:50:27  voba
// no message
//
// Revision 1.42  2007/03/22 14:32:52  voba
// - ren NeedLockBase to ExclusiveMode
//
// Revision 1.41  2007/03/21 11:59:28  narry
// - �� ������� ������ "��������� �������"
//
// Revision 1.40  2006/12/05 13:50:19  voba
// - refactoring
//
// Revision 1.39  2006/12/01 11:40:01  voba
// - add TddInfoUnitFilter
// - cc
//
// Revision 1.38  2006/10/04 08:26:25  voba
// - ����� ������ �������
// - add NeedLockBase
// - add ����������� modified � deleted ������ � m3DB
//
// Revision 1.37  2006/08/24 08:38:47  voba
// - ����� ������������� �����
//
// Revision 1.36  2006/07/14 14:14:50  voba
// - imp ������� Tl3PVList �� _Tl3LongintList
//
// Revision 1.35  2006/05/26 09:46:13  narry
// - �����������: ������ �� ����������� �������� �������� ����������
//
// Revision 1.34  2006/03/27 13:20:07  lulin
// - cleanup.
//
// Revision 1.33  2006/03/07 12:27:36  narry
// - ���������: ����� ���������� �������� �������
//
// Revision 1.32  2006/02/14 08:40:14  voba
// - rename
//  Tm3DocumentStream   -> Tm3DocPartSelector
//  Tm3DocumentStreams  -> Tm3DocPartSet
//  m3_defDocStream     -> m3_defDocPart
//  m3_AllDocStreams    -> m3_AllDocParts
//
// Revision 1.31  2006/02/06 14:56:59  narry
// - ��������� ����������
//
// Revision 1.30  2006/01/26 12:57:46  narry
// - ������ ����: ����� ��� �� ������ ������ � �������������� ����
//
// Revision 1.29  2005/12/02 14:34:38  narry
// - ������: ����������� ������ hasAnno
//
// Revision 1.28  2005/11/09 16:34:29  narry
// - ����������
//
// Revision 1.27  2005/10/18 09:06:47  lulin
// - ����������, �� ��� �� ��������������� � ����� � ��������� �������.
//
// Revision 1.26  2005/07/25 13:07:20  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.25  2005/07/14 15:50:39  narry
// - update
//
// Revision 1.24  2005/03/28 11:32:20  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.23  2005/03/21 10:04:58  lulin
// - new interface: _Ik2Type.
//
// Revision 1.22  2005/03/16 14:44:59  narry
// - cleanup & update
//
// Revision 1.21  2005/03/02 16:28:17  narry
// - �����������: ��������� ���������
//
// Revision 1.20  2005/02/25 16:21:23  narry
// - update: ��������� ���������
//
// Revision 1.19  2005/02/24 15:24:52  narry
// - update
//
// Revision 1.18  2005/02/16 17:11:12  narry
// - update: ��������� ���������
//
// Revision 1.17  2004/09/21 12:21:10  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.16  2004/09/14 12:26:38  narry
// - update: ���������� ����������� ������ ���������
// - update: ���������� ������ ������� � ����� 0
//
// Revision 1.15  2004/09/01 13:36:18  narry
// - update: ������ ������ ������ �� ���� � ���������
//
// Revision 1.14  2004/08/30 10:58:58  law
// - remove class: TmgBasePackageTagFilter.
// - new unit: m3DocumentInfoFilter.
//
// Revision 1.13  2004/06/02 16:24:53  narry
// - update: ��������� � �������� ������
//
// Revision 1.12  2004/05/17 09:36:55  narry
// - update:
//
// Revision 1.11  2004/05/07 12:28:10  narry
// - update: ���������� ���������� � �������� � ��������� ���������
//
// Revision 1.10  2004/02/24 14:40:03  narry
// - update
//
// Revision 1.9  2004/01/08 12:45:57  narry
// - cleanup: �������������� ������� � �����
//
// Revision 1.8  2003/12/29 12:09:37  narry
// - bug fix
//
// Revision 1.7  2003/12/23 17:03:02  narry
// - update
//
// Revision 1.6  2003/12/19 12:12:31  narry
// - update
//
// Revision 1.5  2003/12/17 11:53:16  narry
// - add: ���������� ������ ���������� ��������� �� ������ - ������������ ������ ������� "�������� � �������"
//
// Revision 1.4  2003/09/15 14:28:45  narry
// - update
//
// Revision 1.3  2003/09/03 07:25:48  narry
// - update: ��������� ���������� ��������
//
// Revision 1.2  2003/08/29 13:15:17  narry
// - update
//
// Revision 1.1  2003/05/28 11:55:22  narry
// - ����� ��������� ����� ��� �������
//


{.$DEFINE Bilingual}
{.$DEFINE MemTrap}
interface

Uses
 evHndFlt, evdWriter,
 l3Variant,
 l3Base, l3Types, l3Filer, l3Date,
 k2Interfaces,
 k2TagGen, k2TagFilter, k2Types,

 k2Base,

 daTypes,
 dt_IFltr,
 dt_Types, dt_Const, dt_AttrSchema,
 DT_TblCacheDef,
 m3DB, m3DocumentInfoFilter, m3DBInterfaces,
 ddPipeTypes, ddFixFilter, ddExtObjectSupport;

type
  TddImportFixFilter = class(Tk2TagFilter)
  { - ����������� ������ �������
    - ��������� "�������������" ������ �� ��������� ��������, ���� �� ���� �� �����
    - ������������ ����� ������ � ������ ������� � ������� ���� IsEnglish
    - �������� ������ ������� �� ENG (��� ���������) ���� f_IsEnglish
    - �������� @ �� [�������� �� ��������] }
  private
   FDocumentTypeID: LongInt;
   f_TopicNo: Longint;
   f_IsEnglish: Boolean;
   f_OnStartTopic: TddTopicEvent;

   f_HasActiveInterval: Boolean;
   f_HasAccGroups: Boolean;
   f_HaveMailed: Boolean;
   procedure CorrectPublished(var aValue: Tk2Variant);
  protected
   procedure AddActiveInterval;
   procedure AddAccGroups;

   procedure DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant); override;
   procedure DoStartChild(TypeID: Tk2Type); override;
   procedure DoStartTag(TagID: Long); override;

   procedure DoCloseStructure(NeedUndo: Bool); override;
    {internal methods}
   procedure OpenStream; override;

  public
   property DocumentTypeID: LongInt
    read FDocumentTypeID;
   property IsEnglish: Boolean
    read f_IsEnglish
    write f_IsEnglish;
   property TopicNo: Longint
    read f_TopicNo;
   property OnTopicStart: TddTopicEvent
    read f_OnStartTopic
    write f_OnStartTopic;
  end;


 TddUpdateDictionaryEvent = function (aDictType: TdaDictionaryType; aDocID, aSubID: TSubID;
                                      aNameAttr: Tl3Tag): Boolean of object;

  TddImportPipeFilter = class(Tk2TagFilter)
  private
   f_m3DB : Im3DB;
   FUpdateTables: Boolean;
   f_BaseFiler: Tl3CustomFiler;
   f_Filer: Tl3CustomFiler;
   f_BaseGen: TImportFilter;
   f_CheckRegion: Boolean;
   f_CustomID: Longint;
   f_EvWriter: Tk2TagGenerator;
   f_Handle: Tm3DBStreamIndex;
   f_OnDictionaryUpdate: TddUpdateDictionaryEvent;
   f_OnDocumentReaction: TSameDocReactFunc;
   f_OnGetDeleteCondition: TGetDeleteConditionEvent;
   f_Gen: Tk2TagGenerator;
   f_ImportFilter: TImportFilter;
   f_TopicFilter: TddImportFixFilter;
   f_UpdateDictionary: Boolean;
  private
   function GenerateID(Sender: TObject): Tm3DBStreamIndex;
   function GetCheckDocuments: Boolean;
   //function GetCloseStages: Boolean;
   function GetDeleteCondition: TDeleteConditionSet;
   function GetDocumentReaction: TSameDocReact;
   function GetFamily: TdaFamilyID;
   function GetInternalFormat: Boolean;
   function GetIsEnglish: Boolean;
   function GetOnSkipDocument: TSkipDocNotify;
   function GetOnStartTopic: TddTopicEvent;
   function GetUserID: Long;
   procedure StartTopic(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
   function pm_GetAddNewToLog: Boolean;
   function pm_GetNeedFork: Boolean;
    procedure pm_SetAddNewToLog(const aValue: Boolean);
   procedure pm_SetNeedFork(const aValue: Boolean);
   procedure SetCheckDocuments(const Value: Boolean);
   procedure SetNeedLockBase(const Value: Boolean);
   //procedure SetCloseStages(const Value: Boolean);
   procedure SetDeleteCondition(const Value: TDeleteConditionSet);
   procedure SetDocumentReaction(const Value: TSameDocReact);
   procedure SetFamily(aValue: TdaFamilyID);
   procedure SetInternalFormat(const Value: Boolean);
   procedure SetIsEnglish(const Value: Boolean);
   procedure SetOnSkipDocument(const Value: TSkipDocNotify);
   procedure SetOnStartTopic(const Value: TddTopicEvent);
   procedure SetUpdateTables(const Value: Boolean);
   procedure SetUserID(const Value: Long);
   procedure FinishTopic(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
   function _OnDocumentReaction(aDocID : TDocID) : TSameDocReact;
   function _OnGetDeleteCondition(aDocID : TDocID): TDeleteConditionSet;
   function _UpdateDicts(aDictType: TdaDictionaryType; aSubID: TSubID;
                         aNameAttr: Tl3Tag): Boolean;
  protected
   procedure Cleanup; override;
   procedure CloseStream(NeedUndo : Boolean); override;
  public
   constructor Create(aFamily: Integer; anOwner: Tk2TagGeneratorOwner = nil; anExclusive: Boolean = False);
       reintroduce; virtual;
   procedure evntOnEraseAttrRecords(aAttrType : TCacheType; aDictID : TDictID; aDocID : TDocID; aSubID : TSubID);
    {public methods}
   class function SetTo(var theGenerator: Tk2TagGenerator; aFamily: Integer): Tk2TagGenerator;
       overload;
  public
   property BaseGenerator: TImportFilter read f_BaseGen;
   property CheckDocuments: Boolean
    read GetCheckDocuments
    write SetCheckDocuments;
   property CheckRegion: Boolean
    read f_CheckRegion
    write f_CheckRegion;
   property NeedLockBase: Boolean
    ///read f_NeedLockBase
    write SetNeedLockBase;
   property DeleteConditions: TDeleteConditionSet
    read GetDeleteCondition
    write SetDeleteCondition;
   property DocumentReaction: TSameDocReact
    read GetDocumentReaction
    write SetDocumentReaction;
   property Family: TdaFamilyID
    read GetFamily
    write SetFamily;
   property InternalFormat: Boolean
    read GetInternalFormat
    write SetInternalFormat;
   property IsEnglish: Boolean
    read GetIsEnglish
    write SetIsEnglish;
   property OnDictionaryUpdate: TddUpdateDictionaryEvent
    read f_OnDictionaryUpdate
    write f_OnDictionaryUpdate;
   property OnDocumentReaction: TSameDocReactFunc
    read f_OnDocumentReaction
    write f_OnDocumentREaction;
   property OnGetDeleteCondition : TGetDeleteConditionEvent
    read f_OnGetDeleteCondition
    write f_OnGetDeleteCondition;
   property OnSkipDocument: TSkipDocNotify
    read GetOnSkipDocument
    write SetOnSkipDocument;
   property OnTopicStart: TddTopicEvent
    read GetOnStartTopic
    write SetOnStartTopic;
   property AddNewToLog: Boolean read pm_GetAddNewToLog write pm_SetAddNewToLog;
   property ImportFilter: TImportFilter read f_ImportFilter;
   property NeedFork: Boolean read pm_GetNeedFork write pm_SetNeedFork;
   property UpdateDictionary : Boolean
    read f_UpdateDictionary
    write f_UpdateDictionary;
   property UpdateTables: Boolean
    read FUpdateTables
    write SetUpdateTables;
   property UserID : Long
    read GetUserID
    write SetUserID;
  end;

const
 EnglishIncrement : Longint = 100000000;


implementation

Uses
 {$IFDEF MemTrap}
 d_MemUsg,
 {$ENDIF}
 l3String,
 l3Tree_TLB,

 k2Tags,
 evdBufferedFilter,
 daDataProvider,
 daSchemeConsts,
 dt_Dict, dt_LinkServ,
 Base_CFG,
 SysUtils
 , k2ForkGenerator,

 LogRecord_Const,
 DecorTextPara_Const,
 Document_Const,
 AnnoTopic_Const,
 Address_Const,
 DictRec_Const,
 PIRec_Const,
 ActiveInterval_Const,
 DictItem_Const,
 //dbgTagFilter,
 dt_DictSup, dt_DictConst, NumAndDate_Const,

 k2VariantImpl,
 m3DBFiler
 ;


type
 TddInfoUnitFilter = class(TevdBufferedFilter)
 {������ Tags and Childs ������ ���������
  ��� ��������� TagID � ChildID ����������� ��� ��������� ����������
  �����, ���������� ���� �� ������ ����� ������� - ������� �� ������ � ����� ��� ���
  � ������� ���������� :
   - ������� ChildID = k2_idLogRecord ������, ���� Atom k2_tiType = 0(acRevision)
  }
  protected
   function NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean; override;
   function NeedStartBuffering(aID : Integer): Boolean; override;
  end;

{TddInfoUnitFilter}
function TddInfoUnitFilter.NeedFlushBuffer(aLeaf: Tl3Variant; aTagId: Integer): Boolean;
var
 lChildID : Integer;
begin
 Result := True;
 // ������!!!! ��� Child  ChildID = -aTagId
 lChildID := - aTagId;

 //- ������� ChildID = k2_idLogRecord ������, ���� Atom k2_tiType = 0(acRevision)
 if lChildID = k2_idLogRecord then
  Result := aLeaf.IntA[k2_tiType] <> 0;
end;

function TddInfoUnitFilter.NeedStartBuffering(aID : Integer): Boolean;
begin
 // ������!!!! ��� Child  ChildID = -aTagId
 Result := aID = - k2_idLogRecord;
end;

{TddImportPipeFilter}
constructor TddImportPipeFilter.Create(aFamily: Integer; anOwner: Tk2TagGeneratorOwner = nil; anExclusive: Boolean = False);
begin
 inherited Create(anOwner);
 f_CustomID := 1;
 { �������� ����� }
 if anExclusive then
  f_m3DB := Tm3DB.MakeExclusive(GlobalDataProvider.TextBase[aFamily])
 else
  f_m3DB := Tm3DB.Make(GlobalDataProvider.TextBase[aFamily]);
 f_EvWriter := TevdNativeWriter.Create(nil);
 {$IFNDEF EverestLite}
 TevdNativeWriter(f_EvWriter).Binary := True;
 {$ENDIF}
 f_BaseFiler := Tm3DBFiler.Create(f_m3DB);
 f_BaseFiler.Mode := l3_fmWrite;
 TevdNativeWriter(f_EvWriter).Filer := f_BaseFiler;
 f_Gen := TddExtObjExtractor.SetTo(f_EvWriter);
 TddWrongTagFixFilter.SetTo(f_Gen);
 TddWrongTagFixFilter(f_Gen).Write2Log := False;
 Tm3DocumentInfoFilter.SetTo(F_Gen);
 Tm3DocumentInfoFilter(f_Gen).Filer := Tm3DBFiler(f_BaseFiler);
 TevTopicSwitcher.SetTo(f_Gen);
 TevTopicSwitcher(f_Gen).Filer := f_BaseFiler;
 TevTopicSwitcher(f_Gen).OnInitTopic := StartTopic;
 TevTopicSwitcher(f_Gen).OnDoneTopic := FinishTopic;
 TevTopicSwitcher(f_Gen).OnGenerateTopicID := GenerateID;
 // TddNullDocFilter.SetTo(f_Gen); //<- ������ ��������� ������
 //{!!}f_Gen := TdbgTagFilter.SetTo(f_Gen);
 TImportFilter.SetTo(f_Gen);
 f_ImportFilter := TImportFilter(f_Gen);
 with f_ImportFilter do
 begin
  OnUpdateDictionary       := _UpdateDicts;
  SDR_UserFunc             := _OnDocumentReaction;
  OnGetDeleteCondition     := _OnGetDeleteCondition;
  NeedEventforEraseAttrRec := [ctKW];
  OnEraseAttrRecords       := evntOnEraseAttrRecords;
 end; // TImportFilter(f_Gen)
 f_BaseGen := TImportFilter(f_Gen);
 TddInfoUnitFilter.SetTo(f_Gen);
 TddImportFixFilter.SetTo(f_Gen);
 TddImportFixFilter(f_Gen).IsEnglish:= IsEnglish;
 f_TopicFilter := TddImportFixFilter(f_Gen);
 TddChildBiteOffFilter.SetTo(f_Gen, k2_idDecorTextPara);
 Generator := f_Gen;
 Family := aFamily;
end;

procedure TddImportPipeFilter.CloseStream(NeedUndo : Boolean);
begin
 //����� ���� � m3DB
 f_m3DB.FlushLists;
 Inherited;
end;

function TddImportPipeFilter.GenerateID(Sender: TObject): Tm3DBStreamIndex;
begin
 (*
 Result:= f_CustomID;
 Inc(f_CustomID);
 *)
 Result.rID := 0;
 Result.rPart:= m3_dsMain;
end;

function TddImportPipeFilter.GetCheckDocuments: Boolean;
begin
 Result:= f_BaseGen.CheckDocuments;
end;

function TddImportPipeFilter.GetDeleteCondition: TDeleteConditionSet;
begin
 Result:= f_BaseGen.DeleteConditions;
end;

function TddImportPipeFilter.GetDocumentReaction: TSameDocReact;
begin
 Result:= f_BaseGen.SameDocumentReaction;
end;

function TddImportPipeFilter.GetFamily: TdaFamilyID;
begin
 Result:= f_BaseGen.Family
end;

function TddImportPipeFilter.GetInternalFormat: Boolean;
begin
 Result:= f_BaseGen.InternalFormat;
end;

function TddImportPipeFilter.GetIsEnglish: Boolean;
begin
{$IFDEF Bilingual}
 Result:= DictServer.Bilingual;
{$ELSE}
 Result:= False;
{$ENDIF}
end;

function TddImportPipeFilter.GetOnSkipDocument: TSkipDocNotify;
begin
 Result:= f_BaseGen.SkipDocNotification;
end;

function TddImportPipeFilter.GetOnStartTopic: TddTopicEvent;
begin
 Result:= f_TopicFilter.OnTopicStart;
end;

function TddImportPipeFilter.GetUserID: Long;
begin
 Result:= f_BaseGen.MasterUser
end;

procedure TddImportPipeFilter.StartTopic(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
begin
 if Handle.rID <> 0 then
 begin

  f_Handle.rPart := Handle.rPart;
  f_Filer := f_BaseFiler;

  TevTopicSwitcher(Sender).Filer := f_Filer;

  (f_Filer as Tm3DBFiler).ObjectIndex := 0;
  (f_Filer as Tm3DBFiler).PartSelector := Handle.rPart;
  f_Filer.Handle := Handle.rID;
  if not f_Filer.Opened then //-- ������ ���� ��������, ����������� �� �������, � ����������� (� EndTopic) ������
  f_Filer.Open;
  if f_Filer.Opened then
   if (handle.rpart = m3_dsMain) then
    f_EvWriter.AfterStreamOpened;
 end; // Handle.rID <> 0
end;

procedure TddImportPipeFilter.FinishTopic(Sender: TObject; const Handle: Tm3DBStreamIndex; Filer: Tl3CustomFiler);
begin
 f_BaseFiler.Close;

 // - ��������� ����, ����� ��� ����� �� ����� �� ����� � ��� �� �����
 // http://mdp.garant.ru/pages/viewpage.action?pageId=92340805&focusedCommentId=139444041#comment-139444041
 if Handle.rID <> 0 then
 begin
  if f_Handle.rPart = m3_dsObject then
  begin
   TevTopicSwitcher(Sender).Filer := f_BaseFiler;
   f_Handle.rPart := m3_dsMain;
  end;
 end; // Handle.rID <> 0
end;

procedure TddImportPipeFilter.Cleanup;
begin
// l3Free(f_FireWall);
// l3Free(f_TopicFilter);
// l3Free(f_mgFilter);
 l3Free(f_BaseFiler);
// l3Free(f_EvWriter);
// l3Free(f_Switcher);
 f_BaseGen.SkipDocNotification:= nil;
// l3Free(f_BaseGen);
 l3Free(f_Gen);
 inherited;
end;

procedure TddImportPipeFilter.evntOnEraseAttrRecords(aAttrType : TCacheType; aDictID : TDictID; aDocID : TDocID; aSubID
    : TSubID);
begin
 dictChangeToLogFile(aAttrType, aDictID, aDocID, aSubID);
end;

function TddImportPipeFilter.pm_GetAddNewToLog: Boolean;
begin
 Result := f_BaseGen.AddNewToLog;
end;

function TddImportPipeFilter.pm_GetNeedFork: Boolean;
begin
 { TODO -o����� ������ -c��������� : ���������! }
 Result := True;//Tm3DBFiler(f_BaseFiler).NeedFork;
end;

procedure TddImportPipeFilter.pm_SetAddNewToLog(const aValue: Boolean);
begin
 if aValue <> f_BaseGen.AddNewToLog then
  f_BaseGen.AddNewToLog:= aValue;
end;

procedure TddImportPipeFilter.pm_SetNeedFork(const aValue: Boolean);
begin
 { TODO -o����� ������ -c��������� : ���������! }
 //Tm3DBFiler(f_BaseFiler).NeedFork:= aValue;
end;

procedure TddImportPipeFilter.SetNeedLockBase(const Value: Boolean);
begin
 f_BaseGen.ExclusiveMode := Value;
end;

procedure TddImportPipeFilter.SetCheckDocuments(const Value: Boolean);
begin
 if Value <> f_BaseGen.CheckDocuments then
 begin
  f_BaseGen.CheckDocuments := Value;
  f_BaseGen.FastAddAttr := not f_BaseGen.CheckDocuments;
 end;
end;

(*
procedure TddImportPipeFilter.SetCloseStages(const Value: Boolean);
begin
 if f_TopicFilter is TddImportFixFilter then
  TddImportFixFilter(f_TopicFilter).CloseStages:= Value;
end;
*)

procedure TddImportPipeFilter.SetDeleteCondition(
  const Value: TDeleteConditionSet);
begin
 if f_BaseGen.DeleteConditions <> Value then
  f_BaseGen.DeleteConditions := Value;
end;

procedure TddImportPipeFilter.SetDocumentReaction(const Value: TSameDocReact);
begin
 if f_BaseGen.SameDocumentReaction <> Value then
  f_BaseGen.SameDocumentReaction:= Value;
end;

procedure TddImportPipeFilter.SetFamily(aValue: TdaFamilyID);
begin
 if aValue <> f_BaseGen.Family then
 begin
  f_BaseGen.Family:= aValue;
 end;
end;

procedure TddImportPipeFilter.SetInternalFormat(const Value: Boolean);
begin
 if f_BaseGen.InternalFormat <> Value then
  f_BaseGen.InternalFormat:= Value;
end;

procedure TddImportPipeFilter.SetIsEnglish(const Value: Boolean);
begin
{$IFDEF Bilingual}
 DictServer.Bilingual:= Value;
 f_TopicFilter.IsEnglish:= Value;
{$ENDIF}
end;

procedure TddImportPipeFilter.SetOnSkipDocument(
  const Value: TSkipDocNotify);
begin
 f_BaseGen.SkipDocNotification:= Value;
end;

procedure TddImportPipeFilter.SetOnStartTopic(const Value: TddTopicEvent);
begin
 f_TopicFilter.OnTopicStart:= Value;
end;

procedure TddImportPipeFilter.SetUpdateTables(const Value: Boolean);
begin
  FUpdateTables := Value;
  f_BaseGen.FinalTblUpdate := Value;
end;

procedure TddImportPipeFilter.SetUserID(const Value: Long);
begin
 if Value <> f_BaseGen.MasterUser then
  f_BaseGen.MasterUser:= Value;
end;

class function TddImportPipeFilter.SetTo(var theGenerator: Tk2TagGenerator; aFamily: Integer):
    Tk2TagGenerator;
var
 l_Filter : TddImportPipeFilter;
begin
 l_Filter := Create(aFamily, nil);
 try
  //l_Filter.Generator := theGenerator;
  l3Set(theGenerator, l_Filter);
 finally
  l3Free(l_Filter);
 end;//try..finally
 Result := theGenerator;
end;

function TddImportPipeFilter._OnDocumentReaction(aDocID : TDocID) : TSameDocReact;
begin
 if Assigned(f_OnDocumentReaction) then
  Result:= f_OnDocumentReaction(aDocID)
 else
  Result:= DocumentReaction;
end;

function TddImportPipeFilter._OnGetDeleteCondition(aDocID: TDocID): TDeleteConditionSet;
var
 l_DictID: TDictID;
begin
{ TODO 1 -o����� -c����� : ����������� � ���������� - ��� ��� ����� � ���������� ������� }
 BaseConfig.Section:= 'MagicNumbers';
 l_DictID:= BaseConfig.ReadParamIntDef('RegionID', 0);
 if CheckRegion and LinkServer(Family).LinkExists(da_dlAccGroups, aDocID, l_DictID) then
  Result:= [dcIfNotHasAnno]
 else
  Result:= DeleteConditions;
end;

function TddImportPipeFilter._UpdateDicts(aDictType: TdaDictionaryType; aSubID: TSubID;
                                          aNameAttr: Tl3Tag): Boolean;
begin
 if Assigned(f_OnDictionaryUpdate) then
  Result:= f_OnDictionaryUpdate(aDictType, f_TopicFilter.TopicNo, aSubID, aNameAttr)
 else
  Result:= f_UpdateDictionary;
end;

{TddImportFixFilter}
procedure TddImportFixFilter.DoStartChild(TypeID: Tk2Type);
var
 l_Type : Tk2Type;
begin
 l_Type := TypeID;
 if l_Type.IsKindOf(k2_typDocument) then
 begin
  fDocumentTypeID := TypeID.ID;
  f_HasActiveInterval := False;
  f_HasAccGroups := False;
 end;// l_Type.IsKindOf(k2_typDocument)
 inherited;
end;

procedure TddImportFixFilter.DoStartTag(TagID: Long);
begin
 if TagID = k2_tiActiveIntervals then
  f_HasActiveInterval:= True
 else
 if TagID = k2_tiAccGroups then
  f_HasAccGroups:= True;
 inherited;
end;

procedure TddImportFixFilter.DoCloseStructure(NeedUndo: Bool);
begin
 if not NeedUndo and CurrentType.IsKindOf(k2_typDocument) then
 begin
  if not f_HasActiveInterval and not CurrentType.IsKindOf(k2_typAnnotopic) then
   AddActiveInterval;
   
  if not f_HasAccGroups and IsEnglish then
   AddAccGroups;
 end;
 inherited;
end;

procedure TddImportFixFilter.DoAddAtomEx(AtomIndex: Long; const Value: Tk2Variant);
var
 TT : Tk2Type;
 l_Value : Tk2Variant;
begin
 TT := CurrentType;
 l_Value := Value;

 if TT.IsKindOf(k2_typDocument) then
 begin
  { ����������� ���������� � ������� ���������. ���� ������ ����� }
  case AtomIndex of
   k2_tiInternalHandle :
    Exit;

   k2_tiExternalHandle :
    begin
     if IsEnglish then
      l_Value := Tk2VariantImpl.Make(l_Value.AsInteger + EnglishIncrement);

     f_TopicNo:= l_Value.AsInteger;

     if Assigned(f_OnStartTopic) then
      f_OnStartTopic(l_Value.AsInteger, '');
    end;
   k2_tiRelExternalHandle :
    begin
     if IsEnglish then
      l_Value := Tk2VariantImpl.Make(l_Value.AsInteger + EnglishIncrement);
    end;
  end;
 end
 else
 if IsEnglish then
 begin
  if TT.IsKindOf(k2_typAddress) then
  begin
   if (AtomIndex = k2_tiDocID) and IsEnglish then
    l_Value := Tk2VariantImpl.Make(l_Value.AsInteger + EnglishIncrement);
  end
  else
  if TT.IsKindOf(k2_typDictRec) then
  begin
   if (AtomIndex = k2_tiShortName) and (TopObject[1].isProp)
      and (TopObject[1].AsProp.TagIndex = k2_tiAccGroups) then
   begin
    l_Value.AsString.AsString:= 'ENG';
    f_HasAccGroups := True;
   end;
  end;
 end
 else
 if TT.IsKindOf(k2_typDictRec) then
 begin
  if TopType[1].IsKindOf(k2_typPIRec) then
  begin
   if AtomIndex = k2_tiName then
    CorrectPublished(l_Value);
  end
 end
 else
 if CurrentType.IsKindOf(k2_typNumAndDate) and (AtomIndex = k2_tiNumber) then
  l_Value.AsString.AsString:= AnsiUpperCase(Value.AsString.AsString);
 inherited DoAddAtomEx(AtomIndex, l_Value);
end;

procedure TddImportFixFilter.AddActiveInterval;
begin
 Generator.StartTag(k2_tiActiveIntervals);
 try
  Generator.StartChild(k2_typActiveInterval);
  try
   Generator.AddIntegerAtom(k2_tiStart, minActiveDate);
   Generator.AddIntegerAtom(k2_tiFinish, maxActiveDate);
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

procedure TddImportFixFilter.AddAccGroups;
begin
 Generator.StartTag(k2_tiAccGroups);
 try
  Generator.StartChild(k2_typDictItem);
  try
   Generator.AddStringAtom(k2_tiShortName, 'ENG');
  finally
   Generator.Finish;
  end;
 finally
  Generator.Finish;
 end;
end;

const
 c_IsAtStr = '@';
 c_IsMailedStr = '[�������� �� ��������]';

procedure TddImportFixFilter.CorrectPublished(var aValue: Tk2Variant);
begin
 if (f_HaveMailed and (AnsiCompareText(c_isAtStr, aValue.AsString.AsString) = 0)) then
  aValue.AsString.AsString:= c_IsMailedStr
 else
  if (not f_HaveMailed and (AnsiCompareText(c_IsMailedStr, aValue.AsString.AsString) = 0)) then
   aValue.AsString.AsString:= c_IsAtStr;
end;

procedure TddImportFixFilter.OpenStream;
begin
 inherited;
 f_HaveMailed:= DictServer(CurrentFamily).Dict[da_dlCorSources].FindIDByFullPath(l3PCharLen(PAnsiChar(c_IsMailedStr))) <> cUndefDictID;
end;

end.
