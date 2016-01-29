unit nevSegmentFormatInfo;

interface

uses
 l3IntfUses
 , nevFormatInfo
 , nevTools
 , nevBase
 , evResultFontInterfaces
;

type
 TnevSegmentFormatInfo = class(TnevFormatInfo)
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//TnevSegmentFormatInfo
 
implementation

uses
 l3ImplUses
 , l3Base
 , k2Const
 , l3Interfaces
 , k2Tags
 , evResultFontHolder
;

end.
