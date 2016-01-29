unit DocAttrToolsIntf;

{ $Id: DocAttrToolsIntf.pas,v 1.12 2015/10/02 09:23:48 lukyanets Exp $ }

{$I l3Define.inc}

{DocAttrImpl}
interface
 Uses
  l3Types,
  l3PrimString,
  l3Interfaces,
  l3Variant,
  l3Chars,
  l3Date,
  DT_Types,
  DocAttrIntf,
  dtIntf,
  k2Interfaces
  ;

 Type
  Pl3PrimString = ^Tl3PrimString;

  IDictAttributeTool = interface(IListDocAttribute)
  ['{AA1976C9-333F-4184-B10D-1DDA6252C96D}']
  procedure AddRec(aItemID : Integer);
  end;

  IAlarmAttributeTool = interface(IListDocAttribute)
  ['{33BD0579-B271-4D71-B410-3AFE765A938B}']
   procedure AddRec(aDate : TStDate; aMessage : Tl3WString);
  end;

  IDateNumDocAttributeTool = interface(IListDocAttribute)
   ['{2ABDFF05-E1B7-4466-AB7F-7A7D7017E50E}']
   function GetMinPublishDate(aNum : Pl3PrimString = nil): TStDate;
   function GetChDate : TStDate;
   function GetCasecode: Il3CString;

   function GetType(aIndex : Integer): TDNType;
   function GetDate(aIndex : Integer): TstDate;
   function GetNum(aIndex : Integer): Il3CString;

   procedure UpcaseNum(aIndex : Integer);
   procedure DeleteAllChangerRec;
   function  AddRec(aType : TDNType; aDate : TStDate;  aDocID  : TDocID; aSubID  : TSubID) : integer; overload;
   function  AddRec(aType : TDNType; aDate : TStDate; aNumber : Tl3WString) : integer; overload;
  end;

  ILogDocAttributeTool = interface(IListDocAttribute)
   ['{16BDFC45-56EF-4254-8765-ADABA66FB022}']
   procedure AddAction(aAction : TLogActionType; aDate : TstDate = 0);
   procedure DelAction(aAction : TLogActionType);
   function  HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean; overload;
   function  HasDocThisLogRec(aActions : TLogActionSet; aDate : TStDate = 0 {Any Date}): boolean; overload;
   function  IsAnnoAction(aIndex : Integer) : boolean;
   procedure AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});

  end;

  IStageDocAttributeTool = interface(IListDocAttribute)
   ['{FA091C5F-7A53-46BE-B348-2D07D081CADF}']
   function  CheckStageClosed(aStageType : TStageType): Boolean;
   function  CheckEditEnable(aStageType : TStageType; aDateKind : Byte) : Boolean;
   procedure CloseStage(aStageType : TStageType);
   function  DateOfStageClosed(aStageType : TStageType): TStDate;

   function  MakeStage(aStageType : TStageType): Integer;
   procedure SetStartDate(aIndex : Integer; aDate : TstDate);
   procedure SetEndDate  (aIndex : Integer; aDate : TstDate);
   function  GetStartDate(aIndex : Integer): TstDate;
   function  GetEndDate  (aIndex : Integer): TstDate;
   function  GetAuthor   (aIndex : Integer): TUserID;
   procedure SetAuthor   (aIndex : Integer; aUserID : TUserID);
  end;

  IActiveIntervalsAttributeTool = interface(IListDocAttribute)
   ['{AFD9160D-780E-4522-8E9B-6A9E10190E24}']
   function IsActive: Boolean;
   function IsDelayed: Boolean;
   function MinDate : TstDate;
   function GetDiapasonData(var aSDate, aEDate : TstDate; out aReason : Tl3Tag) : Boolean;

   function GetLastIntervalIndex : integer;
   procedure CloseInterval(aIndex : integer; aEDate : TstDate);
   procedure CopyNotSureRecTo(aActIntervalAttr : IListDocAttribute);

   procedure AddRec(aStart, aFinish  : TStDate{; aComment : Tl3WString = cc_UnAssignedStr});
   procedure AddDefDiapason;
  end;

  IPublishedDocAttributeTool = interface(IListDocAttribute)
  ['{A5D7B048-152B-4D2B-A852-5CA07515B547}']
   function IsImageExists(aIndex : Integer) : Boolean;
   function GetImagePath(aIndex : Integer) : AnsiString;
   function GetImagePageStr(aIndex : Integer) : AnsiString;
  end;

  IVersionListAttributeTool = interface(IListDocAttribute)
  ['{A5D7B048-152B-4D2B-A852-5CA07515B547}']
   function IsActive(aIndex : Integer) : Boolean;
   function GetIconIndex(aIndex : Integer) : Integer;
   function MakeDocSab : ISab;
  end;

implementation
end.


