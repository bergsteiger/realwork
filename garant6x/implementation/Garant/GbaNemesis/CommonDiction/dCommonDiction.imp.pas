{$IfNDef dCommonDiction_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "CommonDiction"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/CommonDiction/dCommonDiction.imp.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Common::CommonDiction::CommonDiction::dCommonDiction
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dCommonDiction_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dCommonDiction_ = {mixin} class(_dBaseDocumentWithAttributes_, IdCommonDiction)
 private
 // private fields
   f_CurrentNode : INodeBase;
   f_dsContentsRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsContentsRef}
 protected
 // realized methods
   function pm_GetCurrentNode: INodeBase;
   procedure pm_SetCurrentNode(const aValue: INodeBase);
   function pm_GetDsContentsRef: IvcmFormDataSourceRef;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Make: IdCommonDiction; reintroduce;
 end;//_dCommonDiction_
{$Else}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dCommonDiction_ = _dBaseDocumentWithAttributes_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dCommonDiction_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

// start class _dCommonDiction_

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
end;

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

function _dCommonDiction_.pm_GetDsContentsRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsContentsRef);
end;//_dCommonDiction_.pm_GetDsContentsRef

procedure _dCommonDiction_.Cleanup;
//#UC START# *479731C50290_4936B78E0024_var*
//#UC END# *479731C50290_4936B78E0024_var*
begin
//#UC START# *479731C50290_4936B78E0024_impl*
 f_CurrentNode := nil;
 inherited;
//#UC END# *479731C50290_4936B78E0024_impl*
end;//_dCommonDiction_.Cleanup

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure _dCommonDiction_.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_CurrentNode := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsContentsRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//_dCommonDiction_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dCommonDiction_imp}
