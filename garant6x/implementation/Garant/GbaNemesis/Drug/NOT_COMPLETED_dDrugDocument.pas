unit NOT_COMPLETED_dDrugDocument;
 {* Данные описания препарата. }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Drug\NOT_COMPLETED_dDrugDocument.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdDrugDocument" MUID: (47F4CCAD037F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , MedicInterfaces
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Types
 , BaseDocumentWithAttributesInterfaces
 , DocumentInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IdDrugDocument;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\dBaseDrugDocument.imp.pas}
 TdDrugDocument = class(_dBaseDrugDocument_, IdDrugDocument)
  {* Данные описания препарата. }
  private
   f_ContentsTree: IdeSimpleTree;
   f_dsContentsRef: IvcmFormDataSourceRef;
    {* Ссылка на "Оглавление" }
  protected
   function pm_GetDsContentsRef: IvcmFormDataSourceRef;
   function pm_GetContentsTree: IdeSimpleTree;
   procedure pm_SetContentsTree(const aValue: IdeSimpleTree);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   class function Make: IdDrugDocument; reintroduce;
 end;//TdDrugDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmFormDataSourceRef
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Utils
;

type _Instance_R_ = TdDrugDocument;

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Drug\dBaseDrugDocument.imp.pas}

class function TdDrugDocument.Make: IdDrugDocument;
var
 l_Inst : TdDrugDocument;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdDrugDocument.Make

function TdDrugDocument.pm_GetDsContentsRef: IvcmFormDataSourceRef;
//#UC START# *3A7D008F28B6_47F4CCAD037Fget_var*
//#UC END# *3A7D008F28B6_47F4CCAD037Fget_var*
begin
//#UC START# *3A7D008F28B6_47F4CCAD037Fget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3A7D008F28B6_47F4CCAD037Fget_impl*
end;//TdDrugDocument.pm_GetDsContentsRef

function TdDrugDocument.pm_GetContentsTree: IdeSimpleTree;
//#UC START# *493925D603CF_47F4CCAD037Fget_var*
//#UC END# *493925D603CF_47F4CCAD037Fget_var*
begin
//#UC START# *493925D603CF_47F4CCAD037Fget_impl*
 Result := f_ContentsTree;
//#UC END# *493925D603CF_47F4CCAD037Fget_impl*
end;//TdDrugDocument.pm_GetContentsTree

procedure TdDrugDocument.pm_SetContentsTree(const aValue: IdeSimpleTree);
//#UC START# *493925D603CF_47F4CCAD037Fset_var*
//#UC END# *493925D603CF_47F4CCAD037Fset_var*
begin
//#UC START# *493925D603CF_47F4CCAD037Fset_impl*
 f_ContentsTree := aValue;
//#UC END# *493925D603CF_47F4CCAD037Fset_impl*
end;//TdDrugDocument.pm_SetContentsTree

procedure TdDrugDocument.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F4CCAD037F_var*
//#UC END# *479731C50290_47F4CCAD037F_var*
begin
//#UC START# *479731C50290_47F4CCAD037F_impl*
 f_ContentsTree := nil;
 inherited;
//#UC END# *479731C50290_47F4CCAD037F_impl*
end;//TdDrugDocument.Cleanup

{$If NOT Defined(NoVCM)}
procedure TdDrugDocument.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47F4CCAD037F_var*
//#UC END# *4B16B8CF0307_47F4CCAD037F_var*
begin
//#UC START# *4B16B8CF0307_47F4CCAD037F_impl*
 f_ContentsTree := aData.ContentsTree;
 pm_GetDsContentsRef.Assign(aData.dsContentsRef);
 inherited;
//#UC END# *4B16B8CF0307_47F4CCAD037F_impl*
end;//TdDrugDocument.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure TdDrugDocument.ClearFields;
begin
 f_ContentsTree := nil;
 f_dsContentsRef := nil;
 inherited;
end;//TdDrugDocument.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
