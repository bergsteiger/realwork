{$IfNDef dsBaseDocumentPrim_imp}

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsBaseDocumentPrim.imp.pas"
// Стереотип: "ViewAreaControllerImp"

{$Define dsBaseDocumentPrim_imp}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
 _InitDataType_ = IdeDocInfo;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
 _UnderControlBehaviour_Parent_ = _vcmFormDataSource_;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlBehaviour.imp.pas}
 _dsBaseDocumentPrim_ = {abstract} class(_UnderControlBehaviour_, IdsBaseDocument, IucpHAFMacroReplacerFactory, IucpFilterInfoFactory)
  {* БОФ, базовый для прецедентов с документом. Не определяет конечный интерфейс бизнес-объекта }
  private
   f_HasControlStatus: Tl3Bool;
   f_DocContainer: InevDocumentContainer;
   xxx: IbsDataProducer;
   f_LikeStateHolder: InsDocumentLikeStateHolder;
   f_DocInfo: IdeDocInfo;
    {* Поле для свойства DocInfo }
  protected
   BaseDocument: IsdsBaseDocument;
   GotoPointDataMaker: IsdsGotoPointDataMaker;
  private
   function MakeLikeStateHolder: InsDocumentLikeStateHolder;
  protected
   function DoGetDocumentShortName: Il3CString; virtual;
   function DoGetDocumentName: Il3CString; virtual;
   function GetHasPrevRedaction: Boolean; virtual;
   function GetHasNextRedaction: Boolean; virtual;
   function GetCanWorkWithRedactions: Boolean; virtual;
   function GetIsReadOnly: Boolean; virtual;
   function GetTimeMachineOff: Boolean; virtual;
    {* при получении источника данных машину времени нужно выключить }
   function DoGet_PreviewCaleeArea: TafwPreviewCaleeArea; virtual;
   function DoMakeHAFMacroReplacer: IafwHAFMacroReplacer; virtual;
   function MakeContainer: InevDocumentContainer; virtual;
    {* Конструирует контейнер документа }
   function As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
    {* Метод приведения нашего интерфейса к IucpHAFMacroReplacerFactory }
   function As_IucpFilterInfoFactory: IucpFilterInfoFactory;
    {* Метод приведения нашего интерфейса к IucpFilterInfoFactory }
   function pm_GetHasDoc: Boolean;
   function pm_GetCanWorkWithRedactions: Boolean;
   function pm_GetHasPrevRedaction: Boolean;
   function pm_GetHasNextRedaction: Boolean;
   function pm_GetIsReadOnly: Boolean;
   function pm_GetTimeMachineOff: Boolean;
   function pm_GetContainer: InevDocumentContainer;
   function pm_GetDocInfo: IdeDocInfo;
   function pm_GetLanguage: TbsLanguage;
   function pm_GetIsDateCurrentRedationEmpty: Boolean;
   function pm_GetIsActualRedation: Boolean;
   function MakeGotoPointData(const aDocument: IDocument;
    aRefType: TDocumentPositionType;
    aPos: Longword): IdeDocInfo;
    {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
             новой сборки вернуться как результат для вызова операции модуля }
   function NewDocInfo(const aPos: TbsDocPos): IdeDocInfo;
    {* открыть документ в окне }
   function Get_PreviewCaleeArea: TafwPreviewCaleeArea;
   function MakeHAFMacroReplacer: IafwHAFMacroReplacer;
   function MakeFilterInfo(aType: TnsFolderFilter;
    aShowFolders: TnsShowFolders = sfAll): InsFolderFilterInfo;
   function DoGetControllable: IControllable; override;
   function Get_LikeState: TdocLikeState;
   procedure Set_LikeState(aValue: TdocLikeState);
   function AsLikeable: ILikeable;
   function GetDocumentShortName: Il3CString;
   function GetDocumentName: Il3CString;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   function MakeDisplayName: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   procedure GotData; override;
    {* - данные изменились. }
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   constructor Create(const aDataSource: _UseCaseControllerType_;
    const aData: _InitDataType_;
    const aLikeStateHolder: InsDocumentLikeStateHolder = nil); reintroduce;
   class function Make(const aDataSource: _UseCaseControllerType_;
    const aData: _InitDataType_;
    const aLikeStateHolder: InsDocumentLikeStateHolder = nil): _FormDataSourceType_; reintroduce;
  protected
   property DocInfo: IdeDocInfo
    read f_DocInfo;
 end;//_dsBaseDocumentPrim_

