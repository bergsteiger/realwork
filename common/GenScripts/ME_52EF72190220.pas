unit tfwParserInterfaces;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\tfwParserInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "tfwParserInterfaces" MUID: (52EF72190220)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Parser
;

type
 ItfwParser = interface
  ['{EA8354FC-1EAD-4724-8124-9D8B54CF0780}']
  procedure NextToken;
  function TokenLongString: Il3CString;
  function TokenInt: Integer;
  function FileName: AnsiString;
  function TokenType: Tl3TokenType;
  function SourceLine: Integer;
 end;//ItfwParser

 ItfwParserEx = interface(ItfwParser)
  ['{5650435D-EB36-4B67-A8A9-ECCC837FD2E6}']
  procedure PushString(const aString: Il3CString);
  procedure PushSymbol(const aString: Il3CString);
  procedure PushInt(aValue: Integer);
 end;//ItfwParserEx

implementation

uses
 l3ImplUses
;

end.
