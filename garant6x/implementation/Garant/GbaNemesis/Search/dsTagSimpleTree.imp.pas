{$IfNDef dsTagSimpleTree_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\dsTagSimpleTree.imp.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "dsTagSimpleTree" MUID: (4924015202CD)
// Имя типа: "_dsTagSimpleTree_"

{$Define dsTagSimpleTree_imp}

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}
 _dsTagSimpleTree_ = {abstract} class(_dsSimpleTree_, IdsTagSimpleTree)
  {* Бизнес объекта для словарных атрибутов }
  private
   f_Operations: TLogicOperationSet;
  private
   procedure UpdateOperations;
  protected
   function GetOperations: TLogicOperationSet; virtual;
   function pm_GetSearch: IdeSearch;
   function pm_GetOperations: TLogicOperationSet;
   function pm_GetIsOneOperation: Boolean;
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
  protected
   property Operations: TLogicOperationSet
    read f_Operations;
 end;//_dsTagSimpleTree_

{$Else dsTagSimpleTree_imp}

{$IfNDef dsTagSimpleTree_imp_impl}

{$Define dsTagSimpleTree_imp_impl}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Tree\dsSimpleTree.imp.pas}

procedure _dsTagSimpleTree_.UpdateOperations;
//#UC START# *492404C20046_4924015202CD_var*
//#UC END# *492404C20046_4924015202CD_var*
begin
//#UC START# *492404C20046_4924015202CD_impl*
 f_Operations := bsGetOperations(PartData.Tag);
//#UC END# *492404C20046_4924015202CD_impl*
end;//_dsTagSimpleTree_.UpdateOperations

function _dsTagSimpleTree_.GetOperations: TLogicOperationSet;
//#UC START# *492406340209_4924015202CD_var*
//#UC END# *492406340209_4924015202CD_var*
begin
//#UC START# *492406340209_4924015202CD_impl*
 Result := f_Operations;
//#UC END# *492406340209_4924015202CD_impl*
end;//_dsTagSimpleTree_.GetOperations

function _dsTagSimpleTree_.pm_GetSearch: IdeSearch;
//#UC START# *4923FDA60287_4924015202CDget_var*
//#UC END# *4923FDA60287_4924015202CDget_var*
begin
//#UC START# *4923FDA60287_4924015202CDget_impl*
 Result := PartData;
//#UC END# *4923FDA60287_4924015202CDget_impl*
end;//_dsTagSimpleTree_.pm_GetSearch

function _dsTagSimpleTree_.pm_GetOperations: TLogicOperationSet;
//#UC START# *4923FDDB026F_4924015202CDget_var*
//#UC END# *4923FDDB026F_4924015202CDget_var*
begin
//#UC START# *4923FDDB026F_4924015202CDget_impl*
 Result := GetOperations;
//#UC END# *4923FDDB026F_4924015202CDget_impl*
end;//_dsTagSimpleTree_.pm_GetOperations

function _dsTagSimpleTree_.pm_GetIsOneOperation: Boolean;
//#UC START# *4923FDFA00F7_4924015202CDget_var*
//#UC END# *4923FDFA00F7_4924015202CDget_var*
begin
//#UC START# *4923FDFA00F7_4924015202CDget_impl*
 Result := bsIsOneOperation(GetOperations);
//#UC END# *4923FDFA00F7_4924015202CDget_impl*
end;//_dsTagSimpleTree_.pm_GetIsOneOperation

{$If NOT Defined(NoVCM)}
procedure _dsTagSimpleTree_.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_4924015202CD_var*
//#UC END# *492ACF630072_4924015202CD_var*
begin
//#UC START# *492ACF630072_4924015202CD_impl*
 inherited;
 UpdateOperations;
//#UC END# *492ACF630072_4924015202CD_impl*
end;//_dsTagSimpleTree_.GotData
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf dsTagSimpleTree_imp_impl}

{$EndIf dsTagSimpleTree_imp}

