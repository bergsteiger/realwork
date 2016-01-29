unit tfwDictionaryPtrListIterator;

interface

uses
 l3IntfUses
 , tfwDictionaryDataIteratorPrim
 , tfwDictionaryPtrList
 , tfwScriptingInterfaces
 , tfwDictionaryEx
;

type
 TtfwDictionaryPtrListIterator = class(TtfwDictionaryDataIteratorPrim)
  function Make(aDictionary: TtfwDictionaryEx): ItfwValueList;
 end;//TtfwDictionaryPtrListIterator
 
implementation

uses
 l3ImplUses
 , tfwDictionary
;

end.
