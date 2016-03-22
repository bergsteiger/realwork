unit DocAttrImpl2;

{ $Id: DocAttrImpl2.pas,v 1.49 2015/11/11 14:29:04 voba Exp $ }

{$I l3Define.inc}
{$R-}
interface

uses
  Windows, Classes, SysUtils, Graphics,
  l3Interfaces,
  l3ChangeNotifier,
  l3Types, l3InternalInterfaces, l3Date, l3Base, l3Tree, l3LongintList, l3Except,
  l3IID,
  m3DBInterfaces,
  k2Interfaces,
  k2Types, k2Base,
  k2Reader, k2TagGen,
  evInternalInterfaces,
  evTextSource,
  evEvdRd, evdWriter, evTxtrd, evEditorWindow, evTypes, evIntf,
  //mgCHDSel,
  {GMP_Slct,}
  ddPictConvertor, ddRTFwriter, ddDocumentCopy,
  dt_AttrSchema, //DictsSup,
  DT_Const, DT_Types,
  dtIntf, DT_Sab,
  DT_Lock, DT_Dict, DT_Link, DT_LinkServ, DT_Doc, DT_Hyper,
  Dt_Active, DT_Alarm, DT_Log, DT_Stage,
  DocIntf,
  DocAttrIntf, DocAttrToolsIntf,
  l3Variant
  ;

(*
TCustomDocAttribute
    +-TListDocAttribute
        |-TDocIDsAttribute
        |-TSingleItemListDocAttribute
        |    +-TVerLinkAttribute
        +-TGroupDocAttribute
        |    |-TDateNumDocAttribute
        |    |-TActiveIntervalListDocAttribute
        |    |-TAlarmDocAttribute
        |    |-TPublishedDocAttribute
        |    |-TStagesDocAttribute
        |    +-TCorrectsAttribute
        +-TDictDocAttribute
        |
        |-//TPaperWhereDocAttribute
        |-TLogAttribute
             |-TLogGrOpAttribute
             +-TLogSumAttribute
        |        |-TJurOperationAttribute
        |        +-TOrdOperationAttribute
        +-TListOfDocAttribute
        |    +-TVersionListAttribute
        +-TDoc2DocAttribute

*)
 type
  TAttrBoxAction = function(aAttrBox : Tl3Tag): Boolean;
  {* Подитеративная функция для перебора меток. }

 type
  _l3LockedChange_Parent_ = Tl3ChangeNotifier;
   {$Include l3LockedChange.imp.pas}

 _l3COMQueryInterface_Parent_ = _l3LockedChange_;
 {$Include l3COMQueryInterface.imp.pas}

  TCustomDocAttribute = class(_l3COMQueryInterface_, IDocAttribute)
   private
    fAttrManager : TDocAttributeManager;
    fAttrID  : TdtAttribute;

    fInLoad  : Boolean;
    fAttrTag : Il3TagRef;
    fSubID   : TSubID;

    function Get_AttrID : TdtAttribute;
    function Get_DocPart : Tm3DocPartSelector; virtual;

    procedure MakeName(lItem : Tl3Tag); virtual; abstract;

    //procedure CheckTypeCompliance(aAttrType : TAttrType);
    function GetEVDAttrParentTag : Tl3Tag; virtual;
    function GetEVDAttrTag : Tl3Tag; virtual;
    function MakeAttrTag : Tl3Tag;   virtual;
    property AttrParentTag : Tl3Tag read GetEVDAttrParentTag;
    property AttrTag : Tl3Tag read GetEVDAttrTag;

   public
    constructor Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute); overload; virtual;
    constructor Create(aAttrManager : TDocAttributeManager);                         overload; virtual;
        {-}
    function    COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;          override;
    function    IsEmpty : Boolean;                                                   virtual; abstract;
    procedure   Delete(aIndex : Integer = 0);                                        virtual;
    procedure   DeleteByHandle(aHandle : Integer);                                   virtual; abstract;
    procedure   DeleteAll;                                                           virtual;
    procedure   DeleteAllforPart(aDocPart : Tm3DocPartSelector);                     virtual;

    function    Get_Modified : Boolean;                                              virtual; abstract;
    procedure   Set_Modified(aValue : Boolean);                                      virtual; abstract;

    function    Get_SubID : TSubID;                                                  //virtual;
    procedure   Set_SubID(aValue : TSubID);                                          virtual;

    function    Get_Count : Integer;                                                 virtual; abstract;

    procedure   Copy(aSrcAttr : IDocAttribute);                                      virtual;
    procedure   Load;

    //function    GetViewString(aIndex : Integer = 0) : String;                        virtual; abstract;

    property AttrID : TdtAttribute read Get_AttrID;
    property SubID : TSubID read  Get_SubID write Set_SubID;
    property Modified : Boolean read Get_Modified write Set_Modified;
  end;

  TListDocAttribute = class(TCustomDocAttribute, Il3IntegerList, IListDocAttribute, Il3ViewStringList, Il3Notify, Il3ItemNotifyRecipient, Il3ChangeRecipient)
   private
    {Il3IntegerList}
    function Il3IntegerList.pm_GetEmpty = IsEmpty;
    function pm_GetFirst: Integer; dynamic; abstract;
    function pm_GetLast: Integer;  dynamic; abstract;
    function Il3IntegerList.pm_GetItems = Get_Handle;
    function Il3IntegerList.pm_GetCount = Get_Count;

   private
    fInNotify : Boolean;
    fModified : Boolean;

    procedure IterateFfromAllSabs(anAction : TAttrBoxAction);
    procedure CollectfromAllSabs;
    function  GetEVDAttrTag : Tl3Tag;                                override;
    function  MakeAttrTag : Tl3Tag;                                  override;

    procedure Notify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer); virtual;
    //procedure Changing;                                              override;
    procedure FireChanged;                                           override;

    procedure Set_SubID(aValue : TSubID);                            override;

    procedure MakeName(lItem : Tl3Tag);                        override;
    procedure DropName(lItem : Tl3Tag);

    function  CheckUniq(aTag : Tl3Tag) : boolean;              virtual;
    function  Add(aTag : Tl3Tag) : Integer;                    overload;
    function  AddPrim(aTag : Tl3Tag) : Integer;                virtual;

    function  Get_ViewString(aIndex: Longint) : Tl3PCharLen;         virtual;
    procedure Set_ViewString(aIndex: Longint; aValue : Tl3PCharLen); virtual;

    {Il3ViewStringList}
    function  pm_GetViewString(anIndex: Integer): Il3CString;
    function  Il3ViewStringList.pm_GetCount = Get_Count;

    function  HandleTag : Integer;                                   virtual;
    function  Get_Handle(aIndex : Integer) : Integer;                virtual;
    function  Get_Child(aIndex : Integer) : Tl3Tag;                  virtual;

    function  Get_Modified : Boolean;                                override;
    procedure Set_Modified(aValue : Boolean);                        override;

    function  Get_Count : Integer;                                   override;

    function  GetIndexByHandle(aHandle : Integer) : Integer;         virtual;

    function EditData(aHandle : Integer; aValue : Pointer) : Boolean; virtual; abstract;
    function EditItem(aIndex : Integer) : Boolean;            virtual; abstract;
    {* - Вызывает форму редактирования элемента списка. Если aIndex = -1, то добавляется новый элемент}

   public
        {-}
    function  IsEmpty : Boolean;                             override;
    procedure Delete(aIndex : Integer = 0);                  override;
    procedure DeleteByHandle(aHandle : Integer);             override;

    //function  GetViewString(aIndex : Integer = 0) : String;  override;

    property  Child[aIndex: Longint] : Tl3Tag
     read Get_Child;

    property  Handle[aIndex: Longint] : Integer
     read Get_Handle;

    property  Count : Integer read Get_Count;
  end;

  TGroupDocAttribute = class(TListDocAttribute)
   private
    //procedure ClearRecHandle(aValue : Pointer);              virtual; abstract;
  end;

  TDateNumDocAttribute = class(TGroupDocAttribute, IDateNumDocAttributeTool)
   private
    procedure MakeName(aItem : Tl3Tag);                override;
    function EditItem(aIndex : Integer): Boolean;            override;
    function  CheckUniq(aTag : Tl3Tag) : boolean;      override;
    {IDateNumDocAttributeTool}
    function  GetMinPublishDate(aNum : Pl3PrimString = nil): TStDate;
    function  GetChDate : TStDate;
    function  GetCasecode: Il3CString;
    function  GetType(aIndex : Integer): TDNType;
    function  GetDate(aIndex : Integer) : TstDate;
    function  GetNum(aIndex : Integer) : Il3CString;
    procedure UpcaseNum(aIndex : Integer);

    procedure DeleteAllChangerRec;

    function  AddRec(aType : TDNType; aDate : TStDate;  aDocID  : TDocID; aSubID  : TSubID) : integer; overload;
    function  AddRec(aType : TDNType; aDate : TStDate; aNumber : Tl3WString) : integer; overload;

   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TActiveIntervalListDocAttribute = class(TGroupDocAttribute, IActiveIntervalsAttributeTool)
   private
    procedure MakeName(aItem : Tl3Tag);                override;

    function InsertDiapason(aItem : Tl3Tag; aOldIndex: Integer = -1) : Integer;
    {* - вставляет aItem в список диапазонов дат c учетом сортировки}

    function  CheckUniq(aTag : Tl3Tag) : boolean;      override;
    function  CheckIntersect(aItem : Tl3Tag; aOldIndex: Integer = -1) : Boolean;

    function EditItem(aIndex : Integer): Boolean;            override;

    {IActiveIntervalsAttributeTool}
    function  IsActive: Boolean;
    function  IsDelayed: Boolean;
    function  MinDate : TstDate;
    function  GetLastIntervalIndex : integer;
    procedure CloseInterval(aIndex : integer; aEDate : TstDate);
    procedure CopyNotSureRecTo(aActIntervalAttr : IListDocAttribute);

     {* - Интервал действия не задан}
    function GetDiapasonData(var aSDate, aEDate : TstDate; out aReason : Tl3Tag) : Boolean;

    procedure AddRec(aStart, aFinish  : TStDate{; aComment : Tl3WString = cc_UnAssignedStr});
    procedure AddDefDiapason;

   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TAlarmDocAttribute = class(TGroupDocAttribute, IAlarmAttributeTool)
   private
    procedure MakeName(aItem : Tl3Tag);                override;
    function  CheckUniq(aTag : Tl3Tag) : boolean;      override;
    function  EditItem(aIndex : Integer): Boolean;            override;
    procedure AddRec(aDate : TStDate; aMessage : Tl3WString);
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TStagesDocAttribute = class(TGroupDocAttribute, IStageDocAttributeTool)
   private
    function HandleTag : Integer;          override;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;

   {IStageDocAttributeTool}
    function  CheckStageClosed(aStageType : TStageType): Boolean;
    procedure CloseStage(aStageType : TStageType);
    function  DateOfStageClosed(aStageType : TStageType): TStDate;

    function  MakeStage(aStageType : TStageType): Integer;
    procedure SetStartDate(aIndex : Integer; aDate : TstDate);
    procedure SetEndDate  (aIndex : Integer; aDate : TstDate);
    function  GetStartDate(aIndex : Integer) : TstDate;
    function  GetEndDate  (aIndex : Integer) : TstDate;
    function  GetAuthor   (aIndex : Integer) : TUserID;
    procedure SetAuthor   (aIndex : Integer; aUserID : TUserID);
    function  CheckEditEnable(aStageType : TStageType; aDateKind : Byte) : Boolean;
  end;

  TSingleItemListDocAttribute = class(TListDocAttribute)
  private
   fName : Tl3String;
   function  Get_Count : Integer;                            override;
   function  Get_Child(aIndex : Integer) : Tl3Tag;           override;
   function  AddPrim(aTag : Tl3Tag) : Integer;               override;
   function  Get_ViewString(aIndex: Longint) : Tl3PCharLen;  override;
   procedure Delete(aIndex : Integer = 0);                   override;
  protected
   procedure Cleanup;                                        override;
  end;

  TDocIDsAttribute = class(TListDocAttribute)
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TVerLinkAttribute = class(TSingleItemListDocAttribute, IIntegerDocAttribute)
   private
    procedure MakeName(aItem : Tl3Tag);                      override;
    procedure Set_Value(aValue : Integer);
    function  Get_Value : Integer;
    procedure Delete(aIndex : Integer = 0);                  override;
    function  AddPrim(aTag : Tl3Tag) : Integer;              override;

   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
    function  EditItem(aIndex : Integer): Boolean;           override;
  end;

  TLogAttribute = class(TListDocAttribute, ILogDocAttributeTool)
   private
    fLogType : TLogActionFlags;
    fDocPart : Tm3DocPartSelector;

    function   Get_DocPart : Tm3DocPartSelector;            override;
    procedure  Set_DocPart(aValue : Tm3DocPartSelector);

    procedure MakeName(aItem : Tl3Tag);                      override;
    procedure Delete(aIndex : Integer = 0);                  override;

    function  Get_Child(aIndex : Integer) : Tl3Tag;          override;
    {tools}
    procedure AddAction(aAction : TLogActionType; aDate : TstDate = 0);
    procedure DelAction(aAction : TLogActionType);
    function  HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean; overload;
    function  HasDocThisLogRec(aActions : TLogActionSet; aDate : TStDate = 0 {Any Date}): boolean; overload;
    procedure AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});
    function  IsAnnoAction(aIndex : Integer) : boolean;

    property DocPart : Tm3DocPartSelector read Get_DocPart write Set_DocPart;
   public
    function  EditItem(aIndex : Integer): Boolean;           override;
  end;

  TLogSumAttribute = class(TListDocAttribute, ILogDocAttributeTool)
   private
    f_DocAttr  : TLogAttribute;
    f_AnnoAttr : TLogAttribute;

    function GetEVDAttrParentTag : Tl3Tag; override; // после отладки удалить
    function  SelectAttr(var aIndex : Integer) : TLogAttribute;     overload;
    function  SelectAttr(aAction : TLogActionType) : TLogAttribute; overload;

    procedure Delete(aIndex : Integer = 0);                         override;
    procedure DeleteAllforPart(aDocPart : Tm3DocPartSelector);      override;

    function  Get_ViewString(aIndex: Longint) : Tl3PCharLen;        override;
    function  Get_Child(aIndex : Integer) : Tl3Tag;                 override;
    function  Get_Count : Integer;                                  override;
    {tools}
    procedure AddAction(aAction : TLogActionType; aDate : TstDate = 0);
    procedure DelAction(aAction : TLogActionType);
    function  HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean; overload;
    function  HasDocThisLogRec(aActions : TLogActionSet; aDate : TStDate = 0 {Any Date}): boolean; overload;
    procedure AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});
    function  IsAnnoAction(aIndex : Integer) : boolean;
    procedure Cleanup;                                        override;
    //procedure FireChanged;                                    override;
   public
    constructor Create(aAttrManager : TDocAttributeManager; aLogType : TLogActionFlags); overload;
    function  EditItem(aIndex : Integer): Boolean;           override;
  end;

  TJurOperationAttribute = class(TLogSumAttribute)
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TOrdOperationAttribute = class(TLogSumAttribute)
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TLogGrOpAttribute = class(TLogAttribute)
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TDictDocAttribute = class(TListDocAttribute, IDictAttributeTool)
   private
    fSingleValue : boolean; // 0 или 1 элемент в списке
    procedure MakeName(aItem : Tl3Tag);                override;
    function  CheckUniq(aTag : Tl3Tag) : boolean;      override;
    function  AddPrim(aTag : Tl3Tag) : Integer;        override;
   public
    constructor Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute; aSingleValue : boolean = false); overload;
    procedure Copy(aSrcAttr : IDocAttribute);                override;
    procedure DeleteAll;                                     override;
    function  EditItem(aIndex : Integer): Boolean;           override;
    procedure AddRec(aItemID : Integer);
  end;

  TPublishedDocAttribute = class(TGroupDocAttribute, IPublishedDocAttributeTool)
   private
    procedure MakeName(aItem : Tl3Tag);                     override;
    function  CheckUniq(aTag : Tl3Tag) : boolean;            override;
    function EditItem(aIndex : Integer): Boolean;            override;

    {IPublishedDocAttributeTool}
    function IsImageExists(aIndex : Integer) : Boolean;
    function GetImagePath(aIndex : Integer) : String;
    function GetImagePageStr(aIndex : Integer) : String;
   public
    constructor Create(aAttrManager : TDocAttributeManager); override;
  end;

  TCorrectsAttribute = class(TGroupDocAttribute)
   private
    fPublishedsNotifier : Il3ChangeNotifier;

    procedure MakeName(aItem : Tl3Tag);                       override;
    function  CheckUniq(aTag : Tl3Tag) : boolean;             override;
    function EditItem(aIndex : Integer): Boolean;             override;
    procedure Notify(const aNotifier : Il3ChangeNotifier;
                     aOperation : Integer; aIndex : Integer); override;
   protected
    procedure Cleanup;                                        override;
   public
    constructor Create(aAttrManager : TDocAttributeManager);  override;
  end;

 TListOfDocAttribute = class(TListDocAttribute)
  private
   //function Get_List: Tl3CustomDataList; override;
   //function Get_NameList: Tl3StringDataList; override;
  public
  end;

  TVersionListAttribute = class(TListOfDocAttribute, IVersionListAttributeTool)
  private
   procedure LoadList;
   function GetIconIndex(aIndex : Integer) : Integer;
   function IsActive(aIndex : Integer) : Boolean;
   function MakeDocSab : ISab;

   function  Get_Modified : Boolean;                                override;
   procedure Set_Modified(aValue : Boolean);                        override;
  public
   constructor Create(aAttrManager : TDocAttributeManager);  override;
  end;

  TDoc2DocAttribute = class(TListDocAttribute)
  private
   procedure MakeName(aItem : Tl3Tag);                override;
   //function Get_List: Tl3CustomDataList; override;
   //function GetViewStringOfData(aData : Pointer): String; override;
  public
   constructor Create(aAttrManager : TDocAttributeManager); override;
   function EditItem(aIndex : Integer): Boolean; override;
  end;

