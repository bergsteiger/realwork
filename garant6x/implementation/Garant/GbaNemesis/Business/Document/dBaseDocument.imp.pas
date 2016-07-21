{$IfNDef dBaseDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocument.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "dBaseDocument" MUID: (47EB3E2202E6)
// Имя типа: "_dBaseDocument_"

{$Define dBaseDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 _dBaseDocument_ = class(_vcmData_, IdBaseDocument)
  {* Данные сборки документа }
  private
   f_dsDocumentRef: IvcmFormDataSourceRef;
    {* Ссылка на "Собственно документ" }
   f_HasDocument: Tl3Bool;
    {* Есть ли "Собственно документ" }
   f_DocInfo: IdeDocInfo;
    {* DocInfo }
  protected
   function pm_GetDsDocumentRef: IvcmFormDataSourceRef;
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

function _dBaseDocument_.pm_GetDsDocumentRef: IvcmFormDataSourceRef;
begin
 Result := vcmCheckAndMake(f_dsDocumentRef);
end;//_dBaseDocument_.pm_GetDsDocumentRef

function _dBaseDocument_.pm_GetHasDocument: Tl3Bool;
begin
 Result := f_HasDocument;
end;//_dBaseDocument_.pm_GetHasDocument

procedure _dBaseDocument_.pm_SetHasDocument(aValue: Tl3Bool);
begin
 f_HasDocument := aValue;
end;//_dBaseDocument_.pm_SetHasDocument

function _dBaseDocument_.pm_GetDocInfo: IdeDocInfo;
begin
 Result := f_DocInfo;
end;//_dBaseDocument_.pm_GetDocInfo

procedure _dBaseDocument_.pm_SetDocInfo(const aValue: IdeDocInfo);
begin
 f_DocInfo := aValue;
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

