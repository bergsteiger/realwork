unit htJournal;

interface

uses
 l3IntfUses
 , daJournal
 , dt_BBLog
 , daInterfaces
 , dtIntf
 , l3Date
 , daTypes
 , l3Tree
;

type
 TBigBrotherAccess = class(TBigBrotherTbl)
 end;//TBigBrotherAccess
 
 ThtJournal = class(TdaJournal)
  procedure Create(const aFactory: IdaTableQueryFactory);
  function Make(const aFactory: IdaTableQueryFactory): IdaJournal;
  function BigBrother: TBigBrotherAccess;
  function GetUserStatistic(FromDate: TStDate;
   ToDate: TStDate;
   UserOrGroupID: TdaUserID;
   UserGr: Boolean): ISab;
  function GetDocStatistic(FromDate: TStDate;
   ToDate: TStDate;
   aDocID: TdaDocID): ISab;
  procedure LogEvent(aOperation: TdaJournalOperation;
   aFamilyID: TdaFamilyID;
   aExtID: LongInt;
   aData: LongInt);
  function CurStatTree: Tl3Tree;
  procedure CheckUser(anUserID: TdaUserID);
  procedure UserChanged(anUserID: TdaUserID);
  procedure SessionChanged;
  procedure DoStartCaching;
  procedure DoStopCaching;
  function MakeResultSet(FromDate: TStDate;
   ToDate: TStDate;
   aDocID: TdaDocID;
   UserOrGroupID: TdaUserID;
   UserGr: Boolean): IdaResultSet;
 end;//ThtJournal
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , htResultSet
 , dt_Sab
 , HT_Const
 , dt_User
 , htInterfaces
 , daSelectFieldList
 , daScheme
 , Classes
 , dt_Err
;

end.
