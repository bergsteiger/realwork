unit evReqRowModelControlMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\evReqRowModelControlMapper.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevReqRowModelControlMapper" MUID: (53D668DE0251)

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
 TevReqRowModelControlMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevReqRowModelControlMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , SysUtils
 , k2Tags
 //#UC START# *53D668DE0251impl_uses*
 //#UC END# *53D668DE0251impl_uses*
;

class function TevReqRowModelControlMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D668DE0251_var*
//#UC END# *53D639B601D7_53D668DE0251_var*
begin
//#UC START# *53D639B601D7_53D668DE0251_impl*
 if not Supports(IUnknown(aTag.IntA[k2_tiModelControl]), IID.IID, Tool) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D668DE0251_impl*
end;//TevReqRowModelControlMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
