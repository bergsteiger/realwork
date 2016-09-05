unit nevDocumentPart;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevDocumentPart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevDocumentPart" MUID: (4F87E8B50206)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevParaList
 , nevBase
;

type
 TnevDocumentPart = class(TnevParaList)
  protected
   function GetAppliesToMaxWidth: Boolean; override;
   function GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean; override;
   function TreatCollapsedAsHidden: Boolean; override;
 end;//TnevDocumentPart
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 //#UC START# *4F87E8B50206impl_uses*
 //#UC END# *4F87E8B50206impl_uses*
;

function TnevDocumentPart.GetAppliesToMaxWidth: Boolean;
//#UC START# *48CFB17F03A2_4F87E8B50206_var*
//#UC END# *48CFB17F03A2_4F87E8B50206_var*
begin
//#UC START# *48CFB17F03A2_4F87E8B50206_impl*
 Result := false;
//#UC END# *48CFB17F03A2_4F87E8B50206_impl*
end;//TnevDocumentPart.GetAppliesToMaxWidth

function TnevDocumentPart.GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *48CFB1F5024F_4F87E8B50206_var*
//#UC END# *48CFB1F5024F_4F87E8B50206_var*
begin
//#UC START# *48CFB1F5024F_4F87E8B50206_impl*
 Result := (GetRedirect.ChildrenCount = 0);
//#UC END# *48CFB1F5024F_4F87E8B50206_impl*
end;//TnevDocumentPart.GetIsHiddenPrim

function TnevDocumentPart.TreatCollapsedAsHidden: Boolean;
//#UC START# *4D596369028C_4F87E8B50206_var*
//#UC END# *4D596369028C_4F87E8B50206_var*
begin
//#UC START# *4D596369028C_4F87E8B50206_impl*
 Result := False;
//#UC END# *4D596369028C_4F87E8B50206_impl*
end;//TnevDocumentPart.TreatCollapsedAsHidden
{$IfEnd} // Defined(k2ForEditor)

end.
