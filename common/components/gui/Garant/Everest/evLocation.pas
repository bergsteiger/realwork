unit evLocation;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evLocation.pas"
// Начат: 01.06.2005 18:11
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevLocation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  nevTools,
  evLocationBase
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevLocation = class(TevLocationBase, InevText)
 protected
 // realized methods
   function CanBeDeleted: Boolean;
   function Modify: InevTextModify;
 protected
 // overridden protected methods
   function GetText: InevText; override;
 end;//TevLocation
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}

// start class TevLocation

function TevLocation.CanBeDeleted: Boolean;
//#UC START# *47C5B23101DE_4A3A5B9F0064_var*
//#UC END# *47C5B23101DE_4A3A5B9F0064_var*
begin
//#UC START# *47C5B23101DE_4A3A5B9F0064_impl*
 Result := GetCanBeDeleted;
//#UC END# *47C5B23101DE_4A3A5B9F0064_impl*
end;//TevLocation.CanBeDeleted

function TevLocation.Modify: InevTextModify;
//#UC START# *47C5B23D0301_4A3A5B9F0064_var*
//#UC END# *47C5B23D0301_4A3A5B9F0064_var*
begin
//#UC START# *47C5B23D0301_4A3A5B9F0064_impl*
 Result := Self;
//#UC END# *47C5B23D0301_4A3A5B9F0064_impl*
end;//TevLocation.Modify

function TevLocation.GetText: InevText;
//#UC START# *4A3A69AC006F_4A3A5B9F0064_var*
//#UC END# *4A3A69AC006F_4A3A5B9F0064_var*
begin
//#UC START# *4A3A69AC006F_4A3A5B9F0064_impl*
 Result := Self;
//#UC END# *4A3A69AC006F_4A3A5B9F0064_impl*
end;//TevLocation.GetText

{$IfEnd} //evUseVisibleCursors

end.