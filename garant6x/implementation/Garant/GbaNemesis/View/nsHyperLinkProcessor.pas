unit nsHyperLinkProcessor;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsHyperLinkProcessor.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsHyperLinkProcessor" MUID: (4A8199550084)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nevNavigation
 , NavigationInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentUnit
 , afwInterfaces
;

function nsProcessHyperLink(const aHyperLink: IevHyperlink;
 inNewWindow: Boolean;
 const aHelper: IbsHyperLinkProcessorHelper;
 const anAggregate: IvcmAggregate;
 const aDocument: IDocument): Boolean; overload;
procedure nsCheckHyperLinkInfo(const aHyperLink: IevHyperlink;
 const aHelper: IbsHyperLinkProcessorHelper;
 var theInfo: TafwCursorInfo;
 const aDocument: IDocument = nil);
procedure nsSaveHyperLinkExternalObject(const aHyperLink: IevHyperlink;
 const aHelper: IbsHyperLinkProcessorHelper;
 const aDocument: IDocument = nil);
function nsProcessHyperLink(const aHyperLink: IevHyperlink;
 aBehaviour: TbsProcessHyperLinkBehaviour;
 const aHelper: IbsHyperLinkProcessorHelper;
 const anAggregate: IvcmAggregate;
 const aDocument: IDocument): Boolean; overload;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , bsHyperLinkProcessorPrim
 , DocumentDomainInterfaces
 , DynamicDocListUnit
 , ExternalObjectUnit
 , SearchUnit
 , ExternalOperationUnit
 , bsTypesNew
 {$If NOT Defined(NoScripts)}
 , tfwScriptEngine
 {$IfEnd} // NOT Defined(NoScripts)
 , nsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , bsDocumentMissingMessage
 , BaseTypesUnit
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , nsUtils
 , bsTypes
 , nsExternalObjectPrim
 , nsExternalObjectModelPart
 , nsQueryUtils
 , DocumentInterfaces
 , Base_Operations_Editions_Controls
 , DocumentAndListInterfaces
 , Base_Operations_Strange_Controls
 , nsExternalObjectData
 , bsUtils
 , nsENOIntegration
 , evdTypes
 , l3String
 , nsTypes
 , WarningConst
 , l3Types
 , LoggingUnit
 , nsHyperlinkProcessorTypes
 , bsHyperlinkProcessorContainerMaker
 , nsOpenDocumentFromLinkEvent
 , nsTryingToOpenMissingDocumentFromLinkEvent
 , Base_Operations_F1Services_Contracts
 //#UC START# *4A8199550084impl_uses*
 //#UC END# *4A8199550084impl_uses*
;

type
 TNewWindowBehaviourArr = array [Boolean] of TbsProcessHyperLinkBehaviour;

 TbsHyperLinkProcessor = class(TbsHyperLinkProcessorPrim)
  private
   f_Document: IDocument;
   f_HyperLink: IevHyperlink;
   f_Helper: IbsHyperLinkProcessorHelper;
   f_Aggregate: IvcmAggregate;
  private
   procedure GetLinkedObj(out anObjType: TLinkedObjectType;
    out anObject: IUnknown);
   procedure ConvertHyperlink(out aTopic: TTopic;
    out aRID: TRedactionID);
   procedure OpenExternalObject(const aExternalObject: InsLinkedObjectData;
    aBehaviour: TbsProcessHyperLinkBehaviour);
   procedure OpenMultiLink(const aList: IDynList;
    aBehaviour: TbsProcessHyperLinkBehaviour);
   procedure OpenExternalLink(const aExternalLink: IExternalLink;
    aBehaviour: TbsProcessHyperLinkBehaviour);
   procedure OpenQueryLink(const aQuery: IQuery;
    aBehaviour: TbsProcessHyperLinkBehaviour);
   procedure OpenAutoreferatLink(const aDocument: IDocument;
    aBehaviour: TbsProcessHyperLinkBehaviour);
   procedure OpenExternalOperationLink(const aExternalOperation: IExternalOperation);
   procedure OpenDocumentLink(const aDocument: IDocument;
    aSub: Cardinal;
    aBehaviour: TbsProcessHyperLinkBehaviour;
    aNeedCorrectRedaction: Boolean;
    aForceOpen: Boolean = False;
    aPointType: TDocumentPositionType = bsTypesNew.dptSub);
   function GetContainer(aBehaviour: TbsProcessHyperLinkBehaviour): IvcmContainer;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aHyperLink: IevHyperlink;
    const aHelper: IbsHyperLinkProcessorHelper;
    const anAggregate: IvcmAggregate;
    const aDocument: IDocument); reintroduce;
   function OpenHyperLink(inNewWindow: Boolean): Boolean; overload;
   procedure GetInfo(var theInfo: TafwCursorInfo);
   procedure SaveExternalObject;
   function OpenHyperLink(aBehaviour: TbsProcessHyperLinkBehaviour): Boolean; overload;
 end;//TbsHyperLinkProcessor

