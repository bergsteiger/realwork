unit evdTagHolder.imp;

interface

uses
 l3IntfUses
 , Classes
 , l3Variant
;

type
 _evdTagHolder_ = class(_k2TaggedDataHolder_)
  procedure SaveToEVD(aStream: TStream;
   const aFilter: Ik2TagGenerator);
  function CreateTaggedDataFromEVD(aStream: TStream): Tl3Tag;
  procedure LoadFromEVD(aStream: TStream);
  function NeedSendRawDataAsBinary: Boolean;
 end;//_evdTagHolder_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
;

end.
