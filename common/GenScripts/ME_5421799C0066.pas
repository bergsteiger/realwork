unit m3Persistent;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ActiveX
 , l3_String
;

type
 Tm3Persistent = class(Tl3ProtoObject)
  procedure Load(const aStream: IStream);
  procedure Save(const aStream: IStream);
  procedure LoadBuff(const aStream: IStream;
   aBuff: Pointer;
   aSize: Integer);
  procedure SaveBuff(const aStream: IStream;
   aBuff: Pointer;
   aSize: Integer);
  procedure LoadWideString(const aStream: IStream;
   aString: Tl3_String);
  procedure SaveWideString(const aStream: IStream;
   aString: Tl3_String);
 end;//Tm3Persistent
 
implementation

uses
 l3ImplUses
 , m2COMLib
 , l3Chars
;

end.
