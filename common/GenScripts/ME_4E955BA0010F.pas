unit ddAutolinkDocHistory;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , ddAutolinkDocEntryList
 , ddAutolinkInterfaces
 , dt_Types
;

type
 TddAutolinkDocHistory = class(Tl3ProtoObject)
  procedure Create(aFZType: TDictID;
   aZType: TDictID);
  procedure AddEntry(const anEntry: IddAutolinkDocEntry);
  procedure Clear;
  function FindBySubEntry(const aSubEntry: IddAutolinkDocEntry): Integer;
  procedure MoveToTop(aIndex: Integer);
 end;//TddAutolinkDocHistory
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
;

end.
