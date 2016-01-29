unit k2ParentedTypedSmallLeafTag;

interface

uses
 l3IntfUses
 , k2TypedSmallLeafTag
;

type
 Tk2ParentedTypedSmallLeafTag = class(_k2ParentedTagObject_)
  {* Листьевой тег с заранее определённым типом, имеющий ссылку на родителя и могущий иметь НЕ более 32 (включительно) атрибутов }
 end;//Tk2ParentedTypedSmallLeafTag
 
implementation

uses
 l3ImplUses
 , k2Base
 , k2NullTagImpl
;

end.
