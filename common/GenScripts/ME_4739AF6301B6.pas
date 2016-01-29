unit l3Drawer;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , Graphics
 , l3Interfaces
 , l3Core
;

type
 Tl3DrawerMode = (
  l3_dmGDIPlus
  , l3_dmGDI
 );//Tl3DrawerMode
 
 Tl3Drawer = class(Tl3ProtoObject)
  {* "”ниверсальный отрисовщик", использующий по возможности функции GDI+ }
  procedure DrawLine(X1: Integer;
   Y1: Integer;
   X2: Integer;
   Y2: Integer);
  procedure DrawEllipse(X1: Integer;
   Y1: Integer;
   X2: Integer;
   Y2: Integer);
  procedure DrawRect(X1: Integer;
   Y1: Integer;
   X2: Integer;
   Y2: Integer);
  procedure DrawPolygon(const Points: TPointsArray);
  procedure FillEllipse(X1: Integer;
   Y1: Integer;
   X2: Integer;
   Y2: Integer);
  procedure FillRect(X1: Integer;
   Y1: Integer;
   X2: Integer;
   Y2: Integer);
  procedure FillPolygon(const Points: TPointsArray);
 end;//Tl3Drawer
 
implementation

uses
 l3ImplUses
;

end.
