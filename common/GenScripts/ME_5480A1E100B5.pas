unit m3TempStream;

interface

uses
 l3IntfUses
 , m3FileStream
 , ActiveX
;

type
 Tm3TempStream = class(Tm3FileStream)
  procedure Create(const APath: WideString;
   const AExt: WideString);
  function Make(const APath: WideString;
   const AExt: WideString): IStream;
 end;//Tm3TempStream
 
implementation

uses
 l3ImplUses
 , m2TMPLib
 , Windows
;

end.
