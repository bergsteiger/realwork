unit ncsFileDesc;

interface

uses
 l3IntfUses
 , l3Variant
 , FileDesc_Const
 , k2Base
;

type
 TncsFileDesc = class(Tl3Tag)
  function GetTaggedDataType: Tk2Type;
 end;//TncsFileDesc
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