{$Else NOT Defined(Admin) AND NOT Defined(Monitorings)}

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}
_UnderControlBehaviour_Parent_ = _vcmFormDataSource_;
{$Include w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlBehaviour.imp.pas}
_dsBaseDocumentPrim_ = _UnderControlBehaviour_;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
{$Else dsBaseDocumentPrim_imp}

{$IfNDef dsBaseDocumentPrim_imp_impl}

{$Define dsBaseDocumentPrim_imp_impl}

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
{$Include w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSource.imp.pas}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\UnderControl\UnderControlBehaviour.imp.pas}

function _dsBaseDocumentPrim_.MakeLikeStateHolder: InsDocumentLikeStateHolder;
//#UC START# *51ED328E0077_47EA20430108_var*
//#UC END# *51ED328E0077_47EA20430108_var*
begin
//#UC START# *51ED328E0077_47EA20430108_impl*
 if not Assigned(f_LikeStateHolder) then
  f_LikeStateHolder := TnsDocumentLikeStateHolder.Make;
 Result := f_LikeStateHolder;
//#UC END# *51ED328E0077_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.MakeLikeStateHolder

constructor _dsBaseDocumentPrim_.Create(const aDataSource: _UseCaseControllerType_;
 const aData: _InitDataType_;
 const aLikeStateHolder: InsDocumentLikeStateHolder = nil);
//#UC START# *51ED45D302CE_47EA20430108_var*
//#UC END# *51ED45D302CE_47EA20430108_var*
begin
//#UC START# *51ED45D302CE_47EA20430108_impl*
 inherited Create(aDataSource, aData);
 f_LikeStateHolder := aLikeStateHolder;
//#UC END# *51ED45D302CE_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.Create

class function _dsBaseDocumentPrim_.Make(const aDataSource: _UseCaseControllerType_;
 const aData: _InitDataType_;
 const aLikeStateHolder: InsDocumentLikeStateHolder = nil): _FormDataSourceType_;
var
 l_Inst : _dsBaseDocumentPrim_;
begin
 l_Inst := Create(aDataSource, aData, aLikeStateHolder);
 try
  Result := _Instance_R_(l_Inst);
 finally
  l_Inst.Free;
 end;//try..finally
end;//_dsBaseDocumentPrim_.Make

function _dsBaseDocumentPrim_.DoGetDocumentShortName: Il3CString;
//#UC START# *53D8E620037C_47EA20430108_var*
var
 l_Str: IString;
//#UC END# *53D8E620037C_47EA20430108_var*
begin
//#UC START# *53D8E620037C_47EA20430108_impl*
 if pm_GetHasDoc then
 begin
  f_DocInfo.Doc.GetShortName(l_Str);
  Result := nsCStr(l_Str);
 end else
  Result := nil;
//#UC END# *53D8E620037C_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.DoGetDocumentShortName

function _dsBaseDocumentPrim_.DoGetDocumentName: Il3CString;
//#UC START# *54B3AC9300C2_47EA20430108_var*
var
 l_Str: IString;
//#UC END# *54B3AC9300C2_47EA20430108_var*
begin
//#UC START# *54B3AC9300C2_47EA20430108_impl*
 if pm_GetHasDoc then
 begin
  f_DocInfo.Doc.GetName(l_Str);
  Result := nsCStr(l_Str);
 end
 else
  Result := nil;
//#UC END# *54B3AC9300C2_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.DoGetDocumentName

function _dsBaseDocumentPrim_.GetHasPrevRedaction: Boolean;
//#UC START# *491C25280247_47EA20430108_var*
//#UC END# *491C25280247_47EA20430108_var*
begin
//#UC START# *491C25280247_47EA20430108_impl*
 Result := false;
//#UC END# *491C25280247_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetHasPrevRedaction

function _dsBaseDocumentPrim_.GetHasNextRedaction: Boolean;
//#UC START# *491C253D0364_47EA20430108_var*
//#UC END# *491C253D0364_47EA20430108_var*
begin
//#UC START# *491C253D0364_47EA20430108_impl*
 Result := false;
//#UC END# *491C253D0364_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetHasNextRedaction

