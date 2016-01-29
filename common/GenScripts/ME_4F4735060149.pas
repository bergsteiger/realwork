unit tfwParser;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , tfwParserInterfaces
 , l3Filer
 , l3Interfaces
 , l3Parser
 , tfwCachedTokens
 , tfwStreamFactory
 , l3ProtoDataContainer
;

type
 TtfwParserToken = object
 end;//TtfwParserToken
 
 TtfwParserTokenList = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TtfwParserTokenList
 
 TtfwDecoratorParser = class(Tl3ProtoObject, ItfwParser, ItfwParserEx)
  procedure Create(aFiler: TtfwStreamFactory);
  function Make(aFiler: TtfwStreamFactory): ItfwParserEx;
  procedure CheckParser;
  procedure PushToken(const aToken: TtfwParserToken);
  procedure NextToken;
  function TokenLongString: Il3CString;
  function TokenInt: Integer;
  function FileName: AnsiString;
  function TokenType: Tl3TokenType;
  function SourceLine: Integer;
  procedure PushString(const aString: Il3CString);
  procedure PushSymbol(const aString: Il3CString);
  procedure PushInt(aValue: Integer);
 end;//TtfwDecoratorParser
 
 TtfwParser = class(Tl3ProtoObject, ItfwParser)
  procedure Create(aFiler: TtfwStreamFactory);
  function MakePrim(aFiler: TtfwStreamFactory): ItfwParser;
  function Make(aFiler: TtfwStreamFactory): ItfwParserEx;
  procedure NextToken;
  function TokenLongString: Il3CString;
  function TokenInt: Integer;
  function FileName: AnsiString;
  function TokenType: Tl3TokenType;
  function SourceLine: Integer;
 end;//TtfwParser
 
implementation

uses
 l3ImplUses
 , l3Chars
 , SysUtils
 , l3Types
 , l3FileUtils
 , l3DateSt
 , tfwCStringFactory
 , l3Variant
 , l3String
 , l3_String
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
