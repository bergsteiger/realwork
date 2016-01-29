unit destColorTable;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ProtoDataContainer
 , ddRTFdestination
 , Graphics
 , ddRTFState
 , RTFtypes
 , l3Base
 , ddCustomRTFReader
;

type
 TddColorEntry = class(Tl3ProtoObject)
 end;//TddColorEntry
 
 TddColorEntryList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TddColorEntryList
 
 TdestColorTable = class(TddRTFDestination)
  function ColorByIndex(aColorIndex: Integer): TColor;
  procedure Close(aState: TddRTFState;
   aNewDest: TddRTFDestination);
  procedure WriteText(aRDS: TRDS;
   aText: Tl3String;
   aState: TddRTFState);
 end;//TdestColorTable
 
implementation

uses
 l3ImplUses
 , Windows
 , ddTypes
 , Math
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
