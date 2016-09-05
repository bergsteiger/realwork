unit evInevParaMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evInevParaMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevInevParaMapper" MUID: (53D8F025001E)

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
 TevInevParaMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevInevParaMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 , nevBase
 //#UC START# *53D8F025001Eimpl_uses*
 //#UC END# *53D8F025001Eimpl_uses*
;

class function TevInevParaMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D8F025001E_var*
var
 l_Para : InevPara;
//#UC END# *53D639B601D7_53D8F025001E_var*
begin
//#UC START# *53D639B601D7_53D8F025001E_impl*
 if not aTag.QT(InevPara, l_Para, aProcessor) then
  Result := false
 else
 if IID.EQ(InevObjectPrim) then
 begin
  InevObjectPrim(Tool) := l_Para;
  Result := true;
 end//IID.EQ(InevObjectPrim)
 else
 if IID.EQ(InevObject) then
 begin
  InevObject(Tool) := l_Para;
  Result := true;
 end//IID.EQ(InevObject)
 else
 if not l_Para.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D8F025001E_impl*
end;//TevInevParaMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
