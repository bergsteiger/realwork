{$IfNDef dDocInfo_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dDocInfo.imp.pas"
// Начат: 12.07.2006
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> F1 Core::Common::Business::BaseDocument::dDocInfo
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define dDocInfo_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 TCRInfoArray = array [TnsUserCRListId] of IbsUserCRListInfoModify;

 {$Include ..\Document\dBaseDocumentWithAttributes.imp.pas}
 _dDocInfo_ = {mixin} class(_dBaseDocumentWithAttributes_, IdDocInfo)
 private
 // private fields
   f_UserCRListInfo : TCRInfoArray;
   f_RespList : IDynList;
   f_CorrList : IDynList;
   f_RespType : IbsFrozenNode;
   f_CorrType : IbsFrozenNode;
   f_dsSimilarDocumentsToFragmentRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsSimilarDocumentsToFragmentRef}
   f_IsUnderControl : Tl3Bool;
    {* Поле для свойства IsUnderControl}
   f_dsAnnotationRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsAnnotationRef}
   f_FlashData : IExternalObject;
    {* Поле для свойства FlashData}
   f_dsCorrespondentsRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsCorrespondentsRef}
   f_HasTranslation : Tl3Bool;
    {* Поле для свойства HasTranslation}
   f_HasSimilarDocuments : Tl3Bool;
    {* Поле для свойства HasSimilarDocuments}
   f_dsRelatedDocRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsRelatedDocRef}
   f_dsUserCR2Ref : IvcmFormDataSourceRef;
    {* Поле для свойства dsUserCR2Ref}
   f_HasAnnotation : Tl3Bool;
    {* Поле для свойства HasAnnotation}
   f_HasChronology : Tl3Bool;
    {* Поле для свойства HasChronology}
   f_HasCorrespondents : Tl3Bool;
    {* Поле для свойства HasCorrespondents}
   f_HasRelatedDoc : Tl3Bool;
    {* Поле для свойства HasRelatedDoc}
   f_dsRespondentsRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsRespondentsRef}
   f_dsChronologyRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsChronologyRef}
   f_dsDocumentWithFlashRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsDocumentWithFlashRef}
   f_HasRespondents : Tl3Bool;
    {* Поле для свойства HasRespondents}
   f_dsTranslationRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsTranslationRef}
   f_dsSimilarDocumentsRef : IvcmFormDataSourceRef;
    {* Поле для свойства dsSimilarDocumentsRef}
   f_dsUserCR1Ref : IvcmFormDataSourceRef;
    {* Поле для свойства dsUserCR1Ref}
 protected
 // realized methods
   function pm_GetDsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
   function pm_GetIsUnderControl: Tl3Bool;
   procedure pm_SetIsUnderControl(aValue: Tl3Bool);
   function pm_GetDsAnnotationRef: IvcmFormDataSourceRef;
   function pm_GetFlashData: IExternalObject;
   procedure pm_SetFlashData(const aValue: IExternalObject);
   function pm_GetDsCorrespondentsRef: IvcmFormDataSourceRef;
   function pm_GetHasTranslation: Tl3Bool;
   procedure pm_SetHasTranslation(aValue: Tl3Bool);
   function pm_GetHasSimilarDocuments: Tl3Bool;
   procedure pm_SetHasSimilarDocuments(aValue: Tl3Bool);
   function pm_GetDsRelatedDocRef: IvcmFormDataSourceRef;
   function pm_GetCorrType: IbsFrozenNode;
   procedure pm_SetCorrType(const aValue: IbsFrozenNode);
   function pm_GetCorrList: IDynList;
   procedure pm_SetCorrList(const aValue: IDynList);
   function pm_GetRespType: IbsFrozenNode;
   procedure pm_SetRespType(const aValue: IbsFrozenNode);
   function pm_GetRespList: IDynList;
   procedure pm_SetRespList(const aValue: IDynList);
   function pm_GetUserCRListInfo(aValue: TnsUserCRListId): IbsUserCRListInfoModify;
   function pm_GetDsUserCR2Ref: IvcmFormDataSourceRef;
   function pm_GetHasAnnotation: Tl3Bool;
   procedure pm_SetHasAnnotation(aValue: Tl3Bool);
   function pm_GetHasChronology: Tl3Bool;
   procedure pm_SetHasChronology(aValue: Tl3Bool);
   function pm_GetHasCorrespondents: Tl3Bool;
   procedure pm_SetHasCorrespondents(aValue: Tl3Bool);
   function pm_GetHasRelatedDoc: Tl3Bool;
   procedure pm_SetHasRelatedDoc(aValue: Tl3Bool);
   function pm_GetDsRespondentsRef: IvcmFormDataSourceRef;
   function pm_GetDsChronologyRef: IvcmFormDataSourceRef;
   function pm_GetDsDocumentWithFlashRef: IvcmFormDataSourceRef;
   function pm_GetHasRespondents: Tl3Bool;
   procedure pm_SetHasRespondents(aValue: Tl3Bool);
   function pm_GetDsTranslationRef: IvcmFormDataSourceRef;
   function pm_GetDsSimilarDocumentsRef: IvcmFormDataSourceRef;
   function pm_GetDsUserCR1Ref: IvcmFormDataSourceRef;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure DoResetBooleans; override;
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // overridden public methods
   {$If not defined(NoVCM)}
   constructor Create; override;
   {$IfEnd} //not NoVCM
 end;//_dDocInfo_
{$Else}

 {$Include ..\Document\dBaseDocumentWithAttributes.imp.pas}
 _dDocInfo_ = _dBaseDocumentWithAttributes_;

