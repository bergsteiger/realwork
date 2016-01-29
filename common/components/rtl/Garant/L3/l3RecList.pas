unit l3RecList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "L3"
// Модуль: "w:/common/components/rtl/Garant/L3/l3RecList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::RecLists::Tl3RecList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3BaseRecList
  ;

type
 Tl3RecList = class(Tl3BaseRecList)
 private
 // private fields
   f_ItemSize : Integer;
 protected
 // realized methods
   function pm_GetItemSize: Integer; override;
 public
 // public methods
   constructor Create(anItemSize: Integer); reintroduce;
 end;//Tl3RecList

implementation

// start class Tl3RecList

constructor Tl3RecList.Create(anItemSize: Integer);
//#UC START# *479F111E032C_479F10C70202_var*
//#UC END# *479F111E032C_479F10C70202_var*
begin
//#UC START# *479F111E032C_479F10C70202_impl*
 inherited Create;
 f_ItemSize := anItemSize;
//#UC END# *479F111E032C_479F10C70202_impl*
end;//Tl3RecList.Create

function Tl3RecList.pm_GetItemSize: Integer;
//#UC START# *47BEE7FD01DC_479F10C70202get_var*
//#UC END# *47BEE7FD01DC_479F10C70202get_var*
begin
//#UC START# *47BEE7FD01DC_479F10C70202get_impl*
 Result := f_ItemSize;
//#UC END# *47BEE7FD01DC_479F10C70202get_impl*
end;//Tl3RecList.pm_GetItemSize

end.