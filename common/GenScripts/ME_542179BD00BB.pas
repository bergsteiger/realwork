unit m3PersistentList.imp;

interface

uses
 l3IntfUses
 , ActiveX
;

type
 _m3PersistentList_ = class(_m3ListWithFind_)
  procedure LoadFromStream(const aStream: IStream;
   aPosition: Int64);
  function SaveToStream(const aStream: IStream): Int64;
 end;//_m3PersistentList_
 
implementation

uses
 l3ImplUses
 , m3Persistent
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 , m2COMLib
 , m3BuffStream
 , m2S32Lib
;

end.
