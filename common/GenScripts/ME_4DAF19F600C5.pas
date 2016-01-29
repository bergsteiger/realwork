unit tfwScriptingInterfaces;

interface

uses
 l3IntfUses
 , tfwTypeInfo
 , tfwScriptingTypes
 , l3Interfaces
 , l3EtalonsWorking
 , tfwScriptingExceptions
 , l3ProtoObject
 , TypInfo
 , tfwValueTypes
 , tfwCStringFactory
 , tfwParserInterfaces
 , SysUtils
 , tfwStreamFactory
 , l3Variant
 , tfwKeyWordPrim
 , tfwDictionaryPrim
 , l3Types
 , Types
 , l3PureMixIns
;

 (*
 ScriptCaller = interface
  procedure Check(aCondition: Boolean;
   const aMessage: AnsiString);
   {* Проверяет инвариант }
  procedure Print(const aStr: Tl3WString); overload;
  procedure Print(const aStr: Il3CString); overload;
 end;//ScriptCaller
 *)
 
 (*
 PrintingCaller = interface
  function GetIsWritingToK: Boolean;
  function GetIsFakeCVS: Boolean;
  function GetCVSPath: AnsiString;
  procedure DontRaiseIfEtalonCreated;
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString);
  function GetTestSetFolderName: AnsiString;
  function GetEtalonSuffix: AnsiString;
  procedure CheckPrintEtalon(const aLogName: AnsiString;
   const aOutputName: AnsiString);
  function ShouldStop: Boolean;
  procedure CheckTimeout(aNow: Cardinal;
   aTimeout: Cardinal);
  function StartTimer: Longword;
  function StopTimer(const aSt: AnsiString;
   const aSubName: AnsiString;
   aNeedTimeToLog: Boolean): Longword;
 end;//PrintingCaller
 *)
 
