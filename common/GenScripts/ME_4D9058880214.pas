unit vtPopupFormModelPart;

interface

uses
 l3IntfUses
 , vtPopupForm
 , vcmExternalInterfaces
 , Controls
 , Types
;

type
 TTailRects = array [TvtTailPosition] of TRect;
 
 TPopupFormBoundsRects = record
 end;//TPopupFormBoundsRects
 
 TvtPopupFormModelPart = class(TvtPopupForm, IvcmDatasourceChangeListener)
  procedure DataSourceChanged(aControl: TControl);
 end;//TvtPopupFormModelPart
 
implementation

uses
 l3ImplUses
 , SysUtils
 , TtfwClassRef_Proxy
;

end.
