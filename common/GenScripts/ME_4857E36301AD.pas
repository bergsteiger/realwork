unit evSBS_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evSBS_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"
// Элемент модели: "TevSBS" MUID: (4857E36301AD)
// Имя типа: "TevSBSInterfaceFactory"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evTable_InterfaceFactory
 , l3Variant
 , l3IID
;

type
 TevSBSInterfaceFactory = class(TevTableInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevSBSInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevRealTools
 {$If Defined(evNeedPainters)}
 , evSBSPainter
 {$IfEnd} // Defined(evNeedPainters)
 , SBS_Const
 //#UC START# *4857E36301ADimpl_uses*
 //#UC END# *4857E36301ADimpl_uses*
;

function TevSBSInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4857E36301AD_var*
//#UC END# *53CCBDA5026D_4857E36301AD_var*
begin
//#UC START# *53CCBDA5026D_4857E36301AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4857E36301AD_impl*
end;//TevSBSInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
