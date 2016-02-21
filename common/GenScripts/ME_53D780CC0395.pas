unit nevParaListInevParaListMapper;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevParaListInevParaListMapper.pas"
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
 TnevParaListInevParaListMapper = class(Tk2InterfaceMapper)
  public
   class function Make(aTag: Tl3Variant;
    const IID: Tl3GUID;
    out Tool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TnevParaListInevParaListMapper
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 , SysUtils
;

class function TnevParaListInevParaListMapper.Make(aTag: Tl3Variant;
 const IID: Tl3GUID;
 out Tool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53D639B601D7_53D780CC0395_var*
var
 l_PL : InevParaList;
//#UC END# *53D639B601D7_53D780CC0395_var*
begin
//#UC START# *53D639B601D7_53D780CC0395_impl*
 if not aTag.QT(InevParaList, l_PL, aProcessor) OR
    not l_PL.AsObject.QT(IID.IID, Tool, aProcessor) then
  Result := false
 else
  Result := true; 
//#UC END# *53D639B601D7_53D780CC0395_impl*
end;//TnevParaListInevParaListMapper.Make
{$IfEnd} // Defined(k2ForEditor)

end.
