unit tb97Ctls;

interface

uses
 l3IntfUses
 , tb97GraphicControl
 , Types
 , Forms
 , Controls
;

type
 TCustomToolbarButton97 = class(Ttb97GraphicTextControl)
  function IsGtbToolbarButtonSizeNeeded: Boolean;
  function GetIsAutoCenter: Boolean;
  procedure CalcSize(var aSize: TSize);
  function NeedAutoDown: Boolean;
  function AutoAllUp: Boolean;
 end;//TCustomToolbarButton97
 
 TToolbarButton97 = class(TCustomToolbarButton97)
 end;//TToolbarButton97
 
 TCustomToolbarPanel97 = class(TCustomToolbarButton97)
 end;//TCustomToolbarPanel97
 
 TSizeGripPanel = class(TCustomToolbarPanel97)
  function GetFormToResize: TCustomForm;
 end;//TSizeGripPanel
 
 TToolbarButton97ActionLink = class(TControlActionLink)
 end;//TToolbarButton97ActionLink
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , tb97WordsPack
;

end.
