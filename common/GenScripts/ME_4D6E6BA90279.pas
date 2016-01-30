unit evAutoreferatDocument_InterfaceFactory;

// Модуль: "w:\common\components\gui\Garant\Everest\evAutoreferatDocument_InterfaceFactory.pas"
// Стереотип: "InterfaceFactory"

{$Include evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , evDocument_InterfaceFactory
 , AutoreferatDocument_Const
 , l3Variant
 , l3IID
;

type
 TevAutoreferatDocumentInterfaceFactory = class(TevDocumentInterfaceFactory)
  protected
   function COMQueryTool(aTag: Tl3Tag;
    const aIID: Tl3GUID;
    out theTool;
    const aProcessor: Ik2Processor): Boolean; override;
 end;//TevAutoreferatDocumentInterfaceFactory
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , nevTools
 , nevAutoreferatDocumentAnchor
;

function TevAutoreferatDocumentInterfaceFactory.COMQueryTool(aTag: Tl3Tag;
 const aIID: Tl3GUID;
 out theTool;
 const aProcessor: Ik2Processor): Boolean;
//#UC START# *53CCBDA5026D_4D6E6BA90279_var*
//#UC END# *53CCBDA5026D_4D6E6BA90279_var*
begin
//#UC START# *53CCBDA5026D_4D6E6BA90279_impl*
 !!! Needs to be implemented !!!
//#UC END# *53CCBDA5026D_4D6E6BA90279_impl*
end;//TevAutoreferatDocumentInterfaceFactory.COMQueryTool
{$IfEnd} // Defined(k2ForEditor)

end.