type
 EAttrWriteError = class(El3NoLoggedException)
 public
  constructor Create(aAttrID : TdtAttribute; const aReasonMsg : string); overload;
 end;

 EDiapasonIntersect = class(El3NoLoggedException)
 end;

implementation

uses
  ActiveX,
  Forms, Printers, Dialogs, vtDialogs,
  StrShop, IniShop, VConst, Com_Cnst,
  DT_Serv, Dt_CFltr, Dt_RecalcHLinkFilter, DT_User,
  //mgBasStr, mgExFStr, mgLnkStr,
  //mgHasPar,
  //m2COMLib,
  m3StorageInterfaces,
  Readers,
  k2Tags, k2List,
  k2TagByHandleView,
  ddDocReader, ddNSRC_r,
  l3Bits,
  l3MinMax,
  l3Chars,
  l3Filer,
  l3BaseStream,
  l3Stream,
  l3String,
  l3Nodes,
  l3BitmapContainer,
  l3InterfacesMisc,
  l3Tree_TLB, l3TreeInterfaces,
  l3TreeSupport,
  l3Languages,

  daDataProvider,
  daTypes,

  DT_TblCache,
  Dt_DocImages,
  dt_DictTypes, dt_DictConst,
  dt_Renum,

  evStatisticsFilter,
  evConst,
  evTextFormatter,
  evDocumentPreview,
  evFacadeSub,
  nevTools,

  evdTypes,

  DictMetaForm, TreeDWin, D_AttrActiveInterval, D_IntEdit, d_GetJurOp, D_PublIn,
  D_SrcChk, D_PaperWhere, D_AttrAlarm, D_DateNumberEditor, D_Doc2DocLinkEdit,
  {DocAttrStructs,} StDateSt,
  imageenio,
  m3DB,
  DictItem_Const,
  Sub_Const,
  Block_Const,

  DocAttrTypes, DocAttrUtils,

  AddrSup,
  ResShop;

{$Include l3LockedChange.imp.pas}

{$Include l3COMQueryInterface.imp.pas}

function  L2AttrBoxA(Action: Pointer): TAttrBoxAction; register;
  {* - делает заглушку для локальной процедуры. }
asm
  jmp  l3LocalStub
end;{asm}

constructor EAttrWriteError.Create(aAttrID : TdtAttribute; const aReasonMsg : string);
begin
 CreateFmt('Не удалось записать атрибут "%s"'^M'по причине : %s', [GetAttrName(aAttrID), aReasonMsg]);
end;

procedure GetListFromTree(const aTree : Il3Tree; const aAttr : TDictDocAttribute; aWithMasterDict : boolean = false);  overload;
var
 lCurNode  : Il3Node;
 lCurParam : Longint;
 lExtNode  : Il3ExtItemNode;
begin
 with aAttr do
 begin
  Changing;
  try
   DeleteAll;
   If aTree = nil then Exit;
   lCurNode := Nil;
   Repeat
    lCurNode := aTree.GetNextSelect(lCurNode);
    If lCurNode = Nil then break;
    lCurParam := (lCurNode as Il3HandleNode).Handle;
     if aWithMasterDict and not Supports(lCurNode, Il3ExtItemNode, lExtNode) then
     lCurParam := - lCurParam;
    AddRec(lCurParam);
   until false;
  finally
   Changed;
  end;
 end;
end;

{TCustomDocAttribute}

constructor TCustomDocAttribute.Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute);
begin
 Create(aAttrManager);
 fAttrID := aAttrID;
end;

constructor TCustomDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create;
 fAttrManager := aAttrManager;
end;

function  TCustomDocAttribute.Get_SubID : TSubID;
begin
 Result := fSubID;
end;

procedure TCustomDocAttribute.Set_SubID(aValue : TSubID);
begin
 if fSubID = aValue then Exit;
 Changing;
 fSubID := aValue;
 fAttrTag := nil;
 Changed;
end;

function TCustomDocAttribute.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
begin
 if IID.SomeOf([IDocAttributeManager]) then
  Result := Tl3HResult_C(l3QueryInterface(fAttrManager, IID, Obj))
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

function TCustomDocAttribute.Get_AttrID : TdtAttribute;
begin
 Result := fAttrID;
end;

function TCustomDocAttribute.Get_DocPart : Tm3DocPartSelector;
begin
 if fAttrID in cAnnoAttrs then
  Result := m3_dsAnno
 else
  Result := m3_dsMain;
