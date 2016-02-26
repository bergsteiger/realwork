unit eeTextPara_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeTextPara_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If Defined(k2ForEditor)}
 , evTextPara_InterfaceFactory
 {$IfEnd} // Defined(k2ForEditor)
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TeeTextParaInterfaceFactory = class(TevTextParaInterfaceFactory)
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TeeTextParaInterfaceFactory
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , eeTextParaCursor
 , eeTextCursorPair
;

function TeeTextParaInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_54BE514101E5_var*
//#UC END# *4D63D26D033F_54BE514101E5_var*
begin
//#UC START# *4D63D26D033F_54BE514101E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_54BE514101E5_impl*
end;//TeeTextParaInterfaceFactory.QueryTool
{$IfEnd} // Defined(Nemesis)

end.
