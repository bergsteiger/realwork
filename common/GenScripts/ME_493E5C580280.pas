{$IfNDef sdsDocument_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Document\sdsDocument.imp.pas"
// Стереотип: "UseCaseControllerImp"

{$Define sdsDocument_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _SetDataType_ = IdDocument;
 _InitDataType_ = IdeDocInfo;
 {$Include sdsDocInfo.imp.pas}
 _nsOpenContents_Parent_ = _sdsDocInfo_;
 {$Include nsOpenContents.imp.pas}
 _sdsDocument_ = {abstract} class(_nsOpenContents_, IsdsDocument, IucpDocumentWithContents, InsWarningGenerator, InsWarningLocker, IucpBaseSearchSupportQuery)
  {* Бизнес объект сборки "Документ" }
  private
   f_LockWarningCount: Integer;
   f_dsBaloonWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsBaloonWarning }
   f_dsTimeMachineWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTimeMachineWarning }
   f_dsTranslationWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsTranslationWarning }
   f_dsCRBaloonWarning: IvcmViewAreaControllerRef;
    {* Поле для области вывода dsCRBaloonWarning }
  private
   procedure DoDoChangeDocument(const aDocInfo: IdeDocInfo;
    const aPos: TbsDocPos;
    aSaveToHistory: Boolean = False;
    const aDataForHistory: IvcmData = nil); virtual;
   function HasTypedCRInCache(const aNode: INodeBase;
    aType: TlstCRType): Boolean;
   function ChangeCRTypeToFullDocument(const aNode: INodeBase;
    aType: TlstCRType): Boolean;
   function ChangeCRTypeToPart(const aNode: INodeBase;
    aType: TlstCRType): Boolean; virtual;
  protected
   function NeedDSWarning: Boolean;
   function DoCanRunBaseSearch: Boolean; virtual;
   function As_IucpDocumentWithContents: IucpDocumentWithContents;
    {* Метод приведения нашего интерфейса к IucpDocumentWithContents }
   function As_InsWarningGenerator: InsWarningGenerator;
    {* Метод приведения нашего интерфейса к InsWarningGenerator }
   function As_InsWarningLocker: InsWarningLocker;
    {* Метод приведения нашего интерфейса к InsWarningLocker }
   function As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
    {* Метод приведения нашего интерфейса к IucpBaseSearchSupportQuery }
   {$If NOT Defined(NoVCM)}
   function MakeData: _SetDataType_; override;
    {* Данные сборки. }
   {$IfEnd} // NOT Defined(NoVCM)
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure OpenWarning;
    {* предупреждение }
   procedure OpenEditions;
    {* редакции }
   procedure OpenSimilarDocuments;
    {* открыть список похожих документов }
   function OpenCRToPart(const aPositionList: IPositionList;
    const aNode: INodeBase;
    aType: TlstCRType): Boolean;
    {* вызывается для открытия вкладки корреспондентов/респондентов к фрагменту }
   function ChangeRedaction(const aChangeWorker: IbsChangeRedactionWorker;
    const aPos: TbsDocPos): Boolean;
    {* изменить редакцию документа }
   function IsWarningNeeded: Boolean;
    {* показывает необходимо ли показывать для данного документа предупреждение }
   function HasTimeMachineWarning: Boolean;
    {* показывает есть ли к документу предупреждение от Машины времени }
   function HasAnyRedaction: Boolean;
    {* показывает есть ли у документа не актуальные редакции }
   procedure LockWarning;
   procedure UnLockWarning;
   function Get_CanRunBaseSearch: Boolean;
   function pm_GetdsBaloonWarning: IdsWarning;
   function pm_GetdsTimeMachineWarning: IdsWarning;
   function pm_GetdsTranslationWarning: IdsWarning;
   function pm_GetdsCRBaloonWarning: IdsWarning;
   function pm_GetdsWarning: IdsWarning;
   function pm_GetdsIncomingLinksToPart: IdsDocumentList;
   function pm_GetdsEditions: IdsEditions;
   function pm_GetdsContents: IdsBaseContents;
   function pm_GetdsOutgoingLinksFromPart: IdsDocumentList;
   procedure OpenSimilarDocumentsToFragment(aBlockId: Integer);
   procedure FinishDataUpdate; override;
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure DoPushFromHistory; override;
    {* сборка была выгружена из истории }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearAllDS; override;
   function DoChangeDocument(const aDoc: IdeDocInfo): Boolean; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure FillState; override;
   function DoChangeCRType(const aNode: INodeBase;
    aType: TlstCRType;
    IsCRToPart: Boolean): Boolean; override;
    {* вызывается при изменении типа корреспондентов/респондентов }
   {$If NOT Defined(NoVCM)}
   function DoGetFormSetImageIndex: Integer; override;
   {$IfEnd} // NOT Defined(NoVCM)
  public
   function Generate(const aWarning: IdsWarning;
    const aGen: InevTagGenerator;
    aUserType: TvcmUserType): TWarningTypeSet;
    {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
 end;//_sdsDocument_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include sdsDocInfo.imp.pas}
_nsOpenContents_Parent_ = _sdsDocInfo_;
{$Include nsOpenContents.imp.pas}
_sdsDocument_ = _nsOpenContents_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else sdsDocument_imp}

