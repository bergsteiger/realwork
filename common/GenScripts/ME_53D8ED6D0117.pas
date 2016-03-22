unit evInevBaseLine4AnchorMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\evInevBaseLine4AnchorMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevInevBaseLine4AnchorMapper" MUID: (53D8ED6D0117)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevInevBaseLine4AnchorMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevBaseLine4AnchorMapper
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , nevTools
;

class function TevInevBaseLine4AnchorMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8ED6D0117_var*
//#UC END# *53D639B601D7_53D8ED6D0117_var*
begin
//#UC START# *53D639B601D7_53D8ED6D0117_impl*
 if not aTag.QT(InevPoint, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8ED6D0117_impl*
end;//TevInevBaseLine4AnchorMapper.Make
{$IfEnd} // Defined(evUseVisibleCursors)

end.
