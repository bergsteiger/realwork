unit tfwCOMaker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Parsing"
// Модуль: "tfwCOMaker.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi Low Level::ScriptEngine$Parsing::Tools::TtfwCOMaker
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

type
 TtfwCOMaker = {final} class
 public
 // public methods
   class procedure Make(const aFileName: AnsiString);
 end;//TtfwCOMaker

implementation

uses
  SysUtils,
  l3Parser,
  tfwParserInterfaces,
  tfwParser,
  tfwFileStreamFactory
  ;

// start class TtfwCOMaker

class procedure TtfwCOMaker.Make(const aFileName: AnsiString);
//#UC START# *55C1F5C100CC_55C1F59F001C_var*
var
 l_F : TtfwFileStreamFactory;
 l_P : TtfwParser;
//#UC END# *55C1F5C100CC_55C1F59F001C_var*
begin
//#UC START# *55C1F5C100CC_55C1F59F001C_impl*
 l_F := TtfwFileStreamFactory.Create(aFileName);
 try
  l_P := TtfwParser.Create(l_F);
  try
   ItfwParser(l_P).NextToken;
   while (ItfwParser(l_P).TokenType <> l3_ttEOF) do
    ItfwParser(l_P).NextToken;
  finally
   FreeAndNil(l_P);
  end;//try..finally
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *55C1F5C100CC_55C1F59F001C_impl*
end;//TtfwCOMaker.Make

end.