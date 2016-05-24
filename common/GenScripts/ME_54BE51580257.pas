unit eeDocument_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeDocument_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TeeDocument" MUID: (54BE51580257)
// Имя типа: "TeeDocumentInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 {$If Defined(k2ForEditor)}
 , evDocument_InterfaceFactory
 {$IfEnd} // Defined(k2ForEditor)
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TeeDocumentInterfaceFactory = class({$If Defined(k2ForEditor)}
 TevDocumentInterfaceFactory
 {$IfEnd} // Defined(k2ForEditor)
 )
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TeeDocumentInterfaceFactory
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , eeDocumentCursor
 , eeDocumentCursorPair
 , Document
;

{$If Defined(k2ForEditor)}
function TeeDocumentInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_54BE51580257_var*
//#UC END# *4D63D26D033F_54BE51580257_var*
begin
//#UC START# *4D63D26D033F_54BE51580257_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_54BE51580257_impl*
end;//TeeDocumentInterfaceFactory.QueryTool
{$IfEnd} // Defined(k2ForEditor)

{$IfEnd} // Defined(Nemesis)
end.
