unit tfwFileStreamFactory;

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3BaseStream
;

type
 TtfwFileStreamFactory = class(TtfwStreamFactory)
  function Stream: Tl3Stream;
  function FileDateTime: TDateTime;
 end;//TtfwFileStreamFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Stream
 , l3Types
 , l3FileUtils
;

end.
