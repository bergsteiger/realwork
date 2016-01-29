unit l3DataRefList;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
;

type
 Tl3DataRefList = class(_l3DataRefList_)
  {* Список ссылок на куски памяти. При своём освобождении освобождает хранимые куски памяти. Эта память должна быть выделена функцией l3System.GetLocalMem. }
 end;//Tl3DataRefList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
