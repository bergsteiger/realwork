unit evDocumentContainerWithProcessor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/evDocumentContainerWithProcessor.pas"
// Начат: 28.09.2004 17:36
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::DocumentContainers::TevDocumentContainerWithProcessor
//
// Контейнер документа с процессором операций.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevDocumentContainer,
  evOpProc,
  nevBase,
  nevTools,
  l3IID
  ;

type
 TevDocumentContainerWithProcessor = class(TnevDocumentContainer)
  {* Контейнер документа с процессором операций. }
 private
 // private fields
   f_Processor : TevCustomUndoProcessor;
    {* Поле для свойства Processor}
 protected
 // property methods
   function pm_GetProcessor: TevCustomUndoProcessor;
   procedure pm_SetProcessor(aValue: TevCustomUndoProcessor);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   function StartOp(Op: Integer = 0;
    DoLock: Boolean = true): InevOp; override;
     {* открывает пачку операций с кодом Op. }
   function DoGetProcessor: InevProcessor; override;
   function DoGetDocumentLimits: InevDocumentLimits; override;
   function DoGetDocumentInfo: InevDocumentInfo; override;
   function GetHasProcessor: Boolean; override;
   function COMQueryInterface(const IID: Tl3GUID;
    out Obj): Tl3HResult; override;
     {* Реализация запроса интерфейса }
 protected
 // protected methods
   procedure MakeProcessor(out theProcessor: TevCustomUndoProcessor); virtual;
 public
 // public properties
   property Processor: TevCustomUndoProcessor
     read pm_GetProcessor
     write pm_SetProcessor;
     {* Процессор операций. }
 end;//TevDocumentContainerWithProcessor

implementation

uses
  l3Base,
  evDefaultContext
  ;

// start class TevDocumentContainerWithProcessor

function TevDocumentContainerWithProcessor.pm_GetProcessor: TevCustomUndoProcessor;
//#UC START# *483D903003C8_47F3513A017Fget_var*
//#UC END# *483D903003C8_47F3513A017Fget_var*
begin
//#UC START# *483D903003C8_47F3513A017Fget_impl*
 if (f_Processor = nil) then
 begin
  MakeProcessor(f_Processor);
  if (f_Processor <> nil) then
   f_Processor.LinkDocument(Self);
 end;//f_Processor = nil
 Result := f_Processor;
//#UC END# *483D903003C8_47F3513A017Fget_impl*
end;//TevDocumentContainerWithProcessor.pm_GetProcessor

procedure TevDocumentContainerWithProcessor.pm_SetProcessor(aValue: TevCustomUndoProcessor);
//#UC START# *483D903003C8_47F3513A017Fset_var*
//#UC END# *483D903003C8_47F3513A017Fset_var*
begin
//#UC START# *483D903003C8_47F3513A017Fset_impl*
 if (f_Processor <> aValue) then
 begin
  if (f_Processor <> nil) then
   f_Processor.UnlinkDocument(Self);
  l3Set(f_Processor, aValue);
  if (f_Processor <> nil) then
   f_Processor.LinkDocument(Self);
 end;//f_Processor <> aValue
//#UC END# *483D903003C8_47F3513A017Fset_impl*
end;//TevDocumentContainerWithProcessor.pm_SetProcessor

procedure TevDocumentContainerWithProcessor.MakeProcessor(out theProcessor: TevCustomUndoProcessor);
//#UC START# *47F35245009A_47F3513A017F_var*
//#UC END# *47F35245009A_47F3513A017F_var*
begin
//#UC START# *47F35245009A_47F3513A017F_impl*
 theProcessor := TevCustomUndoProcessor.Create(TevDefaultContext);
//#UC END# *47F35245009A_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.MakeProcessor

procedure TevDocumentContainerWithProcessor.Cleanup;
//#UC START# *479731C50290_47F3513A017F_var*
//#UC END# *479731C50290_47F3513A017F_var*
begin
//#UC START# *479731C50290_47F3513A017F_impl*
(* if (f_Processor <> nil) AND (f_Processor.GetOwner = Self) then
  Assert(false);*)
  //f_Processor.Owner := nil;
 Processor := nil;
 inherited;
//#UC END# *479731C50290_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.Cleanup

function TevDocumentContainerWithProcessor.StartOp(Op: Integer = 0;
  DoLock: Boolean = true): InevOp;
//#UC START# *47F10A0502B8_47F3513A017F_var*
//#UC END# *47F10A0502B8_47F3513A017F_var*
begin
//#UC START# *47F10A0502B8_47F3513A017F_impl*
 Result := Processor.StartOp(Op, DoLock);
//#UC END# *47F10A0502B8_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.StartOp

function TevDocumentContainerWithProcessor.DoGetProcessor: InevProcessor;
//#UC START# *47F2714A0216_47F3513A017F_var*
//#UC END# *47F2714A0216_47F3513A017F_var*
begin
//#UC START# *47F2714A0216_47F3513A017F_impl*
 Result := Processor;
//#UC END# *47F2714A0216_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.DoGetProcessor

function TevDocumentContainerWithProcessor.DoGetDocumentLimits: InevDocumentLimits;
//#UC START# *47F27268004F_47F3513A017F_var*
//#UC END# *47F27268004F_47F3513A017F_var*
begin
//#UC START# *47F27268004F_47F3513A017F_impl*
 Result := Processor;
//#UC END# *47F27268004F_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.DoGetDocumentLimits

function TevDocumentContainerWithProcessor.DoGetDocumentInfo: InevDocumentInfo;
//#UC START# *47F27286016C_47F3513A017F_var*
//#UC END# *47F27286016C_47F3513A017F_var*
begin
//#UC START# *47F27286016C_47F3513A017F_impl*
 Result := Processor;
//#UC END# *47F27286016C_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.DoGetDocumentInfo

function TevDocumentContainerWithProcessor.GetHasProcessor: Boolean;
//#UC START# *47F2729800DD_47F3513A017F_var*
//#UC END# *47F2729800DD_47F3513A017F_var*
begin
//#UC START# *47F2729800DD_47F3513A017F_impl*
 Result := (f_Processor <> nil);
//#UC END# *47F2729800DD_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.GetHasProcessor

function TevDocumentContainerWithProcessor.COMQueryInterface(const IID: Tl3GUID;
  out Obj): Tl3HResult;
//#UC START# *4A60B23E00C3_47F3513A017F_var*
//#UC END# *4A60B23E00C3_47F3513A017F_var*
begin
//#UC START# *4A60B23E00C3_47F3513A017F_impl*
 Result.SetOk;
 if IID.EQ(InevProcessor) then
  InevProcessor(Obj) := Processor
 else
  Result := inherited COMQueryInterface(IID, Obj);
//#UC END# *4A60B23E00C3_47F3513A017F_impl*
end;//TevDocumentContainerWithProcessor.COMQueryInterface

end.