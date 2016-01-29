unit tfwDictionaryListIterator.imp;

interface

uses
 l3IntfUses
 , tfwIteratableParent
 , tfwScriptingInterfaces
;

type
 _tfwDictionaryListIterator_ = class(TtfwIteratableParent)
  procedure Create(const aListToIterate: _ListType_);
  function Make(const aListToIterate: _ListType_): ItfwValueList;
  function ListToIterate: _ListType_;
 end;//_tfwDictionaryListIterator_
 
implementation

uses
 l3ImplUses
 , SysUtils
 , tfwDictionary
;

end.
