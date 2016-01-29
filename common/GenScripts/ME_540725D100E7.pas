unit m3Exceptions;

interface

uses
 l3IntfUses
 , l3Except
;

type
 Em3Exception = class(El3Exception)
 end;//Em3Exception
 
 Em3InvalidStream = class(Em3Exception)
 end;//Em3InvalidStream
 
 Em3NilStream = class(Em3InvalidStream)
 end;//Em3NilStream
 
 Em3NoIndex = class(Em3Exception)
 end;//Em3NoIndex
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
