{$IfNDef msmOperationsManaging_imp}

// Модуль: "w:\common\components\gui\Garant\msm\msmOperationsManaging.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "msmOperationsManaging" MUID: (57CEB0330239)
// Имя типа: "_msmOperationsManaging_"

{$Define msmOperationsManaging_imp}

 _msmOperationsManaging_ = {abstract} class(_msmOperationsManaging_Parent_)
  private
   f_OperationsList: TmsmOperationsList;
  protected
   function Get_Operations: ImsmOperationsList;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure AddOperation(const anOp: ImsmOperation);
  protected
   property OperationsList: TmsmOperationsList
    read f_OperationsList;
 end;//_msmOperationsManaging_

{$Else msmOperationsManaging_imp}

{$IfNDef msmOperationsManaging_imp_impl}

{$Define msmOperationsManaging_imp_impl}

function _msmOperationsManaging_.Get_Operations: ImsmOperationsList;
//#UC START# *57CEAE470155_57CEB0330239get_var*
//#UC END# *57CEAE470155_57CEB0330239get_var*
begin
//#UC START# *57CEAE470155_57CEB0330239get_impl*
 if (f_OperationsList = nil) then
  Result := TmsmNullOperationsList.Instance
 else
  Result := f_OperationsList;
//#UC END# *57CEAE470155_57CEB0330239get_impl*
end;//_msmOperationsManaging_.Get_Operations

procedure _msmOperationsManaging_.AddOperation(const anOp: ImsmOperation);
//#UC START# *57CEAE6F0148_57CEB0330239_var*
//#UC END# *57CEAE6F0148_57CEB0330239_var*
begin
//#UC START# *57CEAE6F0148_57CEB0330239_impl*
 if (f_OperationsList = nil) then
  f_OperationsList := TmsmOperationsList.Create;
 f_OperationsList.Add(anOp); 
//#UC END# *57CEAE6F0148_57CEB0330239_impl*
end;//_msmOperationsManaging_.AddOperation

procedure _msmOperationsManaging_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_57CEB0330239_var*
//#UC END# *479731C50290_57CEB0330239_var*
begin
//#UC START# *479731C50290_57CEB0330239_impl*
 FreeAndNil(f_OperationsList);
 inherited;
//#UC END# *479731C50290_57CEB0330239_impl*
end;//_msmOperationsManaging_.Cleanup

{$EndIf msmOperationsManaging_imp_impl}

{$EndIf msmOperationsManaging_imp}

