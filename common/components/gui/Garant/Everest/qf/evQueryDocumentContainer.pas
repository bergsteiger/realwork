unit evQueryDocumentContainer;

// Модуль: "w:\common\components\gui\Garant\Everest\qf\evQueryDocumentContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevQueryDocumentContainer" MUID: (48DB9DC1035C)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevPrintableDocumentContainer
 , nevTools
 , l3Variant
 , nevDocumentContainer
 , evOpProc
;

type
 TevQueryDocumentContainer = class(TnevPrintableDocumentContainer, InevQueryDocumentContainer)
  private
   f_ModelNotify: Pointer;
    {* InevControlListener }
  protected
   function GetCurrPara: Tl3Variant;
   procedure SetCursorToPara(const aPara: InevPara;
    bAtEnd: Boolean;
    aNeedClear: Boolean);
    {* Устанавливает курсор на определенный параграф. }
   procedure ClearCard;
    {* Обработчик очистки КЗ. }
   procedure AfterCollapsed;
   procedure ReleaseListeners;
   procedure LinkListener(const aListener: InevControlListener);
   procedure UnlinkListener(const aListener: InevControlListener);
   function Get_ModelNotify: InevControlListener;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); override;
   function PartGeneratorClass: RevDocumentPartGenerator; override;
   {$If NOT Defined(DesignTimeLibrary)}
   procedure DoStyleTableChanged; override;
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
  public
   class function Make(aDocument: Tl3Variant = nil): InevQueryDocumentContainer; reintroduce;
   constructor Create(aDocument: Tl3Variant); reintroduce;
 end;//TevQueryDocumentContainer

implementation

uses
 l3ImplUses
 , evQueryCardInt
 , evQueryCardProcessor
 , evControlGenerator
 , evDefaultContext
 , nevBase
 //#UC START# *48DB9DC1035Cimpl_uses*
 //#UC END# *48DB9DC1035Cimpl_uses*
;

class function TevQueryDocumentContainer.Make(aDocument: Tl3Variant = nil): InevQueryDocumentContainer;
var
 l_Inst : TevQueryDocumentContainer;
begin
 l_Inst := Create(aDocument);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TevQueryDocumentContainer.Make

constructor TevQueryDocumentContainer.Create(aDocument: Tl3Variant);
//#UC START# *48DBA7E101F6_48DB9DC1035C_var*
//#UC END# *48DBA7E101F6_48DB9DC1035C_var*
begin
//#UC START# *48DBA7E101F6_48DB9DC1035C_impl*
 inherited Create;
 Document := aDocument;
//#UC END# *48DBA7E101F6_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.Create

function TevQueryDocumentContainer.GetCurrPara: Tl3Variant;
//#UC START# *47C6BA30033F_48DB9DC1035C_var*
var
 l_Editor: IevQueryCardEditor; 
//#UC END# *47C6BA30033F_48DB9DC1035C_var*
begin
//#UC START# *47C6BA30033F_48DB9DC1035C_impl*
 Result := nil;
 TextSource.CastAnyEditorTo(IevQueryCardEditor, l_Editor);
 if l_Editor <> nil then
  Result := l_Editor.GetCurrPara;
//#UC END# *47C6BA30033F_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.GetCurrPara

procedure TevQueryDocumentContainer.SetCursorToPara(const aPara: InevPara;
 bAtEnd: Boolean;
 aNeedClear: Boolean);
 {* Устанавливает курсор на определенный параграф. }
//#UC START# *47C6BA4200E7_48DB9DC1035C_var*
var
 l_Editor: IevQueryCardEditor; 
//#UC END# *47C6BA4200E7_48DB9DC1035C_var*
begin
//#UC START# *47C6BA4200E7_48DB9DC1035C_impl*
 TextSource.CastAnyEditorTo(IevQueryCardEditor, l_Editor);
 if l_Editor <> nil then
  l_Editor.SetCursorToPara(aPara, bAtEnd, aNeedClear);
//#UC END# *47C6BA4200E7_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.SetCursorToPara

procedure TevQueryDocumentContainer.ClearCard;
 {* Обработчик очистки КЗ. }
//#UC START# *47C6BA6300ED_48DB9DC1035C_var*
//#UC END# *47C6BA6300ED_48DB9DC1035C_var*
begin
//#UC START# *47C6BA6300ED_48DB9DC1035C_impl*
 Processor.UndoBuffer.Clear;
//#UC END# *47C6BA6300ED_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.ClearCard

