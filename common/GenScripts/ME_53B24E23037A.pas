unit k2TaggedDataHolder.imp;

interface

uses
 l3IntfUses
 , l3Variant
 , k2Base
;

type
 _k2TaggedDataHolder_ = class(Ml3Unknown)
  function GetTaggedDataType: Tk2Type;
  procedure SetTaggedData(aData: Tl3Tag);
 end;//_k2TaggedDataHolder_
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
