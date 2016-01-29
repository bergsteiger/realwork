const
  MAPI_DIM = 1;

type
  TWCHAR = WideChar;
  PWSTR = ^TWCHAR;
  TBOOKMARK = ULONG;

  TMAPIERROR = record
    ulVersion: ULONG;
    lpszError: PChar;
    lpszComponent: PChar;
    ulLowLevelError: ULONG;
    ulContext: ULONG;
  end;
  PMAPIERROR = ^TMAPIERROR;

  TENTRYID = record
    abFlags: array [0..4 - 1] of Byte;
    ab: array [0..MAPI_DIM - 1] of Byte;
  end;
  PENTRYID = ^TENTRYID;
  LPENTRYID = ^TENTRYID;

  TSPropTagArray = record
    cValues: ULONG;
    aulPropTag: array [0..MAPI_DIM - 1] of ULONG;
  end;
  PSPropTagArray = ^TSPropTagArray;

  TMAPIUID = record
    ab: array [0..16 - 1] of Byte;
  end;
  PMAPIUID = ^TMAPIUID;

  TCY = record
    case Integer of
      1: (_noname1:
            record
              Lo: Longint;
              Hi: Longint;
            end;
          );
      2: (int64: LONGLONG;);
  end;
  TCURRENCY = TCY;

  TSBinary = record
    cb: ULONG;
    lpb: PBYTE;
  end;
  PSBinary = ^TSBinary;

  TSShortArray = record
    cValues: ULONG;
    lpi: ^Smallint;
  end;

  TSLongArray = record
    cValues: ULONG;
    lpl: ^Longint;
  end;

  TSRealArray = record
    cValues: ULONG;
    lpflt: ^Single;
  end;

  TSDoubleArray = record
    cValues: ULONG;
    lpdbl: ^Double;
  end;

  TSCurrencyArray = record
    cValues: ULONG;
    lpcur: ^TCURRENCY;
  end;

  TSAppTimeArray = record
    cValues: ULONG;
    lpat: ^Double;
  end;

  TSDateTimeArray = record
    cValues: ULONG;
    lpft: ^TFILETIME;
  end;

  TSBinaryArray = record
    cValues: ULONG;
    lpbin: ^TSBinary;
  end;

  TSLPSTRArray = record
    cValues: ULONG;
    lppszA: ^LPSTR;
  end;

  TSWStringArray = record
    cValues: ULONG;
    lppszW: ^PWSTR;
  end;

  TSGuidArray = record
    cValues: ULONG;
    lpguid: ^TGUID;
  end;

  TSLargeIntegerArray = record
    cValues: ULONG;
    lpli: ^TLargeInteger;
  end;

  T__UPV = record
    case Integer of
      1 : (i: Smallint;);
      2 : (l: Longint;);
      3 : (ul: ULONG;);
      4 : (flt: Single;);
      5 : (dbl: Double;);
      6 : (b: Smallint;);
      7 : (cur: TCURRENCY;);
      8 : (at: Double;);
      9 : (ft: TFILETIME;);
      10: (lpszA: LPSTR;);
      11: (bin: TSBinary;);
      12: (lpszW: PWSTR;);
      13: (lpguid: PGUID;);
      14: (li: TLargeInteger;);
      15: (MVi: TSShortArray;);
      16: (MVl: TSLongArray;);
      17: (MVflt: TSRealArray;);
      18: (MVdbl: TSDoubleArray;);
      19: (MVcur: TSCurrencyArray;);
      20: (MVat: TSAppTimeArray;);
      21: (MVft: TSDateTimeArray;);
      22: (MVbin: TSBinaryArray;);
      23: (MVszA: TSLPSTRArray;);
      24: (MVszW: TSWStringArray;);
      25: (MVguid: TSGuidArray;);
      26: (MVli: TSLargeIntegerArray;);
      27: (err: SCODE;);
      28: (x: Longint;);
  end;

  TSPropValue = record
    ulPropTag: ULONG;
    dwAlignPad: ULONG;
    Value: T__UPV;
  end;
  PSPropValue = ^TSPropValue;

  PSPropValueArray = ^TSPropValueArray;
  TSPropValueArray = array [0..0] of TSPropValue;

  TSRow = record
    ulAdrEntryPad: ULONG;
    cValues: ULONG;
    lpProps: PSPropValueArray;
  end;
  PSRow = ^TSRow;

  TSRowSet = record
    cRows: ULONG;
    aRow: array [0..MAPI_DIM - 1] of TSRow;
  end;
  PSRowSet = ^TSRowSet;

  TERROR_NOTIFICATION = record
    cbEntryID: ULONG;
    lpEntryID: PENTRYID;
    scode: SCODE;
    ulFlags: ULONG;
    lpMAPIError: PMAPIERROR;
  end;

  TNEWMAIL_NOTIFICATION = record
    cbEntryID: ULONG;
    lpEntryID: PENTRYID;
    cbParentID: ULONG;
    lpParentID: PENTRYID;
    ulFlags: ULONG;
    lpszMessageClass: PChar;
    ulMessageFlags: ULONG;
  end;

  TOBJECT_NOTIFICATION = record
    cbEntryID: ULONG;
    lpEntryID: PENTRYID;     
    ulObjType: ULONG;
    cbParentID: ULONG;
    lpParentID: PENTRYID;
    cbOldID: ULONG;
    lpOldID: PENTRYID;
    cbOldParentID: ULONG;
    lpOldParentID: PENTRYID;
    lpPropTagArray: PSPropTagArray;
  end;

  TTABLE_NOTIFICATION = record
    ulTableEvent: ULONG;    
    hResult: HResult;
    propIndex: TSPropValue;
    propPrior: TSPropValue;
    row: TSRow;
    ulPad: ULONG;
  end;

  TEXTENDED_NOTIFICATION = record
    ulEvent: ULONG;
    cb: ULONG;
    pbEventParameters: PBYTE;
  end;

  TSTATUS_OBJECT_NOTIFICATION = record
    cbEntryID: ULONG;
    lpEntryID: PENTRYID;
    cValues: ULONG;
    lpPropVals: PSPropValue;
  end;

  TNOTIFICATION = record
    ulEventType: ULONG;
    ulAlignPad: ULONG;
    info: record
      case Integer of
        1: (err: TERROR_NOTIFICATION;);
        2: (newmail: TNEWMAIL_NOTIFICATION;);
        3: (obj: TOBJECT_NOTIFICATION;);
        4: (tab: TTABLE_NOTIFICATION;);
        5: (ext: TEXTENDED_NOTIFICATION;);
        6: (statobj: TSTATUS_OBJECT_NOTIFICATION;);
    end;
  end;
  PNOTIFICATION = ^TNOTIFICATION;

  PSRestriction = ^TSRestriction;

  TSAndRestriction = record
    cRes: ULONG;
    lpRes: PSRestriction;
  end;

  TSOrRestriction = record
    cRes: ULONG;
    lpRes: PSRestriction;
  end;

  TSNotRestriction = record
    ulReserved: ULONG;
    lpRes: PSRestriction;
  end;

  TSContentRestriction = record
    ulFuzzyLevel: ULONG;
    ulPropTag: ULONG;
    lpProp: PSPropValue;
  end;

  TSBitMaskRestriction = record
    relBMR: ULONG;
    ulPropTag: ULONG;
    ulMask: ULONG;
  end;

  TSPropertyRestriction = record
    relop: ULONG;
    ulPropTag: ULONG;
    lpProp: PSPropValue;
  end;

  TSComparePropsRestriction = record
    relop: ULONG;
    ulPropTag1: ULONG;
    ulPropTag2: ULONG;
  end;

  TSSizeRestriction = record
    relop: ULONG;
    ulPropTag: ULONG;
    cb: ULONG;
  end;

  TSExistRestriction = record
    ulReserved1: ULONG;
    ulPropTag: ULONG;
    ulReserved2: ULONG;
  end;

  TSSubRestriction = record
    ulSubObject: ULONG;
    lpRes: PSRestriction;
  end;

  TSCommentRestriction = record
    cValues: ULONG;
    lpRes: PSRestriction;
    lpProp: PSPropValue;
  end;

  TSRestriction = record
    rt : ULONG;
    res :
      record
        case Integer of
          1 : (resCompareProps: TSComparePropsRestriction;);
          2 : (resAnd: TSAndRestriction;);
          3 : (resOr: TSOrRestriction;);
          4 : (resNot: TSNotRestriction;);
          5 : (resContent: TSContentRestriction;);
          6 : (resProperty: TSPropertyRestriction;);
          7 : (resBitMask: TSBitMaskRestriction;);
          8 : (resSize: TSSizeRestriction;);
          9 : (resExist: TSExistRestriction;);
          10: (resSub: TSSubRestriction;);
          11: (resComment: TSCommentRestriction;);
      end;
  end;

  TSSortOrder = record
    ulPropTag: ULONG;
    ulOrder: ULONG;
  end;
  PSSortOrder = ^TSSortOrder;

  TSSortOrderSet = record
    cSorts: ULONG;
    cCategories: ULONG;
    cExpanded: ULONG;
    aSort: array [0..MAPI_DIM - 1] of TSSortOrder;
    end;
  PSSortOrderSet = ^TSSortOrderSet;

  TSPropProblem = record
    ulIndex: ULONG;
    ulPropTag: ULONG;
    scode: SCODE;
  end;
  PSPropProblem = ^TSPropProblem;

  TSPropProblemArray = record
    cProblem: ULONG;
    aProblem: array [0..MAPI_DIM - 1] of TSPropProblem;
  end;
  PSPropProblemArray = ^TSPropProblemArray;

  TMAPINAMEID = record
    lpguid: PGUID;
    ulKind: ULONG;
    Kind:
      record
        case Integer of
          1: (lID: Longint;);
          2: (lpwstrName: PWSTR;);
      end;
  end;
  PMAPINAMEID = ^TMAPINAMEID;

  TADRENTRY = record
    ulReserved1: ULONG;
    cValues: ULONG;
    rgPropVals: PSPropValue;
  end;
  PADRENTRY = ^TADRENTRY;

  TADRLIST = record
    cEntries: ULONG;
    aEntries: array [0..MAPI_DIM - 1] of TADRENTRY;
  end;
  PADRLIST = ^TADRLIST;
  LPADRLIST = ^TADRLIST;

  TACCELERATEABSDI = function (ulUIParam: ULONG; lpvmsg: Pointer): BOOL; stdcall;
  PFNABSDI = ^TACCELERATEABSDI;

  TDISMISSMODELESS = function (ulUIParam: ULONG; lpvContext: Pointer): Pointer; stdcall;
  PFNDISMISS = ^TDISMISSMODELESS;

  PFNBUTTON = function (ulUIParam: ULONG; lpvContext: Pointer; cbEntryID: ULONG;
                        lpSelection: PENTRYID; ulFlags: ULONG): SCODE; stdcall;

  TADRPARM = record
    cbABContEntryID: ULONG;
    lpABContEntryID: PENTRYID;
    ulFlags: ULONG;
    lpReserved: Pointer;
    ulHelpContext: ULONG;
    lpszHelpFileName: PChar;
    lpfnABSDI: PFNABSDI;
    lpfnDismiss: PFNDISMISS;
    lpvDismissContext: Pointer;
    lpszCaption: PChar;
    lpszNewEntryTitle: PChar;
    lpszDestWellsTitle: PChar;
    cDestFields: ULONG;
    nDestFieldFocus: ULONG;
    lppszDestTitles: ^PChar;
    lpulDestComps: ^ULONG;
    lpContRestriction: PSRestriction;
    lpHierRestriction: PSRestriction;
  end;
  PADRPARM = ^TADRPARM;

  TENTRYLIST = TSBinaryArray;
  PENTRYLIST = ^TENTRYLIST;

  IMAPIAdviseSink = interface(IUnknown)
    ['{00020302-0000-0000-C000-000000000046}']
    function OnNotify(cNotif: ULONG; lpNotifications: PNOTIFICATION): ULONG; stdcall;
  end;

  IMAPITable = interface(IUnknown)
    ['{00020301-0000-0000-C000-000000000046}']
    function GetLastError(hResult: HResult; ulFlags: ULONG; var lppMAPIError: PMAPIERROR): HResult; stdcall;
    function Advise(ulEventMask: ULONG; lpAdviseSink: IMAPIAdviseSink; var lpulConnection: ULONG): HResult; stdcall;
    function Unadvise(ulConnection: ULONG): HResult; stdcall;
    function GetStatus(var lpulTableStatus: ULONG; var lpulTableType: ULONG): HResult; stdcall;
    function SetColumns(lpPropTagArray: PSPropTagArray; ulFlags: ULONG): HResult; stdcall;
    function QueryColumns(ulFlags: ULONG; var lpPropTagArray: PSPropTagArray): HResult; stdcall;
    function GetRowCount(ulFlags: ULONG; var lpulCount: ULONG): HResult; stdcall;
    function SeekRow(bkOrigin: TBOOKMARK; lRowCount: Longint; var lplRowsSought: Longint): HResult; stdcall;
    function SeekRowApprox(ulNumerator: ULONG; ulDenominator: ULONG): HResult; stdcall;
    function QueryPosition(var lpulRow: ULONG; var lpulNumerator: ULONG; var lpulDenominator: ULONG): HResult; stdcall;
    function FindRow(lpRestriction: PSRestriction; bkOrigin: TBOOKMARK; ulFlags: ULONG): HResult; stdcall;
    function Restrict(lpRestriction: PSRestriction; ulFlags: ULONG): HResult; stdcall;
    function CreateBookmark(var lpbkPosition: TBOOKMARK): HResult; stdcall;
    function FreeBookmark(bkPosition: TBOOKMARK): HResult; stdcall;
    function SortTable(lpSortCriteria: PSSortOrderSet; ulFlags: ULONG): HResult; stdcall;
    function QuerySortOrder(var lppSortCriteria: PSSortOrderSet): HResult; stdcall;
    function QueryRows(lRowCount: Longint; ulFlags: ULONG; var lppRows: PSRowSet): HResult; stdcall;
    function Abort(): HResult; stdcall;
    function ExpandRow(cbInstanceKey: ULONG; pbInstanceKey: PBYTE; ulRowCount: ULONG; ulFlags: ULONG; var lppRows: PSRowSet; var lpulMoreRows: ULONG): HResult; stdcall;
    function CollapseRow(cbInstanceKey: ULONG; pbInstanceKey: PBYTE; ulFlags: ULONG; var lpulRowCount: ULONG): HResult; stdcall;
    function WaitForCompletion(ulFlags: ULONG; ulTimeout: ULONG; var lpulTableStatus: ULONG): HResult; stdcall;
    function GetCollapseState(ulFlags: ULONG; cbInstanceKey: ULONG; lpbInstanceKey: PBYTE; var lpcbCollapseState: ULONG; var lppbCollapseState: PBYTE): HResult; stdcall;
    function SetCollapseState(ulFlags: ULONG; cbCollapseState: ULONG; pbCollapseState: PBYTE; var lpbkLocation: TBOOKMARK): HResult; stdcall;
  end;

  IMAPIProgress = interface(IUnknown)
    ['{0002031F-0000-0000-C000-000000000046}']
    function Progress(ulValue: ULONG; ulCount: ULONG; ulTotal: ULONG): HResult; stdcall;
    function GetFlags(var lpulFlags: ULONG): HResult; stdcall;
    function GetMax(var lpulMax: ULONG): HResult; stdcall;
    function GetMin(var lpulMin: ULONG): HResult; stdcall;
    function SetLimits(lpulMin: PULONG; lpulMax: PULONG; lpulFlags: PULONG): HResult; stdcall;
  end;

  IMAPIProp = interface(IUnknown)
    ['{00020303-0000-0000-C000-000000000046}']
    function GetLastError(hResult: HResult; ulFlags: ULONG; var lppMAPIError: PMAPIERROR): HResult; stdcall;
    function SaveChanges(ulFlags: ULONG): HResult; stdcall;
    function GetProps(lpPropTagArray: PSPropTagArray; ulFlags: ULONG; var lpcValues: ULONG;
                      var lppPropArray: PSPropValue): HResult; stdcall;
    function GetPropList(ulFlags: ULONG; var lppPropTagArray: PSPropTagArray): HResult; stdcall;
    function OpenProperty(ulPropTag: ULONG; const lpiid: TIID; ulInterfaceOptions: ULONG; ulFlags: ULONG;
                          var lppUnk: IUnknown): HResult; stdcall;
    function SetProps(cValues: ULONG; lpPropArray: PSPropValue; var lppProblems: PSPropProblemArray): HResult; stdcall;
    function DeleteProps(lpPropTagArray: PSPropTagArray; var lppProblems: PSPropProblemArray): HResult; stdcall;
    function CopyTo(ciidExclude: ULONG; const rgiidExclude: TIID;
                    lpExcludeProps: PSPropTagArray; ulUIParam: ULONG;
                    lpProgress: IMAPIProgress; const lpInterface: TIID;
                    lpDestObj: Pointer; ulFlags: ULONG;
                    var lppProblems: PSPropProblemArray): HResult; stdcall;
    function CopyProps(lpIncludeProps: PSPropTagArray; ulUIParam: ULONG;
                       lpProgress: IMAPIProgress; const lpInterface: TIID; lpDestObj: Pointer;
                       ulFlags: ULONG; var lppProblems: PSPropProblemArray): HResult; stdcall;
    function GetNamesFromIDs(var lppPropTags: PSPropTagArray;
                             lpPropSetGuid: PGUID; ulFlags: ULONG; var lpcPropNames: ULONG;
                             var lpppPropNames: PMAPINAMEID): HResult; stdcall;
    function GetIDsFromNames(cPropNames: ULONG; var lppPropNames: PMAPINAMEID;
                             ulFlags: ULONG; var lppPropTags: PSPropTagArray): HResult; stdcall;
  end;

  IAttach = interface(IMAPIProp)
    ['{00020308-0000-0000-C000-000000000046}']
  end;

  IMessage = interface(IMAPIProp)
    ['{00020307-0000-0000-C000-000000000046}']
    function GetAttachmentTable(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function OpenAttach(ulAttachmentNum: ULONG; const lpInterface: TIID;
                        ulFlags: ULONG; var lppAttach: IAttach): HResult; stdcall;
    function CreateAttach(const lpInterface: PIID; ulFlags: ULONG;
                          var lpulAttachmentNum: ULONG; var lppAttach: IAttach): HResult; stdcall;
    function DeleteAttach(ulAttachmentNum: ULONG; ulUIParam: ULONG;
                          lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
    function GetRecipientTable(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function ModifyRecipients(ulFlags: ULONG; lpMods: PADRLIST): HResult; stdcall;
    function SubmitMessage(ulFlags: ULONG): HResult; stdcall;
    function SetReadFlag(ulFlags: ULONG): HResult; stdcall;
  end;

  IMsgStore = interface(IMAPIProp)
    ['{00020306-0000-0000-C000-000000000046}']
    function Advise(cbEntryID: ULONG; lpEntryID: PENTRYID; ulEventMask: ULONG;
                    lpAdviseSink: IMAPIAdviseSink; var lpulConnection: ULONG): HResult; stdcall;
    function Unadvise(ulConnection: ULONG): HResult; stdcall;
    function CompareEntryIDs(cbEntryID1: ULONG; lpEntryID1: PENTRYID;
                             cbEntryID2: ULONG; lpEntryID2: PENTRYID; ulFlags: ULONG;
                             var lpulResult: ULONG): HResult; stdcall;
    function OpenEntry(cbEntryID: ULONG; lpEntryID: PENTRYID; const lpInterface: TIID;
                       ulFlags: ULONG; var lpulObjType: ULONG; var lppUnk: IUnknown): HResult; stdcall;
    function SetReceiveFolder(lpszMessageClass: PChar; ulFlags: ULONG;
                              cbEntryID: ULONG; lpEntryID: PENTRYID): HResult; stdcall;
    function GetReceiveFolder(lpszMessageClass: PChar; ulFlags: ULONG;
                              var lpcbEntryID: ULONG; var lppEntryID: PENTRYID;
                              var lppszExplicitClass: PChar): HResult; stdcall;
    function GetReceiveFolderTable(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function StoreLogoff(var lpulFlags: ULONG): HResult; stdcall;
    function AbortSubmit(cbEntryID: ULONG; lpEntryID: PENTRYID; ulFlags: ULONG): HResult; stdcall;
    function GetOutgoingQueue(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function SetLockState(lpMessage: IMessage; ulLockState: ULONG): HResult; stdcall;
    function FinishedMsg(ulFlags: ULONG; cbEntryID: ULONG; lpEntryID: PENTRYID): HResult; stdcall;
    function NotifyNewMail(lpNotification: PNOTIFICATION): HResult; stdcall;
  end;

  IAddrBook = interface(IMAPIProp)
    ['{00020309-0000-0000-C000-000000000046}']
    function OpenEntry(cbEntryID: ULONG; lpEntryID: PENTRYID; const lpInterface: TIID;
                       ulFlags: ULONG; var lpulObjType: ULONG; out lppUnk: IUnknown): HResult; stdcall;
    function CompareEntryIDs(cbEntryID1: ULONG; lpEntryID1: PENTRYID; cbEntryID2: ULONG; lpEntryID2: PENTRYID;
                             ulFlags: ULONG; var lpulResult: ULONG): HResult; stdcall;
    function Advise(cbEntryID: ULONG; lpEntryID: PENTRYID; ulEventMask: ULONG;
                    lpAdviseSink: IMAPIAdviseSink; var lpulConnection: ULONG): HResult; stdcall;
    function Unadvise(ulConnection: ULONG): HResult; stdcall;
    function CreateOneOff(lpszName: PChar; lpszAdrType: PChar; lpszAddress: PChar;
                          ulFlags: ULONG; var lpcbEntryID: ULONG; var lppEntryID: PENTRYID): HResult; stdcall;
    function NewEntry(ulUIParam: ULONG; ulFlags: ULONG; cbEIDContainer: ULONG;
                      lpEIDContainer: PENTRYID; cbEIDNewEntryTpl: ULONG;
                      lpEIDNewEntryTpl: PENTRYID; var lpcbEIDNewEntry: ULONG;
                      var lppEIDNewEntry: PENTRYID): HResult; stdcall;
    function ResolveName(ulUIParam: ULONG; ulFlags: ULONG;
                         lpszNewEntryTitle: PChar; lpAdrList: PADRLIST): HResult; stdcall;
    function Address(var lpulUIParam: ULONG; lpAdrParms: PADRPARM;
                     var lppAdrList: PADRLIST): HResult; stdcall;
    function Details(var lpulUIParam: ULONG; lpfnDismiss: PFNDISMISS; lpvDismissContext: Pointer;
                     cbEntryID: ULONG; lpEntryID: PENTRYID; lpfButtonCallback: PFNBUTTON;
                     lpvButtonContext: Pointer; lpszButtonText: PChar; ulFlags: ULONG): HResult; stdcall;
    function RecipOptions(ulUIParam: ULONG; ulFlags: ULONG; lpRecip: PADRENTRY): HResult; stdcall;
    function QueryDefaultRecipOpt(lpszAdrType: PChar; ulFlags: ULONG;
                                  var lpcValues: ULONG; var lppOptions: PSPropValue): HResult; stdcall;
    function GetPAB(var lpcbEntryID: ULONG; var lppEntryID: PENTRYID): HResult; stdcall;
    function SetPAB(cbEntryID: ULONG; lpEntryID: PENTRYID): HResult; stdcall;
    function GetDefaultDir(var lpcbEntryID: ULONG; var lppEntryID: PENTRYID): HResult; stdcall;
    function SetDefaultDir(cbEntryID: ULONG; lpEntryID: PENTRYID): HResult; stdcall;
    function GetSearchPath(ulFlags: ULONG; var lppSearchPath: PSRowSet): HResult; stdcall;
    function SetSearchPath(ulFlags: ULONG; lpSearchPath: PSRowSet): HResult; stdcall;
    function PrepareRecips(ulFlags: ULONG; lpPropTagArray: PSPropTagArray; lpRecipList: PADRLIST): HResult; stdcall;
  end;

  IProfSect = interface(IMAPIProp)
    ['{00020304-0000-0000-C000-000000000046}']
  end;

  IProviderAdmin = interface(IUnknown)
    ['{00020325-0000-0000-C000-000000000046}']
    function GetLastError(hResult: HResult; ulFlags: ULONG; var lppMAPIError: PMAPIERROR): HResult; stdcall;
    function GetProviderTable(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function CreateProvider(lpszProvider: PChar; cValues: ULONG;
                            lpProps: PSPropValue; ulUIParam: ULONG; ulFlags: ULONG;
                            var lpUID: TMAPIUID): HResult; stdcall;
    function DeleteProvider(lpUID: PMAPIUID): HResult; stdcall;
    function OpenProfileSection(lpUID: PMAPIUID; const lpInterface: TIID;
                                ulFlags: ULONG; var lppProfSect: IProfSect): HResult; stdcall;
  end;

  IMsgServiceAdmin = interface(IUnknown)
    ['{0002031D-0000-0000-C000-000000000046}']
    function GetLastError(hResult: HResult; ulFlags: ULONG; var lppMAPIError: PMAPIERROR): HResult; stdcall;
    function GetMsgServiceTable(ulFlags: ULONG; out lppTable: IMAPITable): HResult; stdcall;
    function CreateMsgService(lpszService: PChar; lpszDisplayName: PChar; ulUIParam: ULONG; ulFlags: ULONG): HResult; stdcall;
    function DeleteMsgService(lpUID: PMAPIUID): HResult; stdcall;
    function CopyMsgService(lpUID: PMAPIUID; lpszDisplayName: PChar; const lpInterfaceToCopy: TIID; const lpInterfaceDst: TIID;
                            lpObjectDst: Pointer; ulUIParam: ULONG; ulFlags: ULONG): HResult; stdcall;
    function RenameMsgService(lpUID: PMAPIUID; ulFlags: ULONG; lpszDisplayName: PChar): HResult; stdcall;
    function ConfigureMsgService(lpUID: PMAPIUID; ulUIParam: ULONG; ulFlags: ULONG; cValues: ULONG; lpProps: PSPropValue): HResult; stdcall;
    function OpenProfileSection(lpUID: PMAPIUID; const lpInterface: TIID; ulFlags: ULONG;
                                out lppProfSect: IProfSect): HResult; stdcall;
    function MsgServiceTransportOrder(cUID: ULONG; lpUIDList: PMAPIUID; ulFlags: ULONG): HResult; stdcall;
    function AdminProviders(lpUID: PMAPIUID; ulFlags: ULONG; out lppProviderAdmin: IProviderAdmin): HResult; stdcall;
    function SetPrimaryIdentity(lpUID: PMAPIUID; ulFlags: ULONG): HResult; stdcall;
    function GetProviderTable(ulFlags: ULONG; out lppTable: IMAPITable): HResult; stdcall;
  end;

  IMAPIContainer = interface(IMAPIProp)
    ['{0002030B-0000-0000-C000-000000000046}']
    function GetContentsTable(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function GetHierarchyTable(ulFlags: ULONG; var lppTable: IMAPITable): HResult; stdcall;
    function OpenEntry(cbEntryID: ULONG; lpEntryID: PENTRYID; const lpInterface: TIID;
                       ulFlags: ULONG; var lpulObjType: ULONG; var lppUnk: IUnknown): HResult; stdcall;
    function SetSearchCriteria(lpRestriction: PSRestriction; lpContainerList: PENTRYLIST; ulSearchFlags: ULONG): HResult; stdcall;
    function GetSearchCriteria(ulFlags: ULONG; var lppRestriction: PSRestriction;
                               var lppContainerList: PENTRYLIST; var lpulSearchState: ULONG): HResult; stdcall;
  end;

  IMAPIFolder = interface(IMAPIContainer)
    ['{0002030C-0000-0000-C000-000000000046}']
    function CreateMessage(const lpInterface: TIID; ulFlags: ULONG; var lppMessage: IMessage): HResult; stdcall;
    function CopyMessages(lpMsgList: PENTRYLIST; const lpInterface: TIID; lpDestFolder: Pointer;
                          ulUIParam: ULONG; lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
    function DeleteMessages(lpMsgList: PENTRYLIST; ulUIParam: ULONG; lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
    function CreateFolder(ulFolderType: ULONG; lpszFolderName: PChar; lpszFolderComment: PChar;
                          const lpInterface: TIID; ulFlags: ULONG; var lppFolder: IMAPIFolder): HResult; stdcall;
    function CopyFolder(cbEntryID: ULONG; lpEntryID: PENTRYID; const lpInterface: TIID;
                        lpDestFolder: Pointer; lpszNewFolderName: PChar; ulUIParam: ULONG;
                        lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
    function DeleteFolder(cbEntryID: ULONG; lpEntryID: PENTRYID; ulUIParam: ULONG;
                          lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
    function SetReadFlags(lpMsgList: PENTRYLIST; ulUIParam: ULONG; lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
    function GetMessageStatus(cbEntryID: ULONG; lpEntryID: PENTRYID; ulFlags: ULONG; var lpulMessageStatus: ULONG): HResult; stdcall;
    function SetMessageStatus(cbEntryID: ULONG; lpEntryID: PENTRYID; ulNewStatus: ULONG;
                              ulNewStatusMask: ULONG; var lpulOldStatus: ULONG): HResult; stdcall;
    function SaveContentsSort(lpSortCriteria: PSSortOrderSet; ulFlags: ULONG): HResult; stdcall;
    function EmptyFolder(ulUIParam: ULONG; lpProgress: IMAPIProgress; ulFlags: ULONG): HResult; stdcall;
  end;

  IMAPISession = interface(IUnknown)
    ['{00020300-0000-0000-C000-000000000046}']
    function GetLastError(hResult: HResult; ulFlags: ULONG; var lppMAPIError: PMAPIERROR): HResult; stdcall;
    function GetMsgStoresTable(ulFlags: ULONG; out lppTable: IMAPITable): HResult; stdcall;
    function OpenMsgStore(ulUIParam: ULONG; cbEntryID: ULONG; lpEntryID: PENTRYID;
                          const lpInterface: TIID; ulFlags: ULONG; out lppMDB: IMsgStore): HResult; stdcall;
    function OpenAddressBook(ulUIParam: ULONG; const lpInterface: PIID;
                             ulFlags: ULONG; out lppAdrBook: IAddrBook): HResult; stdcall;
    function OpenProfileSection(lpUID: PMAPIUID; const lpInterface: TIID;
                                ulFlags: ULONG; out lppProfSect: IProfSect): HResult; stdcall;
    function GetStatusTable(ulFlags: ULONG; out lppTable: IMAPITable): HResult; stdcall;
    function OpenEntry(cbEntryID: ULONG; lpEntryID: PENTRYID; const lpInterface: TIID;
                       ulFlags: ULONG; var lpulObjType: ULONG; out lppUnk: IUnknown): HResult; stdcall;
    function CompareEntryIDs(cbEntryID1: ULONG; lpEntryID1: PENTRYID; cbEntryID2: ULONG; lpEntryID2: PENTRYID;
                             ulFlags: ULONG; var lpulResult: ULONG): HResult; stdcall;
    function Advise(cbEntryID: ULONG; lpEntryID: PENTRYID; ulEventMask: ULONG;
                    lpAdviseSink: IMAPIAdviseSink; var lpulConnection: ULONG): HResult; stdcall;
    function Unadvise(ulConnection: ULONG): HResult; stdcall;
    function MessageOptions(ulUIParam: ULONG; ulFlags: ULONG; lpszAdrType: PChar; lpMessage: IMessage): HResult; stdcall;
    function QueryDefaultMessageOpt(lpszAdrType: PChar; ulFlags: ULONG; var lpcValues: ULONG;
                                    var lppOptions: PSPropValue): HResult; stdcall;
    function EnumAdrTypes(ulFlags: ULONG; var lpcAdrTypes: ULONG; var lpppszAdrTypes: PChar): HResult; stdcall;
    function QueryIdentity(var lpcbEntryID: ULONG; var lppEntryID: PENTRYID): HResult; stdcall;
    function Logoff(ulUIParam: ULONG; ulFlags: ULONG; ulReserved: ULONG): HResult; stdcall;
    function SetDefaultStore(ulFlags: ULONG; cbEntryID: ULONG; lpEntryID: PENTRYID): HResult; stdcall;
    function AdminServices(ulFlags: ULONG; out lppServiceAdmin: IMsgServiceAdmin): HResult; stdcall;
    function ShowForm(ulUIParam: ULONG; lpMsgStore: IMsgStore; lpParentFolder: IMAPIFolder;
                      const lpInterface: TIID; ulMessageToken: ULONG; lpMessageSent: IMessage;
                      ulFlags: ULONG; ulMessageStatus: ULONG; ulMessageFlags: ULONG;
                      ulAccess: ULONG; lpszMessageClass: LPSTR): HResult; stdcall;
    function PrepareForm(const lpInterface: TIID; lpMessage: IMessage;
                         var lpulMessageToken: ULONG): HResult; stdcall;
  end;

  IProfAdmin = interface(IUnknown)
    ['{0002031C-0000-0000-C000-000000000046}']
    function GetLastError(hResult: HResult; ulFlags: ULONG; var lppMAPIError: PMAPIERROR): HResult; stdcall;
    function GetProfileTable(ulFlags: ULONG; out lppTable: IMAPITable): HResult; stdcall;
    function CreateProfile(lpszProfileName: PChar; lpszPassword: PChar; ulUIParam: ULONG; ulFlags: ULONG): HResult; stdcall;
    function DeleteProfile(lpszProfileName: PChar; ulFlags: ULONG): HResult; stdcall;
    function ChangeProfilePassword(lpszProfileName: PChar; lpszOldPassword: PChar; lpszNewPassword: PChar; ulFlags: ULONG): HResult; stdcall;
    function CopyProfile(lpszOldProfileName: PChar; lpszOldPassword: PChar; lpszNewProfileName: PChar; ulUIParam: ULONG; ulFlags: ULONG): HResult; stdcall;
    function RenameProfile(lpszOldProfileName: PChar; lpszOldPassword: PChar; lpszNewProfileName: PChar; ulUIParam: ULONG; ulFlags: ULONG): HResult; stdcall;
    function SetDefaultProfile(lpszProfileName: PChar; ulFlags: ULONG): HResult; stdcall;
    function AdminServices(lpszProfileName: PChar; lpszPassword: PChar; ulUIParam: ULONG; ulFlags: ULONG; out lppServiceAdmin: IMsgServiceAdmin): HResult; stdcall;
  end;

const
  MAPI_LOGON_UI = $00000001;
  MAPI_NEW_SESSION = $00000002;
  MAPI_ALLOW_OTHERS = $00000008;
  MAPI_EXPLICIT_PROFILE = $00000010;
  MAPI_EXTENDED = $00000020;
  MAPI_FORCE_DOWNLOAD = $00001000;
  MAPI_SERVICE_UI_ALWAYS = $00002000;
  MAPI_NO_MAIL = $00008000;

const
  PT_STRING8 = ULONG(30);
  PT_TSTRING = PT_STRING8;
  PT_UNICODE = ULONG(31);
  PT_LONG    = ULONG(3);

  PR_DISPLAY_NAME   = (PT_TSTRING) or (($3001) shl 16);
  PR_DISPLAY_NAME_W = (PT_UNICODE) or (($3001) shl 16);
  PR_RESOURCE_TYPE  = (PT_LONG) or (($3E03) shl 16);

  MAPI_SUBSYSTEM = ULONG(39);
