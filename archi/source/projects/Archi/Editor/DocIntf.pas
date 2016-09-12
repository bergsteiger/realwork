unit DocIntf;

{ $Id: DocIntf.pas,v 1.113 2016/09/09 10:57:10 lukyanets Exp $ }

{$I l3Define.inc}

interface
uses
 Windows, 
 Classes, 
 SysUtils,
 Graphics,
 
 l3Types, 
 l3Interfaces,
 l3InternalInterfaces, 
 l3Date, 
 l3Base,
 l3Tree,
 l3DatLst,
 l3Except,
 l3LongintList,
 l3Filer,

 m3DBInterfaces,

 k2Base,
 k2Reader,
 k2TagGen,
 k2Types,
 k2Interfaces,
 k2DocumentGenerator,

 evInternalInterfaces,
 evTextSource,
 evTextSourcePublished,
 evCommonTypes,
 evEvdRd,
 evdWriter,
 evdTypes,
 evTxtrd,
 evEditorWindow,
 evTypes,
 evIntf,
 evCursor,
 m4DocumentAddress,
 evdReader,
 nevTools,

 ddPictConvertor,
 ddRTFwriter,
 ddDocumentCopy,

 DictsSup,

 daTypes,

 DT_Const,
 DT_Types,
 dt_AttrSchema,
 DT_TblCacheDef,
 DT_Err,
 DT_Lock,
 DT_Dict,
 DT_LinkServ,
 DT_Doc,
 //DT_Hyper,
 //Dt_Active,
 //DT_Alarm,
 //Dt_Log,
 Dt_EFltr,

 //m4FoundSelector,

 DocAttrIntf {DocAttrImpl DocAttrImpl2},

 l3ObjectRefArray,
 l3FileUtils,
 arInterfaces,
 arDocObject,
 m3DB;

const
  ftDefault  = 0;
  ftEverest  = 1;
  ftANSIText = 2;
  ftOEMText  = 3;
  ftRTF      = 4;

  cAllSubs   = -1;

type
  TSetMode = (smAdd, smReplace);
  TStgSelector = (ssLocal, ssGlobal);


  PDocAddr = ^TDocAddr;
  TDocAddr = Record
              FamID : TdaFamilyID;
              DocID : TDocID;
             end;

  //TSubType = (stSub, stBlock);

  //TDocumentAttrData = class;
  //TDocumentAttrData = TDocumentData;

  TOnChangeDocAttribute = procedure(const aSender: IDocAttribute) of object;
  TOnBeforeSaveAttribute = procedure(const aSender: IDocAttribute) of object;

  TOnDocTextSave = function(aPart: Tm3DocPartSelector; aFullSave: Boolean) : boolean of object;

  TAttrOperateMode = (aomEdit, aomSearch, aomGroupEdit);

  IDocAttributeManager = interface
  ['{16CBC589-2690-4855-9774-92818B8B2E1A}']
   function  Get_SubID : TSubID;
   procedure Set_SubID(aValue : TSubID);

   property  SubID : TSubID
    read Get_SubID
    write Set_SubID;
  end;

  TarTextOfDocument = class;
  TarDocumentWithAttr = class;

  TDocAttributeManager = class(Tl3Base, IDocAttributeManager)
  private
   fSubID                 : TSubID;
   fAttrArray             : Tl3ObjectRefArray;
   fDocument              : TarDocumentWithAttr;
   fInChangeDocProcess    : Boolean;
   fOnChangeDocAttribute  : TOnChangeDocAttribute;
   fOnBeforeSaveAttribute : TOnBeforeSaveAttribute;
   fAttrOperateMode       : TAttrOperateMode;
   fDocFamily             : TdaFamilyID;
   fInLoad                : Boolean;

   function  GetAttrArray : Tl3ObjectRefArray;
   procedure SetDocFamily(aValue : TdaFamilyID);
   function GetDocFamily : TdaFamilyID;
  protected
   procedure Cleanup; override;
   function  Get_SubID : TSubID;
   procedure Set_SubID(aValue : TSubID);
   property  AttrArray : Tl3ObjectRefArray
     read GetAttrArray;

   procedure PrepareEditablePartsInfo;

  public
   constructor Create(aDocument : TarDocumentWithAttr = nil);
   //function    IsDocAttributeCreated(aAttrID : TdtAttribute) : Boolean;
   function    GetDocAttribute(aAttrID : TdtAttribute) : IDocAttribute;
   procedure   ReloadDocAttributes(aAttrIDSet : TdtAttributeSet = []);
   function    DataWasModified(aDocParts : Tm3DocPartSet) : Boolean;
   procedure   DropDataModified;
   procedure   DeleteAllforPart(aDocPart : Tm3DocPartSelector);

   function    BeforeSaveDocData(aAttrIDSet : TdtAttributeSet = []): Boolean;
   procedure   evntChangeDocAttribute(const aSender: IDocAttribute);
   procedure   SetAttrModified(aAttr : IDocAttribute);
   function    GetTextSourceforAttr(aAttr : IDocAttribute) : TarTextOfDocument;
   //procedure   TextSourceLoaded(aDocPart   : Tm3DocPartSelector);

   property  Document : TarDocumentWithAttr
     read  fDocument;

   property  SubID : TSubID
     read Get_SubID
     write Set_SubID;

   property  AttrOperateMode      : TAttrOperateMode
     read fAttrOperateMode
     write fAttrOperateMode;

   property DocFamily: TdaFamilyID
    read GetDocFamily
    write SetDocFamily;

   property OnChangeDocAttribute : TOnChangeDocAttribute
    read fOnChangeDocAttribute
    write fOnChangeDocAttribute;

   property OnBeforeSaveAttribute : TOnBeforeSaveAttribute
    read fOnBeforeSaveAttribute
    write fOnBeforeSaveAttribute;
 end;

  TarDocInfo = class(Tl3Base)
  private
   fDocFamily          : TdaFamilyID;
   fDocID              : TDocID;
   fDocClass           : TDocType;
   //fUserDocID          : TDocID;

   procedure SetDocFamily(aValue : TdaFamilyID);
   procedure SetDocID(aValue : TDocID);
  public
   constructor Make(aDocFamily : TdaFamilyID = 0; aDocID : TDocID = 0; aDocClass : TDocType = dtText);
   function  IsSetted : Boolean;
   //function  GetUserDocID : TDocID;
   //function  SetUserDocID(aValue : TDocID) : boolean;

   property DocFamily : TdaFamilyID read fDocFamily  write SetDocFamily;
   property DocID     : TDocID    read fDocID      write SetDocID;
   property DocClass  : TDocType  read fDocClass   write fDocClass;
  end;

  TOnAfterDataInsert = procedure(aSender: TObject; aInsertInEmptyDoc : Boolean) of object;
  TOnGetHFPainter    = function(aSender: TObject; aPrintBlock : Boolean) : Il3HAFPainter of object;

  TarTextOfDocument = class(TevTextSource)
  private
   procedure BuildLoadPipeParams(out WithAttr: Boolean; out DocPartSel: TDocPartSelector);
   function BuildClientServerLoadPipe(var aGen: Tk2TagGenerator; WithAttr: Boolean;
     DocPartSel: TDocPartSelector; aFoundSelector: Tm4Addresses;
     aLevel : Integer; var theFiler : Tl3CustomFiler): Boolean;
   procedure BuildRemoteLoadPipe(var aGen: Tk2TagGenerator; WithAttr: Boolean;
     DocPartSel: TDocPartSelector; aFoundSelector: Tm4Addresses; aLevel : Integer;
     var theFiler : Tl3CustomFiler);
   function IsObjTopic: Boolean;  
  protected
   fNeedFullSave : Boolean; // это флаг который показывает что хотя мы сохранили текст и модифиед сбросился, но нужно опять сохранить с синхронизацией в базу
   fDocPart   : Tm3DocPartSelector;
   fDocInfo   : TarDocInfo;
   fOnAfterDataInsert : TOnAfterDataInsert;
   fOnGetHFPainter : TOnGetHFPainter;
   fExistsInStg : boolean;
   fExistsInStgWasChecked : boolean;
   //fNewDoc : Boolean;
   procedure pm_SetModified(aValue: Boolean);
   function  pm_GetModified : Boolean;

   function  GetDocUserType : TUserType;

   procedure SetNeedFullSave(aValue: Boolean);

   procedure DoAfterDataInsert(aInsertInEmptyDoc : Boolean);
   function  DoGetHFPainter(aPrintBlock : Boolean) : Il3HAFPainter;
   //procedure SaveTextPrim(aNeedDBSyncro : Boolean; anAdditionalData: TObject);

   procedure SaveLocal(const aLocalDBName : TPathStr; aDocInfoRecord : Tm3DBDocumentInfo);
   procedure Commit;
   procedure Commit_SetAddFilter(var aGenerator: Tk2TagGenerator); virtual;
   function  Commit_IsNeedSaveText : boolean; virtual;

   procedure ClearTextIndent;

   function  DoMakeDocumentContainer: InevDocumentContainer;
     override;
     {-}
  function IsSpravka : boolean;
  function IsAnno    : boolean;

  function  pm_GetDocument: Tl3Variant; override;
  procedure LoadText(aGoToType        : Integer = Ord(ev_sbtNone);
                      aGoToHandle      : Longint = 0;
                      aFoundSelector   : Tm4Addresses = nil;
                      const aSearcher  : IevSearcher = nil;
                      aLevel : Integer = Cm3LastVersion {откат к предыдущей версии});

  procedure LoadLocalText(const aLocalDBName : TPathStr; aLevel : Integer = Cm3LastVersion {откат к предыдущей версии});

  public
  //function GetGenerator(const aView : InevView; const aGeneratorTarget: IUnknown): Ik2TagGenerator;
  //  override;

   procedure LoadTextFromFile(ExtFileName : TFileName; FilterIndex : Integer; const aCursor : TnevCursor = nil);
   procedure PrintText(const aBlock : InevStorable = nil);
   //procedure SaveText(aFullSave : Boolean = True; anAdditionalData: TObject = nil); virtual;
   procedure SaveTextToFile(DestFileName : TFileName; FileType : Byte);
   procedure SaveToEVD(const aFileName : TFileName);
   procedure UnLoadText;

   //procedure LoadPrevVersion(aLevel : Integer; aStg : TStgSelector);

   function  AttrWasModified : Boolean;

   procedure Clear;
   function  Exists : Boolean;
   function  ExistInLocal(const aLocalDBName : TPathStr) : Boolean;
   procedure SetDocInfo(aValue : TarDocInfo);
   procedure MakeNewDoc;
   function  GetDocumentType : Tk2Type; virtual;
   procedure evntGetNewHandleID(aType : TdtHandleIDType; var aHandleID : Integer);
   procedure evntOnEraseAttrRecords(aAttrType : TCacheType; aDictID : TDictID; aDocID : TDocID; aSubID : TSubID);
   procedure evntInsertDocAttribute(aAttr : TCacheType); // for insert from clipboard

   procedure SetEditablePart(aAttr : Cardinal);

   function  IsTextModified : Boolean;
   function  IsPartWasModified(aAttr : Cardinal) : boolean;

   procedure evntGetWriter(Sender: TObject; Format: Cardinal; var Writer: Tk2TagGenerator); virtual;
    {- make filter for put text from clipboard}

   procedure evntGetReader(Sender: TObject; Format: TevFormat; var Reader: TevFileReader); virtual;
    {- make filter for insert text from clipboard}

   constructor Make(aDocInfo : TarDocInfo; aDocPart : Tm3DocPartSelector);
   procedure Cleanup; override;

   property DocInfo : TarDocInfo
     read fDocInfo
     write SetDocInfo;

   property DocUserType : TUserType  read GetDocUserType;

   property Modified : Boolean
     read pm_GetModified
     write pm_SetModified;

   property DocPart : Tm3DocPartSelector
     read fDocPart
     write fDocPart;
     {-}

   property OnAfterDataInsert : TOnAfterDataInsert
     read  fOnAfterDataInsert
     write fOnAfterDataInsert;

   property OnGetHFPainter : TOnGetHFPainter
     read  fOnGetHFPainter
     write fOnGetHFPainter;
  end;

  TarTextOfDocumentWithContentsTree = class(TarTextOfDocument)
  protected
   function  DoMakeDocumentContainer: InevDocumentContainer;
     override;
     {-}
  end;

  RarTextOfDocument = class of TarTextOfDocument;

  TarTextOfAnnoDocument = class(TarTextOfDocument)
  public
   //procedure SaveText(aFullSave : Boolean = True; anAdditionalData: TObject = nil); override;
  end;

  TarSpravkaTextOfDocument = class(TarTextOfDocument)
  protected
   procedure Commit_SetAddFilter(var aGenerator: Tk2TagGenerator); override;
   function  Commit_IsNeedSaveText : boolean;                      override;

   function DoMakeDocumentContainer: InevDocumentContainer;        override;
  end;


  TarCustomDocument = class(Tl3Base)
  private
   fDocInfo           : TarDocInfo;
   fTextSourceArr     : array [Tm3DocPartSelector] of TarTextOfDocument;
   fWrongHlinkList    : Tl3LongintList;

   fOnAfterDataInsert : TNotifyEvent;
   fOnDocTextSave     : TOnDocTextSave;
   //fNewDoc : Boolean; // выставляется, когда текста у документа не было

   function  GetTextAttribute(aDocPart : Tm3DocPartSelector) : TarTextOfDocument; virtual;
   function  GetTextSource : TarTextOfDocument;
   function  GetTextSourceAnno : TarTextOfDocument;
   procedure SetDocFamily(aValue : TdaFamilyID); virtual;
   function  GetDocFamily : TdaFamilyID;
   procedure SetDocID(aValue : TDocId); virtual;
   function  GetDocID : TDocID;
   procedure SetDocClass(aValue : TDocType);  virtual;
   function  GetDocClass : TDocType;
   function  GetDocInfo : TarDocInfo;
   function  GetUserType : TUserType; virtual; abstract;
   procedure SetUserType (aValue : TUserType); virtual; abstract;

   function  GetUserDocID : TDocId;          //virtual;
   procedure SetUserDocID(aValue : TDocId);  //virtual;

   function  pmGetDocumentServer : TDocumentServer;

  protected
   function GetTextOfDocumentClass: RarTextOfDocument; virtual; abstract;
    {* - возвращает класс TextSource документа. }

   procedure DoAfterDataInsert(aSender: TObject; aInsertInEmptyDoc : Boolean); virtual;
   function  evntGetHFPainter(aSender: TObject; aPrintBlock : Boolean) : Il3HAFPainter;

   // - функции поддержки картинки в доке, лазят непосредственно в базу, надо разбираться
   //procedure ExportObject(anObjID: Integer; const aStream: TStream);
   //procedure ImportObject(anObjID: Integer; const aStream: TStream);
   //procedure DeleteObject(anObjID: Integer);

   procedure SaveDocPart(aPart: Tm3DocPartSelector; aFullSave: Boolean); // virtual;
   function  GenDocInfoRecord : Tm3DBDocumentInfo; virtual;

  public
   function  DataWasLoaded : Boolean;
   procedure LoadText(aDocPart         : Tm3DocPartSelector  = m3_dsMain;
                      aGoToType        : Integer = Ord(ev_sbtNone);
                      aGoToHandle      : Longint = 0;
                      aFoundSelector   : Tm4Addresses = nil;
                      const aSearcher  : IevSearcher = nil); virtual;

   procedure LoadPrevVersion(aStg : TStgSelector;  aLevel : Integer; aDocPart : Tm3DocPartSelector  = m3_dsMain);

   procedure CreateNewText(aDocPart : Tm3DocPartSelector = m3_dsMain); virtual;

   function  GetLocalStoragePath : TPathStr; virtual;
   function  GetGlobalStoragePath : TPathStr; virtual;

   procedure PasteTextFromFile(aExtFileName  : TFileName;
                               aFilterIndex  : Integer;
                               const aCursor : TnevCursor;
                               aDocPart      : Tm3DocPartSelector); virtual;

   procedure DeletePersistent;

   procedure DeleteLocalCopy;

   function  IsPossibleText : Boolean; virtual;
   function  IsModified(aDocParts : Tm3DocPartSet = m3_AllDocParts) : Boolean;         virtual;
   procedure Save(aFullSave : Boolean); virtual;
   procedure UnLoad;
   procedure ReLoad;

   function  GetBasesStr : string;

   procedure GetDocInformation(const lInfoOut  : IInfoOut);

   procedure GetDocStatistic(var aCharCount : Long; var aTableCharCount: Long; var aCellCount: Long);

   {DT}
   procedure InitWrongHlinkList;
   {* - Набирает список неправильных ссылок для их последующего поиска}
   function  GetWrongHlinkList : Tl3LongintList;
   {* - Возвращает список неправильных ссылок для их последующего поиска}

   function HasTextSource(aDocumentStreamSelector : Tm3DocPartSelector = m3_dsMain): Boolean;

   constructor Create(aFamily : TdaFamilyID = 0); reintroduce;
   constructor CreateParam(aDocFamily : TdaFamilyID; aDocID : TDocID; aUserDocID : Boolean = false); virtual;
   procedure Cleanup; override;
   procedure ClearWindowLink; virtual;
    {* -  отвязывается от окна редактора, что бы не вызывать его эвенты в случае, когда окно закрыли, а Doc работает (переворот редакции)}

   property DocInfo     : TarDocInfo read GetDocInfo;
   property DocFamily   : TdaFamilyID  read GetDocFamily write SetDocFamily;
   property DocID       : TDocID     read GetDocID write SetDocID;
   property UserDocID   : TDocId     read GetUserDocID write SetUserDocID;
   property DocClass    : TDocType   read GetDocClass write SetDocClass;
   property UserType    : TUserType  read GetUserType;
   property TextSource  : TarTextOfDocument read GetTextSource;
   property AnnoTextSource  : TarTextOfDocument read GetTextSourceAnno;
   property TextAttribute[aDocPart : Tm3DocPartSelector] : TarTextOfDocument read GetTextAttribute;
   property DocServer   : TDocumentServer read pmGetDocumentServer;

   property OnAfterDataInsert : TNotifyEvent read fOnAfterDataInsert write fOnAfterDataInsert;
   property OnDocTextSave : TOnDocTextSave read fOnDocTextSave write fOnDocTextSave;
  end;

  TarDocument = class;

  TSprDocument = class(TarCustomDocument)
   protected
    fMasterDoc : TarDocument;

    function GetTextOfDocumentClass: RarTextOfDocument; override;
    {* - возвращает класс TextSource документа. }
    //function GenDocInfoRecord : Tm3DBDocumentInfo; override;

   public
    constructor CreateParam(aMasterDoc : TarDocument; aDocID : TDocID; aUserDocID : Boolean = false); reintroduce;
    //procedure Cleanup; override;
    function  GetLocalStoragePath : TPathStr; override;
  end;

  TarDocumentwithAttr = class(TarCustomDocument)
  protected
   fAttrManager : TDocAttributeManager;
   fOnChangeDocAttribute : TOnChangeDocAttribute;

   procedure DoAfterDataInsert(aSender: TObject; aInsertInEmptyDoc : Boolean); override;
   procedure evntBeforeSaveAttribute(const aSender: IDocAttribute); virtual;
   procedure evntChangeDocAttribute(const aSender: IDocAttribute);  virtual;

   function  GetDocAttribute(aAttrID : TdtAttribute) : IDocAttribute;

   procedure ReloadDocAttributes(aSubID : TSubID; aAttrIDSet : TdtAttributeSet = []);
    //procedure SynchronizeDeleteFromAttrManagers(aMasterAttrManager : TDocAttributeManager; aAttrID : TdtAttribute; aDictID : TDictID);
   {* - При удалении с SubID = cAllSubs удаляет также из fAttrManager (SubID = 0)}

   function  AttrWasModified(aDocParts : Tm3DocPartSet): boolean; virtual;

   procedure Save(aFullSave : Boolean = True); override;
   procedure Cleanup; override;
  public
   procedure ClearWindowLink; override;

   function AttrManager(aSubID : TSubID = 0): TDocAttributeManager; virtual;
   property OnChangeDocAttribute : TOnChangeDocAttribute
     read fOnChangeDocAttribute
     write fOnChangeDocAttribute;
   property Attribute[aAttrID : TdtAttribute] : IDocAttribute read GetDocAttribute;
  end;

  TarQueryDataTextOfDocument = class(TarTextOfDocument)
  public
   function GetDocumentType : Tk2Type; override;
  end;

  TQueryDataDocument = class(TarDocumentwithAttr)
  private
   function  GetTextAttribute(aDocPart : Tm3DocPartSelector) : TarTextOfDocument; override;
  public
   function AttrManager(aSubID : TSubID = 0): TDocAttributeManager; override;
  end;

  TarDocument = class(TarDocumentwithAttr, Il3ChangeRecipient)
   private
    f_DocObject: TarDocObject;
    f_IsLoading: Boolean;
    fCorespondentsList : TDocumentSabList;
    fRespondentsList   : TDocumentSabList;

    function GetAnnoTextSource: TarTextOfDocument;
    function pm_GetDocObject: TarDocObject;

    function  GetCorespondentsList: TDocumentSabList;
    function  GetRespondentsList: TDocumentSabList;

   protected
    fSpravka            : TSprDocument;
    //fDocData            : TDocumentAttrData;
    fLockHandle         : TJLHandle;
    fMaxMask            : Longint;
    fLockMask           : Longint;

    fSubAttrManager     : TDocAttributeManager;

    fDocLogRec    : array[Low(TLogActionType)..High(TLogActionType)] of Boolean;
    fMainRecModified  : Boolean;
    fIsAnnoWasDeleted : Boolean;

    procedure Changed;
    procedure Changing;
    function  GetSpr : TSprDocument;
    procedure SetSpr(Value : TSprDocument);

    //function  GetDocData       : TDocumentAttrData;
    //procedure SetDocData(Value : TDocumentAttrData);

    procedure SetDocFamily(aValue : TdaFamilyID); override;
    procedure SetDocID(aValue : TDocId);     override;

