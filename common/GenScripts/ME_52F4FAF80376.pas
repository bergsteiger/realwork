unit tfwStringStreamFactory;

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3BaseStream
;

type
 TtfwStringStreamFactory = class(TtfwStreamFactory)
  procedure Create(const aString: AnsiString);
  function Stream: Tl3Stream;
  function FileDateTime: TDateTime;
 end;//TtfwStringStreamFactory
 
implementation

uses
 l3ImplUses
 , l3Memory
 , l3String
 , SysUtils
;

end.
