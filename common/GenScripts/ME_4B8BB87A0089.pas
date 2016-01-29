unit l3DictionaryPrim.imp;

interface

uses
 l3IntfUses
;

type
 // _IDIndexType_
 
 _l3DictionaryPrim_ = class(_l3DictionaryPrimPrim_, Ml3Unknown, Ml3Items, Ml3TypedListPrim)
  function ControlFindByID: Boolean;
 end;//_l3DictionaryPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3String
;

type
 THackIndex = class(_IDIndexType_)
  {* еръ }
 end;//THackIndex
 
end.
