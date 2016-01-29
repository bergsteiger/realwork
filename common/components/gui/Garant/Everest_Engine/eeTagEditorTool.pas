unit eeTagEditorTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest Engine"
// Модуль: "w:/common/components/gui/Garant/Everest_Engine/eeTagEditorTool.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Engine Core::TeeTagEditorTool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

{$If defined(Nemesis)}
uses
  nevTools,
  eeInterfacesEx,
  k2ProcessorTagTool,
  l3Variant,
  k2Interfaces
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
type
 TeeTagEditorTool = class(Tk2ProcessorTagTool, IeeTool)
 private
 // private fields
   f_Document : Pointer;
 protected
 // property methods
   function pm_GetDocument: IeeDocumentEx;
 protected
 // realized methods
   procedure OwnerDead;
     {* Нотификация о смерти родителя. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function GetProcessor: Ik2Processor; override;
 public
 // public methods
   constructor Create(aTagWrap: Tl3Variant;
     const aDocument: IeeDocumentEx;
     const aProcessor: InevProcessor); reintroduce;
 protected
 // protected properties
   property Document: IeeDocumentEx
     read pm_GetDocument;
 end;//TeeTagEditorTool
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}

// start class TeeTagEditorTool

constructor TeeTagEditorTool.Create(aTagWrap: Tl3Variant;
  const aDocument: IeeDocumentEx;
  const aProcessor: InevProcessor);
//#UC START# *54872DB8021E_5487291700EB_var*
//#UC END# *54872DB8021E_5487291700EB_var*
begin
//#UC START# *54872DB8021E_5487291700EB_impl*
 inherited Create(aTagWrap, aProcessor);
 f_Document := Pointer(aDocument);
 if (f_Document <> nil) then
  (Document as IeeToolOwner).AddTool(Self);
//#UC END# *54872DB8021E_5487291700EB_impl*
end;//TeeTagEditorTool.Create

function TeeTagEditorTool.pm_GetDocument: IeeDocumentEx;
//#UC START# *54872D7C031E_5487291700EBget_var*
//#UC END# *54872D7C031E_5487291700EBget_var*
begin
//#UC START# *54872D7C031E_5487291700EBget_impl*
 Result := IeeDocumentEx(f_Document);
//#UC END# *54872D7C031E_5487291700EBget_impl*
end;//TeeTagEditorTool.pm_GetDocument

procedure TeeTagEditorTool.OwnerDead;
//#UC START# *46A5D4220369_5487291700EB_var*
//#UC END# *46A5D4220369_5487291700EB_var*
begin
//#UC START# *46A5D4220369_5487291700EB_impl*
 f_Document := nil;
//#UC END# *46A5D4220369_5487291700EB_impl*
end;//TeeTagEditorTool.OwnerDead

procedure TeeTagEditorTool.Cleanup;
//#UC START# *479731C50290_5487291700EB_var*
//#UC END# *479731C50290_5487291700EB_var*
begin
//#UC START# *479731C50290_5487291700EB_impl*
 if (f_Document <> nil) then
  (Document as IeeToolOwner).RemoveTool(Self);
 f_Document := nil;
 inherited;
//#UC END# *479731C50290_5487291700EB_impl*
end;//TeeTagEditorTool.Cleanup

function TeeTagEditorTool.GetProcessor: Ik2Processor;
//#UC START# *54BD0F310322_5487291700EB_var*
//#UC END# *54BD0F310322_5487291700EB_var*
begin
//#UC START# *54BD0F310322_5487291700EB_impl*
 Result := inherited GetProcessor;
 if (Result = nil) AND (Document <> nil) then
  Result := Document.Processor;
//#UC END# *54BD0F310322_5487291700EB_impl*
end;//TeeTagEditorTool.GetProcessor

{$IfEnd} //Nemesis

end.