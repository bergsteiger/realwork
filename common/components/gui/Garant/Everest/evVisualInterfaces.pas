unit evVisualInterfaces;

// Модуль: "w:\common\components\gui\Garant\Everest\evVisualInterfaces.pas"
// Стереотип: "Interfaces"
// Элемент модели: "evVisualInterfaces" MUID: (547C9F6D029C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Units
 , nevTools
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
;

type
 IevToolWindow = interface
  ['{24069554-CCF1-4F74-924A-CD604876ED4A}']
  function pm_GetVisible: Boolean;
  procedure pm_SetVisible(aValue: Boolean);
  procedure Scroll(iD: Tl3Inch);
  procedure Invalidate;
  property Visible: Boolean
   read pm_GetVisible
   write pm_SetVisible;
 end;//IevToolWindow

 IevLinkedToolWindow = interface(IevToolWindow)
  ['{E478C43E-C7CA-4967-BB4C-690E3FB89782}']
  function pm_GetControl: TWinControl;
  procedure pm_SetControl(aValue: TWinControl);
  property Control: TWinControl
   read pm_GetControl
   write pm_SetControl;
   {* управляющий элемент, к которому привязана панель. }
 end;//IevLinkedToolWindow

 IevZoomedLinkedToolWindow = interface(IevLinkedToolWindow)
  ['{EA309B79-4F35-4C80-879E-D19BC4654F3C}']
  function pm_GetZoom: SmallInt;
  procedure pm_SetZoom(aValue: SmallInt);
  property Zoom: SmallInt
   read pm_GetZoom
   write pm_SetZoom;
 end;//IevZoomedLinkedToolWindow

 IevSubPanel = interface(IevZoomedLinkedToolWindow)
  ['{14C0338E-1370-4504-AE4E-89C994E9E2AC}']
  procedure NeedDrawSub(const aR: Tl3Rect;
   const aSub: IevSub);
 end;//IevSubPanel

 TevOnSetMarker = procedure(aSender: TObject;
  const aMarker: IevMarker;
  aValue: Integer) of object;

 IevRuler = interface(IevZoomedLinkedToolWindow)
  ['{F2A24FCB-171C-4DB8-A4FA-202396805059}']
  procedure pm_SetMargin(aValue: Integer);
  procedure pm_SetDelta(aValue: Integer);
  procedure pm_SetOnSetMarker(aValue: TevOnSetMarker);
  procedure MarkersChanged(const aView: InevView;
   const aCursor: IevMarkersSource);
  procedure ViewChanged(const aView: InevView);
  procedure ControlMoved;
  property Margin: Integer
   write pm_SetMargin;
  property Delta: Integer
   write pm_SetDelta;
  property OnSetMarker: TevOnSetMarker
   write pm_SetOnSetMarker;
 end;//IevRuler

implementation

uses
 l3ImplUses
;

end.
