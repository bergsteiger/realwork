unit evBitmapParaCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/evBitmapParaCursor.pas"
// Начат: 13.11.2004 18:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevBitmapParaCursor
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
  evSolidParaCursor
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevBitmapParaCursor = class(TevSolidParaCursor)
 protected
 // overridden protected methods
   function GetNeedWindowsCaret: Boolean; override;
 end;//TevBitmapParaCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}

// start class TevBitmapParaCursor

function TevBitmapParaCursor.GetNeedWindowsCaret: Boolean;
//#UC START# *49E34A6301AC_49DF6D240199_var*
//#UC END# *49E34A6301AC_49DF6D240199_var*
begin
//#UC START# *49E34A6301AC_49DF6D240199_impl*
 Result := false;
//#UC END# *49E34A6301AC_49DF6D240199_impl*
end;//TevBitmapParaCursor.GetNeedWindowsCaret

{$IfEnd} //evUseVisibleCursors

end.