{$IfNDef sdsDocument_imp_impl}

{$Define sdsDocument_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include sdsDocInfo.imp.pas}

{$Include nsOpenContents.imp.pas}

procedure _sdsDocument_.DoDoChangeDocument(const aDocInfo: IdeDocInfo;
 const aPos: TbsDocPos;
 aSaveToHistory: Boolean = False;
 const aDataForHistory: IvcmData = nil);
//#UC START# *493E68990040_493E5C580280_var*
const
 cl_SaveToHistory: array [Boolean] of TvcmSaveFormSetToHistory = (
  sfsNone,
  sfsOnlyIfDataSourceChanged);
//#UC END# *493E68990040_493E5C580280_var*
begin
//#UC START# *493E68990040_493E5C580280_impl*
 if Assigned(aDocInfo) then
 begin
  aDocInfo.SetPosition(aPos);
  ChangeDocument(aDocInfo);
  Refresh(vcmMakeDataRefreshParams(cl_SaveToHistory[aSaveToHistory],
                                   aDataForHistory));
 end;//if Assigned(aDocInfo) then
//#UC END# *493E68990040_493E5C580280_impl*
end;//_sdsDocument_.DoDoChangeDocument

function _sdsDocument_.NeedDSWarning: Boolean;
//#UC START# *493E6B050077_493E5C580280_var*

 function lp_NeedMake: Boolean;
 begin
  with afw.Settings, SetData.dsWarningRef do
   Result := (LoadBoolean(pi_Document_Warning, dv_Document_Warning) and
              (NeedMake = vcm_nmYes)) or
             (NeedMake = vcm_nmForce);
 end;

//#UC END# *493E6B050077_493E5C580280_var*
begin
//#UC START# *493E6B050077_493E5C580280_impl*
 Result := lp_NeedMake and IsWarningNeeded; 
//#UC END# *493E6B050077_493E5C580280_impl*
end;//_sdsDocument_.NeedDSWarning

function _sdsDocument_.HasTypedCRInCache(const aNode: INodeBase;
 aType: TlstCRType): Boolean;
//#UC START# *493E6F160210_493E5C580280_var*
//#UC END# *493E6F160210_493E5C580280_var*
begin
//#UC START# *493E6F160210_493E5C580280_impl*
 Result := False;
 case aType of
  crtCorrespondents:
   Result := Assigned(SetData.CorrList) and
             ((not SetData.CorrType.HasNode and
               not Assigned(aNode)) or
              (SetData.CorrType.HasNode and
               SetData.CorrType.Value.IsSameNode(aNode)));
  crtRespondents:
   Result := Assigned(SetData.RespList) and
             ((not SetData.RespType.HasNode and
               not Assigned(aNode)) or
              (SetData.RespType.HasNode and
               SetData.RespType.Value.IsSameNode(aNode)));
 end;
//#UC END# *493E6F160210_493E5C580280_impl*
end;//_sdsDocument_.HasTypedCRInCache

function _sdsDocument_.ChangeCRTypeToFullDocument(const aNode: INodeBase;
 aType: TlstCRType): Boolean;
//#UC START# *493E6F3602DD_493E5C580280_var*
var
 l_List          : IDynList;
 l_Count         : LongInt;
 l_MsgId         : TvcmMessageID;
 //l_AdapterMagID  : TvcmMessageID;
 l_Str           : IString;
 //l_MissingBlocks : Il3CString;
 l_Catalog: ICatalogBase;
 
 function lp_CheckListCount(aList: IDynList; out aListCount: LongInt): Boolean;
 // Проверка на слишком большое количества элементов списка
 // с побочным эффектом - вычисление собственно количества элементов
 var
  l_Root : INodeBase;
 begin//lp_CheckListCount
  Result := True;
  if Assigned(aList) then
  begin
   try
    aList.GetRoot(l_Root);
    aListCount := l_Root.GetChildCount;
   except
    on ECanNotFindData do
     aListCount := 0;
   end;//try..except
  end//Assigned(aList)
  else
   aListCount := 0;
  if (f_LockWarningCount = 0) and (aListCount > cMax_CR_List_Count) then
  begin
   // Предупреждение о слишком большом списке респондентов/корреспондентов
   if Assigned(aNode) and bsIsCRNodeAreNotAllDocuments(aNode) then
    Result := vcmAsk(qr_TooBigTypedCRList)
   else
    Result := vcmAsk(qr_TooBigCRList);
  end; // if (l_Count > cMax_CR_List_Count) then
 end;//lp_CheckListCount

