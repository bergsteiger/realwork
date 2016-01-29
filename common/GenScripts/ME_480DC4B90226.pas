unit afwCustomCaretType;

interface

uses
 l3IntfUses
 , l3_Base
 , Classes
 , Graphics
;

type
 TafwCaretShape = (
  {* ����� �������. }
  csBlock
   {* block over whole cell }
  , csHalfBlock
   {* block over bottom part of cell }
  , csVertLine
   {* vertical line to left of cell }
  , csHorzLine
   {* horizontal line on bottom of cell }
  , csCustom
   {* custom width/height }
  , csBitmap
   {* bitmap caret, custom width/height }
 );//TafwCaretShape
 
 TafwCaretAlign = (
  {* ������������ �������. }
  caLeft
   {* left side, centered vertically }
  , caTop
   {* top side, centered horizontally }
  , caRight
   {* right side, centered vertically }
  , caBottom
   {* bottom side, centered horizontally }
  , caCenter
   {* centered vertically and horizontally }
 );//TafwCaretAlign
 
 TafwCustomCaretType = class(Tl3_Base)
  {* ��� ����� �������. }
  procedure Create;
  procedure NotifyChange;
 end;//TafwCustomCaretType
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Bitmap
;

end.