const
 cNewWindowBehaviourMap: TNewWindowBehaviourArr = (phbInSameContainer, phbInNewWindow);

function nsProcessHyperLink(const aHyperLink: IevHyperlink;
 inNewWindow: Boolean;
 const aHelper: IbsHyperLinkProcessorHelper;
 const anAggregate: IvcmAggregate;
 const aDocument: IDocument): Boolean;
//#UC START# *4C7F905401FD_4A8199550084_var*
//#UC END# *4C7F905401FD_4A8199550084_var*
begin
//#UC START# *4C7F905401FD_4A8199550084_impl*
 Result := nsProcessHyperLink(aHyperLink, cNewWindowBehaviourMap[inNewWindow],
  aHelper, anAggregate, aDocument);
//#UC END# *4C7F905401FD_4A8199550084_impl*
end;//nsProcessHyperLink

procedure nsCheckHyperLinkInfo(const aHyperLink: IevHyperlink;
 const aHelper: IbsHyperLinkProcessorHelper;
 var theInfo: TafwCursorInfo;
 const aDocument: IDocument = nil);
//#UC START# *51AF1F7202F8_4A8199550084_var*
var
 l_Processor: TbsHyperLinkProcessor;
//#UC END# *51AF1F7202F8_4A8199550084_var*
begin
//#UC START# *51AF1F7202F8_4A8199550084_impl*
 l_Processor := TbsHyperLinkProcessor.Create(aHyperLink, aHelper, nil, aDocument);
 try
  l_Processor.GetInfo(theInfo);
 finally
  FreeAndNil(l_Processor);
 end;
//#UC END# *51AF1F7202F8_4A8199550084_impl*
end;//nsCheckHyperLinkInfo

procedure nsSaveHyperLinkExternalObject(const aHyperLink: IevHyperlink;
 const aHelper: IbsHyperLinkProcessorHelper;
 const aDocument: IDocument = nil);
//#UC START# *51AF250D0230_4A8199550084_var*
var
 l_Processor: TbsHyperLinkProcessor;
//#UC END# *51AF250D0230_4A8199550084_var*
begin
//#UC START# *51AF250D0230_4A8199550084_impl*
 l_Processor := TbsHyperLinkProcessor.Create(aHyperLink, aHelper, nil, aDocument);
 try
  l_Processor.SaveExternalObject;
 finally
  FreeAndNil(l_Processor);
 end;
//#UC END# *51AF250D0230_4A8199550084_impl*
end;//nsSaveHyperLinkExternalObject

function nsProcessHyperLink(const aHyperLink: IevHyperlink;
 aBehaviour: TbsProcessHyperLinkBehaviour;
 const aHelper: IbsHyperLinkProcessorHelper;
 const anAggregate: IvcmAggregate;
 const aDocument: IDocument): Boolean;
//#UC START# *53A920C400E4_4A8199550084_var*
var
 l_Processor: TbsHyperLinkProcessor;
//#UC END# *53A920C400E4_4A8199550084_var*
begin
//#UC START# *53A920C400E4_4A8199550084_impl*
 Result := False;
 l_Processor := TbsHyperLinkProcessor.Create(aHyperLink, aHelper, anAggregate, aDocument);
 try
  Result := l_Processor.OpenHyperLink(aBehaviour);
 finally
  FreeAndNil(l_Processor);
 end;
//#UC END# *53A920C400E4_4A8199550084_impl*
end;//nsProcessHyperLink

procedure TbsHyperLinkProcessor.GetLinkedObj(out anObjType: TLinkedObjectType;
 out anObject: IUnknown);
//#UC START# *51AF288F01AD_4B0A77F30378_var*
var
 l_Topic : TTopic;
 l_RID   : TRedactionID;
 l_MI    : IMissingInfo;