procedure TevQueryDocumentContainer.AfterCollapsed;
//#UC START# *47C6BA6E01D2_48DB9DC1035C_var*
//#UC END# *47C6BA6E01D2_48DB9DC1035C_var*
begin
//#UC START# *47C6BA6E01D2_48DB9DC1035C_impl*
 TextSource.SetFlag(ev_uwfCursor)
//#UC END# *47C6BA6E01D2_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.AfterCollapsed

procedure TevQueryDocumentContainer.ReleaseListeners;
//#UC START# *47C6BA7402A6_48DB9DC1035C_var*
//#UC END# *47C6BA7402A6_48DB9DC1035C_var*
begin
//#UC START# *47C6BA7402A6_48DB9DC1035C_impl*
 f_ModelNotify := nil;
//#UC END# *47C6BA7402A6_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.ReleaseListeners

procedure TevQueryDocumentContainer.LinkListener(const aListener: InevControlListener);
//#UC START# *47C6BA81030D_48DB9DC1035C_var*
//#UC END# *47C6BA81030D_48DB9DC1035C_var*
begin
//#UC START# *47C6BA81030D_48DB9DC1035C_impl*
 Assert((f_ModelNotify = nil) or (f_ModelNotify = Pointer(aListener)));
 f_ModelNotify := Pointer(aListener);
//#UC END# *47C6BA81030D_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.LinkListener

procedure TevQueryDocumentContainer.UnlinkListener(const aListener: InevControlListener);
//#UC START# *47C6BA8D0081_48DB9DC1035C_var*
//#UC END# *47C6BA8D0081_48DB9DC1035C_var*
begin
//#UC START# *47C6BA8D0081_48DB9DC1035C_impl*
 Assert((f_ModelNotify = nil) or (f_ModelNotify = Pointer(aListener)));
 f_ModelNotify := nil;
//#UC END# *47C6BA8D0081_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.UnlinkListener

function TevQueryDocumentContainer.Get_ModelNotify: InevControlListener;
//#UC START# *47C6BA9902AB_48DB9DC1035Cget_var*
//#UC END# *47C6BA9902AB_48DB9DC1035Cget_var*
begin
//#UC START# *47C6BA9902AB_48DB9DC1035Cget_impl*
 Result := InevControlListener(f_ModelNotify);
//#UC END# *47C6BA9902AB_48DB9DC1035Cget_impl*
end;//TevQueryDocumentContainer.Get_ModelNotify

procedure TevQueryDocumentContainer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_48DB9DC1035C_var*
//#UC END# *479731C50290_48DB9DC1035C_var*
begin
//#UC START# *479731C50290_48DB9DC1035C_impl*
 f_ModelNotify := nil; 
 inherited;
//#UC END# *479731C50290_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.Cleanup

procedure TevQueryDocumentContainer.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_48DB9DC1035C_var*
//#UC END# *47F35245009A_48DB9DC1035C_var*
begin
//#UC START# *47F35245009A_48DB9DC1035C_impl*
 theProcessor := TevQueryCardProcessor.Create(TevDefaultContext);
//#UC END# *47F35245009A_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.MakeProcessor

function TevQueryDocumentContainer.PartGeneratorClass: RevDocumentPartGenerator;
//#UC START# *48033300004D_48DB9DC1035C_var*
//#UC END# *48033300004D_48DB9DC1035C_var*
begin
//#UC START# *48033300004D_48DB9DC1035C_impl*
 Result := TevControlGenerator;
//#UC END# *48033300004D_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.PartGeneratorClass

{$If NOT Defined(DesignTimeLibrary)}
procedure TevQueryDocumentContainer.DoStyleTableChanged;
//#UC START# *4A485B710126_48DB9DC1035C_var*
//#UC END# *4A485B710126_48DB9DC1035C_var*
begin
//#UC START# *4A485B710126_48DB9DC1035C_impl*
 inherited;
 if Get_ModelNotify <> nil then
  Get_ModelNotify.HideDroppedControl(True); //Убираем дерево
  // - а дерево само не может подписаться на смену таблицы стилей?
  // http://mdp.garant.ru/pages/viewpage.action?pageId=119473921&focusedCommentId=119473962#comment-119473962
//#UC END# *4A485B710126_48DB9DC1035C_impl*
end;//TevQueryDocumentContainer.DoStyleTableChanged
{$IfEnd} // NOT Defined(DesignTimeLibrary)

end.
