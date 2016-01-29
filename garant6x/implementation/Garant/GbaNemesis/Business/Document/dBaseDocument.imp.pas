{$IfNDef dBaseDocument_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dBaseDocument.imp.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Common::Business::BaseDocument::dBaseDocument
//
// Данные сборки документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dBaseDocument_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 _dBaseDocument_ = {mixin} class(_vcmData_, IdBaseDocument)
  {* Данные сборки документа }
 private
 // private fields
   f_dsDocumentRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsDocumentRef}
   f_HasDocument : Tl3Bool;
    {* Поле для свойства HasDocument}
   f_DocInfo : IdeDocInfo;
    {* Поле для свойства DocInfo}
 protected
 // realized methods
   function pm_GetDsDocumentRef: IvcmFormDataSourceRef;
   function pm_GetHasDocument: Tl3Bool;
   procedure pm_SetHasDocument(aValue: Tl3Bool);
   function pm_GetDocInfo: IdeDocInfo;
   procedure pm_SetDocInfo(const aValue: IdeDocInfo);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 end;//_dBaseDocument_
{$Else}

 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 _dBaseDocument_ = _vcmData_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dBaseDocument_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}

// start class _dBaseDocument_

function _dBaseDocument_.pm_GetDsDocumentRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsDocumentRef);
end;//_dBaseDocument_.pm_GetDsDocumentRef

function _dBaseDocument_.pm_GetHasDocument: Tl3Bool;
 {-}
begin
 Result := f_HasDocument;
end;//_dBaseDocument_.pm_GetHasDocument

procedure _dBaseDocument_.pm_SetHasDocument(aValue: Tl3Bool);
 {-}
begin
 f_HasDocument := aValue;
end;//_dBaseDocument_.pm_SetHasDocument

function _dBaseDocument_.pm_GetDocInfo: IdeDocInfo;
 {-}
begin
 Result := f_DocInfo;
end;//_dBaseDocument_.pm_GetDocInfo

procedure _dBaseDocument_.pm_SetDocInfo(const aValue: IdeDocInfo);
 {-}
begin
 f_DocInfo := aValue;
end;//_dBaseDocument_.pm_SetDocInfo

procedure _dBaseDocument_.Cleanup;
//#UC START# *479731C50290_47EB3E2202E6_var*
//#UC END# *479731C50290_47EB3E2202E6_var*
begin
//#UC START# *479731C50290_47EB3E2202E6_impl*
 f_DocInfo := nil;
 inherited;
//#UC END# *479731C50290_47EB3E2202E6_impl*
end;//_dBaseDocument_.Cleanup

{$If not defined(NoVCM)}
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
{$IfEnd} //not NoVCM

procedure _dBaseDocument_.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsDocumentRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_DocInfo := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//_dBaseDocument_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dBaseDocument_imp}
