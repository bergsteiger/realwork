unit tfwParserTokenListTest;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TtfwParserTokenListTest = class(TBaseTest)
  procedure TestAddAndDelete;
 end;//TtfwParserTokenListTest
 
implementation

uses
 l3ImplUses
 , tfwParser
 , SysUtils
 , l3InterfacedString
 , l3Base
 , l3Parser
 , testCConstDelphiString
 , l3Interfaces
 , TestFrameWork
;

end.
