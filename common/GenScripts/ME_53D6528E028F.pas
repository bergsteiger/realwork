unit nevControlParaModelControlMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevControlParaModelControlMapper.pas"
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
 TnevControlParaModelControlMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlParaModelControlMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , SysUtils
;

class function TnevControlParaModelControlMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D6528E028F_var*
//#UC END# *53D639B601D7_53D6528E028F_var*
begin
//#UC START# *53D639B601D7_53D6528E028F_impl*
 if not Supports(IUnknown(aTag.IntA[k2_tiModelControl]), IID.IID, Tool) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D6528E028F_impl*
end;//TnevControlParaModelControlMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
