unit tfwScriptEnginePrim;

interface

uses
 l3IntfUses
 , tfwCompilingWord
 , tfwScriptingInterfaces
 , tfwScriptEngineExInterfaces
 , tfwDictionaryEx
 , tfwValueStack
 , tfwSourcePointList
 , tfwDictionaryList
 , tfwDictionaryStack
 , tfwMainDictionary
 , tfwInitedDictionariesList
 , tfwWordRefList
 , tfwStreamFactory
 , l3Interfaces
 , tfwTypeInfo
 , l3Variant
 , Types
 , tfwDictionaryPrim
 , TypInfo
 , kwCompiledWordPrim
;

type
 TtfwScriptEnginePrim = class(TtfwCompilingWord, Ml3Unknown, ItfwScriptEngine, ItfwScriptEngineEx)
  procedure Script(aStream: TtfwStreamFactory;
   const aCaller: ItfwScriptCaller);
  procedure RunInitCode(const aCtx: TtfwContext);
  procedure EnterCode(const aCtx: TtfwContext);
  procedure LeaveCode(const aCtx: TtfwContext);
  procedure RunCompiled(const aContext: TtfwContext);
  function CacheDict: Boolean;
  function Shift(anIndent: Integer): Il3CString;
  procedure PushInt(aValue: Integer);
  function PopInt: Integer;
  procedure PushBool(aValue: Boolean);
  function PopBool: Boolean;
  function IsTopBool: Boolean;
  procedure PushString(const aString: AnsiString); overload;
  procedure PushString(const aString: Il3CString); overload;
  procedure PushString(aString: Tl3PrimString); overload;
  function IsTopString: Boolean;
  function PopDelphiString: AnsiString;
  function PopString: Il3CString;
  function IsTopInt: Boolean;
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
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
  function ValuesCount: Integer;
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
  function Clone: ItfwScriptEngine;
  function PopObjAs(aClass: TClass;
   aAllowNil: Boolean): Pointer;
  function PopClassAs(aClass: TClass): Pointer;
  function PopWideString: WideString;
  procedure PushWideString(const aValue: WideString);
  function PopPoint: TPoint;
  procedure PushPoint(const aPoint: TPoint);
  procedure PushList(const aList: ItfwValueList);
  function PopList: ItfwValueList;
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
  function CascadeDict: Boolean;
  procedure DisableForHelp(aWord: TtfwWord);
  procedure DupN(aN: Integer);
  procedure DropN(aN: Integer);
  function Dictionaries: TtfwDictionaryList;
  function InitedDictionaries: TtfwInitedDictionariesList;
  function MainDictionary: TtfwMainDictionary;
  function DisabledForHelp: TtfwWordRefList;
  function Top: PtfwStackValue;
  procedure PushIntf(const anIntf: IUnknown;
   aType: PTypeInfo);
 end;//TtfwScriptEnginePrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3String
 , SysUtils
 , l3StringList
 , l3Types
 , tfwParser
 , l3Filer
 , l3Parser
 , l3Chars
 , l3Stream
 , tfwStoredValuesStack
 , tfwAutoregisteredDiction
 , l3Memory
 , seWordsInfo
 , l3ScriptService
 , tfwArray
 , tfwParserInterfaces
 , tfwDictionaryListPrim
 , tfwDictionaryPtrList
 , tfwDictionaryCache
 , seThreadSupport
 , tfwMainDictionaryCache
 , tfwMainDictionaryList
 , tfwStandardDictionaries
;

end.
