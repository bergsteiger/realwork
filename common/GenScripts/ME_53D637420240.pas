unit nevControlsBlockIevCommonControlMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevControlsBlockIevCommonControlMapper.pas"
// Стереотип: "SimpleClass"

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
 TnevControlsBlockIevCommonControlMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlsBlockIevCommonControlMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , SysUtils
 , nevTools
;

class function TnevControlsBlockIevCommonControlMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D637420240_var*
var
 l_CP: IevCommonControl;
//#UC END# *53D639B601D7_53D637420240_var*
begin
//#UC START# *53D639B601D7_53D637420240_impl*
 if not aTag.QT(IevCommonControl, l_CP, aProcessor) OR
    not l_CP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D637420240_impl*
end;//TnevControlsBlockIevCommonControlMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
