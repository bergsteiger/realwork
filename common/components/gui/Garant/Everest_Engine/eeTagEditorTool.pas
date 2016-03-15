unit eeTagEditorTool;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\eeTagEditorTool.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest_Engine\eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , k2ProcessorTagTool
 , eeInterfacesEx
 , l3Variant
 , nevTools
 , k2Interfaces
;

type
 TeeTagEditorTool = class(Tk2ProcessorTagTool, IeeTool)
  private
   f_Document: Pointer;
  protected
   function pm_GetDocument: IeeDocumentEx;
   procedure OwnerDead;
    {* Нотификация о смерти родителя. }
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function GetProcessor: Ik2Processor; override;
  public
   constructor Create(aTagWrap: Tl3Variant;
    const aDocument: IeeDocumentEx;
    const aProcessor: InevProcessor); reintroduce;
  protected
   property Document: IeeDocumentEx
    read pm_GetDocument;
 end;//TeeTagEditorTool
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

function TeeTagEditorTool.pm_GetDocument: IeeDocumentEx;
//#UC START# *54872D7C031E_5487291700EBget_var*
//#UC END# *54872D7C031E_5487291700EBget_var*
begin
//#UC START# *54872D7C031E_5487291700EBget_impl*
 Result := IeeDocumentEx(f_Document);
//#UC END# *54872D7C031E_5487291700EBget_impl*
end;//TeeTagEditorTool.pm_GetDocument

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

procedure TeeTagEditorTool.OwnerDead;
 {* Нотификация о смерти родителя. }
//#UC START# *46A5D4220369_5487291700EB_var*
//#UC END# *46A5D4220369_5487291700EB_var*
begin
//#UC START# *46A5D4220369_5487291700EB_impl*
 f_Document := nil;
//#UC END# *46A5D4220369_5487291700EB_impl*
end;//TeeTagEditorTool.OwnerDead

procedure TeeTagEditorTool.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // Defined(Nemesis)

end.
