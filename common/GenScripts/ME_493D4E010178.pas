{$IfNDef dDocInfo_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dDocInfo.imp.pas"
// Стереотип: "Impurity"

{$Define dDocInfo_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
type
 TCRInfoArray = array [TnsUserCRListId] of IbsUserCRListInfoModify;

 {$Include dBaseDocumentWithAttributes.imp.pas}
 _dDocInfo_ = class(_dBaseDocumentWithAttributes_, IdDocInfo)
  private
   f_UserCRListInfo: TCRInfoArray;
   f_RespList: IDynList;
   f_CorrList: IDynList;
   f_RespType: IbsFrozenNode;
   f_CorrType: IbsFrozenNode;
   f_dsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsSimilarDocumentsToFragmentRef }
   f_IsUnderControl: Tl3Bool;
    {* Поле для свойства IsUnderControl }
   f_dsAnnotationRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsAnnotationRef }
   f_FlashData: IExternalObject;
    {* Поле для свойства FlashData }
   f_dsCorrespondentsRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsCorrespondentsRef }
   f_HasTranslation: Tl3Bool;
    {* Поле для свойства HasTranslation }
   f_HasSimilarDocuments: Tl3Bool;
    {* Поле для свойства HasSimilarDocuments }
   f_dsRelatedDocRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsRelatedDocRef }
   f_dsUserCR2Ref: IvcmFormDataSourceRef;
    {* Поле для свойства dsUserCR2Ref }
   f_HasAnnotation: Tl3Bool;
    {* Поле для свойства HasAnnotation }
   f_HasChronology: Tl3Bool;
    {* Поле для свойства HasChronology }
   f_HasCorrespondents: Tl3Bool;
    {* Поле для свойства HasCorrespondents }
   f_HasRelatedDoc: Tl3Bool;
    {* Поле для свойства HasRelatedDoc }
   f_dsRespondentsRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsRespondentsRef }
   f_dsChronologyRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsChronologyRef }
   f_dsDocumentWithFlashRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsDocumentWithFlashRef }
   f_HasRespondents: Tl3Bool;
    {* Поле для свойства HasRespondents }
   f_dsTranslationRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsTranslationRef }
   f_dsSimilarDocumentsRef: IvcmFormDataSourceRef;
    {* Поле для свойства dsSimilarDocumentsRef }
   f_dsUserCR1Ref: IvcmFormDataSourceRef;
    {* Поле для свойства dsUserCR1Ref }
  protected
   function pm_GetdsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
   function pm_GetIsUnderControl: Tl3Bool;
   procedure pm_SetIsUnderControl(aValue: Tl3Bool);
   function pm_GetdsAnnotationRef: IvcmFormDataSourceRef;
   function pm_GetFlashData: IExternalObject;
   procedure pm_SetFlashData(const aValue: IExternalObject);
   function pm_GetdsCorrespondentsRef: IvcmFormDataSourceRef;
   function pm_GetHasTranslation: Tl3Bool;
   procedure pm_SetHasTranslation(aValue: Tl3Bool);
   function pm_GetHasSimilarDocuments: Tl3Bool;
   procedure pm_SetHasSimilarDocuments(aValue: Tl3Bool);
   function pm_GetdsRelatedDocRef: IvcmFormDataSourceRef;
   function pm_GetCorrType: IbsFrozenNode;
   procedure pm_SetCorrType(const aValue: IbsFrozenNode);
   function pm_GetCorrList: IDynList;
   procedure pm_SetCorrList(const aValue: IDynList);
   function pm_GetRespType: IbsFrozenNode;
   procedure pm_SetRespType(const aValue: IbsFrozenNode);
   function pm_GetRespList: IDynList;
   procedure pm_SetRespList(const aValue: IDynList);
   function pm_GetUserCRListInfo(aValue: TnsUserCRListId): IbsUserCRListInfoModify;
   function pm_GetdsUserCR2Ref: IvcmFormDataSourceRef;
   function pm_GetHasAnnotation: Tl3Bool;
   procedure pm_SetHasAnnotation(aValue: Tl3Bool);
   function pm_GetHasChronology: Tl3Bool;
   procedure pm_SetHasChronology(aValue: Tl3Bool);
   function pm_GetHasCorrespondents: Tl3Bool;
   procedure pm_SetHasCorrespondents(aValue: Tl3Bool);
   function pm_GetHasRelatedDoc: Tl3Bool;
   procedure pm_SetHasRelatedDoc(aValue: Tl3Bool);
   function pm_GetdsRespondentsRef: IvcmFormDataSourceRef;
   function pm_GetdsChronologyRef: IvcmFormDataSourceRef;
   function pm_GetdsDocumentWithFlashRef: IvcmFormDataSourceRef;
   function pm_GetHasRespondents: Tl3Bool;
   procedure pm_SetHasRespondents(aValue: Tl3Bool);
   function pm_GetdsTranslationRef: IvcmFormDataSourceRef;
   function pm_GetdsSimilarDocumentsRef: IvcmFormDataSourceRef;
   function pm_GetdsUserCR1Ref: IvcmFormDataSourceRef;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure DoResetBooleans; override;
   procedure ClearFields; override;
  public
   {$If NOT Defined(NoVCM)}
   constructor Create; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//_dDocInfo_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include dBaseDocumentWithAttributes.imp.pas}
