unit k2ParentedTagObject.imp;

interface

uses
 l3IntfUses
 , l3Variant
;

type
 _k2ParentedTagObject_ = class(Ml3Unknown, Ml3VariantMirror)
  {* Тег, имещий ссылку на родителя. }
 end;//_k2ParentedTagObject_
 
implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
;

end.
