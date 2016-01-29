unit l3RangeManager;

interface

uses
 l3IntfUses
 , l3CProtoObject
 , l3Interfaces
;

type
 Tl3RangeManager = class(Tl3CProtoObject, Il3RangeManager)
  function HasPage(anIndex: Integer): Boolean;
   {* содержит ли диапазон указанную страницу. }
  function Count: Integer;
   {* количество поддиапазонов страниц. }
  function Pages: Integer;
  function IndexOfPage: Integer;
   {* номер поддиапазона в котором находится указанная страница. }
 end;//Tl3RangeManager
 
implementation

uses
 l3ImplUses
;

end.
