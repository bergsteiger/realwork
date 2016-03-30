unit nevTextParaInevTextParaMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevTextParaInevTextParaMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevTextParaInevTextParaMapper" MUID: (53D78F15032B)

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
 TnevTextParaInevTextParaMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevTextParaInevTextParaMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
;

class function TnevTextParaInevTextParaMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D78F15032B_var*
var
 l_TP : InevTextPara;
//#UC END# *53D639B601D7_53D78F15032B_var*
begin
//#UC START# *53D639B601D7_53D78F15032B_impl*
 if not aTag.QT(InevTextPara, l_TP, aProcessor) OR
    not l_TP.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D78F15032B_impl*
end;//TnevTextParaInevTextParaMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
