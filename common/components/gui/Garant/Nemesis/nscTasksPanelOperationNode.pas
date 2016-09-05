unit nscTasksPanelOperationNode;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTasksPanelOperationNode.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnscTasksPanelOperationNode" MUID: (508EBDA900AE)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3NodesModelPart
 , l3Interfaces
 , nscTaskPanelInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmTaskPanelInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nscTasksPanelActionLink
;

type
 TnscTasksPanelOperationNode = class(Tl3UsualNode, Il3ItemNotifyRecipient, InscOperationNode)
  private
   f_Op: IvcmCustOpsGroupOperation;
   f_Link: TnscTasksPanelActionLink;
  protected
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
    {* прошла операция. }
   procedure CaptionChanged;
    {* изменилось название операции }
   function pm_GetOp: IvcmCustOpsGroupOperation;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aOp: IvcmCustOpsGroupOperation); reintroduce;
   class function Make(const aOp: IvcmCustOpsGroupOperation): InscOperationNode; reintroduce;
  public
   property Op: IvcmCustOpsGroupOperation
    read f_Op
    write f_Op;
   property Link: TnscTasksPanelActionLink
    read f_Link
    write f_Link;
 end;//TnscTasksPanelOperationNode
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3Tree_TLB
 //#UC START# *508EBDA900AEimpl_uses*
 //#UC END# *508EBDA900AEimpl_uses*
;

constructor TnscTasksPanelOperationNode.Create(const aOp: IvcmCustOpsGroupOperation);
//#UC START# *508FE2F30143_508EBDA900AE_var*
//#UC END# *508FE2F30143_508EBDA900AE_var*
begin
//#UC START# *508FE2F30143_508EBDA900AE_impl*
 inherited Create;
 Op := aOp;
 if (Op <> nil) then
  Op.As_Il3ChangeNotifier.Subscribe(Il3ItemNotifyRecipient(Self));
 CaptionChanged;
//#UC END# *508FE2F30143_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.Create

class function TnscTasksPanelOperationNode.Make(const aOp: IvcmCustOpsGroupOperation): InscOperationNode;
var
 l_Inst : TnscTasksPanelOperationNode;
begin
 l_Inst := Create(aOp);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnscTasksPanelOperationNode.Make

procedure TnscTasksPanelOperationNode.Notify(const aNotifier: Il3ChangeNotifier;
 aOperation: Integer;
 aIndex: Integer);
 {* прошла операция. }
//#UC START# *46A4504B03C4_508EBDA900AE_var*
//#UC END# *46A4504B03C4_508EBDA900AE_var*
begin
//#UC START# *46A4504B03C4_508EBDA900AE_impl*
 case TvcmTaskPanelOperation(aOperation) of
  cvcm_tpOperationRemove:
  begin
   l3Free(f_Link);
    // - почистим связь с Action, т.к. при удалении Action будет приходить
    //   информация о чистке полей Caption и т.д., а обновлять уже будет некого
    //   (CQ: OIT5-26549);
   if (Op <> nil) then
    Op.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
   Remove;
  end;//cvcm_tpOperationRemove
  cvcm_tpOpPosChanged:
  begin
   ParentNode.SortChilds;
   CaptionChanged;
  end;//cvcm_tpOpPosChanged
  cvcm_tpOpCaptionChanged:
   CaptionChanged;
 end;//case aOperation of
//#UC END# *46A4504B03C4_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.Notify

procedure TnscTasksPanelOperationNode.CaptionChanged;
 {* изменилось название операции }
//#UC START# *499C1A5C03B4_508EBDA900AE_var*
//#UC END# *499C1A5C03B4_508EBDA900AE_var*
begin
//#UC START# *499C1A5C03B4_508EBDA900AE_impl*
 {$IfDef nscTasksPanelShowPosition}
  Text := l3PCharLen(vcmCat(vcmCat(Op.Caption, ' ('), IntToStr(Op.Position) + ')'));
 {$Else nscTasksPanelShowPosition}
  Text := Op.Caption.AsWStr;
 {$EndIf nscTasksPanelShowPosition}
//#UC END# *499C1A5C03B4_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.CaptionChanged

function TnscTasksPanelOperationNode.pm_GetOp: IvcmCustOpsGroupOperation;
//#UC START# *499C1AA001FF_508EBDA900AEget_var*
//#UC END# *499C1AA001FF_508EBDA900AEget_var*
begin
//#UC START# *499C1AA001FF_508EBDA900AEget_impl*
 Result := f_Op;
//#UC END# *499C1AA001FF_508EBDA900AEget_impl*
end;//TnscTasksPanelOperationNode.pm_GetOp

procedure TnscTasksPanelOperationNode.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_508EBDA900AE_var*
//#UC END# *479731C50290_508EBDA900AE_var*
begin
//#UC START# *479731C50290_508EBDA900AE_impl*
 if (Op <> nil) then
  Op.As_Il3ChangeNotifier.Unsubscribe(Il3ItemNotifyRecipient(Self));
 Op := nil;
 l3Free(f_Link);
 inherited;
//#UC END# *479731C50290_508EBDA900AE_impl*
end;//TnscTasksPanelOperationNode.Cleanup

procedure TnscTasksPanelOperationNode.ClearFields;
begin
 Op := nil;
 inherited;
end;//TnscTasksPanelOperationNode.ClearFields
{$IfEnd} // Defined(Nemesis)

end.