//#UC END# *493E6F3602DD_493E5C580280_var*
begin
//#UC START# *493E6F3602DD_493E5C580280_impl*
 Result := False;
 l_List := nil;
 if not HasTypedCRInCache(aNode, aType) then
 begin
  case aType of
   crtCorrespondents:
    begin
     Result := pm_GetDocInfo.Doc.HasCorrespondents(aNode);
     l_MsgId := qr_TypedCorrespondentsListNotFound;
     //l_AdapterMagID := qr_TypedCOrrespondentsInOtherBlock;
    end;//crtCorrespondents
   crtRespondents:
    begin
     Result := pm_GetDocInfo.Doc.HasRespondents(aNode);
     l_MsgID := qr_TypedRespondentsListNotFound;
     //l_AdapterMagID := qr_TypedRespondentsInOtherBlock;
    end;//crtRespondents
  end;//case aType

  if Result then
  begin
   case aType of
    crtCorrespondents:
     pm_GetDocInfo.Doc.GetCorrespondents(aNode, l_Catalog);
    crtRespondents:
     pm_GetDocInfo.Doc.GetRespondents(aNode, l_Catalog);
   end;//case aType

   Supports(l_Catalog, IDynList, l_List);

   if not lp_CheckListCount(l_List, l_Count) then
    exit;

   if (l_List = nil) or
      (l_Count = 0) then
   begin
    if Assigned(aNode) then
    begin
     aNode.GetCaption(l_Str);
(*     l_MissingBlocks := defDataAdapter.GetMissingBlocksForCR(aNode);
     if not l3IsNil(l_MissingBlocks) then
     begin
      if vcmAsk(l_AdapterMagID, [nsCStr(l_Str), l_MissingBlocks, defDataAdapter.GetDealerInfo]) then
      begin
       Result := ChangeCRTypeToFullDocument(nil, aType);
       Exit;
      end;
     end//not l3IsNil(l_MissingBlocks)
     else*)
     if vcmAsk(l_MsgID, [nsCStr(l_Str)]) then
     begin
      Result := ChangeCRTypeToFullDocument(nil, aType);
      Exit;
     end;//vcmAsk(l_MsgID, [nsCStr(l_Str)])
    end;//Assigned(aNode)
    Exit;
   end;//l_List = nil..

   Result := inherited DoChangeCRType(aNode, aType, false);

   case aType of
    crtCorrespondents:
     SetData.CorrList := l_List;
    crtRespondents:
     SetData.RespList := l_List;
   end;//case aType
  end // if Result then
  else
  if Assigned(aNode) then
  begin
   aNode.GetCaption(l_Str);
   if vcmAsk(l_MsgId, [nsCStr(l_Str)]) then
   begin
    Result := ChangeCRTypeToFullDocument(nil, aType);
    Exit;
   end;//vcmAsk(l_MsgId, [nsCStr(l_Str)])
  end;//Assigned(aNode)
 end//not HasTypedCRInCache(aNode, aType)
 else
 begin
  case aType of
   crtCorrespondents:
    l_List := GetOrMakeCorrList;
   crtRespondents:
    l_List := GetOrMakeRespList;
  end;//case aType
  If not lp_CheckListCount(l_List, l_Count) then
   Exit;
  Result := True;
 end; // if not HasTypedCRInCache(aNode, aType) then

 if Result then
  case aType of
   crtCorrespondents:
   begin
    pm_GetDsCorrespondentsRef.Referred := nil;
    OpenCorrespondents;
   end;//crtCorrespondents
   crtRespondents:
   begin
    pm_GetDsRespondentsRef.Referred := nil;
    OpenRespondents;
   end;//crtRespondents
  end;//case aType
//#UC END# *493E6F3602DD_493E5C580280_impl*
end;//_sdsDocument_.ChangeCRTypeToFullDocument

function _sdsDocument_.ChangeCRTypeToPart(const aNode: INodeBase;
 aType: TlstCRType): Boolean;
//#UC START# *493E6F4901E6_493E5C580280_var*
var
 l_PosList: IPositionList;
//#UC END# *493E6F4901E6_493E5C580280_var*
begin
//#UC START# *493E6F4901E6_493E5C580280_impl*
 Result := False;
 case aType of
  crtCorrespondents:
   l_PosList := SetData.IncomingLinksToPartPosList;
  crtRespondents:
   l_PosList := SetData.OutgoingLinksFromPartPosList;
 end;
 if Assigned(l_PosList) then
 try
  Result := OpenCRToPart(l_PosList, aNode, aType);
 finally
  l_PosList := nil;
 end;
//#UC END# *493E6F4901E6_493E5C580280_impl*
end;//_sdsDocument_.ChangeCRTypeToPart

function _sdsDocument_.DoCanRunBaseSearch: Boolean;
//#UC START# *496F437400A6_493E5C580280_var*
//#UC END# *496F437400A6_493E5C580280_var*
begin
//#UC START# *496F437400A6_493E5C580280_impl*
 Result := True;
//#UC END# *496F437400A6_493E5C580280_impl*
end;//_sdsDocument_.DoCanRunBaseSearch

function _sdsDocument_.As_IucpDocumentWithContents: IucpDocumentWithContents;
 {* Метод приведения нашего интерфейса к IucpDocumentWithContents }
begin
 Result := Self;
end;//_sdsDocument_.As_IucpDocumentWithContents

function _sdsDocument_.As_InsWarningGenerator: InsWarningGenerator;
 {* Метод приведения нашего интерфейса к InsWarningGenerator }
begin
 Result := Self;
end;//_sdsDocument_.As_InsWarningGenerator

