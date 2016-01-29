unit tfwUsedDictionariesIterator;

interface

uses
 l3IntfUses
 , tfwDictionaryPtrListIterator
;

type
 TtfwUsedDictionariesIterator = class(TtfwDictionaryPtrListIterator)
  function ListToIterate: _ListType_;
 end;//TtfwUsedDictionariesIterator
 
implementation

uses
 l3ImplUses
;

end.
