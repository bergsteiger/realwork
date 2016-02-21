unit nevControlsBlockModelControlMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevControlsBlockModelControlMapper.pas"
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
 TnevControlsBlockModelControlMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevControlsBlockModelControlMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , SysUtils
;

class function TnevControlsBlockModelControlMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D638200108_var*
//#UC END# *53D639B601D7_53D638200108_var*
begin
//#UC START# *53D639B601D7_53D638200108_impl*
 if not Supports(IUnknown(aTag.IntA[k2_tiModelControl]), IID.IID, Tool) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D638200108_impl*
end;//TnevControlsBlockModelControlMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
