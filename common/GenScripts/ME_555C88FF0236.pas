unit m3DBFiler;

interface

uses
 l3IntfUses
 , l3Filer
 , m3DBInterfaces
;

type
 Tm3DBFiler = class(Tl3CustomFiler)
  procedure Create(const aDB: Im3DB;
   aDocID: Integer;
   aDocPart: Tm3DocPartSelector;
   aLevel: Integer);
 end;//Tm3DBFiler
 
implementation

uses
 l3ImplUses
 , l3Types
 , l3Base
 , m3StorageInterfaces
;

end.
