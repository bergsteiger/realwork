unit l3Map.imp;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 _l3Map_ = class(Tl3ProtoDataContainer)
  {* Словарь (ключ-значение) }
 end;//_l3Map_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
