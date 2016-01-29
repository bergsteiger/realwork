unit l3ValueMap;

interface

uses
 l3IntfUses
 , l3BaseWithIDList
 , l3Interfaces
 , l3Except
;

type
 El3ValueMap = class(El3Error)
 end;//El3ValueMap
 
 El3ValueMapValueNotFound = class(El3ValueMap)
 end;//El3ValueMapValueNotFound
 
 Tl3ValueMap = class(Tl3BaseWithIDList, Il3ValueMap)
  {* базовая реализация мап "строка"-что-то. }
  procedure DoGetDisplayNames(const aList: Il3StringsEx);
  function GetMapSize: Integer;
  procedure Create(const aID: Tl3ValueMapID);
  function MapID: Tl3ValueMapID;
   {* Идентификатор мапы. }
  procedure GetDisplayNames(const aList: Il3StringsEx);
   {* заполняет список значениями "UI-строка" }
  function MapSize: Integer;
   {* количество элементов в мапе. }
 end;//Tl3ValueMap
 
implementation

uses
 l3ImplUses
 , l3Base
;

end.
