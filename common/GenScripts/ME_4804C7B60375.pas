unit evLeafParaPainterPrim.imp;

interface

uses
 l3IntfUses
 , l3InternalInterfaces
 , nevTools
;

type
 _evLeafParaPainterPrim_ = class(_evParaPainter_)
  {* ������� ���������� ��������� ����������. }
  function GetBitmapForPara: Il3Bitmap;
  function DrawPicture: Boolean;
   {* ������ �������� � ��������� - Para �� ����� CN �� �������� aTop. }
  function DrawLeaf: Boolean;
 end;//_evLeafParaPainterPrim_
 
implementation

uses
 l3ImplUses
 , l3Units
 , k2Tags
 , evdTypes
 , nevAfterEndPoint
 , Graphics
 , l3SmartCanvas
 , l3MinMax
 , l3Base
 , l3Tree
 , evParaTools
 , TableCell_Const
 , DocumentSub_Const
 , Mark_Const
 , LeafPara_Const
 , CommentPara_Const
 , Block_Const
 , TextPara_Const
 , k2Base
 , SysUtils
 , Table_Const
 , Windows
;

end.
