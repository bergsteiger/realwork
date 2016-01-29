unit daJournal;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , l3Tree
 , daTypes
 , l3Date
 , l3Tree_TLB
;

type
 TdaJournal = class(Tl3ProtoObject, IdaJournal)
  procedure Create(const aFactory: IdaTableQueryFactory);
  procedure LogEvent(aOperation: TdaJournalOperation;
   aFamilyID: TdaFamilyID;
   aExtID: LongInt;
   aData: LongInt);
  procedure CheckUser(anUserID: TdaUserID);
  procedure UserChanged(anUserID: TdaUserID);
  procedure SessionChanged;
  function GetNewSessionID: TdaSessionID;
  procedure DoStartCaching;
  procedure DoStopCaching;
  procedure AnalyseLog(const aLog: IdaResultSet);
  function MakeResultSet(FromDate: TStDate;
   ToDate: TStDate;
   aDocID: TdaDocID;
   UserOrGroupID: TdaUserID;
   UserGr: Boolean): IdaResultSet;
  procedure CorrectDates(var FromDate: TStDate;
   ToDate: TStDate);
  function CurStatisticTreeRoot: Il3RootNode;
  procedure CalcStatistics(FromDate: TStDate;
   ToDate: TStDate;
   aDocID: TdaDocID;
   UserOrGroupID: TdaUserID;
   UserGr: Boolean);
  procedure LogExport(aFamilyID: TdaFamilyID;
   aCount: LongInt);
  procedure LogImport(aFamilyID: TdaFamilyID);
  procedure LogPause(aLength: LongInt);
  procedure LogPrintDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogSaveDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogEditDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   aEditType: TdaDocEditType;
   anOperation: TdaEditOperation); overload;
  procedure LogEditDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID;
   aEditType: TdaDocEditType;
   aDictType: TdaDictionaryType); overload;
  procedure LogDeleteDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogEditDict(aFamilyID: TdaFamilyID;
   aDictType: TdaDictionaryType;
   anOperation: TdaEditOperation);
  procedure LogCreateDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  procedure LogAutoClass(aFamilyID: TdaFamilyID;
   aCount: LongInt);
  procedure LogOpenDoc(aFamilyID: TdaFamilyID;
   aDocID: TdaDocID);
  function UserID: TdaUserID;
  procedure StartCaching;
  procedure StopCaching;
  procedure SessionDone;
 end;//TdaJournal
 
implementation

uses
 l3ImplUses
 , l3Base
 , daScheme
 , SysUtils
 , TypInfo
 , l3Nodes
 , l3TreeInterfaces
;

end.
