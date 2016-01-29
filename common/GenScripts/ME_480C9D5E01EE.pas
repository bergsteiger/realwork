unit evPageBreakPainter;

interface

uses
 l3IntfUses
 , evLeafParaPainter
 , l3Interfaces
 , l3Units
 , l3StringIDEx
;

type
 TevPageBreakPainter = class(TevLeafParaPainter)
  {* Реализация инструмента рисования для разрыва страниц. }
  function GetString: Il3CString;
   {* вернуть строчку для отображения. }
  procedure NewPage;
   {* вызывается перед началом новой страницы. }
  procedure DrawLine(const A: Tl3Point;
   const B: Tl3Point);
   {* нарисовать линию разрыва. }
 end;//TevPageBreakPainter
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Const
 , nevBase
 , Graphics
 , l3String
 , l3MessageID
;

end.
