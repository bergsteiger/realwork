unit evNodePainter;

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3InternalInterfaces
 , nevTools
 , l3Variant
 , l3Units
;

type
 TevNodePainter = class(Tl3CacheableBase, Il3NodePainter)
  {* Рисователь узлов-параграфов. }
  procedure InternalPaintNode(const aCanvas: Il3Canvas;
   aWidth: Integer;
   aSelStart: Integer;
   aSelEnd: Integer;
   DoInverse: Boolean);
  function GetDocument(aLimitWidth: Integer;
   const aCanvas: Il3InfoCanvas): InevObjectList;
  procedure Create(aTag: Tl3Variant);
  function Make(aTag: Tl3Variant): Il3NodePainter;
  procedure PaintNode(const aCanvas: Il3Canvas;
   const aRect: Tl3Rect;
   aSelStart: Integer;
   aSelEnd: Integer;
   DoInverse: Boolean);
   {* Рисует ноду }
  function CalcHeight(const aCanvas: Il3InfoCanvas;
   aWidth: Integer): Integer;
   {* Считает высоту по ширине. }
  function HintSupported: Boolean;
   {* Надо выводить хинт }
  function GetItemTextIndent(const aCanvas: Il3InfoCanvas;
   aTextHeight: Integer): Integer;
 end;//TevNodePainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , Document_Const
 , l3Base
 , l3VirtualCanvas
 , nevNodeView
 , k2Interfaces
 , evConst
 , nevRealTools
;

end.
