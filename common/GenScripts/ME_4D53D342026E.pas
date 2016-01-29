unit HotSpotTools.imp;

interface

uses
 l3IntfUses
 , nevGUIInterfaces
 , evCustomEditorWindow
 , l3Units
;

type
 _HotSpotTools_ = class
  {* Работа с хотспотом }
  function GetHotSpot(aText: TevCustomEditorWindow;
   const aPoint: Tl3Point;
   aMoveLeft: Boolean): IevHotSpot;
   {* Получить курсор по точке. }
 end;//_HotSpotTools_
 
implementation

uses
 l3ImplUses
 , nevTools
 , l3Base
;

end.
