unit k2ParentedTypedSmallListTag;

interface

uses
 l3IntfUses
 , k2TypedSmallListTag
;

type
 Tk2ParentedTypedSmallListTag = class(Tk2TypedSmallListTag)
  {* Список тегов со ссылкой на родителя }
 end;//Tk2ParentedTypedSmallListTag
 
implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
;

end.