function _sdsDocument_.As_InsWarningLocker: InsWarningLocker;
 {* Метод приведения нашего интерфейса к InsWarningLocker }
begin
 Result := Self;
end;//_sdsDocument_.As_InsWarningLocker

function _sdsDocument_.As_IucpBaseSearchSupportQuery: IucpBaseSearchSupportQuery;
 {* Метод приведения нашего интерфейса к IucpBaseSearchSupportQuery }
begin
 Result := Self;
end;//_sdsDocument_.As_IucpBaseSearchSupportQuery

{$If NOT Defined(NoVCM)}
function _sdsDocument_.MakeData: _SetDataType_;
 {* Данные сборки. }
//#UC START# *47F3778403D9_493E5C580280_var*
//#UC END# *47F3778403D9_493E5C580280_var*
begin
//#UC START# *47F3778403D9_493E5C580280_impl*
 Result := TdDocument.Make;
 Result.dsWarningRef.NeedMake := vcm_nmYes;
 // Если справка есть, то она сразу открывается
 Result.dsRelatedDocRef.NeedMake := vcm_nmYes;
//#UC END# *47F3778403D9_493E5C580280_impl*
end;//_sdsDocument_.MakeData
{$IfEnd} // NOT Defined(NoVCM)

function _sdsDocument_.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_493E5C580280_var*
//#UC END# *4925B1EC0100_493E5C580280_var*
begin
//#UC START# *4925B1EC0100_493E5C580280_impl*
 Result := TdsDocument.Make(Self, DocumentData);
//#UC END# *4925B1EC0100_493E5C580280_impl*
end;//_sdsDocument_.BaseDocumentClass

procedure _sdsDocument_.OpenWarning;
 {* предупреждение }
//#UC START# *4937D8220142_493E5C580280_var*

 procedure ClearBaloons;
 begin//ClearBaloons
  if (f_dsBaloonWarning <> nil) then
   f_dsBaloonWarning.Referred := nil;
  if (f_dsTimeMachineWarning <> nil) then
   f_dsTimeMachineWarning.Referred := nil;
//  if (f_dsTranslationWarning <> nil) then
//   f_dsTranslationWarning.Referred := nil;
 end;//ClearBaloons

//#UC END# *4937D8220142_493E5C580280_var*
begin
//#UC START# *4937D8220142_493E5C580280_impl*
 ClearBaloons;
 // - чистим и баллоны тоже, т.к. надо будет перегенерировать из содержимое
 with SetData.dsWarningRef do
 begin
  Clear;
  NeedMake := vcm_nmForce;
 end;//with SetData.dsWarningRef
 Refresh;
//#UC END# *4937D8220142_493E5C580280_impl*
end;//_sdsDocument_.OpenWarning

procedure _sdsDocument_.OpenEditions;
 {* редакции }
//#UC START# *4937D83003DD_493E5C580280_var*
//#UC END# *4937D83003DD_493E5C580280_var*
begin
//#UC START# *4937D83003DD_493E5C580280_impl*
 SetData.dsEditionsRef.NeedMake := vcm_nmForce;
 Refresh;
//#UC END# *4937D83003DD_493E5C580280_impl*
end;//_sdsDocument_.OpenEditions

procedure _sdsDocument_.OpenSimilarDocuments;
 {* открыть список похожих документов }
//#UC START# *4937D83B0026_493E5C580280_var*
//#UC END# *4937D83B0026_493E5C580280_var*
begin
//#UC START# *4937D83B0026_493E5C580280_impl*
 SetData.dsSimilarDocumentsRef.Clear;
 SetData.dsSimilarDocumentsRef.NeedMake := vcm_nmForce;
 Refresh;
//#UC END# *4937D83B0026_493E5C580280_impl*
end;//_sdsDocument_.OpenSimilarDocuments

function _sdsDocument_.OpenCRToPart(const aPositionList: IPositionList;
 const aNode: INodeBase;
 aType: TlstCRType): Boolean;
 {* вызывается для открытия вкладки корреспондентов/респондентов к фрагменту }
//#UC START# *4937D85C028F_493E5C580280_var*
var
 l_List: IDynList;
 l_Root: INodeBase;
 l_Count: LongInt;
 l_MsgId: TvcmMessageID;
 l_Str: IString;
 l_Catalog: ICatalogBase;
 l_ViewAreaRef: IvcmViewAreaControllerRef;
