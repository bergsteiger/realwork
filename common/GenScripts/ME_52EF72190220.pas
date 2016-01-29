unit tfwParserInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Parser
;

type
 ItfwParser = interface
  procedure NextToken;
  function TokenLongString: Il3CString;
  function TokenInt: Integer;
  function FileName: AnsiString;
  function TokenType: Tl3TokenType;
  function SourceLine: Integer;
 end;//ItfwParser
 
 ItfwParserEx = interface(ItfwParser)
  procedure PushString(const aString: Il3CString);
  procedure PushSymbol(const aString: Il3CString);
  procedure PushInt(aValue: Integer);
 end;//ItfwParserEx
 
implementation

uses
 l3ImplUses
;

end.
