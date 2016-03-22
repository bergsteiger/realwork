unit l3Canvas;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/L3/l3Canvas.pas"
// Начат: 15.12.1996
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3Canvas
//
// попытка реализации своего уровня абстракции над DeviceContext.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Windows,
  Graphics,
  l3Interfaces,
  l3Defaults,
  l3InternalInterfaces,
  l3CanvasPrim
  ;

type
//#UC START# *478E3C97021Eci*
//#UC END# *478E3C97021Eci*
//#UC START# *478E3C97021Ecit*
//#UC END# *478E3C97021Ecit*
 Tl3Canvas = {final} class(Tl3CanvasPrim)
  {* попытка реализации своего уровня абстракции над DeviceContext. }
//#UC START# *478E3C97021Epubl*
 public
   property etoFlags default eto_Opaque;
   property BackColor default def_PaperColor;
   property Font: Il3Font
     read Get_Font
     write Set_Font;
   property TextColor default clBlack;
   property PageWidthNumber: Integer
     read pm_GetPageWidthNumber;
   property DrawSpecial default false;
   property Zoom default def_Zoom;
//#UC END# *478E3C97021Epubl*
 end;//Tl3Canvas

implementation


//#UC START# *478E3C97021Eimpl*
//#UC END# *478E3C97021Eimpl*
end.