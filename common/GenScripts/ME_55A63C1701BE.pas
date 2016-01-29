unit tfwNamedDictionaryList.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , tfwDictionaryExPrim
;

type
 _tfwNamedDictionaryList_ = class
  procedure Insert(anIndex: Integer;
   const anItem: _ItemType_);
  procedure Add(const anItem: _ItemType_);
  function FindDictionary(const aFileName: Il3CString): _ItemType_;
  procedure Remove(const anItem: _ItemType_);
  procedure RemoveUsersOf(anItem: TtfwDictionaryExPrim);
  procedure CollectNotValidTo(anOther: _tfwNamedDictionaryList_);
  procedure RemoveElementsOf(aList: _tfwNamedDictionaryList_);
  procedure RemoveNotValid;
 end;//_tfwNamedDictionaryList_
 
implementation

uses
 l3ImplUses
 , l3String
;

end.
