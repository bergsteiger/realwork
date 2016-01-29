unit fstList;

interface

uses
 vcmFormSet,
 fstListInterfaces,
 SimpleListInterfaces,
 vcmBaseTypes,
 vcmInterfaces,
 vcmFormSetFormItemList,

 WorkWithListInterfaces,
 nsListSynchroFormTypesList,

 BaseDocumentFSInterfaces,
 BaseDocumentWithAttributesFSInterfaces,
 DocInfoFSInterfaces,

 bsTypes;

type
 _fstFormSetWithSynchroForm_Parent_ = TvcmFormSet;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\List\fstFormSetWithSynchroForm.imp.pas}
 (* Реализация сборки форм прецедента "Работа со списком" *)
 TfstList = class(_fstFormSetWithSynchroForm_, IfstList, IucpFilters)
 private
  f_DisableAutoOpenAnnotation: Boolean;
 protected
  procedure DoOpenCorrespondents;
  procedure DoOpenRespondents;
  procedure DoOpenAttributes;
  procedure DoOpenAnnotation;
  // IfstList
  procedure Open;
  procedure OpenDocument;
  procedure OpenAttributes;
  procedure OpenCorrespondents;
  procedure OpenRespondents;
  procedure OpenAnnotation;
  procedure OpenSimilar;
  procedure OpenRelated;
  {* Открывает ViewArea "Собственно документ" }
  procedure SetNeedMakeForFullCR(aListType: TlstCRType);
  function StateIfNeedShowFullCRList: TvcmNeedMakeDS;
 protected
  function pm_GetDocumentNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetDocumentNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetAttributesNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetAttributesNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetDisableAutoOpenAnnotation: Boolean;
  procedure pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
  function pm_GetBaloonWarningNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetBaloonWarningNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetListAnalizeNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetListAnalizeNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetTextBaloonWarningNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetTextBaloonWarningNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetFiltersNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetFiltersNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetCorrespondentsNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetCorrespondentsNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetRespondentsNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetRespondentsNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetRelatedDocNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetRelatedDocNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetUserCR1NeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetUserCR1NeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetUserCR2NeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetUserCR2NeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetDocumentWithFlashNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetDocumentWithFlashNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetAnnotationNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetAnnotationNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetTranslationNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetTranslationNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetSimilarDocumentsNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetSimilarDocumentsNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetAsIucpFilters: IucpFilters;
 protected
  procedure InitSynchroForms; override;
  procedure DoCurrentSynchroFormChanged(anOld: TList_SynchroView_Areas; aNew: TList_SynchroView_Areas); virtual;
 end;

implementation
uses
 FiltersUserTypes_utFilters_UserType,
 ListUserTypes_lftNone_UserType,
 BaloonWarningUserTypes_remListModified_UserType,
 BaloonWarningUserTypes_remListFiltered_UserType,
 BaloonWarningUserTypes_remTimeMachineWarning_UserType,
 ListInfoUserTypes_liListInfo_UserType,
 SynchroViewUserTypes_svSynchroView_UserType,
 DocumentUserTypes_dftDocSynchroView_UserType,
 BaloonWarningUserTypes_WarnJuror_UserType,
 BaloonWarningUserTypes_WarnPreActive_UserType,
 BaloonWarningUserTypes_WarnIsAbolished_UserType,
 BaloonWarningUserTypes_WarnOnControl_UserType,
 BaloonWarningUserTypes_WarnInactualDocument_UserType,
 BaloonWarningUserTypes_WarnRedaction_UserType,
 AttributesUserTypes_fAttributeSynchroView_UserType,
 DocumentUserTypes_dftRelatedSynchroView_UserType,
 DocumentUserTypes_dftAnnotationSynchroView_UserType,
 ListUserTypes_lftSimilarDocumentsSynchroView_UserType,
 ListUserTypes_lftUserCRList1_SynchorForm_UserType,
 ListUserTypes_lftUserCRList2_SynchorForm_UserType,
 ListUserTypes_lftCorrespondentsSynchroForm_UserType,
 ListUserTypes_lftRespondentsSynchroForm_UserType,
 DocumentWithFlashUserTypes_dwftSynchro_UserType,
 ListAnalizeUserTypes_Analize_UserType,

 vcmUserControls,

 SysUtils,

 afwFacade,

 l3Base;

{ TfstList }