function _dsBaseDocumentPrim_.GetCanWorkWithRedactions: Boolean;
//#UC START# *491C25470309_47EA20430108_var*
//#UC END# *491C25470309_47EA20430108_var*
begin
//#UC START# *491C25470309_47EA20430108_impl*
 Result := false;
//#UC END# *491C25470309_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetCanWorkWithRedactions

function _dsBaseDocumentPrim_.GetIsReadOnly: Boolean;
//#UC START# *491C263E03AF_47EA20430108_var*
//#UC END# *491C263E03AF_47EA20430108_var*
begin
//#UC START# *491C263E03AF_47EA20430108_impl*
 Result := false;
//#UC END# *491C263E03AF_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetIsReadOnly

function _dsBaseDocumentPrim_.GetTimeMachineOff: Boolean;
 {* при получении источника данных машину времени нужно выключить }
//#UC START# *491C264C02C2_47EA20430108_var*
//#UC END# *491C264C02C2_47EA20430108_var*
begin
//#UC START# *491C264C02C2_47EA20430108_impl*
 Result := false;
//#UC END# *491C264C02C2_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetTimeMachineOff

function _dsBaseDocumentPrim_.DoGet_PreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *49589999029F_47EA20430108_var*
//#UC END# *49589999029F_47EA20430108_var*
begin
//#UC START# *49589999029F_47EA20430108_impl*
 Result := afw_pcaMain;
//#UC END# *49589999029F_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.DoGet_PreviewCaleeArea

function _dsBaseDocumentPrim_.DoMakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *49589C6203A6_47EA20430108_var*
//#UC END# *49589C6203A6_47EA20430108_var*
begin
//#UC START# *49589C6203A6_47EA20430108_impl*
 Result := TnsDocInfoHAFMacroReplacer.Make(nil, DocInfo);
//#UC END# *49589C6203A6_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.DoMakeHAFMacroReplacer

function _dsBaseDocumentPrim_.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_47EA20430108_var*
//#UC END# *4C6AB38800F3_47EA20430108_var*
begin
//#UC START# *4C6AB38800F3_47EA20430108_impl*
 Result := nil;
 Assert(false);
//#UC END# *4C6AB38800F3_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.MakeContainer

function _dsBaseDocumentPrim_.As_IucpHAFMacroReplacerFactory: IucpHAFMacroReplacerFactory;
 {* Метод приведения нашего интерфейса к IucpHAFMacroReplacerFactory }
begin
 Result := Self;
end;//_dsBaseDocumentPrim_.As_IucpHAFMacroReplacerFactory

function _dsBaseDocumentPrim_.As_IucpFilterInfoFactory: IucpFilterInfoFactory;
 {* Метод приведения нашего интерфейса к IucpFilterInfoFactory }
begin
 Result := Self;
end;//_dsBaseDocumentPrim_.As_IucpFilterInfoFactory

function _dsBaseDocumentPrim_.pm_GetHasDoc: Boolean;
//#UC START# *47EA04080292_47EA20430108get_var*
//#UC END# *47EA04080292_47EA20430108get_var*
begin
//#UC START# *47EA04080292_47EA20430108get_impl*
 Result := (f_DocInfo <> nil) AND (f_DocInfo.Doc <> nil);
//#UC END# *47EA04080292_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetHasDoc

function _dsBaseDocumentPrim_.pm_GetCanWorkWithRedactions: Boolean;
//#UC START# *47EA042601D9_47EA20430108get_var*
//#UC END# *47EA042601D9_47EA20430108get_var*
begin
//#UC START# *47EA042601D9_47EA20430108get_impl*
 // По умолчанию нельзя работать с редакциями, это возможно только для
 // документа сборки документ
 Result := GetCanWorkWithRedactions;
//#UC END# *47EA042601D9_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetCanWorkWithRedactions

function _dsBaseDocumentPrim_.pm_GetHasPrevRedaction: Boolean;
//#UC START# *47EA04970339_47EA20430108get_var*
//#UC END# *47EA04970339_47EA20430108get_var*
begin
//#UC START# *47EA04970339_47EA20430108get_impl*
 Result := GetHasPrevRedaction;
//#UC END# *47EA04970339_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetHasPrevRedaction

function _dsBaseDocumentPrim_.pm_GetHasNextRedaction: Boolean;
//#UC START# *47EA04B400A1_47EA20430108get_var*
//#UC END# *47EA04B400A1_47EA20430108get_var*
begin
//#UC START# *47EA04B400A1_47EA20430108get_impl*
 Result := GetHasNextRedaction;
//#UC END# *47EA04B400A1_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetHasNextRedaction

function _dsBaseDocumentPrim_.pm_GetIsReadOnly: Boolean;
//#UC START# *47EA08690258_47EA20430108get_var*
//#UC END# *47EA08690258_47EA20430108get_var*
begin
//#UC START# *47EA08690258_47EA20430108get_impl*
 Result := GetIsReadOnly;
//#UC END# *47EA08690258_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetIsReadOnly

function _dsBaseDocumentPrim_.pm_GetTimeMachineOff: Boolean;
//#UC START# *47EA087C02BC_47EA20430108get_var*
//#UC END# *47EA087C02BC_47EA20430108get_var*
begin
//#UC START# *47EA087C02BC_47EA20430108get_impl*
 Result := GetTimeMachineOff;
//#UC END# *47EA087C02BC_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetTimeMachineOff

function _dsBaseDocumentPrim_.pm_GetContainer: InevDocumentContainer;
//#UC START# *491B2D5A0200_47EA20430108get_var*

 function lp_MakeData: Boolean;
 begin
  if (xxx <> nil) then
   Result := xxx.xxxMakeData
  else
   Result := True;
 end;//lp_CanCreate

//#UC END# *491B2D5A0200_47EA20430108get_var*
begin
//#UC START# *491B2D5A0200_47EA20430108get_impl*
 if not Assigned(f_DocContainer) and lp_MakeData and Assigned(f_DocInfo) then
  f_DocContainer := MakeContainer;
 Result := f_DocContainer;
//#UC END# *491B2D5A0200_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetContainer

function _dsBaseDocumentPrim_.pm_GetDocInfo: IdeDocInfo;
//#UC START# *491B2DB200CE_47EA20430108get_var*
//#UC END# *491B2DB200CE_47EA20430108get_var*
begin
//#UC START# *491B2DB200CE_47EA20430108get_impl*
 // Создаем NULL объект чтобы желающий поработать с документом не падали
 if not Assigned(f_DocInfo) then
  f_DocInfo := TdeDocInfo.Make;
 Result := f_DocInfo;
//#UC END# *491B2DB200CE_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetDocInfo

function _dsBaseDocumentPrim_.pm_GetLanguage: TbsLanguage;
//#UC START# *491B2E63002B_47EA20430108get_var*
var
 lState: IDocumentState;
//#UC END# *491B2E63002B_47EA20430108get_var*
begin
//#UC START# *491B2E63002B_47EA20430108get_impl*
 Result := LG_RUSSIAN;
 if Assigned(f_DocInfo) and Assigned(f_DocInfo.Doc) then
 begin
  f_DocInfo.Doc.GetCurrentState(lState);
  try
   Result := lState.GetLanguage;
  finally
   lState := nil;
  end;{try..finally}
 end;//if Assigned(f_DocInfo) and Assigned(f_DocInfo.Doc) then
//#UC END# *491B2E63002B_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetLanguage

function _dsBaseDocumentPrim_.pm_GetIsDateCurrentRedationEmpty: Boolean;
//#UC START# *491B2E87000D_47EA20430108get_var*
var
 l_Info: TRedactionInfo;
//#UC END# *491B2E87000D_47EA20430108get_var*
begin
//#UC START# *491B2E87000D_47EA20430108get_impl*
 if pm_GetHasDoc then
 begin
  l_Info := bsRedationInfo(DocInfo.Doc);
  Result := IsNullDate(l_Info.rTimeMachineDate);
 end//if pm_GetHasDoc then
 else
  Result := False;
//#UC END# *491B2E87000D_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetIsDateCurrentRedationEmpty

function _dsBaseDocumentPrim_.pm_GetIsActualRedation: Boolean;
//#UC START# *491B2F1601B0_47EA20430108get_var*
//#UC END# *491B2F1601B0_47EA20430108get_var*
begin
//#UC START# *491B2F1601B0_47EA20430108get_impl*
 if pm_GetHasDoc then
  Result := TdmStdRes.IsCurEditionActual(DocInfo.Doc)
 else
  Result := False;
