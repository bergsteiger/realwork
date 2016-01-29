unit vtPopupForm;

interface

uses
 l3IntfUses
 , Forms
 , vg_scene
 , vg_controls
 , vg_layouts
 , Classes
 , vtPanel
 , Messages
 , Controls
 , Types
;

type
 TvtTailPosition = (
  vtTailTop
  , vtTailLeft
  , vtTailBottom
  , vtTailRight
 );//TvtTailPosition
 
 TvtCurrentBounds = array [TvtTailPosition] of TRect;
 
 TvtPopupForm = class(TCustomForm)
  procedure AdjustBalloonSize(const a_TailPosition: TvtTailPosition;
   a_FontSize: Integer;
   a_WidthIn: Integer;
   a_HeightIn: Integer;
   out a_WidthOut: Integer;
   out a_HeightOut: Integer);
   {* По ширине и высоте вдоченного редактора высчитываем ширину и высоту всего баллона. }
  procedure PanelGetSiteInfo(Sender: TObject;
   DockClient: TControl;
   var InfluenceRect: TRect;
   MousePos: TPoint;
   var CanDock: Boolean);
  procedure CMVisibleChanged(var Message: TMessage);
 end;//TvtPopupForm
 
implementation

uses
 l3ImplUses
 , l3Defaults
 , vg_objects
 , Windows
 , afwFacade
 , vgTypes
 , vtVGSceneRes
 , vcmDockTree
 , TtfwClassRef_Proxy
;

type
 THackWinControl = class(TWinControl)
 end;//THackWinControl
 
end.
