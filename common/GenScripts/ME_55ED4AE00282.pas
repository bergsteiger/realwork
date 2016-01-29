unit tfwMembersIteratorPrim;

interface

uses
 l3IntfUses
 , tfwIteratableParent
 , tfwDictionaryPrim
;

type
 TtfwMembersIteratorPrim = class(TtfwIteratableParent)
  procedure Create(aDictionary: TtfwDictionaryPrim);
 end;//TtfwMembersIteratorPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