//#UC END# *491B2F1601B0_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.pm_GetIsActualRedation

function _dsBaseDocumentPrim_.MakeGotoPointData(const aDocument: IDocument;
 aRefType: TDocumentPositionType;
 aPos: Longword): IdeDocInfo;
 {* открыть ссылку. Если ссылка требует пересоздания сборки, то данные для
             новой сборки вернуться как результат для вызова операции модуля }
//#UC START# *491B2F63002D_47EA20430108_var*
//#UC END# *491B2F63002D_47EA20430108_var*
begin
//#UC START# *491B2F63002D_47EA20430108_impl*
 if (ucc_GotoPointDataMaker <> nil) then
  Result := ucc_GotoPointDataMaker.MakeGotoPointData(aDocument, aRefType, aPos)
 else
  Result := nil;
//#UC END# *491B2F63002D_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.MakeGotoPointData

function _dsBaseDocumentPrim_.NewDocInfo(const aPos: TbsDocPos): IdeDocInfo;
 {* открыть документ в окне }
//#UC START# *491B2FE20181_47EA20430108_var*
//#UC END# *491B2FE20181_47EA20430108_var*
begin
//#UC START# *491B2FE20181_47EA20430108_impl*
 Result := DocInfo.Clone;
 Result.SetPosition(aPos);
//#UC END# *491B2FE20181_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.NewDocInfo

function _dsBaseDocumentPrim_.Get_PreviewCaleeArea: TafwPreviewCaleeArea;
//#UC START# *495894020347_47EA20430108get_var*
//#UC END# *495894020347_47EA20430108get_var*
begin
//#UC START# *495894020347_47EA20430108get_impl*
 Result := DoGetPreviewCaleeArea;
//#UC END# *495894020347_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.Get_PreviewCaleeArea

function _dsBaseDocumentPrim_.MakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *4AE56DE80093_47EA20430108_var*
//#UC END# *4AE56DE80093_47EA20430108_var*
begin
//#UC START# *4AE56DE80093_47EA20430108_impl*
 Result := DoMakeHAFMacroReplacer;
//#UC END# *4AE56DE80093_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.MakeHAFMacroReplacer

function _dsBaseDocumentPrim_.MakeFilterInfo(aType: TnsFolderFilter;
 aShowFolders: TnsShowFolders = sfAll): InsFolderFilterInfo;
//#UC START# *4AE575FA030B_47EA20430108_var*
  
 function nsFilterForDocument(const aDoc: IdeDocInfo): TnsFolderFilterFor;
   {-}
 begin
  case aDoc.DocType of
   DT_MEDICAL_DOCUMENT:
    Result := ns_ffDrug;
   else
    Result := ns_ffDocument;
  end;//case aDoc.DocType of
 end;

//#UC END# *4AE575FA030B_47EA20430108_var*
begin
//#UC START# *4AE575FA030B_47EA20430108_impl*
 Result := TnsFolderFilterInfo.Make(aType,
                                    nsFilterForDocument(pm_GetDocInfo),
                                    aShowFolders);
//#UC END# *4AE575FA030B_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.MakeFilterInfo

function _dsBaseDocumentPrim_.DoGetControllable: IControllable;
//#UC START# *4B9A37C90253_47EA20430108_var*
//#UC END# *4B9A37C90253_47EA20430108_var*
begin
//#UC START# *4B9A37C90253_47EA20430108_impl*
 Result := nil;
 if pm_GetHasDoc then
  Supports(DocInfo.Doc, IControllable, Result);
//#UC END# *4B9A37C90253_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.DoGetControllable

function _dsBaseDocumentPrim_.Get_LikeState: TdocLikeState;
//#UC START# *500E5D3B02AF_47EA20430108get_var*
//#UC END# *500E5D3B02AF_47EA20430108get_var*
begin
//#UC START# *500E5D3B02AF_47EA20430108get_impl*
 Result := MakeLikeStateHolder.LikeState;
//#UC END# *500E5D3B02AF_47EA20430108get_impl*
end;//_dsBaseDocumentPrim_.Get_LikeState

