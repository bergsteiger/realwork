unit vgCustomObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgCustomObject.pas"
// Начат: 10.02.2011 20:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Core::TvgCustomObject
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  vgComponent
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 TvgCustomObject = {abstract} class(TvgComponent)
 protected
 // property methods
   function pm_GetIsVisual: Boolean; virtual; abstract;
 public
 // public properties
   property IsVisual: Boolean
     read pm_GetIsVisual;
 end;//TvgCustomObject
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}


{$IfEnd} //not NoVGScene
end.