//#UC END# *51AF288F01AD_4B0A77F30378_var*
begin
//#UC START# *51AF288F01AD_4B0A77F30378_impl*
 ConvertHyperlink(l_Topic, l_RID);
 try
  f_Document.GetLinkedObject(f_Hyperlink.FromDocumentExternalHandle,
                             l_Topic,
                             l_RID,
                             anObjType,
                             anObject);

  // http://mdp.garant.ru/pages/viewpage.action?pageId=337510681 
(*  if anObject = nil then
    raise Exception.Create('Показываем сообщение, что документ отсутствует в базе');*)

 except
//  on ENotAllowedInTrialMode do
//   vcmSay(war_NotAllowedInTrialMode, [defDataAdapter.GetDealerInfo]);
  on EFolderLinkNotFound do
   vcmSay(war_GotoOnMissingBookmark);
  on ERangeError do
  begin
   Assert(false, 'Как всегда забыт f_Hyperlink.FromDocumentExternalHandle');
   raise;
  end;//ERangeError
  on E: Exception do
  begin
   //http://mdp.garant.ru/pages/viewpage.action?pageId=497003433
   TnsTryingToOpenMissingDocumentFromLinkEvent.Log(l_Topic);
   f_Document.GetMissingInfoForObject(l_Topic.rPid, l_MI);
   TbsDocumentMissingMessage.Show(True, l_MI);
  end;//E: Exception
  else
   Assert(false, 'Странное исключение прилетело с адаптера');
 end;//try..except
//#UC END# *51AF288F01AD_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.GetLinkedObj

procedure TbsHyperLinkProcessor.ConvertHyperlink(out aTopic: TTopic;
 out aRID: TRedactionID);
//#UC START# *51AF28B10028_4B0A77F30378_var*
//#UC END# *51AF28B10028_4B0A77F30378_var*
begin
//#UC START# *51AF28B10028_4B0A77F30378_impl*
 if f_Hyperlink <> nil then
 begin
  with aTopic do
  begin
   rPid.rObjectId := TObjectId(f_Hyperlink.TargetDocumentID);
   rPid.rClassId := TClassId(f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID);
   rPosition.rPoint := Cardinal(f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.SubID);
   rPosition.rType := PT_SUB;
  end;
  aRID := f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.RevisionID;
 end
 else
 begin
  l3FillChar(aTopic, SizeOf(TTopic));
  aRID := 0;
 end;
//#UC END# *51AF28B10028_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.ConvertHyperlink

