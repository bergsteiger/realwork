unit l3OpenArray.imp;

interface

uses
 l3IntfUses
;

type
 _l3OpenArray_ = class(Ml3Items, Ml3TypedListPrim)
  {* "Открытый массив". Список, который автоматически расширяется при добавлении элемента за гранецей диапазона }
 end;//_l3OpenArray_
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