const
 // Формы в сборке

 // Ключ для формы 'Filters'
 cFiltersFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztNavigator;
  rFormID : (rName : 'enFilters'; rID : 0); rUserType : utFilters;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'List'
 cListFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztParent;
  rFormID : (rName : 'efList'; rID : 0); rUserType : lftNone;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'remListModified'
 cRemListModifiedFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'WarningBaloonForm'; rID : 0); rUserType : remListModified;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'remListFiltered'
 cRemListFilteredFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'WarningBaloonForm'; rID : 0); rUserType : remListFiltered;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'remTimeMachineWarning'
 cRemTimeMachineWarningFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'WarningBaloonForm'; rID : 0); rUserType : remTimeMachineWarning;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'ListInfo'
 cListInfoFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'efListInfo'; rID : 0); rUserType : liListInfo;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'SynchroView'
 cSynchroViewFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'fcSynchroView'; rID : 0); rUserType : svSynchroView;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Text'
 cTextFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'TextForm'; rID : 0); rUserType : dftDocSynchroView;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'WarnJuror'
 cWarnJurorFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rUserType : WarnJuror;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'WarnPreActive'
 cWarnPreActiveFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rUserType : WarnPreActive;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'WarnIsAbolished'
 cWarnIsAbolishedFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rUserType : WarnIsAbolished;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'WarnOnControl'
 cWarnOnControlFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rUserType : WarnOnControl;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'WarnInactualDocument'
 cWarnInactualDocumentFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rUserType : WarnInactualDocument;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'WarnRedaction'
 cWarnRedactionFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'SynchroView_WarningBaloonForm'; rID : 0); rUserType : WarnRedaction;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Attributes'
 cAttributesFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'AttributesForm'; rID : 0); rUserType : fAttributeSynchroView;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Related'
 cRelatedFormDescr : TvcmFormSetFormItemDescr = (rZoneType: vcm_ztChild;
  rFormID: (rName : 'TextForm'; rID : 0); rUserType : dftRelatedSynchroView;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Annotation'
 cAnnotationFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'TextForm'; rID : 0); rUserType: dftAnnotationSynchroView;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Similar'
 cSimilarFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'efList'; rID : 0); rUserType: lftSimilarDocumentsSynchroView;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'UserCR1'
 cUserCR1FormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'efList'; rID : 0); rUserType: lftUserCRList1_SynchorForm;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'UserCR2'
 cUserCR2FormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'efList'; rID : 0); rUserType: lftUserCRList2_SynchorForm;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Correspondents'
 cCorrespondentsFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'efList'; rID : 0); rUserType: lftCorrespondentsSynchroForm;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'Respondents'
 cRespondentsFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'efList'; rID : 0); rUserType: lftRespondentsSynchroForm;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'DocumentWithFlash'
 cDocumentWithFlashFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'DocumentWithFlashForm'; rID : 0); rUserType: dwftSynchro;
  rSubUserType : TvcmUserType(0));

 // Ключ для формы 'ListAnalize'
 cListAnalizeFormDescr : TvcmFormSetFormItemDescr = (rZoneType : vcm_ztChild;
  rFormID : (rName : 'ListAnalizeForm'; rID : 0); rUserType: Analize;
  rSubUserType : TvcmUserType(0));

 {$Include w:\garant6x\implementation\Garant\GbaNemesis\View\List\fstFormSetWithSynchroForm.imp.pas}

procedure TfstList.DoOpenCorrespondents;
begin
 pm_SetCorrespondentsNeedMakeDS(vcm_nmForce);
end;

procedure TfstList.DoOpenRespondents;
begin
 pm_SetRespondentsNeedMakeDS(vcm_nmForce);
end;

procedure TfstList.DoOpenAttributes;
begin
 pm_SetAttributesNeedMakeDS(vcm_nmForce);
end;

procedure TfstList.Open;
begin
 Forms.NeedMakeDS[cFiltersFormDescr] := vcm_nmForce;
 Refresh(nil);
end;

procedure TfstList.OpenDocument;
begin
 f_disableAutoOpenAnnotation := true;
 SetIfNeedMakeNo(cDocumentWithFlashFormDescr, vcm_nmForce);
end;

function TfstList.pm_GetAsIucpFilters: IucpFilters;
begin
 Result := Self as IucpFilters;
end;

function TfstList.pm_GetBaloonWarningNeedMakeDS: TvcmNeedMakeDS;
begin
 // - здесь нужно что-то делать?
end;

function TfstList.pm_GetDisableAutoOpenAnnotation: Boolean;
begin
 Result := f_DisableAutoOpenAnnotation;
end;

function TfstList.pm_GetFiltersNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := Forms.NeedMakeDS[cFiltersFormDescr];
end;

function TfstList.pm_GetListAnalizeNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := Forms.NeedMakeDS[cListAnalizeFormDescr];
end;

function TfstList.pm_GetTextBaloonWarningNeedMakeDS: TvcmNeedMakeDS;
begin
 // - здесь нужно что-то делать?
end;

procedure TfstList.pm_SetBaloonWarningNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 // - здесь нужно что-то делать?
end;

procedure TfstList.pm_SetFiltersNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 Forms.NeedMakeDS[cFiltersFormDescr] := aValue;
end;

procedure TfstList.pm_SetListAnalizeNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 Forms.NeedMakeDS[cListAnalizeFormDescr] := aValue;
end;

