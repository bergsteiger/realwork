unit m3RootStream.imp;

interface

uses
 l3IntfUses
 , l3Logger
 , ActiveX
;

type
 _m3RootStream_ = class(_m3CustomHeaderStream_)
  procedure Create(const aStream: IStream;
   aAccess: Integer);
 end;//_m3RootStream_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
;

end.
