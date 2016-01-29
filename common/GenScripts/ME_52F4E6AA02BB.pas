unit tfwStreamFactory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3BaseStream
;

type
 TtfwStreamFactory = class(Tl3ProtoObject)
  function FileName: AnsiString;
  function Stream: Tl3Stream;
  procedure Create(const aFileName: AnsiString);
  procedure CloseStream;
  function FileDateTime: TDateTime;
 end;//TtfwStreamFactory
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