{$IfEnd} //not Admin AND not Monitorings

{$Else dDocInfo_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Document\dBaseDocumentWithAttributes.imp.pas}

// start class _dDocInfo_

function _dDocInfo_.pm_GetDsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsSimilarDocumentsToFragmentRef);
end;//_dDocInfo_.pm_GetDsSimilarDocumentsToFragmentRef

function _dDocInfo_.pm_GetIsUnderControl: Tl3Bool;
 {-}
begin
 Result := f_IsUnderControl;
end;//_dDocInfo_.pm_GetIsUnderControl

procedure _dDocInfo_.pm_SetIsUnderControl(aValue: Tl3Bool);
 {-}
begin
 f_IsUnderControl := aValue;
end;//_dDocInfo_.pm_SetIsUnderControl

function _dDocInfo_.pm_GetDsAnnotationRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsAnnotationRef);
end;//_dDocInfo_.pm_GetDsAnnotationRef

function _dDocInfo_.pm_GetFlashData: IExternalObject;
 {-}
begin
 Result := f_FlashData;
end;//_dDocInfo_.pm_GetFlashData

procedure _dDocInfo_.pm_SetFlashData(const aValue: IExternalObject);
 {-}
begin
 f_FlashData := aValue;
end;//_dDocInfo_.pm_SetFlashData

function _dDocInfo_.pm_GetDsCorrespondentsRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsCorrespondentsRef);
end;//_dDocInfo_.pm_GetDsCorrespondentsRef

function _dDocInfo_.pm_GetHasTranslation: Tl3Bool;
 {-}
begin
 Result := f_HasTranslation;
end;//_dDocInfo_.pm_GetHasTranslation

procedure _dDocInfo_.pm_SetHasTranslation(aValue: Tl3Bool);
 {-}
begin
 f_HasTranslation := aValue;
end;//_dDocInfo_.pm_SetHasTranslation

function _dDocInfo_.pm_GetHasSimilarDocuments: Tl3Bool;
 {-}
begin
 Result := f_HasSimilarDocuments;
end;//_dDocInfo_.pm_GetHasSimilarDocuments

procedure _dDocInfo_.pm_SetHasSimilarDocuments(aValue: Tl3Bool);
 {-}
begin
 f_HasSimilarDocuments := aValue;
end;//_dDocInfo_.pm_SetHasSimilarDocuments