procedure TfstList.pm_SetTextBaloonWarningNeedMakeDS(
  aValue: TvcmNeedMakeDS);
begin
 // - здесь нужно что-то делать?
end;

procedure TfstList.InitSynchroForms;
begin
 inherited;
 AddSynchroForm(cDocumentWithFlashFormDescr, sva_List_SynchroView_Document);// Собственно документ
 AddSynchroForm(cRelatedFormDescr, sva_List_SynchroView_RelatedDoc); // справка к документу
 AddSynchroForm(cUserCR1FormDescr, sva_List_SynchroView_UserCR1); // пользовательский СКР1
 AddSynchroForm(cUserCR2FormDescr, sva_List_SynchroView_UserCR2); // пользовательский СКР2
 AddSynchroForm(cAttributesFormDescr, sva_List_SynchroView_Attributes); // атрибуты документа
 AddSynchroForm(cAnnotationFormDescr, sva_List_SynchroView_Annotation); // аннотация к документу
 AddSynchroForm(cSimilarFormDescr, sva_List_SynchroView_SimilarDocuments);// похожие документы
end;

procedure TfstList.DoCurrentSynchroFormChanged(anOld: TList_SynchroView_Areas; aNew: TList_SynchroView_Areas);
begin
end;

procedure TfstList.SetNeedMakeForFullCR(aListType: TlstCRType);
begin
 case aListType of
  crtCorrespondents:
   pm_SetCorrespondentsNeedMakeDS(StateIfNeedShowFullCRList);
  crtRespondents:
   pm_SetRespondentsNeedMakeDS(StateIfNeedShowFullCRList);
 end;
end;

function TfstList.StateIfNeedShowFullCRList: TvcmNeedMakeDS;
begin
 Result := vcm_nmYes;
end;

procedure TfstList.DoOpenAnnotation;
begin
  inherited;
  f_DisableAutoOpenAnnotation := False;
end;

procedure TfstList.pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
begin
 f_DisableAutoOpenAnnotation := aValue;
end;

function TfstList.pm_GetDocumentNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := vcm_nmYes;
end;

procedure TfstList.pm_SetDocumentNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 Assert(False);
end;

function TfstList.pm_GetAttributesNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cAttributesFormDescr);
end;

procedure TfstList.pm_SetAttributesNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cAttributesFormDescr, aValue);
end;

procedure TfstList.OpenAttributes;
begin
 DoOpenAttributes;
end;

function TfstList.pm_GetAnnotationNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cAnnotationFormDescr);
end;

function TfstList.pm_GetCorrespondentsNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cCorrespondentsFormDescr);
end;

function TfstList.pm_GetDocumentWithFlashNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cDocumentWithFlashFormDescr);
end;

function TfstList.pm_GetRelatedDocNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cRelatedFormDescr);
end;

function TfstList.pm_GetRespondentsNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cRespondentsFormDescr);
end;

function TfstList.pm_GetSimilarDocumentsNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cSimilarFormDescr);
end;

function TfstList.pm_GetTranslationNeedMakeDS: TvcmNeedMakeDS;
begin
 Assert(False); // здесь нужно что-то делать?
end;

function TfstList.pm_GetUserCR1NeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cUserCR1FormDescr);
end;

function TfstList.pm_GetUserCR2NeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(cUserCR2FormDescr);
end;

procedure TfstList.pm_SetAnnotationNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cAnnotationFormDescr, aValue);
end;

procedure TfstList.pm_SetCorrespondentsNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cCorrespondentsFormDescr, aValue);
end;

procedure TfstList.pm_SetDocumentWithFlashNeedMakeDS(
  aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cDocumentWithFlashFormDescr, aValue);
end;

procedure TfstList.pm_SetRelatedDocNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cRelatedFormDescr, aValue);
end;

procedure TfstList.pm_SetRespondentsNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cRespondentsFormDescr, aValue);
end;

procedure TfstList.pm_SetSimilarDocumentsNeedMakeDS(
  aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cSimilarFormDescr, aValue);
end;

procedure TfstList.pm_SetTranslationNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 Assert(False); // здесь нужно что-то делать?
end;

procedure TfstList.pm_SetUserCR1NeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cUserCR1FormDescr, aValue);
end;

procedure TfstList.pm_SetUserCR2NeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(cUserCR2FormDescr, aValue);
end;

procedure TfstList.OpenAnnotation;
begin
 DoOpenAnnotation;
end;

procedure TfstList.OpenCorrespondents;
begin
 DoOpenCorrespondents;
end;

procedure TfstList.OpenRespondents;
begin
 DoOpenRespondents;
end;

procedure TfstList.OpenSimilar;
begin
 SetIfNeedMakeNo(cSimilarFormDescr, vcm_nmForce);
end;

procedure TfstList.OpenRelated;
begin
 SetIfNeedMakeNo(cRelatedFormDescr, vcm_nmForce);
end;

end.
