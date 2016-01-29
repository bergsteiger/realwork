unit ActivDbgLib;

// PASTLWTR : 1.1
// File generated on 1/4/01 10:12:55 AM from Type Library described below.

// ************************************************************************  //
// Type Lib: D:\tp\internet\activdbg.tlb (1)
// LIBID: {8845546B-E265-11D4-A540-00C04F6BB853}
// LCID: 0
// Helpfile: 
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINNT\System32\stdole2.tlb)
//   (2) v4.0 StdVCL, (C:\WINNT\System32\stdvcl40.dll)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
interface

uses Windows, ActiveX, Classes, StdVCL, ascrlib;

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  ActivDbgMajorVersion = 1;
  ActivDbgMinorVersion = 0;

  // jmt.!!! begin constants not in activdbg_tlb
  SOURCETEXT_ATTR_KEYWORD = $1;
  SOURCETEXT_ATTR_COMMENT = $2;

  SOURCETEXT_ATTR_NONSOURCE = $4;

  SOURCETEXT_ATTR_OPERATOR = $8;

  SOURCETEXT_ATTR_NUMBER = $10;
  SOURCETEXT_ATTR_STRING = $20;

  SOURCETEXT_ATTR_FUNCTION_START = $40;

  TEXT_DOC_ATTR_READONLY = $1;

  DEBUG_TEXT_ISEXPRESSION	= $1;

  DEBUG_TEXT_RETURNVALUE = $2;

  DEBUG_TEXT_NOSIDEEFFECTS = $4;

  DEBUG_TEXT_ALLOWBREAKPOINTS = $8;

  DEBUG_TEXT_ALLOWERRORREPORT = $10;
  // jmt.!!! end constants not in activdbg_tlb

  LIBID_ActivDbg: TGUID = '{8845546B-E265-11D4-A540-00C04F6BB853}';

  IID_IActiveScriptDebug: TGUID = '{51973C10-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugCodeContexts: TGUID = '{51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugCodeContext: TGUID = '{51973C13-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentContext: TGUID = '{51973C28-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentInfo: TGUID = '{51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocument: TGUID = '{51973C21-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IActiveScriptSiteDebug: TGUID = '{51973C11-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IRemoteDebugApplication: TGUID = '{51973C30-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplication: TGUID = '{51973C32-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IRemoteDebugApplicationThread: TGUID = '{51973C37-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugStackFrames: TGUID = '{51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugStackFrame: TGUID = '{51973C17-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplicationThread: TGUID = '{51973C38-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugThreadCall: TGUID = '{51973C36-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugProperty: TGUID = '{51973C31-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IApplicationDebugger: TGUID = '{51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IActiveScriptErrorDebug: TGUID = '{51973C12-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumRemoteDebugApplicationThreads: TGUID = '{51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentProvider: TGUID = '{51973C20-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplicationNode: TGUID = '{51973C34-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugApplicationNodes: TGUID = '{51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumDebugExpressionContexts: TGUID = '{51973C40-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugExpressionContext: TGUID = '{51973C15-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugExpression: TGUID = '{51973C14-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugExpressionCallBack: TGUID = '{51973C16-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugSyncOperation: TGUID = '{51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugAsyncOperation: TGUID = '{51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugAsyncOperationCallBack: TGUID = '{51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugStackFrameSniffer: TGUID = '{51973C18-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IProvideExpressionContexts: TGUID = '{51973C41-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugStackFrameSnifferEx: TGUID = '{51973C19-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentText: TGUID = '{51973C22-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentTextEvents: TGUID = '{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentTextAuthor: TGUID = '{51973C24-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentTextExternalAuthor: TGUID = '{51973C25-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentHelper: TGUID = '{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugDocumentHost: TGUID = '{51973C27-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugSessionProvider: TGUID = '{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IApplicationDebuggerUI: TGUID = '{51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IMachineDebugManager: TGUID = '{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IEnumRemoteDebugApplications: TGUID = '{51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IMachineDebugManagerCookie: TGUID = '{51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IMachineDebugManagerEvents: TGUID = '{51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IProcessDebugManager: TGUID = '{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IRemoteDebugApplicationEvents: TGUID = '{51973C33-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugApplicationNodeEvents: TGUID = '{51973C35-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugCookie: TGUID = '{51973C39-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugFormatter: TGUID = '{51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_ISimpleConnectionPoint: TGUID = '{51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}';
  IID_IDebugHelper: TGUID = '{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum tagBREAKPOINT_STATE
type
  tagBREAKPOINT_STATE = TOleEnum;
const
  BREAKPOINT_DELETED = $00000000;
  BREAKPOINT_DISABLED = $00000001;
  BREAKPOINT_ENABLED = $00000002;

// Constants for enum tagBREAKREASON
type
  tagBREAKREASON = TOleEnum;
const
  BREAKREASON_STEP = $00000000;
  BREAKREASON_BREAKPOINT = $00000001;
  BREAKREASON_DEBUGGER_BLOCK = $00000002;
  BREAKREASON_HOST_INITIATED = $00000003;
  BREAKREASON_LANGUAGE_INITIATED = $00000004;
  BREAKREASON_DEBUGGER_HALT = $00000005;
  BREAKREASON_ERROR = $00000006;

// Constants for enum tagBREAKRESUME_ACTION
type
  tagBREAKRESUME_ACTION = TOleEnum;
const
  BREAKRESUMEACTION_ABORT = $00000000;
  BREAKRESUMEACTION_CONTINUE = $00000001;
  BREAKRESUMEACTION_STEP_INTO = $00000002;
  BREAKRESUMEACTION_STEP_OVER = $00000003;
  BREAKRESUMEACTION_STEP_OUT = $00000004;

// Constants for enum tagDOCUMENTNAMETYPE
type
  tagDOCUMENTNAMETYPE = TOleEnum;
const
  DOCUMENTNAMETYPE_APPNODE = $00000000;
  DOCUMENTNAMETYPE_TITLE = $00000001;
  DOCUMENTNAMETYPE_FILE_TAIL = $00000002;
  DOCUMENTNAMETYPE_URL = $00000003;

// Constants for enum tagERRORRESUMEACTION
type
  tagERRORRESUMEACTION = TOleEnum;
const
  ERRORRESUMEACTION_ReexecuteErrorStatement = $00000000;
  ERRORRESUMEACTION_AbortCallAndReturnErrorToCaller = $00000001;
  ERRORRESUMEACTION_SkipErrorStatement = $00000002;

// Constants for enum tagTYPEKIND
type
  tagTYPEKIND = TOleEnum;
const
  TKIND_ENUM = $00000000;
  TKIND_RECORD = $00000001;
  TKIND_MODULE = $00000002;
  TKIND_INTERFACE = $00000003;
  TKIND_DISPATCH = $00000004;
  TKIND_COCLASS = $00000005;
  TKIND_ALIAS = $00000006;
  TKIND_UNION = $00000007;
  TKIND_MAX = $00000008;

// Constants for enum tagDESCKIND
type
  tagDESCKIND = TOleEnum;
const
  DESCKIND_NONE = $00000000;
  DESCKIND_FUNCDESC = $00000001;
  DESCKIND_VARDESC = $00000002;
  DESCKIND_TYPECOMP = $00000003;
  DESCKIND_IMPLICITAPPOBJ = $00000004;
  DESCKIND_MAX = $00000005;

// Constants for enum tagFUNCKIND
type
  tagFUNCKIND = TOleEnum;
const
  FUNC_VIRTUAL = $00000000;
  FUNC_PUREVIRTUAL = $00000001;
  FUNC_NONVIRTUAL = $00000002;
  FUNC_STATIC = $00000003;
  FUNC_DISPATCH = $00000004;

// Constants for enum tagINVOKEKIND
type
  tagINVOKEKIND = TOleEnum;
const
  INVOKE_FUNC = $00000001;
  INVOKE_PROPERTYGET = $00000002;
  INVOKE_PROPERTYPUT = $00000004;
  INVOKE_PROPERTYPUTREF = $00000008;

// Constants for enum tagCALLCONV
type
  tagCALLCONV = TOleEnum;
const
  CC_FASTCALL = $00000000;
  CC_CDECL = $00000001;
  CC_MSCPASCAL = $00000002;
  CC_PASCAL = $00000002;
  CC_MACPASCAL = $00000003;
  CC_STDCALL = $00000004;
  CC_FPFASTCALL = $00000005;
  CC_SYSCALL = $00000006;
  CC_MPWCDECL = $00000007;
  CC_MPWPASCAL = $00000008;
  CC_MAX = $00000009;

// Constants for enum tagVARKIND
type
  tagVARKIND = TOleEnum;
const
  VAR_PERINSTANCE = $00000000;
  VAR_STATIC = $00000001;
  VAR_CONST = $00000002;
  VAR_DISPATCH = $00000003;

// Constants for enum tagSYSKIND
type
  tagSYSKIND = TOleEnum;
const
  SYS_WIN16 = $00000000;
  SYS_WIN32 = $00000001;
  SYS_MAC = $00000002;

// Constants for enum tagSCRIPTSTATE
type
  tagSCRIPTSTATE = TOleEnum;
const
  SCRIPTSTATE_UNINITIALIZED = $00000000;
  SCRIPTSTATE_INITIALIZED = $00000005;
  SCRIPTSTATE_STARTED = $00000001;
  SCRIPTSTATE_CONNECTED = $00000002;
  SCRIPTSTATE_DISCONNECTED = $00000003;
  SCRIPTSTATE_CLOSED = $00000004;

// Constants for enum tagSCRIPTTHREADSTATE
type
  tagSCRIPTTHREADSTATE = TOleEnum;
const
  SCRIPTTHREADSTATE_NOTINSCRIPT = $00000000;
  SCRIPTTHREADSTATE_RUNNING = $00000001;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IActiveScriptDebug = interface;
  IEnumDebugCodeContexts = interface;
  IDebugCodeContext = interface;
  IDebugDocumentContext = interface;
  IDebugDocumentInfo = interface;
  IDebugDocument = interface;
  IActiveScriptSiteDebug = interface;
  IRemoteDebugApplication = interface;
  IDebugApplication = interface;
  IRemoteDebugApplicationThread = interface;
  IEnumDebugStackFrames = interface;
  IDebugStackFrame = interface;
  IDebugApplicationThread = interface;
  IDebugThreadCall = interface;
  IDebugProperty = interface;
  IApplicationDebugger = interface;
  IActiveScriptErrorDebug = interface;
  IEnumRemoteDebugApplicationThreads = interface;
  IDebugDocumentProvider = interface;
  IDebugApplicationNode = interface;
  IEnumDebugApplicationNodes = interface;
  IEnumDebugExpressionContexts = interface;
  IDebugExpressionContext = interface;
  IDebugExpression = interface;
  IDebugExpressionCallBack = interface;
  IDebugSyncOperation = interface;
  IDebugAsyncOperation = interface;
  IDebugAsyncOperationCallBack = interface;
  IDebugStackFrameSniffer = interface;
  IProvideExpressionContexts = interface;
  IDebugStackFrameSnifferEx = interface;
  IDebugDocumentText = interface;
  IDebugDocumentTextEvents = interface;
  IDebugDocumentTextAuthor = interface;
  IDebugDocumentTextExternalAuthor = interface;
  IDebugDocumentHelper = interface;
  IDebugDocumentHost = interface;
  IDebugSessionProvider = interface;
  IApplicationDebuggerUI = interface;
  IMachineDebugManager = interface;
  IEnumRemoteDebugApplications = interface;
  IMachineDebugManagerCookie = interface;
  IMachineDebugManagerEvents = interface;
  IProcessDebugManager = interface;
  IRemoteDebugApplicationEvents = interface;
  IDebugApplicationNodeEvents = interface;
  IDebugCookie = interface;
  IDebugFormatter = interface;
  ISimpleConnectionPoint = interface;
  IDebugHelper = interface;

// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PUserType6 = ^tagTYPEDESC; {*}
  PUserType7 = ^tagARRAYDESC; {*}
  PUserType1 = ^_GUID; {*}
  POleVariant1 = ^OleVariant; {*}
  PUserType2 = ^tagEXCEPINFO; {*}
  PUserType3 = ^tagTYPEATTR; {*}
  PUserType4 = ^tagFUNCDESC; {*}
  PUserType5 = ^tagVARDESC; {*}
  PUserType8 = ^tagTLIBATTR; {*}
  PSmallint1 = ^Smallint; {*}
  PWord1 = ^Word; {*}

  _GUID = packed record
    Data1: LongWord;
    Data2: Word;
    Data3: Word;
    Data4: array[0..7] of Byte;
  end;

  tagDebugStackFrameDescriptor = packed record
    pdsf: IDebugStackFrame;
    dwMin: LongWord;
    dwLim: LongWord;
    fFinal: Integer;
    punkFinal: IUnknown;
  end;

  tagEXCEPINFO = packed record
    wCode: Word;
    wReserved: Word;
    bstrSource: WideString;
    bstrDescription: WideString;
    bstrHelpFile: WideString;
    dwHelpContext: LongWord;
    pvReserved: LongWord;
    pfnDeferredFillIn: LongWord;
    scode: SCODE;
  end;


  __MIDL_IOleAutomationTypes_0005 = record
    case Integer of
      0: (lptdesc: PUserType6);
      1: (lpadesc: PUserType7);
      2: (hreftype: LongWord);
  end;

  tagTYPEDESC = packed record
    __MIDL_0013: __MIDL_IOleAutomationTypes_0005;
    vt: Word;
  end;

  tagSAFEARRAYBOUND = packed record
    cElements: LongWord;
    lLbound: Integer;
  end;

  tagIDLDESC = packed record
    dwReserved: LongWord;
    wIDLFlags: Word;
  end;

  DWORD = LongWord; 

  tagPARAMDESCEX = packed record
    cBytes: LongWord;
    varDefaultValue: OleVariant;
  end;

  tagPARAMDESC = packed record
    pparamdescex: ^tagPARAMDESCEX;
    wParamFlags: Word;
  end;

  tagELEMDESC = packed record
    tdesc: tagTYPEDESC;
    paramdesc: tagPARAMDESC;
  end;

  tagFUNCDESC = packed record
    memid: Integer;
    lprgscode: ^SCODE;
    lprgelemdescParam: ^tagELEMDESC;
    funckind: tagFUNCKIND;
    invkind: tagINVOKEKIND;
    callconv: tagCALLCONV;
    cParams: Smallint;
    cParamsOpt: Smallint;
    oVft: Smallint;
    cScodes: Smallint;
    elemdescFunc: tagELEMDESC;
    wFuncFlags: Word;
  end;

  __MIDL_IOleAutomationTypes_0006 = record
    case Integer of
      0: (oInst: LongWord);
      1: (lpvarValue: ^OleVariant);
  end;

  tagVARDESC = packed record
    memid: Integer;
    lpstrSchema: PWideChar;
    __MIDL_0014: __MIDL_IOleAutomationTypes_0006;
    elemdescVar: tagELEMDESC;
    wVarFlags: Word;
    varkind: tagVARKIND;
  end;

  tagTLIBATTR = packed record
    guid: _GUID;
    lcid: LongWord;
    syskind: tagSYSKIND;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    wLibFlags: Word;
  end;


  tagTYPEATTR = packed record
    guid: _GUID;
    lcid: LongWord;
    dwReserved: LongWord;
    memidConstructor: Integer;
    memidDestructor: Integer;
    lpstrSchema: PWideChar;
    cbSizeInstance: LongWord;
    typekind: tagTYPEKIND;
    cFuncs: Word;
    cVars: Word;
    cImplTypes: Word;
    cbSizeVft: Word;
    cbAlignment: Word;
    wTypeFlags: Word;
    wMajorVerNum: Word;
    wMinorVerNum: Word;
    tdescAlias: tagTYPEDESC;
    idldescType: tagIDLDESC;
  end;

  tagARRAYDESC = packed record
    tdescElem: tagTYPEDESC;
    cDims: Word;
    rgbounds: ^tagSAFEARRAYBOUND;
  end;


// *********************************************************************//
// Interface: IActiveScriptDebug
// Flags:     (0)
// GUID:      {51973C10-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IActiveScriptDebug = interface(IUnknown)
    ['{51973C10-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetScriptTextAttributes {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_31:0}pstrCode: PWideChar;
                                                                           {VT_19:0}uNumCodeChars: LongWord; 
                                                                           {VT_31:0}pstrDelimiter: PWideChar; 
                                                                           {VT_19:0}dwFlags: LongWord; 
                                                                           {VT_18:1}var pattr: Word): HResult; stdcall;
    function  GetScriptletTextAttributes {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_31:0}pstrCode: PWideChar; 
                                                                              {VT_19:0}uNumCodeChars: LongWord; 
                                                                              {VT_31:0}pstrDelimiter: PWideChar; 
                                                                              {VT_19:0}dwFlags: LongWord; 
                                                                              {VT_18:1}var pattr: Word): HResult; stdcall;
    function  EnumCodeContextsOfPosition {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_19:0}dwSourceContext: LongWord; 
                                                                              {VT_19:0}uCharacterOffset: LongWord; 
                                                                              {VT_19:0}uNumChars: LongWord; 
                                                                              {VT_29:2}out ppescc: IEnumDebugCodeContexts): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumDebugCodeContexts
// Flags:     (0)
// GUID:      {51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugCodeContexts = interface(IUnknown)
    ['{51973C1D-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  RemoteNext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord; 
                                                              {VT_29:2}out pscc: IDebugCodeContext; 
                                                              {VT_19:1}out pceltFetched: LongWord): HResult; stdcall;
    function  Skip {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord): HResult; stdcall;
    function  Reset {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Clone {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppescc: IEnumDebugCodeContexts): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugCodeContext
// Flags:     (0)
// GUID:      {51973C13-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugCodeContext = interface(IUnknown)
    ['{51973C13-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDocumentContext {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppsc: IDebugDocumentContext): HResult; stdcall;
    function  SetBreakPoint {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:0}bps: tagBREAKPOINT_STATE): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentContext
// Flags:     (0)
// GUID:      {51973C28-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentContext = interface(IUnknown)
    ['{51973C28-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDocument {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppsd: IDebugDocument): HResult; stdcall;
    function  EnumCodeContexts {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppescc: IEnumDebugCodeContexts): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentInfo
// Flags:     (0)
// GUID:      {51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentInfo = interface(IUnknown)
    ['{51973C1F-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetName {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:0}dnt: tagDOCUMENTNAMETYPE; 
                                                           {VT_8:1}out pbstrName: WideString): HResult; stdcall;
    function  GetDocumentClassId {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}out pclsidDocument: _GUID): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocument
// Flags:     (0)
// GUID:      {51973C21-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocument = interface(IDebugDocumentInfo)
    ['{51973C21-CB0C-11D0-B5C9-00A0244A0E7A}']
  end;

// *********************************************************************//
// Interface: IActiveScriptSiteDebug
// Flags:     (0)
// GUID:      {51973C11-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IActiveScriptSiteDebug = interface(IUnknown)
    ['{51973C11-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDocumentContextFromPosition {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_19:0}dwSourceContext: LongWord;
                                                                                  {VT_19:0}uCharacterOffset: LongWord;
                                                                                  {VT_19:0}uNumChars: LongWord;
                                                                                  {VT_29:2}out ppsc: IDebugDocumentContext): HResult; stdcall;
    function  GetApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppda: IDebugApplication): HResult; stdcall;
    function  GetRootApplicationNode {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppdanRoot: IDebugApplicationNode): HResult; stdcall;
    function  OnScriptErrorDebug {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_29:1}const pErrorDebug: IActiveScriptErrorDebug;
                                                                      {VT_3:1}out pfEnterDebugger: Integer;
                                                                      {VT_3:1}out pfCallOnScriptErrorWhenContinuing: Integer): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRemoteDebugApplication
// Flags:     (0)
// GUID:      {51973C30-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IRemoteDebugApplication = interface(IUnknown)
    ['{51973C30-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  ResumeFromBreakPoint {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_29:1}const prptFocus: IRemoteDebugApplicationThread; 
                                                                        {VT_29:0}bra: tagBREAKRESUME_ACTION; 
                                                                        {VT_29:0}era: tagERRORRESUMEACTION): HResult; stdcall;
    function  CauseBreak {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  ConnectDebugger {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pad: IApplicationDebugger): HResult; stdcall;
    function  DisconnectDebugger {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  GetDebugger {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pad: IApplicationDebugger): HResult; stdcall;
    function  CreateInstanceAtApplication {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_29:1}var rclsid: _GUID; 
                                                                               {VT_13:0}const pUnkOuter: IUnknown; 
                                                                               {VT_19:0}dwClsContext: LongWord; 
                                                                               {VT_29:1}var riid: _GUID; 
                                                                               {VT_13:1}out ppvObject: IUnknown): HResult; stdcall;
    function  QueryAlive {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  EnumThreads {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pperdat: IEnumRemoteDebugApplicationThreads): HResult; stdcall;
    function  GetName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrName: WideString): HResult; stdcall;
    function  GetRootNode {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppdanRoot: IDebugApplicationNode): HResult; stdcall;
    function  EnumGlobalExpressionContexts {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppedec: IEnumDebugExpressionContexts): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugApplication
// Flags:     (0)
// GUID:      {51973C32-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplication = interface(IRemoteDebugApplication)
    ['{51973C32-CB0C-11D0-B5C9-00A0244A0E7A}']
   function  SetName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstrName: PWideChar): HResult; stdcall;
    function  StepOutComplete {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  DebugOutput {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstr: PWideChar): HResult; stdcall;
    function  StartDebugSession {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  HandleBreakPoint {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:0}br: tagBREAKREASON;
                                                                    {VT_29:1}out pbra: tagBREAKRESUME_ACTION): HResult; stdcall;
    function  Close {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  GetBreakFlags {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:1}out pabf: LongWord; 
                                                                 {VT_29:2}out pprdatSteppingThread: IRemoteDebugApplicationThread): HResult; stdcall;
    function  GetCurrentThread {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pat: IDebugApplicationThread): HResult; stdcall;
    function  CreateAsyncDebugOperation {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const psdo: IDebugSyncOperation; 
                                                                             {VT_29:2}out ppado: IDebugAsyncOperation): HResult; stdcall;
    function  AddStackFrameSniffer {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pdsfs: IDebugStackFrameSniffer; 
                                                                        {VT_19:1}out pdwCookie: LongWord): HResult; stdcall;
    function  RemoveStackFrameSniffer {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}dwCookie: LongWord): HResult; stdcall;
    function  QueryCurrentThreadIsDebuggerThread {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  SynchronousCallInDebuggerThread {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_29:1}const pptc: IDebugThreadCall; 
                                                                                   {VT_19:0}dwParam1: LongWord; 
                                                                                   {VT_19:0}dwParam2: LongWord; 
                                                                                   {VT_19:0}dwParam3: LongWord): HResult; stdcall;
    function  CreateApplicationNode {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppdanNew: IDebugApplicationNode): HResult; stdcall;
    function  FireDebuggerEvent {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}var riid: _GUID; 
                                                                     {VT_13:0}const punk: IUnknown): HResult; stdcall;
    function  HandleRuntimeError {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_29:1}const pErrorDebug: IActiveScriptErrorDebug; 
                                                                      {VT_29:1}const pScriptSite: IActiveScriptSite;
                                                                      {VT_29:1}out pbra: tagBREAKRESUME_ACTION; 
                                                                      {VT_29:1}out perra: tagERRORRESUMEACTION; 
                                                                      {VT_3:1}out pfCallOnScriptError: Integer): HResult; stdcall;
    function  FCanJitDebug {Flags(1), (0/0) CC:4, INV:1, DBG:6}: Integer; stdcall;
    function  FIsAutoJitDebugEnabled {Flags(1), (0/0) CC:4, INV:1, DBG:6}: Integer; stdcall;
    function  AddGlobalExpressionContextProvider {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pdsfs: IProvideExpressionContexts; 
                                                                                      {VT_19:1}out pdwCookie: LongWord): HResult; stdcall;
    function  RemoveGlobalExpressionContextProvider {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}dwCookie: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRemoteDebugApplicationThread
// Flags:     (0)
// GUID:      {51973C37-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IRemoteDebugApplicationThread = interface(IUnknown)
    ['{51973C37-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetSystemThreadId {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out dwThreadId: LongWord): HResult; stdcall;
    function  GetApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pprda: IRemoteDebugApplication): HResult; stdcall;
    function  EnumStackFrames {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppedsf: IEnumDebugStackFrames): HResult; stdcall;
    function  GetDescription {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrDescription: WideString; 
                                                                  {VT_8:1}out pbstrState: WideString): HResult; stdcall;
    function  SetNextStatement {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pStackFrame: IDebugStackFrame; 
                                                                    {VT_29:1}const pCodeContext: IDebugCodeContext): HResult; stdcall;
    function  GetState {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out pState: LongWord): HResult; stdcall;
    function  Suspend {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out pdwCount: LongWord): HResult; stdcall;
    function  Resume {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out pdwCount: LongWord): HResult; stdcall;
    function  GetSuspendCount {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out pdwCount: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumDebugStackFrames
// Flags:     (0)
// GUID:      {51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugStackFrames = interface(IUnknown)
    ['{51973C1E-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  RemoteNext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord; 
                                                              {VT_29:1}out prgdsfd: tagDebugStackFrameDescriptor; 
                                                              {VT_19:1}out pceltFetched: LongWord): HResult; stdcall;
    function  Skip {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord): HResult; stdcall;
    function  Reset {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Clone {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppedsf: IEnumDebugStackFrames): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugStackFrame
// Flags:     (0)
// GUID:      {51973C17-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugStackFrame = interface(IUnknown)
    ['{51973C17-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetCodeContext {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppcc: IDebugCodeContext): HResult; stdcall;
    function  GetDescriptionString {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_3:0}fLong: Integer; 
                                                                        {VT_8:1}out pbstrDescription: WideString): HResult; stdcall;
    function  GetLanguageString {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_3:0}fLong: Integer; 
                                                                     {VT_8:1}out pbstrLanguage: WideString): HResult; stdcall;
    function  GetThread {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppat: IDebugApplicationThread): HResult; stdcall;
    function  GetDebugProperty {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppDebugProp: IDebugProperty): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugApplicationThread
// Flags:     (0)
// GUID:      {51973C38-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplicationThread = interface(IRemoteDebugApplicationThread)
    ['{51973C38-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  SynchronousCallIntoThread {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_29:1}const pstcb: IDebugThreadCall; 
                                                                             {VT_19:0}dwParam1: LongWord; 
                                                                             {VT_19:0}dwParam2: LongWord; 
                                                                             {VT_19:0}dwParam3: LongWord): HResult; stdcall;
    function  QueryIsCurrentThread {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  QueryIsDebuggerThread {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  SetDescription {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstrDescription: PWideChar): HResult; stdcall;
    function  SetStateString {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstrState: PWideChar): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugThreadCall
// Flags:     (0)
// GUID:      {51973C36-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugThreadCall = interface(IUnknown)
    ['{51973C36-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  ThreadCallHandler {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}dwParam1: LongWord; 
                                                                     {VT_19:0}dwParam2: LongWord; 
                                                                     {VT_19:0}dwParam3: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugProperty
// Flags:     (0)
// GUID:      {51973C31-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugProperty = interface(IUnknown)
    ['{51973C31-CB0C-11D0-B5C9-00A0244A0E7A}']
  end;

// *********************************************************************//
// Interface: IApplicationDebugger
// Flags:     (0)
// GUID:      {51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IApplicationDebugger = interface(IUnknown)
    ['{51973C2A-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  QueryAlive {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  CreateInstanceAtDebugger {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_29:1}var rclsid: _GUID; 
                                                                            {VT_13:0}const pUnkOuter: IUnknown; 
                                                                            {VT_19:0}dwClsContext: LongWord; 
                                                                            {VT_29:1}var riid: _GUID; 
                                                                            {VT_13:1}out ppvObject: IUnknown): HResult; stdcall;
    function  onDebugOutput {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstr: PWideChar): HResult; stdcall;
    function  onHandleBreakPoint {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_29:1}const prpt: IRemoteDebugApplicationThread; 
                                                                      {VT_29:0}br: tagBREAKREASON; 
                                                                      {VT_29:1}const pError: IActiveScriptErrorDebug): HResult; stdcall;
    function  onClose {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  onDebuggerEvent {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}var riid: _GUID; 
                                                                   {VT_13:0}const punk: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IActiveScriptErrorDebug
// Flags:     (0)
// GUID:      {51973C12-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IActiveScriptErrorDebug = interface(IActiveScriptError)
    ['{51973C12-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDocumentContext {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppssc: IDebugDocumentContext): HResult; stdcall;
    function  GetStackFrame {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppdsf: IDebugStackFrame): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumRemoteDebugApplicationThreads
// Flags:     (0)
// GUID:      {51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumRemoteDebugApplicationThreads = interface(IUnknown)
    ['{51973C3C-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  RemoteNext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord;
                                                              {VT_29:2}out ppdat: IRemoteDebugApplicationThread;
                                                              {VT_19:1}out pceltFetched: LongWord): HResult; stdcall;
    function  Skip {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord): HResult; stdcall;
    function  Reset {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Clone {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pperdat: IEnumRemoteDebugApplicationThreads): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentProvider
// Flags:     (0)
// GUID:      {51973C20-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentProvider = interface(IDebugDocumentInfo)
    ['{51973C20-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDocument {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppssd: IDebugDocument): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugApplicationNode
// Flags:     (0)
// GUID:      {51973C34-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplicationNode = interface(IDebugDocumentProvider)
    ['{51973C34-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  EnumChildren {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pperddp: IEnumDebugApplicationNodes): HResult; stdcall;
    function  GetParent {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pprddp: IDebugApplicationNode): HResult; stdcall;
    function  SetDocumentProvider {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pddp: IDebugDocumentProvider): HResult; stdcall;
    function  Close {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Attach {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pdanParent: IDebugApplicationNode): HResult; stdcall;
    function  Detach {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumDebugApplicationNodes
// Flags:     (0)
// GUID:      {51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugApplicationNodes = interface(IUnknown)
    ['{51973C3A-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  RemoteNext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord; 
                                                              {VT_29:2}out pprddp: IDebugApplicationNode; 
                                                              {VT_19:1}out pceltFetched: LongWord): HResult; stdcall;
    function  Skip {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord): HResult; stdcall;
    function  Reset {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Clone {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out pperddp: IEnumDebugApplicationNodes): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumDebugExpressionContexts
// Flags:     (0)
// GUID:      {51973C40-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumDebugExpressionContexts = interface(IUnknown)
    ['{51973C40-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  RemoteNext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord; 
                                                              {VT_29:2}out pprgdec: IDebugExpressionContext; 
                                                              {VT_19:1}out pceltFetched: LongWord): HResult; stdcall;
    function  Skip {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord): HResult; stdcall;
    function  Reset {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Clone {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppedec: IEnumDebugExpressionContexts): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugExpressionContext
// Flags:     (0)
// GUID:      {51973C15-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugExpressionContext = interface(IUnknown)
    ['{51973C15-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  ParseLanguageText {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_31:0}pstrCode: PWideChar; 
                                                                     {VT_23:0}nRadix: SYSUINT; 
                                                                     {VT_31:0}pstrDelimiter: PWideChar; 
                                                                     {VT_19:0}dwFlags: LongWord; 
                                                                     {VT_29:2}out ppe: IDebugExpression): HResult; stdcall;
    function  GetLanguageInfo {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrLanguageName: WideString; 
                                                                   {VT_29:1}out pLanguageID: _GUID): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugExpression
// Flags:     (0)
// GUID:      {51973C14-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugExpression = interface(IUnknown)
    ['{51973C14-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  Start {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pdecb: IDebugExpressionCallBack): HResult; stdcall;
    function  Abort {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  QueryIsComplete {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  GetResultAsString {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_25:1}out phrResult: HResult; 
                                                                     {VT_8:1}out pbstrResult: WideString): HResult; stdcall;
    function  GetResultAsDebugProperty {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_25:1}out phrResult: HResult; 
                                                                            {VT_29:2}out ppdp: IDebugProperty): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugExpressionCallBack
// Flags:     (0)
// GUID:      {51973C16-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugExpressionCallBack = interface(IUnknown)
    ['{51973C16-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  onComplete {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugSyncOperation
// Flags:     (0)
// GUID:      {51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugSyncOperation = interface(IUnknown)
    ['{51973C1A-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetTargetThread {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppatTarget: IDebugApplicationThread): HResult; stdcall;
    function  Execute {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_13:1}out ppunkResult: IUnknown): HResult; stdcall;
    function  InProgressAbort {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugAsyncOperation
// Flags:     (0)
// GUID:      {51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugAsyncOperation = interface(IUnknown)
    ['{51973C1B-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetSyncDebugOperation {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppsdo: IDebugSyncOperation): HResult; stdcall;
    function  Start {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const padocb: IDebugAsyncOperationCallBack): HResult; stdcall;
    function  Abort {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  QueryIsComplete {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  GetResult {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_25:1}out phrResult: HResult; 
                                                             {VT_13:1}out ppunkResult: IUnknown): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugAsyncOperationCallBack
// Flags:     (0)
// GUID:      {51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugAsyncOperationCallBack = interface(IUnknown)
    ['{51973C1C-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  onComplete {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugStackFrameSniffer
// Flags:     (0)
// GUID:      {51973C18-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugStackFrameSniffer = interface(IUnknown)
    ['{51973C18-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  EnumStackFrames {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppedsf: IEnumDebugStackFrames): HResult; stdcall;
  end;


// *********************************************************************//
// Interface: IProvideExpressionContexts
// Flags:     (0)
// GUID:      {51973C41-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IProvideExpressionContexts = interface(IUnknown)
    ['{51973C41-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  EnumExpressionContexts {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppedec: IEnumDebugExpressionContexts): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugStackFrameSnifferEx
// Flags:     (0)
// GUID:      {51973C19-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugStackFrameSnifferEx = interface(IDebugStackFrameSniffer)
    ['{51973C19-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  EnumStackFramesEx {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}dwSpMin: LongWord; 
                                                                     {VT_29:2}out ppedsf: IEnumDebugStackFrames): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentText
// Flags:     (0)
// GUID:      {51973C22-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentText = interface(IDebugDocument)
    ['{51973C22-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDocumentAttributes {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out ptextdocattr: LongWord): HResult; stdcall;
    function  GetSize {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:1}out pcNumLines: LongWord; 
                                                           {VT_19:1}out pcNumChars: LongWord): HResult; stdcall;
    function  GetPositionOfLine {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cLineNumber: LongWord; 
                                                                     {VT_19:1}out pcCharacterPosition: LongWord): HResult; stdcall;
    function  GetLineOfPosition {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                                     {VT_19:1}out pcLineNumber: LongWord; 
                                                                     {VT_19:1}out pcCharacterOffsetInLine: LongWord): HResult; stdcall;
    function  GetText {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                           {VT_2:1}var pcharText: Smallint; 
                                                           {VT_18:1}var pstaTextAttr: Word; 
                                                           {VT_19:1}var pcNumChars: LongWord; 
                                                           {VT_19:0}cMaxChars: LongWord): HResult; stdcall;
    function  GetPositionOfContext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_29:1}const psc: IDebugDocumentContext; 
                                                                        {VT_19:1}out pcCharacterPosition: LongWord; 
                                                                        {VT_19:1}out cNumChars: LongWord): HResult; stdcall;
    function  GetContextOfPosition {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                                        {VT_19:0}cNumChars: LongWord; 
                                                                        {VT_29:2}out ppsc: IDebugDocumentContext): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentTextEvents
// Flags:     (0)
// GUID:      {51973C23-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentTextEvents = interface(IUnknown)
    ['{51973C23-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  onDestroy {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  onInsertText {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                                {VT_19:0}cNumToInsert: LongWord): HResult; stdcall;
    function  onRemoveText {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                                {VT_19:0}cNumToRemove: LongWord): HResult; stdcall;
    function  onReplaceText {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                                 {VT_19:0}cNumToReplace: LongWord): HResult; stdcall;
    function  onUpdateTextAttributes {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                                          {VT_19:0}cNumToUpdate: LongWord): HResult; stdcall;
    function  onUpdateDocumentAttributes {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}textdocattr: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentTextAuthor
// Flags:     (0)
// GUID:      {51973C24-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentTextAuthor = interface(IDebugDocumentText)
    ['{51973C24-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  InsertText {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                              {VT_19:0}cNumToInsert: LongWord; 
                                                              {VT_2:1}var pcharText: Smallint): HResult; stdcall;
    function  RemoveText {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                              {VT_19:0}cNumToRemove: LongWord): HResult; stdcall;
    function  ReplaceText {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}cCharacterPosition: LongWord; 
                                                               {VT_19:0}cNumToReplace: LongWord; 
                                                               {VT_2:1}var pcharText: Smallint): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentTextExternalAuthor
// Flags:     (0)
// GUID:      {51973C25-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentTextExternalAuthor = interface(IUnknown)
    ['{51973C25-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetPathName {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrLongName: WideString; 
                                                               {VT_3:1}out pfIsOriginalFile: Integer): HResult; stdcall;
    function  GetFileName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrShortName: WideString): HResult; stdcall;
    function  NotifyChanged {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentHelper
// Flags:     (0)
// GUID:      {51973C26-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentHelper = interface(IUnknown)
    ['{51973C26-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  Init {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IDebugApplication; 
                                                        {VT_31:0}pszShortName: PWideChar; 
                                                        {VT_31:0}pszLongName: PWideChar; 
                                                        {VT_19:0}docAttr: LongWord): HResult; stdcall;
    function  Attach {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pddhParent: IDebugDocumentHelper): HResult; stdcall;
    function  Detach {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  AddUnicodeText {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pszText: PWideChar): HResult; stdcall;
    function  AddDBCSText {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_30:0}pszText: PChar): HResult; stdcall;
    function  SetDebugDocumentHost {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pddh: IDebugDocumentHost): HResult; stdcall;
    function  AddDeferredText {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}cChars: LongWord; 
                                                                   {VT_19:0}dwTextStartCookie: LongWord): HResult; stdcall;
    function  DefineScriptBlock {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_19:0}ulCharOffset: LongWord; 
                                                                     {VT_19:0}cChars: LongWord; 
                                                                     {VT_29:1}const pas: IActiveScript; 
                                                                     {VT_3:0}fScriptlet: Integer; 
                                                                     {VT_19:1}out pdwSourceContext: LongWord): HResult; stdcall;
    function  SetDefaultTextAttr {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_18:0}staTextAttr: Word): HResult; stdcall;
    function  SetTextAttributes {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}ulCharOffset: LongWord; 
                                                                     {VT_19:0}cChars: LongWord; 
                                                                     {VT_18:1}var pstaTextAttr: Word): HResult; stdcall;
    function  SetLongName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pszLongName: PWideChar): HResult; stdcall;
    function  SetShortName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pszShortName: PWideChar): HResult; stdcall;
    function  SetDocumentAttr {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}pszAttributes: LongWord): HResult; stdcall;
    function  GetDebugApplicationNode {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppdan: IDebugApplicationNode): HResult; stdcall;
    function  GetScriptBlockInfo {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_19:0}dwSourceContext: LongWord; 
                                                                      {VT_29:2}out ppasd: IActiveScript; 
                                                                      {VT_19:1}out piCharPos: LongWord; 
                                                                      {VT_19:1}out pcChars: LongWord): HResult; stdcall;
    function  CreateDebugDocumentContext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}iCharPos: LongWord; 
                                                                              {VT_19:0}cChars: LongWord; 
                                                                              {VT_29:2}out ppddc: IDebugDocumentContext): HResult; stdcall;
    function  BringDocumentToTop {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  BringDocumentContextToTop {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pddc: IDebugDocumentContext): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugDocumentHost
// Flags:     (0)
// GUID:      {51973C27-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugDocumentHost = interface(IUnknown)
    ['{51973C27-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetDeferredText {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_19:0}dwTextStartCookie: LongWord; 
                                                                   {VT_2:1}var pcharText: Smallint; 
                                                                   {VT_18:1}var pstaTextAttr: Word; 
                                                                   {VT_19:1}var pcNumChars: LongWord; 
                                                                   {VT_19:0}cMaxChars: LongWord): HResult; stdcall;
    function  GetScriptTextAttributes {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_31:0}pstrCode: PWideChar; 
                                                                           {VT_19:0}uNumCodeChars: LongWord; 
                                                                           {VT_31:0}pstrDelimiter: PWideChar; 
                                                                           {VT_19:0}dwFlags: LongWord; 
                                                                           {VT_18:1}var pattr: Word): HResult; stdcall;
    function  OnCreateDocumentContext {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_13:1}out ppunkOuter: IUnknown): HResult; stdcall;
    function  GetPathName {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrLongName: WideString; 
                                                               {VT_3:1}out pfIsOriginalFile: Integer): HResult; stdcall;
    function  GetFileName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_8:1}out pbstrShortName: WideString): HResult; stdcall;
    function  NotifyChanged {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugSessionProvider
// Flags:     (0)
// GUID:      {51973C29-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugSessionProvider = interface(IUnknown)
    ['{51973C29-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  StartDebugSession {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IRemoteDebugApplication): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IApplicationDebuggerUI
// Flags:     (0)
// GUID:      {51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IApplicationDebuggerUI = interface(IUnknown)
    ['{51973C2B-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  BringDocumentToTop {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pddt: IDebugDocumentText): HResult; stdcall;
    function  BringDocumentContextToTop {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pddc: IDebugDocumentContext): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMachineDebugManager
// Flags:     (0)
// GUID:      {51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IMachineDebugManager = interface(IUnknown)
    ['{51973C2C-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  AddApplication {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IRemoteDebugApplication; 
                                                                  {VT_19:1}out pdwAppCookie: LongWord): HResult; stdcall;
    function  RemoveApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}dwAppCookie: LongWord): HResult; stdcall;
    function  EnumApplications {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppeda: IEnumRemoteDebugApplications): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IEnumRemoteDebugApplications
// Flags:     (0)
// GUID:      {51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IEnumRemoteDebugApplications = interface(IUnknown)
    ['{51973C3B-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  RemoteNext {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord; 
                                                              {VT_29:2}out ppda: IRemoteDebugApplication; 
                                                              {VT_19:1}out pceltFetched: LongWord): HResult; stdcall;
    function  Skip {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}celt: LongWord): HResult; stdcall;
    function  Reset {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  Clone {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppessd: IEnumRemoteDebugApplications): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMachineDebugManagerCookie
// Flags:     (0)
// GUID:      {51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IMachineDebugManagerCookie = interface(IUnknown)
    ['{51973C2D-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  AddApplication {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IRemoteDebugApplication; 
                                                                  {VT_19:0}dwDebugAppCookie: LongWord; 
                                                                  {VT_19:1}out pdwAppCookie: LongWord): HResult; stdcall;
    function  RemoveApplication {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}dwDebugAppCookie: LongWord; 
                                                                     {VT_19:0}dwAppCookie: LongWord): HResult; stdcall;
    function  EnumApplications {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppeda: IEnumRemoteDebugApplications): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IMachineDebugManagerEvents
// Flags:     (0)
// GUID:      {51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IMachineDebugManagerEvents = interface(IUnknown)
    ['{51973C2E-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  onAddApplication {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IRemoteDebugApplication; 
                                                                    {VT_19:0}dwAppCookie: LongWord): HResult; stdcall;
    function  onRemoveApplication {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IRemoteDebugApplication; 
                                                                       {VT_19:0}dwAppCookie: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IProcessDebugManager
// Flags:     (0)
// GUID:      {51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IProcessDebugManager = interface(IUnknown)
    ['{51973C2F-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  CreateApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppda: IDebugApplication): HResult; stdcall;
    function  GetDefaultApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:2}out ppda: IDebugApplication): HResult; stdcall;
    function  AddApplication {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_29:1}const pda: IDebugApplication; 
                                                                  {VT_19:1}out pdwAppCookie: LongWord): HResult; stdcall;
    function  RemoveApplication {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}dwAppCookie: LongWord): HResult; stdcall;
    function  CreateDebugDocumentHelper {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_13:0}const pUnkOuter: IUnknown; 
                                                                             {VT_29:2}out pddh: IDebugDocumentHelper): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IRemoteDebugApplicationEvents
// Flags:     (0)
// GUID:      {51973C33-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IRemoteDebugApplicationEvents = interface(IUnknown)
    ['{51973C33-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  OnConnectDebugger {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const pad: IApplicationDebugger): HResult; stdcall;
    function  OnDisconnectDebugger {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  OnSetName {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstrName: PWideChar): HResult; stdcall;
    function  onDebugOutput {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_31:0}pstr: PWideChar): HResult; stdcall;
    function  onClose {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  OnEnterBreakPoint {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prdat: IRemoteDebugApplicationThread): HResult; stdcall;
    function  OnLeaveBreakPoint {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prdat: IRemoteDebugApplicationThread): HResult; stdcall;
    function  OnCreateThread {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prdat: IRemoteDebugApplicationThread): HResult; stdcall;
    function  OnDestroyThread {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prdat: IRemoteDebugApplicationThread): HResult; stdcall;
    function  OnBreakFlagChange {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_19:0}abf: LongWord; 
                                                                     {VT_29:1}const prdatSteppingThread: IRemoteDebugApplicationThread): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugApplicationNodeEvents
// Flags:     (0)
// GUID:      {51973C35-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugApplicationNodeEvents = interface(IUnknown)
    ['{51973C35-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  onAddChild {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prddpChild: IDebugApplicationNode): HResult; stdcall;
    function  onRemoveChild {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prddpChild: IDebugApplicationNode): HResult; stdcall;
    function  onDetach {Flags(1), (0/0) CC:4, INV:1, DBG:6}: HResult; stdcall;
    function  onAttach {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_29:1}const prddpParent: IDebugApplicationNode): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugCookie
// Flags:     (0)
// GUID:      {51973C39-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugCookie = interface(IUnknown)
    ['{51973C39-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  SetDebugCookie {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}dwDebugAppCookie: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugFormatter
// Flags:     (0)
// GUID:      {51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugFormatter = interface(IUnknown)
    ['{51973C3D-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetStringForVariant {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_12:1}var pvar: OleVariant; 
                                                                       {VT_8:1}out pbstrValue: WideString): HResult; stdcall;
    function  GetVariantForString {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_31:0}pwstrValue: PWideChar; 
                                                                       {VT_12:1}out pvar: OleVariant): HResult; stdcall;
    function  GetStringForVarType {Flags(1), (3/3) CC:4, INV:1, DBG:6}({VT_18:0}vt: Word; 
                                                                       {VT_29:1}var ptdescArrayType: tagTYPEDESC; 
                                                                       {VT_8:1}out pbstr: WideString): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: ISimpleConnectionPoint
// Flags:     (0)
// GUID:      {51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  ISimpleConnectionPoint = interface(IUnknown)
    ['{51973C3E-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  GetEventCount {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:1}out pulCount: LongWord): HResult; stdcall;
    function  DescribeEvents {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_19:0}iEvent: LongWord; 
                                                                  {VT_19:0}cEvents: LongWord; 
                                                                  {VT_3:1}out prgid: Integer; 
                                                                  {VT_8:1}out prgbstr: WideString; 
                                                                  {VT_19:1}out pcEventsFetched: LongWord): HResult; stdcall;
    function  Advise {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_9:0}const pdisp: IDispatch; 
                                                          {VT_19:1}out pdwCookie: LongWord): HResult; stdcall;
    function  Unadvise {Flags(1), (1/1) CC:4, INV:1, DBG:6}({VT_19:0}dwCookie: LongWord): HResult; stdcall;
  end;

// *********************************************************************//
// Interface: IDebugHelper
// Flags:     (0)
// GUID:      {51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}
// *********************************************************************//
  IDebugHelper = interface(IUnknown)
    ['{51973C3F-CB0C-11D0-B5C9-00A0244A0E7A}']
    function  CreatePropertyBrowser {Flags(1), (4/4) CC:4, INV:1, DBG:6}({VT_12:1}var pvar: OleVariant; 
                                                                         {VT_31:0}bstrName: PWideChar; 
                                                                         {VT_29:1}const pdat: IDebugApplicationThread; 
                                                                         {VT_29:2}out ppdob: IDebugProperty): HResult; stdcall;
    function  CreatePropertyBrowserEx {Flags(1), (5/5) CC:4, INV:1, DBG:6}({VT_12:1}var pvar: OleVariant; 
                                                                           {VT_31:0}bstrName: PWideChar; 
                                                                           {VT_29:1}const pdat: IDebugApplicationThread; 
                                                                           {VT_29:1}const pdf: IDebugFormatter; 
                                                                           {VT_29:2}out ppdob: IDebugProperty): HResult; stdcall;
    function  CreateSimpleConnectionPoint {Flags(1), (2/2) CC:4, INV:1, DBG:6}({VT_9:0}const pdisp: IDispatch; 
                                                                               {VT_29:2}out ppscp: ISimpleConnectionPoint): HResult; stdcall;
  end;

implementation

uses ComObj;

end.
