unit daTypes;

// ������: "w:\common\components\rtl\Garant\DA\daTypes.pas"
// ���������: "Interfaces"
// ������� ������: "daTypes" MUID: (5432448401BC)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3Types
 , dt_Types
 , SysUtils
;

const
 c_UnknownLogin = 'UNKNOWN USER';
 c_UnknownUserName = '������������ %s.%d';

type
 PdaDocEditRec = ^TdaDocEditRec;

 PdaDictEditRec = ^TdaDictEditRec;

 PLargeInt = ^LargeInt;

 PdaUserID = ^TdaUserID;

 PdaFamilyID = ^TdaFamilyID;

 PdaUserGroupID = ^TdaUserGroupID;

 PdaGlobalCoordinateRec = ^TdaGlobalCoordinateRec;

 PdaUserGroupAccessMask = ^TdaUserGroupAccessMask;

 TdaUserID = LongWord;

 TGetLoginPasswordProc = function(var aLogin: AnsiString;
  var aPassword: AnsiString): Boolean;

 TdaBaseFlag = (
  bfAAC
  , bfAutoLink
 );//TdaBaseFlag

 TdaBaseFlags = set of TdaBaseFlag;

 TdaRegionID = Byte;

 TdaLoginError = (
  da_leOk
  , da_leInsufficientRights
  , da_leUserParamsWrong
  , da_leConnectionError
  , da_leSQLError
 );//TdaLoginError

 TdaDocID = TDocID;

 TdaFamilyID = Word;

 TdaPathStr = TPathStr;

 TdaProcessState = (
  da_psStart
  , da_psCurrent
  , da_psEnd
 );//TdaProcessState

 TdaOnLongProcessEvent = function(aState: TdaProcessState): Boolean of object;

 TdaDataType = (
  {* ���� ������ ����� }
  da_dtChar
  , da_dtByte
  , da_dtDate
  , da_dtTime
  , da_dtDWord
  , da_dtWord
  , da_dtInteger
  , da_dtBoolean
  , da_dtQWord
 );//TdaDataType

 TdaTables = (
  da_mtAccess
   {* ����� ������� � ���������� }
  , da_mtPassword
   {* ������ ������������� }
  , da_mtUsers
   {* ������������ }
  , da_mtGroups
   {* ������ (mtGUDt) }
  , da_mtGroupMembers
   {* ����� ������ (mtGULnk) }
  , da_mtFamily
   {* ��������� (�� ���������) }
  , da_mtFree
   {* ������ ���������� ��� ID }
  , da_mtJournal
   {* ������ ������ (mtBBLog) }
  , da_mtControl
   {* ������ ������������� ������� (mtCtrl) }
  , da_mtRegions
   {* ������� �������� }
  , da_ftNone
   {* �������� ������� }
  , da_ftDocuments
   {* ��������� (ftFile) }
  , da_ftHyperlinks
   {* ����������� (ftHLink) }
  , da_ftSubs
   {* ���� (ftSub) }
  , da_ftFree
   {* ������ ���������� ��� ID }
  , da_ftSources
   {* ������� ��������� ������ (ftDt1) }
  , da_ftTypes
   {* ������� ���� (ftDt2) }
  , da_ftClasses
   {* ������� ������ (ftDt3) }
  , da_ftKeywords
   {* ������� �������� ����� (ftDt5) }
  , da_ftBelongs
   {* ������� ������ (ftDt6) }
  , da_ftDateCodes
   {* ������� ������� � ��� (ftDt7) }
  , da_ftWarnings
   {* ������� �������������� (ftDt8) }
  , da_ftCorrections
   {* ������� ������� (ftDt9) }
  , da_ftCoSources
   {* ������� ������� (ftDtA) }
  , da_ftPiblishedIn
   {* ������� ���������� ������������� (ftDtB) }
  , da_ftPrefixes
   {* ������� ����� ���������� (ftDtC) }
  , da_ftTerritories
   {* ������� ���������� (ftDtD) }
  , da_ftNorms
   {* ������� ����� ����� (ftDtE) }
  , da_ftExtClasses
   {* ���������� ������� ������� (ftDt3E) }
  , da_ftAccessGroups
   {* ������� ������ ������� (ftDtF) }
  , da_ftAnnoClasses
   {* ������� ������ ��������� (ftDtI) }
  , da_ftServiceInfo
   {* ������� ��� ���������� ���������� (ftDtJ) }
  , da_ftDocSources
   {* ��������� ������ ��������� (ftLnk1) }
  , da_ftDocTypes
   {* ���� ��������� (ftLnk2) }
  , da_ftDocClasses
   {* ������ ��������� (ftLnk3) }
  , da_ftDocKeywords
   {* �������� ����� ��������� (ftLnk5) }
  , da_ftDocBelongs
   {* ������ ��������� (ftLnk6) }
  , da_ftDocDateCodes
   {* ������ � ���� ��������� (ftLnk7) - �� ����� }
  , da_ftDocWarnings
   {* �������������� ��������� (ftLnk8) }
  , da_ftDocCorrections
   {* ������� ��������� (ftLnk9) - �� ����� }
  , da_ftDocPublishedIn
   {* ��������� ������������� ��������� (ftLnkB) }
  , da_ftDocPrefixes
   {* ���� ���������� ��������� (ftLnkC) }
  , da_ftDocTerritories
   {* ���������� ��������� (ftLnkD) }
  , da_ftDocNorms
   {* ����� ����� ��������� (ftLnkE) }
  , da_ftDocAccessGroups
   {* ������ ������� ��������� (ftLnkF) }
  , da_ftDocAnnoClasses
   {* ������ ��������� ��������� (ftLnkI) }
  , da_ftDocServiceInfo
   {* ��� ���������� ���������� ��������� (ftLnkJ) }
  , da_ftDoc2DocLink
   {* ����� ����� ����������� (ftLnkK) }
  , da_ftPriority
   {* ������� ����������� (ftPriority) }
  , da_ftRenum
   {* ������������ ������� � ���������� ������� (ftRenum) }
  , da_ftDocStages
   {* ����� ��������� ��������� (ftStage) }
  , da_ftDocLog
   {* ������ ��������� ��������� (ftLog) }
  , da_ftDocActivity
   {* ��������� �������� ��������� (ftActiv) }
  , da_ftDocAlarm
   {* ��������� �������������� � ��������� (ftAlarm) }
  , da_ftControl
   {* ������ ������������� ������� (ftCtrl) }
  , da_ftDocumentsDub1
   {* �������� ������� ���������� - ��� ���������� � �������� (ftFileDup1) }
  , da_ftDocumentsDub2
   {* �������� ������� ���������� - ��� ���������� � �������� (ftFileDup2) }
  , da_ftAutolinkDocumentsLocal
  , da_ftAutolinkEditionsLocal
  , da_ftAutolinkDocumentsRemote
  , da_ftAutolinkEditionsRemote
 );//TdaTables

 TdaJournalOperation = (
  da_oobNone
  , da_oobPause
   {* ����� ����� � Additional }
  , da_oobSessionBegin
   {* ID ������������ � ID_Ext }
  , da_oobSessionEnd
  , da_oobOpenDoc
   {* ID ��������� � ID_Ext }
  , da_oobCreateDoc
   {* ID ��������� � ID_Ext }
  , da_oobDeleteDoc
   {* ID ��������� � ID_Ext }
  , da_oobEditDoc
   {* ID ��������� � ID_Ext, TdaDocEditRec � Additional }
  , da_oobPrintDoc
   {* ID ��������� � ID_Ext }
  , da_oobSaveDoc
   {* ID ��������� � ID_Ext }
  , da_oobEditDictionary
   {* TdaDictEditRec � Additional }
  , da_oobExport
   {* ���������� ���������� � Additional }
  , da_oobImport
  , da_oobSearch_Deprecated
  , da_oobAutoClass
   {* ���������� ���������� � Additional }
 );//TdaJournalOperation

 TdaDocEditType = (
  da_detText
  , da_detAttribute
  , da_detHyperLink
  , da_detSub
  , da_detDiction
 );//TdaDocEditType

 TdaEditOperation = (
  da_eoNone
  , da_eoAdd
  , da_eoEdit
  , da_eoDelete
 );//TdaEditOperation

 TdaDictionaryType = (
  da_dlNone
  , da_dlSources
  , da_dlTypes
  , da_dlClasses
  , da_dlKeyWords
  , da_dlBases
  , da_dlDateNums
  , da_dlWarnings
  , da_dlCorrects
  , da_dlCorSources
  , da_dlPublisheds
  , da_dlPrefixes
  , da_dlTerritories
  , da_dlNorms
  , da_dlAccGroups
  , da_dlNewClasses_Deprecated
  , da_dlAnnoClasses
  , da_dlServiceInfo
  , da_dlTextInsert
 );//TdaDictionaryType

 TdaJoinKind = (
  {* ��� ���������� ������ � �������� }
  da_jkInner
  , da_jkLeftOuter
  , da_jkRightOuter
  , da_jkFullOuter
 );//TdaJoinKind

 TdaSessionID = LongInt;

 TdaCompareOperation = (
  da_copEqual
  , da_copGreaterOrEqual
  , da_copLessOrEqual
  , da_copNotEqual
 );//TdaCompareOperation

 EdaError = class(Exception)
 end;//EdaError

 TdaTablesSet = set of TdaTables;

 LargeInt = Int64;

 TdaDictionaryTypeSet = set of TdaDictionaryType;

 TdaDocEditRecUnion = record
  Case Byte of
   1: (Operation: TdaEditOperation);
   2: (DictType: TdaDictionaryType);
 end;//TdaDocEditRecUnion

 TdaDocEditRec = record
  EditType: TdaDocEditType;
  Details: TdaDocEditRecUnion;
 end;//TdaDocEditRec

 TdaDictEditRec = record
  DictType: TdaDictionaryType;
  Operation: TdaEditOperation;
 end;//TdaDictEditRec

 TdaLogicOperation = (
  da_loAnd
  , da_loOr
 );//TdaLogicOperation

 TdaDictID = TDictID;

 TdaParamType = (
  da_ptInput
  , da_ptOutput
  , da_ptInOut
 );//TdaParamType

 TdaSortOrder = (
  da_soAscending
  , da_soDescending
 );//TdaSortOrder

 TdaPriority = (
  prLowest = -2
  , prLow = -1
  , prNormal = 0
  , prHigh = 1
  , prHighest = 2
 );//TdaPriority

 TdaAggregateOperation = (
  da_aopCount
  , da_aopMin
  , da_aopMax
  , da_aopAverage
  , da_aopSum
 );//TdaAggregateOperation

 TdaUserGroupID = Word;

 TdaUserIDArray = array of TdaUserID;

 TdaUserGroupIDArray = array of TdaUserGroupID;

 TdaSubID = TSubID;

 TdaGlobalCoordinateRec = record
  Family: TdaFamilyID;
  Doc: TdaDocID;
  Sub: TdaSubID;
 end;//TdaGlobalCoordinateRec

 TdaUserEditMask = record
  LoginName: Boolean;
  Name: Boolean;
  ActivFlag: Boolean;
 end;//TdaUserEditMask

 TdaBitwiseOperator = (
  da_bwAnd
  , da_bwOr
 );//TdaBitwiseOperator

 TdaDataTypesSet = set of TdaDataType;

 TdaUserGroupAccessMask = record
 //#UC START# *57AC49D002F2publ*
  ID   : TdaUserID;
  Case Byte of
   0 : (Mask : TTblMask);
   1 : (MaskRec : TTblMaskRec);
 //#UC END# *57AC49D002F2publ*
 end;//TdaUserGroupAccessMask

 TdaDocType = TDocType;

const
 cDeprecatedDicts: TdaDictionaryTypeSet = [da_dlNewClasses_Deprecated];
 da_dtIntegers: TdaDataTypesSet = [da_dtByte, da_dtDWord, da_dtWord, da_dtInteger, da_dtQWord];

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EdaError));
 {* ����������� ���� EdaError }
{$IfEnd} // NOT Defined(NoScripts)

end.
