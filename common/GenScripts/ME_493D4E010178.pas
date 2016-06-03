{$IfNDef dDocInfo_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\NOT_COMPLETED_dDocInfo.imp.pas"
// Стереотип: "Impurity"
// Элемент модели: "dDocInfo" MUID: (493D4E010178)
// Имя типа: "_dDocInfo_"

{$Define dDocInfo_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
type
 TCRInfoArray = array [TnsUserCRListId] of IbsUserCRListInfoModify;

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
 _dDocInfo_ = class(_dBaseDocumentWithAttributes_, IdDocInfo)
  private
   f_UserCRListInfo: TCRInfoArray;
   f_RespList: IDynList;
   f_CorrList: IDynList;
   f_RespType: IbsFrozenNode;
   f_CorrType: IbsFrozenNode;
   f_dsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
    {* Ссылка на "dsSimilarDocumentsToFragment" }
   f_IsUnderControl: Tl3Bool;
    {* поставлен ли документ на контроль }
   f_dsAnnotationRef: IvcmFormDataSourceRef;
    {* Ссылка на "аннотация к документу" }
   f_FlashData: IExternalObject;
    {* данные ролика }
   f_dsCorrespondentsRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ корреспонденты документа" }
   f_HasTranslation: Tl3Bool;
    {* Есть ли "БОФ перевода документа" }
   f_HasSimilarDocuments: Tl3Bool;
    {* Есть ли "БОФ похожие документы" }
   f_dsRelatedDocRef: IvcmFormDataSourceRef;
    {* Ссылка на "справка к документу" }
   f_dsUserCR2Ref: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ пользовательский СКР2" }
   f_HasAnnotation: Tl3Bool;
    {* Есть ли "аннотация к документу" }
   f_HasChronology: Tl3Bool;
    {* Есть ли "Хронология судебного дела" }
   f_HasCorrespondents: Tl3Bool;
    {* Есть ли "БОФ корреспонденты документа" }
   f_HasRelatedDoc: Tl3Bool;
    {* Есть ли "справка к документу" }
   f_dsRespondentsRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ респонденты документа" }
   f_dsChronologyRef: IvcmFormDataSourceRef;
    {* Ссылка на "Хронология судебного дела" }
   f_dsDocumentWithFlashRef: IvcmFormDataSourceRef;
    {* Ссылка на "документ-схема" }
   f_HasRespondents: Tl3Bool;
    {* Есть ли "БОФ респонденты документа" }
   f_dsTranslationRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ перевода документа" }
   f_dsSimilarDocumentsRef: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ похожие документы" }
   f_dsUserCR1Ref: IvcmFormDataSourceRef;
    {* Ссылка на "БОФ пользовательский СКР1" }
  protected
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

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}
_dDocInfo_ = _dBaseDocumentWithAttributes_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dDocInfo_imp}

{$IfNDef dDocInfo_imp_impl}

{$Define dDocInfo_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dBaseDocumentWithAttributes.imp.pas}

function _dDocInfo_.pm_GetDsSimilarDocumentsToFragmentRef: IvcmFormDataSourceRef;
//#UC START# *04CD377DE4D3_493D4E010178get_var*
//#UC END# *04CD377DE4D3_493D4E010178get_var*
begin
//#UC START# *04CD377DE4D3_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *04CD377DE4D3_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsSimilarDocumentsToFragmentRef

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

function _dDocInfo_.pm_GetDsAnnotationRef: IvcmFormDataSourceRef;
//#UC START# *0FDAEE3892EB_493D4E010178get_var*
//#UC END# *0FDAEE3892EB_493D4E010178get_var*
begin
//#UC START# *0FDAEE3892EB_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *0FDAEE3892EB_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsAnnotationRef

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

function _dDocInfo_.pm_GetDsCorrespondentsRef: IvcmFormDataSourceRef;
//#UC START# *37162BB4A02F_493D4E010178get_var*
//#UC END# *37162BB4A02F_493D4E010178get_var*
begin
//#UC START# *37162BB4A02F_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *37162BB4A02F_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsCorrespondentsRef

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

function _dDocInfo_.pm_GetDsRelatedDocRef: IvcmFormDataSourceRef;
//#UC START# *3CBE4373050B_493D4E010178get_var*
//#UC END# *3CBE4373050B_493D4E010178get_var*
begin
//#UC START# *3CBE4373050B_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3CBE4373050B_493D4E010178get_impl*
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
//#UC START# *4F5735E5EA84_493D4E010178get_var*
//#UC END# *4F5735E5EA84_493D4E010178get_var*
begin
//#UC START# *4F5735E5EA84_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F5735E5EA84_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsUserCR2Ref

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

function _dDocInfo_.pm_GetDsRespondentsRef: IvcmFormDataSourceRef;
//#UC START# *8DD9C2AE3DFA_493D4E010178get_var*
//#UC END# *8DD9C2AE3DFA_493D4E010178get_var*
begin
//#UC START# *8DD9C2AE3DFA_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *8DD9C2AE3DFA_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsRespondentsRef

function _dDocInfo_.pm_GetDsChronologyRef: IvcmFormDataSourceRef;
//#UC START# *B2A2CF0FB989_493D4E010178get_var*
//#UC END# *B2A2CF0FB989_493D4E010178get_var*
begin
//#UC START# *B2A2CF0FB989_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *B2A2CF0FB989_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsChronologyRef

function _dDocInfo_.pm_GetDsDocumentWithFlashRef: IvcmFormDataSourceRef;
//#UC START# *CB72B7119954_493D4E010178get_var*
//#UC END# *CB72B7119954_493D4E010178get_var*
begin
//#UC START# *CB72B7119954_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *CB72B7119954_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsDocumentWithFlashRef

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

function _dDocInfo_.pm_GetDsTranslationRef: IvcmFormDataSourceRef;
//#UC START# *ECA6B53155C1_493D4E010178get_var*
//#UC END# *ECA6B53155C1_493D4E010178get_var*
begin
//#UC START# *ECA6B53155C1_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECA6B53155C1_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsTranslationRef

function _dDocInfo_.pm_GetDsSimilarDocumentsRef: IvcmFormDataSourceRef;
//#UC START# *ECDDF80BA223_493D4E010178get_var*
//#UC END# *ECDDF80BA223_493D4E010178get_var*
begin
//#UC START# *ECDDF80BA223_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *ECDDF80BA223_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsSimilarDocumentsRef

function _dDocInfo_.pm_GetDsUserCR1Ref: IvcmFormDataSourceRef;
//#UC START# *F86E7A026616_493D4E010178get_var*
//#UC END# *F86E7A026616_493D4E010178get_var*
begin
//#UC START# *F86E7A026616_493D4E010178get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F86E7A026616_493D4E010178get_impl*
end;//_dDocInfo_.pm_GetDsUserCR1Ref

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

