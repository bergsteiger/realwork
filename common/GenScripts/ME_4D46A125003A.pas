unit vtOutlinerControl;

interface

uses
 l3IntfUses
 , vtOutliner
;

type
 TvtOutlinerControl = class(TvtCustomOutliner)
  procedure Invalidate;
   {* Запрос на перерисовку. }
 end;//TvtOutlinerControl
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
