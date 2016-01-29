unit vtNavigatorFormListPrim;

interface

uses
 l3IntfUses
 , vtNavigatorFormListPrimPrim
 , l3Types
;

type
 TvtFormHandlerID = record
  {* Ключ для поиска элемента по объекту. }
 end;//TvtFormHandlerID
 
 TvtNavigatorFormListPrim = class(TvtNavigatorFormListPrimPrim)
  {* Список форм навигатора, который позволяет искать элемент в списка по ключу объект. }
 end;//TvtNavigatorFormListPrim
 
implementation

uses
 l3ImplUses
;

end.
