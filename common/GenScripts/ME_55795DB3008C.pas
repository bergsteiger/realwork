unit tfwResourceStreamFactory;

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3BaseStream
;

type
 TtfwResourceStreamFactory = class(TtfwStreamFactory)
  procedure Create(const aResName: AnsiString);
  function Stream: Tl3Stream;
  function FileDateTime: TDateTime;
 end;//TtfwResourceStreamFactory
 
implementation

uses
 l3ImplUses
 , l3Stream
 , Windows
 , StrUtils
 , SysUtils
 , l3FileUtils
 , l3String
 , l3Interfaces
 , tfwCStringFactory
;

end.