function _dDocInfo_.pm_GetDsRelatedDocRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsRelatedDocRef);
end;//_dDocInfo_.pm_GetDsRelatedDocRef

function _dDocInfo_.pm_GetCorrType: IbsFrozenNode;
//#UC START# *4952847900AB_493D4E010178get_var*
//#UC END# *4952847900AB_493D4E010178get_var*
begin
//#UC START# *4952847900AB_493D4E010178get_impl*
 Result := f_CorrType;
//#UC END# *4952847900AB_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetCorrType

procedure _dDocInfo_.pm_SetCorrType(const aValue: IbsFrozenNode);
//#UC START# *4952847900AB_493D4E010178set_var*
//#UC END# *4952847900AB_493D4E010178set_var*
begin
//#UC START# *4952847900AB_493D4E010178set_impl*
 f_CorrType := aValue;
//#UC END# *4952847900AB_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetCorrType

function _dDocInfo_.pm_GetCorrList: IDynList;
//#UC START# *49528489009B_493D4E010178get_var*
//#UC END# *49528489009B_493D4E010178get_var*
begin
//#UC START# *49528489009B_493D4E010178get_impl*
 Result := f_CorrList;
//#UC END# *49528489009B_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetCorrList

procedure _dDocInfo_.pm_SetCorrList(const aValue: IDynList);
//#UC START# *49528489009B_493D4E010178set_var*
//#UC END# *49528489009B_493D4E010178set_var*
begin
//#UC START# *49528489009B_493D4E010178set_impl*
 f_CorrList := aValue;
//#UC END# *49528489009B_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetCorrList

function _dDocInfo_.pm_GetRespType: IbsFrozenNode;
//#UC START# *495284F00076_493D4E010178get_var*
//#UC END# *495284F00076_493D4E010178get_var*
begin
//#UC START# *495284F00076_493D4E010178get_impl*
 Result := f_RespType;
//#UC END# *495284F00076_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetRespType

procedure _dDocInfo_.pm_SetRespType(const aValue: IbsFrozenNode);
//#UC START# *495284F00076_493D4E010178set_var*
//#UC END# *495284F00076_493D4E010178set_var*
begin
//#UC START# *495284F00076_493D4E010178set_impl*
 f_RespType := aValue;
//#UC END# *495284F00076_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetRespType

function _dDocInfo_.pm_GetRespList: IDynList;
//#UC START# *495284FD02A0_493D4E010178get_var*
//#UC END# *495284FD02A0_493D4E010178get_var*
begin
//#UC START# *495284FD02A0_493D4E010178get_impl*
 Result := f_RespList;
//#UC END# *495284FD02A0_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetRespList

procedure _dDocInfo_.pm_SetRespList(const aValue: IDynList);
//#UC START# *495284FD02A0_493D4E010178set_var*
//#UC END# *495284FD02A0_493D4E010178set_var*
begin
//#UC START# *495284FD02A0_493D4E010178set_impl*
 f_RespList := aValue;
//#UC END# *495284FD02A0_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetRespList

function _dDocInfo_.pm_GetUserCRListInfo(aValue: TnsUserCRListId): IbsUserCRListInfoModify;
//#UC START# *495285A503C4_493D4E010178get_var*
//#UC END# *495285A503C4_493D4E010178get_var*
begin
//#UC START# *495285A503C4_493D4E010178get_impl*
 if f_UserCRListInfo[aValue] = nil then
  f_UserCRListInfo[aValue] := TbsUserCRListInfo.Make;
 Result := f_UserCRListInfo[aValue];
//#UC END# *495285A503C4_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetUserCRListInfo

function _dDocInfo_.pm_GetDsUserCR2Ref: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsUserCR2Ref);
end;//_dDocInfo_.pm_GetDsUserCR2Ref

function _dDocInfo_.pm_GetHasAnnotation: Tl3Bool;
 {-}
begin
 Result := f_HasAnnotation;
end;//_dDocInfo_.pm_GetHasAnnotation