end;

procedure TCustomDocAttribute.Copy(aSrcAttr : IDocAttribute);
begin
 Assert(False, Format('Copy not Defined AttrID = %d', [Ord(fAttrID)]));
end;

function TCustomDocAttribute.GetEVDAttrParentTag : Tl3Tag;
var
 l_Sab    : IevSub;
 l_DocText: TarTextOfDocument;
begin
 l_DocText := fAttrManager.GetTextSourceforAttr(Self);
 if l_DocText = nil then
 begin
  Result := nil;
  Exit;
 end; // if l_DocText = nil then
 if fSubId = 0 then
  Result := l_DocText.Document
 else
 begin
  l_Sab := evGetSubList(l_DocText).Sub[fSubId];
  if l_Sab.Exists then
   Result := l_Sab.SubInstance;
 end;
end;

function TCustomDocAttribute.GetEVDAttrTag : Tl3Tag;
var
 lEVDDoc : Tl3Tag;
begin
 if (fAttrTag = nil) or (not fAttrTag.AsObject.IsValid) then
 begin
  lEVDDoc := AttrParentTag;
  if lEVDDoc.IsValid then
   fAttrTag := lEVDDoc.Attr[cAttr2k2Tag[AttrID]].AsRef;
 end;
 if fAttrTag <> nil then
  Result := fAttrTag.AsObject
 else
  Result := nil;
end;

function TCustomDocAttribute.MakeAttrTag : Tl3Tag;
{- получить, а если не было - создать}
var
 lEVDDoc : Tl3Tag;
begin
 if (fAttrTag = nil) or (not fAttrTag.AsObject.IsValid) then
 begin
  lEVDDoc := AttrParentTag;
  if lEVDDoc.IsValid then
   fAttrTag := lEVDDoc.cAtom(cAttr2k2Tag[AttrID]).AsRef;
  Result := fAttrTag.AsObject;
 end
 else
  Result := fAttrTag.AsObject;
end;

procedure TCustomDocAttribute.Delete(aIndex : Integer = 0);
begin
 DeleteAll;
end;

procedure TCustomDocAttribute.DeleteAll;
var
 lCnt : Integer;
begin
 lCnt := Get_Count;
 if lCnt = 0 then exit;
 Changing;
 try
  CallNotify(ntClear, lCnt);
  AttrParentTag.AttrW[cAttr2k2Tag[AttrID], nil] := nil;
  fAttrTag := nil;

  Modified := True;
 finally
  Changed;
 end;
end;

procedure TCustomDocAttribute.DeleteAllforPart(aDocPart : Tm3DocPartSelector);
begin
 if aDocPart = Get_DocPart then
  DeleteAll;
end;

procedure TCustomDocAttribute.Load;
begin
 if fInLoad then Exit;
 try
  fInLoad := True;
  //LoadPrim;
 finally
  fInLoad := False;
 end;
end;

{TActiveIntervalListDocAttribute}
constructor TActiveIntervalListDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atActiveIntervals;
end;

function  TActiveIntervalListDocAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
begin
 Result := not CheckIntersect(aTag);
end;

function TActiveIntervalListDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lActIntRec  : TActiveIntervalRec;
 lIsInserted : Boolean;
 lRecEmpty   : Boolean;
 lChild      : Tl3Tag;
begin
{Result := Count = 0;

 with AttrTag do
  for I := 0 to Pred(Count) do
  begin
   with Child[I] do
   Result := DateInBounds(CurrentDate, MakeDateBounds(IntA[k2_tiStart], IntA[k2_tiFinish]));
   if Result then Exit;
  end;}

 Result := False;
 lRecEmpty := aIndex < 0;

 if lRecEmpty then // new child
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject
 else
  lChild := Child[aIndex];

 repeat
  Result := GetAttrActiveInterval(lChild, lRecEmpty);
  if Result then
   begin
    try
     lIsInserted := True;
     aIndex := InsertDiapason(lChild, aIndex);
     Result := aIndex >= 0;
    except
     on E : EDiapasonIntersect do
     begin
      Application.ShowException(E);
      lIsInserted := False;
      lRecEmpty := False;
     end;
    end;
   end;
  until lIsInserted or not Result;
end;

function TActiveIntervalListDocAttribute.CheckIntersect(aItem : Tl3Tag; aOldIndex: Integer = -1) : Boolean;
var
 I : Integer;
begin
 Result := False;
 if aItem.IntA[k2_tiType] = 1 then Exit;

 with AttrTag do
 for I := 0 to Pred(Count) do
  with Child[I] do
  if (I <> aOldIndex) and
     (IntA[k2_tiType] = 0) and
     IsDateBoundsIntersected(MakeDateBounds(aItem.IntA[k2_tiStart], IntA[k2_tiFinish]),
                             MakeDateBounds(IntA[k2_tiStart], IntA[k2_tiFinish])) then
  begin
   Result := True;
   Break;
  end;
end;

function TActiveIntervalListDocAttribute.InsertDiapason(aItem : Tl3Tag; aOldIndex: Integer = -1) : Integer;
begin
 Result := 0;
 if CheckIntersect(aItem, aOldIndex) then
  raise EDiapasonIntersect.Create('Пересечение диапазонов дат.');

 Changing;
 try
  // пересортировка выполняется методом изъять/добавить
  aItem.Use; // иначе при добавлении подтеги зачистит
  try
   if (aOldIndex >= 0) then
    Delete(aOldIndex);
   Result := AddPrim(aItem);
  finally
   l3Free(aItem);
  end;
 finally
  Changed;
 end;
end;

procedure TActiveIntervalListDocAttribute.MakeName(aItem : Tl3Tag);
begin
 GenActiveIntervalString(aItem);
end;

function TActiveIntervalListDocAttribute.IsActive: Boolean;
var
 I : Integer;
 lDate : TStDate;
begin
 Result := Count = 0;
 lDate := CurrentDate;
 with AttrTag do
  for I := 0 to Pred(Count) do
  begin
   with Child[I] do
   Result := DateInBounds(lDate, MakeDateBounds(IntA[k2_tiStart], IntA[k2_tiFinish]));
   if Result then Exit;
  end;
end;

function TActiveIntervalListDocAttribute.IsDelayed: Boolean;
var
 I : Integer;
begin
 Result := Count = 0;

 with AttrTag do
  for I := 0 to Pred(Count) do
  begin
   with Child[I] do
    Result := (IntA[k2_tiType] = actt_Normal) and (IntA[k2_tiStart] = maxActiveDate) and (IntA[k2_tiFinish] = maxActiveDate);
   if Result then Exit;
  end;
end;

function TActiveIntervalListDocAttribute.MinDate : TstDate;
begin
 Result := BlankDate;
 if Count > 0 then
 begin
  Result := Child[0].IntA[k2_tiStart];
  if (Result = maxActiveDate) or (Result = minActiveDate) then
   Result := BlankDate;
 end;
end;

function TActiveIntervalListDocAttribute.GetLastIntervalIndex : integer;
var
 I : Integer;
begin
 Result := -1;
 for I := Pred(Count) downto 0 do
  with Child[I] do
   if (IntA[k2_tiType] = actt_Normal) then
   begin
    Result := I;
    Break;
   end;
end;

procedure TActiveIntervalListDocAttribute.CloseInterval(aIndex : integer; aEDate : TstDate);
begin
 Changing;
 try
  with Child[aIndex] do
  begin
   IntA[k2_tiFinish] := aEDate;
   AttrW[k2_tiName, nil] := nil;
  end;
  Modified := True;
 finally
  Changed;
 end;
end;

procedure TActiveIntervalListDocAttribute.CopyNotSureRecTo(aActIntervalAttr : IListDocAttribute);
var
 I : Integer;
 lTag : Tl3Tag;
begin
 with AttrTag do
  for I := 0 to Pred(Count) do
  begin
   lTag := Child[I];
   if lTag.IntA[k2_tiType] = actt_Unsure then
    aActIntervalAttr.Add(lTag);
  end;
end;

function TActiveIntervalListDocAttribute.GetDiapasonData(var aSDate, aEDate : TstDate; out aReason : Tl3Tag) : Boolean;
var
 lIndb : Integer;
 lIndE : Integer;
begin
 aReason := nil;
 with AttrTag do
 begin
  Result := Count > 0;
  If not Result then Exit;

  lIndE := Pred(Count);
  while lIndE >= 0 do
  begin
   if Child[lIndE].IntA[k2_tiType] = actt_Normal then Break;
   Dec(lIndE);
  end;

  if lIndE < 0 then
  begin
   Result := False;
   Exit;
  end;

  lIndB := 0;
  while lIndB < Count do
  begin
   if Child[lIndB].IntA[k2_tiType] = actt_Normal then Break;
   Inc(lIndB);
  end;

  aSDate := Child[lIndB].IntA[k2_tiStart];
  aEDate := Child[lIndE].IntA[k2_tiFinish];
  aReason := Child[lIndE].Attr[k2_tiComment];
 end;
end;

procedure TActiveIntervalListDocAttribute.AddDefDiapason;
begin
 AddRec(minActiveDate, maxActiveDate);
end;

procedure TActiveIntervalListDocAttribute.AddRec(aStart, aFinish  : TStDate{; aComment : Tl3WString = cc_UnAssignedStr});
var
 lChild      : Tl3Tag;
begin
 with MakeAttrTag do
  lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
 with lChild do
 begin
  IntA[k2_tiStart] := aStart;
  IntA[k2_tiFinish] := aFinish;
  //if aComment <> '' then
  // PCharLenA[k2_tiComment] := aComment;
 end;

 Add(lChild);
end;

{TLogAttribute}

function TLogAttribute.Get_DocPart : Tm3DocPartSelector;
begin
 Result := fDocPart;
end;

procedure TLogAttribute.Set_DocPart(aValue : Tm3DocPartSelector);
begin
 fDocPart := aValue;
end;

function TLogAttribute.EditItem(aIndex : Integer): Boolean;
var
 lChild      : Tl3Tag;
begin
 Result := False;

 if aIndex < 0 then // new child
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject
 else
  lChild := Child[aIndex];

 Result := GetJurOperation(lChild, aIndex < 0);

 if Result and (aIndex < 0) then
  Add(lChild);
end;

function  TLogAttribute.Get_Child(aIndex : Integer) : Tl3Tag;
begin
 Result := AttrTag.Child[aIndex];
end;

procedure TLogAttribute.Delete(aIndex : Integer = 0);
begin
 Inherited Delete(aIndex);
end;

procedure TLogAttribute.MakeName(aItem : Tl3Tag);
begin
// !!две разных реализации для дока и групповой операции
 if fAttrManager.AttrOperateMode = aomGroupEdit then
  GenLogString_forGroupEdit(aItem)
 else
  GenLogString(aItem);
end;

procedure TLogAttribute.AddAction(aAction : TLogActionType; aDate : TstDate = 0);
var
 lChild : Tl3tag;
begin
 with MakeAttrTag do
  lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
 with lChild do
 begin
  IntA[k2_tiType] := Ord(aAction);
  if aDate = 0 then
   aDate := CurrentDate;
  IntA[k2_tiStart] := aDate;

  //if fAttrID = atOrdLogRecords then
   IntA[k2_tiTime] := CurrentTime;

  with CAtom(k2_tiUser) do
   IntA[k2_tiHandle] := Integer(GlobalDataProvider.UserID);
 end;

 Add(lChild);
