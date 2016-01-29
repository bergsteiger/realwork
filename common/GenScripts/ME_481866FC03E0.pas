unit nevObjectHolder;

interface

uses
 l3IntfUses
 , nevObjectHolderPrim
 , nevTools
 , nevBase
;

type
 TnevObjectHolder = class(TnevObjectHolderPrim)
  procedure Create(const anObject: InevObject);
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
  function GetTagReader: InevTagReader;
  function GetTagWriter: InevTagWriter;
 end;//TnevObjectHolder
 
implementation

uses
 l3ImplUses
 , l3SimpleObject
;

end.
