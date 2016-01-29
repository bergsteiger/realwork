unit arDocumentContainer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Editor"
// Модуль: "w:/archi/source/projects/Archi/Editor/arDocumentContainer.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> archi::Editor::DocumentContainer::TarDocumentContainer
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  nevPrintableDocumentContainer,
  nevTools
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}
type
 TarDocumentContainer = class(TnevPrintableDocumentContainer)
 protected
 // overridden protected methods
   function DoGetSubEx(anID: Integer;
    aLayerID: Integer): IevSub; override;
   function HAFPainterClass: RevHAFPainter; override;
 end;//TarDocumentContainer
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  arHAFPainer,
  arSubImplementation
  ;
{$IfEnd} //AppClientSide

{$If defined(AppClientSide)}

// start class TarDocumentContainer

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

{$IfEnd} //AppClientSide

end.