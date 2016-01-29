unit ddExportFilerMap;

interface

uses
 l3IntfUses
 , ddPipeOutInterfaces
;

type
 TddExportFilerMap = class(_l3Map_)
  function CompareKeys(const aA: _KeyType_;
   const aB: _KeyType_): Integer;
 end;//TddExportFilerMap
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
