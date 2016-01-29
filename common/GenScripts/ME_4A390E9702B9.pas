unit evTabIndentMarker;

interface

uses
 l3IntfUses
 , evMarker
 , l3Variant
 , nevTools
 , l3Interfaces
 , nevBase
;

type
 TevTabIndentMarker = class(TevMarker)
  function CheckDecimapSeparatorType: Boolean;
  procedure Create(const aView: InevView;
   aPara: Tl3Variant;
   aTabStopsHolder: Tl3Variant;
   const aHint: Il3CString);
 end;//TevTabIndentMarker
 
implementation

uses
 l3ImplUses
 , k2Base
 , evAlignBySeparatorUtils
 , k2Tags
 , SysUtils
;

end.
