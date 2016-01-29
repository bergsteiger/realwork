unit k2OwnedTagObject.imp;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 _k2OwnedTagObject_ = class(Ml3Unknown, Ml3VariantMirror)
  {* Тег имеющий ссылку на владельца }
 end;//_k2OwnedTagObject_
 
implementation

uses
 l3ImplUses
 , k2Base
 , SysUtils
 , k2NullTagImpl
;

end.
