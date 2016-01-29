unit afwVirtualCaret;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , afwInterfaces
 , Types
 , l3Interfaces
;

type
 TafwVirtualCaret = class(Tl3CacheableBase, IafwCaret, IafwScrollCaret)
  {* Виртуальная каретка. }
  procedure Create(const anExtent: TafwSPoint);
  function Make(const anExtent: TafwSPoint): IafwScrollCaret;
  function CheckHidden: Boolean;
  function CanHide: Boolean;
  function Extent: TPoint;
  function Position: Tl3_SPoint;
  function Visible: Boolean;
  function Hidden: Boolean;
  function IsInited: Boolean;
  function IsOnScreen: Boolean;
  procedure Scroll(const aOfs: Tl3_SPoint);
  procedure Reset;
 end;//TafwVirtualCaret
 
implementation

uses
 l3ImplUses
 , l3Units
;

end.