end;

procedure TLogAttribute.DelAction(aAction : TLogActionType);
var
 I : Integer;
 lRec : PDisplayLogRec;
begin
 I := Pred(Count);

 with AttrTag do
  while I >= 0 do
  begin
   if Child[I].IntA[k2_tiType] = Ord(aAction) then
    Delete(I);
   Dec(I);
  end;
end;

function TLogAttribute.HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean;
begin
 Result := HasDocThisLogRec([aAction], aDate);
end;

function TLogAttribute.HasDocThisLogRec(aActions : TLogActionSet; aDate : TStDate = 0 {Any Date}): boolean;
var
 I : Integer;
begin
 Result := False;
 I := Pred(Count);
 with AttrTag do
  for I := Pred(Count) downto 0 do
  begin
   with Child[I] do
    Result := (TLogActionType(IntA[k2_tiType]) in aActions) and ((aDate = 0) or (IntA[k2_tiStart] = aDate));
   if Result then Break;
  end;
end;

procedure TLogAttribute.AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});
{* Если aCheckDate = 0, то проверяется наличие команды с любой датой,
   Если aAddDate = 0, то добавляется с текущей датой}
begin
 if not HasDocThisLogRec(aAction, aCheckDate) then
  AddAction(aAction, aAddDate);
end;

function  TLogAttribute.IsAnnoAction(aIndex : Integer) : boolean;
begin
 result := TLogActionType(Child[aIndex].IntA[k2_tiType]) in cAnnoLogActions;
end;

{TLogSumAttribute}

//    f_DocAttr  : TLogAttribute;
//    f_AnnoAttr : TLogAttribute;

function TLogSumAttribute.GetEVDAttrParentTag : Tl3Tag;
begin
 Assert(false, 'TLogSumAttribute.GetEVDAttrParentTag');
end;

constructor TLogSumAttribute.Create(aAttrManager : TDocAttributeManager; aLogType : TLogActionFlags);
var
 lAttrID  : TdtAttribute;
begin
 case aLogType of
  acfOrdinal : lAttrID := atOrdLogRecords;
  acfJuror   : lAttrID := atJurLogRecords;
 end;

 Inherited Create(nil); //  aAttrManager гасим, работать с ним будут вложенные (иначе в FireChanged лишняя нотификация идет)
 fAttrID := lAttrID;

 f_DocAttr  := TLogAttribute.Create(aAttrManager);
 f_DocAttr.fAttrID := lAttrID;
 f_DocAttr.fLogType := aLogType;
 f_DocAttr.DocPart := m3_dsMain;
 f_DocAttr.Subscribe(Self);

 f_AnnoAttr := TLogAttribute.Create(aAttrManager);
 f_AnnoAttr.fAttrID := lAttrID;
 f_AnnoAttr.fLogType := aLogType;
 f_AnnoAttr.DocPart := m3_dsAnno;
 f_AnnoAttr.Subscribe(Self);
end;

procedure TLogSumAttribute.Cleanup;
begin
 f_DocAttr.Subscribe(Self);
 f_AnnoAttr.Subscribe(Self);
 l3Free(f_DocAttr);
 l3Free(f_AnnoAttr);
 Inherited;
end;

//procedure TLogSumAttribute.FireChanged;
//begin
 // наверх не нотифицируем, это сделают вложенные
//end;

function TLogSumAttribute.Get_Count : Integer;
begin
 Result := f_DocAttr.Count + f_AnnoAttr.Count;
end;

function TLogSumAttribute.SelectAttr(var aIndex : Integer) : TLogAttribute;
begin
 if (f_DocAttr <> nil) then
  if (aIndex < f_DocAttr.Count) then
  begin
   Result := f_DocAttr;
   Exit;
  end
  else
   Dec(aIndex, f_DocAttr.Count);

 //if (f_AnnoAttr <> nil) then
 Result := f_AnnoAttr;
end;

function TLogSumAttribute.SelectAttr(aAction : TLogActionType) : TLogAttribute;
begin
 if aAction in cAnnoLogActions then
  Result := f_AnnoAttr
 else
  Result := f_DocAttr;
end;

procedure TLogSumAttribute.DeleteAllforPart(aDocPart : Tm3DocPartSelector);
begin
 Changing;
 try
  case aDocPart of
   m3_dsMain : f_DocAttr.DeleteAll;
   m3_dsAnno : f_AnnoAttr.DeleteAll;
  end;
 finally
  Changed;
 end;
end;

function  TLogSumAttribute.Get_ViewString(aIndex: Longint) : Tl3PCharLen;
begin
 Result := SelectAttr(aIndex).Get_ViewString(aIndex);
end;

function  TLogSumAttribute.IsAnnoAction(aIndex : Integer) : boolean;
begin
 Result := TLogActionType(Child[aIndex].IntA[k2_tiType]) in cAnnoLogActions;
end;

procedure TLogSumAttribute.Delete(aIndex : Integer = 0);
begin
 SelectAttr(aIndex).Delete(aIndex);
end;

function  TLogSumAttribute.Get_Child(aIndex : Integer) : Tl3Tag;
begin
 Result := SelectAttr(aIndex).Get_Child(aIndex);
end;

procedure TLogSumAttribute.AddAction(aAction : TLogActionType; aDate : TstDate = 0);
begin
 SelectAttr(aAction).AddAction(aAction, aDate);
end;

procedure TLogSumAttribute.DelAction(aAction : TLogActionType);
begin
 SelectAttr(aAction).DelAction(aAction);
end;

function  TLogSumAttribute.HasDocThisLogRec(aAction : TLogActionType; aDate : TStDate = 0 {Any Date}): boolean;
begin
 Result := SelectAttr(aAction).HasDocThisLogRec(aAction, aDate);
end;

function  TLogSumAttribute.HasDocThisLogRec(aActions : TLogActionSet; aDate : TStDate = 0 {Any Date}): boolean;
var
 lActions : TLogActionSet;
begin
 lActions := aActions * cDocLogActions;
 if lActions <> [] then
  Result := f_DocAttr.HasDocThisLogRec(aActions, aDate);

 lActions := aActions * cAnnoLogActions;
 if lActions <> [] then
  Result := f_AnnoAttr.HasDocThisLogRec(aActions, aDate);

end;

procedure TLogSumAttribute.AddLogRecOnce(aAction : TLogActionType; aCheckDate : TStDate = 0 {Any Date}; aAddDate : TStDate = 0 {Today});
begin
 SelectAttr(aAction).AddLogRecOnce(aAction, aCheckDate, aAddDate);
end;

function  TLogSumAttribute.EditItem(aIndex : Integer): Boolean;
begin
 Result := SelectAttr(aIndex).EditItem(aIndex);
end;

{TJurOperationAttribute}
constructor TJurOperationAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager, acfJuror);
 //fAttrID := atJurLogRecords;
end;

{TOrdOperationAttribute}

constructor TOrdOperationAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager, acfOrdinal);
 //fAttrID := atOrdLogRecords;
 //fLogType := acfOrdinal;
end;


constructor TLogGrOpAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atJurLogRecords;
 fLogType := acfJuror;
 DocPart := m3_dsMain;
end;

{TAlarmDocAttribute}
constructor TAlarmDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 inherited Create(aAttrManager);
 fAttrID := atAlarms;
end;

procedure TAlarmDocAttribute.MakeName(aItem : Tl3Tag);
begin
 GenAlarmString(aItem);
end;

function TAlarmDocAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
var
 I : Integer;
begin
 for I := 0 to pred(Count) do
  with Child[I] do
   if (IntA[k2_tiStart] = aTag.IntA[k2_tiStart]) and
      l3Same(PCharLenA[k2_tiComment], aTag.PCharLenA[k2_tiComment]) then
   begin
    Result := False;
    Exit;
   end;

 Result := True;
end;

function TAlarmDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lRecEmpty   : Boolean;
 lChild      : Tl3Tag;
begin
 Result := False;

 lRecEmpty := aIndex < 0;

 if lRecEmpty then // new child
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject
 else
  lChild := Child[aIndex];

 Result := GetAttrAlarm(lChild, lRecEmpty);

 if Result then
 begin
  Changing;
  try
   if lRecEmpty then
    Add(lChild)
   else
    Modified := True;
  finally
   Changed;
  end;
 end;
end;

procedure TAlarmDocAttribute.AddRec(aDate : TStDate; aMessage : Tl3WString);
var
 lChild      : Tl3Tag;
begin
 with MakeAttrTag do
  lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
 with lChild do
 begin
  IntA[k2_tiStart] := aDate;
  if aMessage.SLen <> 0 then
   PCharLenA[k2_tiComment] := Tl3PCharLen(aMessage);
 end;

 Add(lChild);
end;

{TListDocAttribute}
procedure TListDocAttribute.Notify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer);
begin
end;

procedure TListDocAttribute.IterateFfromAllSabs(anAction : TAttrBoxAction);
var
 lObj : Tl3Tag;
 lTag : Tl3Tag;
 I, J : Integer;

 procedure DoSub(lTag : Tl3Tag);
 var
  lAttrBox : Tl3Tag;
 begin
  lAttrBox := lTag.Attr[cAttr2k2Tag[AttrID]];
  if lAttrBox.IsValid then
   anAction(lAttrBox);
 end;

begin
 try
  with fAttrManager.GetTextSourceforAttr(Self) do
  begin
   DoSub(Document.AsObject);
   lTag := Document.rAtomEx([ord(k2_tiSubs), ord(k2_tiChildren), ord(k2_tiHandle), ord(ev_sbtSub)]);
  end; 
  for I := 0 to Pred(lTag.ChildrenCount) do
  begin
   lObj := lTag.Child[I].Attr[k2_tiObject];
   if not lObj.IsKindOf(k2_typBlock) then
   begin
    lObj := lObj.rAtomEx([Ord(k2_tiSubs), Ord(k2_tiChildren), Ord(k2_tiHandle), Ord(ev_sbtSub)]);
    if lObj.IsValid then
     for J := 0 to Pred(lObj.ChildrenCount) do
      DoSub(lObj.Child[J]);
   end
   else
    DoSub(lObj);
  end;
 finally
  l3FreeFA(Tl3FreeAction(anAction));
 end;
end;

procedure TListDocAttribute.CollectfromAllSabs;

 function DoAttrBox(aChildBox : Tl3Tag): Boolean;
 var
  I : Integer;
  lChild : Tl3Tag;
 begin
  Result := True;
  with aChildBox do
   for I := 0 to Pred(ChildrenCount) do
   begin
    lChild := Child[I];
    if not fAttrTag.AsObject.rAtomEx([k2_tiChildren, k2_tiHandle, lChild.IntA[k2_tiHandle]]).IsValid then
     fAttrTag.AsObject.AddChild(lChild);
   end;
 end;

begin
 IterateFfromAllSabs(L2AttrBoxA(@DoAttrBox));
end;

function  TListDocAttribute.GetEVDAttrTag : Tl3Tag;
begin
 if ((fAttrTag = nil) or (not fAttrTag.AsObject.IsValid)) and (fSubID = cAllSubs) then
  Result := MakeAttrTag
 else
  Result := Inherited GetEVDAttrTag;
