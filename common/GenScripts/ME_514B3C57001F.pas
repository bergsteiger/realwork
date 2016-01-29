unit vtHeader;

interface

uses
 l3IntfUses
;

type
 TvtCustomHeader = class
 end;//TvtCustomHeader
 
 TvtHeader = class(TvtCustomHeader)
 end;//TvtHeader
 
 TGetItemImageIndex = function(Sender: TObject;
  Index: LongInt): Integer of object;
 
implementation

uses
 l3ImplUses
;

end.
