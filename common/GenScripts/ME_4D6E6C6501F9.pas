unit nevAutoreferatDocumentAnchor;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevAutoreferatDocumentAnchor.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\new\nevDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaListAnchor
 , nevTools
 {$If Defined(evUseVisibleCursors)}
 , nevParaListAnchorModifyTypes
 {$IfEnd} // Defined(evUseVisibleCursors)
;

type
 TnevAutoreferatDocumentAnchor = class(TnevParaListAnchor)
  protected
   {$If Defined(evUseVisibleCursors)}
   function DoIncLine(const aView: InevView;
    var theLine: Integer;
    aSmall: Boolean;
    const aChildrenInfo: TnevChildrenInfo): Integer; override;
   {$IfEnd} // Defined(evUseVisibleCursors)
 end;//TnevAutoreferatDocumentAnchor
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
;

{$If Defined(evUseVisibleCursors)}
function TnevAutoreferatDocumentAnchor.DoIncLine(const aView: InevView;
 var theLine: Integer;
 aSmall: Boolean;
 const aChildrenInfo: TnevChildrenInfo): Integer;
//#UC START# *4B1D18650208_4D6E6C6501F9_var*
//#UC END# *4B1D18650208_4D6E6C6501F9_var*
begin
//#UC START# *4B1D18650208_4D6E6C6501F9_impl*
 if not aSmall AND
    aChildrenInfo.rLinear AND
    (Abs(theLine) > aChildrenInfo.rLeafCount * 2) then
  Result := 0
 else
  Result := inherited DoIncLine(aView, theLine, aSmall, aChildrenInfo);
//#UC END# *4B1D18650208_4D6E6C6501F9_impl*
end;//TnevAutoreferatDocumentAnchor.DoIncLine
{$IfEnd} // Defined(evUseVisibleCursors)

{$IfEnd} // Defined(k2ForEditor)
end.
