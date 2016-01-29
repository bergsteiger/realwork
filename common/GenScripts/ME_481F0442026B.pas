unit nevLeafRenderInfo;

interface

uses
 l3IntfUses
 , nevParaFormatInfo
 , nevTools
 , nevBase
;

type
 TnevLeafRenderInfo = class(TnevParaFormatInfo)
  procedure DoInvalidateShape(const aShape: InevObject;
   aParts: TnevShapeParts);
 end;//TnevLeafRenderInfo
 
implementation

uses
 l3ImplUses
 , nevFacade
 , l3String
 , evParaTools
 , k2Tags
 , TableCell_Const
 , Block_Const
 , nevFormatInfo
;

end.