type
 ItfwScriptCaller = interface
  function CompileOnly: Boolean;
  function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
  function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
  function KPage: AnsiString;
  procedure ToLog(const aSt: AnsiString);
  procedure Check(aCondition: Boolean;
   const aMessage: AnsiString);
   {* Проверяет инвариант }
  procedure Print(const aStr: Tl3WString); overload;
  procedure Print(const aStr: Il3CString); overload;
  function GetIsWritingToK: Boolean;
  function GetIsFakeCVS: Boolean;
  function GetCVSPath: AnsiString;
  procedure DontRaiseIfEtalonCreated;
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString);
  function GetTestSetFolderName: AnsiString;
  function GetEtalonSuffix: AnsiString;
  procedure CheckPrintEtalon(const aLogName: AnsiString;
   const aOutputName: AnsiString);
  function ShouldStop: Boolean;
  procedure CheckTimeout(aNow: Cardinal;
   aTimeout: Cardinal);
  function StartTimer: Longword;
  function StopTimer(const aSt: AnsiString;
   const aSubName: AnsiString;
   aNeedTimeToLog: Boolean): Longword;
  procedure CheckOutputWithInput(const aIn: AnsiString;
   const aOut: AnsiString;
   aHeaderBegin: AnsiChar;
   aEtalonNeedsComputerName: Boolean;
   aEtalonCanHaveDiff: Boolean;
   const anExtraFileName: AnsiString;
   aNeedsCheck: Boolean); overload;
  procedure CheckOutputWithInput(const aSt: AnsiString;
   aHeaderBegin: AnsiChar;
   const anExtraFileName: AnsiString;
   aNeedsCheck: Boolean); overload;
  procedure CheckPictureOnly;
  procedure CheckWithEtalon(const aFileName: AnsiString;
   aHeaderBegin: AnsiChar);
 end;//ItfwScriptCaller
 
 EtfwCodeFlowException = class(EtfwException)
 end;//EtfwCodeFlowException
 
 EtfwCodeFlowError = class(EtfwCodeFlowException)
 end;//EtfwCodeFlowError
 
 TtfwSuppressNextImmediate = (
  tfw_sniNo
  , tfw_sniYes
  , tfw_sniForce
 );//TtfwSuppressNextImmediate
 
 (*
 MtfwValueList = interface
  procedure Clear;
 end;//MtfwValueList
 *)
 
 TtfwSourcePoint = object
  {* Место в исходниках }
 end;//TtfwSourcePoint
 
 TtfwAccessType = tfwScriptingTypes.TtfwAccessType;
 
 EtfwScriptException = class(EtfwException)
  {* Исключение кидаемое скриптом }
 end;//EtfwScriptException
 
 TtfwLinkType = tfwScriptingTypes.TtfwLinkType;
 
 TtfwWordInfo = class(Tl3ProtoObject)
  {* Информация о типе }
  function IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo;
  function Empty: Boolean;
  function Has(aModifier: TtfwWordModifier): Boolean; overload;
  function Clone: TtfwWordInfo;
  function pRec: PtfwWordInfoRec;
  function IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo;
  function Has(aType: TtfwValueType): Boolean; overload;
  function AcceptsValue(const aValue: TtfwStackValue): Boolean;
  function Make(const aTypeInfoRec: TtfwWordInfoRec): TtfwWordInfo; overload;
  function Make(aTypeInfo: PTypeInfo): TtfwWordInfo; overload;
  function Has(anAccess: TtfwAccessType): Boolean; overload;
  function IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo;
  function Make(aTypes: TtfwValueTypes;
   aModifiers: TtfwWordModifiers;
   anAccess: TtfwAccessType;
   aLinkType: TtfwLinkType): TtfwWordInfo; overload;
  function EQwm(aValue: TtfwWordModifiers): Boolean;
  function IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo;
  function TypeName: Il3CString;
  function Make(const aType: TtfwTypeInfo): TtfwWordInfo; overload;
  function ValueTypes: TtfwValueTypes;
  function IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo;
  function Has(aLinkType: TtfwLinkType): Boolean; overload;
  function LinkType: TtfwLinkType;
  function AccessType: TtfwAccessType;
  function Compare(anOther: TtfwWordInfo): Integer;
  function Modifiers: TtfwWordModifiers;
  function ToString: Il3CString;
 end;//TtfwWordInfo
 
 EtfwExitOrBreak = class(EtfwCodeFlowException)
  procedure Create(const aMessage: AnsiString); overload;
  procedure Create; overload;
 end;//EtfwExitOrBreak
 
 EtfwContinue = class(EtfwExitOrBreak)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//EtfwContinue
 
 EtfwExit = class(EtfwExitOrBreak)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//EtfwExit
 
 EtfwHalt = class(EtfwExitOrBreak)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//EtfwHalt
 
 TtfwStackValue = tfwTypeInfo.TtfwStackValue;
 
 TtfwCStringFactory = tfwCStringFactory.TtfwCStringFactory;
 
 TtfwWordInfoArray = array of TtfwWordInfo;
 
 TtfwWord = class;
 
 TtfwKeyWord = class;
 
 ItfwScriptEngine = interface;
 
 ItfwStoredValuesStack = interface;
 
 TtfwContext = object
 end;//TtfwContext
 
 TtfwWordPrim = class(Tl3ProtoObject)
  function IsCompiled: Boolean;
  procedure StoreState(const aCtx: TtfwContext);
  procedure RestoreState(const aCtx: TtfwContext);
  procedure DoIt(const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
  procedure ClearState(const aCtx: TtfwContext);
  function SourcePoint: TtfwSourcePoint;
  procedure PushAdditionalParams(const aCtx: TtfwContext);
 end;//TtfwWordPrim
 
 (*
 MtfwKeywordFinderSource = interface
  function KeywordFinder(const aCtx: TtfwContext): TtfwWord;
 end;//MtfwKeywordFinderSource
 *)
 
 (*
 MtfwInParameterDefinitor = interface
  function DefineInParameter(const aCtx: TtfwContext;
   const aParamName: Il3CString;
   aStereo: TtfwWord;
   aTypeInfo: TtfwWordInfo): TtfwWord;
 end;//MtfwInParameterDefinitor
 *)
 
 (*
 MtfwWordChecker = interface
  function CheckWord(const aName: Il3CString): TtfwKeyWord;
 end;//MtfwWordChecker
 *)
 
 EtfwBreakIterator = class(EtfwExitOrBreak)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//EtfwBreakIterator
 
 (*
 MtfwNewWordDefinitor = interface(MtfwKeywordFinderSource)
 end;//MtfwNewWordDefinitor
 *)
 
 (*
 MtfwCodeCompiler = interface
  procedure AddCodePart(aWord: TtfwWord;
   const aCtx: TtfwContext;
   aSNI: TtfwSuppressNextImmediate);
   {* Добавляет скомпилированный код к текущему компилируемуму слову }
 end;//MtfwCodeCompiler
 *)
 
 (*
 MtfwNewWordDefinitorSource = interface
  function NewWordDefinitor: TtfwWord;
 end;//MtfwNewWordDefinitorSource
 *)
 
 (*
 MtfwCompiler = interface(MtfwKeywordFinderSource)
  procedure CompileInParameterPopCode(const aContext: TtfwContext;
   aParameterToPop: TtfwWord);
   {* Компилирует код извлечения входного параметра в код компилируемого слова }
 end;//MtfwCompiler
 *)
 
 (*
 MtfwKeywordFinder = interface
  function KeywordByName(const aName: Il3CString): Tl3PrimString;
  function ParentFinder: TtfwWord;
 end;//MtfwKeywordFinder
 *)
 
 EtfwCompiler = class(EtfwCheck)
 end;//EtfwCompiler
 
 EtfwRunner = class(EtfwCheck)
 end;//EtfwRunner
 
 PTypeInfoArray = array of PTypeInfo;
 
 RtfwWord = class of TtfwWord;
 
 TtfwWord = class(TtfwWordPrim)
  {* Элемент словаря }
  function IsDefaultBranch: Boolean;
  procedure RunnerAssert(aCondition: Boolean;
   const aMessage: AnsiString;
   const aContext: TtfwContext);
  function IsAnonimous(const aCtx: TtfwContext): Boolean;
  procedure CompilerAssertFmt(aCondition: Boolean;
   const aMessage: AnsiString;
   const aParams: array of const;
   const aContext: TtfwContext);
  procedure RunnerAssertFmt(aCondition: Boolean;
   const aMessage: AnsiString;
   const aParams: array of const;
   const aContext: TtfwContext);
  function CompiledWordClassPrim(const aCtx: TtfwContext): RtfwWord;
  function IsForwardDeclaration: Boolean;
  function GetValue(const aCtx: TtfwContext): PtfwStackValue;
  function IsVarLike: Boolean;
  procedure SetValuePrim(const aValue: TtfwStackValue;
   const aCtx: TtfwContext);
  function HasCode: Boolean;
   {* Есть ли у слова компилированный код }
  function HasLocalDictionary: Boolean;
   {* Есть ли у слова локальный словарь }
  function CodeCount: Integer;
   {* Число элементов скомпилированного кода }
  function GetCompiler(const aCtx: TtfwContext): TtfwWord;
  function DoDefineInParameter(const aCtx: TtfwContext;
   const aParamName: Il3CString;
   aStereo: TtfwWord;
   aTypeInfo: TtfwWordInfo): TtfwWord;
   {* Определяет слову входной параметр }
  procedure CompileInParameterPopCodeFromString(const aContext: TtfwContext;
   const aParameterToPop: Il3CString);
  procedure DoAddCodePart(aWord: TtfwWord;
   const aCtx: TtfwContext;
   aSNI: TtfwSuppressNextImmediate);
  function IsCloseBracket: Boolean;
  function GetEndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
  function NameForRegister: AnsiString;
  function AcceptMedianBracket(aBracket: TtfwWord;
   var aCtx: TtfwContext): Boolean;
  function GetAsCaller(const aCtx: TtfwContext): TtfwWord;
  function IsRightParam(const aCtx: TtfwContext): Boolean;
  function RightParamsCount(const aCtx: TtfwContext): Integer;
  function GetInParam(const aCtx: TtfwContext;
   anIndex: Integer): TtfwWord;
  procedure SetResultTypeInfo(aValue: TtfwWordInfo;
   const aCtx: TtfwContext);
  function IsLeftWordRefParam(const aCtx: TtfwContext): Boolean;
  procedure RegisterClass;
  function LeftWordRefParamsCount(const aCtx: TtfwContext): Integer;
  procedure AddLeftWordRefValue(const aCtx: TtfwContext;
   aValue: TtfwWord);
  function GetLeftWordRefValue(const aCtx: TtfwContext;
   anIndex: Integer): TtfwWord;
  function LeftWordRefValuesCount(const aCtx: TtfwContext): Integer;
  procedure RunnerError(const aMessage: AnsiString;
   const aContext: TtfwContext);
  function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
  procedure BadValueType(aType: TtfwValueType;
   const aCtx: TtfwContext);
  function GetRightParam(const aCtx: TtfwContext;
   anIndex: Integer): TtfwWord;
  function GetResultVar(const aCtx: TtfwContext): TtfwWord;
  procedure Create;
  function GetRef(const aCtx: TtfwContext): TtfwWord;
  function GetAllParamsCount(const aCtx: TtfwContext): Integer;
  function CanClearInRecursiveCalls: Boolean;
  function IsInParam: Boolean;
  procedure InitValue(const aCtx: TtfwContext);
  function GetNewWordDefinitor: TtfwWord;
  function GetKeywordFinder(const aCtx: TtfwContext): TtfwWord;
  procedure DoCompileInParameterPopCode(const aContext: TtfwContext;
   aParameterToPop: TtfwWord;
   aCheckCode: Boolean);
  function DoCheckWord(const aName: Il3CString): TtfwKeyWord;
  function GetKeywordByName(const aName: Il3CString): Tl3PrimString;
  function GetParentFinder: TtfwWord;
  function WordName: Il3CString;
  function IsForHelp: Boolean;
  function MakeRefForCompile(const aCtx: TtfwContext;
   aSNI: TtfwSuppressNextImmediate): TtfwWord;
  procedure SetValue(const aValue: TtfwStackValue;
   const aCtx: TtfwContext);
  function IsCompleted(const aCtx: TtfwContext): Boolean;
  function IsImmediate(const aCtx: TtfwContext): Boolean;
  procedure CompilerAssert(aCondition: Boolean;
   const aMessage: AnsiString;
   const aContext: TtfwContext);
  function ParamsTypes: PTypeInfoArray;
  function OpenTypesToTypes(const aTypes: array of PTypeInfo): PTypeInfoArray;
  function ParamsInfos: TtfwWordInfoArray;
  function IsGlobalVar: Boolean;
  procedure AddCodePart(aWord: TtfwWord;
   const aCtx: TtfwContext;
   aSNI: TtfwSuppressNextImmediate);
   {* Добавляет скомпилированный код к текущему компилируемуму слову }
  procedure CompileInParameterPopCode(const aContext: TtfwContext;
   aParameterToPop: TtfwWord);
   {* Компилирует код извлечения входного параметра в код компилируемого слова }
  function CheckWord(const aName: Il3CString): TtfwKeyWord;
  function DefineInParameter(const aCtx: TtfwContext;
   const aParamName: Il3CString;
   aStereo: TtfwWord;
   aTypeInfo: TtfwWordInfo): TtfwWord;
  function NewWordDefinitor: TtfwWord;
  function KeywordFinder(const aCtx: TtfwContext): TtfwWord;
  function KeywordByName(const aName: Il3CString): Tl3PrimString;
  function ParentFinder: TtfwWord;
 end;//TtfwWord
 
 TtfwKeyWord = class(TtfwKeyWordPrim)
  procedure Create(aDictionary: TtfwDictionaryPrim;
   const aKeyword: AnsiString;
   aWord: TtfwWord); overload;
  procedure Create(aDictionary: TtfwDictionaryPrim;
   const aKeyword: Tl3WString); overload;
  procedure Create(aDictionary: TtfwDictionaryPrim;
   const aKeyword: Il3CString); overload;
  procedure ChangeDictionary(aValue: TtfwDictionaryPrim);
  procedure SetWord(const aCtx: TtfwContext;
   aWord: TtfwWord);
 end;//TtfwKeyWord
 
 EtfwBreak = class(EtfwExitOrBreak)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//EtfwBreak
 
 EtfwFail = class(EtfwCheck)
 end;//EtfwFail
 
 EtfwManualBreak = class(EtfwScriptException)
 end;//EtfwManualBreak
 
 ItfwValueList = interface;
 
 ItfwFile = interface;
 
 (*
 ValueStack = interface
  procedure PushString(const aString: Tl3WString); overload;
  procedure PushFile(const aFile: ItfwFile);
  function PopFile: ItfwFile;
  function IsTopObj: Boolean;
  function IsTopChar: Boolean;
  procedure PushChar(aChar: AnsiChar);
  function PopChar: AnsiChar;
  procedure PushWStr(const aStr: Tl3WString);
  function PopPrintable: Il3CString;
  procedure PushClass(aClass: TClass);
  function PopClass: TClass;
  function IsTopClass: Boolean;
  function PopObjAs(aClass: TClass;
   aAllowNil: Boolean): Pointer;
  function PopClassAs(aClass: TClass): Pointer;
  function PopWideString: WideString;
  procedure PushWideString(const aValue: WideString);
  function PopPoint: TPoint;
  procedure PushPoint(const aPoint: TPoint);
  procedure PushList(const aList: ItfwValueList);
  function PopList: ItfwValueList;
  procedure DupN(aN: Integer);
  procedure DropN(aN: Integer);
  function Top: PtfwStackValue;
  procedure PushIntf(const anIntf: IUnknown;
   aType: PTypeInfo);
  procedure PushString(aString: Tl3PrimString); overload;
  procedure PushString(const aString: Il3CString); overload;
  procedure PushString(const aString: AnsiString); overload;
  function IsTopString: Boolean;
  function PopDelphiString: AnsiString;
  function PopString: Il3CString;
  function IsTopInt: Boolean;
  procedure Dup;
  procedure Drop;
  procedure Swap;
  procedure Push(const aValue: TtfwStackValue);
  function Pop: TtfwStackValue;
  function IsTopType(aType: TtfwValueType): Boolean;
  procedure PushObj(aValue: TObject);
  function PopObj: TObject;
  procedure DupIfNotZero;
  procedure Rot;
  procedure Pick;
  procedure InvertRot;
  procedure Swap2;
  procedure Over2;
  procedure Dup2;
  procedure Drop2;
  procedure Nip;
  procedure Tuck;
  procedure Over;
  procedure Roll;
  function PopIntf(const aGUID: TGUID): IUnknown; overload;
  function PopIntf: IUnknown; overload;
  function IsTopIntf: Boolean;
   {* Определяет - лежит ли на верхушке стека интерфейс }
  procedure PushInt(aValue: Integer);
  function PopInt: Integer;
  procedure PushBool(aValue: Boolean);
  function PopBool: Boolean;
  function IsTopBool: Boolean;
 end;//ValueStack
 *)
 
 ItfwScriptEngine = interface
  function Clone: ItfwScriptEngine;
  procedure WordFail(const aPoint: TtfwSourcePoint);
  procedure WordSuccess;
  procedure ExceptionStackToLog;
  function ExceptionStack: ItfwValueList;
  procedure FailToLog;
  function OpenDictionary(var aCtx: TtfwContext): Boolean;
  procedure CloseDictionary(const aCtx: TtfwContext);
  procedure AddInitialization(const aCtx: TtfwContext;
   aWord: TtfwWord);
  function CurrentCompilingDictionary: TtfwDictionaryPrim;
  procedure DisableForHelp(aWord: TtfwWord);
  procedure PushString(const aString: Tl3WString); overload;
  procedure PushFile(const aFile: ItfwFile);
  function PopFile: ItfwFile;
  function IsTopObj: Boolean;
  function IsTopChar: Boolean;
  procedure PushChar(aChar: AnsiChar);
  function PopChar: AnsiChar;
  procedure PushWStr(const aStr: Tl3WString);
  function PopPrintable: Il3CString;
  procedure PushClass(aClass: TClass);
  function PopClass: TClass;
  function IsTopClass: Boolean;
  function PopObjAs(aClass: TClass;
   aAllowNil: Boolean): Pointer;
  function PopClassAs(aClass: TClass): Pointer;
  function PopWideString: WideString;
  procedure PushWideString(const aValue: WideString);
  function PopPoint: TPoint;
  procedure PushPoint(const aPoint: TPoint);
  procedure PushList(const aList: ItfwValueList);
  function PopList: ItfwValueList;
  procedure DupN(aN: Integer);
  procedure DropN(aN: Integer);
  function Top: PtfwStackValue;
  procedure PushIntf(const anIntf: IUnknown;
   aType: PTypeInfo);
  procedure PushString(aString: Tl3PrimString); overload;
  procedure PushString(const aString: Il3CString); overload;
  procedure PushString(const aString: AnsiString); overload;
  function IsTopString: Boolean;
  function PopDelphiString: AnsiString;
  function PopString: Il3CString;
  function IsTopInt: Boolean;
  procedure Dup;
  procedure Drop;
  procedure Swap;
  procedure Push(const aValue: TtfwStackValue);
  function Pop: TtfwStackValue;
  function IsTopType(aType: TtfwValueType): Boolean;
  procedure PushObj(aValue: TObject);
  function PopObj: TObject;
  procedure DupIfNotZero;
  procedure Rot;
  procedure Pick;
  procedure InvertRot;
  procedure Swap2;
  procedure Over2;
  procedure Dup2;
  procedure Drop2;
  procedure Nip;
  procedure Tuck;
  procedure Over;
  procedure Roll;
  function PopIntf(const aGUID: TGUID): IUnknown; overload;
  function PopIntf: IUnknown; overload;
  function IsTopIntf: Boolean;
   {* Определяет - лежит ли на верхушке стека интерфейс }
  procedure PushInt(aValue: Integer);
  function PopInt: Integer;
  procedure PushBool(aValue: Boolean);
  function PopBool: Boolean;
  function IsTopBool: Boolean;
  function KeywordFinder(const aCtx: TtfwContext): TtfwWord;
  function KeywordByName(const aName: Il3CString): Tl3PrimString;
  function ParentFinder: TtfwWord;
 end;//ItfwScriptEngine
 
 PtfwContext = ^TtfwContext;
 
 (*
 MtfwIterator = interface
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
 end;//MtfwIterator
 *)
 
 ItfwIterator = interface
  procedure ForEach(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
  procedure ForEachBack(aLambda: TtfwWordPrim;
   const aCtx: TtfwContext);
 end;//ItfwIterator
 
 ItfwValueList = interface(ItfwIterator)
  procedure SetItem(anIndex: Integer;
   const aValue: TtfwStackValue);
  function ItemsCountInSlice: Integer;
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
  procedure Clear;
 end;//ItfwValueList
 
 TtfwStoredValue = record
  {* Сохранённое значение переменной для восстановления }
 end;//TtfwStoredValue
 
 (*
 MtfwStoredValuesStack = interface
  procedure Restore(const aCtx: TtfwContext);
  procedure StoreDictionary(aDictionary: TtfwDictionaryPrim;
   const aCtx: TtfwContext);
 end;//MtfwStoredValuesStack
 *)
 
 ItfwStoredValues = interface;
 
 ItfwStoredValuesStack = interface
  function IndexOf(const anItem: _ItemType_): Integer;
  function Add(const anItem: _ItemType_): Integer;
  procedure Restore(const aCtx: TtfwContext);
  procedure StoreDictionary(aDictionary: TtfwDictionaryPrim;
   const aCtx: TtfwContext);
 end;//ItfwStoredValuesStack
 
 ItfwStoredValues = interface
  procedure Restore(const aCtx: TtfwContext);
  function Grow: PtfwStoredValue;
 end;//ItfwStoredValues
 
 ItfwFile = interface(ItfwIterator)
  function ReadLn: Il3CString;
  procedure WriteLn(const aString: Il3CString);
  procedure WriteChar(aChar: AnsiChar);
  function ReadWStrLn: Tl3WString;
  procedure WriteWStrLn(const aStr: Tl3WString);
  procedure WriteWStr(const aStr: Tl3WString);
  function EOF: Boolean;
 end;//ItfwFile
 
 PtfwStoredValue = ^TtfwStoredValue;
 
 TtfwWordCallContext = record
 end;//TtfwWordCallContext
 
 PtfwWordCallContext = ^TtfwWordCallContext;
 
 TtfwValueType = tfwTypeInfo.TtfwValueType;
 
 TtfwWordModifier = tfwScriptingTypes.TtfwWordModifier;
 
 TtfwWordInfoF = class(TtfwWordInfo)
  procedure Create(const aModifiers: TtfwWordInfoRec);
  function IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo;
  function Empty: Boolean;
  function Has(aModifier: TtfwWordModifier): Boolean; overload;
  function Clone: TtfwWordInfo;
  function pRec: PtfwWordInfoRec;
  function IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo;
  function Has(aType: TtfwValueType): Boolean; overload;
  function AcceptsValue(const aValue: TtfwStackValue): Boolean;
  function Has(anAccess: TtfwAccessType): Boolean; overload;
  function IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo;
  function EQwm(aValue: TtfwWordModifiers): Boolean;
  function IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo;
  function TypeName: Il3CString;
  function ValueTypes: TtfwValueTypes;
  function IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo;
  function Has(aLinkType: TtfwLinkType): Boolean; overload;
  function LinkType: TtfwLinkType;
  function AccessType: TtfwAccessType;
  function Compare(anOther: TtfwWordInfo): Integer;
  function Modifiers: TtfwWordModifiers;
  function ToString: Il3CString;
 end;//TtfwWordInfoF
 
 TtfwWordInfoRec = tfwScriptingTypes.TtfwWordInfoRec;
 
 EtfwException = tfwScriptingExceptions.EtfwException;
 
 EtfwCheck = tfwScriptingExceptions.EtfwCheck;
 
 TtfwNewWordDefinitor = TtfwWord;
 
 TtfwValueTypes = tfwScriptingTypes.TtfwValueTypes;
 
 TtfwStackValueEx = object(TtfwStackValue)
 end;//TtfwStackValueEx
 
 TtfwWordInfoE = class(TtfwWordInfo)
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
  function IncludeModifier(aModifier: TtfwWordModifier): TtfwWordInfo;
  function Empty: Boolean;
  function Has(aModifier: TtfwWordModifier): Boolean; overload;
  function Clone: TtfwWordInfo;
  function pRec: PtfwWordInfoRec;
  function IncludeTypeModifier(aType: TtfwValueType): TtfwWordInfo;
  function Has(aType: TtfwValueType): Boolean; overload;
  function AcceptsValue(const aValue: TtfwStackValue): Boolean;
  function Has(anAccess: TtfwAccessType): Boolean; overload;
  function IncludeAccesType(anAccess: TtfwAccessType): TtfwWordInfo;
  function EQwm(aValue: TtfwWordModifiers): Boolean;
  function IncludeType(const aType: TtfwTypeInfo): TtfwWordInfo;
  function TypeName: Il3CString;
  function ValueTypes: TtfwValueTypes;
  function IncludeLinkType(aLinkType: TtfwLinkType): TtfwWordInfo;
  function Has(aLinkType: TtfwLinkType): Boolean; overload;
  function LinkType: TtfwLinkType;
  function AccessType: TtfwAccessType;
  function Compare(anOther: TtfwWordInfo): Integer;
  function Modifiers: TtfwWordModifiers;
  function ToString: Il3CString;
 end;//TtfwWordInfoE
 
 PtfwStackValue = tfwTypeInfo.PtfwStackValue;
 
 TtfwKeywordFinder = TtfwWord;
 
 TtfwCStringFactoryEx = class(TtfwCStringFactory)
  function ViewOf(const aString: Tl3WString): TtfwStackValue; overload;
  function ViewOf(const aString: AnsiString): TtfwStackValue; overload;
 end;//TtfwCStringFactoryEx
 
 TtfwCompiler = TtfwWord;
 
implementation

uses
 l3ImplUses
 , tfwWordInfoWordsPack
 , StrUtils
 , l3Parser
 , tfwClassRef
 , ArrayProcessingPack
 , BasicsPack
 , FileProcessingPack
 , SysUtilsPack
 , WordsRTTIPack
 , l3Base
 , l3String
 , kwForwardDeclaration
 , KeyWordPack
 , tfwWordInfoCache
 , NewWordDefinitorPack
 , ItfwKeywordFinderWordsPack
 , ItfwCompilerWordsPack
;

end.
