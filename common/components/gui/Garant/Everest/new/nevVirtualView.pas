unit nevVirtualView;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevVirtualView.pas"
// Начат: 17.02.2006 21:23
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Views::TnevVirtualView
//
// Виртуальная область вывода.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevBaseDrawView,
  nevBase
  ;

type
 TnevVirtualView = class(TnevBaseDrawView)
  {* Виртуальная область вывода. }
 protected
 // overridden protected methods
   function GetCanvas(const anExtent: TnevPoint): InevCanvas; override;
 end;//TnevVirtualView

implementation

uses
  l3VirtualCanvas
  ;

// start class TnevVirtualView

function TnevVirtualView.GetCanvas(const anExtent: TnevPoint): InevCanvas;
//#UC START# *4811F0AC0140_4811FD87039D_var*
//#UC END# *4811F0AC0140_4811FD87039D_var*
begin
//#UC START# *4811F0AC0140_4811FD87039D_impl*
 Result := Tl3VirtualCanvas.Make(anExtent);
//#UC END# *4811F0AC0140_4811FD87039D_impl*
end;//TnevVirtualView.GetCanvas

end.