//    procedure SaveDocPart(aPart: Tm3DocPartSelector; aFullSave: Boolean); override;

    function  GetShortName : Tl3WString;
    function  GetName      : Tl3WString;
    function  GetAnnoName  : Tl3WString;
    function  GetHasAnno   : Boolean;
    function  GetUrgency   : Byte;
    function  GetUserType  : TUserType; override;

    procedure SetDocClass (aValue : TDocType); override;
    procedure SetShortName(aValue : Tl3WString);
    procedure SetName     (aValue : Tl3WString);
    procedure SetAnnoName (aValue : Tl3WString);
    //procedure SetUserDocID(aValue : TDocId); override;
    procedure SetHasAnno  (aValue : Boolean);
    procedure SetUrgency  (aValue : Byte);
    procedure SetUserType (aValue : TUserType); override;

    function  GetStatus : Word;
    procedure SetStatus(aValue :  Word);

    function  GetStatusMask : Word;
    procedure SetStatusMask(aValue :  Word);

    function  CalcAutoPriority : Word;
    function  GetPriority : Word;
    //procedure SetPriority(aValue :  Word);
    //procedure SetPriorityPrim(aValue :  Integer);

    function  GetPriorFlag : Boolean;
    //procedure SetPriorFlag(aValue : Boolean);

    function  GetDocComment: Tl3WString;
    procedure SetDocComment(aValue : Tl3WString);

    function  GetRelated : TDocID;
    procedure SetRelated(aValue :  TDocID);

    function  GetSprShortName : Tl3WString;
    procedure SetSprShortName(aValue : Tl3WString);

    function  GetTextOfDocumentClass: RarTextOfDocument; override;
     {* - возвращает класс TextSource документа. }

    procedure evntChangeDocAttribute(const aSender: IDocAttribute); override;

    function  IsNeedAddLog(aDocParts : Tm3DocPartSet) : Boolean;

    function  GenDocInfoRecord : Tm3DBDocumentInfo; override;
   public
    function  AttrManager(aSubID : TSubID = 0): TDocAttributeManager; override;
    procedure Analyse(const Text: string);
    {* - Анализирует текст и заполняет атрибуты.}

    procedure Close;
    constructor CreateParam(aDocFamily : TdaFamilyID; aDocID : TDocID; aUserDocID : Boolean = false); override;
    procedure Cleanup; override;

    procedure MakeNew(aDocClass : TDocType; aSrcFile: TFileName = '');

    function  MakeSpravka(aDocID : TDocID = 0): TSprDocument;
    procedure DeleteSpr;
    procedure DeleteAnno;
    procedure SetAlienSpr(aSprUserDocID : Longint);
    procedure LoadText(aDocPart         : Tm3DocPartSelector = m3_dsMain;
                      aGoToType        : Integer = Ord(ev_sbtNone);
                      aGoToHandle      : Longint = 0;
                      aFoundSelector   : Tm4Addresses = nil;
                      const aSearcher  : IevSearcher = nil); override;

    procedure CheckRequiredFields;
    function  AttrWasModified(aDocParts : Tm3DocPartSet): boolean; override;
    function  IsModified(aDocParts : Tm3DocPartSet = m3_AllDocParts) : Boolean;         override;

    procedure PrepareEditablePartsInfo;
    //procedure SaveAttributes(aSubID : TSubID = cAllSubs);
    //procedure SaveDocData;

    //procedure CreateNewText(aDocPart : Tm3DocPartSelector = m3_dsMain); override;
    procedure Save(aFullSave : Boolean = True); override;

    {Special}
    procedure MakeDocCopy(aCopyDocUserID : TDocID; aAttrSetKind : TddAttrSetKind; aCopyType : TUserType = utEdition);
  {* - Формирует заготовку "редакции" документа :
          копирует документ в документ с внешним номером aCopyDocUserID,
          отрезает лишние атрибуты,
          выставляет тип utEdition}

    function  IsLock : Boolean;
    procedure Lock;
    procedure Unlock;
    procedure Relock;
    procedure WhoLockDoc(var aStation : TStationNameArray; var aUserID : TdaUserIDArray);

    function IsPossibleText : Boolean; override;
    function IsPossibleSpr: Boolean;

    procedure PasteTextFromFile(aExtFileName  : TFileName;
                                aFilterIndex  : Integer;
                                const aCursor : TnevCursor;
                                aDocPart      : Tm3DocPartSelector); override;

    function GetSprDocID : TDocID;
    function GetPrevVerDocID : TDocID;

    function IsActive : Boolean;

    function HasSpravka : Boolean;

    //function GetVersionDocImageIndex(aIndex : Integer) : Integer;
    function IsFutureVersion : Boolean;

    procedure AddLog(aLogType : TLogActionType);
    procedure SetPriority(aValue : Word; aManualSetted : Boolean);

    procedure RefreshCorespondentsList(aSubList: Tl3LongintList = nil);

    property Spravka     : TSprDocument read GetSpr write SetSpr;

    property MaxMask     : Longint read fMaxMask;
    property LockMask    : Longint read fLockMask;

    property AnnoTextSource  : TarTextOfDocument read GetAnnoTextSource;

    {main}
    //property DocClass  : TDocType    read GetDocClass  write SetDocClass;
    property UserType  : TUserType   read GetUserType  write SetUserType;
    property ShortName : Tl3WString  read GetShortName write SetShortName;
    property Name      : Tl3WString  read GetName      write SetName;
    property HasAnno   : Boolean     read GetHasAnno   write SetHasAnno;
    property AnnoName  : Tl3WString  read GetAnnoName  write SetAnnoName;

    property Urgency   : Byte        read GetUrgency   write SetUrgency;

    property Status     : Word       read GetStatus    write SetStatus;
    property StatusMask : Word       read GetStatusMask write SetStatusMask;

    property Priority  : Word        read GetPriority;  //write SetPriority;
    property PriorFlag : Boolean     read GetPriorFlag; //write SetPriorFlag;

    property DocComment: Tl3WString  read GetDocComment write SetDocComment;

    property Related   : TDocID      read GetRelated write SetRelated;
    property SprShortName : Tl3WString  read GetSprShortName write SetSprShortName;

    property ObjAccess: TarDocObject read pm_GetDocObject;

    property CorespondentsList : TDocumentSabList read GetCorespondentsList;
    property RespondentsList   : TDocumentSabList read GetRespondentsList;

  end;//TarDocument

 TDocsList = class(Tl3Base)
   private
    fDocList : Tl3DataList;
    procedure SetDocAddr(I : Longint; Value : TDocAddr);
    function  GetDocAddr(I : Longint) : TDocAddr;
    function  GetDocList : Tl3DataList;
    function  GetCount : Longint;
   public
    procedure Cleanup; override;
    procedure AddAddrToList(aDocAddr : TDocAddr);
    procedure ClearIDList;

    property DocAddr[I : Longint] : TDocAddr read GetDocAddr write SetDocAddr;
    property DocList : Tl3DataList read GetDocList;
    property Count : Longint read GetCount;
  end;//TDocsList

 EUserError           = class(El3NoLoggedException);
 EDocNotPresentError  = class(El3NoLoggedException);
 EAssignError         = class(El3NoLoggedException);
 ERequiredFieldsEmpty = class(El3NoLoggedException);
 ESprForbidden        = class(El3NoLoggedException);

 function DocAddr(aFamID : TdaFamilyID; aDocID  : TDocID) : TDocAddr;
 procedure DeleteLocalCopy(aDocID : TDocID);

implementation

uses
  ActiveX,
  ComObj,
  Forms,
  Printers,
  Dialogs,

  TypInfo,
  vtDialogs,

  StrShop,
  IniShop,
  VConst,
  Com_Cnst,

  daDataProvider,
  daSchemeConsts,

  dt_Serv,
  dt_Record,
  DT_Sab,
  Dt_Acces,
  Dt_CFltr,
  Dt_IFltr,
  Dt_RecalcHLinkFilter,
  DT_Stage,
  DT_Prior,

  m4DictTypes,
  m4DictScanner,
  m4PhraseParser,

  arTextOfDocumentWithContentsTree,

  m2COMLib,

  m3StorageInterfaces,
  m3StgMgr,

  Readers,

  k2Tags,

  ddDocReader,
  ddNSRC_r,
  ddHTML_r,
  ddFixFilter,

  ddExtObjectSupport,
  ddImageHandleInsert,
  //ddKTExtractor,

  l3Bits,
  l3MinMax,
  l3Chars,
  l3BaseStream,
  l3Stream,
  l3String,
  l3BitmapContainer,
  l3Memory,
  l3Bitmap,
  l3Languages,

  k2Except,
  k2TagFilter,

  afwInterfaces,

  evdVer,
  evdPlainTextWriter,
  evdHyperlinkCorrector,
  evdF1HyperlinkCorrector,
  evStrictContentsElementEliminator,
  evBlocksEliminator,
  evTagsListFilter,

  evdBufferedFilter,
  evFacadTextSource,

  nevBase,
  nevInternalInterfaces,
  nevPersistentDocumentContainer,
  evdBadEVDToEmptyDocumentTranslator,

  evFacadeSub,
  evFacadeGUI,
  evFacadeUtils,

  evCommonUtils,

  evConst,
  evSubWaiter,
  evSearchWaiter,
  evOutTextParaEliminator,
  evStatisticsFilter,
  evTextFormatter,
  evDocumentPreview,
  evGraphicFileSupport,

  arDocAttributesMixer,
  arHAFPainer,
  arMacroReplacer,
  arDocumentContainer,
  arFoundSelectionFilter,
  arSpravkaDocumentContainer,
  arDocumentContainerWithContentsTree,
  arUploadDocumentHelper,

  ArchiUserRequestManager,

  StDateSt,

  imageenio,

  ResShop,
  Base_CFG,

  DocAttrToolsIntf,
  DocAttrImpl2,
  vtDebug,

  TextPara_Const,
  DictEntry_Const,
  AnnoTopic_Const,
  DocumentQuery_Const,

  dt_DictSup, dt_DictTypes, dt_DictConst,
  arVAnouncedBlackList,
  DocAttrTypes,
  Document_Const,
  LeafPara_Const,
  
  m3SimpleDB,
  m3DBFiler
  ;

function DocAddr(aFamID : TdaFamilyID; aDocID  : TDocID) : TDocAddr;
begin
 with Result do
 begin
  FamID := aFamID;
  DocID := aDocID;
 end;
end;

{TarDocInfo}
constructor TarDocInfo.Make(aDocFamily : TdaFamilyID = 0; aDocID : TDocID = 0; aDocClass : TDocType = dtText);
begin
 Create;
 DocFamily := aDocFamily;
 DocID  := aDocID;
 DocClass := aDocClass;
end;

procedure TarDocInfo.SetDocFamily(aValue : TdaFamilyID);
begin
 fDocFamily := aValue;
 //fUserDocID := 0;
end;

procedure TarDocInfo.SetDocID(aValue : TDocID);
begin
 fDocID := aValue;
 //fUserDocID := 0;
end;

function TarDocInfo.IsSetted : Boolean;
begin
 Result := (DocFamily > 0) and (DocID > 0);
end;

(*
function TarDocInfo.GetUserDocID : TDocID;
begin
 if fUserDocID <= 0 then
  fUserDocID := LinkServer(DocFamily).Renum.GetExtDocID(DocID);
 Result := fUserDocID;
end;

function TarDocInfo.SetUserDocID(aValue : Longint) : Boolean;
var
 lUserDocID : TDocID;
begin
 if DocID = 0 then
  lUserDocID := 0
 else
  lUserDocID := LinkServer(DocFamily).Renum.GetExtDocID(DocID);

 Result := lUserDocID <> aValue;
 if Result then
 begin
  if (DocID <> 0) and not LinkServer(DocFamily).Renum.UpdateImportNumber(DocID, aValue) then
   raise EAssignError.CreateFmt(sidEWNotUniq,[scDocID]);

  fUserDocID := aValue;
  //fUserDocID := 0; // получить в GetUserDocID
 end;
end;
*)

{TarCustomDocument}
constructor TarCustomDocument.Create(aFamily : TdaFamilyID = 0);
begin
 inherited Create;
 DocFamily := aFamily;
end;

constructor TarCustomDocument.CreateParam(aDocFamily : TdaFamilyID; aDocID : TDocID; aUserDocID : Boolean = false);
begin
 Create;
 DocFamily := aDocFamily;
 if aUserDocID then
  aDocID := LinkServer(aDocFamily).Renum.ConvertToRealNumber(aDocID);
 if aDocID < 0 then
  raise EDocNotPresentError.Create('');
 SetDocID(aDocID);