end;

function TListDocAttribute.MakeAttrTag : Tl3Tag;
begin
 if ((fAttrTag = nil) or (not fAttrTag.AsObject.IsValid)) and (fSubID = cAllSubs) then
 begin
  //Сделаем себе тег и набъем его всеми детьми
  fAttrTag := k2_typSub.Prop[cAttr2k2Tag[AttrID]].TagType.MakeTag;
  with fAttrTag.AsObject.CAtom(k2_tiChildren) do
   if IsValid then
    (asObject as Tk2List).SortIndex := k2_tiHandle;
  CollectfromAllSabs;
 end;

 Result := Inherited MakeAttrTag;
end;

procedure TListDocAttribute.Set_SubID(aValue : TSubID);
begin
 if fSubID = aValue then Exit;
 CallNotify(ntChildClear, Count);
 Inherited;
 CallNotify(ntChildInsert, Count);
 end;

procedure TListDocAttribute.FireChanged;
begin
 Inherited;
 //fAttrTag := nil;
 if Assigned(fAttrManager) and not fInLoad then
  fAttrManager.evntChangeDocAttribute(Self as IDocAttribute);
 //Inherited;
end;

function  TListDocAttribute.Get_ViewString(aIndex: Longint) : Tl3PCharLen;
var
 lItem : Tl3Tag;
begin
 lItem := Child[aIndex];
 Result := lItem.PCharLenA[k2_tiName];
 if Result.SLen = 0 then
 begin
  MakeName(lItem);
  Result := lItem.PCharLenA[k2_tiName];
 end;
end;

function TListDocAttribute.pm_GetViewString(anIndex: Integer): Il3CString;
begin
 Result := l3CStr(Get_ViewString(anIndex));
end;

procedure TListDocAttribute.Set_ViewString(aIndex: Longint; aValue : Tl3PCharLen);
begin
 // не реализовано
 raise Exception.Create('Set_ViewString не реализован');
end;

procedure TListDocAttribute.MakeName(lItem : Tl3Tag);
begin
end;

procedure TListDocAttribute.DropName(lItem : Tl3Tag);
begin
 lItem.AttrW[k2_tiName, nil] := nil;
end;

function  TListDocAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
begin
 Result := True;
end;

function  TListDocAttribute.Add(aTag : Tl3Tag) : Integer;
begin
 if CheckUniq(aTag) then
  Result := AddPrim(aTag);
end;

function  TListDocAttribute.AddPrim(aTag : Tl3Tag) : Integer;
var
 lTag : Tl3Tag;
 lAttrTag : Tl3Tag;
begin
 Changing;
 try
  lAttrTag := MakeAttrTag;
  lTag := aTag.CloneTag.AsObject;
  Result := lAttrTag.AddChild(lTag {aContext: Ik2Op = nil});
  if Result >= 0 then // может не добавиться из-за ограничений evd-схемы
   CallNotify(ntInsert, Result);
 finally
  Changed;
 end;
 Modified := True;
end;

function  TListDocAttribute.HandleTag : Integer;
begin
 Result := k2_tiHandle;
end;

function  TListDocAttribute.Get_Handle(aIndex: Longint) : Integer;
begin
 Result := Child[aIndex].IntA[HandleTag];
end;

function  TListDocAttribute.Get_Child(aIndex : Integer) : Tl3Tag;
begin
 Result := AttrTag.Child[aIndex];
end;

function  TListDocAttribute.IsEmpty : Boolean;
begin
 Result := Count = 0;
end;

function TListDocAttribute.Get_Modified : Boolean;
begin
 Result := fModified;
end;

procedure TListDocAttribute.Set_Modified(aValue : Boolean);
begin
 inherited;
 fModified := aValue;
end;

function  TListDocAttribute.Get_Count : Integer;
begin
 if AttrTag <> nil then
  Result := AttrTag.ChildrenCount
 else
  Result := 0;
end;

function  TListDocAttribute.GetIndexByHandle(aHandle : Integer) : Integer;
//var
 //I : Integer;
 //r1 : Integer;
begin
 if not AttrTag.RAtomEx([k2_tiChildren, HandleTag, aHandle], @Result).IsValid then
  Result := -1;

 {Result := -1;
 for I := 0 to Pred(Count) do
 if Handle[I] = aHandle then
 begin
  Result := I;
  Break;
 end;}
 
end;

procedure TListDocAttribute.DeleteByHandle(aHandle : Integer);
var
 lIndex : Integer;
begin
 lIndex := GetIndexByHandle(aHandle);
 if lIndex >= 0 then
  Delete(lIndex);
end;

procedure TListDocAttribute.Delete(aIndex : Integer = 0);
var
 lHandle : Integer;

 function DoAttrBox(aChildBox : Tl3Tag): Boolean;
 var
  I : Integer;
  lChild : Tl3Tag;
 begin
  Result := True;
  with aChildBox do
   for I := 0 to Pred(ChildrenCount) do
    if Child[I].IntA[k2_tiHandle] = lHandle then
    begin
     DeleteChild(I);
     Exit;
    end;
 end;

begin
  //l_Found := AttrTag.rAtom([k2_tiChildren, k2_tiHandle, lHandle]);
  //if not l_Found.IsExists then
  // Add;

 Changing;
 try
  CallNotify(ntDelete, aIndex);
  if fSubID = cAllSubs then
  begin
   lHandle := AttrTag.Child[aIndex].IntA[k2_tiHandle];
   IterateFfromAllSabs(L2AttrBoxA(@DoAttrBox));
  end;
  AttrTag.DeleteChild(aIndex);
  Modified := True;
 finally
  Changed;
 end;
end;

constructor TDateNumDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atDateNums;
end;

procedure TDateNumDocAttribute.MakeName(aItem : Tl3Tag);
begin
 GenDateNumString(aItem);
end;

function TDateNumDocAttribute.AddRec(aType : TDNType; aDate : TStDate;  aDocID  : TDocID; aSubID  : TSubID) : integer;
var
 lChild : Tl3Tag;
begin
 with MakeAttrTag do
  lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
 with lChild do
 begin
  IntA[k2_tiType] := Ord(aType);
  IntA[k2_tiStart] := aDate;
  if (aType = dnChangerDate) and (aDocID <> 0) then
   with cAtom(k2_tiLinkAddress) do
   begin
    IntA[k2_tiDocID] := aDocID;
    IntA[k2_tiSubID] := aSubID;
   end;
 end;
 Result := Add(lChild);
end;

function  TDateNumDocAttribute.AddRec(aType : TDNType; aDate : TStDate; aNumber : Tl3WString) : integer;
var
 lChild : Tl3Tag;
begin
 with MakeAttrTag do
  lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
 with lChild do
 begin
  IntA[k2_tiType] := Ord(aType);
  IntA[k2_tiStart] := aDate;
  if aNumber.SLen > 0 then
   PCharLenA[k2_tiNumber] := Tl3PCharLen(aNumber);
 end;
 Result := Add(lChild);
end;

function TDateNumDocAttribute.GetMinPublishDate(aNum : Pl3PrimString = nil): TStDate;
var
 I : Integer;
 lDate : TStDate;

begin
 Result := 0;

 with AttrTag do
 for I := 0 to Pred(Count) do
  with Child[I] do
  begin
   lDate := IntA[k2_tiStart];
   if ((Result = 0) or (Result > lDate)) and (lDate > 0) and (IntA[k2_tiType] = Ord(dnPublish)) then
   begin
    Result := lDate;
    if aNum <> nil then
     aNum^ := Attr[k2_tiNumber].AsObject As Tl3PrimString;
   end;
  end;
end;

procedure TDateNumDocAttribute.DeleteAllChangerRec;
var
 I : Integer;
begin
 with AttrTag do
 for I := Pred(Count) downto 0 do
  with Child[I] do
  begin
   //lDate := IntA[k2_tiStart];
   if (IntA[k2_tiType] = Ord(dnChangerDate)) then
    Delete(I);
  end;
end;

//procedure TDateNumDocAttribute.ClearRecHandle(aValue : Pointer);
//begin
// PDNDictRec(aValue)^.ID := cUndefDictID;
//end;


function GetIntTag(const aItem : Tl3Tag; aTagID : Integer) : integer;
begin
 with aItem do
  if IsValid then
   Result := IntA[aTagID]
  else
   Result := 0;
end;

function TDateNumDocAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
var
 I : Integer;
 lItem : Tl3Tag;
begin
 for I := 0 to pred(Count) do
 begin
  lItem := Child[I];
  if (lItem.IntA[k2_tiType] = aTag.IntA[k2_tiType]) and
     (lItem.IntA[k2_tiStart] = aTag.IntA[k2_tiStart]) and
     l3Same(lItem.PCharLenA[k2_tiNumber], aTag.PCharLenA[k2_tiNumber]) and
     (GetIntTag(lItem.Attr[k2_tiLinkAddress], k2_tiDocID) = GetIntTag(aTag.Attr[k2_tiLinkAddress], k2_tiDocID)) and
     (GetIntTag(lItem.Attr[k2_tiLinkAddress], k2_tiSubID) = GetIntTag(aTag.Attr[k2_tiLinkAddress], k2_tiSubID)) then
   begin
    Result := False;
    Exit;
   end;
 end;
 Result := True;
end;

function TDateNumDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lRecEmpty   : Boolean;
 lChild      : Tl3Tag;
begin
 Result := False;

 lRecEmpty := aIndex < 0;

 if lRecEmpty then // new child
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject
 else
  lChild := Child[aIndex];

 Result := GetAttrDateNum(lChild, lRecEmpty);

 if Result then
 begin
  Changing;
  try
   if lRecEmpty then
    Add(lChild)
   else
    Modified := True;
  finally
   Changed;
  end;
 end;
end;

function TDateNumDocAttribute.GetChDate: TStDate;
var
 I : Integer;
begin
 Result := 0;
 with AttrTag do
 for I := 0 to Pred(Count) do
  with Child[I] do
   if (IntA[k2_tiType] = ord(dnChangerDate)) and ((Result = BadDate) or (Result > IntA[k2_tiStart])) then
    Result := IntA[k2_tiStart];
end;

function TDateNumDocAttribute.GetCasecode: Il3CString;
var
 I : Integer;
begin
 with AttrTag do
 for I := 0 to Pred(Count) do
  with Child[I] do
   if (IntA[k2_tiType] = ord(dnLawCaseNum)) then
   begin
    Result := l3CStr(PCharLenA[k2_tiNumber]);
    Break;
   end;
end;

function TDateNumDocAttribute.GetType(aIndex : Integer) : TDNType;
begin
 Result := TDNType(Child[aIndex].IntA[k2_tiType]);
end;

function TDateNumDocAttribute.GetDate(aIndex : Integer) : TstDate;
begin
 Result := Child[aIndex].IntA[k2_tiStart];
end;

function TDateNumDocAttribute.GetNum(aIndex : Integer) : Il3CString;
begin
 Result := l3CStr(Child[aIndex].PCharLenA[k2_tiNumber]);
end;

procedure TDateNumDocAttribute.UpcaseNum(aIndex : Integer);
begin
 Child[aIndex].PCharLenW[k2_tiNumber, nil] := l3PCharLen(l3Upper(Child[aIndex].PCharLenA[k2_tiNumber]));