//#UC END# *4937D85C028F_493E5C580280_var*
begin
//#UC START# *4937D85C028F_493E5C580280_impl*
 Result := False;
 try
  case aType of
   crtCorrespondents:
    begin
     if Assigned(aNode) then
      l_MsgID := inf_TypedCorrespondentsListToBlockNotFound
     else
      l_MsgID := inf_CorrespondentsListToBlockNotFound;
     pm_GetDocInfo.Doc.GetCorrespondentsToPart(aPositionList, aNode, l_Catalog);
    end;//crtCorrespondents
   crtRespondents:
    begin
     if Assigned(aNode) then
      l_MsgID := inf_TypedRespondentsListToBlockNotFound
     else
      l_MsgID := inf_RespondentsListToBlockNotFound;
     pm_GetDocInfo.Doc.GetRespondentsToPart(aPositionList, aNode, l_Catalog);
    end;//crtRespondents
  end;//case aType
  Supports(l_Catalog, IDynList, l_List);
  if Assigned(l_List) then
  begin
   try
    l_List.GetRoot(l_Root);
    l_Count := l_Root.GetChildCount;
   except
    on ECanNotFindData do
     l_Count := 0;
   end;//try..except
  end//Assigned(l_List)
  else
   l_Count := 0;
  if (l_Count <> 0) then
   with SetData do
   begin
    case aType of
     crtCorrespondents:
      begin
       IncomingLinksToPartFilter := aNode;
       IncomingLinksToPartList := l_List;
       IncomingLinksToPartPosList := aPositionList;
      end;
     crtRespondents:
      begin
       OutgoingLinksFromPartFilter := aNode;
       OutgoingLinksFromPartList := l_List;
       OutgoingLinksFromPartPosList := aPositionList;
      end;
     end;//case aType of
   end//with SetData
  else
  begin
   if Assigned(aNode) then
   begin
    aNode.GetCaption(l_Str);
    vcmSay(l_MsgID, [nsCStr(l_Str)]);
   end//Assigned(aNode)
   else
    vcmSay(l_MsgID);
   exit;
  end;//l_Count <> 0
 except
  on ECanNotFindData do
  begin
   if Assigned(aNode) then
   begin
    aNode.GetCaption(l_Str);
    vcmSay(l_MsgID, [nsCStr(l_Str)]);
   end//Assigned(aNode)
   else
    vcmSay(l_MsgID);
   exit;
  end;//on ECanNotFindData
 end;//try..except
 case aType of
  crtCorrespondents:
   l_ViewAreaRef := SetData.dsIncomingLinksToPartRef;
  crtRespondents:
   l_ViewAreaRef := SetData.dsOutgoingLinksFromPartRef;
 end;//case aType of
 Assert(l_ViewAreaRef <> nil);
 try
  l_ViewAreaRef.Clear;
  l_ViewAreaRef.NeedMake := vcm_nmForce;
 finally
  l_ViewAreaRef := nil;
 end;//try..finally
 Refresh;
 Result := True;
//#UC END# *4937D85C028F_493E5C580280_impl*
end;//_sdsDocument_.OpenCRToPart

function _sdsDocument_.ChangeRedaction(const aChangeWorker: IbsChangeRedactionWorker;
 const aPos: TbsDocPos): Boolean;
 {* изменить редакцию документа }
//#UC START# *4937D8F20041_493E5C580280_var*
var
 l_DocInfo : IdeDocInfo;
 l_Data    : IvcmData;
//#UC END# *4937D8F20041_493E5C580280_var*
begin
//#UC START# *4937D8F20041_493E5C580280_impl*
 Result := False;
 if pm_GetHasDocument then
 begin
  l_Data := SetData.Clone;
  try
   l_DocInfo := pm_GetDocInfo.Clone;
   try
    Result := aChangeWorker.Change(l_DocInfo);
    if Result then
     DoDoChangeDocument(l_DocInfo, aPos, True, l_Data);
   finally
    l_DocInfo := nil;
   end;//try..finally
  finally
   l_Data := nil;
  end;//try..finally
 end;//if pm_GetHasDocument then
//#UC END# *4937D8F20041_493E5C580280_impl*
end;//_sdsDocument_.ChangeRedaction

function _sdsDocument_.IsWarningNeeded: Boolean;
 {* показывает необходимо ли показывать для данного документа предупреждение }
//#UC START# *4937D90C03C6_493E5C580280_var*
//#UC END# *4937D90C03C6_493E5C580280_var*
begin
//#UC START# *4937D90C03C6_493E5C580280_impl*
 Result := pm_GetHasDocument and
          (pm_GetDocInfo.Doc.HasWarning or
           defDataAdapter.TimeMachine.HasTimeMachineWarning(pm_GetDocInfo.Doc) or
           not TdmStdRes.IsCurEditionActual(pm_GetDocInfo.Doc));
//#UC END# *4937D90C03C6_493E5C580280_impl*
end;//_sdsDocument_.IsWarningNeeded

function _sdsDocument_.HasTimeMachineWarning: Boolean;
 {* показывает есть ли к документу предупреждение от Машины времени }
//#UC START# *4937D92D01E9_493E5C580280_var*
//#UC END# *4937D92D01E9_493E5C580280_var*
begin
//#UC START# *4937D92D01E9_493E5C580280_impl*
 Result := pm_GetHasDocument and
           defDataAdapter.TimeMachine.IsOn and
           (defDataAdapter.TimeMachine.HasTimeMachineWarning(pm_GetDocInfo.Doc) or
            not TdmStdRes.IsCurEditionActual(pm_GetDocInfo.Doc));
//#UC END# *4937D92D01E9_493E5C580280_impl*
end;//_sdsDocument_.HasTimeMachineWarning

function _sdsDocument_.HasAnyRedaction: Boolean;
 {* показывает есть ли у документа не актуальные редакции }