procedure _dDocInfo_.pm_SetHasAnnotation(aValue: Tl3Bool);
 {-}
begin
 f_HasAnnotation := aValue;
end;//_dDocInfo_.pm_SetHasAnnotation

function _dDocInfo_.pm_GetHasChronology: Tl3Bool;
 {-}
begin
 Result := f_HasChronology;
end;//_dDocInfo_.pm_GetHasChronology

procedure _dDocInfo_.pm_SetHasChronology(aValue: Tl3Bool);
 {-}
begin
 f_HasChronology := aValue;
end;//_dDocInfo_.pm_SetHasChronology

function _dDocInfo_.pm_GetHasCorrespondents: Tl3Bool;
 {-}
begin
 Result := f_HasCorrespondents;
end;//_dDocInfo_.pm_GetHasCorrespondents

procedure _dDocInfo_.pm_SetHasCorrespondents(aValue: Tl3Bool);
 {-}
begin
 f_HasCorrespondents := aValue;
end;//_dDocInfo_.pm_SetHasCorrespondents

function _dDocInfo_.pm_GetHasRelatedDoc: Tl3Bool;
 {-}
begin
 Result := f_HasRelatedDoc;
end;//_dDocInfo_.pm_GetHasRelatedDoc

procedure _dDocInfo_.pm_SetHasRelatedDoc(aValue: Tl3Bool);
 {-}
begin
 f_HasRelatedDoc := aValue;
end;//_dDocInfo_.pm_SetHasRelatedDoc

function _dDocInfo_.pm_GetDsRespondentsRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsRespondentsRef);
end;//_dDocInfo_.pm_GetDsRespondentsRef

function _dDocInfo_.pm_GetDsChronologyRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsChronologyRef);
end;//_dDocInfo_.pm_GetDsChronologyRef

function _dDocInfo_.pm_GetDsDocumentWithFlashRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsDocumentWithFlashRef);
end;//_dDocInfo_.pm_GetDsDocumentWithFlashRef

function _dDocInfo_.pm_GetHasRespondents: Tl3Bool;
 {-}
begin
 Result := f_HasRespondents;
end;//_dDocInfo_.pm_GetHasRespondents

procedure _dDocInfo_.pm_SetHasRespondents(aValue: Tl3Bool);
 {-}
begin
 f_HasRespondents := aValue;
end;//_dDocInfo_.pm_SetHasRespondents

function _dDocInfo_.pm_GetDsTranslationRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsTranslationRef);
end;//_dDocInfo_.pm_GetDsTranslationRef

function _dDocInfo_.pm_GetDsSimilarDocumentsRef: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsSimilarDocumentsRef, vcm_nmYes);
end;//_dDocInfo_.pm_GetDsSimilarDocumentsRef

function _dDocInfo_.pm_GetDsUserCR1Ref: IvcmFormDataSourceRef;
 {-}
begin
 Result := vcmCheckAndMake(f_dsUserCR1Ref);
end;//_dDocInfo_.pm_GetDsUserCR1Ref

procedure _dDocInfo_.Cleanup;
//#UC START# *479731C50290_493D4E010178_var*
var
 l_Index: TnsUserCRListId;
//#UC END# *479731C50290_493D4E010178_var*
begin
//#UC START# *479731C50290_493D4E010178_impl*
 for l_Index := Low(TnsUserCRListId) to High(TnsUserCRListId) do
  f_UserCRListInfo[l_Index] := nil;
 ResetBooleans;
 f_CorrType := nil;
 f_RespType := nil;
 f_CorrList := nil;
 f_RespList := nil;
 inherited;
//#UC END# *479731C50290_493D4E010178_impl*
end;//_dDocInfo_.Cleanup

{$If not defined(NoVCM)}
procedure _dDocInfo_.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_493D4E010178_var*
var
 l_Index   : TnsUserCRListId;
