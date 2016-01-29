{$IfNDef _fstFormSetWithSynchroForm_imp}

{$Define _fstFormSetWithSynchroForm_imp}
 (* Сборка форм с формами синхронного просмотра *)
 _fstFormSetWithSynchroForm_ = class(_fstFormSetWithSynchroForm_Parent_)
 private
  f_SynchroForms: TnsSynchroFormList;
  {* - мапа идентификаторов форм и зон синхронного просмотра }
  f_CurrentSynchroForm: TList_SynchroView_Areas;
  {* - текущая форма синхронного просмотра }
  function pm_GetSynchroForms: TnsSynchroFormList;
  function pm_GetDefaultSynchroForm: TList_SynchroView_Areas;
 protected
  procedure DoCurrentSynchroFormChanged(anOld: TList_SynchroView_Areas; aNew: TList_SynchroView_Areas); virtual;
  {* - вызывается при изменении текущей формы синхронного просмотра (нужно ли?)}
  procedure AddSynchroForm(const aFormDescr: TvcmFormSetFormItemDescr; anArea: TList_SynchroView_Areas);
  {* - добавляет идентификатор формы и зоны синхронного просмотра в мапу}
  procedure InitSynchroForms; virtual;
  {* - инициализация мапы идентификаторов форм и зон синхронного просмотра}
  function DoGetDefaultSynchroForm: TList_SynchroView_Areas; virtual;
 protected
  // properties
  property SynchroForms: TnsSynchroFormList
   read pm_GetSynchroForms;
 protected
  // overriden
  procedure FormListAssigned; override;
  procedure CleanUp; override;
 protected
  function GetFormDescrForSynchroForm(aSynchroForm: TList_SynchroView_Areas): TvcmFormSetFormItemDescr;
  {* - возвращает идентификатор текущей формы синхронного просмотра }
  function pm_GetCurrentSynchroForm: TList_SynchroView_Areas;
  {* - возвращает идентификатор текущей зоны синхронного просмотра }
  procedure pm_SetCurrentSynchroForm(aValue: TList_SynchroView_Areas);
  {* - устанавливает текущую зону синхронного просмотра}
  function pm_GetCurrentSynchroFormNeedMakeDS: TvcmNeedMakeDS;
  {* - возвращает значение флажка TvcmNeedMakeDS для текущей формы синхронного просмотра}
  procedure pm_SetCurrentSynchroFormNeedMakeDS(aValue: TvcmNeedMakeDS);
  {* - устанавливает значение флажка TvcmNeedMakeDS для текущей формы синхронного просмотра}
  function StateIfSynchroFormActive: TvcmNeedMakeDS; virtual;
  procedure UpdateSynchroFormFlags;
 end;

{$Else _fstFormSetWithSynchroForm_imp}

function _fstFormSetWithSynchroForm_.pm_GetSynchroForms: TnsSynchroFormList;
begin
 if (f_SynchroForms = nil) then
 begin
  f_SynchroForms := TnsSynchroFormList.Create;
  InitSynchroForms;
 end;
 Result := f_SynchroForms;
end;

function _fstFormSetWithSynchroForm_.pm_GetDefaultSynchroForm: TList_SynchroView_Areas;
begin
 Result := DoGetDefaultSynchroForm;
end;

procedure _fstFormSetWithSynchroForm_.DoCurrentSynchroFormChanged(anOld: TList_SynchroView_Areas; aNew: TList_SynchroView_Areas);
begin
  // Не знаю, нужно ли тут что-то делать
end;

procedure _fstFormSetWithSynchroForm_.AddSynchroForm(const aFormDescr: TvcmFormSetFormItemDescr; anArea: TList_SynchroView_Areas);
begin
 SynchroForms.Add(TnsSynchroFormItem_C(aFormDescr, anArea));
end;

procedure _fstFormSetWithSynchroForm_.InitSynchroForms;
begin
 // Инициализация мапы идентификаторов форм и зон синхронного просмотра в потомках
end;

function _fstFormSetWithSynchroForm_.DoGetDefaultSynchroForm: TList_SynchroView_Areas;
begin
 Result := sva_List_SynchroView_Document;
end;

function _fstFormSetWithSynchroForm_.GetFormDescrForSynchroForm(aSynchroForm: TList_SynchroView_Areas): TvcmFormSetFormItemDescr;
begin
 Result := SynchroForms.Forms[aSynchroForm];
end;

procedure _fstFormSetWithSynchroForm_.FormListAssigned;
begin
 inherited;
 f_CurrentSynchroForm := pm_GetDefaultSynchroForm;
 UpdateSynchroFormFlags;
end;

procedure _fstFormSetWithSynchroForm_.CleanUp;
begin
 inherited;
 FreeAndNil(f_SynchroForms);
end;

function _fstFormSetWithSynchroForm_.pm_GetCurrentSynchroForm: TList_SynchroView_Areas;
begin
 Result := f_CurrentSynchroForm;
end;

procedure _fstFormSetWithSynchroForm_.pm_SetCurrentSynchroForm(aValue: TList_SynchroView_Areas);
var
 l_PrevSynchroForm: TList_SynchroView_Areas;
begin
 if (aValue <> f_CurrentSynchroForm) then
 begin
  l_PrevSynchroForm := f_CurrentSynchroForm;
  f_CurrentSynchroForm := aValue;
  UpdateSynchroFormFlags;
  // - При смене формы синхронного просмотра нужно синхронизировать флажки
  DoCurrentSynchroFormChanged(l_PrevSynchroForm, f_CurrentSynchroForm);
 end;//(aValue <> f_CurrentSynchroForm)
end;

function _fstFormSetWithSynchroForm_.pm_GetCurrentSynchroFormNeedMakeDS: TvcmNeedMakeDS;
begin
 Result := GetFormNeedMakeDS(GetFormDescrForSynchroForm(f_CurrentSynchroForm));
end;

procedure _fstFormSetWithSynchroForm_.pm_SetCurrentSynchroFormNeedMakeDS(aValue: TvcmNeedMakeDS);
begin
 SetFormNeedMakeDS(GetFormDescrForSynchroForm(f_CurrentSynchroForm), aValue);
end;

function _fstFormSetWithSynchroForm_.StateIfSynchroFormActive: TvcmNeedMakeDS;
begin
 Result := vcm_nmYes;
end;

procedure _fstFormSetWithSynchroForm_.UpdateSynchroFormFlags;

 function lp_DoUpdateSynchroFormFlags(aForm: PnsSynchroFormItem; aIndex: Integer): Boolean;
 var
  l_NeedMake: TvcmNeedMakeDS;
 begin
  if (aForm^.rArea <> f_CurrentSynchroForm) then
   l_NeedMake := vcm_nmNo
  else
   l_NeedMake := StateIfSynchroFormActive;
  SetFormNeedMakeDS(aForm^.rKey, l_NeedMake);
  Result := True;
 end;//lp_DoUpdateSynchroFormFlags

begin
  SynchroForms.IterateAllF(l3L2IA(@lp_DoUpdateSynchroFormFlags));
end;

{$EndIf _fstFormSetWithSynchroForm_imp}
