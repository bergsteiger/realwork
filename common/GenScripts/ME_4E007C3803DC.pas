unit arDocumentContainer;

// Модуль: "w:\archi\source\projects\Archi\Editor\arDocumentContainer.pas"
// Стереотип: "SimpleClass"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , nevTools
;

type
 TarDocumentContainer = class(TnevPrintableDocumentContainer)
  protected
   function DoGetSubEx(anID: Integer;
    aLayerID: Integer): IevSub; override;
   function HAFPainterClass: RevHAFPainter; override;
 end;//TarDocumentContainer
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , arHAFPainer
 , arSubImplementation
;

function TarDocumentContainer.DoGetSubEx(anID: Integer;
 aLayerID: Integer): IevSub;
//#UC START# *47F27721012A_4E007C3803DC_var*
//#UC END# *47F27721012A_4E007C3803DC_var*
begin
//#UC START# *47F27721012A_4E007C3803DC_impl*
 if HasDocument then
  Result := TarSubImplementation.Make(Document.AsObject, Processor, anID, aLayerID)
 else
  Result := DoGetSubEx(anID, aLayerID);
//#UC END# *47F27721012A_4E007C3803DC_impl*
end;//TarDocumentContainer.DoGetSubEx

function TarDocumentContainer.HAFPainterClass: RevHAFPainter;
//#UC START# *47F35CAC00E4_4E007C3803DC_var*
//#UC END# *47F35CAC00E4_4E007C3803DC_var*
begin
//#UC START# *47F35CAC00E4_4E007C3803DC_impl*
 Result := TarHAFPainer;
//#UC END# *47F35CAC00E4_4E007C3803DC_impl*
end;//TarDocumentContainer.HAFPainterClass
{$IfEnd} // Defined(AppClientSide)

end.
