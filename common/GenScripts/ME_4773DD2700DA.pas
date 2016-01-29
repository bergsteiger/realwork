unit l3DataPtrList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
;

type
 Tl3DataPtrList = class(_l3DataPtrList_)
  {* Список указателей на куски памяти. Ничего не освобождает. }
 end;//Tl3DataPtrList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
