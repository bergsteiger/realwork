unit evToolPanel;

interface

uses
 l3IntfUses
 , vtPanel
 , evVisualInterfaces
 , l3Interfaces
;

type
 TevCustomToolPanel = class(TvtCustomPanel, IevToolWindow)
  {* базовый класс для инструментальных панелей }
  procedure OrientationChanged;
  procedure DoScroll(iD: Tl3Inch);
  procedure Scroll(iD: Tl3Inch);
  procedure Invalidate;
  function Visible: Boolean;
 end;//TevCustomToolPanel
 
implementation

uses
 l3ImplUses
 , Controls
 , TtfwClassRef_Proxy
;

end.