end;

procedure TarCustomDocument.Cleanup;
var
 I : Tm3DocPartSelector;
begin
 l3Free(fDocInfo);
 l3Free(fWrongHlinkList);
 ClearWindowLink;

 for I := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
  l3Free(fTextSourceArr[I]);
 inherited;
end;

procedure TarCustomDocument.ClearWindowLink;
begin
 fOnAfterDataInsert := nil;
 fOnDocTextSave     := nil;
end;

procedure TarCustomDocument.SetDocFamily(aValue : TdaFamilyID);
begin
 if DocFamily = aValue then Exit;
 if DocFamily > 0 then
  UnLoad;

 DocInfo.DocFamily := aValue;
end;

function TarCustomDocument.GetDocFamily : TdaFamilyID;
begin
 Result := DocInfo.DocFamily;
end;

procedure TarCustomDocument.SetDocID(aValue : TDocId);
begin
 if DocID = aValue then Exit;
 if DocInfo.DocID > 0 then
  UnLoad;
 DocInfo.DocID := aValue;
end;

function TarCustomDocument.HasTextSource(aDocumentStreamSelector : Tm3DocPartSelector = m3_dsMain) : Boolean;
begin
 Result := fTextSourceArr[aDocumentStreamSelector] <> nil;
end;

function TarCustomDocument.GetTextAttribute(aDocPart : Tm3DocPartSelector) : TarTextOfDocument;
begin
 if fTextSourceArr[aDocPart] = nil then
 begin
  if aDocPart = m3_dsAnno then
   fTextSourceArr[aDocPart] := TarTextOfAnnoDocument.Make(DocInfo, aDocPart)
  else
   fTextSourceArr[aDocPart] := GetTextOfDocumentClass.Make(DocInfo, aDocPart);

  fTextSourceArr[aDocPart].OnAfterDataInsert := DoAfterDataInsert;
  fTextSourceArr[aDocPart].OnGetHFPainter    := evntGetHFPainter;
 end;
 Result := fTextSourceArr[aDocPart];
end;

function TarCustomDocument.GetTextSource : TarTextOfDocument;
begin
 if IsPossibleText then
  Result := GetTextAttribute(m3_dsMain)
 else
  Result := nil;
end;

function TarCustomDocument.GetTextSourceAnno : TarTextOfDocument;
begin
 Result := GetTextAttribute(m3_dsAnno);
end;

function TarCustomDocument.GetDocID : TDocID;
begin
 Result := DocInfo.DocID;
end;

procedure TarCustomDocument.SetDocClass(aValue : TDocType);
begin
 DocInfo.DocClass := aValue;
end;

function  TarCustomDocument.GetDocClass : TDocType;
begin
 Result := DocInfo.DocClass;
end;

function  TarCustomDocument.GetDocInfo : TarDocInfo;
begin
 if fDocInfo = nil then
  fDocInfo := TarDocInfo.Make;

 Result := fDocInfo;
end;

function  TarCustomDocument.GetUserDocID : TDocId;
begin
 Result := TextSource.Document.IntA[k2_tiExternalHandle];
 if Result <= 0 then
 begin
  Result := LinkServer(DocFamily).Renum.GetExtDocID(DocID);
  if (Result > 0) and DataWasLoaded then
   TextSource.Document.IntA[k2_tiExternalHandle] := Result;
 end;
end;

procedure TarCustomDocument.SetUserDocID(aValue : TDocId);
begin
 with TextSource.Document do
  if IntA[k2_tiExternalHandle] <> aValue then
  begin
   if (aValue <> 0) and not LinkServer(DocFamily).Renum.UpdateImportNumber(DocID, aValue) then
    raise EAssignError.CreateFmt(sidEWNotUniq,[scDocID]);
   IntA[k2_tiExternalHandle] := aValue;
   //DocInfo.SetUserDocID(aValue);

   TextSource.SetEditablePart(epRenum);
  end;
 //TextSource.Document.IntA[k2_tiExternalHandle] := aValue;
 //DocInfo.SetUserDocID(aValue);
end;

function  TarCustomDocument.pmGetDocumentServer : TDocumentServer;
begin
 Result := DocumentServer;
 Result.Family := DocFamily;
 //Result.DocID := DocID;
end;

procedure TarCustomDocument.InitWrongHlinkList;
begin
 l3Free(fWrongHlinkList);
 fWrongHlinkList := Tl3LongintList.Create;
 LinkServer(DocFamily).HLinkTbl.CheckDestInDoc(DocID, fWrongHlinkList);
end;

function TarCustomDocument.GetWrongHlinkList : Tl3LongintList;
begin
 if fWrongHlinkList = nil then InitWrongHlinkList;
 Result := fWrongHlinkList;
end;

procedure TarCustomDocument.GetDocStatistic(var aCharCount : Long; var aTableCharCount: Long; var aCellCount: Long);
var
 l_DB        : Im3DB;
 lTextReader : TevEVDReader;
 lBaseFiler  : Tl3CustomFiler;
 lCntFilter  : TevStatisticsFilter;
begin
 if (DocFamily = 0) or (DocID = 0) then exit;

 lTextReader := TevEVDReader.Create;
 try
  l_DB := dtGetDB(DocFamily);
  try
   lBaseFiler := Tm3DBFiler.Create(l_DB, DocID, m3_dsMain {DocStream});
  finally
   l_DB := nil;
  end;//try..finally
  try
   lTextReader.Filer := lBaseFiler;
  finally
   l3Free(lBaseFiler);
  end;
  lCntFilter := TevStatisticsFilter.Create;
  try
   lTextReader.Generator := lCntFilter;
   lTextReader.Execute;
   aCharCount := lCntFilter.CharCount;
   aTableCharCount := lCntFilter.TableCharCount;
   aCellCount := lCntFilter.CellCount;
  finally
   l3Free(lCntFilter);
  end;{try..finally}
 finally
  l3Free(lTextReader);
 end;
end;

procedure TarCustomDocument.DeletePersistent;
begin
 if DocID > 0 then
  DocServer.DelDoc(DocID);
end;

function TarCustomDocument.IsPossibleText : Boolean;
begin
 Result := True;
end;

function TarCustomDocument.IsModified(aDocParts : Tm3DocPartSet = m3_AllDocParts): Boolean;
var
 I : Tm3DocPartSelector;
begin
 Result := False;
 for I := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
  if (I in aDocParts) and (fTextSourceArr[I] <> nil) then
  begin
   Result := fTextSourceArr[I].Modified;
   if Result then
    Exit;
  end;
end;

procedure TarCustomDocument.Save(aFullSave : Boolean);
 procedure SavedocInfo;
 var
  lDB : Im3DB;
  lDocument : Im3DBDocument;
 begin
  lDB := Tm3SimpleDB.Make(GetLocalStoragePath);
  try
   lDocument := lDB.GetDocument(DocID);
   lDB := nil;
   try
    lDocument.GetVersion.Info := GenDocInfoRecord;
   finally
    lDocument := nil;
   end;
  finally
   lDB := nil;
  end;//try..finally
 end;

var
 lPart : Tm3DocPartSelector;
begin
 if not aFullSave and IsModified then
  SaveDocInfo;

 for lPart := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
  if IsModified([lPart]) then
   SaveDocPart(lPart, aFullSave);
end;

procedure TarCustomDocument.ReLoad;
begin
 Unload;
 TextSource.LoadText;
end;

procedure TarCustomDocument.UnLoad;
var
 I : Tm3DocPartSelector;
begin
 for I := Low(Tm3DocPartSelector) to High(Tm3DocPartSelector) do
  if fTextSourceArr[I] <> nil then
   fTextSourceArr[I].UnLoadText;
end;

procedure TarCustomDocument.PasteTextFromFile(aExtFileName : TFileName;
                                            aFilterIndex   : Integer;
                                            const aCursor  : TnevCursor;
                                            aDocPart       : Tm3DocPartSelector);
begin
 if fTextSourceArr[aDocPart] <> nil then
   fTextSourceArr[aDocPart].LoadTextFromFile(aExtFileName, aFilterIndex, aCursor);
end;

procedure TarCustomDocument.CreateNewText(aDocPart : Tm3DocPartSelector  = m3_dsMain);
begin
 TextAttribute[aDocPart].MakeNewDoc;
end;

function TarCustomDocument.DataWasLoaded : Boolean;
begin
 Result := TextSource.Document.IsValid;
end;

procedure TarCustomDocument.LoadText(aDocPart         : Tm3DocPartSelector  = m3_dsMain;
                                     aGoToType        : Integer = Ord(ev_sbtNone);
                                     aGoToHandle      : Longint = 0;
                                     aFoundSelector   : Tm4Addresses = nil;
                                     const aSearcher  : IevSearcher = nil
                                     );
begin
 //if DataWasLoaded then Exit;
 if Tm3StorageManager.StorageFileExists(GetLocalStoragePath) and TextAttribute[aDocPart].ExistInLocal(GetLocalStoragePath) then
  TextAttribute[aDocPart].LoadLocalText(GetLocalStoragePath);

 if not TextAttribute[aDocPart].Document.IsValid then
  TextAttribute[aDocPart].LoadText(aGoToType, aGoToHandle,
                      aFoundSelector, aSearcher);

 if not TextAttribute[aDocPart].Document.IsValid then
  CreateNewText(aDocPart);
end;

procedure TarCustomDocument.LoadPrevVersion(aStg : TStgSelector; aLevel : Integer; aDocPart : Tm3DocPartSelector  = m3_dsMain);
begin
 with TextAttribute[aDocPart] do
 begin
  UnLoadText;
  case aStg of
   ssLocal  : LoadLocalText(GetLocalStoragePath, aLevel);
   ssGlobal :
   begin
    LoadText(ord(ev_sbtNone), 0 {aGoToHandle}, nil {aFoundSelector}, nil {aSearcher}, aLevel);
    Modified := true;
   end;
  end;
 end;
end;

procedure TarCustomDocument.DoAfterDataInsert(aSender: TObject; aInsertInEmptyDoc : Boolean);
begin
end;

function TarCustomDocument.evntGetHFPainter(aSender: TObject; aPrintBlock : Boolean) : Il3HAFPainter;
var
 l_MacroReplacer: Il3HAFMacroReplacer;
begin
 l_MacroReplacer := TarMacroReplacer.Make(nil, Self, aPrintBlock);
 Result := TarHAFPainer.Make(l_MacroReplacer);
end;

function TarCustomDocument.GetBasesStr : String;
var
 lList : TStringList;
 I : Integer;
begin
 Result := '';
 lList := TStringList.Create;
 With lList do
  try
   LinkServer(DocFamily).GetAttributeList(da_dlBases, DocID, lList, True);
   If lList.Count > 0 then
    begin
     Result := lList[0];
     for I := 1 to Pred(lList.Count) do
      Result := Result + '/' + lList[I];
    end;
  finally
   Free;
  end;
end;

procedure TarCustomDocument.GetDocInformation(const lInfoOut : IInfoOut);
var
 lCharCount : Long;
 lTableCharCount: Long;
 lCellCount: Long;
