unit vgPtrList;

interface

uses
 l3IntfUses
 , l3DataPtrList
;

type
 TvgPtrList = class(Tl3DataPtrList)
  {* Список указателей на куски памяти. Ничего не освобождает }
 end;//TvgPtrList
 
implementation

uses
 l3ImplUses
;

end.
