unit tfwCOMaker;

interface

uses
 l3IntfUses
;

type
 TtfwCOMaker = class
  procedure Make(const aFileName: AnsiString);
 end;//TtfwCOMaker
 
implementation

uses
 l3ImplUses
 , tfwParser
 , tfwFileStreamFactory
 , SysUtils
 , l3Parser
 , tfwParserInterfaces
;

end.
