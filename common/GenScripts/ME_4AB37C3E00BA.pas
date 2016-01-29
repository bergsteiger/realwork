unit m4WordIDStr;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , m4DictTypes
;

type
 Tm4WordIDStr = class(_l3AtomicList_)
  {* Элемент словаря. Список идентификаторов слов }
  function Compare(anOther: Tm4WordIDStr): Integer;
  procedure Create(const anID: Tm4DictItemAddr);
 end;//Tm4WordIDStr
 
implementation

uses
 l3ImplUses
 , m2MemLib
 , l3MinMax
 , l3Base
 , RTLConsts
 , SysUtils
;

end.