procedure _dsBaseDocumentPrim_.Set_LikeState(aValue: TdocLikeState);
//#UC START# *500E5D3B02AF_47EA20430108set_var*
//#UC END# *500E5D3B02AF_47EA20430108set_var*
begin
//#UC START# *500E5D3B02AF_47EA20430108set_impl*
 if Get_LikeState <> aValue then
 begin
  MakeLikeStateHolder.LikeState := aValue;
  case aValue of
   dlsUseful: Self.AsLikeable.Like;
   dlsUseless: Self.AsLikeable.UnLike;
  else
   Assert(False, 'А мы не умеем сбрасывать состояние полезности документа');
  end;
 end;
//#UC END# *500E5D3B02AF_47EA20430108set_impl*
end;//_dsBaseDocumentPrim_.Set_LikeState

function _dsBaseDocumentPrim_.AsLikeable: ILikeable;
//#UC START# *500E5D5D0268_47EA20430108_var*
//#UC END# *500E5D5D0268_47EA20430108_var*
begin
//#UC START# *500E5D5D0268_47EA20430108_impl*
 Supports(DocInfo.Doc, ILikeable, Result);
//#UC END# *500E5D5D0268_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.AsLikeable

function _dsBaseDocumentPrim_.GetDocumentShortName: Il3CString;
//#UC START# *53D8C6EA038C_47EA20430108_var*
//#UC END# *53D8C6EA038C_47EA20430108_var*
begin
//#UC START# *53D8C6EA038C_47EA20430108_impl*
 Result := DoGetDocumentShortName;
//#UC END# *53D8C6EA038C_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetDocumentShortName

function _dsBaseDocumentPrim_.GetDocumentName: Il3CString;
//#UC START# *54B3A7C7038F_47EA20430108_var*
//#UC END# *54B3A7C7038F_47EA20430108_var*
begin
//#UC START# *54B3A7C7038F_47EA20430108_impl*
 Result := DoGetDocumentName;
//#UC END# *54B3A7C7038F_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetDocumentName

procedure _dsBaseDocumentPrim_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47EA20430108_var*
//#UC END# *479731C50290_47EA20430108_var*
begin
//#UC START# *479731C50290_47EA20430108_impl*
 f_LikeStateHolder := nil;
 f_DocInfo := nil;
 f_DocContainer := nil;
 inherited;
//#UC END# *479731C50290_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.Cleanup

{$If NOT Defined(NoVCM)}
function _dsBaseDocumentPrim_.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_47EA20430108_var*
//#UC END# *491476B001D3_47EA20430108_var*
begin
//#UC START# *491476B001D3_47EA20430108_impl*
 if pm_GetHasDoc then
  Result := f_DocInfo.DocName
 else
  Result := nil;
//#UC END# *491476B001D3_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.MakeDisplayName
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function _dsBaseDocumentPrim_.GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean;
//#UC START# *49147B4602C0_47EA20430108_var*
//#UC END# *49147B4602C0_47EA20430108_var*
begin
//#UC START# *49147B4602C0_47EA20430108_impl*
 Result := False;
 if (aDataSource <> nil) then
  if aDataSource.DocInfo.IsSame(f_DocInfo, True, False) then
  begin
   f_DocInfo.Pos := aDataSource.DocInfo.Pos;
   // - переприсваивать позицию и не учитывать ее при сравнении нужно потому,
   //   что пользователь мог открыть закладку на документ, далее
   //   проскролироваться с помощью курсора и снова открыть эту же ссылку на
   //   документ при этом должно произойти позиционирование на закладку;
   Result := True;
  end;//if aDataSource.DocInfo.IsSame(f_DocInfo, True, False) and
//#UC END# *49147B4602C0_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GetIsNeedChangePosition
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
procedure _dsBaseDocumentPrim_.GotData;
 {* - данные изменились. }
//#UC START# *492ACF630072_47EA20430108_var*
//#UC END# *492ACF630072_47EA20430108_var*
begin
//#UC START# *492ACF630072_47EA20430108_impl*
 inherited;
 f_DocInfo := PartData;
//#UC END# *492ACF630072_47EA20430108_impl*
end;//_dsBaseDocumentPrim_.GotData
{$IfEnd} // NOT Defined(NoVCM)

procedure _dsBaseDocumentPrim_.ClearFields;
begin
 f_DocInfo := nil;
 inherited;
end;//_dsBaseDocumentPrim_.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

{$EndIf dsBaseDocumentPrim_imp_impl}

{$EndIf dsBaseDocumentPrim_imp}

