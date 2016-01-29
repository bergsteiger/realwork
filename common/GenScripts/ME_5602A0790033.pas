unit pgJournal;

interface

uses
 l3IntfUses
 , daJournal
 , pgJournalCache
 , pgTableModifier
 , pgConnection
 , daInterfaces
 , l3Tree
 , daTypes
 , l3Date
;

type
 TpgJournal = class(TdaJournal)
  procedure Create(aConnection: TpgConnection;
   const aFactory: IdaTableQueryFactory);
  function Make(aConnection: TpgConnection;
   const aFactory: IdaTableQueryFactory): IdaJournal;
  procedure PurgeCache;
  function Modifier: TpgTableModifier;
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
 end;//TpgJournal
 
implementation

uses
 l3ImplUses
 , daScheme
 , SysUtils
 , l3Types
 , l3Base
;

end.