begin
 with lInfoOut do
 begin
  GetDocStatistic(lCharCount, lTableCharCount, lCellCount);

  StartData;
  AddString(Format('Внутренний ID: %d'#13#10, [DocID]));
  AddString(Format('Внешний ID: %d'#13#10, [UserDocID]));
  AddString(Format('Группы документов : %S'#13#10, [GetBasesStr]));
  AddString('_______'#13#10);
  AddString(Format('Всего символов: %d'#13#10, [lCharCount + lTableCharCount]));
  AddString(Format('из них в таблице: %d'#13#10, [lTableCharCount]));
  AddString(Format('Ячеек: %d', [lCellCount]));
  EndData;
 end;
end;

(* снести потом *)
(*
procedure TarCustomDocument.ImportObject(anObjID: Integer; const aStream: TStream);
var
 l_IStr: IStream;
 l_SA  : TStreamAdapter;
 l_R, l_W : Int64;
begin
 l_IStr := dtGetObjectStream(DocFamily, DocID, anObjID, m3_saCreate);
 if l_IStr <> nil then
 try
  l_SA := TStreamAdapter.Create(aStream, soReference);
  try
   l_SA.CopyTo(l_IStr, MaxInt, l_R, l_W);
  finally
   l3Free(l_SA);
  end;
 finally
  l_IStr := nil;
 end;
end;

procedure TarCustomDocument.ExportObject(anObjID: Integer; const aStream: TStream);
var
 l_IStr: IStream;
 l_Out : IStream;
 l_R, l_W : Int64;
begin
 l_IStr := dtGetObjectStream(DocFamily, DocID, anObjID, m3_saRead);
 if l_IStr <> nil then
 try
  l_Out := l3Stream2IStream(aStream);
  try
   l_IStr.CopyTo(l_Out, MaxInt, l_R, l_W);
  finally
   l_Out := nil;
  end;
 finally
  l_IStr := nil;
 end;
end;

procedure TarCustomDocument.DeleteObject(anObjID: Integer);
var
 l_DB  : Im3DB;
 l_Doc : Im3DBDocument;
begin
 l_DB := dtGetDB(DocFamily);
 try
  l_Doc := l_DB.GetDocument(DocID);
  try
   l_Doc.DeleteObject(anObjID);
  finally
   l_Doc := nil;
  end;
 finally
  l_DB := nil;
 end;
end;
*)

function TarCustomDocument.GetLocalStoragePath : TPathStr;
begin
 Result := ConcatDirName(IniRec.PathToLocalSaveDir, IntToStr(DocID));
end;

function  TarCustomDocument.GetGlobalStoragePath : TPathStr;
begin
 Result := GlobalDataProvider.TextBase[DocFamily];
end;

function  TarCustomDocument.GenDocInfoRecord : Tm3DBDocumentInfo;
begin
 Result := Tm3DBDocumentInfo_C(ord(DocClass));
 with Result do
 begin
  rDocType := Ord(DocClass);
  rExtDocID := Max(UserDocID, 0);
 end;
end;

procedure TarCustomDocument.DeleteLocalCopy;
var
 l_DB : Im3DB;
begin
 //Tm3StorageManager.DeleteStorageFile(GetLocalStoragePath);
 l_DB := Tm3SimpleDB.Make(GetLocalStoragePath);
 try
  l_DB.DeleteVersion;
 finally
  l_DB := nil;
 end;//try..finally
end;

procedure TarCustomDocument.SaveDocPart(aPart: Tm3DocPartSelector; aFullSave: Boolean);
begin
 if (fTextSourceArr[aPart] = nil) or
    (Assigned(fOnDocTextSave) and not fOnDocTextSave(aPart, aFullSave)) then
  Exit;

 if aFullSave then
 begin
  TextAttribute[aPart].Commit;
  DeleteLocalCopy;
 end
 else
  TextAttribute[aPart].SaveLocal(GetLocalStoragePath, GenDocInfoRecord);
end;

{TarDocumentWithAttr}
procedure TarDocumentWithAttr.Cleanup;
begin
 l3Free(fAttrManager);
 inherited;
end;

procedure TarDocumentWithAttr.ClearWindowLink;
begin
 inherited;
 fOnChangeDocAttribute := nil;
end;

procedure TarDocumentWithAttr.Save(aFullSave : Boolean = True);
begin
 if assigned(fAttrManager) then
  fAttrManager.BeforeSaveDocData;
 inherited; //!!там Modified сбрасывается
end;

procedure TarDocumentWithAttr.DoAfterDataInsert(aSender: TObject; aInsertInEmptyDoc : Boolean);
begin
 if not aInsertInEmptyDoc then
 begin
  ReloadDocAttributes(0);
  //fDocData.RefreshDateNumList;
  if (Assigned(fOnAfterDataInsert)) then fOnAfterDataInsert(Self);
 end;
end;

procedure TarDocumentWithAttr.evntBeforeSaveAttribute(const aSender: IDocAttribute);

{Старую логику см в v.1.26}
function CheckAnoncedConditions: Boolean;
 var
  I : Integer;
  l_BlackList: Tl3LongintList;
  l_AccGr : IListDocAttribute;
 begin
  Result := (UserType in utFullFeatureDocTypes);
  if Result then
  begin
   l_BlackList := GetVAnouncedAccGroupsBlackList;
   if l_BlackList.Count = 0 then exit;
   l_AccGr := AttrManager.GetDocAttribute(atAccGroups) as IListDocAttribute;
   if l_AccGr <> nil then
    for I := 0 to Pred(l_AccGr.Count) do
    begin
     Result := l_BlackList.IndexOf(l_AccGr.Handle[I]) < 0;
     if not Result then
      Break;
    end;
  end;
 end;

//var
//  lListAttr : IDocAttribute;
begin
(*
 if aSender.AttrID = atDateNums then
 begin //вычисление SortDate
  lListAttr := AttrManager.GetDocAttribute(atDateNums);
  //if lListAttr.Modified then
  // SortDate := (lListAttr as IDateNumDocAttributeTool).GetMinPublishDate;
 end
 else
*) 
 if aSender.AttrID = atStages then
  if ((AttrManager.GetDocAttribute(atStages) as IStageDocAttributeTool).DateOfStageClosed(stEdit) = CurrentDate)
     and
     CheckAnoncedConditions then
     (AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool)
      .AddLogRecOnce(acAnonced, 0 {Check Any Date}, DateTimeToStDate(IniRec.AnouncedDate));
end;

procedure TarDocumentWithAttr.evntChangeDocAttribute(const aSender: IDocAttribute);
begin
 if Assigned(fOnChangeDocAttribute) then
   fOnChangeDocAttribute(aSender);
end;

function  TarDocumentWithAttr.GetDocAttribute(aAttrID : TdtAttribute) : IDocAttribute;
begin
 Result := AttrManager.GetDocAttribute(aAttrID);
end;

function TarDocumentWithAttr.AttrManager(aSubID : TSubID = 0): TDocAttributeManager;
begin
 if fAttrManager = nil then
 begin
  fAttrManager := TDocAttributeManager.Create(Self);
  fAttrManager.OnChangeDocAttribute := evntChangeDocAttribute;
  fAttrManager.OnBeforeSaveAttribute := evntBeforeSaveAttribute;
 end;
 Result := fAttrManager;
 Result.SubID := aSubID;
end;

procedure TarDocumentWithAttr.ReloadDocAttributes(aSubID : TSubID; aAttrIDSet : TdtAttributeSet = []);
begin
 AttrManager(aSubID).ReloadDocAttributes(aAttrIDSet);
end;

function TarDocumentWithAttr.AttrWasModified(aDocParts : Tm3DocPartSet): boolean;
begin
 Result := (fAttrManager <> nil) and fAttrManager.DataWasModified(aDocParts);
end;

{TarDocument}
procedure TarDocument.Analyse(const Text: string);
var
 lDNRec   : TDNAttrRec;
 lText    : Tl3PCharLen;

 procedure InitDN;
 begin
  lDNRec.rNum := nil;
  l3FillChar(lDNRec, SizeOf(TDNAttrRec));
  //lDNRec.ID  := cUndefDictID;
  lDNRec.rType := dnPublish;
 end;

 procedure PostAndClearDN;
 var
  lListAttr : IDateNumDocAttributeTool;
  TmpDN     : PDNDictRec;
  I         : Integer;
  begin
  lListAttr := AttrManager.GetDocAttribute(atDateNums) as IDateNumDocAttributeTool;
  try
   if lDNRec.rType = dnPublish then
   begin
    // проверяем, есть ли записи с такими же датой и номером
    with lListAttr do
     for I := 0 to Pred(Count) do
     begin
      if (GetType(I) <> dnPublish) then Continue;

      if GetDate(I) = lDNRec.rDate then
       lDNRec.rDate := 0;

      if l3Compare(l3PCharLen(GetNum(I)), l3PCharLen(lDNRec.rNum), l3_siCaseUnsensitive) = 0 then
      begin
       // если есть маленькие буквы у существующей строки, поднимем ей регистр
       if l3Compare(l3PCharLen(GetNum(I)), l3PCharLen(lDNRec.rNum)) = 0 then // новая строка гаранированно в верхнем регистре, если не совпадают, значит есть маленькие
       begin
        UpCaseNum(I);
        //lListAttr.DataWasChanged(I);
       end;
       lDNRec.rNum := nil;
      end;
     end;
    // если есть данные отличающиеся от существующих, то вставляем
    if (lDNRec.rDate <> 0) or not l3IsNil(lDNRec.rNum) then
     lListAttr.AddRec(dnPublish, lDNRec.rDate, l3PCharLen(lDNRec.rNum));
   end // if lDNRec.Typ = dnPublish then
   else
    with lListAttr do
     for I := 0 to Pred(lListAttr.Count) do
      if not ((GetType(I) = lDNRec.rType) and (GetDate(I) = lDNRec.rDate) and
         (l3Compare(l3PCharLen(GetNum(I)), l3PCharLen(lDNRec.rNum)) = 0)) then
       lListAttr.AddRec(lDNRec.rType, lDNRec.rDate, l3PCharLen(lDNRec.rNum));
  finally
   lListAttr := nil;
   InitDN;
  end;
 end;

 function lFoundDictItem(aDictItemID : Tm4DictItemAddr; aSegment : Tm4Segment) : boolean;
 begin
  Result := True;

  if aDictItemID.rDictionaryID >= 0 then
   (AttrManager.GetDocAttribute(DLType2AttrID(TdaDictionaryType(aDictItemID.rDictionaryID))) as IDictAttributeTool).AddRec(aDictItemID.rID)
  else
   case aDictItemID.rDictionaryID of
    cDateDictID :
     begin
      if lDNRec.rDate <> 0 then PostAndClearDN;
      lDNRec.rDate := StDateToDemon(aDictItemID.rID);
     end;

    cNumDictID :
     begin
      if l3Len(lDNRec.rNum) > 0 then PostAndClearDN;
      lDNRec.rNum := l3CStr(l3PcharLen(lText.S + aSegment.rOffs, aSegment.rLen, lText.SCodePage));
      l3MakeUpperCase(lDNRec.rNum.AsWStr.S, lDNRec.rNum.AsWStr.SLen);
      l3MakeSimpleANSI(lDNRec.rNum.AsWStr.S, lDNRec.rNum.AsWStr.SLen);
     end;

    cLawcaseNumDictID :
     begin
      if (l3Len(lDNRec.rNum) > 0) or (lDNRec.rDate <> 0) then PostAndClearDN;
      lDNRec.rType := dnLawCaseNum;
      lDNRec.rNum := l3CStr(l3PcharLen(lText.S + aSegment.rOffs, aSegment.rLen, lText.SCodePage));
      PostAndClearDN;
     end;

   end; //case aDictItemID.rDictionaryID do
 end; //function lFoundDictItem

var
 lFDIProcStub : Tm4FoundDictItemProc;
 lIdx : Integer;

begin
 InitDN;
 lText := l3PCharLen(Text);
 lIdx := l3CharSetPresentEx(lText, cc_Quotes);
 if lIdx >= 0 then
  lText.SLen := lIdx;

 // собственно, парсим строку
 lFDIProcStub := L2FoundDictItemProc(@lFoundDictItem);
 try
  DoParsePhrase(lText, DictServer(DocFamily).DictScanner, lFDIProcStub);
 finally
  FreeFoundDictItemProc(lFDIProcStub);
 end;

 if (l3Len(lDNRec.rNum) > 0) or (lDNRec.rDate <> 0) then
  PostAndClearDN;
end;

function TarDocument.GetTextOfDocumentClass: RarTextOfDocument;
begin
 Result := TarTextOfDocumentWithContentsTree;
end;

function  TarDocument.GenDocInfoRecord : Tm3DBDocumentInfo;
begin
 Result := inherited GenDocInfoRecord;
 // Еще поля заполнить
 // with Result do
 //begin
 // rRelID := 0; // ID справки
 // rRightsMask := 0; // маска прав
 // rLockedBy := 0; // пользователь, который забрал документ
 // rDocType := Ord(DocClass);
 // rExtDocID := UserDocID;
 //end;
end;

procedure TarDocument.Changed;
begin
 if not f_IsLoading then
  TextSource.Modified := True;
end;

procedure TarDocument.Changing;
begin
  // в текущей реализации пока не нужен
end;

procedure TarDocument.evntChangeDocAttribute(const aSender: IDocAttribute);
var
 lLogAct : TLogActionType;
begin
 if aSender.AttrID in cReadOnlyAttrs then exit;
 if GetAttrLogType(aSender.AttrID, lLogAct) then
  AddLog(lLogAct);

 inherited;
end;

constructor TarDocument.CreateParam(aDocFamily : TdaFamilyID; aDocID : TDocID; aUserDocID : Boolean = false);
begin
 Inherited;
 fMainRecModified := False;
end;

procedure TarDocument.Cleanup;
begin
 l3Free(fCorespondentsList);
 l3Free(fRespondentsList);

 //l3Free(fAttrManager);
 l3Free(fSubAttrManager);

 l3Free(fSpravka);
 //l3Free(fDocData);
 l3Free(f_DocObject);
 inherited;
end;

procedure TarDocument.Close;
// закончить работу с документом
begin
 DeleteLocalCopy;
end;

procedure TarDocument.RefreshCorespondentsList(aSubList: Tl3LongintList = nil);
begin
 if fCorespondentsList = nil then
 begin
  fCorespondentsList := TDocumentSabList.CreateEmpty(DocFamily);
  fCorespondentsList.CheckActiveStatus := True;
 end;
 LinkServer(DocFamily).HLinkTbl.GetParentList(DocId, fCorespondentsList, aSubList);
end;

function TarDocument.GetCorespondentsList: TDocumentSabList;
begin
 if fCorespondentsList = nil then
  RefreshCorespondentsList;
 Result := fCorespondentsList;
end;

function TarDocument.GetRespondentsList: TDocumentSabList;
begin
 if fRespondentsList = nil then
  fRespondentsList := TDocumentSabList.CreateEmpty(DocFamily);
 Result := fRespondentsList;
end;

function  TarDocument.AttrManager(aSubID : TSubID = 0): TDocAttributeManager;
begin
 if aSubID = 0 then
 begin
  Result := inherited AttrManager;
 end
 else
 begin
  if fSubAttrManager = nil then
  begin
   fSubAttrManager := TDocAttributeManager.Create(Self);
   fSubAttrManager.OnChangeDocAttribute := evntChangeDocAttribute;
   fSubAttrManager.OnBeforeSaveAttribute := evntBeforeSaveAttribute;
  end
  {else
   if fSubAttrManager.SubID <> aSubID then
    fSubAttrManager.SaveDocData};

  fSubAttrManager.SubID := aSubID;

  Result := fSubAttrManager;
 end;
end;

procedure TarDocument.LoadText(aDocPart         : Tm3DocPartSelector = m3_dsMain;
                               aGoToType        : Integer = ord(ev_sbtNone);
                               aGoToHandle      : Longint = 0;
                               aFoundSelector   : Tm4Addresses = nil;
                               const aSearcher  : IevSearcher = nil
                               );
begin
 if (fTextSourceArr[aDocPart] <> nil) and (fTextSourceArr[aDocPart].Document.IsValid) then
  Exit; // повторная загрузка не нужна

 try
  f_IsLoading := True;
  try
   inherited LoadText(aDocPart, aGoToType, aGoToHandle, aFoundSelector, aSearcher);

   if aDocPart = m3_dsMain then
   begin
    inherited LoadText(m3_dsAnno);
    if not HasAnno and AnnoTextSource.Document.IsValid and (evGetNettoCharCount(AnnoTextSource) < 0) then
     HasAnno := True;
   end;

   (*if IsObjTopic then
    TextSource.LoadText(aGoToType, aGoToHandle, DocObject)
   else
   begin
    inherited LoadText(aDocPart, aGoToType, aGoToHandle, nil, aFoundSelector, aSearcher);

    //if not AnnoTextSource.Document.IsValid then
    AnnoTextSource.LoadText;


    if not HasAnno and AnnoTextSource.Document.IsValid and (evGetNettoCharCount(AnnoTextSource) < 0) then
     //if AnnoTextSource.Exists then
      HasAnno := True;
   end;
   *)
  finally
   f_IsLoading := False;
  end;
 except
  on Ek2CannotAddChild do
   vtMessageDlg(l3Fmt(sidBadDocStructure, []), mtError);
 end;
end;

procedure TarDocument.SetDocFamily(aValue : TdaFamilyID);
begin
 if DocFamily = aValue then Exit;
 Inherited SetDocFamily(aValue);
 //if (fDocData <> nil) then l3Free(fDocData);
end;

procedure TarDocument.MakeNew(aDocClass : TDocType; aSrcFile: TFileName);
begin
 if aDocClass = dtNone then aDocClass := dtText;
 DocClass := aDocClass;
 inherited SetDocID(DocumentServer(CurrentFamily).FileTbl.GetFreeNum);

  case aDocClass of
   Dt_Types.dtText :
    begin
     if (aSrcFile <> '') then
      TextSource.LoadTextFromFile(aSrcFile, -1);
     if not TextSource.Document.IsValid then
      CreateNewText;
    end;
   Dt_Types.dtObject,
   Dt_Types.dtFlash :
    begin
     CreateNewText;
     if (aSrcFile <> '') then
      ObjAccess.LoadFromFile(aSrcFile);
    end
   else // case aDocClass of
    CreateNewText;
  end;

 if aDocClass in [Dt_Types.dtText, Dt_Types.dtObject, Dt_Types.dtFlash] then
 begin
  with (AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool) do
   if Count = 0 then
    AddDefDiapason;
 {$IfNDef nsTest}
  (AttrManager.GetDocAttribute(atOrdLogRecords) as ILogDocAttributeTool).AddAction(acNew);
 {$EndIf nsTest}
 end;

 //l3Free(f_DocObject);
 fMainRecModified := False;
end;

procedure TarDocument.SetDocID(aValue : TDocId);

 procedure LoadDocInfo(var aDocInfo : Tm3DBDocumentInfo);
 var
  lDB : Im3DB;
  lDocument : Im3DBDocument;
 begin
  lDB := Tm3SimpleDB.Make(GetLocalStoragePath);
  try
   lDocument := lDB.GetDocument(DocID);
   lDB := nil;
   try
    aDocInfo := lDocument.GetVersion.Info;
   finally
    lDocument := nil;
   end;
  finally
   lDB := nil;
  end;//try..finally
 end;

var
 lDocInfo : Tm3DBDocumentInfo;
 lDocRec : TdtRecord;
begin
 if DocID = aValue then Exit;
 Assert(aValue > 0, 'TarDocument.SetDocID aValue <= 0 !!');

 Inherited SetDocID(aValue);
 if TextAttribute[m3_dsMain].ExistInLocal(GetLocalStoragePath) then
 begin
  LoadDocInfo(lDocInfo);
  //Inherited SetDocID(aValue);
  DocClass := TDocType(lDocInfo.rDocType);
 end
 else
 begin
  if DocumentServer(CurrentFamily).FileTbl.GetDocRecord(aValue, lDocRec) then
  begin
   Inherited SetDocID(aValue);  // может поменяться если это была спрвка
   DocClass := TDocType(lDocRec.GetIntField(fType_Fld));
  end
  else
   raise EHtErrors.CreateInt(ecNotFound);
 end;

 l3Free(fSpravka);

 GlobalDataProvider.Journal.LogOpenDoc(DocFamily, DocID);
end;

procedure TarDocument.SetDocClass(aValue : TDocType);
begin
 if DocClass <> aValue then
 begin
  inherited SetDocClass(aValue);
  fMainRecModified := True;
 end;
end;

function  TarDocument.GetShortName : Tl3WString;
begin
 Result := TextSource.Document.PCharLenA[k2_tiShortName];
end;

procedure TarDocument.SetShortName(aValue : Tl3WString);
begin
 with TextSource.Document do
  if not l3Same(PCharLenA[k2_tiShortName], aValue) then
  begin
   PCharLenA[k2_tiShortName] := Tl3PCharLen(aValue);
   fMainRecModified := True;
  end;
end;

function  TarDocument.GetSprShortName : Tl3WString;
begin
 if Spravka = nil then
  l3AssignNil(Result)
 else
  Result := Spravka.TextSource.Document.PCharLenA[k2_tiShortName];
end;

procedure TarDocument.SetSprShortName(aValue : Tl3WString);
begin
 if Spravka = nil then Exit;

 with Spravka.TextSource.Document do
  if not l3Same(PCharLenA[k2_tiShortName], aValue) then
  begin
   PCharLenA[k2_tiShortName] := Tl3PCharLen(aValue);
   AddLog(acTextWork);
   Spravka.TextSource.Modified := True;
  end;
end;

function  TarDocument.GetName : Tl3WString;
begin
 Result := TextSource.Document.PCharLenA[k2_tiName];
end;

procedure TarDocument.SetName(aValue : Tl3WString);
begin
 with TextSource.Document do
  if not l3Same(PCharLenA[k2_tiName], aValue) then
  begin
   PCharLenA[k2_tiName] := Tl3PCharLen(aValue);
   fMainRecModified := True;
  end;
end;

function  TarDocument.GetAnnoName : Tl3WString;
begin
 with GetTextAttribute(m3_dsAnno) do
  if not HasDocument {and not Exists} then
   l3AssignNil(Result)
  else
   Result := Document.PCharLenA[k2_tiName]
end;

procedure TarDocument.SetAnnoName(aValue : Tl3WString);
begin
 AnnoTextSource.Document.PCharLenA[k2_tiName] := Tl3PCharLen(aValue);
 AnnoTextSource.Modified := True;
end;

(*
procedure TarDocument.SetUserDocID(aValue : TDocId);
begin
 with TextSource.Document do
  if IntA[k2_tiExternalHandle] <> aValue then
  begin
   IntA[k2_tiExternalHandle] := aValue;
   //DocInfo.SetUserDocID(aValue);

   TextSource.SetEditablePart(epRenum);
  end;
end;
*)

function  TarDocument.GetHasAnno : Boolean;
begin
 with TextSource.Document do
  Result := BoolA[k2_tiHasAnno];
end;

procedure TarDocument.SetHasAnno(aValue : Boolean);
begin
 with TextSource.Document do
  if BoolA[k2_tiHasAnno] <> aValue then
  begin
   BoolA[k2_tiHasAnno] := aValue;
   //fMainRecModified := True;
   //DocServer.FileTbl.SetHasAnno(DocID, aValue);
  end;
 with AnnoTextSource.Document do
  if BoolA[k2_tiHasAnno] <> aValue then
  begin
   BoolA[k2_tiHasAnno] := aValue;
   //fMainRecModified := True;
   //DocServer.FileTbl.SetHasAnno(DocID, aValue);
  end;
end;

function  TarDocument.GetUrgency : Byte;
begin
 Result := TextSource.Document.IntA[k2_tiUrgency];
end;

procedure TarDocument.SetUrgency(aValue : Byte);
begin
 with TextSource.Document do
  if IntA[k2_tiUrgency] <> aValue then
  begin
   IntA[k2_tiUrgency] := aValue;
   fMainRecModified := True;
  end;
end;

procedure TarDocument.SetUserType(aValue : TUserType);
begin
 with TextSource.Document do
  if IntA[k2_tiUserType] <> Ord(aValue) then
  begin
   IntA[k2_tiUserType] := Ord(aValue);
   fMainRecModified := True;
  end;
end;

function  TarDocument.GetUserType : TUserType;
begin
 Result := TUserType(TextSource.Document.IntA[k2_tiUserType]);
end;

function  TarDocument.GetStatus : Word;
begin
 Result := Tl3MakeLong(TextSource.Document.IntA[k2_tiPriceLevel]).Lo;
end;

procedure TarDocument.SetStatus(aValue :  Word);
var
 lStatus : Longint;
begin
  if Status <> aValue then
  with TextSource.Document do
  begin
   lStatus := IntA[k2_tiPriceLevel];
   Tl3MakeLong(lStatus).Lo := aValue;
   IntA[k2_tiPriceLevel] := lStatus;
   fMainRecModified := True;
  end;
end;

function  TarDocument.GetStatusMask : Word;
begin
 Result := Tl3MakeLong(TextSource.Document.IntA[k2_tiPriceLevel]).Hi;
end;

procedure TarDocument.SetStatusMask(aValue :  Word);
var
 lStatus : Longint;
begin
 if StatusMask <> aValue then
  with TextSource.Document do
  begin
   lStatus := IntA[k2_tiPriceLevel];
   Tl3MakeLong(lStatus).Hi := aValue;
   IntA[k2_tiPriceLevel] := lStatus;
   fMainRecModified := True;
  end;
end;

function  TarDocument.CalcAutoPriority : Word;
begin
 Result := GetProirityTbl(DocFamily).CalcPriorityBy(GetDocAttribute(atSources) as Il3IntegerList, GetDocAttribute(atTypes) as Il3IntegerList);
end;

function  TarDocument.GetPriority : Word;
begin
 Result := Word(Abs(TextSource.Document.IntA[k2_tiPriority]));
 if Result = 0 then
  Result := CalcAutoPriority;
end;

//procedure TarDocument.SetPriority(aValue :  Word);
//begin
// SetPriorityPrim(aValue);
//end;

procedure TarDocument.SetPriority(aValue : Word; aManualSetted : Boolean);
var
 lVal : Integer;
begin
 if aManualSetted then
  lVal := aValue
 else
  lVal := -aValue;

 with TextSource.Document do
  if IntA[k2_tiPriority] <> lVal then
  begin
   IntA[k2_tiPriority] := lVal;
   fMainRecModified := True;
  end;
end;

function  TarDocument.GetPriorFlag : Boolean;
begin
 Result := TextSource.Document.IntA[k2_tiPriority] > 0;
end;

//procedure TarDocument.SetPriorFlag(aValue : Boolean);
//begin
// if aValue then
//  SetPriorityPrim(Priority)
// else
//  SetPriorityPrim(-Priority);
//end;

function  TarDocument.GetDocComment : Tl3WString;
begin
 Result := TextSource.Document.PCharLenA[k2_tiNameComment];
end;

procedure TarDocument.SetDocComment(aValue : Tl3WString);
begin
 with TextSource.Document do
  if not l3Same(PCharLenA[k2_tiNameComment], aValue) then
  begin
   PCharLenA[k2_tiNameComment] := Tl3PCharLen(aValue);
   fMainRecModified := True;
  end;
end;

function  TarDocument.GetRelated : TDocID;
begin
  //k2_tiRelExternalHandle
  //k2_tiRelInternalHandle = Ord(_k2_tiRelInternalHandle);

 Result := TextSource.Document.IntA[k2_tiRelInternalHandle];
end;

procedure TarDocument.SetRelated(aValue : TDocID);
begin
 with TextSource.Document do
  if IntA[k2_tiRelInternalHandle] <> aValue then
  begin
   IntA[k2_tiRelInternalHandle] := aValue;
   fMainRecModified := True;
  end;
end;

procedure TarDocument.AddLog(aLogType : TLogActionType);
begin
 fDocLogRec[aLogType] := True;
end;

function TarDocument.IsNeedAddLog(aDocParts : Tm3DocPartSet) : Boolean;
var
 I : TLogActionType;
begin
 Result := False;
 for I := Low(TLogActionType) to High(TLogActionType) do
  if fDocLogRec[I] and ((I in cDocLogActions) and (m3_dsMain in aDocParts)
                      or (I in cAnnoLogActions) and (m3_dsAnno in aDocParts)) then
  begin
   Result := True;
   exit;
  end;
end;

procedure TarDocument.PasteTextFromFile(aExtFileName      : TFileName;
                                            aFilterIndex  : Integer;
                                            const aCursor : TnevCursor;
                                            aDocPart      : Tm3DocPartSelector);
begin
//save header
 //if fDocData <> nil then SaveAttributes(0);
 inherited;
end;

procedure TarDocument.CheckRequiredFields;
begin
 if (ShortName.SLen = 0) then
  raise ERequiredFieldsEmpty.CreateFmt(sidNonDefProp,[scShortName]);

 if (UserDocID <= 0) then
  raise ERequiredFieldsEmpty.CreateFmt(sidNonDefProp,[scDocID]);

  if (Spravka <> nil) and (Spravka.UserDocID <= 0) then
   raise ERequiredFieldsEmpty.CreateFmt(sidNonDefProp,[scSprID]);
end;

function TarDocument.AttrWasModified(aDocParts : Tm3DocPartSet): boolean;
begin
 Result := ((fMainRecModified or IsNeedAddLog([m3_dsMain])) and (m3_dsMain in aDocParts)) or
           ((fAttrManager <> nil) and (fAttrManager.DataWasModified(aDocParts) or ((m3_dsAnno in aDocParts) and fIsAnnoWasDeleted))) or
           ((fSubAttrManager <> nil) and fSubAttrManager.DataWasModified(aDocParts));
end;

function  TarDocument.IsModified(aDocParts : Tm3DocPartSet = m3_AllDocParts) : Boolean;
begin
 Result := Inherited IsModified(aDocParts) or AttrWasModified(aDocParts);
end;

procedure TarDocument.PrepareEditablePartsInfo;
var
 lLogEdited : boolean;
begin
 if fAttrManager = nil then Exit;
 fAttrManager.PrepareEditablePartsInfo;

 if (fTextSourceArr[m3_dsMain] <> nil) and (fTextSourceArr[m3_dsMain].IsTextModified) then
  TextSource.SetEditablePart(epText);

 if fMainRecModified then
  TextSource.SetEditablePart(epMainRecAttr);
end;

(*procedure TarDocument.CreateNewText(aDocPart : Tm3DocPartSelector = m3_dsMain);
begin
 Inherited;

 //AddLog(acNew);

{$IfNDef nsTest}
 if aDocPart = m3_dsMain then
  (AttrManager.GetDocAttribute(atOrdLogRecords) as ILogDocAttributeTool).AddAction(acNew);
{$EndIf nsTest}
end;
*)

procedure TarDocument.Save(aFullSave : Boolean = True);
var
 I : TLogActionType;
 lNeedSetTextChanged : boolean;
begin
 PrepareEditablePartsInfo;

 if HasSpravka and Spravka.IsModified then
 begin
  Spravka.Save(aFullSave);
  AddLog(acTextWork);
 end;

 if not aFullSave then
 begin
  inherited;
  Exit;
 end;

 if (fTextSourceArr[m3_dsMain] <> nil) then
  with fTextSourceArr[m3_dsMain] do
  begin
   if IsPartWasModified(epText) then
    AddLog(acTextWork);
   if IsPartWasModified(epMainRecAttr) then
    AddLog(acAttrWork);
  end;

 if {(inherited IsModified([m3_dsMain])) or} ((Spravka <> nil) and Spravka.IsModified) then
  AddLog(acTextWork);

 lNeedSetTextChanged := fDocLogRec[acTextWork];

 with (AttrManager.GetDocAttribute(atOrdLogRecords) as ILogDocAttributeTool) do
  for I := Low(TLogActionType) to High(TLogActionType) do
   if fDocLogRec[I] then
   begin
   {$IfNDef nsTest}
    AddAction(I);
   {$EndIf nsTest}
    fDocLogRec[I] := false;
   end;

 if (fTextSourceArr[m3_dsAnno] <> nil) and fTextSourceArr[m3_dsAnno].Modified or
    ((fAttrManager <> nil) and fAttrManager.DataWasModified([m3_dsAnno])) then
 begin
  HasAnno := True;
  (AttrManager.GetDocAttribute(atOrdLogRecords) as ILogDocAttributeTool).AddAction(acAnnoWork);
 end;

 if fIsAnnoWasDeleted then
 begin
  fIsAnnoWasDeleted := false;
  (AttrManager.GetDocAttribute(atOrdLogRecords) as ILogDocAttributeTool).AddAction(acAnnoWasDeleted);
 end;

 inherited; //!!там Modified сбрасывается

 if lNeedSetTextChanged then // put log to BB
  GlobalDataProvider.Journal.LogEditDoc(DocFamily, DocID, da_detText);

 fMainRecModified := False;
 if fAttrManager <> nil then
  fAttrManager.DropDataModified;
 if fSubAttrManager <> nil then
  fSubAttrManager.DropDataModified;
end;

procedure TarDocument.MakeDocCopy(aCopyDocUserID : TDocID; aAttrSetKind : TddAttrSetKind; aCopyType : TUserType = utEdition);
var
 lIntCopyDocID : TDocID;
begin
 Save;
 with TddDocumentCopier.Create do
  try
   Family := DocFamily;
   { TODO -oВованыч -cРазвитие : Тут нужно присвоить функцию прогресса }
   //ProgressFunc :=
   lIntCopyDocID := aCopyDocUserID;
   LinkServer(DocFamily).Renum.GetRNumber(lIntCopyDocID);
   MakeCopy(DocID, lIntCopyDocID, aAttrSetKind, False, aCopyType);
  finally
   Free;
  end;
end;

function TarDocument.IsLock : Boolean;
begin
 Result := fLockHandle <> 0;
end;

procedure TarDocument.Lock;
var
 lAccGr : TDictID;
 lIsIncl : Boolean;
begin
 if IsLock then Exit;

 //if fAttrManager <> nil then
 // fAttrManager.SaveDocData([atAccGroups]);

 if DataWasLoaded then
 begin // достаем из атрибутов
  with (AttrManager.GetDocAttribute(atAccGroups) as IListDocAttribute) do
   if Count > 0 then
    lAccGr := Handle[0]
   else
    lAccGr := 0;

  lIsIncl := (AttrManager.GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool).HasDocThisLogRec(acIncluded);

  fMaxMask := AccessServer.GetRightMask(DocFamily, lAccGr, lIsIncl);
 end
 else
  fMaxMask := AccessServer.GetRightMask(DocFamily, DocID);

 //fMaxMask    := fMaxMask and not acgNonDocEditMask;

 fLockHandle := LockServer.LockDocByMask(DocFamily, DocID, fMaxMask, fLockMask);
end;

procedure TarDocument.Unlock;
begin
 if not IsLock then Exit;
 LockServer.UnLockDoc(DocFamily, fLockHandle);
 fLockHandle := 0;
 fMaxMask  := 0;
 fLockMask := 0;
end;

procedure TarDocument.Relock;
begin
 UnLock;
 Lock;
end;

procedure TarDocument.WhoLockDoc(var aStation : TStationNameArray; var aUserID : TdaUserIDArray);
begin
 LockServer.WhoLockDoc(DocFamily, DocID, aStation, aUserID, fLockHandle);
end;

function TarDocument.GetSprDocID : TDocID;
begin
 if Spravka <> nil then
  Result := Spravka.DocID
 else
  Result := 0;
end;

function TarDocument.GetPrevVerDocID : TDocID;
begin
 Result := DocServer.FileTbl.CheckVerLink(DocID);
 // если загружен список редакций то можно из него получить
end;

function TarDocument.IsActive : Boolean;
begin
 Result := (AttrManager.GetDocAttribute(atActiveIntervals) as IActiveIntervalsAttributeTool).IsActive;
end;

function TarDocument.HasSpravka : Boolean;
begin
 Result := fSpravka <> nil;
end;

function TarDocument.GetSpr : TSprDocument;
var
 lSprID : TDocID;
begin
 if fSpravka = nil then
 begin
  lSprID := Related;
  if lSprID > 0 then
  begin
   fSpravka := TsprDocument.CreateParam(Self, lSprID);
   fSpravka.DocClass := dtRelText;
  end;
 end;
 Result := fSpravka;
end;

function TarDocument.MakeSpravka(aDocID : TDocID = 0): TSprDocument;
var
 lSprID : TDocID;
begin
 if fSpravka = nil then
 begin
  fSpravka := TSprDocument.CreateParam(Self, 0);
  fSpravka.DocClass := dtRelText;
  fSpravka.TextSource.MakeNewDoc;
 end;

 if fSpravka.DocID = 0 then
 begin
  lSprID := Related;

  if lSprID = 0 then
  begin
   if aDocID > 0 then
    lSprID := aDocID
   else
    lSprID := GetFreeDocID(DocFamily);

   Related := lSprID;
   fSpravka.SetDocID(lSprID);
  end;
 end;

 AddLog(acAttrWork);
 Result := fSpravka;
end;

procedure TarDocument.DeleteSpr;
begin
 if (Spravka <> nil) and (Spravka.DocId > 0) then
 begin
  Related := 0;
  l3Free(fSpravka);
 end;
end;

procedure TarDocument.DeleteAnno;
var
 I : TLogActionType;
begin
 AttrManager.DeleteAllforPart(m3_dsAnno);

 // почистим журнал новых лог-записей
 for I := Low(TLogActionType) to High(TLogActionType) do
  if fDocLogRec[I] and (I in cAnnoLogActions) then
   fDocLogRec[I] := false;

 fIsAnnoWasDeleted := True;

 GetTextAttribute(m3_dsAnno).MakeNewDoc;

 //сбрасываем HasAnno
 HasAnno := False;
end;

function TarDocument.GetAnnoTextSource: TarTextOfDocument;
begin
 Result := GetTextAttribute(m3_dsAnno);
end;

procedure TarDocument.SetAlienSpr(aSprUserDocID : Longint);
var
 lSprRealDocID : Longint;
begin
 // убить свою справку
 //if (Spravka <> nil) and (Spravka.DocId > 0) then
 // DocServer.DelRel(Spravka.DocId);

 lSprRealDocID := LinkServer(DocFamily).Renum.ConvertToRealNumber(aSprUserDocID);

 Related := lSprRealDocID;
 ///DocData.SetRelatedDoc(lSprRealDocID);

 Spravka.SetDocID(lSprRealDocID);
 Spravka.ReLoad;
end;

procedure TarDocument.SetSpr(Value : TSprDocument);
begin
 l3Set(fSpravka, Value);
 If fSpravka <> nil then
  fSpravka.DocClass := dtRelText;
end;

(*function  TarDocument.GetDocData : TDocumentAttrData;
begin
 if fDocData = nil then
 begin
  if (DocFamily > 0) {and (fDocID  <> 0)} then
  begin
   fDocData := TDocumentAttrData.Create(DocFamily, DocID, Byte(DocClass));
   //fDocData.OnChangeDocAttribute := evntChangeDocAttribute;
  end;
 end;
 Result := fDocData;
end;
*)

function TarDocument.IsPossibleText : Boolean;
begin
 Result := True; //UserType in utDocTypesHasText;
end;

function TarDocument.IsPossibleSpr: Boolean;
begin
 Result := (DocClass = Dt_Types.dtText) and (UserType in utDocTypesHasSpr);
end;

function TarDocument.pm_GetDocObject: TarDocObject;
begin
 if f_DocObject = nil then
 begin
  f_DocObject := TarDocObject.Create(TextSource.DocumentContainer);
  if DocClass = dtFlash then
   f_DocObject.ObjType := dotFlash;
  //else
  // f_DocObject.ObjType := dotOther;
  Il3ChangeNotifier(f_DocObject).Subscribe(Il3ChangeRecipient(Self));
 end;
 Result := f_DocObject;
end;
(*
procedure TarDocument.SaveDocPart(aPart: Tm3DocPartSelector; aFullSave: Boolean);
begin
 if (aPart = m3_dsMain) and (DocClass in [dtObject, dtFlash]) then
  inherited SaveDocPart(aPart, aFullSave)
 else
  inherited;
end;
*)
(*procedure TarDocument.SetDocData(Value : TDocumentAttrData);
begin
 l3Set(fDocData, Value);
end;
*)

function TarDocument.IsFutureVersion : Boolean;
var
 I : Integer;
 lDocRec : TDocReadRec;
begin
 Result := False;
 with (AttrManager.GetDocAttribute(atVersions) as IVersionListAttributeTool) do
  for I := 0 to Pred(Count) do
 begin
  if IsActive(I) then Exit;
  if Handle[I] = DocID then
  begin
   Result := True;
   Exit;
  end;
 end;
end;

{TarSpravkaTextOfDocument}

function TarSpravkaTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
begin
 Result := TarSpravkaDocumentContainer.Make;
end;

procedure TarSpravkaTextOfDocument.Commit_SetAddFilter(var aGenerator: Tk2TagGenerator);
begin
end;

function  TarSpravkaTextOfDocument.Commit_IsNeedSaveText : boolean;
begin
 Result := True;
end;

{TSprDocument}
constructor TSprDocument.CreateParam(aMasterDoc : TarDocument; aDocID : TDocID; aUserDocID : Boolean = false);
begin
 inherited CreateParam(aMasterDoc.DocFamily, aDocID, aUserDocID);
 fMasterDoc := aMasterDoc;
end;

//procedure TSprDocument.Cleanup;
//begin
// l3Free(fMasterDoc);
// Inherited;
//end;

function TSprDocument.GetTextOfDocumentClass: RarTextOfDocument;
begin
 Result := TarSpravkaTextOfDocument;
end;

function TSprDocument.GetLocalStoragePath : TPathStr;
begin
 Result := fMasterDoc.GetLocalStoragePath;
end;

//function  TSprDocument.GenDocInfoRecord : Tm3DBDocumentInfo;
//begin
// Result := fMasterDoc.GenDocInfoRecord;
//end;

{TDocsList}
procedure TDocsList.Cleanup;
begin
 l3Free(fDocList);
 Inherited;
end;

function TDocsList.GetDocList : Tl3DataList;
begin
 if fDocList = nil then
  fDocList := Tl3DataList.CreateSize(SizeOf(TDocAddr));
 Result := fDocList;
end;

procedure TDocsList.SetDocAddr(I : Longint; Value : TDocAddr);
begin
 Abort;
end;

function TDocsList.GetDocAddr(I : Longint) : TDocAddr;
begin
 if fDocList <> nil then
  Result := PDocAddr(fDocList.Data[I])^;
end;

procedure TDocsList.AddAddrToList(aDocAddr : TDocAddr);
begin
 DocList.Add(@aDocAddr);
end;

procedure TDocsList.ClearIDList;
begin
 if fDocList <> nil then fDocList.Clear;
end;

function TDocsList.GetCount : Longint;
begin
 if fDocList <> nil then
  Result := fDocList.Count
 else
  Result := 0;
end;

{TarTextOfDocument}
constructor TarTextOfDocument.Make(aDocInfo : TarDocInfo; aDocPart : Tm3DocPartSelector);
begin
 Create;
 fDocInfo := aDocInfo.Use;
 fDocPart := aDocPart;

 OnGetReader := evntGetReader;
 OnGetWriter := evntGetWriter;

end;

procedure TarTextOfDocument.SetEditablePart(aAttr : Cardinal);
begin
 Document.CAtomEx([k2_tiEditableParts, k2_tiChildren, k2_tiHandle, aAttr], nil).BoolA[k2_tiModified] := true;
end;

function TarTextOfDocument.IsPartWasModified(aAttr : Cardinal) : boolean;
begin
 with Document.rAtomEx([k2_tiEditableParts, k2_tiChildren, k2_tiHandle, aAttr]) do
  Result := IsValid AND BoolA[k2_tiModified];
end;

procedure TarTextOfDocument.evntGetWriter(Sender: TObject; Format: Cardinal; var Writer: Tk2TagGenerator);
 {- make filter for put text from clipboard}
//var
// Filter : TAddDocAttributeFilter;
begin
 //DocTextEditor.TextSource.Document.wAtom(k2_tiInternalHandle).sLong(DocID);

 if (Format = cf_OEMText) then
 begin
  if (Writer Is TevCustomTextFormatter) then
   TevCustomTextFormatter(Writer).CodePage := CP_OEMLite;
 end
 (*else
  if (Format <> cf_Text) and (not fGetOnlyText) then
  begin
   if (Writer <> nil) then
   begin
    Filter := TAddDocAttributeFilter.Create(nil,DocFamily);
    try
     Filter.Generator := Writer;
     Filter.SourceDocID := DocID;
     Filter.RecalcHyperLinks := False;
     l3Set(Writer, Filter);
    finally
     l3Free(Filter);
    end;{try..finally}
   end;{Writer <> nil}
  end*);//Format <> cf_Text  *)
end;


procedure TarTextOfDocument.evntGetReader(Sender: TObject; Format: TevFormat; var Reader: TevFileReader);
 {- make filter for insert text from clipboard}
var
 l_Gen: Tk2TagGenerator;

 procedure lp_InitCommonFilters;
 var
  l_Filter: TGetClipboardLightFilter;
 begin
  TGetClipboardLightFilter.SetTo(l_Gen);
  l_Filter := TGetClipboardLightFilter(l_Gen);

  if Document <> nil then
   l_Filter.OnGetNewHandleID := evntGetNewHandleID;
  l_Filter.Family := Docinfo.DocFamily;

  l_Filter.ExpandedFormat := not IsSpravka and not IsAnno and
                             // (Docinfo.DocClass in [dtNone, dtText]) and
                             ((DocUserType in utFullFeatureDocTypes) or
                              ((DocUserType = utEdition){ and Document.IsFutureVersion})); //вставлять субатрибуты

  l_Filter.OnInsertDocAttribute := evntInsertDocAttribute;

  evLinkTableFilters(l_Gen, False);
 end;

begin
 l_Gen := nil;
 if (Reader <> nil) then
 begin
  lp_InitCommonFilters;

  if (Format = cf_EverestBin) or (Format = cf_EverestTxt) then
  begin
   TevStrictContentsElementEliminator.SetTo(l_Gen);
   TevdF1HyperlinkCorrector.SetTo(l_Gen, LinkServer(Docinfo.DocFamily).Renum); // Этот фильтр должен быть перед TGetClipboardFilter, т.е. добавляться позже (!). См. http://mdp.garant.ru/pages/viewpage.action?pageId=512986739
  end; // if (Format <> cf_EverestBin) and (Format <> cf_EverestTxt) then


  if IsAnno {(Docinfo.DocClass = dtAnnotation)} then
  begin
   TevTagsListFilter.SetTo(l_Gen, TevTagsListFilter.MakeAttrList(k2_typLeafPara, [k2_tiSubs]));
   TevBlocksEliminator.SetTo(l_Gen);
  end;

  try
   (Reader As Ik2TagGeneratorChainEnd).Link(l_Gen);
  finally
   l3Free(l_Gen);
  end;
 end;{Reader <> nil}
end;

procedure TarTextOfDocument.Cleanup;
begin
 l3Free(fDocInfo);
 inherited;
end;

function  TarTextOfDocument.pm_GetDocument: Tl3Variant;
begin
 result := inherited pm_GetDocument;
end;

function  TarTextOfDocument.GetDocUserType : TUserType;
begin
 Result := TUserType(Document.IntA[k2_tiUserType]);
end;

procedure TarTextOfDocument.pm_SetModified(aValue: Boolean);
begin
 inherited Modified := aValue;
end;

function TarTextOfDocument.pm_GetModified : Boolean;
begin
 Result := fNeedFullSave or Inherited Modified
           or ((fDocPart = m3_dsMain) and AttrWasModified); 
end;

function TarTextOfDocument.IsTextModified : Boolean;
begin
 Result := Inherited Modified;
end;

function  TarTextOfDocument.AttrWasModified : Boolean;
var
 I : Integer;
begin
 Result := False;
 with Document.Attr[k2_tiEditableParts] do
 for I := 0 to Pred(ChildrenCount) do
 begin
  with Child[I] do
   if (BoolA[k2_tiModified]) then
   begin
    Result := True;
    Exit;
   end;
 end;
end;

procedure TarTextOfDocument.SetNeedFullSave(aValue: Boolean);
begin
 fNeedFullSave := aValue;

 //                 and (fDocPart = m3_dsMain) //нужна синхронизация с БД
 //                 and (DocInfo.fDocClass <> dtRelText);
end;

procedure TarTextOfDocument.DoAfterDataInsert(aInsertInEmptyDoc : Boolean);
begin
 if Assigned(fOnAfterDataInsert) then OnAfterDataInsert(Self, aInsertInEmptyDoc);
end;

function  TarTextOfDocument.DoGetHFPainter(aPrintBlock : Boolean) : Il3HAFPainter;
begin
 if Assigned(fOnGetHFPainter) then
  Result := fOnGetHFPainter(Self, aPrintBlock)
 else
  Result := nil;
end;

procedure TarTextOfDocument.evntGetNewHandleID(aType : TdtHandleIDType; var aHandleID : Integer);
begin
 case aType of
  dt_hidSub:
   if evGetSubList(Self).Sub[aHandleID].Exists then
    aHandleID := evGetSubList(Self).NewSub.ID;
  dt_hidHyperlink:
   aHandleID := {TextSource.}GetNewHyperlinkID;
 end; // case
end;

procedure TarTextOfDocument.evntInsertDocAttribute(aAttr : TCacheType); // for insert from clipboard
begin
 SetEditablePart(Ord(aAttr));
end;

function TarTextOfDocument.IsSpravka : boolean;
begin
 Result := DocInfo.DocClass = dtRelText;
end;

function TarTextOfDocument.IsAnno : boolean;
begin
 Result := DocPart = m3_dsAnno;

 //DocInfo.DocClass = dtAnnotation;
end;

procedure TarTextOfDocument.LoadText(aGoToType      : Integer = ord(ev_sbtNone);
                                     aGoToHandle    : Longint = 0;
                                     aFoundSelector : Tm4Addresses = nil;
                                     const aSearcher  : IevSearcher = nil;
                                     aLevel : Integer = Cm3LastVersion {откат к предыдущей версии});
var
 l_Filer : Tl3CustomFiler;
 G           : Tk2TagGenerator;
 l_Control  : InevControl;
 {*}lTimer : Cardinal;
 lWithAttr  : boolean;
 lDocPartSel : TDocPartSelector;
begin
 if not (DocInfo.IsSetted) then Exit;

 if Document.IsValid then Exit;

 {*}lTimer := dbgStartTimeCounter;

 G := nil;
 try
  BuildLoadPipeParams(lWithAttr, lDocPartSel);

  l_Filer := nil;

  if IniRec.DirectDocStorageAccess then
    BuildRemoteLoadPipe(G, lWithAttr, lDocPartSel, aFoundSelector, aLevel, l_Filer)
  else
   if not BuildClientServerLoadPipe(G, lWithAttr, lDocPartSel, aFoundSelector, aLevel, l_Filer) then
    raise Exception.Create(sidRemoteStorageDisabled);
  try
   TevEVDReader.SetTo(G);
   (G as TevEVDReader).Filer := l_Filer;
  finally
   l3Free(l_Filer);
  end;

  if Editors.Count > 0 then
   Supports(Tl3Base(Editors.Items[0]), InevControl, l_Control);
  if (l_Control <> nil) and (aGoToType <> Ord(ev_sbtNone)) then
   if (aGoToType = ev_sbtBySearcher) then
   begin
    Assert(aSearcher <> nil);
    DocumentContainer.LinkWaiter(TevSearchWaiter.Make(l_Control, aSearcher))
   end // if (aGoToType = ev_sbtBySearcher) then
   else
    DocumentContainer.LinkWaiter(TevSubWaiter.Make(l_Control, aGoToHandle, aGoToType));

   Load((G as TevEVDReader));
 finally
  l3Free(G);
 end;

 //l3System.Msg2Log
 {*} dbgAppendToLogLN(format('DocLoad %s',[dbgFinishTimeCounter(lTimer)]));
// ClearTextIndent;
end;


procedure TarTextOfDocument.LoadLocalText(const aLocalDBName : TPathStr;
                                          aLevel : Integer = Cm3LastVersion {откат к предыдущей версии});
var
 l_DB       : Im3DB;
 lBaseFiler : Tl3CustomFiler;
 G           : Tk2TagGenerator;
begin
 if not (DocInfo.IsSetted) then Exit;

 if Document.IsValid then Exit;

 G := nil;
 try
  //TddExtObjInserter.SetTo(G{, DocInfo.DocID});

  //if aDocObject <> nil then
  // TarDocObjectExtractor.SetTo(G, aDocObject);


  TevEVDReader.SetTo(G);
  l_DB := Tm3SimpleDB.Make(aLocalDBName);
  try
    lBaseFiler := Tm3DBFiler.Create(l_DB, DocInfo.DocID, DocPart, aLevel);
    l_DB := nil;
    try
     (G as TevEVDReader).Filer := lBaseFiler;
    finally
     l3Free(lBaseFiler);
    end;
   finally
    l_DB := nil;
   end;//try..finally

   Load(G as TevEVDReader);

   SetNeedFullSave(True); //нужно записывать в базу
 finally
  l3Free(G);
 end;
end;

function TarTextOfDocument.DoMakeDocumentContainer: InevDocumentContainer;
begin
 Result := TarDocumentContainer.Make;
end;

procedure TarTextOfDocument.ClearTextIndent;
//Зачистка "нестандартных" полей бумаги
var
 l_FormatNeed : Boolean;
begin
 l_FormatNeed := False;
 with Document do
 begin
  if Attr[k2_tiWidth].IsValid then
  begin
   l_FormatNeed := True;
   AttrW[k2_tiWidth, nil] := nil;
  end;
  if Attr[k2_tiLeftIndent].IsValid then
  begin
   l_FormatNeed := True;
   AttrW[k2_tiLeftIndent, nil] := nil;
  end;
  if Attr[k2_tiRightIndent].IsValid then
  begin
   l_FormatNeed := True;
   AttrW[k2_tiRightIndent, nil] := nil;
  end;
  if l_FormatNeed then
   evUnformatAll(Self);
 end;
end;

procedure TarTextOfDocument.LoadTextFromFile(ExtFileName   : TFileName;
                                             FilterIndex   : Integer;
                                             const aCursor : TnevCursor = nil);
var
 l_Reader            : Tk2CustomFileReader;
 l_Reader2           : Tk2CustomFileReader;
 l_Generator         : Tk2TagGenerator;
 l_DosFiler          : TevDOSFiler;
 l_Format            : Boolean;
 lFileExt            : ShortString;
 lClipbordFilter     : TGetClipboardLightFilter;
 lCnv2InternalFilter : THLinkAddrToInternal;
begin
 ExtFileName := l3StripDoubleQuotes(ExtFileName);

 if ExtFileName = '' then
  MakeNewDoc
 else
 begin
  if evIsGraphicFile(ExtFileName) then
  begin
   if Assigned(evGetReaderProc) then
   begin
    l_Reader := nil;
    try
     evGetReaderProc(Self, CF_HDROP, Tk2CustomReader(l_Reader), ExtFileName);
     if l_Reader <> nil then
      evInsertFile(Self, l_Reader, aCursor);
    finally
     l3Free(l_Reader);
    end;
   end; // if Assigned(evGetReaderProc) then
  end // if evIsGraphicFile() then
  else
  begin
   l_DosFiler := TevDosFiler.Create;
   try
    try
     l_DosFiler.FileName := ExtFileName;
     l_Reader2 := nil;
     try
      lFileExt := ExtractFileExt(Trim(ExtFileName));
      { 0 - docx, doc, rtf
        1 - evd
        2 - nsr
        3 - html
        4 - txt
        5 - картинки
        6 - неизвестно }
      If (FilterIndex = -1) or (FilterIndex = 6) then
       if (lFileExt = '') or (lFileExt = '.') or
          // раньше непонятные файлы (без раcширения) обрабатывал EVDReader,
          //но он слишком много мусору в лог выплевывает
          AnsiSameText(lFileExt, '.txt') then
        FilterIndex := 4 {TextParser}
       else
        if AnsiSameText(lFileExt, '.rtf') or
           AnsiSameText(lFileExt, '.doc') or
           AnsiSameText(lFileExt, '.docx')  then
         FilterIndex := 0  {TRTFReader}
        else
         if AnsiSameText(lFileExt, '.nsr') then
          FilterIndex := 2  {TNSRCReader}
         else
          if AnsiSameText(lFileExt, '.htm') or AnsiSameText(lFileExt, '.html') then
           FilterIndex := 3  {TddHTMLReader}
          else
           if AnsiSameText(lFileExt, '.evd') then
            FilterIndex := 1; {TevEVDReader}

       case FilterIndex of
        1 :
         begin
          l_Reader := TevEVDReader.Create(nil);
          l_Reader2     := TevTxtReader.Create(nil);
          TevTextParser(l_Reader2).Criteria.AddSBS := False;
          TevEVDReader(l_Reader).TextParser := TevTextParser(l_Reader2);
         end;
        4 :
         begin
          l_Reader := TevTextParser.Create(nil);
          TevTextParser(l_Reader).Criteria.AddSBS := False;
         end;
        0 :
         begin           
          l_Reader := TddDocReader.Create(nil);
          TddDocReader(l_Reader).LiteVersion := True;
          TddDocReader(l_Reader).EnablePictures := True;
          //TddDocReader(l_Reader).EnablePictures := False;
         end;
        2 :
         begin
          l_Reader := TCustomNSRCReader.Create(nil);
          TCustomNSRCReader(l_Reader).StrictFormat := False;
          TCustomNSRCReader(l_Reader).CodePage := GlobalDataProvider.BaseLanguage[DocInfo.DocFamily].OEMCodePage;
         end;
        3 :
         begin
          {$IFNDEF nsTest}
          Exit;
          {$ENDIF nsTest}
          l_Reader := TddHTMLReader.Create(nil);
         end;
        else
         Exit; {l_Reader := nil;}
       end;

     if FilterIndex in [0..2] then // вставляем фильтры для гиперссылок
     begin
      lClipbordFilter := TGetClipboardLightFilter.Create(nil);
      try
       //lClipbordFilter.OnHyperItemInsert := evntHyperItemInsert;
       lClipbordFilter.OnGetNewHandleID := evntGetNewHandleID;
       lClipbordFilter.ExpandedFormat := (DocInfo.DocClass <> dtRelText);
       lClipbordFilter.Family := DocInfo.DocFamily;
       //lClipbordFilter.TargetDocID := DocInfo.DocID;

       lCnv2InternalFilter  := THLinkAddrToInternal.Create(nil);
        try
         lCnv2InternalFilter.Family := DocInfo.DocFamily;
         lCnv2InternalFilter.Generator := lClipbordFilter;
         l_Reader.Generator := lCnv2InternalFilter;
        finally
         l3Free(lCnv2InternalFilter);
       end;

       //l_Reader.Generator := lClipbordFilter;

       
      finally
       l3Free(lClipbordFilter);
      end;{try..finally}
     end;

     l_Reader.Filer := l_DosFiler;
     evLinkTableFilters(l_Generator, True);
     TevOutTextParaEliminator.SetTo(l_Generator);
     try
      l_Reader.Link(l_Generator);
      if (aCursor = nil) then
      begin
       Load(l_Reader);
       ClearTextIndent;
      end
      else
      begin
       evInsertFile(Self, l_Reader, aCursor);
       if (FilterIndex = 2 {NSRC}) then
        DoAfterDataInsert(aCursor = nil);
       end;
      finally
       l3Free(l_Generator);
      end;
     finally
      l3Free(l_Reader2);
      l3Free(l_Reader);
     end;
    finally
     l3Free(l_DosFiler);
    end;
   except
    on Ek2CannotAddChild do
     vtMessageDlg(l3Fmt(sidBadDocStructure, []), mtError);
   end;
   if Document.IsValid then
   begin
    Document.IntA[k2_tiInternalHandle] := DocInfo.DocID;
    Document.IntA[k2_tiLanguage] := GlobalDataProvider.BaseLanguage[DocInfo.DocFamily].LanguageID;
   end;
  end;
 end;
end;

procedure TarTextOfDocument.PrintText(const aBlock : InevStorable = nil);
var
 HFPainter : Il3HAFPainter;
 lStr      : string;
 l_Preview : IafwDocumentPreview;
begin

 LoadText;
 HFPainter := DoGetHFPainter(aBlock <> nil);
 Try
  if (aBlock = nil) then
   l_Preview := TevDocumentPreview.Make(Document.AsObject, evDefaultPreviewCacheKey, HFPainter)
  else
   l_Preview := TevDocumentPreview.Make(aBlock, evDefaultPreviewCacheKey, HFPainter);
  try
   l_Preview.Print;
  finally
   l_Preview := nil;
  end;//try..finally
 finally
  HFPainter := nil;
 end;
end;

{procedure TarTextOfDocument.SaveText(aFullSave : Boolean = True; anAdditionalData: TObject = nil);
begin
 SaveTextPrim(aFullSave, anAdditionalData);
 //fNewDoc := false;
 fExistsInStgWasChecked := true;
 fExistsInStg := True;
end;
}

procedure TarTextOfDocument.evntOnEraseAttrRecords(aAttrType : TCacheType; aDictID : TDictID; aDocID : TDocID; aSubID : TSubID);
begin
 dictChangeToLogFile(aAttrType, aDictID, aDocID, aSubID);
end;

(*
procedure TarTextOfDocument.SaveTextPrim(aNeedDBSyncro : Boolean; anAdditionalData: TObject);
begin
 if aNeedDBSyncro then
  Commit(anAdditionalData)
 else
  SaveLocal(anAdditionalData);
end;
*)

procedure TarTextOfDocument.Commit_SetAddFilter(var aGenerator: Tk2TagGenerator);
// фильтры для основного потока с атрибутами
begin
 BuildDocSavePipe(DocInfo.DocFamily, DocInfo.DocID, IsObjTopic, evntOnEraseAttrRecords, aGenerator);

(*
 if not (IsObjTopic) then
 begin
  //TddImageHandleInsertFilter.SetTo(aGenerator);
  // - этот функционал переехал в TddSavedObjectsList и TddExtObjExtractor
  TddExtObjExtractor.SetTo(aGenerator);
 end;
 //else
 // TarDocObjectAdder.SetTo(G, TarDocObject(anAdditionalData));

  // устанавливает фильтр, который укладывает данные в СУБД
  with TDBFilter(TDocSaveDBFilter.SetTo(aGenerator)) do
  begin
   Family := DocInfo.DocFamily;
   CurDocID := DocInfo.DocID;
   InternalFormat := True;
   SaveMode := smSave;
   ExcludeAttr := CctAllAttributes; // рассчитывается через k2_tiEditablePartsв TDocSaveDBFilter,
                                    // если k2_tiEditableParts не придет атрибуты записываться не будут
   ExcludeMainRec := True;          // см. выше

   NeedEventforEraseAttrRec := [ctKW];
   OnEraseAttrRecords := evntOnEraseAttrRecords;
  end;

  // правильнее было бы проверить DocInfo.DocClass, но он всегда dtText
  //if Assigned(anAdditionalData) and (TarDocObject(anAdditionalData).ObjType <> dotFlash) then
  // TddChildBiteOffFilter.SetTo(G, k2_idTextPara); // текстовые параграфы объектам не полагаются
*)  
end;

function TarTextOfDocument.Commit_IsNeedSaveText : Boolean;
begin
 Result := (DocPart <> m3_dsMain) or IsPartWasModified(epText);
end;

procedure TarTextOfDocument.Commit; // save to DB
var
 l_NeedSaveText : Boolean;

 l_NeedOpen : Boolean;
 l_DB       : Im3DB;
 l_Filer    : Tm3DBFiler;
 G          : Tk2TagGenerator;

 l_UploadDocHelper: TarUploadDocumentHelper;

var
 lDocClassWasChanged : Boolean;
begin
 if not HasDocument or InIO then Exit;

 l3System.Msg2Log('CommitText Start, DocID = %d, part=%s', [DocInfo.DocID, GetEnumName(TypeInfo(Tm3DocPartSelector), Ord(DocPart))]);

 lDocClassWasChanged := Document.IntA[k2_tiType] <> ord(DocInfo.DocClass);
 if lDocClassWasChanged then
  Document.IntA[k2_tiType] := ord(DocInfo.DocClass);

 //SaveTextToFile(format('d:\out\%d.evd',[DocInfo.DocID]),FTDefault);
 //Exit;

 SetNeedFullSave(False);

 l_NeedSaveText := Commit_IsNeedSaveText;
 //DocPart = m3_dsAnno


 l_UploadDocHelper := TarUploadDocumentHelper.Create(IniRec.DirectDocStorageAccess,
  DocInfo.DocFamily, DocInfo.DocID, DocInfo.DocClass, DocPart, not IsSpravka, l_NeedSaveText,
  lDocClassWasChanged, evntOnEraseAttrRecords, IsObjTopic);


// G := nil;
 try
(*  l_DB := dtGetDB(DocInfo.DocFamily);
  try
   l_Filer := Tm3DBFiler.Create(l_DB, DocInfo.DocID, DocPart);
  finally
   l_DB := nil;
  end;//try..finally
  try
   l_Filer.Mode := l3_fmReadWrite;
   l_NeedOpen := (DocInfo.DocClass <> dtNone) and l_NeedSaveText;
   if l_NeedOpen then
    l_Filer.Open;
   try
    try
     if lDocClassWasChanged and (l_Filer.Part <> nil) then
      l_Filer.Part.Info := Tm3DBDocumentInfo_C(ord(DocInfo.DocClass));
     if l_NeedSaveText then
     begin
      TevdNativeWriter.SetTo(G);
      with TevdNativeWriter(G) do
      begin
       Filer := l_Filer;
       Binary := true;
      end;
     end;
     Commit_SetAddFilter(G);
*)

     try
      Save(l_UploadDocHelper.Generator);

//     Save(G);

      if not l_UploadDocHelper.UploadDoc then
       raise Exception.Create(sidRemoteStorageDisabled);
     except
      l_UploadDocHelper.HanldeException;
      raise;
     end;
(*
    except
     l_Filer.Rollback;
     raise;
    end;//try..except
   finally
    if l_NeedOpen then
     l_Filer.Close;
   end;//try..finally
  finally
   l3Free(l_Filer)
  end;//try..finally
*)
 finally
//  l3Free(G);

  l3Free(l_UploadDocHelper);

 end;//try..finally

 Document.AttrW[k2_tiEditableParts, nil] := nil; // записали - обнуляем
 //l3System.Msg2Log('SaveText End, DocID = %d', [DocInfo.DocID]);

 fExistsInStgWasChecked := true;
 fExistsInStg := True;
end;

procedure TarTextOfDocument.SaveLocal(const aLocalDBName : TPathStr; aDocInfoRecord : Tm3DBDocumentInfo);
var
 l_DB       : Im3DB;
 l_Filer    : Tm3DBFiler;
 G          : Tk2TagGenerator;

var
 lDocClassWasChanged : Boolean;
begin
 l3System.Msg2Log('SaveLocalText Start, DocID = %d, part=%s', [DocInfo.DocID, GetEnumName(TypeInfo(Tm3DocPartSelector), Ord(DocPart))]);

 //SaveTextToFile(format(aLocalDBName+'.evd',[DocInfo.DocID]),FTDefault);
 //Exit;

 if not HasDocument or InIO then Exit;

 lDocClassWasChanged := Document.IntA[k2_tiType] <> ord(DocInfo.DocClass);
 if lDocClassWasChanged then
  Document.IntA[k2_tiType] := ord(DocInfo.DocClass);

 SetNeedFullSave(True);

 G := nil;
 try
  l_DB := Tm3SimpleDB.Make(aLocalDBName);
  try
   l_Filer := Tm3DBFiler.Create(l_DB, DocInfo.DocID, DocPart);
  finally
   l_DB := nil;
  end;//try..finally
  try
   l_Filer.Mode := l3_fmReadWrite;
   l_Filer.Open;
   try
    try
     TevdNativeWriter.SetTo(G);
     with TevdNativeWriter(G) do
     begin
      Filer := l_Filer;
      Binary := true;
     end;
     Save(G);
    except
     l_Filer.Rollback;
     raise;
    end;//try..except
   finally
    l_Filer.Close;
   end;//try..finally
  finally
   l3Free(l_Filer)
  end;//try..finally
 finally
  l3Free(G);
 end;//try..finally
end;

procedure TarTextOfDocument.SaveTextToFile(DestFileName : TFileName; FileType : Byte);
var
 lDosFiler     : TevDOSFiler;
 W,G           : Tk2TagGenerator; {TevCustomFileGenerator;}
 lSaveModified : Boolean;
begin
 LoadText;
 if DestFileName = '' then Exit;
 lSaveModified := Modified;
 try
  lDosFiler := TevDosFiler.Create(Nil);
  try
   lDOSFiler.FileName := DestFileName;
   W := nil;
   G := nil;
   try
    case FileType of
     ftDefault,
     ftEverest :
         begin
          W := TevdNativeWriter.Create(Nil); {Everest}
          TevdNativeWriter(W).Filer := lDosFiler;
          TevdNativeWriter(W).Binary := False{!true};
           W := TevTagsListFilter.SetTo(W, TevTagsListFilter.MakeAttrList(k2_typDocument, [k2_tiEditableParts]));
          Save(W);
         end;
     ftANSIText,
     ftOEMText  :
          begin {ANSI & OEM}
           W := TevTextFormatter.Create(nil);
           G := TevdPlainTextWriter.Create(nil);
           TevdPlainTextWriter(G).Filer := lDosFiler;
           TevTextFormatter(W).Generator := G;
           TevTextFormatter(W).SBSDelimeter := cc_HardSpace;
           lDosFiler.Mode := l3_fmWrite;
           lDosFiler.Open;
           try
            lDosFiler.Write(Format('!TOPIC %d'#13#10,[Document.IntA[k2_tiExternalHandle]]));
           //lDosFiler.Mode := l3_fmAppend;
            if (FileType = ftANSIText)
             then
              begin
               TevTextFormatter(W).CodePage := CP_ANSI;
               TevTextFormatter(W).FormatOrdinalParas := false;
              end
             else
              TevTextFormatter(W).CodePage := CP_OEMLite;
            Save(W);
           finally
            lDosFiler.Close;
           end;
          end;
     ftRTF :
         begin
          W := TevRTFObjectGenerator.Create(nil); {Everest}
          TevdNativeWriter(W).Filer := lDosFiler;
          //TevdNativeWriter(W).Binary := true;
          Save(W);
         end;
     else
      begin
       vtMessageDlg(l3CStr('Сохранение в этом формате недоступно.'), mtWarning);
       Exit;
      end;
    end;
    //if (W <> nil) then fTextSource.Save(W);
   finally
    W.Free;
    G.Free;
   end;
  finally
   lDosFiler.Free;
  end;
 finally
  Modified := lSaveModified;
 end;
end;

procedure TarTextOfDocument.SaveToEVD(const aFileName : TFileName);
var
 l_StreamOut : Tl3Stream;
 l_StreamIn  : IStream;
 l_Read      : Int64;
 l_Written   : Int64;
begin
 l_StreamOut := Tl3FileStream.Create(aFileName, l3_fmWrite);
 try
  with dtGetDB(DocInfo.DocFamily) do
  begin
   with GetDocument(DocInfo.DocID) do
   begin
    l_StreamIn := GetVersion.Open();
    if (l_StreamIn = nil) then
     l_StreamIn := GetConst.Open();
    if (l_StreamIn <> nil) then
     try
      l_StreamIn.CopyTo(l_StreamOut, High(Int64), l_Read, l_Written);
     finally
      l_StreamIn := nil;
     end;//try..finally
   end;//with GetDocument(fDocID)
  end;//with dtGetDB(fDocFamily)
 finally
  l3Free(l_StreamOut);
 end;//try..finally
end;

(*procedure TarCustomDocument.SetNeedTextIndex(Value : Boolean);
begin
 if fNeedTextIndex = Value then Exit;
 fNeedTextIndex := Value;
end;
*)

procedure TarTextOfDocument.UnLoadText;
begin
 //if fTextSource <> nil then
{$IFDEF ARCHI_OLD_EVEREST}
  DocumentContainer.Clear;
{$ELSE}
 DocumentContainer := nil;
{$ENDIF ARCHI_OLD_EVEREST}
end;


function  TarTextOfDocument.Exists : Boolean;
var
 l_DB : Im3DB;
 lSize : Int64;
begin
 if fExistsInStgWasChecked then
  Result := fExistsInStg
 else
 begin
  Result := False;
  if not (DocInfo.IsSetted) then Exit;

  l_DB := dtGetDB(DocInfo.DocFamily);
  try
   try
    lSize := m2ComGetSize(l_DB.GetDocument(DocInfo.DocID).Open(m3_saRead, DocPart));
    Result := lSize > 0;
   except
    on E: EOleSysError do
     if (E.ErrorCode = E_NOTIMPL) OR
        (E.ErrorCode = STG_E_INVALIDFUNCTION) OR
        (E.ErrorCode = STG_E_INVALIDPOINTER) OR
        (E.ErrorCode = E_UNEXPECTED) then
     begin
      Result := true;
     end//E.ErrorCode = E_NOTIMPL..
     else
      raise;
   end;//try..except
  finally
   l_DB := nil;
  end;//try..finally

  fExistsInStgWasChecked := true;
  fExistsInStg := Result;
 end;
end;

function  TarTextOfDocument.ExistInLocal(const aLocalDBName : TPathStr) : Boolean;
var
 lDB : Im3DB;
 lSize : Int64;
 lStream : IStream;
begin
 Result := False;
 if not (DocInfo.IsSetted) then Exit;

 lDB := Tm3SimpleDB.Make(aLocalDBName);
 try
  try
   lStream := lDB.GetDocument(DocInfo.DocID).Open(m3_saRead, DocPart);
   lDB := nil;
   lSize := m2ComGetSize(lStream);
   Result := lSize > 0;
  except
   on E: EOleSysError do
    if (E.ErrorCode = E_NOTIMPL) OR
       (E.ErrorCode = STG_E_INVALIDFUNCTION) OR
       (E.ErrorCode = STG_E_INVALIDPOINTER) OR
       (E.ErrorCode = E_UNEXPECTED) then
    begin
     Result := true;
    end//E.ErrorCode = E_NOTIMPL..
    else
     raise;
  end;//try..except

 finally
  lDB := nil;
 end;//try..finally
end;

procedure TarTextOfDocument.Clear;
var
 l_DB : Im3DB;
begin
 if not (DocInfo.IsSetted) then Exit;

 l_DB := dtGetDB(DocInfo.DocFamily);
 try
  l_DB.GetDocument(DocInfo.DocID).Open(m3_saReadWrite, DocPart);
 finally
  l_DB := nil;
 end;//try..finally
end;

(*
function  TarTextOfDocument.GetGenerator(const aView : InevView;

                             const aGeneratorTarget: IUnknown): Ik2TagGenerator;
begin
 Result := inherited GetGenerator(aView, aGeneratorTarget);
 if (aGeneratorTarget = nil) and not fNewDoc then // только для процедуры New;
  if (DocInfo.DocID > 0) // не док для поиска
     and not IsSpravka and (DocPart = m3_dsMain) then
  begin
   TExportFilter.SetTo(Result, DocInfo.DocFamily, DocInfo.DocID, true, false, emLoad);
  end;
end;
*)

function TarTextOfDocument.GetDocumentType : Tk2Type;
begin
 if DocInfo.DocClass = dtDictEntry then
  Result := k2_typDictEntry
 else
  if DocPart = m3_dsAnno then
   Result := k2_typAnnoTopic
  else
   Result := k2_typDocument;
end;

procedure TarTextOfDocument.MakeNewDoc;
begin
 //fNewDoc := True;
 Inherited New(GetDocumentType);

 Document.IntA[k2_tiInternalHandle] := DocInfo.DocID;
 Document.IntA[k2_tiLanguage] := GlobalDataProvider.BaseLanguage[DocInfo.DocFamily].LanguageID;

 Modified := False;
end;

procedure TarTextOfDocument.SetDocInfo(aValue : TarDocInfo);
begin
 l3Set(fDocInfo, aValue);
end;

function  TarTextOfDocumentWithContentsTree.DoMakeDocumentContainer: InevDocumentContainer;
begin
 Result := TarDocumentContainerWithContentsTree.Make;
end;

{TarTextOfAnnoDocument}

//procedure TarTextOfAnnoDocument.SaveText(aFullSave : Boolean = True; anAdditionalData: TObject = nil);
//begin
// SaveTextPrim(aFullSave, anAdditionalData);
//end;

procedure TarTextOfDocument.BuildRemoteLoadPipe(var aGen: Tk2TagGenerator;
  WithAttr: Boolean; DocPartSel: TDocPartSelector;
  aFoundSelector: Tm4Addresses; aLevel: Integer; var theFiler : Tl3CustomFiler);
//var
// l_DB: Im3DB;
begin
 BuildDocLoadPipe(DocInfo.DocFamily, DocInfo.DocID, IsObjTopic, GetDocumentType,
  DocPart, aLevel, WithAttr, DocPartSel, aFoundSelector, aGen, theFiler);
(*
 if WithAttr then
 begin
  TExportFilter.SetTo(aGen, DocInfo.DocFamily, DocInfo.DocID, true, false, emLoad, DocPartSel);
 end;

 if WithAttr then
  TddWrongTagFixFilter.SetTo(aGen, false);

 if DocPart = m3_dsMain then
 begin
  if not IsObjTopic then
  begin
   //TRecalcHLinksFilter.SetTo(G, DocInfo.DocFamily, DocInfo.DocID);
    TddExtObjInserter.SetTo(aGen);
    evLinkTableFilters(aGen, False);
    TevOutTextParaEliminator.SetTo(aGen);
  end
  else
  begin
   TarDocObjectMixer.SetTo(aGen);
  end;
 end;

 //TddKTExtractorFilter.SetTo(aGen);
 if aFoundSelector <> nil then
  TarFoundSelectionFilter.SetTo(aGen, aFoundSelector);

 TFixInternalNumberHandleFilter.SetTo(aGen, DocInfo.DocID); // гарантированно кладет DocInfo.DocID в InternalHandle
 TevTagsListFilter.SetTo(aGen, TevTagsListFilter.MakeAttrList(k2_typDocument, [k2_tiEditableParts, k2_tiExternalHandle]));
 TevdBadEVDToEmptyDocumentTranslator.SetTo(aGen, GetDocumentType, GlobalDataProvider.BaseLanguage[DocInfo.DocFamily].LanguageID);


 l_DB := dtGetDB(DocInfo.DocFamily);
 try
  theFiler := Tm3DBFiler.Create(l_DB, DocInfo.DocID, DocPart, aLevel);
 finally
  l_DB := nil;
 end;//try..finally
*) 
end;

procedure TarTextOfDocument.BuildLoadPipeParams(out WithAttr: Boolean;
  out DocPartSel: TDocPartSelector);
begin
 WithAttr:= not IsSpravka and (DocPart in [m3_dsMain, m3_dsAnno]);
 DocPartSel := dpDoc;
 if WithAttr then
 begin
  if IsSpravka then
   DocPartSel := dpSpr
  else
   if DocPart = m3_dsAnno then
    DocPartSel := dpAnno
   else
    DocPartSel := dpDoc;
 end;
end;

function TarTextOfDocument.BuildClientServerLoadPipe(
  var aGen: Tk2TagGenerator; WithAttr: Boolean; DocPartSel: TDocPartSelector;
  aFoundSelector: Tm4Addresses; aLevel : Integer; var theFiler : Tl3CustomFiler): Boolean;
var
 l_ComStream: IStream;
begin
 l_ComStream := nil;
 Result := ArchiRequestManager.DownloadDocStream(DocInfo.DocFamily, DocInfo.DocID,
   IsObjTopic, GetDocumentType.AsString, DocPart, aLevel, WithAttr, DocPartSel,
   aFoundSelector, l_ComStream);
 try
  if Result then
  begin
   theFiler := Tl3CustomFiler.Create(nil);
   theFiler.COMStream := l_ComStream;
  end;
 finally
  l_ComStream := nil;
 end;
end;

function TarTextOfDocument.IsObjTopic: Boolean;
begin
 Result := DocInfo.fDocClass in [dtFlash, dtObject];
end;

{TDocAttributeManager}

constructor TDocAttributeManager.Create(aDocument : TarDocumentWithAttr = nil);
begin
 inherited Create;
 fDocument := aDocument;
end;

procedure TDocAttributeManager.Cleanup;
begin
 l3Free(fAttrArray);
 inherited;
end;

function TDocAttributeManager.DataWasModified(aDocParts : Tm3DocPartSet) : Boolean;
begin
 Result := False;
 if m3_dsMain in aDocParts then
  Result := Document.TextSource.AttrWasModified;

 if Result then exit;

 if m3_dsAnno in aDocParts then
  Result := Document.AnnoTextSource.AttrWasModified;
end;

procedure  TDocAttributeManager.DeleteAllforPart(aDocPart : Tm3DocPartSelector);
var
 I : Integer;
begin
 if fAttrArray <> nil then
  for I := 0 to Pred(fAttrArray.Count) do
   if (fAttrArray[I] <> nil) then
    TCustomDocAttribute(fAttrArray[I]).DeleteAllforPart(aDocPart);
end;


procedure TDocAttributeManager.DropDataModified;
var
 I : Integer;
begin
 if fAttrArray <> nil then
  for I := 0 to Pred(fAttrArray.Count) do
   if (fAttrArray[I] <> nil) then
    TCustomDocAttribute(fAttrArray[I]).Modified := False;
end;

function TDocAttributeManager.GetTextSourceforAttr(aAttr : IDocAttribute) : TarTextOfDocument;
begin
 if (AttrOperateMode = aomEdit) and (aAttr.DocPart = m3_dsAnno) then
  Result := Document.AnnoTextSource
 else
  if Document = nil then
   Result := nil
  else
   Result := Document.TextSource;
end;

(*procedure TDocAttributeManager.TextSourceLoaded(aDocPart : Tm3DocPartSelector);
var
 lAttrSet : TdtAttributeSet;
 I : Integer;
begin
 case aDocPart of
  m3_dsMain : lAttrSet := cDocAttrs;
  m3_dsAnno : lAttrSet := cAnnoAttrs;
 else Exit
 end; //case aDocPart of

 if fAttrArray <> nil then
  for I := 0 to Pred(fAttrArray.Count) do
   if (TdtAttribute(I) in lAttrSet) and (fAttrArray[I] <> nil) then
    with TCustomDocAttribute(fAttrArray[I]) do
    begin
     Changing;
     Changed;
    end;
end;
*)
procedure TDocAttributeManager.SetAttrModified(aAttr : IDocAttribute);
var
 l_CT     : TCacheType;
 lEdPart : Cardinal;
 l_DocText: TarTextOfDocument;
begin
 if aAttr.AttrID in GlAttrInMainRecSet then
  lEdPart := epMainRecAttr
 else
 begin
  l_CT := AttributeToCacheType(aAttr.AttrID);
  if (l_CT = ctLog_Doc) and (aAttr.DocPart = m3_dsAnno) then
   l_CT := ctLog_Anno;
   lEdPart := Ord(l_CT);
 end;

 l_DocText := GetTextSourceforAttr(aAttr);
 if l_DocText <> nil then
  l_DocText.SetEditablePart(lEdPart);
end;

procedure TDocAttributeManager.evntChangeDocAttribute(const aSender: IDocAttribute);
begin
 if fInLoad then Exit;
 if aSender.AttrID in cReadOnlyAttrs then exit;
 SetAttrModified(aSender);
 if not fInChangeDocProcess then
 begin
  if Assigned(fOnChangeDocAttribute) then
   fOnChangeDocAttribute(aSender);
 end;
end;

procedure TDocAttributeManager.PrepareEditablePartsInfo;
var
 lLogEdited : boolean;
begin
 if AttrOperateMode = aomGroupEdit then
 begin
  // если исправляли ctLog_Doc
  with Document.TextSource.Document.rAtomEx([k2_tiEditableParts, k2_tiChildren, k2_tiHandle, ord(ctLog_Doc)]) do
   lLogEdited := IsValid AND BoolA[k2_tiModified];

  if lLogEdited then
  begin
   // если добавляли операции относящиеся к анно
   with (GetDocAttribute(atJurLogRecords) as ILogDocAttributeTool) do
   begin
    if HasDocThisLogRec(cAnnoLogActions) then
     Document.TextSource.Document.CAtomEx([k2_tiEditableParts, k2_tiChildren, k2_tiHandle, epAnno], nil)
     .BoolA[k2_tiModified] := true;

    if HasDocThisLogRec(cDocLogActions) then
     Document.TextSource.Document.CAtomEx([k2_tiEditableParts, k2_tiChildren, k2_tiHandle, epJurOp], nil)
      .BoolA[k2_tiModified] := true;
    {else
     Document.TextSource.Document.CAtomEx([k2_tiEditableParts, k2_tiChildren, k2_tiHandle, ord(ctLog_Doc)], nil)
     .BoolA[k2_tiModified] := false;}
   end;
  end;
 end;
end;

function TDocAttributeManager.GetAttrArray : Tl3ObjectRefArray;
begin
 if fAttrArray = nil then
  fAttrArray := Tl3ObjectRefArray.Make;
 Result := fAttrArray;
end;

//function TDocAttributeManager.IsDocAttributeCreated(aAttrID : TdtAttribute) : Boolean;
//begin
// Result := AttrArray[Ord(aAttrID)] <> nil;
//end;

//function  TDocAttributeManager.GetAttrContainer : _Ik2Tag;
//begin

//end;

function TDocAttributeManager.GetDocAttribute(aAttrID : TdtAttribute) : IDocAttribute;

 function MakeAttrObj(aAttrID : TdtAttribute) : TCustomDocAttribute;
 begin
 { if GetAttrType(aAttrID) in OrdAttrSet then
   Result := TOrdinalDocAttribute.Create(Self, aAttrID)
  else}
  {!!NewAttr}  // dt_link
  if aAttrID in StdDictAttrSet then
   Result := TDictDocAttribute.Create(Self, aAttrID, (AttrOperateMode = aomEdit) and not cAttrPassport[aAttrID].rMultiValue)
  else
   case aAttrID of
    atDateNums :
     Result := TDateNumDocAttribute.Create(Self);
    atAlarms :
     Result := TAlarmDocAttribute.Create(Self);
    atActiveIntervals :
     Result := TActiveIntervalListDocAttribute.Create(Self);
    atJurLogRecords :
     if AttrOperateMode = aomEdit then
      Result := TJurOperationAttribute.Create(Self)
     else
      Result := TLogGrOpAttribute.Create(Self);
    atOrdLogRecords :
     Result := TOrdOperationAttribute.Create(Self);
    atRenum :
     Result := TDocIDsAttribute.Create(Self);
    atVerLink :
     Result := TVerLinkAttribute.Create(Self);
    atPublisheds :
     if AttrOperateMode = aomSearch then //поисковый запрос
      Result := TDictDocAttribute.Create(Self, aAttrID)
     else
      Result := TPublishedDocAttribute.Create(Self);
    atCorrects :
     Result := TCorrectsAttribute.Create(Self);
    atVersions :
     Result := TVersionListAttribute.Create(Self);
    atStages :
     Result := TStagesDocAttribute.Create(Self);
    atDoc2DocLink :
     Result := TDoc2DocAttribute.Create(Self);

   else
    Result := nil;
   end;
 end;

var
 lDocAttr : TCustomDocAttribute;
begin
 lDocAttr := AttrArray[Ord(aAttrID)] As TCustomDocAttribute;
 if lDocAttr = nil then
 begin
  lDocAttr := MakeAttrObj(aAttrID);
  Assert(lDocAttr <> nil, Format('Не удалось получить интерфейс на атрибут #%d', [Ord(aAttrID)]));
  if lDocAttr <> nil then
  begin
   AttrArray[Ord(aAttrID)] := lDocAttr;
   lDocAttr.Free; //dec refcount
  end;
 end;

 fInLoad := True;  //предотвращает взведение Modified в evntChangeDocAttribute
 try
  lDocAttr.SubID := SubID;
 finally
  fInLoad := false;
 end;
 Supports(lDocAttr, IDocAttribute, Result);
end;

function  TDocAttributeManager.Get_SubID : TSubID;
begin
 Result := fSubID;
end;

procedure TDocAttributeManager.ReloadDocAttributes(aAttrIDSet : TdtAttributeSet = []);
var
 I : Integer;
begin
 if fAttrArray <> nil then
 for I := 0 to Pred(fAttrArray.Count) do
  if (fAttrArray[I] <> nil) and
     ((aAttrIDSet = []) or (TdtAttribute(I) in aAttrIDSet)) then
   TCustomDocAttribute(fAttrArray[I]).Load;
end;

function TDocAttributeManager.BeforeSaveDocData(aAttrIDSet : TdtAttributeSet = []) : Boolean;
var
 I : Integer;
begin
 Result := False;
 if fAttrArray = nil then Exit;
 if SubID = cAllSubs then Exit;  //удаление сразу, добавление невозможно


 if Assigned(fOnBeforeSaveAttribute) then
  for I := 0 to Pred(fAttrArray.Count) do
  if (fAttrArray[I] <> nil) and
     ((aAttrIDSet = []) or (TdtAttribute(I) in aAttrIDSet)) then
   fOnBeforeSaveAttribute(TCustomDocAttribute(fAttrArray[I]));

 {for I := 0 to Pred(fAttrArray.Count) do
  if (fAttrArray[I] <> nil) and
     ((aAttrIDSet = []) or (TdtAttribute(I) in aAttrIDSet)) then
   if TCustomDocAttribute(fAttrArray[I]).Save then
    Result := True;}
end;

procedure TDocAttributeManager.SetDocFamily(aValue : TdaFamilyID);
begin
 if fDocument <> nil then
  fDocument.DocFamily := aValue;

 fDocFamily := aValue;
end;

function TDocAttributeManager.GetDocFamily : TdaFamilyID;
begin
 if fDocument <> nil then
  Result := fDocument.DocFamily
 else
  Result := fDocFamily;
end;

procedure TDocAttributeManager.Set_SubID(aValue : TSubID);
var
 I : Integer;
begin
 if fSubID = aValue then Exit;
 fSubID := aValue;
 if fAttrArray <> nil then
 begin
  fInLoad := True;  //предотвращает взведение Modified в evntChangeDocAttribute
  try
   for I := 0 to Pred(fAttrArray.Count) do
    if (fAttrArray[I] <> nil) then
     TCustomDocAttribute(fAttrArray[I]).SubID := fSubID;
  finally
   fInLoad := false;
  end;
 end;
end;

{TarQueryDataTextOfDocument}
function TarQueryDataTextOfDocument.GetDocumentType : Tk2Type;
begin
 Result := k2_typDocumentQuery;
end;

{TQueryDataDocument}
function  TQueryDataDocument.GetTextAttribute(aDocPart : Tm3DocPartSelector) : TarTextOfDocument;
begin
 if fTextSourceArr[m3_dsMain] = nil then
  fTextSourceArr[m3_dsMain] := TarQueryDataTextOfDocument.Make(DocInfo, aDocPart);

 Result := fTextSourceArr[m3_dsMain];
end;

function TQueryDataDocument.AttrManager(aSubID : TSubID = 0): TDocAttributeManager;
begin
 Result := inherited AttrManager(aSubID);
 Result.fAttrOperateMode := aomSearch;
end;

procedure DeleteLocalCopy(aDocID : TDocID);
 var
  l_DB : Im3DB;
 begin
 l_DB := Tm3SimpleDB.Make(ConcatDirName(IniRec.PathToLocalSaveDir, IntToStr(aDocID)));
 try
  l_DB.DeleteVersion;
 finally
  l_DB := nil;
 end;//try..finally
 end;
end.




