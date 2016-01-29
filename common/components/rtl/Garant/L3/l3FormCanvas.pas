unit l3FormCanvas;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3FormCanvas.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Canvas::Tl3FormCanvas
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3WinControlCanvas
  ;

type
 Tl3FormCanvas = class(Tl3WinControlCanvas)
 public
 // public methods
   constructor Create(aForm: TForm); reintroduce;
 end;//Tl3FormCanvas

implementation

// start class Tl3FormCanvas

constructor Tl3FormCanvas.Create(aForm: TForm);
//#UC START# *4FAE57980326_4F916FD10199_var*
//#UC END# *4FAE57980326_4F916FD10199_var*
begin
//#UC START# *4FAE57980326_4F916FD10199_impl*
 inherited Create(aForm);
 Canvas := aForm.Canvas;
//#UC END# *4FAE57980326_4F916FD10199_impl*
end;//Tl3FormCanvas.Create

end.