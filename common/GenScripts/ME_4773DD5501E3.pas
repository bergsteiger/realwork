unit l3ObjectRefArray;

interface

uses
 l3IntfUses
 , l3ProtoObjectRefList
;

type
 Tl3ObjectRefArray = class(_l3OpenArray_)
  {* "Открытый массив". Список, который автоматически расширяется при добавлении элемента за гранецей диапазона }
 end;//Tl3ObjectRefArray
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