procedure TbsHyperLinkProcessor.OpenExternalObject(const aExternalObject: InsLinkedObjectData;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *51AF29070012_4B0A77F30378_var*
var
 l_Container: IvcmContainer;
//#UC END# *51AF29070012_4B0A77F30378_var*
begin
//#UC START# *51AF29070012_4B0A77F30378_impl*
 if (vcmDispatcher <> nil) then
  if (aBehaviour in [phbInNewWindow, phbInNewTabNoActivate, phbInNewTabActivate]) and
     (aExternalObject.IsPicture) then
  begin
   // http://mdp.garant.ru/pages/viewpage.action?pageId=414849606
   l_Container := GetContainer(aBehaviour);
   // - http://mdp.garant.ru/pages/viewpage.action?pageId=565265761
   if (l_Container <> nil) then
   try
    TDocumentService.Instance.OpenExternalObject(l_Container, aExternalObject);
   finally
    l_Container := nil;
   end;
  end
  else
   TDocumentService.Instance.OpenExternalObject(nil, aExternalObject);
//#UC END# *51AF29070012_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenExternalObject

procedure TbsHyperLinkProcessor.OpenMultiLink(const aList: IDynList;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *51AF293B00F7_4B0A77F30378_var*
var
 l_Cont: IvcmContainer;
//#UC END# *51AF293B00F7_4B0A77F30378_var*
begin
//#UC START# *51AF293B00F7_4B0A77F30378_impl*
 l_Cont := GetContainer(aBehaviour);
 if (l_Cont = nil) then
  Exit;
 nsOpenList(aList, l_Cont, wdOpenIfUserDefine, False, lofMultilink);
//#UC END# *51AF293B00F7_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenMultiLink

procedure TbsHyperLinkProcessor.OpenExternalLink(const aExternalLink: IExternalLink;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *51AF296C01DD_4B0A77F30378_var*
var
 l_ContainerMaker: IvcmContainerMaker;
//#UC END# *51AF296C01DD_4B0A77F30378_var*
begin
//#UC START# *51AF296C01DD_4B0A77F30378_impl*
 l_ContainerMaker := TbsHyperlinkProcessorContainerMaker.Make(aBehaviour, f_Helper);
 try
  nsExecuteExternalLinkEx(aExternalLink, l_ContainerMaker);
 finally
  l_ContainerMaker := nil;
 end;
//#UC END# *51AF296C01DD_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenExternalLink

procedure TbsHyperLinkProcessor.OpenQueryLink(const aQuery: IQuery;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *51AF299202E3_4B0A77F30378_var*
var
 l_List: IDynList;
//#UC END# *51AF299202E3_4B0A77F30378_var*
begin
//#UC START# *51AF299202E3_4B0A77F30378_impl*
 if (aBehaviour <> phbInSameContainer) then
  nsSearch(aQuery, nil, nil, GetContainer(aBehaviour))
 else
 begin
  l_List := nsSearchExecute(aQuery);
  if Assigned(l_List) then
  try
   OpenMultiLink(l_List, aBehaviour);
  finally
   l_List := nil;
  end;//try..finally
 end;//not inNewWindow
//#UC END# *51AF299202E3_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenQueryLink

procedure TbsHyperLinkProcessor.OpenAutoreferatLink(const aDocument: IDocument;
 aBehaviour: TbsProcessHyperLinkBehaviour);
//#UC START# *51AF29C30280_4B0A77F30378_var*
var
 l_Document : IDocument;
 l_DocInfo  : IdeDocInfo;
 l_Container : IvcmContainer;
//#UC END# *51AF29C30280_4B0A77F30378_var*
begin
//#UC START# *51AF29C30280_4B0A77F30378_impl*
 if Assigned(aDocument) then
 begin
  l_Container := GetContainer(aBehaviour);
  try
   TMonitoringsService.Instance.OpenAutoreferat(aDocument, l_Container);
  finally
   l_Container := nil;
  end;
 end;//aDocument <> nil
//#UC END# *51AF29C30280_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenAutoreferatLink

procedure TbsHyperLinkProcessor.OpenExternalOperationLink(const aExternalOperation: IExternalOperation);
//#UC START# *51AF2A1101C6_4B0A77F30378_var*
//#UC END# *51AF2A1101C6_4B0A77F30378_var*
begin
//#UC START# *51AF2A1101C6_4B0A77F30378_impl*
 if not f_Helper.ProcessExternalOperation(aExternalOperation) then
  vcmSay(inf_UnsupportedLink);
//#UC END# *51AF2A1101C6_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenExternalOperationLink

procedure TbsHyperLinkProcessor.OpenDocumentLink(const aDocument: IDocument;
 aSub: Cardinal;
 aBehaviour: TbsProcessHyperLinkBehaviour;
 aNeedCorrectRedaction: Boolean;
 aForceOpen: Boolean = False;
 aPointType: TDocumentPositionType = bsTypesNew.dptSub);
//#UC START# *51AF2A2E0257_4B0A77F30378_var*
  function lpDocInfo(const aData: IdeDocInfo): Boolean;
  {* При открытии ссылки на документ. }
  var
   lLink : IExternalLink;
   l_ContainerMaker: IvcmContainerMaker;
  begin
   Result := False;
   with aData do
   begin
    case Doc.GetDocType of
     DT_BOOK:
      if Pos.rRefType = dptSub then
      begin
       Doc.GetInternetImageUrl(Longint(Pos.rPos), lLink);
       if Assigned(lLink) then
       try
        l_ContainerMaker := TbsHyperlinkProcessorContainerMaker.Make(aBehaviour, f_Helper);
        try
         nsExecuteExternalLinkEx(lLink, l_ContainerMaker);
        finally
         l_ContainerMaker := nil;
        end;
        Result := True;
       finally
        lLink := nil;
       end;//if Assigned(lLink) then
      end;//Pos.rRefType = dptSub
    end;//case Doc.GetDocType of
   end;//with aData do
  end;//lpDocInfo

var
 l_Document : IDocument;
 l_DocInfo  : IdeDocInfo;
 l_Cont: IvcmContainer;
//#UC END# *51AF2A2E0257_4B0A77F30378_var*
begin
//#UC START# *51AF2A2E0257_4B0A77F30378_impl*
 if Assigned(aDocument) then
 begin
  if (f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.DocID = 0) or
      aDocument.IsSameDocument(f_Document) then
  begin
   if (not aForceOpen) and f_Helper.ProcessLocalLink(aDocument, aPointType, aSub, aBehaviour) then
    Exit;
   if (aDocument.GetDocType = DT_BOOK) then
   begin
    lpDocInfo(f_Helper.MakeLinkDocInfo(aDocument, aPointType, aSub));
    Exit;
   end;//aDocument.GetDocType = DT_BOOK
  end;

  if aNeedCorrectRedaction then
   l_Document := defDataAdapter.TimeMachine.CorrectDocumentEdition(aDocument)
  else
   l_Document := aDocument;
  if Assigned(l_Document) then
  begin
   if f_Helper.ProcessGlobalLink(aDocument, aPointType, aSub, aBehaviour) then
    Exit;

   l_DocInfo := f_Helper.MakeLinkDocInfo(l_Document, aPointType, aSub);
   Assert(Assigned(l_DocInfo));

   if (aBehaviour <> phbInNewWindow) then
    if l_Document.GetDocType in [DT_DOCUMENT,
                                 DT_FLASH,
                                 DT_ACTUAL_ANALYTICS,
                                 DT_ACTUAL_ANALYTICS_CONTENTS] then
     TnsOpenDocumentFromLinkEvent.Log(l_DocInfo);
   l_Cont := GetContainer(aBehaviour);
   try
    if (l_Cont <> nil) then
     TDocumentService.Instance.OpenDocument(l_DocInfo, l_Cont);      
   finally
    l_Cont := nil;
   end;
  end;//Assigned(l_Document)
 end;//aDocument <> nil
//#UC END# *51AF2A2E0257_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenDocumentLink

constructor TbsHyperLinkProcessor.Create(const aHyperLink: IevHyperlink;
 const aHelper: IbsHyperLinkProcessorHelper;
 const anAggregate: IvcmAggregate;
 const aDocument: IDocument);
//#UC START# *51AF2ABC0119_4B0A77F30378_var*
var
 l_Handle: Integer;
 l_MissingInfo: IMissingInfo;
//#UC END# *51AF2ABC0119_4B0A77F30378_var*
begin
//#UC START# *51AF2ABC0119_4B0A77F30378_impl*
 inherited Create;
 Assert(Assigned(aHyperLink));
 Assert(Assigned(aHelper));
 f_HyperLink := aHyperLink;
 f_Helper := aHelper;
 f_Document := aDocument;
 f_Aggregate := anAggregate;
 if (f_Document = nil) then
 begin
  l_Handle := aHyperLink.FromDocumentExternalHandle;
  if (l_Handle <> -1) then
   defDataAdapter.CommonInterfaces.GetDocumentOnNumber(l_Handle, f_Document, l_MissingInfo);
 end;//f_Document = nil
//#UC END# *51AF2ABC0119_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.Create

function TbsHyperLinkProcessor.OpenHyperLink(inNewWindow: Boolean): Boolean;
//#UC START# *51AF2B2A029F_4B0A77F30378_var*
//#UC END# *51AF2B2A029F_4B0A77F30378_var*
begin
//#UC START# *51AF2B2A029F_4B0A77F30378_impl*
 Result := OpenHyperLink(cNewWindowBehaviourMap[inNewWindow]);
//#UC END# *51AF2B2A029F_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenHyperLink

procedure TbsHyperLinkProcessor.GetInfo(var theInfo: TafwCursorInfo);
//#UC START# *51AF2B4C01A8_4B0A77F30378_var*
 function CalcKind(const aSource: TafwCursorShape; const aKind: TevLinkViewKind): TafwCursorShape;
 begin//on ERangeError
  Result := aSource;
  case aKind of
   ev_lvkInternalInvalid:
    Result := ev_csInvalidHand;
   ev_lvkExternal:
    Result := ev_csExternalHand;
   ev_lvkInternalAbolished:
    Result := ev_csAbolishedHand;
   ev_lvkInternalPreactive:
    Result := ev_csPreactiveHand;
   ev_lvkExternalENO:
    Result := ev_csExternalENO;
   ev_lvkInternalEdition:
    Result := ev_csTimeMachineHand;
  end; //case aKind
 end;//on ERangeError

var
 l_RID       : TRedactionID;
 l_Topic     : TTopic;
 l_Info      : TLinkInfo;
 
const
 lc_Map: array [TLinkKind] of TevLinkViewKind = (
   ev_lvkInternalInvalid,
   ev_lvkInternalValid,
   ev_lvkExternal,
   ev_lvkInternalAbolished,
   ev_lvkInternalPreactive,
   ev_lvkExternalENO,
   ev_lvkInternalEdition,
   ev_lvkScript
 );
//#UC END# *51AF2B4C01A8_4B0A77F30378_var*
begin
//#UC START# *51AF2B4C01A8_4B0A77F30378_impl*
 if (f_Hyperlink.Kind <> ev_lvkShellInternal) then
  if {(f_Hyperlink.Kind = ev_lvkUnknown) or} l3IsNil(f_Hyperlink.Hint) then
  begin
   if (f_Hyperlink.Kind = ev_lvkUnknown) then
   begin
    if (f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = 0) then
    begin
     if not l3IsNil(f_Hyperlink.URL) then
     case f_Hyperlink.ID of
      Ord(cTimeMachineOff_LinkHandle):
      begin
       f_Hyperlink.Kind := ev_lvkInternalValid;
       theInfo.rHint := str_wgTimeMachineOffHint.AsCStr;
       Exit;
      end;//Ord(cTimeMachineOff_LinkHandle)
      Ord(cNotSure_LinkHandle):
      begin
       f_Hyperlink.Kind := ev_lvkInternalValid;
       theInfo.rHint := str_wgJurorCommentHint.AsCStr;
       Exit;
      end;//Ord(cNotSure_LinkHandle)
     end;//case f_Hyperlink.ID
    end;//f_Hyperlink.Address.TypeID = 0
   end;
   if Assigned(f_Document) then
   begin
    with f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf} do
    begin
     with l_Topic do
     begin
      with rPid do
      begin
       try
        rObjectId := DocID;
        rClassId := TypeID;
       except
        on ERangeError do
        begin
         theInfo.rHint := nsCStr(f_Hyperlink.Hint);
         Exit;
        end;//on ERangeError
       end;//try..except
      end;//with rPid
      with rPosition do
      begin
       rPoint := Cardinal(SubID);
       rType := PT_SUB;
       end;//with rPosition
     end;//with l_Topic
     l_RID := RevisionID;
    end;//with f_Hyperlink.Address
    try
     f_Document.GetLinkInfo(f_Hyperlink.FromDocumentExternalHandle,
      l_Topic, l_RID, l_Info);
     Assert(Ord(l_Info.rKind) >= Ord(Low(l_Info.rKind)));
     Assert(Ord(l_Info.rKind) <= Ord(High(l_Info.rKind)));
     f_Hyperlink.Hint := Tl3PCharLen(nsWStr(l_Info.rHint));
     f_Hyperlink.Kind := lc_Map[l_Info.rKind];
     f_Helper.CheckLinkInfo(f_Hyperlink);
    except
     on ERangeError do
     begin
      theInfo.rHint := nsCStr(f_Hyperlink.Hint);
      if not l3IsNil(f_Hyperlink.URL) then
       f_Hyperlink.Kind := ev_lvkInternalValid
      else
       f_Hyperlink.Kind := ev_lvkInternalInvalid;
     end;//on ERangeError
     on ECanNotFindData do
      ;
     on EFolderLinkNotFound do
      ;
    end;//try..except
   end//Assigned(f_Document)
   else
   begin
    f_Hyperlink.Hint := Tl3PCharLen(nsWStr(vcmCStr(str_UnsupportedLink)));
    f_Hyperlink.Kind := ev_lvkInternalInvalid;
   end;//Assigned(f_Document)
  end;//f_Hyperlink.Kind = ev_lvkUnknown
 theInfo.rHint := nsCStr(f_Hyperlink.Hint);
 theInfo.rCursor := CalcKind(theInfo.rCursor, f_Hyperlink.Kind);
//#UC END# *51AF2B4C01A8_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.GetInfo

procedure TbsHyperLinkProcessor.SaveExternalObject;
//#UC START# *51AF2B68026D_4B0A77F30378_var*
var
 l_LinkedObj : IUnknown;
 l_ObjType   : TLinkedObjectType;
//#UC END# *51AF2B68026D_4B0A77F30378_var*
begin
//#UC START# *51AF2B68026D_4B0A77F30378_impl*
 GetLinkedObj(l_ObjType, l_LinkedObj);
 try
  nsSaveExternalObject(l_LinkedObj, l_ObjType);
 finally
  l_LinkedObj := nil;
 end;{try..finally}
//#UC END# *51AF2B68026D_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.SaveExternalObject

function TbsHyperLinkProcessor.OpenHyperLink(aBehaviour: TbsProcessHyperLinkBehaviour): Boolean;
//#UC START# *53A92141005B_4B0A77F30378_var*
var
 l_ObjType           : TLinkedObjectType;
 l_LinkedObj         : IUnknown;
 l_List              : IDynList;
 l_Document          : IDocument;
 l_Query             : IQuery;
 l_ExternalObject    : IExternalObject;
 l_ExternalLink      : IExternalLink;
 l_ExternalOperation : IExternalOperation;
 l_Bookmark          : IBookmark;
 l_SubID             : Integer;
//#UC END# *53A92141005B_4B0A77F30378_var*
begin
//#UC START# *53A92141005B_4B0A77F30378_impl*
 Result := True;
 if (f_Hyperlink <> nil) then
 begin
  if OpenURL(f_Hyperlink.URL) then
  begin
   l_SubID := f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.SubID;
   if (l_SubID <> 0) then
   begin
    if (l_SubID > 0) then
    // http://mdp.garant.ru/pages/viewpage.action?pageId=290271457&focusedCommentId=290950421&#comment-290950421
    begin
     //Application.CallActionIdle; ?
     Op_Document_SetPosition.Call(vcmDispatcher.ActiveEntity.AsForm.Aggregate,
                                  l_SubID);
    end;//l_SubID > 0
   end;//f_Hyperlink.Address.SubID <> 0
   Exit;
  end;//OpenURL(f_Hyperlink.URL)
  if (f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.TypeID = 0) then
  begin
   if (f_Aggregate <> nil) then
   begin
    Case f_Hyperlink.ID of
     Ord(cTimeMachineOff_LinkHandle):
     begin
      op_TimeMachine_TimeMachineOffAndReset.Call(f_Aggregate);
      Result := true;
      Exit;
     end;//cTimeMachineOff_LinkHandle
     Ord(cNotSure_LinkHandle):
     begin
      op_Document_OpenNotSureTopic.Call(f_Aggregate);
      Result := true;
      Exit;
     end;//cNotSure_LinkHandle
     Ord(cSwitchFiltersOff_LinkHandle):
     begin
      op_Filters_InternalClear.Call(f_Aggregate);
      Result := true;
      Exit;
     end;//Ord(cSwitchFiltersOff_LinkHandle):
     Ord(cTimeMachineChangeDateOrOff_LinkHandle):
     begin
      vcmDispatcher.EntityOperation(opcode_TimeMachine_TimeMachineOnOffNew, vcmParams);
      //f_Aggregate.Operation(opcode_TimeMachine_TimeMachineOnOffNew);
      Result := true;
      Exit;
     end;//Ord(TimeMachineChangeDateOrOff_LinkHandle)
     else
     begin
 (*      Assert(false);
      Result := false;*)
     end;//else
    end;//Case f_Hyperlink.ID
   end//f_Aggregate <> nil
   else
    Case f_Hyperlink.ID of
     Ord(cUnreadConsultations_LinkHandle):
     begin
      TFoldersService.Instance.TryOpenConsultationAnswer(nil);
      Result := true;
      Exit;
     end;//Ord(cUnreadConsultations_LinkHandle)
     else
     begin
 (*      Assert(false);
      Result := false;*)
     end;//else
    end;//Case f_Hyperlink.ID
  end;//f_Hyperlink.Address.TypeID = 0
  if f_Document = nil then
   Exit;

  GetLinkedObj(l_ObjType, l_LinkedObj);

  if l_LinkedObj <> nil then
  begin
   case l_ObjType of
    // Документ.
    LO_DOCUMENT :
     if Supports(l_LinkedObj, IDocument, l_Document) then
      try
{       if IsHyperlinkLocal(aHyperlink) AND
          not (TTextFormUT(UserType) in [dftDocSynchroView, dftRelatedSynchroView, dftMedicFirmSynchroView]) then
        OpenDocumentLocalLink(l_Document, Longword(aHyperlink.Address.SubID), l_Params, inNewWindow)
       else}
        OpenDocumentLink(l_Document, Cardinal(f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.SubID), aBehaviour,
                        f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.RevisionID = 0);
      finally
       l_Document := nil;
      end;//try..finally
    // Справка к документу.
    LO_RELATED_DOCUMENT : ;
    // Встроенный объект.
    LO_EXTERNAL_OBJECT :
     if Supports(l_LinkedObj, IExternalObject, l_ExternalObject) then
      try
       OpenExternalObject(TnsExternalObjectData.Make(f_HyperLink, l_ExternalObject), aBehaviour);
      finally
       l_ExternalObject := nil;
      end;//try..finally
    // Мультиссылка.
    LO_MULTILINK :
    begin
      if Supports(l_LinkedObj, IDynList, l_List) then
      try
       // Выведем сообщение об отсутствующих информационных блоках
       if bsDocCount(l_List) = 0 then
        TbsDocumentMissingMessage.Show
       // Покажем список
       else
        OpenMultiLink(l_List, aBehaviour);
      finally
       l_List := nil;
      end;//try..finally
    end;
    // Внешняя ссылка.
    LO_EXTERNAL_LINK :
     if Supports(l_LinkedObj, IExternalLink, l_ExternalLink) then
      try
       OpenExternalLink(l_ExternalLink, aBehaviour);
      finally
       l_ExternalLink := nil;
      end;//try..finally
    LO_ENO:
     if Supports(l_LinkedObj, IExternalLink, l_ExternalLink) then
      try
       nsProcessENOLink(nsExtractURL(l_ExternalLink));
      finally
       l_ExternalLink := nil;
      end;//try..finally
    LO_Query :
     if Supports(l_LinkedObj, IQuery, l_Query) then
      try
       OpenQueryLink(l_Query, aBehaviour);
      finally
       l_Query := nil;
      end;//try..finally
    LO_Bookmark :
     if Supports(l_LinkedObj, IBookmark, l_Bookmark) then
      try
       l_Bookmark.GetDocument(l_Document);
       OpenDocumentLink(l_Document,
                        l_Bookmark.GetParagraph,
                        aBehaviour,
                        f_Hyperlink.Address{$IfDef XE4}.rTafwAddress{$EndIf}.RevisionID = 0,
                        true,
                        dptPara);
      finally
       l_Bookmark := nil;
      end;//try..finally
    LO_EXTERNAL_OPERATION :
     if Supports(l_LinkedObj, IExternalOperation, l_ExternalOperation) then
      try
       OpenExternalOperationLink(l_ExternalOperation);
      finally
       l_ExternalOperation := nil;
      end;
    LO_AUTOREFERAT:
     if Supports(l_LinkedObj, IDocument, l_Document) then
      try
       OpenAutoreferatLink(l_Document, aBehaviour);
      finally
       l_Document := nil;
      end;//try..finally
    LO_SCRIPT:
     if Supports(l_LinkedObj, IExternalLink, l_ExternalLink) then
      try
       OpenURL(l_ExternalLink);
      finally
       l_ExternalLink := nil;
      end;//try..finally
   end;//case l_ObjType
  end//l_LinkedObj <> nil
  else
   Result := False; // формируем правильный результат, надо для http://mdp.garant.ru/pages/viewpage.action?pageId=336660806
 end;//f_Hyperlink <> nil
//#UC END# *53A92141005B_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.OpenHyperLink

function TbsHyperLinkProcessor.GetContainer(aBehaviour: TbsProcessHyperLinkBehaviour): IvcmContainer;
//#UC START# *53A93A0800CA_4B0A77F30378_var*
var
 l_ContainerMaker: IvcmContainerMaker;
//#UC END# *53A93A0800CA_4B0A77F30378_var*
begin
//#UC START# *53A93A0800CA_4B0A77F30378_impl*
 l_ContainerMaker := TbsHyperlinkProcessorContainerMaker.Make(aBehaviour, f_Helper);
 try
  Result := l_ContainerMaker.MakeContainer;
 finally
  l_ContainerMaker := nil;
 end;
//#UC END# *53A93A0800CA_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.GetContainer

procedure TbsHyperLinkProcessor.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B0A77F30378_var*
//#UC END# *479731C50290_4B0A77F30378_var*
begin
//#UC START# *479731C50290_4B0A77F30378_impl*
 f_Document := nil;
 f_HyperLink := nil;
 f_Helper := nil;
 f_Aggregate := nil;
 inherited;
//#UC END# *479731C50290_4B0A77F30378_impl*
end;//TbsHyperLinkProcessor.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
