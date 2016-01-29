unit afwCaret;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AFW"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwCaret.pas"
// Начат: 09.12.1998 16:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::AFW::Visual::TafwCaret
//
// Пара кареток (для окончательного использования).
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  afwInterfaces,
  afwCaretPair,
  l3Interfaces
  ;

type
 TafwCaret = class(TafwCaretPair, IafwCaret)
  {* Пара кареток (для окончательного использования). }
 protected
 // realized methods
   procedure Set_Extent(const aValue: TPoint);
   function Get_Position: Tl3_SPoint;
   procedure Set_Position(const aValue: Tl3_SPoint);
   function Get_Visible: Boolean;
 end;//TafwCaret

implementation

uses
  l3Units
  ;

// start class TafwCaret

procedure TafwCaret.Set_Extent(const aValue: TPoint);
//#UC START# *4728CCBC023F_480DDF270394set_var*
//#UC END# *4728CCBC023F_480DDF270394set_var*
begin
//#UC START# *4728CCBC023F_480DDF270394set_impl*
 CellWidth := aValue.X;
 CellHeight := aValue.Y;
//#UC END# *4728CCBC023F_480DDF270394set_impl*
end;//TafwCaret.Set_Extent

function TafwCaret.Get_Position: Tl3_SPoint;
//#UC START# *4728CCC90157_480DDF270394get_var*
//#UC END# *4728CCC90157_480DDF270394get_var*
begin
//#UC START# *4728CCC90157_480DDF270394get_impl*
 Result := Position;
//#UC END# *4728CCC90157_480DDF270394get_impl*
end;//TafwCaret.Get_Position

procedure TafwCaret.Set_Position(const aValue: Tl3_SPoint);
//#UC START# *4728CCC90157_480DDF270394set_var*
//#UC END# *4728CCC90157_480DDF270394set_var*
begin
//#UC START# *4728CCC90157_480DDF270394set_impl*
 Position := Tl3SPoint(aValue);
//#UC END# *4728CCC90157_480DDF270394set_impl*
end;//TafwCaret.Set_Position

function TafwCaret.Get_Visible: Boolean;
//#UC START# *4728CCD502A9_480DDF270394get_var*
//#UC END# *4728CCD502A9_480DDF270394get_var*
begin
//#UC START# *4728CCD502A9_480DDF270394get_impl*
 Result := Visible;
//#UC END# *4728CCD502A9_480DDF270394get_impl*
end;//TafwCaret.Get_Visible

end.