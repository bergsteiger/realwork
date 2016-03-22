unit evQueryCard_InterfaceFactory;
 {* "фабрика интерфейсов" для новой КЗ. }

// Модуль: "w:\common\components\gui\Garant\Everest\evQueryCard_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevQueryCard" MUID: (4857E8F003A2)
// Имя типа: "TevQueryCardInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evDocument_InterfaceFactory
 , l3Variant
 , l3IID
 , k2ToolPrim
;

type
 TevQueryCardInterfaceFactory = class(TevDocumentInterfaceFactory)
  {* "фабрика интерфейсов" для новой КЗ. }
  public
   function QueryTool(aTag: Tl3Variant;
    const ID: Tl3IID;
    out I: Tk2ToolPrim): Boolean; override;
 end;//TevQueryCardInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 {$If Defined(evUseVisibleCursors)}
 , evQueryCardCursor
 {$IfEnd} // Defined(evUseVisibleCursors)
;

function TevQueryCardInterfaceFactory.QueryTool(aTag: Tl3Variant;
 const ID: Tl3IID;
 out I: Tk2ToolPrim): Boolean;
//#UC START# *4D63D26D033F_4857E8F003A2_var*
//#UC END# *4D63D26D033F_4857E8F003A2_var*
begin
//#UC START# *4D63D26D033F_4857E8F003A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D63D26D033F_4857E8F003A2_impl*
end;//TevQueryCardInterfaceFactory.QueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
