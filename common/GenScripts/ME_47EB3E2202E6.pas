{$IfNDef dBaseDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocument.imp.pas"
// Стереотип: "Impurity"

{$Define dBaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 _dBaseDocument_ = class(_vcmData_, IdBaseDocument)
  {* Данные сборки документа }
  private
   f_dsDocumentRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsDocumentRef }
   f_HasDocument: Tl3Bool;
    {* Поле для свойства HasDocument }
   f_DocInfo: IdeDocInfo;
    {* Поле для свойства DocInfo }
  protected
   function pm_GetdsDocumentRef: IvcmFormDataSourceRef;
   function pm_GetHasDocument: Tl3Bool;
   procedure pm_SetHasDocument(aValue: Tl3Bool);
   function pm_GetDocInfo: IdeDocInfo;
   procedure pm_SetDocInfo(const aValue: IdeDocInfo);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
 end;//_dBaseDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
_dBaseDocument_ = _vcmData_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dBaseDocument_imp}

{$IfNDef dBaseDocument_imp_impl}

{$Define dBaseDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}

function _dBaseDocument_.pm_GetdsDocumentRef: IvcmFormDataSourceRef;
//#UC START# *2C233EE5B42C_47EB3E2202E6get_var*
//#UC END# *2C233EE5B42C_47EB3E2202E6get_var*
begin
//#UC START# *2C233EE5B42C_47EB3E2202E6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *2C233EE5B42C_47EB3E2202E6get_impl*
end;//_dBaseDocument_.pm_GetdsDocumentRef

function _dBaseDocument_.pm_GetHasDocument: Tl3Bool;
//#UC START# *77EA326510B8_47EB3E2202E6get_var*
//#UC END# *77EA326510B8_47EB3E2202E6get_var*
begin
//#UC START# *77EA326510B8_47EB3E2202E6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *77EA326510B8_47EB3E2202E6get_impl*
end;//_dBaseDocument_.pm_GetHasDocument

procedure _dBaseDocument_.pm_SetHasDocument(aValue: Tl3Bool);
//#UC START# *77EA326510B8_47EB3E2202E6set_var*
//#UC END# *77EA326510B8_47EB3E2202E6set_var*
begin
//#UC START# *77EA326510B8_47EB3E2202E6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *77EA326510B8_47EB3E2202E6set_impl*
end;//_dBaseDocument_.pm_SetHasDocument

function _dBaseDocument_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *CEA3A9CB4068_47EB3E2202E6get_var*
//#UC END# *CEA3A9CB4068_47EB3E2202E6get_var*
begin
//#UC START# *CEA3A9CB4068_47EB3E2202E6get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CEA3A9CB4068_47EB3E2202E6get_impl*
end;//_dBaseDocument_.pm_GetDocInfo

procedure _dBaseDocument_.pm_SetDocInfo(const aValue: IdeDocInfo);
//#UC START# *CEA3A9CB4068_47EB3E2202E6set_var*
//#UC END# *CEA3A9CB4068_47EB3E2202E6set_var*
begin
//#UC START# *CEA3A9CB4068_47EB3E2202E6set_impl*
 !!! Needs to be implemented !!!
//#UC END# *CEA3A9CB4068_47EB3E2202E6set_impl*
end;//_dBaseDocument_.pm_SetDocInfo

procedure _dBaseDocument_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47EB3E2202E6_var*
//#UC END# *479731C50290_47EB3E2202E6_var*
begin
//#UC START# *479731C50290_47EB3E2202E6_impl*
 f_DocInfo := nil;
 inherited;
//#UC END# *479731C50290_47EB3E2202E6_impl*
end;//_dBaseDocument_.Cleanup

{$If NOT Defined(NoVCM)}
procedure _dBaseDocument_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_47EB3E2202E6_var*
//#UC END# *4B16B8CF0307_47EB3E2202E6_var*
begin
//#UC START# *4B16B8CF0307_47EB3E2202E6_impl*
 f_DocInfo := aData.DocInfo.Clone;
 pm_GetDsDocumentRef.Assign(aData.dsDocumentRef);
 inherited;
//#UC END# *4B16B8CF0307_47EB3E2202E6_impl*
end;//_dBaseDocument_.AssignData
{$IfEnd} // NOT Defined(NoVCM)

procedure _dBaseDocument_.ClearFields;
begin
 f_dsDocumentRef := nil;
 f_DocInfo := nil;
 inherited;
end;//_dBaseDocument_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dBaseDocument_imp_impl}

{$EndIf dBaseDocument_imp}

