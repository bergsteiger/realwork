unit l3RecListWithPartialFind;

interface

uses
 l3IntfUses
 , l3ProtoPtrRecListPrim
 , l3Types
;

type
 Tl3DataAndSize = record
 end;//Tl3DataAndSize
 
 Tl3RecListWithPartialFind = class(Tl3ProtoPtrRecListPrim)
  function FindPart(aData;
   aDataSize: Cardinal;
   out theIndex: Integer): Boolean;
   {* поиск по началу записи, размер сравниваемых данных в aDataSize }
 end;//Tl3RecListWithPartialFind
 
implementation

uses
 l3ImplUses
;

end.