//#UC END# *4B16B8CF0307_493D4E010178_var*
begin
//#UC START# *4B16B8CF0307_493D4E010178_impl*
 for l_Index := Low(TnsUserCRListId) to High(TnsUserCRListId) do
  f_UserCRListInfo[l_Index] := aData.UserCRListInfo[l_Index];
 f_HasRelatedDoc := aData.HasRelatedDoc;
 f_HasAttributes := aData.HasAttributes;
 f_HasRespondents := aData.HasRespondents;
 f_HasCorrespondents := aData.HasCorrespondents;
 f_HasAnnotation := aData.HasAnnotation;
 f_HasSimilarDocuments := aData.HasSimilarDocuments;
 f_HasChronology := aData.HasChronology;
 f_IsUnderControl := aData.IsUnderControl;
 f_HasTranslation := aData.HasTranslation;
 f_CorrType := aData.CorrType;
 f_RespType := aData.RespType;
 f_CorrList := aData.CorrList;
 f_RespList := aData.RespList;
 pm_GetDsDocumentWithFlashRef.Assign(aData.dsDocumentWithFlashRef);
 pm_GetDsAttributesRef.Assign(aData.dsAttributesRef);
 pm_GetdsRelatedDocRef.Assign(aData.dsRelatedDocRef);
 pm_GetdsRespondentsRef.Assign(aData.dsRespondentsRef);
 pm_GetdsCorrespondentsRef.Assign(aData.dsCorrespondentsRef);
 pm_GetdsAnnotationRef.Assign(aData.dsAnnotationRef);
 pm_GetdsSimilarDocumentsRef.Assign(aData.dsSimilarDocumentsRef);
 pm_GetdsChronologyRef.Assign(aData.dsChronologyRef);
 inherited;
//#UC END# *4B16B8CF0307_493D4E010178_impl*
end;//_dDocInfo_.AssignData
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
constructor _dDocInfo_.Create;
//#UC START# *4B16B8E3013F_493D4E010178_var*
//#UC END# *4B16B8E3013F_493D4E010178_var*
begin
//#UC START# *4B16B8E3013F_493D4E010178_impl*
 inherited;
 f_HasSimilarDocuments := l3_bUnknown;
 f_HasRelatedDoc := l3_bUnknown;
 f_HasAttributes := l3_bUnknown;
 f_HasRespondents := l3_bUnknown;
 f_HasCorrespondents := l3_bUnknown;
 f_HasAnnotation := l3_bUnknown;
 f_IsUnderControl := l3_bUnknown;
 f_HasTranslation := l3_bUnknown;
 f_HasChronology := l3_bUnknown;
//#UC END# *4B16B8E3013F_493D4E010178_impl*
end;//_dDocInfo_.Create
{$IfEnd} //not NoVCM

procedure _dDocInfo_.DoResetBooleans;
//#UC START# *4B18134E01F8_493D4E010178_var*
//#UC END# *4B18134E01F8_493D4E010178_var*
begin
//#UC START# *4B18134E01F8_493D4E010178_impl*
 inherited;
 l3BoolReset(f_HasSimilarDocuments);
 l3BoolReset(f_HasCorrespondents);
 l3BoolReset(f_HasTranslation);
 l3BoolReset(f_HasRelatedDoc);
 l3BoolReset(f_HasRespondents);
 l3BoolReset(f_HasAnnotation);
 l3BoolReset(f_IsUnderControl);
 l3BoolReset(f_HasChronology);
//#UC END# *4B18134E01F8_493D4E010178_impl*
end;//_dDocInfo_.DoResetBooleans

procedure _dDocInfo_.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_RespList := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_CorrList := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_RespType := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsSimilarDocumentsToFragmentRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsAnnotationRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_FlashData := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsCorrespondentsRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsRelatedDocRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsUserCR2Ref := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsRespondentsRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsChronologyRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsDocumentWithFlashRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsTranslationRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsSimilarDocumentsRef := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_dsUserCR1Ref := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//_dDocInfo_.ClearFields

{$IfEnd} //not Admin AND not Monitorings

{$EndIf dDocInfo_imp}