_dDocInfo_ = _dBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dDocInfo_imp}

{$IfNDef dDocInfo_imp_impl}

{$Define dDocInfo_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include dBaseDocumentWithAttributes.imp.pas}

function _dDocInfo_.pm_GetdsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
//#UC START# *04CD377DE4D3_493D4E010178get_var*
//#UC END# *04CD377DE4D3_493D4E010178get_var*
begin
//#UC START# *04CD377DE4D3_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *04CD377DE4D3_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsSimilarDocumentsToFragmentRef

function _dDocInfo_.pm_GetIsUnderControl: Tl3Bool;
//#UC START# *09E3D10967EC_493D4E010178get_var*
//#UC END# *09E3D10967EC_493D4E010178get_var*
begin
//#UC START# *09E3D10967EC_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *09E3D10967EC_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetIsUnderControl

procedure _dDocInfo_.pm_SetIsUnderControl(aValue: Tl3Bool);
//#UC START# *09E3D10967EC_493D4E010178set_var*
//#UC END# *09E3D10967EC_493D4E010178set_var*
begin
//#UC START# *09E3D10967EC_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *09E3D10967EC_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetIsUnderControl

function _dDocInfo_.pm_GetdsAnnotationRef: IvcmFormDataSourceRef;
//#UC START# *0FDAEE3892EB_493D4E010178get_var*
//#UC END# *0FDAEE3892EB_493D4E010178get_var*
begin
//#UC START# *0FDAEE3892EB_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0FDAEE3892EB_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsAnnotationRef

function _dDocInfo_.pm_GetFlashData: IExternalObject;
//#UC START# *3561F2BAF64C_493D4E010178get_var*
//#UC END# *3561F2BAF64C_493D4E010178get_var*
begin
//#UC START# *3561F2BAF64C_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3561F2BAF64C_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetFlashData

procedure _dDocInfo_.pm_SetFlashData(const aValue: IExternalObject);
//#UC START# *3561F2BAF64C_493D4E010178set_var*
//#UC END# *3561F2BAF64C_493D4E010178set_var*
begin
//#UC START# *3561F2BAF64C_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *3561F2BAF64C_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetFlashData

function _dDocInfo_.pm_GetdsCorrespondentsRef: IvcmFormDataSourceRef;
//#UC START# *37162BB4A02F_493D4E010178get_var*
//#UC END# *37162BB4A02F_493D4E010178get_var*
begin
//#UC START# *37162BB4A02F_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *37162BB4A02F_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsCorrespondentsRef

function _dDocInfo_.pm_GetHasTranslation: Tl3Bool;
//#UC START# *386DA8B0B24E_493D4E010178get_var*
//#UC END# *386DA8B0B24E_493D4E010178get_var*
begin
//#UC START# *386DA8B0B24E_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *386DA8B0B24E_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasTranslation

procedure _dDocInfo_.pm_SetHasTranslation(aValue: Tl3Bool);
//#UC START# *386DA8B0B24E_493D4E010178set_var*
//#UC END# *386DA8B0B24E_493D4E010178set_var*
begin
//#UC START# *386DA8B0B24E_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *386DA8B0B24E_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasTranslation

function _dDocInfo_.pm_GetHasSimilarDocuments: Tl3Bool;
//#UC START# *38A4EB8BFEB0_493D4E010178get_var*
//#UC END# *38A4EB8BFEB0_493D4E010178get_var*
begin
//#UC START# *38A4EB8BFEB0_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *38A4EB8BFEB0_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasSimilarDocuments

procedure _dDocInfo_.pm_SetHasSimilarDocuments(aValue: Tl3Bool);
//#UC START# *38A4EB8BFEB0_493D4E010178set_var*
//#UC END# *38A4EB8BFEB0_493D4E010178set_var*
begin
//#UC START# *38A4EB8BFEB0_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *38A4EB8BFEB0_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasSimilarDocuments

function _dDocInfo_.pm_GetdsRelatedDocRef: IvcmFormDataSourceRef;
//#UC START# *3CBE4373050B_493D4E010178get_var*
//#UC END# *3CBE4373050B_493D4E010178get_var*
begin
//#UC START# *3CBE4373050B_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3CBE4373050B_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsRelatedDocRef

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

function _dDocInfo_.pm_GetdsUserCR2Ref: IvcmFormDataSourceRef;
//#UC START# *4F5735E5EA84_493D4E010178get_var*
//#UC END# *4F5735E5EA84_493D4E010178get_var*
begin
//#UC START# *4F5735E5EA84_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F5735E5EA84_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsUserCR2Ref

function _dDocInfo_.pm_GetHasAnnotation: Tl3Bool;
//#UC START# *5BA1E1B8EF77_493D4E010178get_var*
//#UC END# *5BA1E1B8EF77_493D4E010178get_var*
begin
//#UC START# *5BA1E1B8EF77_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5BA1E1B8EF77_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasAnnotation

procedure _dDocInfo_.pm_SetHasAnnotation(aValue: Tl3Bool);
//#UC START# *5BA1E1B8EF77_493D4E010178set_var*
//#UC END# *5BA1E1B8EF77_493D4E010178set_var*
begin
//#UC START# *5BA1E1B8EF77_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *5BA1E1B8EF77_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasAnnotation

function _dDocInfo_.pm_GetHasChronology: Tl3Bool;
//#UC START# *638373ED1616_493D4E010178get_var*
//#UC END# *638373ED1616_493D4E010178get_var*
begin
//#UC START# *638373ED1616_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *638373ED1616_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasChronology

procedure _dDocInfo_.pm_SetHasChronology(aValue: Tl3Bool);
//#UC START# *638373ED1616_493D4E010178set_var*
//#UC END# *638373ED1616_493D4E010178set_var*
begin
//#UC START# *638373ED1616_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *638373ED1616_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasChronology

function _dDocInfo_.pm_GetHasCorrespondents: Tl3Bool;
//#UC START# *82DD1F33FCBB_493D4E010178get_var*
//#UC END# *82DD1F33FCBB_493D4E010178get_var*
begin
//#UC START# *82DD1F33FCBB_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *82DD1F33FCBB_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasCorrespondents

procedure _dDocInfo_.pm_SetHasCorrespondents(aValue: Tl3Bool);
//#UC START# *82DD1F33FCBB_493D4E010178set_var*
//#UC END# *82DD1F33FCBB_493D4E010178set_var*
begin
//#UC START# *82DD1F33FCBB_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *82DD1F33FCBB_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasCorrespondents

function _dDocInfo_.pm_GetHasRelatedDoc: Tl3Bool;
//#UC START# *888536F26197_493D4E010178get_var*
//#UC END# *888536F26197_493D4E010178get_var*
begin
//#UC START# *888536F26197_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *888536F26197_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasRelatedDoc

procedure _dDocInfo_.pm_SetHasRelatedDoc(aValue: Tl3Bool);
//#UC START# *888536F26197_493D4E010178set_var*
//#UC END# *888536F26197_493D4E010178set_var*
begin
//#UC START# *888536F26197_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *888536F26197_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasRelatedDoc

function _dDocInfo_.pm_GetdsRespondentsRef: IvcmFormDataSourceRef;
//#UC START# *8DD9C2AE3DFA_493D4E010178get_var*
//#UC END# *8DD9C2AE3DFA_493D4E010178get_var*
begin
//#UC START# *8DD9C2AE3DFA_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8DD9C2AE3DFA_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsRespondentsRef

function _dDocInfo_.pm_GetdsChronologyRef: IvcmFormDataSourceRef;
//#UC START# *B2A2CF0FB989_493D4E010178get_var*
//#UC END# *B2A2CF0FB989_493D4E010178get_var*
begin
//#UC START# *B2A2CF0FB989_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B2A2CF0FB989_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsChronologyRef

function _dDocInfo_.pm_GetdsDocumentWithFlashRef: IvcmFormDataSourceRef;
//#UC START# *CB72B7119954_493D4E010178get_var*
//#UC END# *CB72B7119954_493D4E010178get_var*
begin
//#UC START# *CB72B7119954_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CB72B7119954_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsDocumentWithFlashRef

function _dDocInfo_.pm_GetHasRespondents: Tl3Bool;
//#UC START# *D9A0B62E9A86_493D4E010178get_var*
//#UC END# *D9A0B62E9A86_493D4E010178get_var*
begin
//#UC START# *D9A0B62E9A86_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9A0B62E9A86_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetHasRespondents

procedure _dDocInfo_.pm_SetHasRespondents(aValue: Tl3Bool);
//#UC START# *D9A0B62E9A86_493D4E010178set_var*
//#UC END# *D9A0B62E9A86_493D4E010178set_var*
begin
//#UC START# *D9A0B62E9A86_493D4E010178set_impl*
 !!! Needs to be implemented !!!
//#UC END# *D9A0B62E9A86_493D4E010178set_impl*
end;//_dDocInfo_.pm_SetHasRespondents

function _dDocInfo_.pm_GetdsTranslationRef: IvcmFormDataSourceRef;
//#UC START# *ECA6B53155C1_493D4E010178get_var*
//#UC END# *ECA6B53155C1_493D4E010178get_var*
begin
//#UC START# *ECA6B53155C1_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECA6B53155C1_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsTranslationRef

function _dDocInfo_.pm_GetdsSimilarDocumentsRef: IvcmFormDataSourceRef;
//#UC START# *ECDDF80BA223_493D4E010178get_var*
//#UC END# *ECDDF80BA223_493D4E010178get_var*
begin
//#UC START# *ECDDF80BA223_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECDDF80BA223_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsSimilarDocumentsRef

function _dDocInfo_.pm_GetdsUserCR1Ref: IvcmFormDataSourceRef;
//#UC START# *F86E7A026616_493D4E010178get_var*
//#UC END# *F86E7A026616_493D4E010178get_var*
begin
//#UC START# *F86E7A026616_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F86E7A026616_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetdsUserCR1Ref

procedure _dDocInfo_.Cleanup;
 {* Функция очистки полей объекта. }
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

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
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
{$IfEnd} // NOT Defined(NoVCM)

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
begin
 f_RespList := nil;
 f_CorrList := nil;
 f_RespType := nil;
 f_dsSimilarDocumentsToFragmentRef := nil;
 f_dsAnnotationRef := nil;
 f_FlashData := nil;
 f_dsCorrespondentsRef := nil;
 f_dsRelatedDocRef := nil;
 f_dsUserCR2Ref := nil;
 f_dsRespondentsRef := nil;
 f_dsChronologyRef := nil;
 f_dsDocumentWithFlashRef := nil;
 f_dsTranslationRef := nil;
 f_dsSimilarDocumentsRef := nil;
 f_dsUserCR1Ref := nil;
 inherited;
end;//_dDocInfo_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dDocInfo_imp_impl}

{$EndIf dDocInfo_imp}

