unit evSBSRowCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evSBSRowCursor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevSBSRowCursor
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
  evTableRowCursor,
  evColumnBorderMarker
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevSBSRowCursor = class(TevTableRowCursor)
 protected
 // overridden protected methods
   function GetColumnMarkerClass: RevColumnMarkerClass; override;
 end;//TevSBSRowCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  evSBSColumnBorderMarker
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevSBSRowCursor

function TevSBSRowCursor.GetColumnMarkerClass: RevColumnMarkerClass;
//#UC START# *4ED4C5C40177_4ED4C58100B1_var*
//#UC END# *4ED4C5C40177_4ED4C58100B1_var*
begin
//#UC START# *4ED4C5C40177_4ED4C58100B1_impl*
 Result := TevSBSColumnBorderMarker;
//#UC END# *4ED4C5C40177_4ED4C58100B1_impl*
end;//TevSBSRowCursor.GetColumnMarkerClass

{$IfEnd} //evUseVisibleCursors

end.