//#UC START# *4937D93B01BC_493E5C580280_var*
//#UC END# *4937D93B01BC_493E5C580280_var*
begin
//#UC START# *4937D93B01BC_493E5C580280_impl*
 Result := pm_GetHasDocument and (pm_GetDocInfo.Doc.HasNextRedaction or
  pm_GetDocInfo.Doc.HasPrevRedaction);
//#UC END# *4937D93B01BC_493E5C580280_impl*
end;//_sdsDocument_.HasAnyRedaction

procedure _sdsDocument_.LockWarning;
//#UC START# *493E4E670017_493E5C580280_var*
//#UC END# *493E4E670017_493E5C580280_var*
begin
//#UC START# *493E4E670017_493E5C580280_impl*
 Inc(f_LockWarningCount);
//#UC END# *493E4E670017_493E5C580280_impl*
end;//_sdsDocument_.LockWarning

procedure _sdsDocument_.UnLockWarning;
//#UC START# *493E4E6E0115_493E5C580280_var*
//#UC END# *493E4E6E0115_493E5C580280_var*
begin
//#UC START# *493E4E6E0115_493E5C580280_impl*
 Dec(f_LockWarningCount);
//#UC END# *493E4E6E0115_493E5C580280_impl*
end;//_sdsDocument_.UnLockWarning

function _sdsDocument_.Generate(const aWarning: IdsWarning;
 const aGen: InevTagGenerator;
 aUserType: TvcmUserType): TWarningTypeSet;
 {* Результат сообщает о том, какие предупреждения есть у документа. Если нет ни одного предупреждения, то вернется cEmptyWarning }
//#UC START# *493E4F7E039B_493E5C580280_var*
var
  l_Doc : IDocument;
//#UC END# *493E4F7E039B_493E5C580280_var*
begin
//#UC START# *493E4F7E039B_493E5C580280_impl*
 // проверяем для исключения - http://mdp.garant.ru/pages/viewpage.action?pageId=325259961
 l_Doc := nil;
 if Assigned(aWarning.DocInfo) then
  l_Doc := aWarning.DocInfo.Doc;
 //
 Result := TnsDocumentWarningGenerator.Generate(aWarning,
                                                l_Doc,
                                                //pm_GetDocInfo.Doc,
                                                aGen, aUserType,
                                                Self.pm_GetDsDocument As IucpUnderControl);
//#UC END# *493E4F7E039B_493E5C580280_impl*
end;//_sdsDocument_.Generate

function _sdsDocument_.Get_CanRunBaseSearch: Boolean;
//#UC START# *496F344101D0_493E5C580280get_var*
//#UC END# *496F344101D0_493E5C580280get_var*
begin
//#UC START# *496F344101D0_493E5C580280get_impl*
 Result := DoCanRunBaseSearch;
//#UC END# *496F344101D0_493E5C580280get_impl*
end;//_sdsDocument_.Get_CanRunBaseSearch

function _sdsDocument_.pm_GetdsBaloonWarning: IdsWarning;
//#UC START# *4DA87F3D006B_493E5C580280get_var*
//#UC END# *4DA87F3D006B_493E5C580280get_var*
begin
//#UC START# *4DA87F3D006B_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DA87F3D006B_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsBaloonWarning

function _sdsDocument_.pm_GetdsTimeMachineWarning: IdsWarning;
//#UC START# *4DABF91B0274_493E5C580280get_var*
//#UC END# *4DABF91B0274_493E5C580280get_var*
begin
//#UC START# *4DABF91B0274_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DABF91B0274_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsTimeMachineWarning

function _sdsDocument_.pm_GetdsTranslationWarning: IdsWarning;
//#UC START# *4EDCF32E02FF_493E5C580280get_var*
//#UC END# *4EDCF32E02FF_493E5C580280get_var*
begin
//#UC START# *4EDCF32E02FF_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EDCF32E02FF_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsTranslationWarning

function _sdsDocument_.pm_GetdsCRBaloonWarning: IdsWarning;
//#UC START# *4EF486CE0310_493E5C580280get_var*
//#UC END# *4EF486CE0310_493E5C580280get_var*
begin
//#UC START# *4EF486CE0310_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EF486CE0310_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsCRBaloonWarning

function _sdsDocument_.pm_GetdsWarning: IdsWarning;
//#UC START# *500CED6C023C_493E5C580280get_var*
//#UC END# *500CED6C023C_493E5C580280get_var*
begin
//#UC START# *500CED6C023C_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CED6C023C_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsWarning

function _sdsDocument_.pm_GetdsIncomingLinksToPart: IdsDocumentList;
//#UC START# *500CED9B0156_493E5C580280get_var*
//#UC END# *500CED9B0156_493E5C580280get_var*
begin
//#UC START# *500CED9B0156_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CED9B0156_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsIncomingLinksToPart

function _sdsDocument_.pm_GetdsEditions: IdsEditions;
//#UC START# *500CEDBC03A5_493E5C580280get_var*
//#UC END# *500CEDBC03A5_493E5C580280get_var*
begin
//#UC START# *500CEDBC03A5_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CEDBC03A5_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsEditions

function _sdsDocument_.pm_GetdsContents: IdsBaseContents;
//#UC START# *500CEEBD01CB_493E5C580280get_var*
//#UC END# *500CEEBD01CB_493E5C580280get_var*
begin
//#UC START# *500CEEBD01CB_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *500CEEBD01CB_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsContents

function _sdsDocument_.pm_GetdsOutgoingLinksFromPart: IdsDocumentList;
//#UC START# *5236A4FB0320_493E5C580280get_var*
//#UC END# *5236A4FB0320_493E5C580280get_var*
begin
//#UC START# *5236A4FB0320_493E5C580280get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5236A4FB0320_493E5C580280get_impl*
end;//_sdsDocument_.pm_GetdsOutgoingLinksFromPart

procedure _sdsDocument_.OpenSimilarDocumentsToFragment(aBlockId: Integer);
//#UC START# *559510480014_493E5C580280_var*
//#UC END# *559510480014_493E5C580280_var*
begin
//#UC START# *559510480014_493E5C580280_impl*
 SetData.dsSimilarDocumentsToFragmentRef.Clear;
 SetData.dsSimilarDocumentsToFragmentRef.NeedMake := vcm_nmForce;
 SetData.SimilarDocumentsBlockId := aBlockId;
 Refresh;
//#UC END# *559510480014_493E5C580280_impl*
end;//_sdsDocument_.OpenSimilarDocumentsToFragment

procedure _sdsDocument_.FinishDataUpdate;
//#UC START# *47EA4E9002C6_493E5C580280_var*
  // Обнуление документа не нужно, т.к. вместо живого документа с адаптера
  // автоматически приедет NullDocument:
//#UC END# *47EA4E9002C6_493E5C580280_var*
begin
//#UC START# *47EA4E9002C6_493E5C580280_impl*
 inherited;
 ResetCacheAfterUpdate;
 ClearAllDS;
 Refresh;
//#UC END# *47EA4E9002C6_493E5C580280_impl*
end;//_sdsDocument_.FinishDataUpdate

{$If NOT Defined(NoVCM)}
procedure _sdsDocument_.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_493E5C580280_var*
//#UC END# *47F37DF001FE_493E5C580280_var*
begin
//#UC START# *47F37DF001FE_493E5C580280_impl*
 ChangeDocument(InitialUseCaseData);
//#UC END# *47F37DF001FE_493E5C580280_impl*
end;//_sdsDocument_.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function _sdsDocument_.GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
//#UC START# *491B02D80112_493E5C580280_var*
//#UC END# *491B02D80112_493E5C580280_var*
begin
//#UC START# *491B02D80112_493E5C580280_impl*
 Result := false;
 if (aDataSource <> nil) then
 begin
  Result := aDataSource.DocInfo.IsSame(Self.pm_GetDocInfo, True, False);
  if Result then
   Self.pm_GetDocInfo.Pos := aDataSource.DocInfo.Pos;
 end;//aDataSource <> nil
//#UC END# *491B02D80112_493E5C580280_impl*
end;//_sdsDocument_.GetIsNeedChangePosition
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _sdsDocument_.DoPushFromHistory;
 {* сборка была выгружена из истории }
//#UC START# *491B06F000BB_493E5C580280_var*

 procedure ClearBaloons;
 begin//ClearBaloons
  if (f_dsBaloonWarning <> nil) then
   f_dsBaloonWarning.Referred := nil;
  if (f_dsTimeMachineWarning <> nil) then
   f_dsTimeMachineWarning.Referred := nil;
  if (f_dsTranslationWarning <> nil) then
   f_dsTranslationWarning.Referred := nil;
 end;//ClearBaloons

//#UC END# *491B06F000BB_493E5C580280_var*
begin
//#UC START# *491B06F000BB_493E5C580280_impl*
 inherited;
 // Состояние машины времени изменилось нужно показать вкладку предупреждения:
 ClearBaloons;
 // - чистим и баллоны тоже, т.к. надо будет перегенерировать из содержимое
 if NeedDSWarning and SetData.dsWarningRef.IsEmpty then
  Refresh;
//#UC END# *491B06F000BB_493E5C580280_impl*
end;//_sdsDocument_.DoPushFromHistory
{$IfEnd} // NOT Defined(NoVCM)

procedure _sdsDocument_.ClearAllDS;
//#UC START# *4925B7F00156_493E5C580280_var*
//#UC END# *4925B7F00156_493E5C580280_var*
begin
//#UC START# *4925B7F00156_493E5C580280_impl*
 inherited;
 SetData.dsUserCR1Ref.Referred := nil;
 SetData.dsUserCR2Ref.Referred := nil;
 SetData.dsEditionsRef.Referred := nil;
 SetData.dsAnnotationRef.Referred := nil;
 SetData.dsIncomingLinksToPartRef.Referred := nil;
 SetData.dsOutgoingLinksFromPartRef.Referred := nil; 
 SetData.dsWarningRef.Referred := nil;
 if (f_dsBaloonWarning <> nil) then
  f_dsBaloonWarning.Referred := nil;
 if (f_dsTimeMachineWarning <> nil) then
  f_dsTimeMachineWarning.Referred := nil;
 if (f_dsTranslationWarning <> nil) then
  f_dsTranslationWarning.Referred := nil;
