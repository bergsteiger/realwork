unit NOT_FINISHED_l3Drawer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Жучков А.Ю.
// Модуль: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3Drawer.pas"
// Начат: 2007/11/06 09:34:31
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3Drawer::l3Drawer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Interfaces,
  l3Core,
  Graphics,
  l3ProtoObject
  ;

type
 Tl3DrawerMode = (
   l3_dmGDIPlus
 , l3_dmGDI
 );//Tl3DrawerMode

 Tl3Drawer = class(Tl3ProtoObject)
  {* "Универсальный отрисовщик", использующий по возможности функции GDI+ }
 protected
 // protected fields
   Canvas : TCanvas;
    {* Канва для рисования.}
 public
 // public fields
   PenColor : Tl3Color;
   BrushColor : Tl3Color;
   Mode : Tl3DrawerMode;
 public
 // public methods
   procedure DrawLine(X1: Integer;
    Y1: Integer;
    X2: Integer;
    Y2: Integer); virtual;
   procedure DrawEllipse(X1: Integer;
    Y1: Integer;
    X2: Integer;
    Y2: Integer); virtual;
   procedure DrawRect(X1: Integer;
    Y1: Integer;
    X2: Integer;
    Y2: Integer); virtual;
   procedure DrawPolygon(const Points: array of TPoint); virtual;
   procedure FillEllipse(X1: Integer;
    Y1: Integer;
    X2: Integer;
    Y2: Integer); virtual;
   procedure FillRect(X1: Integer;
    Y1: Integer;
    X2: Integer;
    Y2: Integer); virtual;
   procedure FillPolygon(const Points: array of TPoint); virtual;
 end;//Tl3Drawer

implementation

// start class Tl3Drawer

procedure Tl3Drawer.DrawLine(X1: Integer;
  Y1: Integer;
  X2: Integer;
  Y2: Integer);
//#UC START# *4739AC0801D9_4739ABDB029D_var*
//#UC END# *4739AC0801D9_4739ABDB029D_var*
begin
//#UC START# *4739AC0801D9_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.DrawLine not implemented');
//#UC END# *4739AC0801D9_4739ABDB029D_impl*
end;//Tl3Drawer.DrawLine

procedure Tl3Drawer.DrawEllipse(X1: Integer;
  Y1: Integer;
  X2: Integer;
  Y2: Integer);
//#UC START# *4739AC7E016B_4739ABDB029D_var*
//#UC END# *4739AC7E016B_4739ABDB029D_var*
begin
//#UC START# *4739AC7E016B_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.DrawEllipse not implemented');
//#UC END# *4739AC7E016B_4739ABDB029D_impl*
end;//Tl3Drawer.DrawEllipse

procedure Tl3Drawer.DrawRect(X1: Integer;
  Y1: Integer;
  X2: Integer;
  Y2: Integer);
//#UC START# *4739AC99032C_4739ABDB029D_var*
//#UC END# *4739AC99032C_4739ABDB029D_var*
begin
//#UC START# *4739AC99032C_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.DrawRect not implemented');
//#UC END# *4739AC99032C_4739ABDB029D_impl*
end;//Tl3Drawer.DrawRect

procedure Tl3Drawer.DrawPolygon(const Points: array of TPoint);
//#UC START# *4739ACBB02E5_4739ABDB029D_var*
//#UC END# *4739ACBB02E5_4739ABDB029D_var*
begin
//#UC START# *4739ACBB02E5_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.DrawPolygon not implemented');
//#UC END# *4739ACBB02E5_4739ABDB029D_impl*
end;//Tl3Drawer.DrawPolygon

procedure Tl3Drawer.FillEllipse(X1: Integer;
  Y1: Integer;
  X2: Integer;
  Y2: Integer);
//#UC START# *4739ADEF01F7_4739ABDB029D_var*
//#UC END# *4739ADEF01F7_4739ABDB029D_var*
begin
//#UC START# *4739ADEF01F7_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.FillEllipse not implemented');
//#UC END# *4739ADEF01F7_4739ABDB029D_impl*
end;//Tl3Drawer.FillEllipse

procedure Tl3Drawer.FillRect(X1: Integer;
  Y1: Integer;
  X2: Integer;
  Y2: Integer);
//#UC START# *4739AE3300F1_4739ABDB029D_var*
//#UC END# *4739AE3300F1_4739ABDB029D_var*
begin
//#UC START# *4739AE3300F1_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.FillRect not implemented');
//#UC END# *4739AE3300F1_4739ABDB029D_impl*
end;//Tl3Drawer.FillRect

procedure Tl3Drawer.FillPolygon(const Points: array of TPoint);
//#UC START# *4739AE6C0279_4739ABDB029D_var*
//#UC END# *4739AE6C0279_4739ABDB029D_var*
begin
//#UC START# *4739AE6C0279_4739ABDB029D_impl*
 assert(false, 'Tl3Drawer.FillPolygon not implemented');
//#UC END# *4739AE6C0279_4739ABDB029D_impl*
end;//Tl3Drawer.FillPolygon

end.