end;

{TDictDocAttribute}

constructor TDictDocAttribute.Create(aAttrManager : TDocAttributeManager; aAttrID : TdtAttribute; aSingleValue : boolean = false);
begin
 Inherited Create(aAttrManager, aAttrID);
 fSingleValue := aSingleValue;
end;

procedure TDictDocAttribute.Copy(aSrcAttr : IDocAttribute);
var
 I : integer;
 lHandle : Integer;
begin
 if aSrcAttr.AttrID <> fAttrID then Exit;

 for I := 0 to Pred((aSrcAttr as IListDocAttribute).Count) do
 begin
  lHandle := (aSrcAttr as IListDocAttribute).Handle[I];
  AddRec(lHandle);
 end;
end;

procedure TDictDocAttribute.DeleteAll;
var
 lLinkTbl : TLinkTbl;
begin
 if (fAttrManager.Document = nil) or
    (fSubID = cAllSubs) then
  Exit;

 Inherited;
end;

function TDictDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lTreeCur      : Il3Tree;
begin
 with TTreeDesignerForm.Create(nil, fAttrManager.DocFamily, AttrID2DLType(AttrID), dmShow) do
 try
  Result := Execute(Self, fAttrManager.AttrOperateMode = aomSearch {AllowSelNonLeaf},
            (fAttrManager.AttrOperateMode = aomSearch) or cAttrPassport[AttrID].rMultiValue);

  if Result then
  begin
   Changing;
   try
    lTreeCur := DictOutliner.CTree;
    lTreeCur.SetLevelSlash(#13);

    GetListFromTree(lTreeCur, Self, GetMasterDict(AttrID2DLType(AttrID)) <> da_dlNone);
   finally
    Changed;
   end;
  end;
 finally
  Free;
 end;
end;

procedure TDictDocAttribute.AddRec(aItemID : Integer);
var
 lChild      : Tl3Tag;
begin
 with MakeAttrTag do
  lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
 with lChild do
  IntA[k2_tiHandle] := aItemID;

 Add(lChild);
end;

procedure TDictDocAttribute.MakeName(aItem : Tl3Tag);
var
 lRootNode : Il3Node;
 lNode     : Il3Node;
 lDictID   : TdaDictionaryType;
 lLen      : Cardinal;
begin
 lDictID :=  AttrID2DLType(fAttrID);

 with (aItem.cAtom(k2_tiName).AsObject As Tl3String) do
 begin
  lRootNode := DictServer(fAttrManager.DocFamily).DictRootNode[lDictID];
  lNode := l3FindNodeByHandle(lRootNode, aItem.IntA[k2_tiHandle]);
  lLen := l3GetFullPathLen(lRootNode, lNode, #13, '  ');
  Len := lLen;
  l3GetFullPath(lRootNode, lNode, St, lLen, #13, '  ');
 end;
end;

function  TDictDocAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
begin
 Result := GetIndexByHandle(aTag.IntA[k2_tiHandle]) < 0;
end;

function  TDictDocAttribute.AddPrim(aTag : Tl3Tag) : Integer;
begin
 Changing;
 try
  if (fAttrManager.AttrOperateMode <> aomSearch) and not cAttrPassport[AttrID].rMultiValue then
   DeleteAll;
  inherited AddPrim(aTag);
 finally
  Changed;
 end;
end;

{TVerLinkAttribute}
constructor TVerLinkAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atVerLink;
end;

procedure TVerLinkAttribute.Set_Value(aValue : Integer);
var
 lWasEmpty : boolean;
begin
 if Get_Value = aValue then Exit;
 if aValue = 0 then
 begin
  Delete;
  exit;
 end;

 lWasEmpty := AttrTag.IsNull;
 Changing;
 try
  AttrParentTag.IntA[cAttr2k2Tag[AttrID]] := aValue;
  AttrParentTag.IntA[k2_tiInternalVerLink] := 0; // Внутренний сбрасываем

  Modified := True;
  fAttrTag := nil;

  if lWasEmpty then
   CallNotify(ntInsert, 0)
  else
   if (aValue = 0) then
    CallNotify(ntDelete, 0);

  //fAttrTag := nil;
  l3Free(fName); // reset Name
 finally
  Changed;
 end;
end;

function TVerLinkAttribute.Get_Value : Integer;
begin
 with AttrTag do
  if IsNull then
   Result := 0
  else
   Result := AsLong;
end;

//function TVerLinkAttribute.GetViewStringOfData(aData : Pointer): string;
//begin
// Result := Format('№ %d', [PDocID(aData)^]);
//end;

procedure TVerLinkAttribute.MakeName(aItem : Tl3Tag);
begin
 fName.AsString := Format('№ %d', [Get_Value]);
end;

procedure TVerLinkAttribute.Delete(aIndex : Integer = 0);
begin
 Inherited Delete(aIndex);
 AttrParentTag.IntA[k2_tiInternalVerLink] := 0; // Внутренний сбрасываем
end;

function TVerLinkAttribute.EditItem(aIndex : Integer): Boolean;
var
 lLinkID : TDocID;
begin
 lLinkID := Get_Value;
 Result := RequestIntegerValue(lLinkID, nil, GetAttrName(fAttrID), 'Номер документа');
 if Result then
 begin
  Changing;
  try
   Set_Value(lLinkID);
  finally
   Changed;
  end;
 end;
end;

function  TVerLinkAttribute.AddPrim(aTag : Tl3Tag) : Integer;
begin
 Set_Value(aTag.AsLong);
end;

{TSingleItemListDocAttribute}
procedure TSingleItemListDocAttribute.Cleanup;
begin
 l3Free(fName);
 Inherited;
end;

function  TSingleItemListDocAttribute.Get_Count : Integer;
begin
 if AttrTag.IsNull then
  Result := 0
 else
  Result := 1;
end;

function  TSingleItemListDocAttribute.Get_Child(aIndex : Integer) : Tl3Tag;
begin
 //возвращаем родительский тег
 Result := AttrTag;
end;

function  TSingleItemListDocAttribute.AddPrim(aTag : Tl3Tag) : Integer;
begin
 // do nothing
end;

procedure TSingleItemListDocAttribute.Delete(aIndex : Integer = 0);
begin
 DeleteAll;
end;

function  TSingleItemListDocAttribute.Get_ViewString(aIndex: Longint) : Tl3PCharLen;
begin
 if fName = nil then
 begin
  fName := Tl3String.Create;
  MakeName(AttrTag.AsObject);
 end;

 Result := fName.AsPCharLen;
end;

{TDocIDsAttribute}
constructor TDocIDsAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atRenum;
end;

//function TDocIDsAttribute.GetViewStringOfData(aData : Pointer): string;
//begin
// Result := GenDocIDsString(PDocIDsRec(aData)^);
//end;

//function TDocIDsAttribute.Get_Handle(aIndex: Longint): Integer;
//begin
// Result := PDocIDsRec(Data[aIndex])^.rID;
//end;

(*
function TDocIDsAttribute.Get_List: Tl3CustomDataList;
var
 lIDRec : TDocIDsRec;
begin
 if fList = nil then
 begin
  fList := Tl3DataList.CreateSize(SizeOf(TDocIDsRec));
  if fAttrManager.Document <> nil then
  begin
   fList.LockModified := True;
   try
    lIDRec.rIDKind := idkDocExternal;
    with fAttrManager.Document do
     lIDRec.rID := LinkServer(fAttrManager.DocFamily).Renum.GetExtDocID(DocID);
    fList.Add(@lIDRec);

    lIDRec.rIDKind := idkDocInternal;
    lIDRec.rID := fAttrManager.Document.DocID;
    fList.Add(@lIDRec);

    {lIDRec.rIDKind := idkSprExternal;
    fList.Add(lIDRec);

    lIDRec.rIDKind := idkSprInternal;
    fList.Add(lIDRec);
    }

   finally
    fList.LockModified := False;
   end;
  end;
 end;
 Result := fList;
end;
*)

{TPublishedDocAttribute}
constructor TPublishedDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atPublisheds;
end;

function TPublishedDocAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
var
 I : Integer;
 lSrcTag : Tl3Tag;
 lSrcTag2 : Tl3Tag;
begin
 for I := 0 to pred(Count) do
  with Child[I] do
   if (IntA[k2_tiStart] = aTag.IntA[k2_tiStart]) and
      (IntA[k2_tiFinish] = aTag.IntA[k2_tiFinish]) and
      l3Same(PCharLenA[k2_tiNumber], aTag.PCharLenA[k2_tiNumber]) then
   begin
    lSrcTag  := Attr[k2_tiSource];
    lSrcTag2 := aTag.Attr[k2_tiSource];
    if (lSrcTag = lSrcTag2) or
       (lSrcTag.IsValid and lSrcTag2.IsValid and (lSrcTag.IntA[k2_tiHandle] = lSrcTag2.IntA[k2_tiHandle])) then
    begin
     Result := False;
     Exit;
    end;
   end;
 Result := True;
end;

function TPublishedDocAttribute.EditItem(aIndex : Integer): Boolean;
var
 lTreeCur : Il3Tree;
 lAddIndex : TListIndex;

 procedure lGetListFromTree(const aTree : Il3Tree; var aAddIndex : TListIndex);
  var
  lCurNode  : Il3Node;
  lCurID    : Longint;
  lIndex    : TListIndex;

  function lFindItem(aID : Integer) : Integer;
  var
   I : Integer;
  begin
   Result := -1;
   for I := 0 to Pred(Count) do
    if Handle[I] = aID then
    begin
     Result := I;
     Exit;
    end;
  end;

 const
  lfItemNeedDelete = $8000;
 var
  lExtNode : Il3ExtItemNode;
  lChild      : Tl3Tag;
 begin
  aAddIndex := -1;
  Changing;
  try
   If aTree = nil then Exit;
   lCurNode := Nil;

   Repeat
    lCurNode := aTree.GetNextSetFlag(lCurNode, nfSelModified);
    If lCurNode = Nil then break;

    lIndex := lFindItem((lCurNode as Il3HandleNode).Handle);
    if aTree.SelectedNode[lCurNode] then
    begin
     if (lIndex = -1) then
     begin
      if Supports(lCurNode, Il3ExtItemNode, lExtNode) then
      begin
       with MakeAttrTag do
        lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;

       with lChild, PPublishDataRec(lExtNode.Data)^ do
       begin
        AttrW[k2_tiName, nil] := nil;
        IntA[k2_tiHandle] := DictID;

        if SourID > 0 then
         CAtom(k2_tiSource).IntA[k2_tiHandle] := SourID
        else
         AttrW[k2_tiSource, nil] := nil;

        IntA[k2_tiStart] := SDate;
        IntA[k2_tiFinish] := EDate;

        PCharLenA[k2_tiNumber] := l3ArrayToPCharLen(Num, SizeOf(Num));
        PCharLenA[k2_tiComment] := l3ArrayToPCharLen(Comment, SizeOf(Comment));

        BoolA[k2_tiIsPeriodic] := (DictServer(fAttrManager.DocFamily).Dict[da_dlCorSources].DictTbl.GetIsNonperiodic(SourID) = 0);
       end;

       lIndex := Add(lChild);

       if aAddIndex = -1 then
        aAddIndex := lIndex
       else
        aAddIndex := -2; // если добавили 2 и больше, то индекс не возвращаем
      end;
     end;
    end
    else //if aTree.SelectedNode[lCurNode] then
     if (lIndex > -1) then
      Delete(lIndex);
      //aList.PasStr[lIndex] := GetViewString(lIndex);
   until false;

  finally
   Changed;
  end;
 end;

 procedure lEditOneItem(aIndex : TListIndex);
 begin
  Result := RunPublishedInEditDlg(nil, l3Str(Get_ViewString(aIndex)), Child[aIndex], fAttrManager.Document.DocID);
  //MakeName(Child[aIndex]);
 end;

begin
 Result := False;

 if (fAttrManager.AttrOperateMode = aomSearch) or (aIndex = -1) then //поисковый запрос или ветка целиком
 begin
  with TTreeDesignerForm.Create(nil, fAttrManager.DocFamily, da_dlCorSources {TdaDictionaryType(AttrID)}, dmShow) do
  try
   Result := Execute(Self, false {fAttrManager.AttrOperateMode = aomSearch} {AllowSelNonLeaf}, True {aMultiSelect});
   if Result then
   begin
    lTreeCur := DictOutliner.CTree;
    lTreeCur.SetLevelSlash(#13);

    //List.Clear;
    lGetListFromTree(lTreeCur, lAddIndex);
    if lAddIndex >= 0 then
     lEditOneItem(lAddIndex)
   end;
  finally
   Free;
  end;
 end
 else //редактирование одного
  lEditOneItem(aIndex);
end;

procedure TPublishedDocAttribute.MakeName(aItem : Tl3Tag);
begin
 GenPublInString(aItem);
end;

function TPublishedDocAttribute.IsImageExists(aIndex : Integer) : Boolean;
begin
 with Child[aIndex] do
  Result := DocImageServer.IsImageExists(Attr[k2_tiSource].IntA[k2_tiHandle], IntA[k2_tiStart], IntA[k2_tiFinish],
                                  StrA[k2_tiNumber], not BoolA[k2_tiIsPeriodic], fAttrManager.Document.DocID);
end;

function TPublishedDocAttribute.GetImagePath(aIndex : Integer) : AnsiString;
begin
 with Child[aIndex] do
  Result := DocImageServer.GetImageFileName(Attr[k2_tiSource].IntA[k2_tiHandle], IntA[k2_tiStart], IntA[k2_tiFinish],
                                  StrA[k2_tiNumber], not BoolA[k2_tiIsPeriodic], fAttrManager.Document.DocID);
end;

function TPublishedDocAttribute.GetImagePageStr(aIndex : Integer) : AnsiString;
begin
 with Child[aIndex] do
  Result := StrA[k2_tiPages];
end;

{TCorrectsAttribute}
constructor TCorrectsAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atCorrects;
 fPublishedsNotifier := (fAttrManager.GetDocAttribute(atPublisheds) as Il3ChangeNotifier);
 if fPublishedsNotifier <> nil then
  fPublishedsNotifier.Subscribe(Self as Il3ItemNotifyRecipient);
end;

procedure TCorrectsAttribute.Cleanup;
begin
 if fPublishedsNotifier <> nil then
  fPublishedsNotifier.Unsubscribe(Self as Il3ItemNotifyRecipient);
 Inherited;
end;

function TCorrectsAttribute.CheckUniq(aTag : Tl3Tag) : boolean;
var
 I : Integer;
 lUserTag  : Tl3Tag;
 lUserTag2 : Tl3Tag;
begin
 {for I := 0 to pred(Count) do
  with Child[I] do
   if (IntA[k2_tiSource] = aTag.IntA[k2_tiSource]) and
      (IntA[k2_tiStart] = aTag.IntA[k2_tiStart]) and
      (IntA[k2_tiType] = aTag.IntA[k2_tiType]) then
   begin
    lUserTag := Attr[k2_tiUser];
    lUserTag2 := aTag.Attr[k2_tiUser];
    if (lUserTag = lUserTag2) or
       (lUserTag.IsValid and lUserTag2.IsValid and (lUserTag.IntA[k2_tiHandle] = lUserTag2.IntA[k2_tiHandle])) then
    begin
     Result := False;
     Exit;
    end;

   end;
 }  
 Result := True;
end;

function TCorrectsAttribute.EditItem(aIndex : Integer): Boolean;
var
 lRecEmpty   : Boolean;
 lChild      : Tl3Tag;

 procedure AssignList(aList : TStrings);
 var
  I : Integer;
 begin
  with fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute do
   for I := 0 to Pred(Count) do
    aList.AddObject(l3Str(ViewString[I]), Pointer(Handle[I]));
 end;

begin
 Result := False;

 lRecEmpty := aIndex < 0;

 if lRecEmpty then // new child
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject
 else
  lChild := Child[aIndex];

 with TSrcCheckDlg.Create(nil) do
  try
   AssignList(cbSource.Items);
   Result := Execute(fAttrManager.DocFamily, lChild, lRecEmpty);
  finally
   Free;
  end;

 if Result then
 begin
  Changing;
  try
   if lRecEmpty then
    Add(lChild)
   else
    Modified := True;
  finally
   Changed;
  end;
 end;
end;

procedure TCorrectsAttribute.MakeName(aItem : Tl3Tag);

 function GetPublishStr(aPubID : TDictID) : Tl3PCharLen;
 var
  lIdx : Integer;
 begin
  Result := Tl3PCharLen(cc_EmptyStr);
  if aPubID = 0 then
   Exit;

  with (fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute) do
  begin
   lIdx := GetIndexByHandle(aPubID);
   if lIdx >= 0 then
    Result := ViewString[lIdx];
  end;
 end;

begin
 GenCorrectString(aItem, GetPublishStr(aItem.IntA[k2_tiSource]));
end;

procedure TCorrectsAttribute.Notify(const aNotifier : Il3ChangeNotifier; aOperation : Integer; aIndex : Integer);
var
 lRec : Tl3Tag;
 lPubInID : TDictID;
 I : Integer;
 lInChange : Boolean;

 function IsPublishedPresent(aPubID : TDictID) : boolean;
 begin
  with (fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute) do
   Result := GetIndexByHandle(aPubID) >= 0;
 end;

 procedure DoChange;
 begin
  if not lInChange then
  begin
   Changing;
   lInChange := True;
  end;
 end;

begin
 lInChange := False;

 if l3IEQ(aNotifier, fPublishedsNotifier) then
 begin
  if (aOperation = ntDelete) or (aOperation = ntChangeItemData) then
  begin
   lPubInID := (fAttrManager.GetDocAttribute(atPublisheds) as IListDocAttribute).Handle[aIndex];
   try
    with AttrTag do
    for I := 0 to Pred(Count) do
    begin
     lRec := Child[I];
     if lRec.IntA[k2_tiSource] = lPubInID then
     begin
      Case aOperation of
       ntDelete :
        begin
         DoChange;
         lRec.IntA[k2_tiSource] := 0;
         DropName(lRec);
         Modified := True;
        end;
       ntChangeItemData :
        DropName(lRec);
      end; //Case aOperation of
     end
     else
      if (aOperation = ntChangeItemData) and
         ((lRec.IntA[k2_tiSource] <> 0) and not IsPublishedPresent(lRec.IntA[k2_tiSource])) then
       begin
        DoChange;
        lRec.IntA[k2_tiSource] := 0;
        DropName(lRec);
        Modified := True;
       end;
    end;
   finally
    if lInChange then Changed;
   end;
  end;
 end
 else
  inherited;
end;


{TListOfDocAttribute}

{
function TListOfDocAttribute.Get_List: Tl3CustomDataList;
begin
 Result := NameList;
end;
}
{
function TListOfDocAttribute.Get_NameList: Tl3StringDataList;
begin
 if fNameList = nil then
 begin
  fNameList := Tl3StringDataList.Create;
  Load;
 end;
 Result := fNameList;
end;
}

{TVersionListAttribute}
constructor TVersionListAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atVersions;
 LoadList;
end;

function  TVersionListAttribute.Get_Modified : Boolean;                                
begin
 Result := False;
end;

procedure TVersionListAttribute.Set_Modified(aValue : Boolean);
begin
end;

function TVersionListAttribute.GetIconIndex(aIndex : Integer) : Integer;
begin
 Result := Child[aIndex].IntA[k2_tiType];
end;

function TVersionListAttribute.IsActive(aIndex : Integer) : Boolean;
begin
 Result := Child[aIndex].BoolA[k2_tiIsActive];
end;

function TVersionListAttribute.MakeDocSab : ISab;
const
 cHandleSize = SizeOf(Longint);
var
 lListCursor : Integer;
 lCount : Integer;

 function lFillBufferProc(aBuffer: Pointer; aBufSize: Longint): Longint; register;
 var
  lRealSize : Longint;
  I : Integer;
 begin
  lRealSize := Min(aBufSize div cHandleSize, lCount - lListCursor);

  for I := lListCursor to lListCursor + pred(lRealSize) do
  begin
   PLongint(aBuffer)^ := Handle[I];
   Inc(PChar(aBuffer), cHandleSize);
  end;

  Result := lRealSize * cHandleSize;
  Inc(lListCursor, lRealSize);
 end;

var
 lSab : TSab;
 lFillBufferProcStub : TFillBufferProc;
begin
 lListCursor := 0;
 lCount := Count;
 lFillBufferProcStub := L2FillBufferProc(@lFillBufferProc);
 try
  lSab := TSab.MakeValueSet(DocumentServer(fAttrManager.DocFamily).FileTbl, fId_Fld, lFillBufferProcStub);
 finally
  FreeFillBufferProc(lFillBufferProcStub);
 end;

 Result := lSab;
 l3Free(lSab);
end;

procedure TVersionListAttribute.LoadList;
var
 lChild      : Tl3Tag;
 I : Integer;

 lVerList    : TL3LongintList;

 lSabActInt       : ISab;
 lSabDateNum      : ISab;
 lSabDateNumLnk   : ISab;
 lSabRenum        : ISab;
 lSabDoc          : ISab;

 //lJoinSabSumAct   : IJoinSab;
 lJoinSabDN_DocID : IJoinSab;
 lJoinSabDoc_Renum : IJoinSab;

 lSabCursorDN_DocID : ISabCursor;
 lSabCursorActInt   : ISabCursor;
 lSabCursorDoc      : ISabCursor;

 lCurDN_DocID : Integer;
 lCurActInt   : Integer;
 lCurDoc      : Integer;

 lCurrentDate : TStDate;

 procedure lGetNameString(aChild : Tl3Tag);
 type
  pDNAccRec = ^TDNAccRec;
  TDNAccRec = record
   rDocID : TDocID;
   rDate : TStDate;
  end;

  pActAccRec = ^TActAccRec;
  TActAccRec = record
   rDocID : TDocID;
   rStart : TStDate;
   rFinish : TStDate;
  end;

  pDocRec = ^TDocRec;
  TDocRec = record
   rRealID   : TDocID;
   rImportID : TDocID;
   rType     : Byte;
   rUserType : Byte;
  end;

 var
  I : Integer;
  lIntervalStr : String;
  lChDateStr   : String;
  lDocRec      : pDocRec;
  lDocID       : TDocID;
  lFirstTime : boolean;
  lName  : String;

 begin
  lDocRec := pDocRec(lSabCursorDoc.GetItem(lCurDoc));

  lDocID := aChild.IntA[k2_tiHandle];

  if (lDocRec = nil) or (lDocRec^.rRealID <> lDocID) then
  begin
   lName := Format('Документ %d отсутствует в базе', [LinkServer(fAttrManager.DocFamily).Renum.GetExtDocID(aChild.IntA[k2_tiHandle])]);
   aChild.PCharLenA[k2_tiName] := l3PCharLen(lName);
   exit;
  end
  else
   Inc(lCurDoc);

  lFirstTime := True;
  //lActive := False;
  while true do
  begin
   if lCurActInt >= lSabCursorActInt.Count then Break;
   with pActAccRec(lSabCursorActInt.GetItem(lCurActInt))^ do
    if rDocID = lDocID then
    begin
     if not lFirstTime then
     begin
      lIntervalStr := lIntervalStr +',';
      lFirstTime := False
     end;
     lIntervalStr := lIntervalStr + GenDateDiapasonString(MakeDateBounds(rStart, rFinish));

     //if (lCurrentDate >= rStart) and (lCurrentDate <= rFinish) then
     // lActive := True;

     Inc(lCurActInt);
    end
    else
     Break;
  end;
  if lIntervalStr = '' then
   lIntervalStr := ' действует';

  while true do
  begin
   if lCurDN_DocID >= lSabCursorDN_DocID.Count then Break;
   with pDNAccRec(lSabCursorDN_DocID.GetItem(lCurDN_DocID))^ do
    if rDocID = lDocID then
    begin
     lChDateStr := lChDateStr + ' ' + GenStDateString(rDate);
     Inc(lCurDN_DocID);
    end
    else
     Break;
  end;

  aChild.BoolA[k2_tiIsActive] := TUserType(lDocRec^.rUserType) <> utEdition;
  aChild.IntA[k2_tiType] := GetDocumentImageIndex(TDocType(lDocRec^.rType),
                                                   TUserType(lDocRec^.rUserType),
                                                   aChild.BoolA[k2_tiIsActive]); //сразу иконку воткнем

  lName := Format('[%d] Интервал действия:%s', [lDocRec^.rImportID, lIntervalStr]);

  if lChDateStr <> '' then
   lName := lName + Format('   Дата изменяющего документа:%s', [lChDateStr]);

  aChild.PCharLenA[k2_tiName] := l3PCharLen(lName);
 end;
var
 lk2TagView : Tk2TagByHandleView;
const
 lDNDocType : TDNType = dnChangerDate;
 lActDocType : Integer = actt_Normal;

begin
 lCurrentDate := CurrentDate;
 lVerList := TL3LongintList.Create;
 try
  DocumentServer(fAttrManager.DocFamily).FileTbl.GetAllVerLinkOrder(fAttrManager.Document.DocID, lVerList);

  lSabDoc := MakeValueSet(DocumentServer(fAttrManager.DocFamily).FileTbl, fId_Fld, lVerList);
  lSabDateNumLnk := MakeSabCopy(lSabDoc);

  Changing;
  try
   DeleteAll;
   with MakeAttrTag do
    for I := 0 to Pred(lVerList.Count) do
    begin
     lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
     with lChild do
     begin
      IntA[k2_tiHandle] := lVerList[I];
      //PCharLenA[k2_tiName] := l3PCharLen(GetNameString(ID));
     end;
     Add(lChild);
    end;
  finally
   Changed;
  end;

 finally
  l3Free(lVerList);
 end;

 lSabActInt := MakeSabCopy(lSabDoc);
 lSabRenum  := MakeSabCopy(lSabDoc);

 lSabDateNumLnk.TransferToPhoto(lnkDocIDFld, LinkServer(fAttrManager.DocFamily).Attribute[atDateNums]);
 lSabDateNumLnk.RecordsByKey;

 lSabDateNum := MakeSabCopy(lSabDateNumLnk);
 lSabDateNum.ValuesOfKey(lnkDictIDFld);
 lSabDateNum.TransferToPhoto(dnIDFld, DictServer(fAttrManager.DocFamily).GroupTbl[da_dlDateNums]);
 lSabDateNum.RecordsByKey;
 lSabDateNum.SubSelect(dnTypFld, lDNDocType);

 //объединение DN-DocID
 lJoinSabDN_DocID := MakeJoinSab(lSabDateNum, dnIDFld,
                                 lSabDateNumLnk, lnkDictIDFld);

 lJoinSabDN_DocID.SortJoin([JFRec(lSabDateNumLnk.Table, lnkDocIDFld)]);


 lSabActInt.TransferToPhoto(actDocID, LinkServer(fAttrManager.DocFamily).Attribute[atActiveIntervals]);
 lSabActInt.RecordsByKey;
 lSabActInt.SubSelect(actTyp, lActDocType);

 lSabActInt.Sort([dnIDFld]);

 lSabRenum.TransferToPhoto(rnRealID_fld, LinkServer(fAttrManager.DocFamily).Attribute[atRenum]);
 lSabRenum.RecordsByKey;

 lSabDoc.RecordsByKey;
 lJoinSabDoc_Renum := MakeJoinSab(lSabDoc, fId_Fld, lSabRenum, rnRealID_fld);

 lJoinSabDoc_Renum.SortJoin([JFRec(lSabDoc.Table, fId_Fld)]);
 lSabCursorDoc := lJoinSabDoc_Renum.MakeJoinSabCursor([JFRec(lSabDoc.Table, fId_Fld), JFRec(lSabRenum.Table, rnImportID_fld),
                                                       JFRec(lSabDoc.Table, fType_Fld), JFRec(lSabDoc.Table, fUserType_Fld)], cmForward);

 lSabCursorDN_DocID := lJoinSabDN_DocID.MakeJoinSabCursor([JFRec(lSabDateNumLnk.Table, lnkDocIDFld), JFRec(lSabDateNum.Table, dnDateFld)], cmForward);
 lSabCursorActInt   := lSabActInt.MakeSabCursor([actDocID, actStart, actFinish], cmForward);

 lCurDN_DocID := 0;
 lCurActInt   := 0;
 lCurDoc      := 0;

 lk2TagView := Tk2TagByHandleView.Create(MakeAttrTag.AsObject);
 try
  with lk2TagView do
   for I := 0 to Pred(Count) do
    lGetNameString(Items[I]);
 finally
  l3Free(lk2TagView);
 end;

end;

(*
function TVersionListAttribute.Get_Data(aIndex: Longint): Pointer;
begin
 Result := Pointer(fAttrManager.Document.DocData.VersionsList.GetDoc(aIndex).ID);
end;
*)

{TStagesDocAttribute}
constructor TStagesDocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atStages;
end;

function  TStagesDocAttribute.HandleTag : Integer;
begin
 Result := k2_tiType;
end;

function TStagesDocAttribute.CheckStageClosed(aStageType : TStageType): Boolean;
begin
 Result := DateOfStageClosed(aStageType) > 0;
end;

procedure TStagesDocAttribute.CloseStage(aStageType : TStageType);
var
 lIndex : Integer;
begin
 lIndex := MakeStage(aStageType);
 with Child[lIndex] do
 begin
  if IntA[k2_tiStart]  = 0 then IntA[k2_tiStart]  := CurrentDate;
  if IntA[k2_tiFinish] = 0 then IntA[k2_tiFinish] := CurrentDate;
 end;
 Modified := True;
end;

function TStagesDocAttribute.DateOfStageClosed(aStageType : TStageType): TStDate;
var
 lIndex : Integer;
begin
 lIndex := GetIndexByHandle(ord(aStageType));
 if lIndex >= 0 then
  Result := GetEndDate(lIndex)
 else
  Result := 0;
end;

function TStagesDocAttribute.GetStartDate(aIndex : Integer) : TstDate;
begin
 Result := Child[aIndex].IntA[k2_tiStart];
end;

function TStagesDocAttribute.GetEndDate(aIndex : Integer) : TstDate;
begin
 Result := Child[aIndex].IntA[k2_tiFinish];
end;

function TStagesDocAttribute.GetAuthor(aIndex : Integer) : TUserID;
begin
 Result := TUserID(Child[aIndex].IntA[k2_tiUser]);
end;

procedure TStagesDocAttribute.SetAuthor(aIndex : Integer; aUserID : TUserID);
begin
 with Child[aIndex].CAtom(k2_tiUser) do
  IntA[k2_tiHandle] := Integer(aUserID);
end;

function TStagesDocAttribute.CheckEditEnable(aStageType : TStageType; aDateKind : Byte) : Boolean;
var
 lIndex : Integer;
 lDate  : Integer;
begin
 lIndex := GetIndexByHandle(Byte(aStageType));
 if lIndex < 0 then
  Result := True
 else
  with Child[lIndex] do
  begin
   case aDateKind of
    0 : lDate := IntA[k2_tiStart];
    1 : lDate := IntA[k2_tiFinish];
   end;
   Result := {(IntA[k2_tiUser] = Integer(GlobalDataProvider.UserID)) and} ((lDate = 0) or (lDate = CurrentDate));
  end;
end;

function  TStagesDocAttribute.MakeStage(aStageType : TStageType): Integer;
var
 lChild : Tl3Tag;
begin
 Result := GetIndexByHandle(Byte(aStageType));

 if Result < 0 then
 begin
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject;
  with lChild do
  begin
   IntA[k2_tiType] := Ord(aStageType);

   with CAtom(k2_tiUser) do
    IntA[k2_tiHandle] := Integer(GlobalDataProvider.UserID);
  end;
  Result := Add(lChild);
 end;
end;

procedure TStagesDocAttribute.SetStartDate(aIndex : Integer; aDate : TstDate);
begin
 Changing;
 try
  if aDate = 1 then aDate := CurrentDate;
  Child[aIndex].IntA[k2_tiStart] := aDate;
  Modified := True;
 finally
  Changed;
 end;
end;

procedure TStagesDocAttribute.SetEndDate(aIndex : Integer; aDate : TstDate);
begin
 Changing;
 try
  if aDate = 1 then aDate := CurrentDate;
  Child[aIndex].IntA[k2_tiFinish] := aDate;
  Modified := True;
 finally
  Changed;
 end;
end;

{TDocIDsAttribute}
constructor TDoc2DocAttribute.Create(aAttrManager : TDocAttributeManager);
begin
 Inherited Create(aAttrManager);
 fAttrID := atDoc2DocLink;
end;

procedure TDoc2DocAttribute.MakeName(aItem : Tl3Tag);
begin
 GenDoc2DocString(aItem);
end;

function TDoc2DocAttribute.EditItem(aIndex : Integer) : Boolean;
var
 lChild : Tl3Tag;
 lRecEmpty   : Boolean;
begin
 lRecEmpty := aIndex < 0;

 if lRecEmpty then // new child
  with MakeAttrTag do
   lChild := Tk2Type(TagType).ArrayProp[k2_tiChildren].ChildType.MakeTag.AsObject
 else
  lChild := Child[aIndex];

 Result := Doc2DocLinkEdit(lChild, lRecEmpty);
 //MakeName(lChild);

 if Result then
 begin
  Changing;
  try
   if lRecEmpty then
    Add(lChild)
   else
    Modified := True;
  finally
   Changed;
  end;
 end;
end;

end.


