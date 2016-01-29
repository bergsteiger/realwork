unit tfwExportedDictionariesIterator;

interface

uses
 l3IntfUses
 , tfwDictionaryPtrListIterator
;

type
 TtfwExportedDictionariesIterator = class(TtfwDictionaryPtrListIterator)
  function ListToIterate: _ListType_;
 end;//TtfwExportedDictionariesIterator
 
implementation

uses
 l3ImplUses
;

end.
