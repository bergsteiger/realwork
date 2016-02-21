unit evSBSRowCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBSRowCursor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTableRowCursor
 , evColumnBorderMarker
;

type
 TevSBSRowCursor = class(TevTableRowCursor)
  protected
   function GetColumnMarkerClass: RevColumnMarkerClass; override;
 end;//TevSBSRowCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evSBSColumnBorderMarker
;

function TevSBSRowCursor.GetColumnMarkerClass: RevColumnMarkerClass;
//#UC START# *4ED4C5C40177_4ED4C58100B1_var*
//#UC END# *4ED4C5C40177_4ED4C58100B1_var*
begin
//#UC START# *4ED4C5C40177_4ED4C58100B1_impl*
 Result := TevSBSColumnBorderMarker;
//#UC END# *4ED4C5C40177_4ED4C58100B1_impl*
end;//TevSBSRowCursor.GetColumnMarkerClass
{$IfEnd} // Defined(evUseVisibleCursors)

end.
