unit evIevAnchorIndexMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evIevAnchorIndexMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevIevAnchorIndexMapper" MUID: (53D8EE9F00BC)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , k2InterfaceMapper
 , l3Variant
 , l3IID
;

type
 TevIevAnchorIndexMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevIevAnchorIndexMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *53D8EE9F00BCimpl_uses*
 //#UC END# *53D8EE9F00BCimpl_uses*
;

class function TevIevAnchorIndexMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8EE9F00BC_var*
//#UC END# *53D639B601D7_53D8EE9F00BC_var*
begin
//#UC START# *53D639B601D7_53D8EE9F00BC_impl*
 if not aTag.Owner.QT(IID.IID, Tool, aProcessor) then
 // - спросим родителя
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8EE9F00BC_impl*
end;//TevIevAnchorIndexMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
