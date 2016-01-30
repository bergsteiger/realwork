unit sdsAAC;
 {* Контроллер прецедента "Актуальная аналитика" }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AAC\sdsAAC.pas"
// Стереотип: "UseCaseControllerImp"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , WorkWithDocumentInterfaces
 , nsDocumentLikeStateHolder
 {$If NOT Defined(NoVCM)}
 , vcmControllers
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentAndListInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DocumentInterfaces
 , bsTypesNew
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , DynamicTreeUnit
 , bsTypes
 , nsTypes
 , DocumentUnit
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , DocInfoInterfaces
 , PrimListInterfaces
 , DynamicDocListUnit
 , ExternalObjectUnit
 , BaseDocumentWithAttributesInterfaces
 , l3IID
 , l3ProtoObjectWithCOMQI
 , l3Interfaces
 , l3NotifyPtrList
 , afwInterfaces
 , bsInterfaces
 , nevTools
 , PrimPrimListInterfaces
 , AdapterFacade
 , l3ProtoObject
;

type
 IdeAAC = interface(IdeDocInfo)
  ['{E8001007-EC93-4F80-8D22-72743A5029AB}']
  function pm_GetLikeStateHolder: InsDocumentLikeStateHolder;
  function pm_GetDeDocInfo: IdeDocInfo;
  property LikeStateHolder: InsDocumentLikeStateHolder
   read pm_GetLikeStateHolder;
  property DeDocInfo: IdeDocInfo
   read pm_GetDeDocInfo;
 end;//IdeAAC

 TdeAAC = class(Tl3ProtoObject, IdeAAC)
  private
   f_deDocInfo: IdeDocInfo;
   f_LikeStateHolder: InsDocumentLikeStateHolder;
  protected
   function IsSame(const aDocInfo: IdeDocInfo;
    aView: Boolean = True;
    aPosition: Boolean = True): Boolean;
    {* сравнить документы.
           - aView: возвращает равенство документов с учетом их состояния (в
                    отличии от is_same_entity, который возвращает равенство без
                    учета состояния). Состоянием документа является суперпозиция
                    номера редакции, языка и списка извлечений.
           - aPosition: сравнивать с учетом позиций. }
   procedure SetPosition(const aPos: TbsDocPos);
   function ChangeRedaction(aChangeType: TnsChangeRedactionType;
    aRedaction: TRedactionID = 0): Boolean; overload;
   function ChangeRedaction(const aDate: AdapterDate): Boolean; overload;
   function ChangeRedaction(const aDocument: IDocument): Boolean; overload;
   procedure InitListNode(const aRoot: INodeBase;
    const aListNode: INodeBase);
    {* документ открывается из списка }
   procedure CorrectLanguage(aLanguage: TbsLanguage);
   function Clone: IdeDocInfo;
   function pm_GetDoc: IDocument;
   procedure pm_SetDoc(const aValue: IDocument);
   function pm_GetDocumentState: IDocumentState;
   function pm_GetPos: TbsDocPos;
   procedure pm_SetPos(const aValue: TbsDocPos);
   function pm_GetLanguage: TbsLanguage;
   function pm_GetList: IDynList;
   function pm_GetListNode: INodeBase;
   function pm_GetDocName: Il3CString;
   function pm_GetDocShortName: Il3CString;
   function pm_GetCurEditionName: Il3CString;
   function pm_GetDataSize: Il3CString;
   function pm_GetInternalNumber: Il3CString;
   function pm_GetListRoot: INodeBase;
   function Get_DocType: TDocumentType;
   function pm_GetSearchInfo: IdeSearchInfo;
   procedure pm_SetSearchInfo(const aValue: IdeSearchInfo);
   function pm_GetFilePosition: Il3CString;
   procedure ClearListNode;
    {* http://mdp.garant.ru/pages/viewpage.action?pageId=124453871&focusedCommentId=173507098#comment-173507098 }
   function pm_GetLikeStateHolder: InsDocumentLikeStateHolder;
   function pm_GetDeDocInfo: IdeDocInfo;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(const aDeDocInfo: IdeDocInfo;
    const aLikeStateHolder: InsDocumentLikeStateHolder); reintroduce;
   class function Make(const aDeDocInfo: IdeDocInfo;
    const aLikeStateHolder: InsDocumentLikeStateHolder): IdeAAC; reintroduce;
 end;//TdeAAC

 _SetType_ = IsdsAAC;
 {$Include sdsDocument.imp.pas}
 TsdsAAC = class(_sdsDocument_, IsdsAAC)
  {* Контроллер прецедента "Актуальная аналитика" }
  private
   f_DocumentLikeStateHolder: InsDocumentLikeStateHolder;
   f_Container: IvcmViewAreaControllerRef;
    {* Поле для области вывода Container }
   f_Left: IvcmViewAreaControllerRef;
    {* Поле для области вывода Left }
   f_Right: IvcmViewAreaControllerRef;
    {* Поле для области вывода Right }
  private
   function MakeDocumentLikeStateHolder: InsDocumentLikeStateHolder;
  protected
   function pm_GetContainer: IdsAACContainer;
   function pm_GetLeft: IdsBaseDocument;
   function pm_GetRight: IdsBaseDocument;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   {$If NOT Defined(NoVCM)}
   procedure DataExchange; override;
    {* - вызывается после получения данных инициализации. }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean; override;
   {$IfEnd} // NOT Defined(NoVCM)
   function BaseDocumentClass: IdsBaseDocument; override;
   procedure ClearAllDS; override;
   {$If NOT Defined(NoVCM)}
   procedure ClearAreas; override;
    {* Очищает ссылки на области ввода }
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function DoGetTabCaption: IvcmCString; override;
   {$IfEnd} // NOT Defined(NoVCM)
   {$If NOT Defined(NoVCM)}
   function GetDataForClone: _InitDataType_; override;
   {$IfEnd} // NOT Defined(NoVCM)
 end;//TsdsAAC
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , dsDocument
 , dsAACContainer
 , dsAACDocumentLeft
 , dsAACDocumentRight
 , dDocument
 , SysUtils
 , dsDocumentListCRToPart
 , deDocumentListCR
 , dsWarning
 , dsContents
 , dsEditions
 {$If NOT Defined(NoVCM)}
 , vcmForm
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmGUI
 {$IfEnd} // NOT Defined(NoVCM)
 , IOUnit
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , BaseTypesUnit
 , DataAdapter
 , k2Tags
 {$If NOT Defined(NoVCM)}
 , vcmFormSetRefreshParams
 {$IfEnd} // NOT Defined(NoVCM)
 , bsUtils
 , l3String
 , l3Core
 , nsDocumentTools
 , afwFacade
 , Graphics
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 , nsConst
 , Document_Const
 , TextPara_Const
 , UnderControlInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , ControlStatusUtils
 , nsDocumentWarningGenerator
 , dsTranslationWarning
 , dsCRWarning
 , nsTabbedInterfaceTypes
 , dsDocumentListCR
 , dsDocumentList
 , dsAnnotation
 , dsDocumentWithFlash
 , bsFrozenNode
 , deDocInfo
 , bsDataContainer
 , deDocumentList
 , bsUserCRListInfo
 , l3Types
 , DebugStr
 , l3Utils
 , nsUtils
 , dsTranslation
 , dsRelatedDoc
 , dsChronology
 , dsAttributes
 , Windows
 {$If NOT Defined(NoVCM)}
 , vcmLocalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , afwSettingsChangePublisher
;

constructor TdeAAC.Create(const aDeDocInfo: IdeDocInfo;
 const aLikeStateHolder: InsDocumentLikeStateHolder);
//#UC START# *56A0857B0382_56A08533037E_var*
//#UC END# *56A0857B0382_56A08533037E_var*
begin
//#UC START# *56A0857B0382_56A08533037E_impl*
 inherited Create;
 f_DeDocInfo := aDeDocInfo;
 f_LikeStateHolder := aLikeStateHolder;
//#UC END# *56A0857B0382_56A08533037E_impl*
end;//TdeAAC.Create

class function TdeAAC.Make(const aDeDocInfo: IdeDocInfo;
 const aLikeStateHolder: InsDocumentLikeStateHolder): IdeAAC;
var
 l_Inst : TdeAAC;
begin
 l_Inst := Create(aDeDocInfo, aLikeStateHolder);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TdeAAC.Make

function TdeAAC.IsSame(const aDocInfo: IdeDocInfo;
 aView: Boolean = True;
 aPosition: Boolean = True): Boolean;
 {* сравнить документы.
           - aView: возвращает равенство документов с учетом их состояния (в
                    отличии от is_same_entity, который возвращает равенство без
                    учета состояния). Состоянием документа является суперпозиция
                    номера редакции, языка и списка извлечений.
           - aPosition: сравнивать с учетом позиций. }
//#UC START# *4B1D118000EA_56A08533037E_var*
//#UC END# *4B1D118000EA_56A08533037E_var*
begin
//#UC START# *4B1D118000EA_56A08533037E_impl*
 Result := f_deDocInfo.IsSame(aDocInfo, aView, aPosition);
//#UC END# *4B1D118000EA_56A08533037E_impl*
end;//TdeAAC.IsSame

procedure TdeAAC.SetPosition(const aPos: TbsDocPos);
//#UC START# *4B1D11B00164_56A08533037E_var*
//#UC END# *4B1D11B00164_56A08533037E_var*
begin
//#UC START# *4B1D11B00164_56A08533037E_impl*
 f_deDocInfo.SetPosition(aPos);
//#UC END# *4B1D11B00164_56A08533037E_impl*
end;//TdeAAC.SetPosition

function TdeAAC.ChangeRedaction(aChangeType: TnsChangeRedactionType;
 aRedaction: TRedactionID = 0): Boolean;
//#UC START# *4B1D11CF0265_56A08533037E_var*
//#UC END# *4B1D11CF0265_56A08533037E_var*
begin
//#UC START# *4B1D11CF0265_56A08533037E_impl*
 Result := f_deDocInfo.ChangeRedaction(aChangeType, aRedaction);
//#UC END# *4B1D11CF0265_56A08533037E_impl*
end;//TdeAAC.ChangeRedaction

function TdeAAC.ChangeRedaction(const aDate: AdapterDate): Boolean;
//#UC START# *4B1D11E00385_56A08533037E_var*
//#UC END# *4B1D11E00385_56A08533037E_var*
begin
//#UC START# *4B1D11E00385_56A08533037E_impl*
 Result := f_deDocInfo.ChangeRedaction(aDate);
//#UC END# *4B1D11E00385_56A08533037E_impl*
end;//TdeAAC.ChangeRedaction

function TdeAAC.ChangeRedaction(const aDocument: IDocument): Boolean;
//#UC START# *4B1D11F0033E_56A08533037E_var*
//#UC END# *4B1D11F0033E_56A08533037E_var*
begin
//#UC START# *4B1D11F0033E_56A08533037E_impl*
 Result := f_deDocInfo.ChangeRedaction(aDocument);
//#UC END# *4B1D11F0033E_56A08533037E_impl*
end;//TdeAAC.ChangeRedaction

procedure TdeAAC.InitListNode(const aRoot: INodeBase;
 const aListNode: INodeBase);
 {* документ открывается из списка }
//#UC START# *4B1D11FE0117_56A08533037E_var*
//#UC END# *4B1D11FE0117_56A08533037E_var*
begin
//#UC START# *4B1D11FE0117_56A08533037E_impl*
 f_deDocInfo.InitListNode(aRoot, aListNode);
//#UC END# *4B1D11FE0117_56A08533037E_impl*
end;//TdeAAC.InitListNode

procedure TdeAAC.CorrectLanguage(aLanguage: TbsLanguage);
//#UC START# *4B1D121B03D0_56A08533037E_var*
//#UC END# *4B1D121B03D0_56A08533037E_var*
begin
//#UC START# *4B1D121B03D0_56A08533037E_impl*
 f_deDocInfo.CorrectLanguage(aLanguage);
//#UC END# *4B1D121B03D0_56A08533037E_impl*
end;//TdeAAC.CorrectLanguage

function TdeAAC.Clone: IdeDocInfo;
//#UC START# *4B1D12260038_56A08533037E_var*
//#UC END# *4B1D12260038_56A08533037E_var*
begin
//#UC START# *4B1D12260038_56A08533037E_impl*
 Result := f_deDocInfo.Clone;
//#UC END# *4B1D12260038_56A08533037E_impl*
end;//TdeAAC.Clone

function TdeAAC.pm_GetDoc: IDocument;
//#UC START# *4B1D126203E6_56A08533037Eget_var*
//#UC END# *4B1D126203E6_56A08533037Eget_var*
begin
//#UC START# *4B1D126203E6_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetDoc;
//#UC END# *4B1D126203E6_56A08533037Eget_impl*
end;//TdeAAC.pm_GetDoc

procedure TdeAAC.pm_SetDoc(const aValue: IDocument);
//#UC START# *4B1D126203E6_56A08533037Eset_var*
//#UC END# *4B1D126203E6_56A08533037Eset_var*
begin
//#UC START# *4B1D126203E6_56A08533037Eset_impl*
 f_deDocInfo.pm_SetDoc(aValue);
//#UC END# *4B1D126203E6_56A08533037Eset_impl*
end;//TdeAAC.pm_SetDoc

function TdeAAC.pm_GetDocumentState: IDocumentState;
//#UC START# *4B1D127600DC_56A08533037Eget_var*
//#UC END# *4B1D127600DC_56A08533037Eget_var*
begin
//#UC START# *4B1D127600DC_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetDocumentState;
//#UC END# *4B1D127600DC_56A08533037Eget_impl*
end;//TdeAAC.pm_GetDocumentState

function TdeAAC.pm_GetPos: TbsDocPos;
//#UC START# *4B1D12A30083_56A08533037Eget_var*
//#UC END# *4B1D12A30083_56A08533037Eget_var*
begin
//#UC START# *4B1D12A30083_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetPos;
//#UC END# *4B1D12A30083_56A08533037Eget_impl*
end;//TdeAAC.pm_GetPos

procedure TdeAAC.pm_SetPos(const aValue: TbsDocPos);
//#UC START# *4B1D12A30083_56A08533037Eset_var*
//#UC END# *4B1D12A30083_56A08533037Eset_var*
begin
//#UC START# *4B1D12A30083_56A08533037Eset_impl*
 f_deDocInfo.pm_SetPos(aValue);
//#UC END# *4B1D12A30083_56A08533037Eset_impl*
end;//TdeAAC.pm_SetPos

function TdeAAC.pm_GetLanguage: TbsLanguage;
//#UC START# *4B1D12C103CC_56A08533037Eget_var*
//#UC END# *4B1D12C103CC_56A08533037Eget_var*
begin
//#UC START# *4B1D12C103CC_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetLanguage;
//#UC END# *4B1D12C103CC_56A08533037Eget_impl*
end;//TdeAAC.pm_GetLanguage

function TdeAAC.pm_GetList: IDynList;
//#UC START# *4B1D12F10074_56A08533037Eget_var*
//#UC END# *4B1D12F10074_56A08533037Eget_var*
begin
//#UC START# *4B1D12F10074_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetList;
//#UC END# *4B1D12F10074_56A08533037Eget_impl*
end;//TdeAAC.pm_GetList

function TdeAAC.pm_GetListNode: INodeBase;
//#UC START# *4B1D13200333_56A08533037Eget_var*
//#UC END# *4B1D13200333_56A08533037Eget_var*
begin
//#UC START# *4B1D13200333_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetListNode;
//#UC END# *4B1D13200333_56A08533037Eget_impl*
end;//TdeAAC.pm_GetListNode

function TdeAAC.pm_GetDocName: Il3CString;
//#UC START# *4B1D137202D9_56A08533037Eget_var*
//#UC END# *4B1D137202D9_56A08533037Eget_var*
begin
//#UC START# *4B1D137202D9_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetDocName;
//#UC END# *4B1D137202D9_56A08533037Eget_impl*
end;//TdeAAC.pm_GetDocName

function TdeAAC.pm_GetDocShortName: Il3CString;
//#UC START# *4B1D13AF006C_56A08533037Eget_var*
//#UC END# *4B1D13AF006C_56A08533037Eget_var*
begin
//#UC START# *4B1D13AF006C_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetDocShortName;
//#UC END# *4B1D13AF006C_56A08533037Eget_impl*
end;//TdeAAC.pm_GetDocShortName

function TdeAAC.pm_GetCurEditionName: Il3CString;
//#UC START# *4B1D13C500CA_56A08533037Eget_var*
//#UC END# *4B1D13C500CA_56A08533037Eget_var*
begin
//#UC START# *4B1D13C500CA_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetCurEditionName;
//#UC END# *4B1D13C500CA_56A08533037Eget_impl*
end;//TdeAAC.pm_GetCurEditionName

function TdeAAC.pm_GetDataSize: Il3CString;
//#UC START# *4B1D13D501CF_56A08533037Eget_var*
//#UC END# *4B1D13D501CF_56A08533037Eget_var*
begin
//#UC START# *4B1D13D501CF_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetDataSize;
//#UC END# *4B1D13D501CF_56A08533037Eget_impl*
end;//TdeAAC.pm_GetDataSize

function TdeAAC.pm_GetInternalNumber: Il3CString;
//#UC START# *4B1D13E30017_56A08533037Eget_var*
//#UC END# *4B1D13E30017_56A08533037Eget_var*
begin
//#UC START# *4B1D13E30017_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetInternalNumber;
//#UC END# *4B1D13E30017_56A08533037Eget_impl*
end;//TdeAAC.pm_GetInternalNumber

function TdeAAC.pm_GetListRoot: INodeBase;
//#UC START# *4B1D142201E3_56A08533037Eget_var*
//#UC END# *4B1D142201E3_56A08533037Eget_var*
begin
//#UC START# *4B1D142201E3_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetListRoot;
//#UC END# *4B1D142201E3_56A08533037Eget_impl*
end;//TdeAAC.pm_GetListRoot

function TdeAAC.Get_DocType: TDocumentType;
//#UC START# *4B1D144802C3_56A08533037Eget_var*
//#UC END# *4B1D144802C3_56A08533037Eget_var*
begin
//#UC START# *4B1D144802C3_56A08533037Eget_impl*
 Result := f_deDocInfo.Get_DocType;
//#UC END# *4B1D144802C3_56A08533037Eget_impl*
end;//TdeAAC.Get_DocType

function TdeAAC.pm_GetSearchInfo: IdeSearchInfo;
//#UC START# *4B1D14B701DF_56A08533037Eget_var*
//#UC END# *4B1D14B701DF_56A08533037Eget_var*
begin
//#UC START# *4B1D14B701DF_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetSearchInfo;
//#UC END# *4B1D14B701DF_56A08533037Eget_impl*
end;//TdeAAC.pm_GetSearchInfo

procedure TdeAAC.pm_SetSearchInfo(const aValue: IdeSearchInfo);
//#UC START# *4B1D14B701DF_56A08533037Eset_var*
//#UC END# *4B1D14B701DF_56A08533037Eset_var*
begin
//#UC START# *4B1D14B701DF_56A08533037Eset_impl*
 f_deDocInfo.pm_SetSearchInfo(aValue);
//#UC END# *4B1D14B701DF_56A08533037Eset_impl*
end;//TdeAAC.pm_SetSearchInfo

function TdeAAC.pm_GetFilePosition: Il3CString;
//#UC START# *4B1D14CE0062_56A08533037Eget_var*
//#UC END# *4B1D14CE0062_56A08533037Eget_var*
begin
//#UC START# *4B1D14CE0062_56A08533037Eget_impl*
 Result := f_deDocInfo.pm_GetFilePosition;
//#UC END# *4B1D14CE0062_56A08533037Eget_impl*
end;//TdeAAC.pm_GetFilePosition

procedure TdeAAC.ClearListNode;
 {* http://mdp.garant.ru/pages/viewpage.action?pageId=124453871&focusedCommentId=173507098#comment-173507098 }
//#UC START# *4B1FA0B003E1_56A08533037E_var*
//#UC END# *4B1FA0B003E1_56A08533037E_var*
begin
//#UC START# *4B1FA0B003E1_56A08533037E_impl*
 f_deDocInfo.ClearListNode;
//#UC END# *4B1FA0B003E1_56A08533037E_impl*
end;//TdeAAC.ClearListNode

function TdeAAC.pm_GetLikeStateHolder: InsDocumentLikeStateHolder;
//#UC START# *56A063DB012F_56A08533037Eget_var*
//#UC END# *56A063DB012F_56A08533037Eget_var*
begin
//#UC START# *56A063DB012F_56A08533037Eget_impl*
 Result := f_LikeStateHolder;
//#UC END# *56A063DB012F_56A08533037Eget_impl*
end;//TdeAAC.pm_GetLikeStateHolder

function TdeAAC.pm_GetDeDocInfo: IdeDocInfo;
//#UC START# *56A06EC803B1_56A08533037Eget_var*
//#UC END# *56A06EC803B1_56A08533037Eget_var*
begin
//#UC START# *56A06EC803B1_56A08533037Eget_impl*
 Result := f_deDocInfo;
//#UC END# *56A06EC803B1_56A08533037Eget_impl*
end;//TdeAAC.pm_GetDeDocInfo

procedure TdeAAC.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_56A08533037E_var*
//#UC END# *479731C50290_56A08533037E_var*
begin
//#UC START# *479731C50290_56A08533037E_impl*
 f_deDocInfo := nil;
 f_LikeStateHolder := nil;
 inherited;
//#UC END# *479731C50290_56A08533037E_impl*
end;//TdeAAC.Cleanup

type _Instance_R_ = TsdsAAC;

{$Include sdsDocument.imp.pas}

function TsdsAAC.MakeDocumentLikeStateHolder: InsDocumentLikeStateHolder;
//#UC START# *51ED56B903D6_4FF2E6B003C4_var*
//#UC END# *51ED56B903D6_4FF2E6B003C4_var*
begin
//#UC START# *51ED56B903D6_4FF2E6B003C4_impl*
 if not Assigned(f_DocumentLikeStateHolder) then
  f_DocumentLikeStateHolder := TnsDocumentLikeStateHolder.Make;
 Result := f_DocumentLikeStateHolder;
//#UC END# *51ED56B903D6_4FF2E6B003C4_impl*
end;//TsdsAAC.MakeDocumentLikeStateHolder

function TsdsAAC.pm_GetContainer: IdsAACContainer;
//#UC START# *4FF2E70A0103_4FF2E6B003C4get_var*
//#UC END# *4FF2E70A0103_4FF2E6B003C4get_var*
begin
//#UC START# *4FF2E70A0103_4FF2E6B003C4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FF2E70A0103_4FF2E6B003C4get_impl*
end;//TsdsAAC.pm_GetContainer

function TsdsAAC.pm_GetLeft: IdsBaseDocument;
//#UC START# *4FF2E78901DC_4FF2E6B003C4get_var*
//#UC END# *4FF2E78901DC_4FF2E6B003C4get_var*
begin
//#UC START# *4FF2E78901DC_4FF2E6B003C4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FF2E78901DC_4FF2E6B003C4get_impl*
end;//TsdsAAC.pm_GetLeft

function TsdsAAC.pm_GetRight: IdsBaseDocument;
//#UC START# *4FF2E7BE016B_4FF2E6B003C4get_var*
//#UC END# *4FF2E7BE016B_4FF2E6B003C4get_var*
begin
//#UC START# *4FF2E7BE016B_4FF2E6B003C4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FF2E7BE016B_4FF2E6B003C4get_impl*
end;//TsdsAAC.pm_GetRight

procedure TsdsAAC.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4FF2E6B003C4_var*
//#UC END# *479731C50290_4FF2E6B003C4_var*
begin
//#UC START# *479731C50290_4FF2E6B003C4_impl*
 f_DocumentLikeStateHolder := nil;
 inherited;
//#UC END# *479731C50290_4FF2E6B003C4_impl*
end;//TsdsAAC.Cleanup

{$If NOT Defined(NoVCM)}
procedure TsdsAAC.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_4FF2E6B003C4_var*
var
 l_deAAC: IdeAAC;
//#UC END# *47F37DF001FE_4FF2E6B003C4_var*
begin
//#UC START# *47F37DF001FE_4FF2E6B003C4_impl*
 inherited;
 if Supports(InitialUseCaseData, IdeAAC, l_deAAC) then
 try
  f_DocumentLikeStateHolder := l_deAAC.LikeStateHolder;
 finally
  l_deAAC := nil;
 end;
//#UC END# *47F37DF001FE_4FF2E6B003C4_impl*
end;//TsdsAAC.DataExchange
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsAAC.GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
//#UC START# *491B02D80112_4FF2E6B003C4_var*
//#UC END# *491B02D80112_4FF2E6B003C4_var*
begin
//#UC START# *491B02D80112_4FF2E6B003C4_impl*
 Result := (_SetType_(Self) = aDataSource);
 // - сборки для ААК всегда отличаются,
 //   т.к. блоки в правой или левой половинах могут менятся
 if not Result AND (aDataSource <> nil) then
  if Self.pm_GetDocInfo.Pos.EQ(aDataSource.DocInfo.Pos) then
   Result := inherited GetIsNeedChangePosition(aDataSource);
//#UC END# *491B02D80112_4FF2E6B003C4_impl*
end;//TsdsAAC.GetIsNeedChangePosition
{$IfEnd} // NOT Defined(NoVCM)

function TsdsAAC.BaseDocumentClass: IdsBaseDocument;
//#UC START# *4925B1EC0100_4FF2E6B003C4_var*
//#UC END# *4925B1EC0100_4FF2E6B003C4_var*
begin
//#UC START# *4925B1EC0100_4FF2E6B003C4_impl*
 Result := pm_GetLeft;
 //Result := inherited BaseDocumentClass;
//#UC END# *4925B1EC0100_4FF2E6B003C4_impl*
end;//TsdsAAC.BaseDocumentClass

procedure TsdsAAC.ClearAllDS;
//#UC START# *4925B7F00156_4FF2E6B003C4_var*
//#UC END# *4925B7F00156_4FF2E6B003C4_var*
begin
//#UC START# *4925B7F00156_4FF2E6B003C4_impl*
 inherited;
 if (f_Container <> nil) then f_Container.Referred := nil;
 if (f_Left <> nil) then f_Left.Referred := nil;
 if (f_Right <> nil) then f_Right.Referred := nil;
//#UC END# *4925B7F00156_4FF2E6B003C4_impl*
end;//TsdsAAC.ClearAllDS

{$If NOT Defined(NoVCM)}
procedure TsdsAAC.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_4FF2E6B003C4_var*
//#UC END# *4938F7E702B7_4FF2E6B003C4_var*
begin
//#UC START# *4938F7E702B7_4FF2E6B003C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4938F7E702B7_4FF2E6B003C4_impl*
end;//TsdsAAC.ClearAreas
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsAAC.DoGetTabCaption: IvcmCString;
//#UC START# *54CF10260215_4FF2E6B003C4_var*
//#UC END# *54CF10260215_4FF2E6B003C4_var*
begin
//#UC START# *54CF10260215_4FF2E6B003C4_impl*
 Result := nsGetDocumentName(pm_GetDocInfo.Doc);
//#UC END# *54CF10260215_4FF2E6B003C4_impl*
end;//TsdsAAC.DoGetTabCaption
{$IfEnd} // NOT Defined(NoVCM)

{$If NOT Defined(NoVCM)}
function TsdsAAC.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_4FF2E6B003C4_var*
var
 l_Inner: _InitDataType_;
//#UC END# *55C1DD070354_4FF2E6B003C4_var*
begin
//#UC START# *55C1DD070354_4FF2E6B003C4_impl*
 l_Inner := inherited GetDataForClone;
 Result := TdeAAC.Make(l_Inner, f_DocumentLikeStateHolder);
//#UC END# *55C1DD070354_4FF2E6B003C4_impl*
end;//TsdsAAC.GetDataForClone
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
