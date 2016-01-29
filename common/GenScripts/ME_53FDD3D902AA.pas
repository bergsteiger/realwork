unit m3BuffStream;

interface

uses
 l3IntfUses
 , m3CustomStream
 , l3Memory
 , ActiveX
 , Classes
;

type
 Tm3BuffStream = class(Tm3CustomStream)
  procedure LoadBuff;
  procedure SaveBuff;
  procedure Create(const aStream: IStream);
  function Make(const aStream: IStream): IStream;
 end;//Tm3BuffStream
 
implementation

uses
 l3ImplUses
 , m2COMLib
 , ComObj
 , SysUtils
 , m2S32Lib
 , m2S64Lib
;

end.