//#UC END# *4925B7F00156_493E5C580280_impl*
end;//_sdsDocument_.ClearAllDS

function _sdsDocument_.DoChangeDocument(const aDoc: IdeDocInfo): Boolean;
//#UC START# *4925B9370022_493E5C580280_var*
//#UC END# *4925B9370022_493E5C580280_var*
begin
//#UC START# *4925B9370022_493E5C580280_impl*
 Result := inherited DoChangeDocument(aDoc);
 ClearAllDS;
//#UC END# *4925B9370022_493E5C580280_impl*
end;//_sdsDocument_.DoChangeDocument

{$If NOT Defined(NoVCM)}
procedure _sdsDocument_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_493E5C580280_var*
//#UC END# *4938F7E702B7_493E5C580280_var*
begin
//#UC START# *4938F7E702B7_493E5C580280_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_493E5C580280_impl*
end;//_sdsDocument_.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

procedure _sdsDocument_.FillState;
//#UC START# *493D51ED0329_493E5C580280_var*

  procedure lpNeedMake(const aDSRef    : IvcmFormDataSourceRef;
                       const aProperty : AnsiString;
                       const aDefault  : Boolean);
  begin
   // Если пользователь самостоятельно открыл форму, далее в настройках выбрал
   // не открывать данную форму, то обновлении форма останется, закроется форма
   // открытая из настроек
   if aDSRef.NeedMake <> vcm_nmForce then
   begin
    aDSRef.Referred := nil;
    case afw.Settings.LoadBoolean(PAnsiChar(aProperty), aDefault) of
     True:
      aDSRef.NeedMake := vcm_nmYes;
     False:
      aDSRef.NeedMake := vcm_nmNo;
    end;//case GetBoolean(aProperty, aDefault) of
   end;//if aDSRef.NeedMake <> vcm_nmForce then
  end;//lpNeedMake

//#UC END# *493D51ED0329_493E5C580280_var*
begin
//#UC START# *493D51ED0329_493E5C580280_impl*
 inherited;
 // Авто открытие "Атрибуты документа"
 lpNeedMake(pm_GetdsAttributesRef, pi_Document_Sheets_Attributes,
  dv_Document_Sheets_Attributes);
 // Авто открытие "Редакции документа"
 lpNeedMake(SetData.dsEditionsRef, pi_Document_Sheets_Redactions,
  dv_Document_Sheets_Redactions);
//#UC END# *493D51ED0329_493E5C580280_impl*
end;//_sdsDocument_.FillState

function _sdsDocument_.DoChangeCRType(const aNode: INodeBase;
 aType: TlstCRType;
 IsCRToPart: Boolean): Boolean;
 {* вызывается при изменении типа корреспондентов/респондентов }
//#UC START# *493D6B5B02DE_493E5C580280_var*
//#UC END# *493D6B5B02DE_493E5C580280_var*
begin
//#UC START# *493D6B5B02DE_493E5C580280_impl*
 if not IsCRToPart then
  Result := ChangeCRTypeToFullDocument(aNode, aType)
 else
  Result := ChangeCRTypeToPart(aNode, aType);
//#UC END# *493D6B5B02DE_493E5C580280_impl*
end;//_sdsDocument_.DoChangeCRType

{$If NOT Defined(NoVCM)}
function _sdsDocument_.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_493E5C580280_var*
const
 cDocImagesArr: array[TRedactionType] of TnsTabIconType = (titDocumentNormal,
  titDocumentAbolished, titDocumentPreactive, titDocumentNewRedaction,
  titDocumentNewRedaction, titDocumentNewRedaction, titDocumentNewRedaction);
var
 l_DocumentType: TDocumentType;
 l_RedactionType: TRedactionType;
 l_Doc: IDocument;
 l_State: IDocumentState;
 l_RI: TRedactionInfo;
//#UC END# *53B3BF9C00EF_493E5C580280_var*
begin
//#UC START# *53B3BF9C00EF_493E5C580280_impl*
 Result := 0;
 l_Doc := pm_GetDocInfo.Doc;
 if (l_Doc <> nil) then
 try
  l_DocumentType := l_Doc.GetDocType;
  case l_DocumentType of
   DT_BOOK:
    Result := nsTabIconIndex(titDocumentNormal);
   DT_DOCUMENT, DT_FLASH:
    begin
     l_Doc.GetCurrentState(l_State);
     if (l_State <> nil) then
     try
      l3FillChar(l_RI, SizeOf(l_RI), 0);
      l_State.GetCurrentRedaction(l_RI);
      l_RedactionType := l_RI.rActualType;
      Result := nsTabIconIndex(cDocImagesArr[l_RedactionType]);
     finally
      l_State := nil;
     end;//try..finally
    end;
  DT_ACTUAL_ANALYTICS, DT_ACTUAL_ANALYTICS_CONTENTS:
    Result := nsTabIconIndex(titAAC);
  end;
 finally
  l_Doc := nil;
 end;//try..finally
//#UC END# *53B3BF9C00EF_493E5C580280_impl*
end;//_sdsDocument_.DoGetFormSetImageIndex
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$EndIf sdsDocument_imp_impl}

{$EndIf sdsDocument_imp}

