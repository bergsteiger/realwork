unit tfwCOMStreamFactory;

interface

uses
 l3IntfUses
 , tfwStreamFactory
 , l3Interfaces
 , l3BaseStream
;

type
 TtfwCOMStreamFactory = class(TtfwStreamFactory)
  procedure Create(const aStream: IStream);
  function Stream: Tl3Stream;
  function FileDateTime: TDateTime;
 end;//TtfwCOMStreamFactory
 
implementation

uses
 l3ImplUses
 , l3Stream
 , Classes
 , SysUtils
;

end.
