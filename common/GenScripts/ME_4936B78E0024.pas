{$IfNDef dCommonDiction_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\CommonDiction\dCommonDiction.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "dCommonDiction" MUID: (4936B78E0024)
// Имя типа: "_dCommonDiction_"

{$Define dCommonDiction_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dCommonDiction_ = class(_dBaseDocumentWithAttributes_, IdCommonDiction)
  private
   f_CurrentNode: INodeBase;
   f_dsContentsRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsContentsRef }
  protected
   function pm_GetCurrentNode: INodeBase;
   procedure pm_SetCurrentNode(const aValue: INodeBase);
   function pm_GetdsContentsRef: IvcmFormDataSourceRef;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   class function Make: IdCommonDiction; reintroduce;
 end;//_dCommonDiction_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
_dCommonDiction_ = _dBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dCommonDiction_imp}

{$IfNDef dCommonDiction_imp_impl}

{$Define dCommonDiction_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

class function _dCommonDiction_.Make: IdCommonDiction;
var
 l_Inst : _dCommonDiction_;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_dCommonDiction_.Make

function _dCommonDiction_.pm_GetCurrentNode: INodeBase;
//#UC START# *49527BB50018_4936B78E0024get_var*
//#UC END# *49527BB50018_4936B78E0024get_var*
begin
//#UC START# *49527BB50018_4936B78E0024get_impl*
 Result := f_CurrentNode;
//#UC END# *49527BB50018_4936B78E0024get_impl*
end;//_dCommonDiction_.pm_GetCurrentNode

procedure _dCommonDiction_.pm_SetCurrentNode(const aValue: INodeBase);
//#UC START# *49527BB50018_4936B78E0024set_var*
//#UC END# *49527BB50018_4936B78E0024set_var*
begin
//#UC START# *49527BB50018_4936B78E0024set_impl*
 f_CurrentNode := aValue;
//#UC END# *49527BB50018_4936B78E0024set_impl*
end;//_dCommonDiction_.pm_SetCurrentNode

function _dCommonDiction_.pm_GetdsContentsRef: IvcmFormDataSourceRef;
//#UC START# *AB0AA05AFA56_4936B78E0024get_var*
//#UC END# *AB0AA05AFA56_4936B78E0024get_var*
begin
//#UC START# *AB0AA05AFA56_4936B78E0024get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AB0AA05AFA56_4936B78E0024get_impl*
end;//_dCommonDiction_.pm_GetdsContentsRef

procedure _dCommonDiction_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4936B78E0024_var*
//#UC END# *479731C50290_4936B78E0024_var*
begin
//#UC START# *479731C50290_4936B78E0024_impl*
 f_CurrentNode := nil;
 inherited;
//#UC END# *479731C50290_4936B78E0024_impl*
end;//_dCommonDiction_.Cleanup

{$If NOT Defined(NoVCM)}
procedure _dCommonDiction_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_4936B78E0024_var*
//#UC END# *4B16B8CF0307_4936B78E0024_var*
begin
//#UC START# *4B16B8CF0307_4936B78E0024_impl*
 inherited;
 f_CurrentNode := aData.CurrentNode;
 pm_GetDsContentsRef.Assign(aData.dsContentsRef);
//#UC END# *4B16B8CF0307_4936B78E0024_impl*
end;//_dCommonDiction_.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure _dCommonDiction_.ClearFields;
begin
 f_CurrentNode := nil;
 f_dsContentsRef := nil;
 inherited;
end;//_dCommonDiction_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dCommonDiction_imp_impl}

{$EndIf dCommonDiction_imp}

