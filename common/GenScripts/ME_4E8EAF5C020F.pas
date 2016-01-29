unit ddAutolinkInterfaces;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Date
 , ddBaseAutoLinkDataSource
 , dt_Types
 , l3LongintList
;

type
 IddAutolinkDocEntry = interface
  procedure AddSource(aSource: Integer);
  procedure DelSource(anIndex: Integer);
  procedure Clear;
   {* очищает все данные }
  function IsEmpty: Boolean;
   {* ≈сли нет никаких данных... }
  function IsSame(const anEntry: IddAutolinkDocEntry): Boolean;
  function SourcesIdenticalTo(const anEntry: IddAutolinkDocEntry): Boolean;
  function Clone: IddAutolinkDocEntry;
 end;//IddAutolinkDocEntry
 
 IddAutolinkArbitraryDocEntry = interface
 end;//IddAutolinkArbitraryDocEntry
 
implementation

uses
 l3ImplUses
;

end.
