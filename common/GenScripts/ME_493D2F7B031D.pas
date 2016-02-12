{$IfNDef sdsDocInfo_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsDocInfo.imp.pas"
// Стереотип: "UseCaseControllerImp"

{$Define sdsDocInfo_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
 _afwApplicationDataUpdate_Parent_ = _sdsBaseDocumentWithAttributes_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 _afwSettingsReplace_Parent_ = _afwApplicationDataUpdate_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
 _nsUserSettingsListener_Parent_ = _afwSettingsReplace_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
 _sdsDocInfo_ = {abstract} class(_nsUserSettingsListener_, IsdsDocInfo, IbsFlash)
  {* Общий объект сборки для списка и документа }
  private
   procedure ConfigurationChanged;
    {* изменилась активная конфигурация }
  protected
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
   function As_IbsFlash: IbsFlash;
    {* Метод приведения нашего интерфейса к IbsFlash }
   function pm_GetHasTranslation: Boolean;
   function pm_GetHasSimilarDocuments: Boolean;
   function pm_GetHasRelatedDoc: Boolean;
   procedure OpenCorrespondents;
    {* корреспонденты }
   procedure OpenRespondents;
    {* респонденты }
   function ChangeCRType(const aNode: INodeBase;
    aType: TlstCRType;
    IsCRToPart: Boolean = False): Boolean;
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
   function pm_GetdsRelatedDoc: IdsDocument;
   function pm_GetdsRespondents: IdsDocumentList;
   function pm_GetdsCorrespondents: IdsDocumentList;
   function pm_GetdsUserCR1: IdsDocumentList;
   function pm_GetdsUserCR2: IdsDocumentList;
   function pm_GetdsDocumentWithFlash: IdsDocumentWithFlash;
   function pm_GetdsAnnotation: IdsDocument;
   function pm_GetdsTranslation: IdsDocument;
   function pm_GetdsSimilarDocuments: IdsDocumentList;
   function pm_GetdsChronology: IdsDocument;
   function HasSimilarToFragment(anId: Integer): Boolean;
   function pm_GetdsSimilarDocumentsToFragment: IdsDocumentList;
   function pm_GetHasChronology: Boolean;
   function pm_GetHasAnnotation: Boolean;
   function pm_GetHasCorrespondents: Boolean;
   function pm_GetHasRespondents: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure FinishDataUpdate; override;
   procedure SettingsReplaceFinish; override;
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure FillState; override;
   procedure UserSettingsChanged; override;
    {* Изменились настройки пользователя }
 end;//_sdsDocInfo_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}
_afwApplicationDataUpdate_Parent_ = _sdsBaseDocumentWithAttributes_;
{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
_afwSettingsReplace_Parent_ = _afwApplicationDataUpdate_;
{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
_nsUserSettingsListener_Parent_ = _afwSettingsReplace_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}
_sdsDocInfo_ = _nsUserSettingsListener_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsDocInfo_imp}

{$IfNDef sdsDocInfo_imp_impl}

{$Define sdsDocInfo_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\sdsBaseDocumentWithAttributes.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsUserSettingsListener.imp.pas}

function _sdsDocInfo_.NeedMakeDSUserCRList1: Boolean;
//#UC START# *493D51B00058_493D2F7B031D_var*
//#UC END# *493D51B00058_493D2F7B031D_var*
begin
//#UC START# *493D51B00058_493D2F7B031D_impl*
 Result := SetData.UserCRListInfo[ulFirst].Has;
//#UC END# *493D51B00058_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeDSUserCRList1

function _sdsDocInfo_.NeedMakeDSUserCRList2: Boolean;
//#UC START# *493D51BE03DC_493D2F7B031D_var*
//#UC END# *493D51BE03DC_493D2F7B031D_var*
begin
//#UC START# *493D51BE03DC_493D2F7B031D_impl*
 Result := SetData.UserCRListInfo[ulSecond].Has;
//#UC END# *493D51BE03DC_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeDSUserCRList2

function _sdsDocInfo_.NeedMakeDSCorrespondents: Boolean;
//#UC START# *493D51D0039B_493D2F7B031D_var*
//#UC END# *493D51D0039B_493D2F7B031D_var*
begin
//#UC START# *493D51D0039B_493D2F7B031D_impl*
 Result := pm_GetHasCorrespondents;
//#UC END# *493D51D0039B_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeDSCorrespondents

function _sdsDocInfo_.NeedMakeDSRespondents: Boolean;
//#UC START# *493D51DF022F_493D2F7B031D_var*
//#UC END# *493D51DF022F_493D2F7B031D_var*
begin
//#UC START# *493D51DF022F_493D2F7B031D_impl*
 Result := pm_GetHasRespondents;
//#UC END# *493D51DF022F_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeDSRespondents

function _sdsDocInfo_.StateIfNeedShowFullCRList: TvcmNeedMakeDS;
 {* определяет состояние, которое присваивается бизнес объекту полного
           списка, если принимается решение показывать вместо пользовательского
           списка полный СКР }
//#UC START# *493D521E0135_493D2F7B031D_var*
//#UC END# *493D521E0135_493D2F7B031D_var*
begin
//#UC START# *493D521E0135_493D2F7B031D_impl*
 Result := vcm_nmYes;
//#UC END# *493D521E0135_493D2F7B031D_impl*
end;//_sdsDocInfo_.StateIfNeedShowFullCRList

function _sdsDocInfo_.ChangeCorrType(const aValue: INodeBase): Boolean;
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
end;//_sdsDocInfo_.ChangeCorrType

function _sdsDocInfo_.ChangeRespType(const aValue: INodeBase): Boolean;
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
end;//_sdsDocInfo_.ChangeRespType

function _sdsDocInfo_.IsOrdinalCRSelected(aCRType: TlstCRType;
 out aId: TnsUserCRListId): Boolean;
 {* проверка того, что в настройках пользователя выбраны нетипизированные
           СКР. aId - возвращает вкладку для которой определен не
           типизированный СКР, это нужно при изменении настроек }
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
end;//_sdsDocInfo_.IsOrdinalCRSelected

procedure _sdsDocInfo_.ResetCachedObject(aWithoutCRTypes: Boolean);
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
end;//_sdsDocInfo_.ResetCachedObject

function _sdsDocInfo_.TruthHasSimilarDocuments: Boolean;
 {* определяет наличие похожих у документа }
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
end;//_sdsDocInfo_.TruthHasSimilarDocuments

function _sdsDocInfo_.TruthHasRelatedDoc: Boolean;
 {* определяет наличие справки у документа }
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
end;//_sdsDocInfo_.TruthHasRelatedDoc

function _sdsDocInfo_.TruthHasAnnotation: Boolean;
 {* определяет наличие аннотации у документа }
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
end;//_sdsDocInfo_.TruthHasAnnotation

function _sdsDocInfo_.TruthHasChronology: Boolean;
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
end;//_sdsDocInfo_.TruthHasChronology

function _sdsDocInfo_.GetTypedCR(aId: TnsUserCRListId): IdeDocumentListCR;
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
end;//_sdsDocInfo_.GetTypedCR

procedure _sdsDocInfo_.ConfigurationChanged;
 {* изменилась активная конфигурация }
//#UC START# *493D606D0189_493D2F7B031D_var*
//#UC END# *493D606D0189_493D2F7B031D_var*
begin
//#UC START# *493D606D0189_493D2F7B031D_impl*
 FillState;
 Refresh;
//#UC END# *493D606D0189_493D2F7B031D_impl*
end;//_sdsDocInfo_.ConfigurationChanged

function _sdsDocInfo_.NeedMakeDocumentWithFlash: Boolean;
//#UC START# *493D62FF02AF_493D2F7B031D_var*
//#UC END# *493D62FF02AF_493D2F7B031D_var*
begin
//#UC START# *493D62FF02AF_493D2F7B031D_impl*
 Result := pm_GetHasDocument and (pm_GetDocInfo.Doc.GetDocType = DT_FLASH);
//#UC END# *493D62FF02AF_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeDocumentWithFlash

function _sdsDocInfo_.DoChangeCRType(const aNode: INodeBase;
 aType: TlstCRType;
 IsCRToPart: Boolean): Boolean;
 {* вызывается при изменении типа корреспондентов/респондентов }
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
end;//_sdsDocInfo_.DoChangeCRType

function _sdsDocInfo_.NeedMakeRelatedDoc: Boolean;
//#UC START# *493D6E7E0282_493D2F7B031D_var*
//#UC END# *493D6E7E0282_493D2F7B031D_var*
begin
//#UC START# *493D6E7E0282_493D2F7B031D_impl*
 Result := pm_GetHasRelatedDoc;
//#UC END# *493D6E7E0282_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeRelatedDoc

function _sdsDocInfo_.NeedMakeAnnotation: Boolean;
//#UC START# *493D6EAB0019_493D2F7B031D_var*
//#UC END# *493D6EAB0019_493D2F7B031D_var*
begin
//#UC START# *493D6EAB0019_493D2F7B031D_impl*
 Result := pm_GetHasAnnotation;
//#UC END# *493D6EAB0019_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeAnnotation

function _sdsDocInfo_.NeedMakeChronology: Boolean;
//#UC START# *53BFE4C1035E_493D2F7B031D_var*
//#UC END# *53BFE4C1035E_493D2F7B031D_var*
begin
//#UC START# *53BFE4C1035E_493D2F7B031D_impl*
 Result := pm_GetHasChronology;
//#UC END# *53BFE4C1035E_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeChronology

function _sdsDocInfo_.NeedMakeSimilarDocuments: Boolean;
//#UC START# *493D6EC40228_493D2F7B031D_var*
//#UC END# *493D6EC40228_493D2F7B031D_var*
begin
//#UC START# *493D6EC40228_493D2F7B031D_impl*
 Result := pm_GetHasSimilarDocuments;
//#UC END# *493D6EC40228_493D2F7B031D_impl*
end;//_sdsDocInfo_.NeedMakeSimilarDocuments

function _sdsDocInfo_.GetOrMakeRespList: IDynList;
 {* О необходимости метода читаем тут - [$130744335] }
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
end;//_sdsDocInfo_.GetOrMakeRespList

function _sdsDocInfo_.GetOrMakeCorrList: IDynList;
 {* О необходимости метода читаем тут - [$130744335] }
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
end;//_sdsDocInfo_.GetOrMakeCorrList

function _sdsDocInfo_.As_IbsFlash: IbsFlash;
 {* Метод приведения нашего интерфейса к IbsFlash }
begin
 Result := Self;
end;//_sdsDocInfo_.As_IbsFlash

function _sdsDocInfo_.pm_GetHasTranslation: Boolean;
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
end;//_sdsDocInfo_.pm_GetHasTranslation

function _sdsDocInfo_.pm_GetHasSimilarDocuments: Boolean;
//#UC START# *10E3D328A415_493D2F7B031Dget_var*
//#UC END# *10E3D328A415_493D2F7B031Dget_var*
begin
//#UC START# *10E3D328A415_493D2F7B031Dget_impl*
 Result := TruthHasSimilarDocuments;
//#UC END# *10E3D328A415_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetHasSimilarDocuments

function _sdsDocInfo_.pm_GetHasRelatedDoc: Boolean;
//#UC START# *3690DB82E835_493D2F7B031Dget_var*
//#UC END# *3690DB82E835_493D2F7B031Dget_var*
begin
//#UC START# *3690DB82E835_493D2F7B031Dget_impl*
 Result := TruthHasRelatedDoc;
//#UC END# *3690DB82E835_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetHasRelatedDoc

procedure _sdsDocInfo_.OpenCorrespondents;
 {* корреспонденты }
//#UC START# *4937C4D90220_493D2F7B031D_var*
//#UC END# *4937C4D90220_493D2F7B031D_var*
begin
//#UC START# *4937C4D90220_493D2F7B031D_impl*
 if SetData.dsCorrespondentsRef.IsEmpty then
 begin
  SetData.dsCorrespondentsRef.NeedMake := vcm_nmForce;
  Refresh;
 end;//if SetData.refCorrespondents.IsEmpty then
//#UC END# *4937C4D90220_493D2F7B031D_impl*
end;//_sdsDocInfo_.OpenCorrespondents

procedure _sdsDocInfo_.OpenRespondents;
 {* респонденты }
//#UC START# *4937C4E701F3_493D2F7B031D_var*
//#UC END# *4937C4E701F3_493D2F7B031D_var*
begin
//#UC START# *4937C4E701F3_493D2F7B031D_impl*
 if SetData.dsRespondentsRef.IsEmpty then
 begin
  SetData.dsRespondentsRef.NeedMake := vcm_nmForce;
  Refresh;
 end;//if SetData.refRespondents.IsEmpty then
//#UC END# *4937C4E701F3_493D2F7B031D_impl*
end;//_sdsDocInfo_.OpenRespondents

function _sdsDocInfo_.ChangeCRType(const aNode: INodeBase;
 aType: TlstCRType;
 IsCRToPart: Boolean = False): Boolean;
 {* вызывается при изменении типа корреспондентов/респондентов }
//#UC START# *4937C4F5038B_493D2F7B031D_var*
//#UC END# *4937C4F5038B_493D2F7B031D_var*
begin
//#UC START# *4937C4F5038B_493D2F7B031D_impl*
 Result := DoChangeCRType(aNode, aType, IsCRToPart);
//#UC END# *4937C4F5038B_493D2F7B031D_impl*
end;//_sdsDocInfo_.ChangeCRType

procedure _sdsDocInfo_.AddToControl;
 {* поставить документ на контроль }
//#UC START# *4937C5250138_493D2F7B031D_var*
//#UC END# *4937C5250138_493D2F7B031D_var*
begin
//#UC START# *4937C5250138_493D2F7B031D_impl*
 if (pm_GetDocInfo <> nil) then
 begin
  TdmStdRes.AddDocumentToControl(pm_GetDocInfo.Doc);
  SetData.IsUnderControl := l3_bUnknown;
 end;
//#UC END# *4937C5250138_493D2F7B031D_impl*
end;//_sdsDocInfo_.AddToControl

procedure _sdsDocInfo_.DelFromControl;
 {* снять с контроля }
//#UC START# *4937C55101B2_493D2F7B031D_var*
//#UC END# *4937C55101B2_493D2F7B031D_var*
begin
//#UC START# *4937C55101B2_493D2F7B031D_impl*
 if (pm_GetDocInfo <> nil) then
 begin
  TdmStdRes.DeleteDocumentFromControl(pm_GetDocInfo.Doc);
  SetData.IsUnderControl := l3_bUnknown;
 end;
//#UC END# *4937C55101B2_493D2F7B031D_impl*
end;//_sdsDocInfo_.DelFromControl

procedure _sdsDocInfo_.ResetCacheAfterUpdate;
 {* сброс закэшированных параметров после обновления базы документов }
//#UC START# *4937C56002B6_493D2F7B031D_var*
//#UC END# *4937C56002B6_493D2F7B031D_var*
begin
//#UC START# *4937C56002B6_493D2F7B031D_impl*
 SetData.ResetBooleans;
 ResetCachedObject(True);
//#UC END# *4937C56002B6_493D2F7B031D_impl*
end;//_sdsDocInfo_.ResetCacheAfterUpdate

function _sdsDocInfo_.IsTypedCRSelected(aSheetNumber: TnsUserCRListId): Boolean;
 {* проверка того, что пользователь настроил соответствующую вкладку СКР }
//#UC START# *4937C58D008D_493D2F7B031D_var*
//#UC END# *4937C58D008D_493D2F7B031D_var*
begin
//#UC START# *4937C58D008D_493D2F7B031D_impl*
 with SetData.UserCRListInfo[aSheetNumber] do
  Result := (ListType <> crtNone) and bsIsCRNodeAreNotAllDocuments(Node);
//#UC END# *4937C58D008D_493D2F7B031D_impl*
end;//_sdsDocInfo_.IsTypedCRSelected

function _sdsDocInfo_.HasTypedCRinBigBase(aSheetNumber: TnsUserCRListId): Boolean;
 {* проверка наличмия типизированных СКР в полной базе }
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
end;//_sdsDocInfo_.HasTypedCRinBigBase

function _sdsDocInfo_.pm_GetIsUnderControl: Boolean;
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
  Result := l3BoolSet(TdmStdRes.IsUnderControl(pm_GetDocInfo.Doc), l_Temp);
  SetData.IsUnderControl := l_Temp;
 end;
//#UC END# *4937C61C0270_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetIsUnderControl

function _sdsDocInfo_.pm_GetUserCRListInfo(aId: TnsUserCRListId): IbsUserCRListInfo;
//#UC START# *4937D0FF0303_493D2F7B031Dget_var*
//#UC END# *4937D0FF0303_493D2F7B031Dget_var*
begin
//#UC START# *4937D0FF0303_493D2F7B031Dget_impl*
 Result := SetData.UserCRListInfo[aId];
//#UC END# *4937D0FF0303_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetUserCRListInfo

function _sdsDocInfo_.pm_GetFlashData: IExternalObject;
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
end;//_sdsDocInfo_.pm_GetFlashData

function _sdsDocInfo_.pm_GetdsRelatedDoc: IdsDocument;
//#UC START# *5009A673037A_493D2F7B031Dget_var*
//#UC END# *5009A673037A_493D2F7B031Dget_var*
begin
//#UC START# *5009A673037A_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009A673037A_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsRelatedDoc

function _sdsDocInfo_.pm_GetdsRespondents: IdsDocumentList;
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
//#UC START# *5009A699023D_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009A699023D_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsRespondents

function _sdsDocInfo_.pm_GetdsCorrespondents: IdsDocumentList;
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
//#UC START# *5009A6BE01DD_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009A6BE01DD_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsCorrespondents

function _sdsDocInfo_.pm_GetdsUserCR1: IdsDocumentList;
//#UC START# *5009A6EF0016_493D2F7B031Dget_var*
//#UC END# *5009A6EF0016_493D2F7B031Dget_var*
begin
//#UC START# *5009A6EF0016_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009A6EF0016_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsUserCR1

function _sdsDocInfo_.pm_GetdsUserCR2: IdsDocumentList;
//#UC START# *5009A72B01A5_493D2F7B031Dget_var*
//#UC END# *5009A72B01A5_493D2F7B031Dget_var*
begin
//#UC START# *5009A72B01A5_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009A72B01A5_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsUserCR2

function _sdsDocInfo_.pm_GetdsDocumentWithFlash: IdsDocumentWithFlash;
//#UC START# *5009ADAC0080_493D2F7B031Dget_var*
//#UC END# *5009ADAC0080_493D2F7B031Dget_var*
begin
//#UC START# *5009ADAC0080_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5009ADAC0080_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsDocumentWithFlash

function _sdsDocInfo_.pm_GetdsAnnotation: IdsDocument;
//#UC START# *500CEDF00141_493D2F7B031Dget_var*
//#UC END# *500CEDF00141_493D2F7B031Dget_var*
begin
//#UC START# *500CEDF00141_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CEDF00141_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsAnnotation

function _sdsDocInfo_.pm_GetdsTranslation: IdsDocument;
//#UC START# *500CEE0F0071_493D2F7B031Dget_var*
//#UC END# *500CEE0F0071_493D2F7B031Dget_var*
begin
//#UC START# *500CEE0F0071_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CEE0F0071_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsTranslation

function _sdsDocInfo_.pm_GetdsSimilarDocuments: IdsDocumentList;
//#UC START# *500CEE5200DF_493D2F7B031Dget_var*
//#UC END# *500CEE5200DF_493D2F7B031Dget_var*
begin
//#UC START# *500CEE5200DF_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CEE5200DF_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsSimilarDocuments

function _sdsDocInfo_.pm_GetdsChronology: IdsDocument;
//#UC START# *53BFD3A70050_493D2F7B031Dget_var*
//#UC END# *53BFD3A70050_493D2F7B031Dget_var*
begin
//#UC START# *53BFD3A70050_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *53BFD3A70050_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsChronology

function _sdsDocInfo_.HasSimilarToFragment(anId: Integer): Boolean;
//#UC START# *558928CF0335_493D2F7B031D_var*
var
 l_Provider: IDocumentTextProvider;
//#UC END# *558928CF0335_493D2F7B031D_var*
begin
//#UC START# *558928CF0335_493D2F7B031D_impl*
 if pm_GetHasDocument then
 begin
  pm_GetDocInfo.Doc.GetTextProvider(False, l_Provider);
  Result := l_Provider.HasSame(anId);
 end else
  Result := False;
//#UC END# *558928CF0335_493D2F7B031D_impl*
end;//_sdsDocInfo_.HasSimilarToFragment

function _sdsDocInfo_.pm_GetdsSimilarDocumentsToFragment: IdsDocumentList;
//#UC START# *5594F2C102D7_493D2F7B031Dget_var*
//#UC END# *5594F2C102D7_493D2F7B031Dget_var*
begin
//#UC START# *5594F2C102D7_493D2F7B031Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5594F2C102D7_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetdsSimilarDocumentsToFragment

function _sdsDocInfo_.pm_GetHasChronology: Boolean;
//#UC START# *5BAF4D39E661_493D2F7B031Dget_var*
//#UC END# *5BAF4D39E661_493D2F7B031Dget_var*
begin
//#UC START# *5BAF4D39E661_493D2F7B031Dget_impl*
 Result := TruthHasChronology; 
//#UC END# *5BAF4D39E661_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetHasChronology

function _sdsDocInfo_.pm_GetHasAnnotation: Boolean;
//#UC START# *8A0096569944_493D2F7B031Dget_var*
//#UC END# *8A0096569944_493D2F7B031Dget_var*
begin
//#UC START# *8A0096569944_493D2F7B031Dget_impl*
 Result := TruthHasAnnotation;
//#UC END# *8A0096569944_493D2F7B031Dget_impl*
end;//_sdsDocInfo_.pm_GetHasAnnotation

function _sdsDocInfo_.pm_GetHasCorrespondents: Boolean;
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
end;//_sdsDocInfo_.pm_GetHasCorrespondents

function _sdsDocInfo_.pm_GetHasRespondents: Boolean;
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
end;//_sdsDocInfo_.pm_GetHasRespondents

procedure _sdsDocInfo_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_493D2F7B031D_var*
//#UC END# *479731C50290_493D2F7B031D_var*
begin
//#UC START# *479731C50290_493D2F7B031D_impl*
 ResetCachedObject(false);
 SetData.ResetBooleans;
 inherited;
//#UC END# *479731C50290_493D2F7B031D_impl*
end;//_sdsDocInfo_.Cleanup

procedure _sdsDocInfo_.InitFields;
//#UC START# *47A042E100E2_493D2F7B031D_var*
//#UC END# *47A042E100E2_493D2F7B031D_var*
begin
//#UC START# *47A042E100E2_493D2F7B031D_impl*
 inherited;
 SetData.ResetBooleans;
 SetData.CorrType := TbsCRTypeFrozen.Make;
 SetData.RespType := TbsCRTypeFrozen.Make;
//#UC END# *47A042E100E2_493D2F7B031D_impl*
end;//_sdsDocInfo_.InitFields

procedure _sdsDocInfo_.FinishDataUpdate;
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
end;//_sdsDocInfo_.FinishDataUpdate

procedure _sdsDocInfo_.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_493D2F7B031D_var*
//#UC END# *47EA8B9601FE_493D2F7B031D_var*
begin
//#UC START# *47EA8B9601FE_493D2F7B031D_impl*
 inherited;
 ConfigurationChanged;
//#UC END# *47EA8B9601FE_493D2F7B031D_impl*
end;//_sdsDocInfo_.SettingsReplaceFinish

procedure _sdsDocInfo_.ClearAllDS;
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
end;//_sdsDocInfo_.ClearAllDS

function _sdsDocInfo_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
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
end;//_sdsDocInfo_.DoChangeDocument

{$If NOT Defined(NoVCM)}
procedure _sdsDocInfo_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_493D2F7B031D_var*
//#UC END# *4938F7E702B7_493D2F7B031D_var*
begin
//#UC START# *4938F7E702B7_493D2F7B031D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_493D2F7B031D_impl*
end;//_sdsDocInfo_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

procedure _sdsDocInfo_.FillState;
//#UC START# *493D51ED0329_493D2F7B031D_var*

  procedure lpCRNeedMake(const aDSRef : IvcmFormDataSourceRef;
                         const aType  : TlstCRType);
  var
   l_List             : TnsUserCRListId;
   l_IsFullCRSelected : Boolean;
  begin
   with aDSRef do
   begin
    l_IsFullCRSelected := IsOrdinalCRSelected(aType, l_List);
    // Отметим, что вместо пользовательской вкладки показывается полный СКР:
    if l_IsFullCRSelected then
     SetData.UserCRListInfo[l_List].wKindOfList := bs_ulFullCR;
    // Откроем нормальную СКР вместо пользовательской
    if (NeedMake = vcm_nmNo) and l_IsFullCRSelected then
    begin
     NeedMake := StateIfNeedShowFullCRList;
     // Закроем пользовательскую вкладку
     case l_List of
      ulFirst:
       SetData.dsUserCR1Ref.Referred := nil;
      ulSecond:
       SetData.dsUserCR2Ref.Referred := nil;
     end;//case l_List of
    end//if (NeedMake = vcm_nmNo) ...
    else
     // Закроем форму СКР потому, что она была открыта по причине установки
     // пользовательской вкладки в настройках с типом "Все документы", а теперь
     // пользователь установил другой тип
     if (NeedMake = StateIfNeedShowFullCRList) and not l_IsFullCRSelected then
      aDSRef.Clear;
   end;//with aDSRef do
  end;//lpCRNeedMake

  procedure lp_InitUserCRList(const aValue: TnsUserCRListId);
  var
   l_Temp: IbsUserCRListInfoModify;

   function lp_IsUserCRListChanged: Boolean;
   begin
    l_Temp.Assign(SetData.UserCRListInfo[aValue]);
     // - скопируем, чтобы позднее сравнить изменились ли параметры
     //   пользовательской вкладки:
    with SetData.UserCRListInfo[aValue] do
    begin
     wListType := bsUserCRList(aValue);
     wNode := bsUserCRNode(aValue);
     wHas := IsTypedCRSelected(aValue) and (ListType <> crtNone) and
      HasTypedCRinBigBase(aValue);
     wKindOfList := bs_ulUserCR;
    end;//with SetData.UserCRListInfo[ulSecond] do
    Result := not l_Temp.IsSame(SetData.UserCRListInfo[aValue]);
     // - проверим изменились ли данные;
   end;//lp_ReadSettings

   procedure lp_UpdateDSUserCRList;
   begin
    // Инициируем переполучение бизнес объекта для вкладки:
    with SetData do
     case aValue of
      ulFirst:
       dsUserCR1Ref.Clear;
      ulSecond:
       dsUserCR2Ref.Clear;
      else
       Assert(False);
     end;//case aValue of
   end;//lp_UpdateDSUserCRList

  begin
   l_Temp := TbsUserCRListInfo.Make;
   try
    // Проверим изменились ли параметры:
    if lp_IsUserCRListChanged then
     // Инициируем переполучение бизнес объктов:
     lp_UpdateDSUserCRList;
   finally
    l_Temp := nil;
   end;//try..finally
  end;//lp_InitUserCRList

//#UC END# *493D51ED0329_493D2F7B031D_var*
begin
//#UC START# *493D51ED0329_493D2F7B031D_impl*
 inherited;
 if not afw.Settings.LoadBoolean(pi_Document_Sheets_Translation,
   dv_Document_Sheets_Translation) then
  SetData.dsTranslationRef.Clear;
 // Первый пользовательский список КР:
 lp_InitUserCRList(ulFirst);
 // Второй список КР:
 lp_InitUserCRList(ulSecond);
 // Если в качестве пользовательского СР выбраны "Все документы", то открывается
 // обычный СКР, который можно типизировать:
 lpCRNeedMake(pm_GetDsRespondentsRef, crtRespondents);
 lpCRNeedMake(pm_GetDsCorrespondentsRef, crtCorrespondents);
//#UC END# *493D51ED0329_493D2F7B031D_impl*
end;//_sdsDocInfo_.FillState

procedure _sdsDocInfo_.UserSettingsChanged;
 {* Изменились настройки пользователя }
//#UC START# *4958BE910345_493D2F7B031D_var*
//#UC END# *4958BE910345_493D2F7B031D_var*
begin
//#UC START# *4958BE910345_493D2F7B031D_impl*
 inherited;
 ConfigurationChanged;
//#UC END# *4958BE910345_493D2F7B031D_impl*
end;//_sdsDocInfo_.UserSettingsChanged
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf sdsDocInfo_imp_impl}

{$EndIf sdsDocInfo_imp}

