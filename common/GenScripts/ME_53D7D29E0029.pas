unit nevLeafParaInevLeafParaMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevLeafParaInevLeafParaMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevLeafParaInevLeafParaMapper" MUID: (53D7D29E0029)

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
 TnevLeafParaInevLeafParaMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevLeafParaInevLeafParaMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 , SysUtils
;

class function TnevLeafParaInevLeafParaMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D7D29E0029_var*
var
 l_TP : InevLeafPara;
//#UC END# *53D639B601D7_53D7D29E0029_var*
begin
//#UC START# *53D639B601D7_53D7D29E0029_impl*
 if not aTag.QT(InevLeafPara, l_TP, aProcessor) OR
    not l_TP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D7D29E0029_impl*
end;//TnevLeafParaInevLeafParaMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
