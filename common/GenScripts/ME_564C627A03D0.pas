unit ddAnnoKindSortItem;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddPipeOutInterfaces
 , l3Interfaces
 , l3LongintList
;

type
 TddAnnoKindSortItem = class(Tl3ProtoObject, IddAnnoKindSortItem)
  procedure Create(const aName: AnsiString;
   aID: Integer);
  function Make(const aName: AnsiString;
   aID: Integer): IddAnnoKindSortItem;
  function Name: Il3CString;
  procedure Add(aTopic: Integer);
  function Count: Integer;
  function Topics: Integer;
  function ID: Integer;
 end;//TddAnnoKindSortItem
 
implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
;

end.
