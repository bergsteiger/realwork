{$IfNDef sdsDocInfo_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Business"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/sdsDocInfo.imp.pas"
// Начат: 2005/08/24 13:53:25
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UseCaseControllerImp::Class>> F1 Core::Common::Business::DocumentAndList::sdsDocInfo
//
// Общий объект сборки для списка и документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define sdsDocInfo_imp}
{$If not defined(Admin) AND not defined(Monitorings)}
 {$Include ..\Document\sdsBaseDocumentWithAttributesFS.imp.pas}
 _afwApplicationDataUpdate_Parent_ = _sdsBaseDocumentWithAttributes_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _afwSettingsReplace_Parent_ = _afwApplicationDataUpdate_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
 _nsUserSettingsListener_Parent_ = _afwSettingsReplace_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 _sdsDocInfoFS_ = {abstract ucc} class(_nsUserSettingsListener_, IsdsDocInfo, IbsFlash {from IsdsDocInfo})
  {* Общий объект сборки для списка и документа }
 private
 // private methods
   procedure ConfigurationChanged;
     {* изменилась активная конфигурация }
 protected
 // realized methods
   function pm_GetHasTranslation: Boolean;
   function pm_GetHasSimilarDocuments: Boolean;
   function pm_GetHasRelatedDoc: Boolean;
   procedure OpenCorrespondents; virtual;
     {* корреспонденты }
   procedure OpenRespondents; virtual;
     {* респонденты }
   function ChangeCRType(const aNode: INodeBase;
    aType: TlstCRType;
    IsCRToPart: Boolean = false): Boolean;
     {* вызывается при изменении типа корреспондентов/респондентов }
   procedure AddToControl;
     {* поставить документ на контроль }
   procedure DelFromControl;
     {* снять с контроля }
   procedure ResetCacheAfterUpdate;
     {* сброс закэшированных параметров после обновления базы документов }
   function IsTypedCRSelected(aSheetNumber: TnsUserCRListId): Boolean;
     {* проверка того, что пользователь настроил соответствующую вкладку СКР }
   function HasTypedCRinBigBase(aSheetNumber: TnsUserCRListId): Boolean;
     {* проверка наличмия типизированных СКР в полной базе }
   function pm_GetIsUnderControl: Boolean;
   function pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
   function pm_GetFlashData: IExternalObject;
   function pm_GetDsRelatedDoc: IdsDocument;
   function DoGet_dsRelatedDoc: IdsDocument;
   function pm_GetdsRelatedDocRef: IvcmViewAreaControllerRef;
   function pm_GetDsRespondents: IdsDocumentList;
   function DoGet_dsRespondents: IdsDocumentList;
   function pm_GetdsRespondentsRef: IvcmViewAreaControllerRef;
   function pm_GetDsCorrespondents: IdsDocumentList;
   function DoGet_dsCorrespondents: IdsDocumentList;
   function pm_GetdsCorrespondentsRef: IvcmViewAreaControllerRef;
   function pm_GetDsUserCR1: IdsDocumentList;
   function DoGet_dsUserCR1: IdsDocumentList;
   function pm_GetdsUserCR1Ref: IvcmViewAreaControllerRef;
   function pm_GetDsUserCR2: IdsDocumentList;
   function DoGet_dsUserCR2: IdsDocumentList;
   function pm_GetdsUserCR2Ref: IvcmViewAreaControllerRef;
   function pm_GetDsDocumentWithFlash: IdsDocumentWithFlash;
   function DoGet_dsDocumentWithFlash: IdsDocumentWithFlash;
   function pm_GetdsDocumentWithFlashRef: IvcmViewAreaControllerRef;
   function pm_GetDsAnnotation: IdsDocument;
   function DoGet_dsAnnotation: IdsDocument;
   function pm_GetdsAnnotationRef: IvcmViewAreaControllerRef;
   function pm_GetDsTranslation: IdsDocument;
   function DoGet_dsTranslation: IdsDocument;
   function pm_GetdsTranslationRef: IvcmViewAreaControllerRef;
   function pm_GetDsSimilarDocuments: IdsDocumentList;
   function DoGet_dsSimilarDocuments: IdsDocumentList;
   function pm_GetdsSimilarDocumentsRef: IvcmViewAreaControllerRef;
   function pm_GetDsChronology: IdsDocument;
   function DoGet_dsChronology: IdsDocument;
   function pm_GetdsChronologyRef: IvcmViewAreaControllerRef;
   function HasSimilarToFragment(anId: Integer): Boolean;
   function pm_GetDsSimilarDocumentsToFragment: IdsDocumentList;
   function DoGet_dsSimilarDocumentsToFragment: IdsDocumentList;
   function pm_GetdsSimilarDocumentsToFragmentRef: IvcmViewAreaControllerRef;
   function pm_GetHasChronology: Boolean;
   function pm_GetHasAnnotation: Boolean;
   function pm_GetHasCorrespondents: Boolean;
   function pm_GetHasRespondents: Boolean;
   function pm_GetHasSimilarDocumentsToFragment: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   {$If not defined(NoVCM)}
   procedure ClearAreas; override;
     {* Очищает ссылки на области ввода }
   {$IfEnd} //not NoVCM
   procedure FillState; override;
   procedure UserSettingsChanged; override;
     {* Изменились настройки пользователя }
 protected
 // protected methods
   function NeedMakeDSUserCRList1: Boolean; virtual;
   function NeedMakeDSUserCRList2: Boolean; virtual;
   function NeedMakeDSCorrespondents: Boolean; virtual;
   function NeedMakeDSRespondents: Boolean; virtual;
   function StateIfNeedShowFullCRList: TvcmNeedMakeDS;
     {* определяет состояние, которое присваивается бизнес объекту полного
           списка, если принимается решение показывать вместо пользовательского
           списка полный СКР }
   function ChangeCorrType(const aValue: INodeBase): Boolean;
   function ChangeRespType(const aValue: INodeBase): Boolean;
   function IsOrdinalCRSelected(aCRType: TlstCRType;
    out aId: TnsUserCRListId): Boolean;
     {* проверка того, что в настройках пользователя выбраны нетипизированные
           СКР. aId - возвращает вкладку для которой определен не
           типизированный СКР, это нужно при изменении настроек }
   procedure ResetCachedObject(aWithoutCRTypes: Boolean);
   function TruthHasSimilarDocuments: Boolean;
     {* определяет наличие похожих у документа }
   function TruthHasRelatedDoc: Boolean;
     {* определяет наличие справки у документа }
   function TruthHasAnnotation: Boolean;
     {* определяет наличие аннотации у документа }
   function TruthHasChronology: Boolean; 
   function GetTypedCR(aId: TnsUserCRListId): IdeDocumentListCR;
   function NeedMakeDocumentWithFlash: Boolean; virtual;
   function DoChangeCRType(const aNode: INodeBase;
    aType: TlstCRType;
    IsCRToPart: Boolean): Boolean; virtual;
     {* вызывается при изменении типа корреспондентов/респондентов }
   function NeedMakeRelatedDoc: Boolean; virtual;
   function NeedMakeAnnotation: Boolean; virtual;
   function NeedMakeChronology: Boolean; virtual;
   function NeedMakeSimilarDocuments: Boolean; virtual;
   function GetOrMakeRespList: IDynList;
     {* О необходимости метода читаем тут - [$130744335] }
   function GetOrMakeCorrList: IDynList;
     {* О необходимости метода читаем тут - [$130744335] }
 protected
 // Методы преобразования к реализуемым интерфейсам
   function As_IbsFlash: IbsFlash;
 end;//_sdsDocInfoFS_
{$IfEnd} //not Admin AND not Monitorings

{$Else sdsDocInfo_imp}

{$If not defined(Admin) AND not defined(Monitorings)}


{$Include ..\Document\sdsBaseDocumentWithAttributesFS.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

// start class _sdsDocInfoFS_

function _sdsDocInfoFS_.NeedMakeDSUserCRList1: Boolean;
//#UC START# *493D51B00058_493D2F7B031D_var*
//#UC END# *493D51B00058_493D2F7B031D_var*
begin
//#UC START# *493D51B00058_493D2F7B031D_impl*
 Result := SetData.UserCRListInfo[ulFirst].Has;
//#UC END# *493D51B00058_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeDSUserCRList1

function _sdsDocInfoFS_.NeedMakeDSUserCRList2: Boolean;
//#UC START# *493D51BE03DC_493D2F7B031D_var*
//#UC END# *493D51BE03DC_493D2F7B031D_var*
begin
//#UC START# *493D51BE03DC_493D2F7B031D_impl*
 Result := SetData.UserCRListInfo[ulSecond].Has;
//#UC END# *493D51BE03DC_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeDSUserCRList2

function _sdsDocInfoFS_.NeedMakeDSCorrespondents: Boolean;
//#UC START# *493D51D0039B_493D2F7B031D_var*
//#UC END# *493D51D0039B_493D2F7B031D_var*
begin
//#UC START# *493D51D0039B_493D2F7B031D_impl*
 Result := pm_GetHasCorrespondents;
//#UC END# *493D51D0039B_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeDSCorrespondents

function _sdsDocInfoFS_.NeedMakeDSRespondents: Boolean;
//#UC START# *493D51DF022F_493D2F7B031D_var*
//#UC END# *493D51DF022F_493D2F7B031D_var*
begin
//#UC START# *493D51DF022F_493D2F7B031D_impl*
 Result := pm_GetHasRespondents;
//#UC END# *493D51DF022F_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeDSRespondents

function _sdsDocInfoFS_.StateIfNeedShowFullCRList: TvcmNeedMakeDS;
//#UC START# *493D521E0135_493D2F7B031D_var*
//#UC END# *493D521E0135_493D2F7B031D_var*
begin
//#UC START# *493D521E0135_493D2F7B031D_impl*
 Result := vcm_nmYes;
//#UC END# *493D521E0135_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.StateIfNeedShowFullCRList

function _sdsDocInfoFS_.ChangeCorrType(const aValue: INodeBase): Boolean;
//#UC START# *493D524802C9_493D2F7B031D_var*
//#UC END# *493D524802C9_493D2F7B031D_var*
begin
//#UC START# *493D524802C9_493D2F7B031D_impl*
 Result := False;
 if not SetData.CorrType.HasNode or not SetData.CorrType.Value.IsSameNode(aValue) then
 begin
  SetData.CorrType.Value := aValue;
  SetData.HasCorrespondents := l3_bUnknown;
  SetData.CorrList := nil;
  SetData.dsCorrespondentsRef.Referred := nil;
  Result := True;
 end
 else//if not Assigned(SetData.CorrType)
  Result := SetData.CorrList = nil;
//#UC END# *493D524802C9_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ChangeCorrType

function _sdsDocInfoFS_.ChangeRespType(const aValue: INodeBase): Boolean;
//#UC START# *493D525B007D_493D2F7B031D_var*
//#UC END# *493D525B007D_493D2F7B031D_var*
begin
//#UC START# *493D525B007D_493D2F7B031D_impl*
 Result := False;
 if not SetData.RespType.HasNode or not SetData.RespType.Value.IsSameNode(aValue) then
 begin
  SetData.RespType.Value := aValue;
  SetData.HasRespondents := l3_bUnknown;
  SetData.RespList := nil;
  SetData.dsRespondentsRef.Referred := nil;
  Result := True;
 end
 else//if not Assigned(SetData.RespType)
  Result := SetData.RespList = nil;
//#UC END# *493D525B007D_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ChangeRespType

function _sdsDocInfoFS_.IsOrdinalCRSelected(aCRType: TlstCRType;
  out aId: TnsUserCRListId): Boolean;
//#UC START# *493D5BB40051_493D2F7B031D_var*
var
 I: TnsUserCRListId;
//#UC END# *493D5BB40051_493D2F7B031D_var*
begin
//#UC START# *493D5BB40051_493D2F7B031D_impl*
 for I := Low(TnsUserCRListId) to High(TnsUserCRListId) do
 begin
  with SetData.UserCRListInfo[I] do
   Result := (ListType = aCRType) and not bsIsCRNodeAreNotAllDocuments(Node);
  if Result then
  begin
   aId := I;
   Break;
  end;//if Result then
 end;//for I := Low(TnsUserCRListId) to
//#UC END# *493D5BB40051_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.IsOrdinalCRSelected

procedure _sdsDocInfoFS_.ResetCachedObject(aWithoutCRTypes: Boolean);
//#UC START# *493D5E9700AE_493D2F7B031D_var*
//#UC END# *493D5E9700AE_493D2F7B031D_var*
begin
//#UC START# *493D5E9700AE_493D2F7B031D_impl*
 with SetData do
 begin
  if not aWithoutCRTypes then
  begin
   if (CorrType <> nil) then
    CorrType.Value := nil;
   if (RespType <> nil) then
    RespType.Value := nil;
  end;
  CorrList := nil;
  RespList := nil;
  //RelatedDoc := nil;
  //Annotation := nil;
  FlashData := nil;
 end;//with SetData do
//#UC END# *493D5E9700AE_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ResetCachedObject

function _sdsDocInfoFS_.TruthHasSimilarDocuments: Boolean;
//#UC START# *493D5FA703E6_493D2F7B031D_var*
var
 l_Temp: Tl3Bool;
//#UC END# *493D5FA703E6_493D2F7B031D_var*
begin
//#UC START# *493D5FA703E6_493D2F7B031D_impl*
 Result := False;
 if pm_GetHasDocument and
  not l3BoolCheck(SetData.HasSimilarDocuments, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasSameDocuments, l_Temp);
  SetData.HasSimilarDocuments := l_Temp;
 end;
//#UC END# *493D5FA703E6_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.TruthHasSimilarDocuments

function _sdsDocInfoFS_.TruthHasRelatedDoc: Boolean;
//#UC START# *493D5FC202B1_493D2F7B031D_var*
var
 l_Temp: Tl3Bool;
//#UC END# *493D5FC202B1_493D2F7B031D_var*
begin
//#UC START# *493D5FC202B1_493D2F7B031D_impl*
 Result := False;
 if pm_GetHasDocument and not l3BoolCheck(SetData.HasRelatedDoc, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasRelatedDoc, l_Temp);
  SetData.HasRelatedDoc := l_Temp;
 end;//if pm_GetHasDocument..
//#UC END# *493D5FC202B1_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.TruthHasRelatedDoc

function _sdsDocInfoFS_.TruthHasAnnotation: Boolean;
//#UC START# *493D5FD70278_493D2F7B031D_var*
var
 l_Temp: Tl3Bool;
//#UC END# *493D5FD70278_493D2F7B031D_var*
begin
//#UC START# *493D5FD70278_493D2F7B031D_impl*
 Result := False;
 if pm_GetHasDocument and not l3BoolCheck(SetData.HasAnnotation, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasAnnotation, l_Temp);
  SetData.HasAnnotation := l_Temp;
 end;
//#UC END# *493D5FD70278_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.TruthHasAnnotation

function _sdsDocInfoFS_.TruthHasChronology: Boolean;
//#UC START# *53BFE45F039B_493D2F7B031D_var*
var
 l_Temp: Tl3Bool;
//#UC END# *53BFE45F039B_493D2F7B031D_var*
begin
//#UC START# *53BFE45F039B_493D2F7B031D_impl*
 Result := False;
 if pm_GetHasDocument and not l3BoolCheck(SetData.HasChronology, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasChronology, l_Temp);
  SetData.HasChronology := l_Temp;
 end;
//#UC END# *53BFE45F039B_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.TruthHasChronology

function _sdsDocInfoFS_.GetTypedCR(aId: TnsUserCRListId): IdeDocumentListCR;
//#UC START# *493D60320164_493D2F7B031D_var*
var
 l_List    : IDynList;
 l_Catalog : ICatalogBase;
//#UC END# *493D60320164_493D2F7B031D_var*
begin
//#UC START# *493D60320164_493D2F7B031D_impl*
 Result := nil;
 try
  with SetData.UserCRListInfo[aId] do
   if pm_GetHasDocument and Assigned(Node) then
    case ListType of
     crtRespondents:
      pm_GetDocInfo.Doc.GetRespondents(Node.Value, l_Catalog);
     crtCorrespondents:
      pm_GetDocInfo.Doc.GetCorrespondents(Node.Value, l_Catalog);
    end;//case ListType of
 except
  on ECanNotFindData do
   l_Catalog := nil;
 end;//try..except
 Supports(l_Catalog, IDynList, l_List);
 with SetData.UserCRListInfo[aId] do
  Result := TdeDocumentListCR.Make(l_List, Node.Value, ListType);
//#UC END# *493D60320164_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.GetTypedCR

procedure _sdsDocInfoFS_.ConfigurationChanged;
//#UC START# *493D606D0189_493D2F7B031D_var*
//#UC END# *493D606D0189_493D2F7B031D_var*
begin
//#UC START# *493D606D0189_493D2F7B031D_impl*
 FillState;
 Refresh;
//#UC END# *493D606D0189_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ConfigurationChanged

function _sdsDocInfoFS_.NeedMakeDocumentWithFlash: Boolean;
//#UC START# *493D62FF02AF_493D2F7B031D_var*
//#UC END# *493D62FF02AF_493D2F7B031D_var*
begin
//#UC START# *493D62FF02AF_493D2F7B031D_impl*
 Result := pm_GetHasDocument and (pm_GetDocInfo.Doc.GetDocType = DT_FLASH);
//#UC END# *493D62FF02AF_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeDocumentWithFlash

function _sdsDocInfoFS_.DoChangeCRType(const aNode: INodeBase;
  aType: TlstCRType;
  IsCRToPart: Boolean): Boolean;
//#UC START# *493D6B5B02DE_493D2F7B031D_var*
//#UC END# *493D6B5B02DE_493D2F7B031D_var*
begin
//#UC START# *493D6B5B02DE_493D2F7B031D_impl*
 Result := False;
 if not IsCRToPart then
  case aType of
   crtCorrespondents:
    Result := ChangeCorrType(aNode);
   crtRespondents:
    Result := ChangeRespType(aNode);
  end
 else
  Assert(not IsCRToPart, caRespCorrestUnsupported);
//#UC END# *493D6B5B02DE_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.DoChangeCRType

function _sdsDocInfoFS_.NeedMakeRelatedDoc: Boolean;
//#UC START# *493D6E7E0282_493D2F7B031D_var*
//#UC END# *493D6E7E0282_493D2F7B031D_var*
begin
//#UC START# *493D6E7E0282_493D2F7B031D_impl*
 Result := pm_GetHasRelatedDoc;
//#UC END# *493D6E7E0282_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeRelatedDoc

function _sdsDocInfoFS_.NeedMakeAnnotation: Boolean;
//#UC START# *493D6EAB0019_493D2F7B031D_var*
//#UC END# *493D6EAB0019_493D2F7B031D_var*
begin
//#UC START# *493D6EAB0019_493D2F7B031D_impl*
 Result := pm_GetHasAnnotation;
//#UC END# *493D6EAB0019_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeAnnotation

function _sdsDocInfoFS_.NeedMakeChronology: Boolean;
//#UC START# *53BFE4C1035E_493D2F7B031D_var*
//#UC END# *53BFE4C1035E_493D2F7B031D_var*
begin
//#UC START# *53BFE4C1035E_493D2F7B031D_impl*
 Result := pm_GetHasChronology;
//#UC END# *53BFE4C1035E_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeChronology

function _sdsDocInfoFS_.NeedMakeSimilarDocuments: Boolean;
//#UC START# *493D6EC40228_493D2F7B031D_var*
//#UC END# *493D6EC40228_493D2F7B031D_var*
begin
//#UC START# *493D6EC40228_493D2F7B031D_impl*
 Result := pm_GetHasSimilarDocuments;
//#UC END# *493D6EC40228_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.NeedMakeSimilarDocuments

function _sdsDocInfoFS_.GetOrMakeRespList: IDynList;
//#UC START# *4946533D0039_493D2F7B031D_var*
var
 l_Temp: IDynList;
 l_Catalog: ICatalogBase;
//#UC END# *4946533D0039_493D2F7B031D_var*
begin
//#UC START# *4946533D0039_493D2F7B031D_impl*
 if (pm_GetDocInfo <> nil) and not Assigned(SetData.RespList) then
  try
   pm_GetDocInfo.Doc.GetRespondents(SetData.RespType.Value, l_Catalog);
   if Supports(l_Catalog, IDynList, l_Temp) then
   SetData.RespList := l_Temp;
  except
   on ECanNotFindData do
    SetData.RespList := nil;
  end;
 Result := SetData.RespList;
//#UC END# *4946533D0039_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.GetOrMakeRespList

function _sdsDocInfoFS_.GetOrMakeCorrList: IDynList;
//#UC START# *4946539A0021_493D2F7B031D_var*
var
 l_Temp: IDynList;
 l_Catalog: ICatalogBase;
//#UC END# *4946539A0021_493D2F7B031D_var*
begin
//#UC START# *4946539A0021_493D2F7B031D_impl*
 if (pm_GetDocInfo <> nil) and not Assigned(SetData.CorrList) then
  try
   pm_GetDocInfo.Doc.GetCorrespondents(SetData.CorrType.Value, l_Catalog);
   if Supports(l_Catalog, IDynList, l_Temp) then
    SetData.CorrList := l_Temp;
  except
   on ECanNotFindData do
    SetData.CorrList := nil;
  end;
 Result := SetData.CorrList;
//#UC END# *4946539A0021_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.GetOrMakeCorrList

function _sdsDocInfoFS_.pm_GetHasTranslation: Boolean;
//#UC START# *01DBA41F4474_493D2F7B031Dget_var*
var
 l_Temp: Tl3Bool;
//#UC END# *01DBA41F4474_493D2F7B031Dget_var*
begin
//#UC START# *01DBA41F4474_493D2F7B031Dget_impl*
 Result := False;
 if pm_GetHasDocument and not l3BoolCheck(SetData.HasTranslation, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasTranslation, l_Temp);
  SetData.HasTranslation := l_Temp;
 end;
//#UC END# *01DBA41F4474_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasTranslation

function _sdsDocInfoFS_.pm_GetHasSimilarDocuments: Boolean;
//#UC START# *10E3D328A415_493D2F7B031Dget_var*
//#UC END# *10E3D328A415_493D2F7B031Dget_var*
begin
//#UC START# *10E3D328A415_493D2F7B031Dget_impl*
 Result := TruthHasSimilarDocuments;
//#UC END# *10E3D328A415_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasSimilarDocuments

function _sdsDocInfoFS_.pm_GetHasRelatedDoc: Boolean;
//#UC START# *3690DB82E835_493D2F7B031Dget_var*
//#UC END# *3690DB82E835_493D2F7B031Dget_var*
begin
//#UC START# *3690DB82E835_493D2F7B031Dget_impl*
 Result := TruthHasRelatedDoc;
//#UC END# *3690DB82E835_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasRelatedDoc

procedure _sdsDocInfoFS_.OpenCorrespondents;
//#UC START# *4937C4D90220_493D2F7B031D_var*
//#UC END# *4937C4D90220_493D2F7B031D_var*
begin
//#UC START# *4937C4D90220_493D2F7B031D_impl*
 if SetData.dsCorrespondentsRef.IsEmpty then
 begin
  UCFormSet.OpenCorrespondents;
  Refresh;
 end;//if SetData.refCorrespondents.IsEmpty then
//#UC END# *4937C4D90220_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.OpenCorrespondents

procedure _sdsDocInfoFS_.OpenRespondents;
//#UC START# *4937C4E701F3_493D2F7B031D_var*
//#UC END# *4937C4E701F3_493D2F7B031D_var*
begin
//#UC START# *4937C4E701F3_493D2F7B031D_impl*
 if SetData.dsRespondentsRef.IsEmpty then
 begin
  UCFormSet.OpenRespondents;
  Refresh;
 end;//if SetData.refRespondents.IsEmpty then
//#UC END# *4937C4E701F3_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.OpenRespondents

function _sdsDocInfoFS_.ChangeCRType(const aNode: INodeBase;
  aType: TlstCRType;
  IsCRToPart: Boolean = false): Boolean;
//#UC START# *4937C4F5038B_493D2F7B031D_var*
//#UC END# *4937C4F5038B_493D2F7B031D_var*
begin
//#UC START# *4937C4F5038B_493D2F7B031D_impl*
 Result := DoChangeCRType(aNode, aType, IsCRToPart);
//#UC END# *4937C4F5038B_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ChangeCRType

procedure _sdsDocInfoFS_.AddToControl;
//#UC START# *4937C5250138_493D2F7B031D_var*
//#UC END# *4937C5250138_493D2F7B031D_var*
begin
//#UC START# *4937C5250138_493D2F7B031D_impl*
 if (pm_GetDocInfo <> nil) then
 begin
  TCommonService.Instance.AddDocumentToControl(pm_GetDocInfo.Doc);
  SetData.IsUnderControl := l3_bUnknown;
 end;
//#UC END# *4937C5250138_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.AddToControl

procedure _sdsDocInfoFS_.DelFromControl;
//#UC START# *4937C55101B2_493D2F7B031D_var*
//#UC END# *4937C55101B2_493D2F7B031D_var*
begin
//#UC START# *4937C55101B2_493D2F7B031D_impl*
 if (pm_GetDocInfo <> nil) then
 begin
  TCommonService.Instance.DeleteDocumentFromControl(pm_GetDocInfo.Doc);
  SetData.IsUnderControl := l3_bUnknown;
 end;
//#UC END# *4937C55101B2_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.DelFromControl

procedure _sdsDocInfoFS_.ResetCacheAfterUpdate;
//#UC START# *4937C56002B6_493D2F7B031D_var*
//#UC END# *4937C56002B6_493D2F7B031D_var*
begin
//#UC START# *4937C56002B6_493D2F7B031D_impl*
 SetData.ResetBooleans;
 ResetCachedObject(True);
//#UC END# *4937C56002B6_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ResetCacheAfterUpdate

function _sdsDocInfoFS_.IsTypedCRSelected(aSheetNumber: TnsUserCRListId): Boolean;
//#UC START# *4937C58D008D_493D2F7B031D_var*
//#UC END# *4937C58D008D_493D2F7B031D_var*
begin
//#UC START# *4937C58D008D_493D2F7B031D_impl*
 with SetData.UserCRListInfo[aSheetNumber] do
  Result := (ListType <> crtNone) and bsIsCRNodeAreNotAllDocuments(Node);
//#UC END# *4937C58D008D_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.IsTypedCRSelected

function _sdsDocInfoFS_.HasTypedCRinBigBase(aSheetNumber: TnsUserCRListId): Boolean;
//#UC START# *4937C5A5024F_493D2F7B031D_var*
//#UC END# *4937C5A5024F_493D2F7B031D_var*
begin
//#UC START# *4937C5A5024F_493D2F7B031D_impl*
 Result := false;
 with SetData.UserCRListInfo[aSheetNumber] do
  if pm_GetHasDocument and (Node <> nil) then
   case ListType of
    crtRespondents:
     Result := pm_GetDocInfo.Doc.HasRespondents(Node.Value);
    crtCorrespondents:
     Result := pm_GetDocInfo.Doc.HasCorrespondents(Node.Value);
   end;//case SetData.UserCRSheetTypes[aSheetNumber] of
//#UC END# *4937C5A5024F_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.HasTypedCRinBigBase

function _sdsDocInfoFS_.pm_GetIsUnderControl: Boolean;
//#UC START# *4937C61C0270_493D2F7B031Dget_var*
var
 l_Temp: Tl3Bool;
//#UC END# *4937C61C0270_493D2F7B031Dget_var*
begin
//#UC START# *4937C61C0270_493D2F7B031Dget_impl*
 Result := False;
 if (pm_GetDocInfo <> nil) and
    not l3BoolCheck(SetData.IsUnderControl, Result) then
 begin
  Result := l3BoolSet(TCommonService.Instance.IsUnderControl(pm_GetDocInfo.Doc), l_Temp);
  SetData.IsUnderControl := l_Temp;
 end;
//#UC END# *4937C61C0270_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetIsUnderControl

function _sdsDocInfoFS_.pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
//#UC START# *4937D0FF0303_493D2F7B031Dget_var*
//#UC END# *4937D0FF0303_493D2F7B031Dget_var*
begin
//#UC START# *4937D0FF0303_493D2F7B031Dget_impl*
 Result := SetData.UserCRListInfo[aId];
//#UC END# *4937D0FF0303_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetUserCRListInfo

function _sdsDocInfoFS_.pm_GetFlashData: IExternalObject;
//#UC START# *4939534D01FB_493D2F7B031Dget_var*
//#UC END# *4939534D01FB_493D2F7B031Dget_var*
begin
//#UC START# *4939534D01FB_493D2F7B031Dget_impl*
 if SetData.FlashData = nil then
 begin
  if pm_GetHasDocument then
  begin
   try
    pm_GetDocInfo.Doc.GetFlash(Result);
    SetData.FlashData := Result;
   except
    on ECanNotFindData do
     ;
   end;
  end
  else
   Result := nil;
 end
 else
  Result := SetData.FlashData;
//#UC END# *4939534D01FB_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetFlashData

function _sdsDocInfoFS_.pm_GetDsRelatedDoc: IdsDocument;
//#UC START# *5009A673037A_493D2F7B031Dget_var*
//#UC END# *5009A673037A_493D2F7B031Dget_var*
begin
 with pm_GetdsRelatedDocRef do
 begin
  if IsEmpty
   //#UC START# *5009A673037A_493D2F7B031Dget_need*
     and (UCFormSet.RelatedDocNeedMakeDS <> vcm_nmNo)
     and NeedMakeRelatedDoc
   // - условие создания ViewArea
  //#UC END# *5009A673037A_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsRelatedDoc;
  Result := IdsDocument(Referred);
 end;//with pm_GetdsRelatedDocRef
end;

function _sdsDocInfoFS_.DoGet_dsRelatedDoc: IdsDocument;
//#UC START# *5009A673037A_493D2F7B031Darea_var*
var
 l_Container : IbsDocumentContainer;
//#UC END# *5009A673037A_493D2F7B031Darea_var*
begin
//#UC START# *5009A673037A_493D2F7B031Darea_impl*
 if Supports(SetData.DocInfo, IbsDocumentContainer, l_Container) then
  try
   Result := TdsRelatedDoc.Make(Self, TdeDocInfo.Make(
    TbsNestedDocumentContainer.Make(l_Container, ndtRelatedDoc, TruthHasRelatedDoc)));
  finally
   l_Container := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *5009A673037A_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsRelatedDoc

function _sdsDocInfoFS_.pm_GetdsRelatedDocRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsRelatedDocRef;
end;

function _sdsDocInfoFS_.pm_GetDsRespondents: IdsDocumentList;
//#UC START# *5009A699023D_493D2F7B031Dget_var*

 function CheckList: Boolean;
  // Обнулим, потому, что пользователь мог удалить из списка документы,
  // потом закрыть вкладку, потом открыть вновь, то мы должны показать ему
  // полный список
 begin
  Result := true;
  if bsIsListChanged(GetOrMakeRespList) then
   SetData.RespList := nil;
 end;

//#UC END# *5009A699023D_493D2F7B031Dget_var*
begin
 with pm_GetdsRespondentsRef do
 begin
  if IsEmpty
   //#UC START# *5009A699023D_493D2F7B031Dget_need*
     AND (UCFormSet.RespondentsNeedMakeDS <> vcm_nmNo)
     AND NeedMakeDSRespondents
     AND CheckList   
   // - условие создания ViewArea
  //#UC END# *5009A699023D_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsRespondents;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsRespondentsRef
end;

function _sdsDocInfoFS_.DoGet_dsRespondents: IdsDocumentList;
//#UC START# *5009A699023D_493D2F7B031Darea_var*
//#UC END# *5009A699023D_493D2F7B031Darea_var*
begin
//#UC START# *5009A699023D_493D2F7B031Darea_impl*
 Result := TdsDocumentListCR.Make(Self, TdeDocumentListCR.Make(GetOrMakeRespList,
  SetData.RespType.Value, crtRespondents));
//#UC END# *5009A699023D_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsRespondents

function _sdsDocInfoFS_.pm_GetdsRespondentsRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsRespondentsRef;
end;

function _sdsDocInfoFS_.pm_GetDsCorrespondents: IdsDocumentList;
//#UC START# *5009A6BE01DD_493D2F7B031Dget_var*

 function CheckList: Boolean;
  // Обнулим, потому, что пользователь мог удалить из списка документы,
  // потом закрыть вкладку, потом открыть вновь, то мы должны показать ему
  // полный список
 begin
  Result := true;
  if bsIsListChanged(GetOrMakeCorrList) then
   SetData.CorrList := nil;
 end;

//#UC END# *5009A6BE01DD_493D2F7B031Dget_var*
begin
 with pm_GetdsCorrespondentsRef do
 begin
  if IsEmpty
   //#UC START# *5009A6BE01DD_493D2F7B031Dget_need*
     AND (UCFormSet.CorrespondentsNeedMakeDS <> vcm_nmNo)
     AND NeedMakeDSCorrespondents
     AND CheckList   
   // - условие создания ViewArea
  //#UC END# *5009A6BE01DD_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsCorrespondents;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsCorrespondentsRef
end;

function _sdsDocInfoFS_.DoGet_dsCorrespondents: IdsDocumentList;
//#UC START# *5009A6BE01DD_493D2F7B031Darea_var*
//#UC END# *5009A6BE01DD_493D2F7B031Darea_var*
begin
//#UC START# *5009A6BE01DD_493D2F7B031Darea_impl*
 Result := TdsDocumentListCR.Make(Self, TdeDocumentListCR.Make(GetOrMakeCorrList,
  SetData.CorrType.Value, crtCorrespondents));
//#UC END# *5009A6BE01DD_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsCorrespondents

function _sdsDocInfoFS_.pm_GetdsCorrespondentsRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsCorrespondentsRef;
end;

function _sdsDocInfoFS_.pm_GetDsUserCR1: IdsDocumentList;
//#UC START# *5009A6EF0016_493D2F7B031Dget_var*
//#UC END# *5009A6EF0016_493D2F7B031Dget_var*
begin
 with pm_GetdsUserCR1Ref do
 begin
  if IsEmpty
   //#UC START# *5009A6EF0016_493D2F7B031Dget_need*
     AND NeedMakeDSUserCRList1   
   // - условие создания ViewArea
  //#UC END# *5009A6EF0016_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsUserCR1;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsUserCR1Ref
end;

function _sdsDocInfoFS_.DoGet_dsUserCR1: IdsDocumentList;
//#UC START# *5009A6EF0016_493D2F7B031Darea_var*
//#UC END# *5009A6EF0016_493D2F7B031Darea_var*
begin
//#UC START# *5009A6EF0016_493D2F7B031Darea_impl*
 Result := TdsDocumentListCR.Make(Self, GetTypedCR(ulFirst)); 
//#UC END# *5009A6EF0016_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsUserCR1

function _sdsDocInfoFS_.pm_GetdsUserCR1Ref: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsUserCR1Ref;
end;

function _sdsDocInfoFS_.pm_GetDsUserCR2: IdsDocumentList;
//#UC START# *5009A72B01A5_493D2F7B031Dget_var*
//#UC END# *5009A72B01A5_493D2F7B031Dget_var*
begin
 with pm_GetdsUserCR2Ref do
 begin
  if IsEmpty
   //#UC START# *5009A72B01A5_493D2F7B031Dget_need*
     AND NeedMakeDSUserCRList2   
   // - условие создания ViewArea
  //#UC END# *5009A72B01A5_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsUserCR2;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsUserCR2Ref
end;

function _sdsDocInfoFS_.DoGet_dsUserCR2: IdsDocumentList;
//#UC START# *5009A72B01A5_493D2F7B031Darea_var*
//#UC END# *5009A72B01A5_493D2F7B031Darea_var*
begin
//#UC START# *5009A72B01A5_493D2F7B031Darea_impl*
 Result := TdsDocumentListCR.Make(Self, GetTypedCR(ulSecond));
//#UC END# *5009A72B01A5_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsUserCR2

function _sdsDocInfoFS_.pm_GetdsUserCR2Ref: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsUserCR2Ref;
end;

function _sdsDocInfoFS_.pm_GetDsDocumentWithFlash: IdsDocumentWithFlash;
//#UC START# *5009ADAC0080_493D2F7B031Dget_var*
//#UC END# *5009ADAC0080_493D2F7B031Dget_var*
begin
 with pm_GetdsDocumentWithFlashRef do
 begin
  if IsEmpty
   //#UC START# *5009ADAC0080_493D2F7B031Dget_need*
     AND NeedMakeDocumentWithFlash   
   // - условие создания ViewArea
  //#UC END# *5009ADAC0080_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsDocumentWithFlash;
  Result := IdsDocumentWithFlash(Referred);
 end;//with pm_GetdsDocumentWithFlashRef
end;

function _sdsDocInfoFS_.DoGet_dsDocumentWithFlash: IdsDocumentWithFlash;
//#UC START# *5009ADAC0080_493D2F7B031Darea_var*
//#UC END# *5009ADAC0080_493D2F7B031Darea_var*
begin
//#UC START# *5009ADAC0080_493D2F7B031Darea_impl*
 Result := TdsDocumentWithFlash.Make(Self, pm_GetDocInfo.Clone);
//#UC END# *5009ADAC0080_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsDocumentWithFlash

function _sdsDocInfoFS_.pm_GetdsDocumentWithFlashRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsDocumentWithFlashRef;
end;

function _sdsDocInfoFS_.pm_GetDsAnnotation: IdsDocument;
//#UC START# *500CEDF00141_493D2F7B031Dget_var*
//#UC END# *500CEDF00141_493D2F7B031Dget_var*
begin
 with pm_GetdsAnnotationRef do
 begin
  if IsEmpty
   //#UC START# *500CEDF00141_493D2F7B031Dget_need*
     AND NeedMakeAnnotation   
   // - условие создания ViewArea
  //#UC END# *500CEDF00141_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsAnnotation;
  Result := IdsDocument(Referred);
 end;//with pm_GetdsAnnotationRef
end;

function _sdsDocInfoFS_.DoGet_dsAnnotation: IdsDocument;
//#UC START# *500CEDF00141_493D2F7B031Darea_var*
var
 l_Container: IbsDocumentContainer;
//#UC END# *500CEDF00141_493D2F7B031Darea_var*
begin
//#UC START# *500CEDF00141_493D2F7B031Darea_impl*
 if Supports(SetData.DocInfo, IbsDocumentContainer, l_Container) then
  try
   Result := TdsAnnotation.Make(Self, TdeDocInfo.Make(
    TbsNestedDocumentContainer.Make(l_Container, ndtAnnotation, TruthHasAnnotation)));
  finally
   l_Container := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *500CEDF00141_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsAnnotation

function _sdsDocInfoFS_.pm_GetdsAnnotationRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsAnnotationRef;
end;

function _sdsDocInfoFS_.pm_GetDsTranslation: IdsDocument;
//#UC START# *500CEE0F0071_493D2F7B031Dget_var*
//#UC END# *500CEE0F0071_493D2F7B031Dget_var*
begin
 with pm_GetdsTranslationRef do
 begin
  if IsEmpty
   //#UC START# *500CEE0F0071_493D2F7B031Dget_need*
     AND pm_GetHasTranslation
     AND afw.Settings.LoadBoolean(pi_Document_Sheets_Translation, dv_Document_Sheets_Translation)
   // - условие создания ViewArea
  //#UC END# *500CEE0F0071_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsTranslation;
  Result := IdsDocument(Referred);
 end;//with pm_GetdsTranslationRef
end;

function _sdsDocInfoFS_.DoGet_dsTranslation: IdsDocument;
//#UC START# *500CEE0F0071_493D2F7B031Darea_var*
var
 l_Container: IbsDocumentContainer;
//#UC END# *500CEE0F0071_493D2F7B031Darea_var*
begin
//#UC START# *500CEE0F0071_493D2F7B031Darea_impl*
 if Supports(SetData.DocInfo, IbsDocumentContainer, l_Container) then
  try
   Result := TdsTranslation.Make(Self, TdeDocInfo.Make(
    TbsNestedDocumentContainer.Make(l_Container, ndtTranslation, pm_GetHasTranslation)));
  finally
   l_Container := nil;
  end{try..finally}
 else
  Result := nil; 
//#UC END# *500CEE0F0071_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsTranslation

function _sdsDocInfoFS_.pm_GetdsTranslationRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsTranslationRef;
end;

function _sdsDocInfoFS_.pm_GetDsSimilarDocuments: IdsDocumentList;
//#UC START# *500CEE5200DF_493D2F7B031Dget_var*
//#UC END# *500CEE5200DF_493D2F7B031Dget_var*
begin
 with pm_GetdsSimilarDocumentsRef do
 begin
  if IsEmpty
   //#UC START# *500CEE5200DF_493D2F7B031Dget_need*
     and (UCFormSet.SimilarDocumentsNeedMakeDS <> vcm_nmNo)
     and NeedMakeSimilarDocuments
   // - условие создания ViewArea
  //#UC END# *500CEE5200DF_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsSimilarDocuments;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsSimilarDocumentsRef
end;

function _sdsDocInfoFS_.DoGet_dsSimilarDocuments: IdsDocumentList;
//#UC START# *500CEE5200DF_493D2F7B031Darea_var*

  function lp_SimilarDocsList: IDynList;
  var
   l_CB: ICatalogBase;
  begin
   if TruthHasSimilarDocuments then
   begin
    pm_GetDocInfo.Doc.GetSameDocuments(l_CB);
    try
     Supports(l_CB, IDynList, Result);
    finally
     l_CB := nil;
    end;{try..finally}
   end//TruthHasSimilarDocuments
   else
    Result := nil;
  end;//lp_SimilarDocsList

//#UC END# *500CEE5200DF_493D2F7B031Darea_var*
begin
//#UC START# *500CEE5200DF_493D2F7B031Darea_impl*
 Result := TdsDocumentList.Make(Self, TdeDocumentList.Make(lp_SimilarDocsList));
//#UC END# *500CEE5200DF_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsSimilarDocuments

function _sdsDocInfoFS_.pm_GetdsSimilarDocumentsRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsSimilarDocumentsRef;
end;

function _sdsDocInfoFS_.pm_GetDsChronology: IdsDocument;
//#UC START# *53BFD3A70050_493D2F7B031Dget_var*
//#UC END# *53BFD3A70050_493D2F7B031Dget_var*
begin
 with pm_GetdsChronologyRef do
 begin
  if IsEmpty
   //#UC START# *53BFD3A70050_493D2F7B031Dget_need*
   and NeedMakeChronology
  //#UC END# *53BFD3A70050_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsChronology;
  Result := IdsDocument(Referred);
 end;//with pm_GetdsChronologyRef
end;

function _sdsDocInfoFS_.DoGet_dsChronology: IdsDocument;
//#UC START# *53BFD3A70050_493D2F7B031Darea_var*
var
 l_Container: IbsDocumentContainer;
//#UC END# *53BFD3A70050_493D2F7B031Darea_var*
begin
//#UC START# *53BFD3A70050_493D2F7B031Darea_impl*
 if Supports(SetData.DocInfo, IbsDocumentContainer, l_Container) then
  try
   Result := TdsChronology.Make(Self,
     TdeDocInfo.Make(TbsNestedDocumentContainer.Make(l_Container, ndtChronology, TruthHasChronology))
   );
  finally
   l_Container := nil;
  end//try..finally
 else
  Result := nil;
//#UC END# *53BFD3A70050_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsChronology

function _sdsDocInfoFS_.pm_GetdsChronologyRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsChronologyRef;
end;

function _sdsDocInfoFS_.HasSimilarToFragment(anId: Integer): Boolean;
//#UC START# *558928CF0335_493D2F7B031D_var*
//#UC END# *558928CF0335_493D2F7B031D_var*
begin
//#UC START# *558928CF0335_493D2F7B031D_impl*
 Assert(False);
 Result := False; // заглушка
//#UC END# *558928CF0335_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.HasSimilarToFragment

function _sdsDocInfoFS_.pm_GetDsSimilarDocumentsToFragment: IdsDocumentList;
//#UC START# *5594F2C102D7_493D2F7B031Dget_var*
//#UC END# *5594F2C102D7_493D2F7B031Dget_var*
begin
 with pm_GetdsSimilarDocumentsToFragmentRef do
 begin
  if IsEmpty
   //#UC START# *5594F2C102D7_493D2F7B031Dget_need*
    and False //todo
  //#UC END# *5594F2C102D7_493D2F7B031Dget_need*
   then
    Referred := DoGet_dsSimilarDocumentsToFragment;
  Result := IdsDocumentList(Referred);
 end;//with pm_GetdsSimilarDocumentsToFragmentRef
end;

function _sdsDocInfoFS_.DoGet_dsSimilarDocumentsToFragment: IdsDocumentList;
//#UC START# *5594F2C102D7_493D2F7B031Darea_var*
//#UC END# *5594F2C102D7_493D2F7B031Darea_var*
begin
//#UC START# *5594F2C102D7_493D2F7B031Darea_impl*
 Assert(False);
 Result := nil;
//#UC END# *5594F2C102D7_493D2F7B031Darea_impl*
end;//_sdsDocInfoFS_.DoGet_dsSimilarDocumentsToFragment

function _sdsDocInfoFS_.pm_GetdsSimilarDocumentsToFragmentRef: IvcmViewAreaControllerRef;
begin
 Result := SetData.dsSimilarDocumentsToFragmentRef;
end;

function _sdsDocInfoFS_.pm_GetHasChronology: Boolean;
//#UC START# *5BAF4D39E661_493D2F7B031Dget_var*
//#UC END# *5BAF4D39E661_493D2F7B031Dget_var*
begin
//#UC START# *5BAF4D39E661_493D2F7B031Dget_impl*
 Result := TruthHasChronology; 
//#UC END# *5BAF4D39E661_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasChronology

function _sdsDocInfoFS_.pm_GetHasAnnotation: Boolean;
//#UC START# *8A0096569944_493D2F7B031Dget_var*
//#UC END# *8A0096569944_493D2F7B031Dget_var*
begin
//#UC START# *8A0096569944_493D2F7B031Dget_impl*
 Result := TruthHasAnnotation;
//#UC END# *8A0096569944_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasAnnotation

function _sdsDocInfoFS_.pm_GetHasCorrespondents: Boolean;
//#UC START# *A0814C441725_493D2F7B031Dget_var*
var
 l_Temp: Tl3Bool;
//#UC END# *A0814C441725_493D2F7B031Dget_var*
begin
//#UC START# *A0814C441725_493D2F7B031Dget_impl*
 Result := False;
 if pm_GetHasDocument and not l3BoolCheck(SetData.HasCorrespondents, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.
   HasCorrespondents(SetData.CorrType.Value), l_Temp);
  SetData.HasCorrespondents := l_Temp;
 end;
//#UC END# *A0814C441725_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasCorrespondents

function _sdsDocInfoFS_.pm_GetHasRespondents: Boolean;
//#UC START# *E562F23618B1_493D2F7B031Dget_var*
var
 l_Temp: Tl3Bool;
//#UC END# *E562F23618B1_493D2F7B031Dget_var*
begin
//#UC START# *E562F23618B1_493D2F7B031Dget_impl*
 Result := False;
 if pm_GetHasDocument and not l3BoolCheck(SetData.HasRespondents, Result) then
 begin
  Result := l3BoolSet(pm_GetDocInfo.Doc.HasRespondents(SetData.RespType.Value),
   l_Temp);
  SetData.HasRespondents := l_Temp;
 end;
//#UC END# *E562F23618B1_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasRespondents

function _sdsDocInfoFS_.pm_GetHasSimilarDocumentsToFragment: Boolean;
//#UC START# *FB58A26F97AF_493D2F7B031Dget_var*
//#UC END# *FB58A26F97AF_493D2F7B031Dget_var*
begin
//#UC START# *FB58A26F97AF_493D2F7B031Dget_impl*
 Assert(False);
 Result := False;
//#UC END# *FB58A26F97AF_493D2F7B031Dget_impl*
end;//_sdsDocInfoFS_.pm_GetHasSimilarDocumentsToFragment

procedure _sdsDocInfoFS_.Cleanup;
//#UC START# *479731C50290_493D2F7B031D_var*
//#UC END# *479731C50290_493D2F7B031D_var*
begin
//#UC START# *479731C50290_493D2F7B031D_impl*
 ResetCachedObject(false);
 SetData.ResetBooleans;
 inherited;
//#UC END# *479731C50290_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.Cleanup

procedure _sdsDocInfoFS_.InitFields;
//#UC START# *47A042E100E2_493D2F7B031D_var*
//#UC END# *47A042E100E2_493D2F7B031D_var*
begin
//#UC START# *47A042E100E2_493D2F7B031D_impl*
 inherited;
 SetData.ResetBooleans;
 SetData.CorrType := TbsCRTypeFrozen.Make;
 SetData.RespType := TbsCRTypeFrozen.Make;
//#UC END# *47A042E100E2_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.InitFields

procedure _sdsDocInfoFS_.FinishDataUpdate;
//#UC START# *47EA4E9002C6_493D2F7B031D_var*
//#UC END# *47EA4E9002C6_493D2F7B031D_var*
begin
//#UC START# *47EA4E9002C6_493D2F7B031D_impl*
 inherited;
 ResetCacheAfterUpdate; // http://mdp.garant.ru/pages/viewpage.action?pageId=323060346 
 if pm_GetDocInfo <> nil then
  pm_GetDocInfo.ClearListNode;
  // - отключаем переход по предыдущему\сдедующему (K<104434416>).
  //
  //   В самом TdeDocInfo подписываться на уведомления о переключении базы и
  //   обнулять ListNode нельзя, т.к. когда уведомление получит БОС то
  //   произойдет Refresh, в котором клонируют TdeDocInfo (передадут ListNode),
  //   а старый освободят и до уведомления TdeDocInfo дело не дойдет.
  //
  //   Можно было дописать логику уведомления об обновлении, если подписывается
  //   новый слушатель и при этом идет процесс уведомления, то уведомлять
  //   слушателя, но я не уверен, что правильно посылать такое сообщение вновь
  //   созданным объектам.
  //
  //   Морозов. М.А.
  ////////////////////////////////////////////////////////////////////////////// 
//#UC END# *47EA4E9002C6_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.FinishDataUpdate

procedure _sdsDocInfoFS_.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_493D2F7B031D_var*
//#UC END# *47EA8B9601FE_493D2F7B031D_var*
begin
//#UC START# *47EA8B9601FE_493D2F7B031D_impl*
 inherited;
 ConfigurationChanged;
//#UC END# *47EA8B9601FE_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.SettingsReplaceFinish

procedure _sdsDocInfoFS_.ClearAllDS;
//#UC START# *4925B7F00156_493D2F7B031D_var*
//#UC END# *4925B7F00156_493D2F7B031D_var*
begin
//#UC START# *4925B7F00156_493D2F7B031D_impl*
 inherited;
 with SetData do
 begin
  dsRespondentsRef.Referred := nil;
  dsCorrespondentsRef.Referred := nil;
  dsRelatedDocRef.Referred := nil;
  dsAnnotationRef.Referred := nil;
  dsSimilarDocumentsRef.Referred := nil;
  dsDocumentWithFlashRef.Referred := nil;

  pm_GetdsTranslationRef.Referred := nil;
  pm_GetdsUserCR1Ref.Referred := nil;
  pm_GetdsUserCR2Ref.Referred := nil;
 end;
//#UC END# *4925B7F00156_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.ClearAllDS

function _sdsDocInfoFS_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_493D2F7B031D_var*
//#UC END# *4925B9370022_493D2F7B031D_var*
begin
//#UC START# *4925B9370022_493D2F7B031D_impl*
 if not (pm_GetDocInfo <> nil) or not Assigned(aDoc) or
   (not aDoc.Doc.IsSameView(pm_GetDocInfo.Doc) or
   not aDoc.Pos.EQ(pm_GetDocInfo.Pos)) then
 begin
  SetData.DocInfo := aDoc;
  ResetCachedObject(false);
  SetData.ResetBooleans;
  Result := True;
 end
 else
  Result := False;
 FillState;
//#UC END# *4925B9370022_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.DoChangeDocument

{$If not defined(NoVCM)}
procedure _sdsDocInfoFS_.ClearAreas;
 {-}
begin
 pm_GetdsRelatedDocRef.Referred := nil;
 pm_GetdsRespondentsRef.Referred := nil;
 pm_GetdsCorrespondentsRef.Referred := nil;
 pm_GetdsUserCR1Ref.Referred := nil;
 pm_GetdsUserCR2Ref.Referred := nil;
 pm_GetdsDocumentWithFlashRef.Referred := nil;
 pm_GetdsAnnotationRef.Referred := nil;
 pm_GetdsTranslationRef.Referred := nil;
 pm_GetdsSimilarDocumentsRef.Referred := nil;
 pm_GetdsChronologyRef.Referred := nil;
 inherited;
end;//_sdsDocInfoFS_.ClearAreas
{$IfEnd} //not NoVCM

procedure _sdsDocInfoFS_.FillState;
//#UC START# *493D51ED0329_493D2F7B031D_var*
//#UC END# *493D51ED0329_493D2F7B031D_var*
begin
//#UC START# *493D51ED0329_493D2F7B031D_impl*
 inherited;
//#UC END# *493D51ED0329_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.FillState

procedure _sdsDocInfoFS_.UserSettingsChanged;
//#UC START# *4958BE910345_493D2F7B031D_var*
//#UC END# *4958BE910345_493D2F7B031D_var*
begin
//#UC START# *4958BE910345_493D2F7B031D_impl*
 inherited;
 ConfigurationChanged;
//#UC END# *4958BE910345_493D2F7B031D_impl*
end;//_sdsDocInfoFS_.UserSettingsChanged

// Методы преобразования к реализуемым интерфейсам

function _sdsDocInfoFS_.As_IbsFlash: IbsFlash;
begin
 Result := Self;
end;

{$IfEnd} //not Admin AND not Monitorings

{$EndIf sdsDocInfo_imp}
