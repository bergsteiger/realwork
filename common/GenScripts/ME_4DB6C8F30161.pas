unit tfwCompilingWord;

interface

uses
 l3IntfUses
 , tfwRegisterableWord
 , tfwScriptingInterfaces
 , kwCompiledWordPrim
 , l3Interfaces
;

type
 TtfwCompilingWord = class(TtfwRegisterableWord)
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
  procedure BeforeCompile(var theNewContext: TtfwContext);
  procedure AfterCompile(var theNewContext: TtfwContext;
   aCompiled: TkwCompiledWordPrim);
  procedure UnknownWord(var aContext: TtfwContext;
   aWordNumber: Integer);
  function AfterWordMaxCount(const aCtx: TtfwContext): Integer;
  function AcceptsKeyWordAfter(const aContext: TtfwContext;
   aWordNumber: Integer): Boolean;
  function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
  procedure DoStringToken(const aContext: TtfwContext;
   aCompiled: TtfwWord;
   const aString: Il3CString);
  function AcceptsEOF: Boolean;
  function DisabledEndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
  procedure FillCompiledWord(aCompiled: TtfwWord;
   const aCtx: TtfwContext);
  function GetWordProducerForCompiledClass: TtfwWord;
  function SuppressNextImmediate(const aContext: TtfwContext;
   aWordNumber: Integer): TtfwSuppressNextImmediate;
  procedure AfterCodePartAdded(aWord: TtfwWord;
   var aCtx: TtfwContext);
  procedure DoKeyword(var aContext: TtfwContext;
   aWord: TtfwWord;
   aFinder: TtfwWord;
   aWordNumber: Integer);
  procedure CheckWordInfoOnCompile(const aCtx: TtfwContext);
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TtfwCompilingWord
 
implementation

uses
 l3ImplUses
 , l3Parser
 , kwCompiledWord
 , kwInteger
 , kwString
 , SysUtils
 , TypInfo
 , l3Base
 , l3ParserInterfaces
 , kwIntegerFactory
 , kwStringFactory
 , l3String
 , l3Chars
 , StrUtils
;

end.
