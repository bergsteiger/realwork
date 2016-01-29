unit tfwDictionaryDataIteratorPrim;

interface

uses
 l3IntfUses
 , tfwIteratableParent
 , tfwDictionaryEx
;

type
 TtfwDictionaryDataIteratorPrim = class(TtfwIteratableParent)
  procedure Create(aDictionary: TtfwDictionaryEx);
 end;//TtfwDictionaryDataIteratorPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
