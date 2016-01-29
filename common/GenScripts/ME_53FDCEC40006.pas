unit m3CustomHeaderStream.imp;

interface

uses
 l3IntfUses
 , m3BaseHeaderStream
 , ActiveX
;

type
 // _HeaderType_
 
 _m3CustomHeaderStream_ = class(Tm3BaseHeaderStream)
  {* ѕоток с заголовком-идентификатором }
  procedure Create(const aStream: IStream;
   aAccess: Integer);
  function DefaultHeaderValue: _HeaderType_;
  function NeedHeaderAlignment: Boolean;
  procedure DoLoadHeader;
   {* загружает заголовок в пам€ть }
  procedure DoSaveHeader(aForceSave: Boolean);
   {* сохран€ет заголовок }
 end;//_m3CustomHeaderStream_
 
implementation

uses
 l3ImplUses
 , m2AddDbg
 , m2AddPrc
 , m2COMLib
 , m2MemLib
 , l3Base
 , ComObj
 , m3Const
;

end.
