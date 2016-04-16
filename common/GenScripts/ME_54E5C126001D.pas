unit nsQueryAttribute;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsQueryAttribute.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsQueryAttribute" MUID: (54E5C126001D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3CacheableBase
 , nsQueryInterfaces
 , evQueryCardInt
 , l3Interfaces
 , l3CObjectRefList
 , DynamicTreeUnit
 , SearchDomainInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
 , nsTypes
 , nevBase
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , SearchUnit
 , ContextHistoryInterfaces
 , nevTools
 , BaseTreeSupportUnit
 , afwInterfaces
 , BaseSearchInterfaces
;

type
 TqaReqClass = class of TqaReq;

 TqaReq = class(Tl3CacheableBase, IqaReq)
  {* Реквизит. }
  private
   f_MgrSearch: IqaMgrSearch;
   f_EditorReq: IevReq;
    {* Интерфейс реквизита из редактора. }
  protected
   function pm_GetMulti: Boolean; virtual;
   function GetCanAdd: Boolean; virtual;
   function GetCanOpenTree: Boolean; virtual;
   function DoGetReqAsString(const aSeparator: Il3CString): Il3CString; virtual;
   procedure DoMakeFieldValue; virtual;
   procedure DoLoad; virtual;
   procedure DoOpenSelectWindow; virtual;
   procedure DoCheckAttr; virtual;
   procedure DoReqClear; virtual;
   procedure MakeChangedReq;
   function IsAttrValid: Boolean;
   procedure DoOperateChanged; virtual;
   function BeforeGroupCollapse: Boolean; virtual;
   procedure SaveReq; virtual; abstract;
   function IsEditEmpty: Boolean;
   procedure DeleteEmptyValues;
   function CheckFromControl(out aExceptionClass: EaqExceptionClass;
    out aMessage: AnsiString;
    out aControl: IevEditorControlField): Boolean; virtual;
   function DoGetReqAsStrings: Il3StringsEx; virtual;
   function Get_EditorReq: IevReq;
   function Get_TagCaption: Il3CString;
   function Get_TagName: Il3CString;
   function Get_Modified: Boolean;
   procedure Set_Modified(aValue: Boolean);
   function Get_Multi: Boolean;
   function CanAdd: Boolean;
    {* Проверяет можно ли добавить еще одно поле к реквизиту }
   function CanOpenTree: Boolean;
    {* Проверяет можно ли открыть окно выбора реквизита }
   function GetReqAsString(const aSeparator: Il3CString): Il3CString;
   procedure Save;
   procedure Load;
   procedure CheckAttr;
   procedure ReqClear;
   procedure OpenSelectWindow;
   function IsSet(aElseDefaultValue: Boolean = False): Boolean;
    {* Если True, то в компоненте установлено значение }
   procedure MakeFieldValue;
   function GetReqAsStrings: Il3StringsEx;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   procedure Clear; virtual;
   constructor Create(const aMgrSearch: IqaMgrSearch;
    const aEditorReq: IevReq); reintroduce; virtual;
   class function Make(const aMgrSearch: IqaMgrSearch;
    const aEditorReq: IevReq): IqaReq;
  public
   property Multi: Boolean
    read pm_GetMulti;
 end;//TqaReq

 TqaAttrInfo = class(Tl3CObjectRefList)
  {* Предназначен для сохранения IDictNode и типа операции. }
  private
   f_NodeBase: INodeBase;
   f_Mask: Il3CString;
   f_Oper: TLogicOperation;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(aOper: TLogicOperation = SearchDomainInterfaces.loNone;
    const aNode: INodeBase = nil;
    const aMask: Il3CString = nil); reintroduce; virtual;
  public
   property NodeBase: INodeBase
    read f_NodeBase;
   property Mask: Il3CString
    read f_Mask
    write f_Mask;
   property Oper: TLogicOperation
    read f_Oper
    write f_Oper;
 end;//TqaAttrInfo

 {$Define l3Items_NoSort}

 _ItemType_ = TqaAttrInfo;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TqaAttrInfoList = class(_l3UncomparabeObjectRefList_)
  {* Список описателей атрибутов. }
 end;//TqaAttrInfoList

 TqaEventReq = class(TqaReq, IevModelListener)
  {* Класс создан исключительно ради поддержки интерфейса IevModelListner. }
  protected
   function pm_GetAdditionalFilter: TnsFilterType; virtual;
   function GetHint4Button(const aValue: IevEditorControlButton): Il3CString; virtual;
   function StateIndex2LogicState(aValue: Integer): TLogicOperation;
   procedure DoEnterPressed; virtual;
   procedure DoTextChange; virtual;
   procedure DoAfterSetText(const aField: IevEditorControlField); virtual;
   function DoAnalyzeString(const aValue: Il3CString;
    out aRslt: Il3CString): Boolean; virtual;
   procedure DoHyperLinkClick; virtual;
   procedure EnterPressed;
    {* Обработчик нажатия на "Enter". }
   function GetHint(const aValue: IevEditorControl): Il3CString;
    {* Возвращает хинт для поля. }
   function GetImage(Index: Integer;
    var aImages: InevImageList): Integer;
    {* Возвращает номер картинки и массив картинок для отображения. }
   function AnalyzeString(const aValue: Il3CString;
    out aRslt: Il3CString): Boolean;
    {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
   function CheckValue(const aField: IevEditorControlField): Boolean;
    {* Проверка значения поля. }
   procedure TextChange;
    {* Обработчик изменения текста в поле. }
   procedure AfterSetText(const aField: IevEditorControlField);
    {* Обработчик присвоения полю нового значения - срабатывает после выбора
          значения в дереве. }
   procedure HyperLinkClick;
    {* Обработка щелчка по ссылки. }
  protected
   property AdditionalFilter: TnsFilterType
    read pm_GetAdditionalFilter;
 end;//TqaEventReq

 TqaReqComboField = class(TqaEventReq)
  protected
   function DoGetReqAsString(const aSeparator: Il3CString): Il3CString; override;
   procedure DoCheckAttr; override;
   procedure DoReqClear; override;
   function CheckFromControl(out aExceptionClass: EaqExceptionClass;
    out aMessage: AnsiString;
    out aControl: IevEditorControlField): Boolean; override;
 end;//TqaReqComboField

 TqaCustomReqContext = class(TqaReqComboField)
  protected
   procedure SaveReq; override;
   function GetCanAdd: Boolean; override;
   procedure DoLoad; override;
   procedure DoEnterPressed; override;
   function DoAnalyzeString(const aValue: Il3CString;
    out aRslt: Il3CString): Boolean; override;
   function DoGetReqAsStrings: Il3StringsEx; override;
  public
   procedure FillReqListAsString(const aList: Il3StringsEx);
   constructor Create(const aMgrSearch: IqaMgrSearch;
    const aEditorReq: IevReq); override;
 end;//TqaCustomReqContext

 TqaReqContext = class(TqaCustomReqContext, IqaMorphoReq)
  protected
   procedure DoCheckAttr; override;
 end;//TqaReqContext

 TqaCommonStrReq = class(TqaCustomReqContext)
  protected
   procedure DoLoad; override;
   procedure DoReqClear; override;
   procedure SaveReq; override;
   procedure DoTextChange; override;
 end;//TqaCommonStrReq

 TqaReqMemo = class(TqaCommonStrReq)
 end;//TqaReqMemo

 TqaReqStr = class(TqaCommonStrReq)
  protected
   function pm_GetMulti: Boolean; override;
   procedure DoMakeFieldValue; override;
   procedure DoLoad; override;
   procedure DoReqClear; override;
 end;//TqaReqStr

 TqaReqEMail = class(TqaReqStr)
  protected
   procedure DoCheckAttr; override;
   function CheckFromControl(out aExceptionClass: EaqExceptionClass;
    out aMessage: AnsiString;
    out aControl: IevEditorControlField): Boolean; override;
 end;//TqaReqEMail

 TqaReqAttribute = class(TqaReqComboField, IqaReqAttribute)
  private
   function Root: INodeBase;
   procedure SetAttributesToView;
  protected
   procedure SaveFieldToQuery(const aValue: IevEditorControlField);
   function FieldLogicOperation(const aValue: IevEditorFieldWithTree): TLogicOperation;
   procedure LoadField(const aValue: IevEditorFieldWithTree;
    aLogicOper: TLogicOperation;
    const aNode: INodeBase);
   procedure GetAttributesFromView(const aRoot: INodeBase);
    {* Вычитываем флаги операций из дерева (создаёт поля ввода) и устанавливаем фокус в последнее добавленное поле }
   procedure SaveReq; override;
   function GetCanAdd: Boolean; override;
   function GetCanOpenTree: Boolean; override;
   procedure DoLoad; override;
   procedure DoOpenSelectWindow; override;
   procedure DoOperateChanged; override;
   procedure DoEnterPressed; override;
   procedure DoAfterSetText(const aField: IevEditorControlField); override;
   function DoGetReqAsStrings: Il3StringsEx; override;
 end;//TqaReqAttribute

 TqaReqNum = class(TqaReqAttribute)
  protected
   procedure InitFields; override;
 end;//TqaReqNum

 TqaReqDate = class(TqaEventReq, IqaDateReq)
  protected
   function Get_StartDate: TDateTime;
   procedure Set_StartDate(aValue: TDateTime);
   function Get_EndDate: TDateTime;
   procedure Set_EndDate(aValue: TDateTime);
   procedure SaveReq; override;
   procedure InitFields; override;
   function pm_GetMulti: Boolean; override;
   function GetCanOpenTree: Boolean; override;
   procedure DoLoad; override;
   procedure DoOpenSelectWindow; override;
   procedure DoCheckAttr; override;
   procedure DoReqClear; override;
   function BeforeGroupCollapse: Boolean; override;
   function CheckFromControl(out aExceptionClass: EaqExceptionClass;
    out aMessage: AnsiString;
    out aControl: IevEditorControlField): Boolean; override;
   function GetHint4Button(const aValue: IevEditorControlButton): Il3CString; override;
   procedure DoEnterPressed; override;
   procedure DoHyperLinkClick; override;
  public
   property StartDate: TDateTime
    read Get_StartDate
    write Set_StartDate;
   property EndDate: TDateTime
    read Get_EndDate
    write Set_EndDate;
 end;//TqaReqDate

 TqaReqPhone = class(TqaEventReq, IqaPhoneReq)
  protected
   function Get_Code: Il3CString;
   procedure Set_Code(const aValue: Il3CString);
   function Get_Number: Il3CString;
   procedure Set_Number(const aValue: Il3CString);
   procedure SaveReq; override;
   function pm_GetMulti: Boolean; override;
   function GetCanOpenTree: Boolean; override;
   procedure DoLoad; override;
   procedure DoReqClear; override;
  public
   property Code: Il3CString
    read Get_Code
    write Set_Code;
   property Number: Il3CString
    read Get_Number
    write Set_Number;
 end;//TqaReqPhone

 TqaDateReqDataHolder = class({$If NOT Defined(NoVCM)}
 TvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , IqaDateReqDataHolder)
  private
   f_ReqCaption: Il3CString;
   f_StartDate: TDateTime;
   f_EndDate: TDateTime;
   f_IsOk: Boolean;
  protected
   function Get_StartDate: TDateTime;
   procedure Set_StartDate(aValue: TDateTime);
   function Get_EndDate: TDateTime;
   procedure Set_EndDate(aValue: TDateTime);
   function Get_IsOk: Boolean;
   procedure Set_IsOk(aValue: Boolean);
   function Get_ReqCaption: Il3CString;
   function IsStartDateEmpty: Boolean;
   function IsEndDateEmpty: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aReq: IqaDateReq); reintroduce;
   class function Make(const aReq: IqaDateReq): IqaDateReqDataHolder;
  public
   property ReqCaption: Il3CString
    read Get_ReqCaption;
   property StartDate: TDateTime
    read Get_StartDate
    write Set_StartDate;
   property EndDate: TDateTime
    read Get_EndDate
    write Set_EndDate;
   property IsOk: Boolean
    read Get_IsOk
    write Set_IsOk;
 end;//TqaDateReqDataHolder

{$If NOT Defined(Monitorings)}
 InsMisatakesCorrectorForNemesis = InsMistakesCorrector;
{$IfEnd} // NOT Defined(Monitorings)

 TqaMgrSearch = class({$If NOT Defined(NoVCM)}
 TvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , IqaMgrSearch, IevAdapterModel{$If NOT Defined(Monitorings)}
 , InsMisatakesCorrectorForNemesis
 {$IfEnd} // NOT Defined(Monitorings)
 )
  private
   f_FormName: Il3CString;
   f_OnDateQuery: TOnDateQuery;
   f_OnNeedExecQuery: TNotifyEvent;
   f_OnModifiedChanged: TNotifyEvent;
   f_InModifiedChanged: Integer;
   f_Modified: Integer;
   f_GettingAttributesFromView: Integer;
   {$If NOT Defined(Monitorings)}
   f_ContextHistory: InsContextSearchHistory;
   {$IfEnd} // NOT Defined(Monitorings)
   f_FirstErrorContextReq: IevEditorControlField;
   f_IsQueryNew: Boolean;
   f_QueryType: TlgQueryType;
   f_QueryCard: IevQueryCard;
   f_FromHistory: Boolean;
   f_Query: IQuery;
  private
   function NeedSettings: Boolean;
   procedure FinishEntering;
   function MakeGroupsSettingId: Il3CString;
   function MakeDescriptionsSettingId: Il3CString;
  protected
   procedure DoFocusStartField; virtual;
   function GetCurrentEditorReq: IevReq;
   procedure IterateAttrsF(anAction: Tl3FreeAction);
   procedure CallModifiedChanged;
   procedure ClearAttrs;
   function Get_Query: IQuery;
   procedure Set_Query(const aValue: IQuery);
   procedure FocusStartField;
    {* Устанавливает фокус на первый элемент. }
   procedure LimitCharsReached(const aControl: IevEditorControl);
   function GetTreeFromAdapter(const aReq: Il3CString): InevSimpleTree;
    {* Получает дерево с адаптера. }
   procedure EscPressed(const aField: IevEditorFieldWithTree);
    {* Обработчик закрытия дерева по ESC. }
   {$If NOT Defined(Monitorings)}
   function Get_HistoryList: Il3StringsEx;
   {$IfEnd} // NOT Defined(Monitorings)
   function ModelListener(const aReq: IevReq): IevModelListener;
   function GetPromptTreeFromAdapter: InevSimpleTree;
   procedure NotifyContextWrong;
   procedure Correct(const aCorrectedContext: Il3StringsEx;
    const aMistakesList: Il3StringsEx);
   function Get_QueryType: TlgQueryType;
   function Get_IsQueryNew: Boolean;
   function Get_Modified: Boolean;
   procedure Set_Modified(aValue: Boolean);
   function Get_FromHistory: Boolean;
   procedure Set_FromHistory(aValue: Boolean);
   function Get_QueryCard: IevQueryCard;
   {$If NOT Defined(Monitorings)}
   function Get_HistoryValues: IvcmStrings;
   {$IfEnd} // NOT Defined(Monitorings)
   procedure FinishOpenTree(const aRoot: INodeBase;
    const aReq: IqaReq);
   procedure ReadSettings;
   procedure WriteSettings;
   procedure InitUpdate;
   procedure Clear;
   procedure ClearContextMistakes;
   procedure AddValue(const aView: InevView);
   procedure DeleteValue(const aView: InevView);
   procedure DeleteAll;
   procedure OpenSelectWindow;
   function ChangableReq: IqaReq;
    {* Изменяющаеся значение при изменении реквизита }
   function GetName4Query: Il3CString;
    {* Возвращают имя для запроса }
   function GetCurrentReq: IqaReq;
    {* Возвращает текущий реквизит для контрола }
   function GetCurrentField: IevEditorControlField;
    {* Возвращает текущий контрол для реквизита }
   procedure CreateTree(const aQueryCard: IevQueryCard);
   function Save(aIgnoreError: Boolean = False): Boolean;
   procedure Load;
   function IsSomeFieldFilled(aElseDefaultValue: Boolean): Boolean;
   procedure ChangeStateAll(aExpand: Boolean);
   procedure Check;
   procedure DateQuery(const aValue: IqaDateReq);
   procedure ModifiedChanged(aValue: Boolean);
   procedure ExecQuery;
   function FindAttr(const aTagName: Il3CString): IqaReq;
    {* Возвращает атрибут по имени }
   function GettingFromView: Boolean;
   procedure StartGettingFromView;
   procedure FinishGettingFromView;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure ClearFields; override;
  public
   {$If NOT Defined(Monitorings)}
   constructor Create(const aQuery: IQuery;
    aQueryType: TlgQueryType;
    const aFormName: Il3CString;
    OnDateQuery: TOnDateQuery;
    OnNeedExecQuery: TNotifyEvent;
    OnModifiedChanged: TNotifyEvent;
    const aContextHistory: InsContextSearchHistory); reintroduce; overload; virtual;
   {$IfEnd} // NOT Defined(Monitorings)
   {$If NOT Defined(Monitorings)}
   class function Make(const aQuery: IQuery;
    aQueryType: TlgQueryType;
    const aFormName: Il3CString;
    OnDateQuery: TOnDateQuery;
    OnNeedExecQuery: TNotifyEvent;
    OnModifiedChanged: TNotifyEvent;
    const aContextHistory: InsContextSearchHistory): IqaMgrSearch; reintroduce; overload;
   {$IfEnd} // NOT Defined(Monitorings)
   {$If Defined(Monitorings)}
   constructor Create(const aQuery: IQuery;
    aQueryType: TlgQueryType;
    const aFormName: Il3CString;
    OnDateQuery: TOnDateQuery;
    OnNeedExecQuery: TNotifyEvent;
    OnModifiedChanged: TNotifyEvent); reintroduce; overload; virtual;
   {$IfEnd} // Defined(Monitorings)
   {$If Defined(Monitorings)}
   class function Make(const aQuery: IQuery;
    aQueryType: TlgQueryType;
    const aFormName: Il3CString;
    OnDateQuery: TOnDateQuery;
    OnNeedExecQuery: TNotifyEvent;
    OnModifiedChanged: TNotifyEvent): IqaMgrSearch; reintroduce; overload;
   {$IfEnd} // Defined(Monitorings)
   procedure CheckAttrs;
   {$If NOT Defined(Monitorings)}
   procedure CheckMorpho;
   {$IfEnd} // NOT Defined(Monitorings)
   procedure InitFocus;
  public
   property Modified: Boolean
    read Get_Modified
    write Set_Modified;
   property IsQueryNew: Boolean
    read Get_IsQueryNew;
   property QueryType: TlgQueryType
    read Get_QueryType;
   {$If NOT Defined(Monitorings)}
   property HistoryValues: IvcmStrings
    read Get_HistoryValues;
   {$IfEnd} // NOT Defined(Monitorings)
   property QueryCard: IevQueryCard
    read Get_QueryCard
    write f_QueryCard;
   property FromHistory: Boolean
    read Get_FromHistory
    write Set_FromHistory;
   property Query: IQuery
    read Get_Query
    write Set_Query;
 end;//TqaMgrSearch

 TqaMgrSearchForNewsLine = class(TqaMgrSearch)
  protected
   procedure DoFocusStartField; override;
 end;//TqaMgrSearchForNewsLine

 _afwApplicationDataUpdate_Parent_ = Tl3CacheableBase;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}
 TqaHistory = class(_afwApplicationDataUpdate_, IqaHistory{$If NOT Defined(NoVCM)}
 , IvcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 )
  private
   f_Filter: INode;
   f_Query: IQuery;
   f_DataReset: Boolean;
   f_ConsultationSened: Boolean;
  protected
   function Get_Query: IQuery;
   procedure Set_Query(const aValue: IQuery);
   function Get_Filter: INode;
   procedure Set_Filter(const aValue: INode);
   function Get_DataReset: Boolean;
   function Get_ConsultationSended: Boolean;
   procedure Set_ConsultationSended(aValue: Boolean);
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure FinishDataUpdate; override;
 end;//TqaHistory
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3String
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , k2Tags
 , evControlParaTools
 , evdTypes
 , DebugStr
 , l3Base
 , nsContextUtils
 , nsQueryUtils
 , l3Bits
 , l3TreeInterfaces
 , l3ImageList
 {$If NOT Defined(NoVCM)}
 , vcmStringList
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Math
 , nsVerifyValue
 , nsAttributeTreeCacheNew
 , nsLogicOperationToFlags
 , nsTreeUtils
 , nsAttributeTreeStruct
 , nsINodeWrap
 , afwFacade
 , nsUtils
 , SystemStr
 , l3Date
 , nsConst
 , bsUtils
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , bsInterfaces
 , evTypes
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evSearch
 , evdStyles
 {$If Defined(k2ForEditor)}
 , evSegLst
 {$IfEnd} // Defined(k2ForEditor)
 , nsSearchClasses
 , nsQuery
 , nsbQueryUtils
 , l3MinMax
 , RTLConsts
 , SearchRes
;

type
 T01Range = 0 .. 1;

 T01String = array [T01Range] of AnsiString;

const
 cSrc: T01String = (AT_ANNO_KIND, AT_ANNO_USER);

function TqaReq.pm_GetMulti: Boolean;
//#UC START# *54E5C23D016C_46839C340218get_var*
var
 l_EdComboReq: IevComboReq;
//#UC END# *54E5C23D016C_46839C340218get_var*
begin
//#UC START# *54E5C23D016C_46839C340218get_impl*
 if not Supports(f_EditorReq, IevComboReq, l_EdComboReq) then
  Assert(False);
 Result := l_EdComboReq.IsMulti;
//#UC END# *54E5C23D016C_46839C340218get_impl*
end;//TqaReq.pm_GetMulti

function TqaReq.GetCanAdd: Boolean;
//#UC START# *54E5C2970015_46839C340218_var*
//#UC END# *54E5C2970015_46839C340218_var*
begin
//#UC START# *54E5C2970015_46839C340218_impl*
 Result := False;
//#UC END# *54E5C2970015_46839C340218_impl*
end;//TqaReq.GetCanAdd

function TqaReq.GetCanOpenTree: Boolean;
//#UC START# *54E5C2C801EC_46839C340218_var*
//#UC END# *54E5C2C801EC_46839C340218_var*
begin
//#UC START# *54E5C2C801EC_46839C340218_impl*
 Result := False;
//#UC END# *54E5C2C801EC_46839C340218_impl*
end;//TqaReq.GetCanOpenTree

function TqaReq.DoGetReqAsString(const aSeparator: Il3CString): Il3CString;
//#UC START# *54E5C312006A_46839C340218_var*
//#UC END# *54E5C312006A_46839C340218_var*
begin
//#UC START# *54E5C312006A_46839C340218_impl*
 Result := nil;
//#UC END# *54E5C312006A_46839C340218_impl*
end;//TqaReq.DoGetReqAsString

procedure TqaReq.DoMakeFieldValue;
//#UC START# *54E5C6020026_46839C340218_var*
//#UC END# *54E5C6020026_46839C340218_var*
begin
//#UC START# *54E5C6020026_46839C340218_impl*
//#UC END# *54E5C6020026_46839C340218_impl*
end;//TqaReq.DoMakeFieldValue

procedure TqaReq.DoLoad;
//#UC START# *54E5C6B2036C_46839C340218_var*
//#UC END# *54E5C6B2036C_46839C340218_var*
begin
//#UC START# *54E5C6B2036C_46839C340218_impl*
//#UC END# *54E5C6B2036C_46839C340218_impl*
end;//TqaReq.DoLoad

procedure TqaReq.DoOpenSelectWindow;
//#UC START# *54E5C719014A_46839C340218_var*
//#UC END# *54E5C719014A_46839C340218_var*
begin
//#UC START# *54E5C719014A_46839C340218_impl*
//#UC END# *54E5C719014A_46839C340218_impl*
end;//TqaReq.DoOpenSelectWindow

procedure TqaReq.DoCheckAttr;
//#UC START# *54E5C744010C_46839C340218_var*
//#UC END# *54E5C744010C_46839C340218_var*
begin
//#UC START# *54E5C744010C_46839C340218_impl*
 if f_EditorReq.IsRequired and not IsSet(False) then
  raise EqaRequiredValue.CreateFmt(Get_EditorReq.FirstField,
                                   vcmConstString(str_RequiredValue),
                                              [nsEStr(Get_EditorReq.ReqCaption)]);
//#UC END# *54E5C744010C_46839C340218_impl*
end;//TqaReq.DoCheckAttr

procedure TqaReq.DoReqClear;
//#UC START# *54E5C772012F_46839C340218_var*
//#UC END# *54E5C772012F_46839C340218_var*
begin
//#UC START# *54E5C772012F_46839C340218_impl*
//#UC END# *54E5C772012F_46839C340218_impl*
end;//TqaReq.DoReqClear

procedure TqaReq.MakeChangedReq;
//#UC START# *54E5C80B0342_46839C340218_var*
var
 l_CR: IqaReq;
//#UC END# *54E5C80B0342_46839C340218_var*
begin
//#UC START# *54E5C80B0342_46839C340218_impl*
 if l3SomeOf(Get_TagName, cSrc) then
 begin
  l_CR := f_MgrSearch.ChangableReq;
  if (l_CR <> nil) then
   l_CR.MakeFieldValue;
 end;//l3Same(Get_TagName, cSrc)
//#UC END# *54E5C80B0342_46839C340218_impl*
end;//TqaReq.MakeChangedReq

function TqaReq.IsAttrValid: Boolean;
//#UC START# *54E5C83801F9_46839C340218_var*
var
 l_Exception: EaqExceptionClass;
 l_Message: AnsiString;
 l_Control: IevEditorControlField;
//#UC END# *54E5C83801F9_46839C340218_var*
begin
//#UC START# *54E5C83801F9_46839C340218_impl*
 Result := CheckFromControl(l_Exception, l_Message, l_Control);
//#UC END# *54E5C83801F9_46839C340218_impl*
end;//TqaReq.IsAttrValid

procedure TqaReq.DoOperateChanged;
//#UC START# *54E5C85002FA_46839C340218_var*
//#UC END# *54E5C85002FA_46839C340218_var*
begin
//#UC START# *54E5C85002FA_46839C340218_impl*
 {$ifndef Admin}
 if Get_Modified then
  MakeChangedReq;
 {$endif}
//#UC END# *54E5C85002FA_46839C340218_impl*
end;//TqaReq.DoOperateChanged

function TqaReq.BeforeGroupCollapse: Boolean;
//#UC START# *54E5C8690080_46839C340218_var*
//#UC END# *54E5C8690080_46839C340218_var*
begin
//#UC START# *54E5C8690080_46839C340218_impl*
 Result := True;
//#UC END# *54E5C8690080_46839C340218_impl*
end;//TqaReq.BeforeGroupCollapse

function TqaReq.IsEditEmpty: Boolean;
//#UC START# *54E5C89F0045_46839C340218_var*
//#UC END# *54E5C89F0045_46839C340218_var*
begin
//#UC START# *54E5C89F0045_46839C340218_impl*
 Result := not IsSet(True);
//#UC END# *54E5C89F0045_46839C340218_impl*
end;//TqaReq.IsEditEmpty

procedure TqaReq.DeleteEmptyValues;
//#UC START# *54E5C8B6016B_46839C340218_var*
var
 l_Index: Integer;
 l_ComboField: IevEditorFieldWithTree;
//#UC END# *54E5C8B6016B_46839C340218_var*
begin
//#UC START# *54E5C8B6016B_46839C340218_impl*
 if f_EditorReq.FieldsCount > 0 then
  for l_Index := f_EditorReq.FieldsCount - 1 downto 0 do
   if Supports(f_EditorReq.Fields[l_Index], IevEditorFieldWithTree, l_ComboField) and
      l_ComboField.IsFieldEmpty then
    f_EditorReq.DeleteField(nil, f_EditorReq.Fields[l_Index]);
//#UC END# *54E5C8B6016B_46839C340218_impl*
end;//TqaReq.DeleteEmptyValues

procedure TqaReq.Clear;
//#UC START# *54E5D1420183_46839C340218_var*
//#UC END# *54E5D1420183_46839C340218_var*
begin
//#UC START# *54E5D1420183_46839C340218_impl*
 ReqClear;
 Set_Modified(True);
//#UC END# *54E5D1420183_46839C340218_impl*
end;//TqaReq.Clear

constructor TqaReq.Create(const aMgrSearch: IqaMgrSearch;
 const aEditorReq: IevReq);
//#UC START# *54E5D16303C7_46839C340218_var*
//#UC END# *54E5D16303C7_46839C340218_var*
begin
//#UC START# *54E5D16303C7_46839C340218_impl*
 inherited Create;
 f_MgrSearch := aMgrSearch;
 f_EditorReq := aEditorReq;
//#UC END# *54E5D16303C7_46839C340218_impl*
end;//TqaReq.Create

class function TqaReq.Make(const aMgrSearch: IqaMgrSearch;
 const aEditorReq: IevReq): IqaReq;
//#UC START# *54E5D18A0342_46839C340218_var*
var
 l_Req: TqaReq;
 l_CType: TevControlType;
 l_ReqClass: TqaReqClass;
 l_EdReq: IevComboReq;
//#UC END# *54E5D18A0342_46839C340218_var*
begin
//#UC START# *54E5D18A0342_46839C340218_impl*
 if (aEditorReq <> nil) then
  l_CType := aEditorReq.FirstField.ControlType
 else
  l_CType := ev_ctCombo;
 case l_CType of
  ev_ctEdit:
   l_ReqClass := TqaReqStr;
  ev_ctEmailEdit:
   l_ReqClass := TqaReqEMail;
  ev_ctMemoEdit:
   l_ReqClass := TqaReqMemo;
  ev_ctCombo:
  begin
   if Supports(aEditorReq, IevComboReq, l_EdReq) then
   begin
    if l_EdReq.IsContext then
     l_ReqClass := TqaReqContext
    else
    if aEditorReq.Para.AsObject.BoolA[k2_tiNumList] then
     l_ReqClass := TqaReqNum
    else
     l_ReqClass := TqaReqAttribute;
   end//Supports(aEditorReq, IevComboReq, l_EdReq)
   else
    l_ReqClass := TqaReqAttribute;
  end;//ev_ctCombo
  ev_ctCalEdit:
   l_ReqClass := TqaReqDate;
  ev_ctPhoneEdit:
   l_ReqClass := TqaReqPhone;
  else
   l_ReqClass := nil;
 end;//case l_CType
 Assert(Assigned(l_ReqClass), caUnsuppotedAttributeType);
 l_Req := l_ReqClass.Create(aMgrSearch, aEditorReq);
 try
  Result := l_Req;
 finally
  l3Free(l_Req);
 end;//try..finally 
//#UC END# *54E5D18A0342_46839C340218_impl*
end;//TqaReq.Make

function TqaReq.CheckFromControl(out aExceptionClass: EaqExceptionClass;
 out aMessage: AnsiString;
 out aControl: IevEditorControlField): Boolean;
//#UC START# *54E5D1D5002A_46839C340218_var*
//#UC END# *54E5D1D5002A_46839C340218_var*
begin
//#UC START# *54E5D1D5002A_46839C340218_impl*
 aExceptionClass := nil;
 aMessage := '';
 aControl := nil;
 Result := True;
//#UC END# *54E5D1D5002A_46839C340218_impl*
end;//TqaReq.CheckFromControl

function TqaReq.DoGetReqAsStrings: Il3StringsEx;
//#UC START# *555495740306_46839C340218_var*
//#UC END# *555495740306_46839C340218_var*
begin
//#UC START# *555495740306_46839C340218_impl*
 Result := nil;
//#UC END# *555495740306_46839C340218_impl*
end;//TqaReq.DoGetReqAsStrings

function TqaReq.Get_EditorReq: IevReq;
//#UC START# *46837AD603C1_46839C340218get_var*
//#UC END# *46837AD603C1_46839C340218get_var*
begin
//#UC START# *46837AD603C1_46839C340218get_impl*
 Result := f_EditorReq;
//#UC END# *46837AD603C1_46839C340218get_impl*
end;//TqaReq.Get_EditorReq

function TqaReq.Get_TagCaption: Il3CString;
//#UC START# *46837B020021_46839C340218get_var*
//#UC END# *46837B020021_46839C340218get_var*
begin
//#UC START# *46837B020021_46839C340218get_impl*
 Result := f_EditorReq.ReqCaption;
//#UC END# *46837B020021_46839C340218get_impl*
end;//TqaReq.Get_TagCaption

function TqaReq.Get_TagName: Il3CString;
//#UC START# *46837B1D02AB_46839C340218get_var*
//#UC END# *46837B1D02AB_46839C340218get_var*
begin
//#UC START# *46837B1D02AB_46839C340218get_impl*
 Result := f_EditorReq.ReqName;
//#UC END# *46837B1D02AB_46839C340218get_impl*
end;//TqaReq.Get_TagName

function TqaReq.Get_Modified: Boolean;
//#UC START# *4CD0181A0355_46839C340218get_var*
//#UC END# *4CD0181A0355_46839C340218get_var*
begin
//#UC START# *4CD0181A0355_46839C340218get_impl*
 Result := f_EditorReq.Para.AsObject.BoolA[k2_tiModified];
//#UC END# *4CD0181A0355_46839C340218get_impl*
end;//TqaReq.Get_Modified

procedure TqaReq.Set_Modified(aValue: Boolean);
//#UC START# *4CD0181A0355_46839C340218set_var*
//#UC END# *4CD0181A0355_46839C340218set_var*
begin
//#UC START# *4CD0181A0355_46839C340218set_impl*
 with f_EditorReq.Para do
  if (AsObject.BoolA[k2_tiModified] <> aValue) then
  begin
   AsObject.BoolA[k2_tiModified] := aValue;
   if Assigned(f_MgrSearch) then
    f_MgrSearch.ModifiedChanged(aValue);
  end;//BoolA[k2_tiModified] <> Value
//#UC END# *4CD0181A0355_46839C340218set_impl*
end;//TqaReq.Set_Modified

function TqaReq.Get_Multi: Boolean;
//#UC START# *5232E86900DB_46839C340218get_var*
//#UC END# *5232E86900DB_46839C340218get_var*
begin
//#UC START# *5232E86900DB_46839C340218get_impl*
 Result := pm_GetMulti;
//#UC END# *5232E86900DB_46839C340218get_impl*
end;//TqaReq.Get_Multi

function TqaReq.CanAdd: Boolean;
 {* Проверяет можно ли добавить еще одно поле к реквизиту }
//#UC START# *5232E8A0007B_46839C340218_var*
//#UC END# *5232E8A0007B_46839C340218_var*
begin
//#UC START# *5232E8A0007B_46839C340218_impl*
 Result := GetCanAdd;
//#UC END# *5232E8A0007B_46839C340218_impl*
end;//TqaReq.CanAdd

function TqaReq.CanOpenTree: Boolean;
 {* Проверяет можно ли открыть окно выбора реквизита }
//#UC START# *5232E8C7000B_46839C340218_var*
//#UC END# *5232E8C7000B_46839C340218_var*
begin
//#UC START# *5232E8C7000B_46839C340218_impl*
 Result := GetCanOpenTree;
//#UC END# *5232E8C7000B_46839C340218_impl*
end;//TqaReq.CanOpenTree

function TqaReq.GetReqAsString(const aSeparator: Il3CString): Il3CString;
//#UC START# *5232E8F20155_46839C340218_var*
//#UC END# *5232E8F20155_46839C340218_var*
begin
//#UC START# *5232E8F20155_46839C340218_impl*
 Result := DoGetReqAsString(aSeparator);
//#UC END# *5232E8F20155_46839C340218_impl*
end;//TqaReq.GetReqAsString

procedure TqaReq.Save;
//#UC START# *5232E907013E_46839C340218_var*
//#UC END# *5232E907013E_46839C340218_var*
begin
//#UC START# *5232E907013E_46839C340218_impl*
 DeleteEmptyValues;
 if IsSet then
  SaveReq;
 Set_Modified(False);
//#UC END# *5232E907013E_46839C340218_impl*
end;//TqaReq.Save

procedure TqaReq.Load;
//#UC START# *5232E92800F6_46839C340218_var*
//#UC END# *5232E92800F6_46839C340218_var*
begin
//#UC START# *5232E92800F6_46839C340218_impl*
 DoLoad;
//#UC END# *5232E92800F6_46839C340218_impl*
end;//TqaReq.Load

procedure TqaReq.CheckAttr;
//#UC START# *5232E9410043_46839C340218_var*
//#UC END# *5232E9410043_46839C340218_var*
begin
//#UC START# *5232E9410043_46839C340218_impl*
 DoCheckAttr;
//#UC END# *5232E9410043_46839C340218_impl*
end;//TqaReq.CheckAttr

procedure TqaReq.ReqClear;
//#UC START# *5232E94C01DD_46839C340218_var*
//#UC END# *5232E94C01DD_46839C340218_var*
begin
//#UC START# *5232E94C01DD_46839C340218_impl*
 DoReqClear;
//#UC END# *5232E94C01DD_46839C340218_impl*
end;//TqaReq.ReqClear

procedure TqaReq.OpenSelectWindow;
//#UC START# *5232E95400B8_46839C340218_var*
//#UC END# *5232E95400B8_46839C340218_var*
begin
//#UC START# *5232E95400B8_46839C340218_impl*
 DoOpenSelectWindow;
//#UC END# *5232E95400B8_46839C340218_impl*
end;//TqaReq.OpenSelectWindow

function TqaReq.IsSet(aElseDefaultValue: Boolean = False): Boolean;
 {* Если True, то в компоненте установлено значение }
//#UC START# *5232E98101D5_46839C340218_var*
//#UC END# *5232E98101D5_46839C340218_var*
begin
//#UC START# *5232E98101D5_46839C340218_impl*
 Result := evIsSomeFieldFilled(f_EditorReq, aElseDefaultValue);
//#UC END# *5232E98101D5_46839C340218_impl*
end;//TqaReq.IsSet

procedure TqaReq.MakeFieldValue;
//#UC START# *5232E9CB024E_46839C340218_var*
//#UC END# *5232E9CB024E_46839C340218_var*
begin
//#UC START# *5232E9CB024E_46839C340218_impl*
 DoMakeFieldValue;
//#UC END# *5232E9CB024E_46839C340218_impl*
end;//TqaReq.MakeFieldValue

function TqaReq.GetReqAsStrings: Il3StringsEx;
//#UC START# *5554953A023D_46839C340218_var*
//#UC END# *5554953A023D_46839C340218_var*
begin
//#UC START# *5554953A023D_46839C340218_impl*
 Result := DoGetReqAsStrings;
//#UC END# *5554953A023D_46839C340218_impl*
end;//TqaReq.GetReqAsStrings

procedure TqaReq.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_46839C340218_var*
//#UC END# *479731C50290_46839C340218_var*
begin
//#UC START# *479731C50290_46839C340218_impl*
 f_EditorReq := nil;
 f_MgrSearch := nil;
 inherited;
//#UC END# *479731C50290_46839C340218_impl*
end;//TqaReq.Cleanup

procedure TqaReq.ClearFields;
begin
 f_MgrSearch := nil;
 f_EditorReq := nil;
 inherited;
end;//TqaReq.ClearFields

constructor TqaAttrInfo.Create(aOper: TLogicOperation = SearchDomainInterfaces.loNone;
 const aNode: INodeBase = nil;
 const aMask: Il3CString = nil);
//#UC START# *54EC8AD90376_46839CF3010E_var*
//#UC END# *54EC8AD90376_46839CF3010E_var*
begin
//#UC START# *54EC8AD90376_46839CF3010E_impl*
 inherited Create;
 f_Oper := aOper;
 f_Mask := aMask;
 f_NodeBase := aNode;
//#UC END# *54EC8AD90376_46839CF3010E_impl*
end;//TqaAttrInfo.Create

procedure TqaAttrInfo.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_46839CF3010E_var*
//#UC END# *479731C50290_46839CF3010E_var*
begin
//#UC START# *479731C50290_46839CF3010E_impl*
 f_Mask := nil;
 f_NodeBase := nil;
 inherited;
//#UC END# *479731C50290_46839CF3010E_impl*
end;//TqaAttrInfo.Cleanup

procedure TqaAttrInfo.ClearFields;
begin
 f_NodeBase := nil;
 Mask := nil;
 inherited;
end;//TqaAttrInfo.ClearFields

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4683A23B009A_var*
//#UC END# *47B2C42A0163_4683A23B009A_var*
begin
//#UC START# *47B2C42A0163_4683A23B009A_impl*
 Assert(False);
//#UC END# *47B2C42A0163_4683A23B009A_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4683A23B009A_var*
//#UC END# *47B99D4503A2_4683A23B009A_var*
begin
//#UC START# *47B99D4503A2_4683A23B009A_impl*
 Assert(False);
 Result := 0;
//#UC END# *47B99D4503A2_4683A23B009A_impl*
end;//CompareExistingItems

type _Instance_R_ = TqaAttrInfoList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

function TqaEventReq.pm_GetAdditionalFilter: TnsFilterType;
//#UC START# *54F3492A02D7_4683A2660291get_var*
//#UC END# *54F3492A02D7_4683A2660291get_var*
begin
//#UC START# *54F3492A02D7_4683A2660291get_impl*
 Result := GetAdditionalFilter(Get_TagName, f_MgrSearch.QueryType);
//#UC END# *54F3492A02D7_4683A2660291get_impl*
end;//TqaEventReq.pm_GetAdditionalFilter

function TqaEventReq.GetHint4Button(const aValue: IevEditorControlButton): Il3CString;
//#UC START# *54F3482A0186_4683A2660291_var*
var
 l_PictBTN: IevEditorStateButton;
//#UC END# *54F3482A0186_4683A2660291_var*
begin
//#UC START# *54F3482A0186_4683A2660291_impl*
 case aValue.GetButtonType of
  ev_btLogical:
  begin
   if (l3BitCountF(Get_EditorReq.Para.AsObject.IntA[k2_tiOperations]) = 1)  then
    Result := vcmCStr(str_HintNotChangedOperation)
   else
   if Supports(aValue, IevEditorStateButton, l_PictBTN) then
   try
    case StateIndex2LogicState(l_PictBTN.GetStateIndex) of
     loOr: Result := vcmCStr(str_HintOrOperation);
     loAnd: Result := vcmCStr(str_HintAndOperation);
     loNot: Result := vcmCStr(str_HintNotOperation);
    else
     Result := vcmCStr(str_HintChangeOperation);
    end;//case StateIndex2LogicState(l_PictBTN.GetStateIndex)
   finally
    l_PictBTN := nil;
   end;//try..finally
  end;//l3BitCountF(EditorReq.Para.IntA[k2_tiOperations]) = 1
  ev_btAdd: Result := vcmCStr(str_HintBtnCreateAttr);
  ev_btDelete: Result := vcmCStr(str_HintBtnDeleteAttr);
 end;//case aValue.GetButtonType
//#UC END# *54F3482A0186_4683A2660291_impl*
end;//TqaEventReq.GetHint4Button

function TqaEventReq.StateIndex2LogicState(aValue: Integer): TLogicOperation;
//#UC START# *54F3484701AA_4683A2660291_var*
//#UC END# *54F3484701AA_4683A2660291_var*
begin
//#UC START# *54F3484701AA_4683A2660291_impl*
 if aValue < 0 then
  Result := loNone
 else
  Result := TLogicOperation(aValue + 1)
//#UC END# *54F3484701AA_4683A2660291_impl*
end;//TqaEventReq.StateIndex2LogicState

procedure TqaEventReq.DoEnterPressed;
//#UC START# *54F348660219_4683A2660291_var*
//#UC END# *54F348660219_4683A2660291_var*
begin
//#UC START# *54F348660219_4683A2660291_impl*
//#UC END# *54F348660219_4683A2660291_impl*
end;//TqaEventReq.DoEnterPressed

procedure TqaEventReq.DoTextChange;
//#UC START# *54F3487402BE_4683A2660291_var*
//#UC END# *54F3487402BE_4683A2660291_var*
begin
//#UC START# *54F3487402BE_4683A2660291_impl*
 Set_Modified(True);
//#UC END# *54F3487402BE_4683A2660291_impl*
end;//TqaEventReq.DoTextChange

procedure TqaEventReq.DoAfterSetText(const aField: IevEditorControlField);
//#UC START# *54F34897011A_4683A2660291_var*
//#UC END# *54F34897011A_4683A2660291_var*
begin
//#UC START# *54F34897011A_4683A2660291_impl*
//#UC END# *54F34897011A_4683A2660291_impl*
end;//TqaEventReq.DoAfterSetText

function TqaEventReq.DoAnalyzeString(const aValue: Il3CString;
 out aRslt: Il3CString): Boolean;
//#UC START# *54F348BB012A_4683A2660291_var*
//#UC END# *54F348BB012A_4683A2660291_var*
begin
//#UC START# *54F348BB012A_4683A2660291_impl*
 Result := False;
//#UC END# *54F348BB012A_4683A2660291_impl*
end;//TqaEventReq.DoAnalyzeString

procedure TqaEventReq.DoHyperLinkClick;
//#UC START# *54F348D700E2_4683A2660291_var*
//#UC END# *54F348D700E2_4683A2660291_var*
begin
//#UC START# *54F348D700E2_4683A2660291_impl*
 OpenSelectWindow;
//#UC END# *54F348D700E2_4683A2660291_impl*
end;//TqaEventReq.DoHyperLinkClick

procedure TqaEventReq.EnterPressed;
 {* Обработчик нажатия на "Enter". }
//#UC START# *47CD611402BF_4683A2660291_var*
//#UC END# *47CD611402BF_4683A2660291_var*
begin
//#UC START# *47CD611402BF_4683A2660291_impl*
 DoEnterPressed;
//#UC END# *47CD611402BF_4683A2660291_impl*
end;//TqaEventReq.EnterPressed

function TqaEventReq.GetHint(const aValue: IevEditorControl): Il3CString;
 {* Возвращает хинт для поля. }
//#UC START# *47CD61200100_4683A2660291_var*
var
 l_Button: IevEditorControlButton;
//#UC END# *47CD61200100_4683A2660291_var*
begin
//#UC START# *47CD61200100_4683A2660291_impl*
 if Supports(aValue, IevEditorControlButton, l_Button) then
 try
  Result := GetHint4Button(l_Button);
 finally
  l_Button := nil;
 end
 else
  Result := nil;
//#UC END# *47CD61200100_4683A2660291_impl*
end;//TqaEventReq.GetHint

function TqaEventReq.GetImage(Index: Integer;
 var aImages: InevImageList): Integer;
 {* Возвращает номер картинки и массив картинок для отображения. }
//#UC START# *47CD617100AE_4683A2660291_var*
{$IfNDef Admin}
var
 l_Node: Il3SimpleNode;
 l_ComboReq: IevComboReq;
{$EndIf Admin}
//#UC END# *47CD617100AE_4683A2660291_var*
begin
//#UC START# *47CD617100AE_4683A2660291_impl*
 Result := -1;
 {$IfNDef Admin}
 aImages := Tl3ImageList.Make(nsSearchRes.SearchItemsImageList);
 if Supports(Get_EditorReq, IevComboReq, l_ComboReq) then
 try
  l_Node := l_ComboReq.GetNode(Index);
  if l_Node <> nil then
  try
   // Папка
   if l_Node.HasChild then
    Result := siilFolderStart
   // Элемент
   else
    Result := siilSelectedElement;
  finally
   l_Node := nil;
  end;//try..finally
 finally
  l_ComboReq := nil;
 end;//try..finally
 {$EndIf  Admin}
//#UC END# *47CD617100AE_4683A2660291_impl*
end;//TqaEventReq.GetImage

function TqaEventReq.AnalyzeString(const aValue: Il3CString;
 out aRslt: Il3CString): Boolean;
 {* Анализ добавленной строки, если нужно, то убирает лишние символы или разбивает строку на несколько. }
//#UC START# *47CD61990018_4683A2660291_var*
//#UC END# *47CD61990018_4683A2660291_var*
begin
//#UC START# *47CD61990018_4683A2660291_impl*
 Result := DoAnalyzeString(aValue, aRslt);
//#UC END# *47CD61990018_4683A2660291_impl*
end;//TqaEventReq.AnalyzeString

function TqaEventReq.CheckValue(const aField: IevEditorControlField): Boolean;
 {* Проверка значения поля. }
//#UC START# *47CD659200E3_4683A2660291_var*
//#UC END# *47CD659200E3_4683A2660291_var*
begin
//#UC START# *47CD659200E3_4683A2660291_impl*
 Result := IsAttrValid;
//#UC END# *47CD659200E3_4683A2660291_impl*
end;//TqaEventReq.CheckValue

procedure TqaEventReq.TextChange;
 {* Обработчик изменения текста в поле. }
//#UC START# *47CD659E0297_4683A2660291_var*
//#UC END# *47CD659E0297_4683A2660291_var*
begin
//#UC START# *47CD659E0297_4683A2660291_impl*
 DoTextChange;
//#UC END# *47CD659E0297_4683A2660291_impl*
end;//TqaEventReq.TextChange

procedure TqaEventReq.AfterSetText(const aField: IevEditorControlField);
 {* Обработчик присвоения полю нового значения - срабатывает после выбора
          значения в дереве. }
//#UC START# *47CD6608039E_4683A2660291_var*
//#UC END# *47CD6608039E_4683A2660291_var*
begin
//#UC START# *47CD6608039E_4683A2660291_impl*
 DoAfterSetText(aField);
//#UC END# *47CD6608039E_4683A2660291_impl*
end;//TqaEventReq.AfterSetText

procedure TqaEventReq.HyperLinkClick;
 {* Обработка щелчка по ссылки. }
//#UC START# *47CD6629039E_4683A2660291_var*
//#UC END# *47CD6629039E_4683A2660291_var*
begin
//#UC START# *47CD6629039E_4683A2660291_impl*
 DoHyperLinkClick;
//#UC END# *47CD6629039E_4683A2660291_impl*
end;//TqaEventReq.HyperLinkClick

function TqaReqComboField.DoGetReqAsString(const aSeparator: Il3CString): Il3CString;
//#UC START# *54E5C312006A_4683A2A102E6_var*
var
 l_Strings: Il3StringsEx;
 l_Index: Integer;
 l_Count: Integer;
//#UC END# *54E5C312006A_4683A2A102E6_var*
begin
//#UC START# *54E5C312006A_4683A2A102E6_impl*
 l_Strings := GetReqAsStrings;
 Assert(l_Strings <> nil);
 l_Count := l_Strings.Count;
 for l_Index := 0 to Pred(l_Count) do
 begin
  if (l_Index > 0) then
   Result := l3Cat([Result, aSeparator]);
  Result := l3Cat([Result, l_Strings.ItemC[l_Index]]);
 end;
//#UC END# *54E5C312006A_4683A2A102E6_impl*
end;//TqaReqComboField.DoGetReqAsString

procedure TqaReqComboField.DoCheckAttr;
//#UC START# *54E5C744010C_4683A2A102E6_var*
var
 l_FirstDuplicate: IevEditorControlField;
 l_Exception: EaqExceptionClass;
 l_Message: AnsiString;
//#UC END# *54E5C744010C_4683A2A102E6_var*
begin
//#UC START# *54E5C744010C_4683A2A102E6_impl*
 inherited;
 if not CheckFromControl(l_Exception, l_Message, l_FirstDuplicate) then
  raise l_Exception.Create(l_FirstDuplicate, l_Message);
//#UC END# *54E5C744010C_4683A2A102E6_impl*
end;//TqaReqComboField.DoCheckAttr

procedure TqaReqComboField.DoReqClear;
//#UC START# *54E5C772012F_4683A2A102E6_var*
var
 l_ComboReq: IevComboReq;
 l_Req: IevReq;
 l_TreeField: IevEditorFieldWithTree;
 l_TreeFieldReq: IevReq;
 l_T: Il3CString;
//#UC END# *54E5C772012F_4683A2A102E6_var*
begin
//#UC START# *54E5C772012F_4683A2A102E6_impl*
 l_Req := Get_EditorReq;
 try
  while l_Req.FieldsCount > 1 do
   l_Req.DeleteField(nil, nil, true);
                            // ^ http://mdp.garant.ru/pages/viewpage.action?pageId=96483355&focusedCommentId=109511365#comment-109511365
  if Supports(l_Req.LastField, IevEditorFieldWithTree, l_TreeField) then
   try
    if evIsFieldSet(l_TreeField, True) then
    begin
     if Assigned(l_TreeField.DefaultNode) then
      l_TreeField.ShowNode(l_TreeField.DefaultNode)
     else
     begin
      //l_TreeField.ClearText; // mdp.garant.ru/pages/viewpage.action?pageId=528429019
      l_TreeFieldReq := l_TreeField.Req;
      if (l_TreeFieldReq <> nil) then
      begin
       l_T := l3CStr(l_TreeFieldReq.Para.AsObject.PCharLenA[k2_tiDefaultText]);
       l_TreeField.Text := l_T;
      end;
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=604485227
     end;
     //l_Req.SetFocus(l_TreeField);
    end;//evIsFieldSet(l_TreeField, True)
   finally
    l_TreeField := nil;
   end;
  if Supports(l_Req, IevComboReq, l_ComboReq) then
   try
    l_ComboReq.ClearLogicValue;
   finally
    l_ComboReq := nil;
   end; 
 finally
  l_Req := nil;
 end; 
//#UC END# *54E5C772012F_4683A2A102E6_impl*
end;//TqaReqComboField.DoReqClear

function TqaReqComboField.CheckFromControl(out aExceptionClass: EaqExceptionClass;
 out aMessage: AnsiString;
 out aControl: IevEditorControlField): Boolean;
//#UC START# *54E5D1D5002A_4683A2A102E6_var*
var
 l_Index: Integer;
 l_SList: IvcmStrings;
 l_CheckEditor: IevEditorControlField;
 l_CheckValue: Il3CString;
//#UC END# *54E5D1D5002A_4683A2A102E6_var*
begin
//#UC START# *54E5D1D5002A_4683A2A102E6_impl*
 Result := inherited CheckFromControl(aExceptionClass, aMessage, aControl);
 if Result then
 begin
  // Проверим уникальность значений
  l_SList := TvcmStringList.Make;
  try
   for l_Index := 0 to Get_EditorReq.FieldsCount - 1 do
   begin
    l_CheckEditor := Get_EditorReq.Fields[l_Index];
    l_CheckValue := l_CheckEditor.Text;
    l_CheckEditor.ErrorColor := not l3IsNil(l_CheckValue) and (l_SList.IndexOf(l_CheckValue) <> -1);
    if l_CheckEditor.ErrorColor then
    begin
     if aControl = nil then
      aControl := l_CheckEditor;
    end
    else
     l_SList.Add(l_CheckValue);
   end;//for l_Index := 0
  finally
   l_SList := nil;
  end;//try..finally
  if Assigned(aControl) then
  begin
   Result := False;
   aExceptionClass := EqaDuplicateValue;
   aMessage := Format(vcmConstString(str_DuplicateValue), [nsEStr(aControl.Text)]);
  end;//Assigned(aControl)
 end;//Result
//#UC END# *54E5D1D5002A_4683A2A102E6_impl*
end;//TqaReqComboField.CheckFromControl

procedure TqaCustomReqContext.FillReqListAsString(const aList: Il3StringsEx);
//#UC START# *5232EAFF0300_54F34A4103A4_var*
var
 l_Index: Integer;
 l_Count: Integer;
 l_Field: IevEditorControlField;
//#UC END# *5232EAFF0300_54F34A4103A4_var*
begin
//#UC START# *5232EAFF0300_54F34A4103A4_impl*
 l_Count := Get_EditorReq.FieldsCount - 1;
 // Сформируем строку контекста из всех строк определенных пользователем
 for l_Index := 0 to l_Count do
 begin
  l_Field := Get_EditorReq.Fields[l_Index];
  try
   l_Field.Text := nsContextUtils.CheckContext(l_Field.Text);
   if not l_Field.IsFieldEmpty then
    aList.Add(l_Field.Text);
  finally
   l_Field := nil;
  end;//try..finally
 end;//for l_Index
//#UC END# *5232EAFF0300_54F34A4103A4_impl*
end;//TqaCustomReqContext.FillReqListAsString

procedure TqaCustomReqContext.SaveReq;
//#UC START# *54E5C884028F_54F34A4103A4_var*
//#UC END# *54E5C884028F_54F34A4103A4_var*
begin
//#UC START# *54E5C884028F_54F34A4103A4_impl*
 {$If not defined(Admin)}
// SaveContextNew(f_MgrSearch.Query, Get_TagName, GetReqAsString(nil));
 SaveContextNew(f_MgrSearch.Query, Get_TagName, GetReqAsStrings);
 {$Else}
 Assert(False);
 {$IfEnd}
//#UC END# *54E5C884028F_54F34A4103A4_impl*
end;//TqaCustomReqContext.SaveReq

function TqaCustomReqContext.GetCanAdd: Boolean;
//#UC START# *54E5C2970015_54F34A4103A4_var*
//#UC END# *54E5C2970015_54F34A4103A4_var*
begin
//#UC START# *54E5C2970015_54F34A4103A4_impl*
 Result := True;
//#UC END# *54E5C2970015_54F34A4103A4_impl*
end;//TqaCustomReqContext.GetCanAdd

procedure TqaCustomReqContext.DoLoad;
//#UC START# *54E5C6B2036C_54F34A4103A4_var*
var
 l_Context: Il3CString;
 l_Index: Integer;
 l_Count: Integer;
 l_ED: IevEditorControlField;
 l_Phrases: IvcmStrings;
 l_FieldCount: Integer;
//#UC END# *54E5C6B2036C_54F34A4103A4_var*
begin
//#UC START# *54E5C6B2036C_54F34A4103A4_impl*
 if LoadContextNew(f_MgrSearch.Query, Get_TagName, l_Context) then
 begin  
  l_Phrases := nsContextUtils.ContextToPhrases(l_Context);
  l_FieldCount := Get_EditorReq.FieldsCount;
  try
   // Загрузим фразы
   l_Count := l_Phrases.Count - 1;
   for l_Index := 0 to l_Count do
   begin
    if (l_Index = 0) or (l_FieldCount > l_Index) then
     with Get_EditorReq do
     begin
      if (l_Index = 0) then
       l_ED := FirstField
      else
       l_ED := Fields[l_Index];
      try
       l_ED.Text := l_Phrases.ItemC[l_Index];
      finally
       l_ED := nil;
      end;//try..finally
     end//with Get_EditorReq
    else
     with Get_EditorReq do
     begin
      AddField(nil);
      l_ED := LastField;
      try
       l_ED.Text := l_Phrases.ItemC[l_Index];
      finally
       l_ED := nil;
      end;//try..finally
     end;//with Get_EditorReq
   end;//for l_Index
  finally
   l_Phrases := nil;
  end;//try..finally  
  Get_EditorReq.Group.Expanded := True;  
 end;//LoadContextNew
 inherited;
//#UC END# *54E5C6B2036C_54F34A4103A4_impl*
end;//TqaCustomReqContext.DoLoad

constructor TqaCustomReqContext.Create(const aMgrSearch: IqaMgrSearch;
 const aEditorReq: IevReq);
//#UC START# *54E5D16303C7_54F34A4103A4_var*
var
 I: Integer;
 l_FieldTree: IevEditorFieldWithTree;
//#UC END# *54E5D16303C7_54F34A4103A4_var*
begin
//#UC START# *54E5D16303C7_54F34A4103A4_impl*
 inherited;
 for I := 0 to Get_EditorReq.FieldsCount - 1 do
  if Supports(Get_EditorReq.Fields[I], IevEditorFieldWithTree, l_FieldTree) then
   try
    l_FieldTree.ComboStyle := ev_cbDropDown;
   finally
    l_FieldTree := nil;
   end;//try..finally
//#UC END# *54E5D16303C7_54F34A4103A4_impl*
end;//TqaCustomReqContext.Create

procedure TqaCustomReqContext.DoEnterPressed;
//#UC START# *54F348660219_54F34A4103A4_var*
//#UC END# *54F348660219_54F34A4103A4_var*
begin
//#UC START# *54F348660219_54F34A4103A4_impl*
 f_MgrSearch.ExecQuery;
//#UC END# *54F348660219_54F34A4103A4_impl*
end;//TqaCustomReqContext.DoEnterPressed

function TqaCustomReqContext.DoAnalyzeString(const aValue: Il3CString;
 out aRslt: Il3CString): Boolean;
//#UC START# *54F348BB012A_54F34A4103A4_var*
var
 l_ControlListener: InevControlListener;
//#UC END# *54F348BB012A_54F34A4103A4_var*
begin
//#UC START# *54F348BB012A_54F34A4103A4_impl*
 if Supports(Get_EditorReq.QueryCard, InevControlListener, l_ControlListener)
  and l_ControlListener.IsPasting then
 begin
  {$If not defined(Admin)}
  aRslt := RepairContext6x(aValue);
  {$Else}
  Assert(false);
  {$IfEnd}
  Result := not l3Same(aRslt, aValue);
 end//Supports(EditorReq.QueryCard, InevControlListener, l_ControlListener)
 else
  Result := inherited DoAnalyzeString(aValue, aRslt);
//#UC END# *54F348BB012A_54F34A4103A4_impl*
end;//TqaCustomReqContext.DoAnalyzeString

function TqaCustomReqContext.DoGetReqAsStrings: Il3StringsEx;
//#UC START# *555495740306_54F34A4103A4_var*
var
 l_Index: Integer;
 l_Count: Integer;
 l_Field: IevEditorControlField;
 l_Str: Il3CString;
//#UC END# *555495740306_54F34A4103A4_var*
begin
//#UC START# *555495740306_54F34A4103A4_impl*
 Result := TvcmStringList.Make;
 l_Count := Get_EditorReq.FieldsCount - 1;
 // Сформируем строку контекста из всех строк определенных пользователем
 for l_Index := 0 to l_Count do
 begin
  l_Field := Get_EditorReq.Fields[l_Index];
  try
   l_Field.Text := nsContextUtils.CheckContext(l_Field.Text);
   l_Str := nsContextUtils.AddPhrase(l_Str, l_Field.Text);
   Result.add(l_Str);
   l_Str := nil;
  finally
   l_Field := nil;
  end;//try..finally
 end;//for l_Index
//#UC END# *555495740306_54F34A4103A4_impl*
end;//TqaCustomReqContext.DoGetReqAsStrings

procedure TqaReqContext.DoCheckAttr;
//#UC START# *54E5C744010C_4683A2BA0332_var*
 procedure CheckContext(const aComboBox: IevEditorControlField);
 var
  l_Pos: Integer;
  l_ErrMessage: Il3CString;
 begin//CheckContext
  aComboBox.Text := nsContextUtils.CheckContext(aComboBox.Text);
  if not l3IsNil(aComboBox.Text) then
  begin
   {$If not defined(Admin)}
   l_Pos := CheckContext6x(aComboBox.Text, l_ErrMessage);
   {$Else}
   Assert(false);
   {$IfEnd}
   if (l_Pos >= 0) then
    raise EqaInvalidValue.Create(aComboBox, nsEStr(l_ErrMessage));
  end;//not l3IsNil(aComboBox.Text)
 end;//CheckContext

var
 l_Index: Integer;
 l_Req: IevComboReq;
//#UC END# *54E5C744010C_4683A2BA0332_var*
begin
//#UC START# *54E5C744010C_4683A2BA0332_impl*
 inherited;
 if Supports(Get_EditorReq, IevComboReq, l_Req) and l_Req.IsContext then
 begin
  (* Проверим значения в полях контекста. *)
  for l_Index := 0 to Get_EditorReq.FieldsCount - 1 do
   CheckContext(Get_EditorReq.Fields[l_Index]);
 end;//Supports(Get_EditorReq, IevComboReq, l_Req) and l_Req.IsContext
//#UC END# *54E5C744010C_4683A2BA0332_impl*
end;//TqaReqContext.DoCheckAttr

procedure TqaCommonStrReq.DoLoad;
//#UC START# *54E5C6B2036C_4683A2D201B0_var*
var
 l_Context: Il3CString;
//#UC END# *54E5C6B2036C_4683A2D201B0_var*
begin
//#UC START# *54E5C6B2036C_4683A2D201B0_impl*
 if LoadContextNew(f_MgrSearch.Query, Get_TagName, l_Context) then
  Get_EditorReq.FirstField.Text := l_Context;
//#UC END# *54E5C6B2036C_4683A2D201B0_impl*
end;//TqaCommonStrReq.DoLoad

procedure TqaCommonStrReq.DoReqClear;
//#UC START# *54E5C772012F_4683A2D201B0_var*
//#UC END# *54E5C772012F_4683A2D201B0_var*
begin
//#UC START# *54E5C772012F_4683A2D201B0_impl*
 Get_EditorReq.FirstField.ClearText;
//#UC END# *54E5C772012F_4683A2D201B0_impl*
end;//TqaCommonStrReq.DoReqClear

procedure TqaCommonStrReq.SaveReq;
//#UC START# *54E5C884028F_4683A2D201B0_var*
var
 l_Value: Il3CString;
//#UC END# *54E5C884028F_4683A2D201B0_var*
begin
//#UC START# *54E5C884028F_4683A2D201B0_impl*
 l_Value := nsContextUtils.CheckContext(Get_EditorReq.FirstField.Text);
 {$If not defined(Admin)}
 SaveContextNew(f_MgrSearch.Query, Get_TagName, l_Value);
 {$ELse}
 Assert(false);
 {$IfEnd}
//#UC END# *54E5C884028F_4683A2D201B0_impl*
end;//TqaCommonStrReq.SaveReq

procedure TqaCommonStrReq.DoTextChange;
//#UC START# *54F3487402BE_4683A2D201B0_var*
//#UC END# *54F3487402BE_4683A2D201B0_var*
begin
//#UC START# *54F3487402BE_4683A2D201B0_impl*
 Set_Modified(True);
//#UC END# *54F3487402BE_4683A2D201B0_impl*
end;//TqaCommonStrReq.DoTextChange

function TqaReqStr.pm_GetMulti: Boolean;
//#UC START# *54E5C23D016C_4683A300002Fget_var*
//#UC END# *54E5C23D016C_4683A300002Fget_var*
begin
//#UC START# *54E5C23D016C_4683A300002Fget_impl*
 Result := False;
//#UC END# *54E5C23D016C_4683A300002Fget_impl*
end;//TqaReqStr.pm_GetMulti

procedure TqaReqStr.DoMakeFieldValue;
//#UC START# *54E5C6020026_4683A300002F_var*
 function GetFieldValue: Il3CString;
 var
  I: Integer;
  l_Req: IqaReq;
 begin
  for I := Low(cSrc) to High(cSrc) do
  begin
   l_Req := f_MgrSearch.FindAttr(nsCStr(cSrc[I]));
   try
    if (l_Req <> nil) then
    begin
     if (I > 0) and not l3IsNil(Result) then
      Result := l3Cat([l3Cat(Result, '. '), l_Req.GetReqAsString(nsCStr('. '))])
     else
      Result := l_Req.GetReqAsString(nsCStr('. '));
    end;//l_Req <> nil
   finally
    l_Req := nil;
   end;//try..finally
  end;//for I := 0 to ...
 end;

var
 l_Field: IevEditorControlField;
 l_Value: Tl3PCharLen;
//#UC END# *54E5C6020026_4683A300002F_var*
begin
//#UC START# *54E5C6020026_4683A300002F_impl*
 if l3Same(Get_TagName, cChangableReqName) then
 begin
  l_Field := Get_EditorReq.FirstField;
  try
   l_Value := Tl3PCharLen(nsWStr(GetFieldValue));
   if not l3IsNil(l_Value) then
   begin
    with l_Field.Para do
    begin
     if l3Same(PCharLenA[k2_tiText], Get_EditorReq.Para.PCharLenA[k2_tiDefaultText]) then
     begin
      PCharLenA[k2_tiText] := l_Value;
      Invalidate([nev_spExtent]);
      l_Field.Req.UpdateState(l_Field, nil);
     end;//l3Same..
    end;//with l_Field.Para
    Get_EditorReq.Para.PCharLenA[k2_tiDefaultText] := l_Value;
   end;//not l3IsNil(l_Value)
  finally
   l_Field := nil;
  end;//try..finally
 end;//l3Same(TagName, cChangableReqName)
//#UC END# *54E5C6020026_4683A300002F_impl*
end;//TqaReqStr.DoMakeFieldValue

procedure TqaReqStr.DoLoad;
//#UC START# *54E5C6B2036C_4683A300002F_var*
var
 l_Context: Il3CString;
//#UC END# *54E5C6B2036C_4683A300002F_var*
begin
//#UC START# *54E5C6B2036C_4683A300002F_impl*
 if LoadContextNew(f_MgrSearch.Query, Get_TagName, l_Context) then
  Get_EditorReq.FirstField.Text := l_Context;
//#UC END# *54E5C6B2036C_4683A300002F_impl*
end;//TqaReqStr.DoLoad

procedure TqaReqStr.DoReqClear;
//#UC START# *54E5C772012F_4683A300002F_var*
//#UC END# *54E5C772012F_4683A300002F_var*
begin
//#UC START# *54E5C772012F_4683A300002F_impl*
{$IFDEF Monitorings}
 if l3Same(Get_TagName, cChangableReqName) then
  Get_EditorReq.Para.PCharLenA[k2_tiDefaultText] := Tl3PCharLen(nsWStr(''));
{$ENDIF Monitorings}
 inherited;
//#UC END# *54E5C772012F_4683A300002F_impl*
end;//TqaReqStr.DoReqClear

procedure TqaReqEMail.DoCheckAttr;
//#UC START# *54E5C744010C_4683A3160045_var*
var
 l_Exception: EaqExceptionClass;
 l_Message: AnsiString;
 l_Control: IevEditorControlField;
//#UC END# *54E5C744010C_4683A3160045_var*
begin
//#UC START# *54E5C744010C_4683A3160045_impl*
 inherited;
 if not CheckFromControl(l_Exception, l_Message, l_Control) then
  raise l_Exception.Create(l_Control, l_Message);
//#UC END# *54E5C744010C_4683A3160045_impl*
end;//TqaReqEMail.DoCheckAttr

function TqaReqEMail.CheckFromControl(out aExceptionClass: EaqExceptionClass;
 out aMessage: AnsiString;
 out aControl: IevEditorControlField): Boolean;
//#UC START# *54E5D1D5002A_4683A3160045_var*
var
 l_Emails: Tl3CStringArray;
 l_Correct: Boolean;
 I: Integer;
//#UC END# *54E5D1D5002A_4683A3160045_var*
begin
//#UC START# *54E5D1D5002A_4683A3160045_impl*
 Result := inherited CheckFromControl(aExceptionClass, aMessage, aControl);
 l_Correct := False;
 l_Emails := l3Split(Get_EditorReq.FirstField.Text, ',');
 for I := 0 to Length(l_Emails) - 1 do
 begin
  l_Correct := nsEmailVerify.Verify(l3Trim(l_Emails[I]));
  if not l_Correct then
   Break;
 end;
 if Result and IsSet(False) and not l_Correct then
 begin
  Result := False;
  aExceptionClass := EqaInvalidValue;
  aMessage := vcmConstString(str_WrongEMail);
  aControl := Get_EditorReq.FirstField;
 end;
//#UC END# *54E5D1D5002A_4683A3160045_impl*
end;//TqaReqEMail.CheckFromControl

function TqaReqAttribute.Root: INodeBase;
//#UC START# *54F42EA70211_4683A3310076_var*
//#UC END# *54F42EA70211_4683A3310076_var*
begin
//#UC START# *54F42EA70211_4683A3310076_impl*
 Result := TnsAttributeTreeCacheNew.Instance.AttributeRoot[Get_TagName];
//#UC END# *54F42EA70211_4683A3310076_impl*
end;//TqaReqAttribute.Root

procedure TqaReqAttribute.SetAttributesToView;
//#UC START# *54F42EBA00FC_4683A3310076_var*
var
 l_Index: Integer;
 l_NodeBase: INodeBase;
 l_Count: Integer;
 l_Field: IevEditorFieldWithTree;
//#UC END# *54F42EBA00FC_4683A3310076_var*
begin
//#UC START# *54F42EBA00FC_4683A3310076_impl*
 // Сбросим флаги
 DropAllOperations(Root);
 Root.SetAllFlag(FM_SELECTION, False); 
 l_Count := Get_EditorReq.FieldsCount - 1;  
 // Установим флаги
 for l_Index := 0 to l_Count do
  if Supports(Get_EditorReq.Fields[l_Index], IevEditorFieldWithTree, l_Field) then
  try
   if l_Field.IsFieldEmpty then
    l_Field.ClearText;
   if Supports(l_Field.Value, INodeBase, l_NodeBase) then
   try
    nsLogicOperationToFlags.SetLogicOperation(l_NodeBase, FieldLogicOperation(l_Field));
   finally
    l_NodeBase := nil;
   end;//try..finally
  finally
   l_Field := nil;
  end;//try..finally
//#UC END# *54F42EBA00FC_4683A3310076_impl*
end;//TqaReqAttribute.SetAttributesToView

procedure TqaReqAttribute.SaveFieldToQuery(const aValue: IevEditorControlField);
//#UC START# *54F42F9D008B_4683A3310076_var*
var
 l_DictNode,
 l_Node: INodeBase;
 l_ComboField: IevEditorFieldWithTree;
//#UC END# *54F42F9D008B_4683A3310076_var*
begin
//#UC START# *54F42F9D008B_4683A3310076_impl*
 if Supports(aValue, IevEditorFieldWithTree, l_ComboField) then
 try
  if l_ComboField.IsFieldEmpty then
   l_ComboField.ClearText //Заточка для новой реакции на откатку, т.к. теперь
   //ядро не ждет никакой нотификации, то может получиться так, что текст
   //удален при нажатии "Ctrl + Z", а выбранный узел остался.
  else
  if evIsFieldSet(l_ComboField, false) then
  begin
   // Введено значение со звездочкой
   if l_ComboField.IsAsterisk then
    {$If not defined(Admin)}
    SaveContextNew(f_MgrSearch.Query, Get_TagName, aValue.Text)
    {$Else}
    Assert(false)
    {$IfEnd}
   // Выбрано конкретное значение
   else
   if aValue.Valid and Supports(l_ComboField.Value, INodeBase, l_DictNode) then
   try
    // !! обход бага в дереве, связанного с IQuery
    // убрать после правки.
    {$IFDEF NEW_TREE}
    SaveAttributeNew(f_MgrSearch.Query, Get_TagName, FieldLogicOperation(l_ComboField), l_DictNode);
    {$ELSE}
    l_Node := GetTwinNode(TnsAttributeTreeStruct.Make(Get_TagName, False), l_DictNode);
    if not Assigned(l_Node) then
     l_Node := l_DictNode;
    {$If not defined(Admin)}
    SaveAttributeNew(f_MgrSearch.Query, Get_TagName, FieldLogicOperation(l_ComboField), l_Node);
    {$Else}
    Assert(false);
    {$IfEnd}
    {$ENDIF NEW_TREE}
   finally
    l_DictNode := nil;
   end;//try..finally
  end;//if evIsFieldSet(aValue) then
 finally
  l_ComboField := nil;
 end;//try..finally
//#UC END# *54F42F9D008B_4683A3310076_impl*
end;//TqaReqAttribute.SaveFieldToQuery

function TqaReqAttribute.FieldLogicOperation(const aValue: IevEditorFieldWithTree): TLogicOperation;
//#UC START# *54F42FBA00EA_4683A3310076_var*
//#UC END# *54F42FBA00EA_4683A3310076_var*
begin
//#UC START# *54F42FBA00EA_4683A3310076_impl*
 Result := StateIndex2LogicState(aValue.LogicalState);
//#UC END# *54F42FBA00EA_4683A3310076_impl*
end;//TqaReqAttribute.FieldLogicOperation

procedure TqaReqAttribute.LoadField(const aValue: IevEditorFieldWithTree;
 aLogicOper: TLogicOperation;
 const aNode: INodeBase);
//#UC START# *54F42FD60076_4683A3310076_var*
var
 l_State: Integer;
 l_Node: Il3SimpleNode;
//#UC END# *54F42FD60076_4683A3310076_var*
begin
//#UC START# *54F42FD60076_4683A3310076_impl*
 l_State := Ord(aLogicOper) - 1; //loNone - не учитываем
 l_Node := TnsINodeWrap.Make(aNode);
 try
  aValue.ShowNode(l_Node); 
  aValue.LogicalState := l_State;
 finally
  l_Node := nil;
 end; 
//#UC END# *54F42FD60076_4683A3310076_impl*
end;//TqaReqAttribute.LoadField

procedure TqaReqAttribute.GetAttributesFromView(const aRoot: INodeBase);
 {* Вычитываем флаги операций из дерева (создаёт поля ввода) и устанавливаем фокус в последнее добавленное поле }
//#UC START# *5232EA510243_4683A3310076_var*
var
 l_Index: TLogicOperation;
 l_Iterator: INodeIterator;
 l_NodeBase: INodeBase;
 l_Cursor: TCursor;
 l_FieldCount: Integer;
 //* - Количество выбранных элементов. Для удаления лишних полей.
 l_Count: Integer;
 l_EdFieldCount: Integer;

 procedure AddField(const aNodeBase: INodeBase; aOperation: TLogicOperation);
 var
  l_Field: IevEditorFieldWithTree;
  l_EdField: IevEditorControlField;
 begin
  // счетчик загруженных полей
  Inc(l_FieldCount);
  // используем существующее поле
  if (l_FieldCount <= Get_EditorReq.FieldsCount) then  
   Get_EditorReq.Fields[l_FieldCount - 1].QueryInterface(IevEditorFieldWithTree, l_Field)
  // новое поле 
  else
   begin
    l_EdField := Get_EditorReq.AddField(nil);    
    Assert(Assigned(l_EdField), caFieldNotAdded);
    try
     l_EdField.QueryInterface(IevEditorFieldWithTree, l_Field);
    finally
     l_EdField := nil;
    end;
   end;
  try
   Assert(Assigned(l_Field), caFieldNotInitialized);
   // покажем значение
   LoadField(l_Field, aOperation, aNodeBase);
   Get_EditorReq.SetFocus(l_Field, True);
   Get_EditorReq.UpdateState(l_Field, nil);
  finally
   l_Field := nil;
  end;
 end;
//#UC END# *5232EA510243_4683A3310076_var*
begin
//#UC START# *5232EA510243_4683A3310076_impl*
 l_EdFieldCount := Get_EditorReq.FieldsCount - 1;
 l_FieldCount := 0;
 // не удаляем значения, используем существующие поля ввода
 l_Cursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 try
  f_MgrSearch.StartGettingFromView;
  try
   // первая операция
   l_Index := Low(TLogicOperation);
   // пройдем по списку итераторов
   while True do
   begin
    if l_Index <> loNone then
    begin
     // итератор
     l_Iterator := GetOperationIterator(Root, l_Index);
     try
      // узлы
      l_Iterator.GetNext(l_NodeBase);
      while Assigned(l_NodeBase) do
      begin
       try
        // создадим поле ввода
        AddField(l_NodeBase, l_Index);
       finally
        l_NodeBase := nil;
       end;
       l_Iterator.GetNext(l_NodeBase);
      end;//while Assigned(l_NodeBase) do
     finally
      l_Iterator := nil;
     end;//try..finally
    end;
    if l_Index < High(TLogicOperation) then
     Inc(l_Index)
    else
     Break;
   end;//while l_Index < Pred(aParams.Count) do
   // удалим "лишние поля"
   if l_FieldCount > 0 then
    for l_Count := l_EdFieldCount downto l_FieldCount do
     Get_EditorReq.DeleteField(nil)
   else
    ReqClear;
   Get_EditorReq.UpdateState(Get_EditorReq.FirstField, nil);
   Get_EditorReq.UpdateState(Get_EditorReq.LastField, nil);
  finally
   f_MgrSearch.FinishGettingFromView;
  end;//try..finally
  DoOperateChanged;
  // установим фокус в последнем элементе
  Get_EditorReq.SetFocus(Get_EditorReq.LastField);
 finally
  Screen.Cursor := l_Cursor;
 end;//Screen.Cursor := crHourGlass;
//#UC END# *5232EA510243_4683A3310076_impl*
end;//TqaReqAttribute.GetAttributesFromView

procedure TqaReqAttribute.SaveReq;
//#UC START# *54E5C884028F_4683A3310076_var*
var
 l_Index: Integer;
//#UC END# *54E5C884028F_4683A3310076_var*
begin
//#UC START# *54E5C884028F_4683A3310076_impl*
 for l_Index := 0 to Get_EditorReq.FieldsCount - 1 do
  SaveFieldToQuery(Get_EditorReq.Fields[l_Index]);
//#UC END# *54E5C884028F_4683A3310076_impl*
end;//TqaReqAttribute.SaveReq

function TqaReqAttribute.GetCanAdd: Boolean;
//#UC START# *54E5C2970015_4683A3310076_var*
//#UC END# *54E5C2970015_4683A3310076_var*
begin
//#UC START# *54E5C2970015_4683A3310076_impl*
 Result := IsAttrValid;
//#UC END# *54E5C2970015_4683A3310076_impl*
end;//TqaReqAttribute.GetCanAdd

function TqaReqAttribute.GetCanOpenTree: Boolean;
//#UC START# *54E5C2C801EC_4683A3310076_var*
//#UC END# *54E5C2C801EC_4683A3310076_var*
begin
//#UC START# *54E5C2C801EC_4683A3310076_impl*
 Result := True;
//#UC END# *54E5C2C801EC_4683A3310076_impl*
end;//TqaReqAttribute.GetCanOpenTree

procedure TqaReqAttribute.DoLoad;
//#UC START# *54E5C6B2036C_4683A3310076_var*
var
 l_List: TqaAttrInfoList;
 l_Index: Integer;
 l_Node: INodeBase;
 l_Count: Integer;
 l_FieldCount: Integer;
 l_FieldTree: IevEditorFieldWithTree;
 l_ED: IevEditorControlField;
 l_Tree: Il3SimpleTree;
//#UC END# *54E5C6B2036C_4683A3310076_var*
begin
//#UC START# *54E5C6B2036C_4683A3310076_impl*
 l_List := TqaAttrInfoList.Make;
 try
  {$IfNDef Admin}
  LoadDictionaryNew(l_List, f_MgrSearch.Query, Get_TagName);
  {$Else   Admin}
  Assert(false);
  {$EndIf  Admin}
  l_Count := l_List.Count - 1;
  l_FieldCount := Get_EditorReq.FieldsCount;
  Assert((l_FieldCount = 1) OR (l_Count >= l_FieldCount - 1));
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=227478809&focusedCommentId=227967127#comment-227967127
  for l_Index := 0 to l_Count do
  begin
   { Новый TasField }
   if (l_Index = 0) then
    l_ED := Get_EditorReq.FirstField
   else
   if (l_FieldCount > l_Index) then
    l_ED := Get_EditorReq.Fields[l_Index]
   else
   begin
    Get_EditorReq.AddField(nil);
    l_ED := Get_EditorReq.LastField;
   end;//l_FieldCount > l_Index
   try
    { Введена маска }
    if not l3IsNil(l_List[l_Index].Mask) then
    begin
     if Supports(l_ED, IevEditorFieldWithTree, l_FieldTree) then
     try
      l_FieldTree.SetMaskText(l_List[l_Index].Mask)
      // - http://mdp.garant.ru/pages/viewpage.action?pageId=588810734
     finally
      l_FieldTree := nil;
     end
     else
      l_ED.Text := l_List[l_Index].Mask;
    end
    { Выбран конкретный элемент }
    else
     with l_List[l_Index] do
     begin
      if Supports(l_ED, IevEditorFieldWithTree, l_FieldTree) then
      try
       l_Tree := l_FieldTree.SourceTree;
       if Supports(l_Tree, Il3ExpandedSimpleTree) then
       begin
        // преобразуем ноду в IQuery в ноду в дереве
        // l_Node := GetTwinNode(l_Mgr.ComboBox.TreeStruct, NodeBase);
        // !! обход бага в дереве, связанного с тем, что ноды в View и IQuery - разные
        // поправить после правки бага в дереве
        {$IFDEF NEW_TREE}
        LoadField(l_FieldTree, Oper, NodeBase);
        {$ELSE}
        l_Node := GetTwinNode(TnsAttributeTreeStruct.Make(Get_TagName, l_Tree.ShowRoot), NodeBase);
        try
         LoadField(l_FieldTree, Oper, l_Node);
        finally
         l_Node := nil;
        end;//try..finally
        {$ENDIF NEW_TREE}
       end;//Supports(l_Tree, Il3ExpandedSimpleTree)
      finally
       l_FieldTree := nil;
      end;//try..finally
     end;//with l_List[l_Index]
   finally
    l_ED := nil;
   end;//try..finally
  end;//for l_Index
  if (Get_EditorReq.FieldsCount > 0) and IsSet(True) then
  begin
   Get_EditorReq.Group.Expanded := True;   
   //EditorReq.Valid := True; //Проверяем загруженные данные 
  end;//EditorReq.FieldsCount > 0..
 finally
  vcmFree(l_List);
 end;//try..finally
 isAttrValid;
 inherited;
//#UC END# *54E5C6B2036C_4683A3310076_impl*
end;//TqaReqAttribute.DoLoad

procedure TqaReqAttribute.DoOpenSelectWindow;
//#UC START# *54E5C719014A_4683A3310076_var*
 function DoShowTree(const aTagName: Il3CString; anAdditionalFilter: TnsFilterType): Boolean;
 var
  l_Cursor: TCursor;
 begin
  Result := False;
  l_Cursor := Screen.Cursor;
  try
   Screen.Cursor := crHourGlass;
   Result := TdmStdRes.OpenTreeSelection(aTagName, anAdditionalFilter, nil) = mrOk;
  finally
   Screen.Cursor := l_Cursor;
  end;//try..finally
 end;
//#UC END# *54E5C719014A_4683A3310076_var*
begin
//#UC START# *54E5C719014A_4683A3310076_impl*
 SetAttributesToView;
 if DoShowTree(Get_TagName, AdditionalFilter) then
  f_MgrSearch.FinishOpenTree(Root, Self);
//#UC END# *54E5C719014A_4683A3310076_impl*
end;//TqaReqAttribute.DoOpenSelectWindow

procedure TqaReqAttribute.DoOperateChanged;
//#UC START# *54E5C85002FA_4683A3310076_var*
//#UC END# *54E5C85002FA_4683A3310076_var*
begin
//#UC START# *54E5C85002FA_4683A3310076_impl*
 if not f_MgrSearch.GettingFromView then
  inherited;
//#UC END# *54E5C85002FA_4683A3310076_impl*
end;//TqaReqAttribute.DoOperateChanged

procedure TqaReqAttribute.DoEnterPressed;
//#UC START# *54F348660219_4683A3310076_var*
//#UC END# *54F348660219_4683A3310076_var*
begin
//#UC START# *54F348660219_4683A3310076_impl*
 if not Multi then
  f_MgrSearch.ExecQuery
 else
  OpenSelectWindow;
//#UC END# *54F348660219_4683A3310076_impl*
end;//TqaReqAttribute.DoEnterPressed

procedure TqaReqAttribute.DoAfterSetText(const aField: IevEditorControlField);
//#UC START# *54F34897011A_4683A3310076_var*
//#UC END# *54F34897011A_4683A3310076_var*
begin
//#UC START# *54F34897011A_4683A3310076_impl*
 Set_Modified(True);
 DoOperateChanged;
//#UC END# *54F34897011A_4683A3310076_impl*
end;//TqaReqAttribute.DoAfterSetText

function TqaReqAttribute.DoGetReqAsStrings: Il3StringsEx;
//#UC START# *555495740306_4683A3310076_var*
var
 I, l_Count: Integer;
 l_Field: IevEditorFieldWithTree;
 l_Str: Il3CString;
 l_SpecialWasAdded: Boolean;
 l_SpecialLanguage: Boolean;
//#UC END# *555495740306_4683A3310076_var*
begin
//#UC START# *555495740306_4683A3310076_impl*
Result := TvcmStringList.Make;
 l_Count := Get_EditorReq.FieldsCount - 1;
 l_SpecialWasAdded := False;
 l_SpecialLanguage := afw.Application.LocaleInfo.Language = afw_lngRussian;
 if (l_Count >= 0) then
  for i := 0 to l_Count do
   if Supports(Get_EditorReq.Fields[i], IevEditorFieldWithTree, l_Field) then
   try
    if evIsFieldSet(l_Field, false) then
    begin
     if l_SpecialLanguage and
        (l3Same(Get_TagName, AT_ANNO_KIND)) then //Для более короткого названия в мониторингах.
     begin
      l_Str := nsConvertAnnoKind(l_Field.Text);
      if not ((l3Same(l_Str, ccakRegionalLaw)) and
         l_SpecialWasAdded) then
      begin
       Result.add(l_Str);
      end;//not ((l3Same(l_Str.AsWStr, ccakRegionalLaw)) and
      if (l3Same(l_Str, ccakRegionalLaw)) then
       l_SpecialWasAdded := true;
     end//l_SpecialLanguage..
     else
     begin
      Result.Add(l_Field.Text);
     end;//l_SpecialLanguage..
    end;//evIsFieldSet(l_Field)
   finally
    l_Field := nil;
   end;//try..finally
//#UC END# *555495740306_4683A3310076_impl*
end;//TqaReqAttribute.DoGetReqAsStrings

procedure TqaReqNum.InitFields;
//#UC START# *47A042E100E2_4683A373026F_var*
var
 l_Combo: IevEditorFieldWithTree;
//#UC END# *47A042E100E2_4683A373026F_var*
begin
//#UC START# *47A042E100E2_4683A373026F_impl*
 inherited;
 if Supports(Get_EditorReq.FirstField, IevEditorFieldWithTree, l_Combo) then
 try
  // Установим символ звездочки
  l_Combo.Asterisk := '*';
 finally
  l_Combo := nil;
 end;//try..finally
//#UC END# *47A042E100E2_4683A373026F_impl*
end;//TqaReqNum.InitFields

function TqaReqDate.Get_StartDate: TDateTime;
//#UC START# *5232EB600109_4683A39B0078get_var*
var
 l_CalReq: IevDatesReq;
//#UC END# *5232EB600109_4683A39B0078get_var*
begin
//#UC START# *5232EB600109_4683A39B0078get_impl*
 if Supports(Get_EditorReq, IevDatesReq, l_CalReq) then
 try
  Result := l_CalReq.StartDate;
 finally
  l_CalReq := nil;
 end
 else
  Result := NullDate;
//#UC END# *5232EB600109_4683A39B0078get_impl*
end;//TqaReqDate.Get_StartDate

procedure TqaReqDate.Set_StartDate(aValue: TDateTime);
//#UC START# *5232EB600109_4683A39B0078set_var*
var
 l_CalReq: IevDatesReq;
//#UC END# *5232EB600109_4683A39B0078set_var*
begin
//#UC START# *5232EB600109_4683A39B0078set_impl*
 if Supports(Get_EditorReq, IevDatesReq, l_CalReq) then
 try
  l_CalReq.StartDate := aValue;
 finally
  l_CalReq := nil;
 end;
//#UC END# *5232EB600109_4683A39B0078set_impl*
end;//TqaReqDate.Set_StartDate

function TqaReqDate.Get_EndDate: TDateTime;
//#UC START# *5232EB690203_4683A39B0078get_var*
var
 l_CalReq: IevDatesReq;
//#UC END# *5232EB690203_4683A39B0078get_var*
begin
//#UC START# *5232EB690203_4683A39B0078get_impl*
 if Supports(Get_EditorReq, IevDatesReq, l_CalReq) then
 try
  Result := l_CalReq.EndDate;
 finally
  l_CalReq := nil;
 end
 else
  Result := NullDate;
//#UC END# *5232EB690203_4683A39B0078get_impl*
end;//TqaReqDate.Get_EndDate

procedure TqaReqDate.Set_EndDate(aValue: TDateTime);
//#UC START# *5232EB690203_4683A39B0078set_var*
var
 l_CalReq: IevDatesReq;
//#UC END# *5232EB690203_4683A39B0078set_var*
begin
//#UC START# *5232EB690203_4683A39B0078set_impl*
 if Supports(Get_EditorReq, IevDatesReq, l_CalReq) then
 try
  l_CalReq.EndDate := aValue;
 finally
  l_CalReq := nil;
 end;
//#UC END# *5232EB690203_4683A39B0078set_impl*
end;//TqaReqDate.Set_EndDate

procedure TqaReqDate.SaveReq;
//#UC START# *54E5C884028F_4683A39B0078_var*
//#UC END# *54E5C884028F_4683A39B0078_var*
begin
//#UC START# *54E5C884028F_4683A39B0078_impl*
 {$If not defined(Admin)}
 Assert(Get_EditorReq.FirstField.Enabled = Get_EditorReq.LastField.Enabled);
 if Get_EditorReq.FirstField.Enabled AND Get_EditorReq.LastField.Enabled then
  SaveDateNewEx(f_MgrSearch.Query, Get_TagName, StartDate, EndDate);
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *54E5C884028F_4683A39B0078_impl*
end;//TqaReqDate.SaveReq

procedure TqaReqDate.InitFields;
//#UC START# *47A042E100E2_4683A39B0078_var*
var
 l_Field: IevEditorControlField;
 l_CT: Tl3PCharLen;
 l_Cal: IevEditorCalendarField;

 procedure lp_Init(const aField: IevEditorControlField);
 begin
  if (aField <> nil) then
   if l3IsNil(aField.Para.AsObject.PCharLenA[k2_tiText]) then
    aField.Para.AsObject.PCharLenA[k2_tiText] := l_CT
   else
   if not l3IsNil(l_CT) then
    aField.Para.AsObject.PCharLenA[k2_tiText] := l_CT;
 end;
//#UC END# *47A042E100E2_4683A39B0078_var*
begin
//#UC START# *47A042E100E2_4683A39B0078_impl*
 inherited;
 if not Get_EditorReq.Para.AsObject.HasSubAtom(k2_tiDefaultText) then
 //Обновление масок текста (могут не соотвествовать региональным настройкам).
 begin
  l_CT := Tl3PCharLen(nsWStr(evMakeDateMaskText));
  l_Field := Get_EditorReq.FirstField;
  if (l_Field <> nil) then
  begin
   lp_Init(l_Field);
   if Supports(l_Field, IevEditorCalendarField, l_Cal) then
    lp_Init(l_Cal.GetOtherField);
  end;//l_Field <> nil
  Get_EditorReq.Para.AsObject.PCharLenA[k2_tiDefaultText] := l_CT;
 end;//not Get_EditorReq.Para.HasSubAtom(k2_tiDefaultText)
//#UC END# *47A042E100E2_4683A39B0078_impl*
end;//TqaReqDate.InitFields

function TqaReqDate.pm_GetMulti: Boolean;
//#UC START# *54E5C23D016C_4683A39B0078get_var*
//#UC END# *54E5C23D016C_4683A39B0078get_var*
begin
//#UC START# *54E5C23D016C_4683A39B0078get_impl*
 Result := True;
//#UC END# *54E5C23D016C_4683A39B0078get_impl*
end;//TqaReqDate.pm_GetMulti

function TqaReqDate.GetCanOpenTree: Boolean;
//#UC START# *54E5C2C801EC_4683A39B0078_var*
//#UC END# *54E5C2C801EC_4683A39B0078_var*
begin
//#UC START# *54E5C2C801EC_4683A39B0078_impl*
 Result := False;
//#UC END# *54E5C2C801EC_4683A39B0078_impl*
end;//TqaReqDate.GetCanOpenTree

procedure TqaReqDate.DoLoad;
//#UC START# *54E5C6B2036C_4683A39B0078_var*
var
 l_StartDate: System.TDateTime;
 l_EndDate: System.TDateTime;
//#UC END# *54E5C6B2036C_4683A39B0078_var*
begin
//#UC START# *54E5C6B2036C_4683A39B0078_impl*
 {$If not defined(Admin)}
 LoadDateNew(f_MgrSearch.Query, Get_TagName, l_StartDate, l_EndDate);
 {$Else}
 Assert(false);
 {$IfEnd}
 if (l_StartDate <> NullDate) or (l_EndDate <> NullDate) then
 begin
  Get_EditorReq.Group.Expanded := True;
  EndDate := l_EndDate;
  StartDate := l_StartDate;
 end;
 inherited;
//#UC END# *54E5C6B2036C_4683A39B0078_impl*
end;//TqaReqDate.DoLoad

procedure TqaReqDate.DoOpenSelectWindow;
//#UC START# *54E5C719014A_4683A39B0078_var*
//#UC END# *54E5C719014A_4683A39B0078_var*
begin
//#UC START# *54E5C719014A_4683A39B0078_impl*
 HyperLinkClick;
//#UC END# *54E5C719014A_4683A39B0078_impl*
end;//TqaReqDate.DoOpenSelectWindow

procedure TqaReqDate.DoCheckAttr;
//#UC START# *54E5C744010C_4683A39B0078_var*
var
 l_DateField: IevEditorCalendarField;
 l_Exception: EaqExceptionClass;
 l_Message: AnsiString;
 l_Control: IevEditorControlField;
//#UC END# *54E5C744010C_4683A39B0078_var*
begin
//#UC START# *54E5C744010C_4683A39B0078_impl*
 inherited;
 if not CheckFromControl(l_Exception, l_Message, l_Control) then
 begin
  (l_Control as IevEditorCalendarField).ClearField;
  raise l_Exception.Create(l_Control, l_Message);
 end;
 if Supports(Get_EditorReq.FirstField, IevEditorCalendarField, l_DateField) then
 begin
 // Удалим если введена не верная дата
  if not l_DateField.IsFieldEmpty and not l_DateField.GetOtherField.IsFieldEmpty then
   if Floor(l_DateField.aDate) > Floor(l_DateField.GetOtherField.aDate) then
    raise EqaInvalidValue.CreateFmt(l_DateField, vcmConstString(str_StartDateMoreEnd),
                                    [DateToStr(l_DateField.aDate), DateToStr(l_DateField.GetOtherField.aDate)]);
 end;
//#UC END# *54E5C744010C_4683A39B0078_impl*
end;//TqaReqDate.DoCheckAttr

procedure TqaReqDate.DoReqClear;
//#UC START# *54E5C772012F_4683A39B0078_var*
//#UC END# *54E5C772012F_4683A39B0078_var*
begin
//#UC START# *54E5C772012F_4683A39B0078_impl*
 Get_EditorReq.FirstField.ClearText;
//#UC END# *54E5C772012F_4683A39B0078_impl*
end;//TqaReqDate.DoReqClear

function TqaReqDate.BeforeGroupCollapse: Boolean;
//#UC START# *54E5C8690080_4683A39B0078_var*
//#UC END# *54E5C8690080_4683A39B0078_var*
begin
//#UC START# *54E5C8690080_4683A39B0078_impl*
 Result := IsAttrValid;
//#UC END# *54E5C8690080_4683A39B0078_impl*
end;//TqaReqDate.BeforeGroupCollapse

function TqaReqDate.CheckFromControl(out aExceptionClass: EaqExceptionClass;
 out aMessage: AnsiString;
 out aControl: IevEditorControlField): Boolean;
//#UC START# *54E5D1D5002A_4683A39B0078_var*
 procedure CheckDate(const aDateField: IevEditorCalendarField);
 {* - проверяет правильность даты и выводит сообщение. }
 begin
  if not aDateField.IsBlank and not aDateField.Valid then
  begin
   Result := False;
   aExceptionClass := EqaInvalidValue;
   aMessage := Format(vcmConstString(str_InvalidDate), [nsEStr(aDateField.text)]);
   aControl := aDateField;
  end;
 end;

var
 l_DateField: IevEditorCalendarField;
//#UC END# *54E5D1D5002A_4683A39B0078_var*
begin
//#UC START# *54E5D1D5002A_4683A39B0078_impl*
 Result := inherited CheckFromControl(aExceptionClass, aMessage, aControl);
 if Result and Supports(Get_EditorReq.FirstField, IevEditorCalendarField, l_DateField) then
 begin
  CheckDate(l_DateField);
  if Result then
   CheckDate(l_DateField.GetOtherField);
 end;
//#UC END# *54E5D1D5002A_4683A39B0078_impl*
end;//TqaReqDate.CheckFromControl

function TqaReqDate.GetHint4Button(const aValue: IevEditorControlButton): Il3CString;
//#UC START# *54F3482A0186_4683A39B0078_var*
//#UC END# *54F3482A0186_4683A39B0078_var*
begin
//#UC START# *54F3482A0186_4683A39B0078_impl*
 Result := inherited GetHint4Button(aValue);
 if (aValue.GetButtonType = ev_btDelete) then
  Result := vcmCStr(str_HintBtnDeleteDate);
//#UC END# *54F3482A0186_4683A39B0078_impl*
end;//TqaReqDate.GetHint4Button

procedure TqaReqDate.DoEnterPressed;
//#UC START# *54F348660219_4683A39B0078_var*
//#UC END# *54F348660219_4683A39B0078_var*
begin
//#UC START# *54F348660219_4683A39B0078_impl*
 HyperLinkClick;
//#UC END# *54F348660219_4683A39B0078_impl*
end;//TqaReqDate.DoEnterPressed

procedure TqaReqDate.DoHyperLinkClick;
//#UC START# *54F348D700E2_4683A39B0078_var*
//#UC END# *54F348D700E2_4683A39B0078_var*
begin
//#UC START# *54F348D700E2_4683A39B0078_impl*
 f_MgrSearch.DateQuery(Self);
//#UC END# *54F348D700E2_4683A39B0078_impl*
end;//TqaReqDate.DoHyperLinkClick

function TqaReqPhone.Get_Code: Il3CString;
//#UC START# *468395A20036_4683A447009Eget_var*
var
 l_PhoneReq: IevPhoneReq;
//#UC END# *468395A20036_4683A447009Eget_var*
begin
//#UC START# *468395A20036_4683A447009Eget_impl*
 if Supports(Get_EditorReq, IevPhoneReq, l_PhoneReq) then
 try
  Result := l_PhoneReq.Code;
 finally
  l_PhoneReq := nil;
 end//try..finally
 else
  Result := nil;
//#UC END# *468395A20036_4683A447009Eget_impl*
end;//TqaReqPhone.Get_Code

procedure TqaReqPhone.Set_Code(const aValue: Il3CString);
//#UC START# *468395A20036_4683A447009Eset_var*
var
 l_PhoneReq: IevPhoneReq;
//#UC END# *468395A20036_4683A447009Eset_var*
begin
//#UC START# *468395A20036_4683A447009Eset_impl*
 if Supports(Get_EditorReq, IevPhoneReq, l_PhoneReq) then
 try
  l_PhoneReq.Code := aValue;
 finally
  l_PhoneReq := nil;
 end;//try..finally
//#UC END# *468395A20036_4683A447009Eset_impl*
end;//TqaReqPhone.Set_Code

function TqaReqPhone.Get_Number: Il3CString;
//#UC START# *468395AD02B5_4683A447009Eget_var*
var
 l_PhoneReq: IevPhoneReq;
//#UC END# *468395AD02B5_4683A447009Eget_var*
begin
//#UC START# *468395AD02B5_4683A447009Eget_impl*
 if Supports(Get_EditorReq, IevPhoneReq, l_PhoneReq) then
 try
  Result := l_PhoneReq.Number;
 finally
  l_PhoneReq := nil;
 end//try..finally
 else
  Result := nil;
//#UC END# *468395AD02B5_4683A447009Eget_impl*
end;//TqaReqPhone.Get_Number

procedure TqaReqPhone.Set_Number(const aValue: Il3CString);
//#UC START# *468395AD02B5_4683A447009Eset_var*
var
 l_PhoneReq: IevPhoneReq;
//#UC END# *468395AD02B5_4683A447009Eset_var*
begin
//#UC START# *468395AD02B5_4683A447009Eset_impl*
 if Supports(Get_EditorReq, IevPhoneReq, l_PhoneReq) then
 try
  l_PhoneReq.Number := aValue;
 finally
  l_PhoneReq := nil;
 end;//try..finally
//#UC END# *468395AD02B5_4683A447009Eset_impl*
end;//TqaReqPhone.Set_Number

procedure TqaReqPhone.SaveReq;
//#UC START# *54E5C884028F_4683A447009E_var*
//#UC END# *54E5C884028F_4683A447009E_var*
begin
//#UC START# *54E5C884028F_4683A447009E_impl*
 {$If not defined(Admin)}
 SavePhone(f_MgrSearch.Query, Get_TagName, Code, Number);
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *54E5C884028F_4683A447009E_impl*
end;//TqaReqPhone.SaveReq

function TqaReqPhone.pm_GetMulti: Boolean;
//#UC START# *54E5C23D016C_4683A447009Eget_var*
//#UC END# *54E5C23D016C_4683A447009Eget_var*
begin
//#UC START# *54E5C23D016C_4683A447009Eget_impl*
 Result := True;
//#UC END# *54E5C23D016C_4683A447009Eget_impl*
end;//TqaReqPhone.pm_GetMulti

function TqaReqPhone.GetCanOpenTree: Boolean;
//#UC START# *54E5C2C801EC_4683A447009E_var*
//#UC END# *54E5C2C801EC_4683A447009E_var*
begin
//#UC START# *54E5C2C801EC_4683A447009E_impl*
 Result := False;
//#UC END# *54E5C2C801EC_4683A447009E_impl*
end;//TqaReqPhone.GetCanOpenTree

procedure TqaReqPhone.DoLoad;
//#UC START# *54E5C6B2036C_4683A447009E_var*
var
 l_Code,
 l_Number: Il3CString;
//#UC END# *54E5C6B2036C_4683A447009E_var*
begin
//#UC START# *54E5C6B2036C_4683A447009E_impl*
 LoadPhone(f_MgrSearch.Query, nsWStr(Get_TagName), l_Code, l_Number);
 Code := l_Code;
 Number := l_Number;
 if not l3IsNil(l_Code) or not l3IsNil(l_Number) then
  Get_EditorReq.Group.Expanded := True;
 inherited;
//#UC END# *54E5C6B2036C_4683A447009E_impl*
end;//TqaReqPhone.DoLoad

procedure TqaReqPhone.DoReqClear;
//#UC START# *54E5C772012F_4683A447009E_var*
//#UC END# *54E5C772012F_4683A447009E_var*
begin
//#UC START# *54E5C772012F_4683A447009E_impl*
 Code := nil;
 Number := nil;
//#UC END# *54E5C772012F_4683A447009E_impl*
end;//TqaReqPhone.DoReqClear

constructor TqaDateReqDataHolder.Create(const aReq: IqaDateReq);
//#UC START# *54F4619A00B4_4683A3F40329_var*
var
 l_Req: IqaReq;
//#UC END# *54F4619A00B4_4683A3F40329_var*
begin
//#UC START# *54F4619A00B4_4683A3F40329_impl*
 inherited Create;
 StartDate := aReq.StartDate;
 EndDate := aReq.EndDate;
 IsOk := False;
 if Supports(aReq, IqaReq, l_Req) then
  f_ReqCaption := l_Req.TagCaption;
//#UC END# *54F4619A00B4_4683A3F40329_impl*
end;//TqaDateReqDataHolder.Create

class function TqaDateReqDataHolder.Make(const aReq: IqaDateReq): IqaDateReqDataHolder;
//#UC START# *54F461B00000_4683A3F40329_var*
var
 l_Inst: TqaDateReqDataHolder;
//#UC END# *54F461B00000_4683A3F40329_var*
begin
//#UC START# *54F461B00000_4683A3F40329_impl*
 if Assigned(aReq) then
 begin
  l_Inst := Create(aReq);
  try
   Result := l_Inst;
  finally
   l3Free(l_Inst)
  end;
 end
 else
  Result := nil;
//#UC END# *54F461B00000_4683A3F40329_impl*
end;//TqaDateReqDataHolder.Make

function TqaDateReqDataHolder.Get_StartDate: TDateTime;
//#UC START# *5232FE7B005F_4683A3F40329get_var*
//#UC END# *5232FE7B005F_4683A3F40329get_var*
begin
//#UC START# *5232FE7B005F_4683A3F40329get_impl*
 Result := f_StartDate;
//#UC END# *5232FE7B005F_4683A3F40329get_impl*
end;//TqaDateReqDataHolder.Get_StartDate

procedure TqaDateReqDataHolder.Set_StartDate(aValue: TDateTime);
//#UC START# *5232FE7B005F_4683A3F40329set_var*
//#UC END# *5232FE7B005F_4683A3F40329set_var*
begin
//#UC START# *5232FE7B005F_4683A3F40329set_impl*
 f_StartDate := aValue;
//#UC END# *5232FE7B005F_4683A3F40329set_impl*
end;//TqaDateReqDataHolder.Set_StartDate

function TqaDateReqDataHolder.Get_EndDate: TDateTime;
//#UC START# *5232FE830114_4683A3F40329get_var*
//#UC END# *5232FE830114_4683A3F40329get_var*
begin
//#UC START# *5232FE830114_4683A3F40329get_impl*
 Result := f_EndDate;
//#UC END# *5232FE830114_4683A3F40329get_impl*
end;//TqaDateReqDataHolder.Get_EndDate

procedure TqaDateReqDataHolder.Set_EndDate(aValue: TDateTime);
//#UC START# *5232FE830114_4683A3F40329set_var*
//#UC END# *5232FE830114_4683A3F40329set_var*
begin
//#UC START# *5232FE830114_4683A3F40329set_impl*
 f_EndDate := aValue;
//#UC END# *5232FE830114_4683A3F40329set_impl*
end;//TqaDateReqDataHolder.Set_EndDate

function TqaDateReqDataHolder.Get_IsOk: Boolean;
//#UC START# *5232FE9601A2_4683A3F40329get_var*
//#UC END# *5232FE9601A2_4683A3F40329get_var*
begin
//#UC START# *5232FE9601A2_4683A3F40329get_impl*
 Result := f_IsOk;
//#UC END# *5232FE9601A2_4683A3F40329get_impl*
end;//TqaDateReqDataHolder.Get_IsOk

procedure TqaDateReqDataHolder.Set_IsOk(aValue: Boolean);
//#UC START# *5232FE9601A2_4683A3F40329set_var*
//#UC END# *5232FE9601A2_4683A3F40329set_var*
begin
//#UC START# *5232FE9601A2_4683A3F40329set_impl*
 f_IsOk := aValue;
//#UC END# *5232FE9601A2_4683A3F40329set_impl*
end;//TqaDateReqDataHolder.Set_IsOk

function TqaDateReqDataHolder.Get_ReqCaption: Il3CString;
//#UC START# *5232FEA603CB_4683A3F40329get_var*
//#UC END# *5232FEA603CB_4683A3F40329get_var*
begin
//#UC START# *5232FEA603CB_4683A3F40329get_impl*
 Result := f_ReqCaption;
//#UC END# *5232FEA603CB_4683A3F40329get_impl*
end;//TqaDateReqDataHolder.Get_ReqCaption

function TqaDateReqDataHolder.IsStartDateEmpty: Boolean;
//#UC START# *5232FEB60232_4683A3F40329_var*
//#UC END# *5232FEB60232_4683A3F40329_var*
begin
//#UC START# *5232FEB60232_4683A3F40329_impl*
 Result := StartDate = NullDate;
//#UC END# *5232FEB60232_4683A3F40329_impl*
end;//TqaDateReqDataHolder.IsStartDateEmpty

function TqaDateReqDataHolder.IsEndDateEmpty: Boolean;
//#UC START# *5232FEC70307_4683A3F40329_var*
//#UC END# *5232FEC70307_4683A3F40329_var*
begin
//#UC START# *5232FEC70307_4683A3F40329_impl*
 Result := EndDate = NullDate;
//#UC END# *5232FEC70307_4683A3F40329_impl*
end;//TqaDateReqDataHolder.IsEndDateEmpty

procedure TqaDateReqDataHolder.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4683A3F40329_var*
//#UC END# *479731C50290_4683A3F40329_var*
begin
//#UC START# *479731C50290_4683A3F40329_impl*
 f_ReqCaption := nil;
 inherited;
//#UC END# *479731C50290_4683A3F40329_impl*
end;//TqaDateReqDataHolder.Cleanup

procedure TqaDateReqDataHolder.ClearFields;
begin
 f_ReqCaption := nil;
 inherited;
end;//TqaDateReqDataHolder.ClearFields

procedure TqaMgrSearch.DoFocusStartField;
//#UC START# *54F590B7028F_4683A4A90094_var*
 {$IFNDEF Monitorings}
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := false;
  // - прекращаем на первом реквизите
  aReq.EditorReq.FirstField.SetFocus;
 end;
 {$EndIF  Monitorings}

{$IFDEF Monitorings}
var
 l_Req: IqaReq;
{$EndIF Monitorings}
//#UC END# *54F590B7028F_4683A4A90094_var*
begin
//#UC START# *54F590B7028F_4683A4A90094_impl*
 {$IFDEF Monitorings}
 l_Req := FindAttr(nsCStr(cChangableReqName));
 if (l_Req <> nil) then
  l_Req.EditorReq.FirstField.SetFocus;
 {$ELSE}
 IterateAttrsF(l3L2FA(@DoReq));
 {$ENDIF Monitorings}
//#UC END# *54F590B7028F_4683A4A90094_impl*
end;//TqaMgrSearch.DoFocusStartField

{$If NOT Defined(Monitorings)}
constructor TqaMgrSearch.Create(const aQuery: IQuery;
 aQueryType: TlgQueryType;
 const aFormName: Il3CString;
 OnDateQuery: TOnDateQuery;
 OnNeedExecQuery: TNotifyEvent;
 OnModifiedChanged: TNotifyEvent;
 const aContextHistory: InsContextSearchHistory);
//#UC START# *54F594D4005F_4683A4A90094_var*
//#UC END# *54F594D4005F_4683A4A90094_var*
begin
//#UC START# *54F594D4005F_4683A4A90094_impl*
 f_FormName := aFormName;
 f_QueryType := aQueryType;
 f_IsQueryNew := True;
 f_OnDateQuery := OnDateQuery;
 f_OnNeedExecQuery := OnNeedExecQuery;
 f_OnModifiedChanged := OnModifiedChanged;
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 f_ContextHistory := aContextHistory;
 {$IfEnd}
 // Загрузим IQuery
 if (aQuery = nil) then
  {$If not defined(Admin)}
  nsQuery.CreateQuery(f_Query, BusinessQueryToAdapterQuery(aQueryType))
  {$Else}
  Assert(false)
  {$IfEnd}
 else
 begin
  f_Query := aQuery;
  f_IsQueryNew := False;
 end;//aQuery = nil
//#UC END# *54F594D4005F_4683A4A90094_impl*
end;//TqaMgrSearch.Create
{$IfEnd} // NOT Defined(Monitorings)

{$If NOT Defined(Monitorings)}
class function TqaMgrSearch.Make(const aQuery: IQuery;
 aQueryType: TlgQueryType;
 const aFormName: Il3CString;
 OnDateQuery: TOnDateQuery;
 OnNeedExecQuery: TNotifyEvent;
 OnModifiedChanged: TNotifyEvent;
 const aContextHistory: InsContextSearchHistory): IqaMgrSearch;
var
 l_Inst : TqaMgrSearch;
begin
 l_Inst := Create(aQuery, aQueryType, aFormName, OnDateQuery, OnNeedExecQuery, OnModifiedChanged, aContextHistory);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TqaMgrSearch.Make
{$IfEnd} // NOT Defined(Monitorings)

{$If Defined(Monitorings)}
constructor TqaMgrSearch.Create(const aQuery: IQuery;
 aQueryType: TlgQueryType;
 const aFormName: Il3CString;
 OnDateQuery: TOnDateQuery;
 OnNeedExecQuery: TNotifyEvent;
 OnModifiedChanged: TNotifyEvent);
//#UC START# *54F5990601E6_4683A4A90094_var*
//#UC END# *54F5990601E6_4683A4A90094_var*
begin
//#UC START# *54F5990601E6_4683A4A90094_impl*
 f_FormName := aFormName;
 f_QueryType := aQueryType;
 f_IsQueryNew := True;
 f_OnDateQuery := OnDateQuery;
 f_OnNeedExecQuery := OnNeedExecQuery;
 f_OnModifiedChanged := OnModifiedChanged;
 // Загрузим IQuery
 if (aQuery = nil) then
  {$If not defined(Admin)}
  nsQuery.CreateQuery(f_Query, BusinessQueryToAdapterQuery(aQueryType))
  {$Else}
  Assert(false)
  {$IfEnd}
 else
 begin
  f_Query := aQuery;
  f_IsQueryNew := False;
 end;//aQuery = nil
//#UC END# *54F5990601E6_4683A4A90094_impl*
end;//TqaMgrSearch.Create
{$IfEnd} // Defined(Monitorings)

{$If Defined(Monitorings)}
class function TqaMgrSearch.Make(const aQuery: IQuery;
 aQueryType: TlgQueryType;
 const aFormName: Il3CString;
 OnDateQuery: TOnDateQuery;
 OnNeedExecQuery: TNotifyEvent;
 OnModifiedChanged: TNotifyEvent): IqaMgrSearch;
var
 l_Inst : TqaMgrSearch;
begin
 l_Inst := Create(aQuery, aQueryType, aFormName, OnDateQuery, OnNeedExecQuery, OnModifiedChanged);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TqaMgrSearch.Make
{$IfEnd} // Defined(Monitorings)

function TqaMgrSearch.NeedSettings: Boolean;
//#UC START# *54F59B5200CD_4683A4A90094_var*
//#UC END# *54F59B5200CD_4683A4A90094_var*
begin
//#UC START# *54F59B5200CD_4683A4A90094_impl*
 Result := not (f_QueryType in [lg_qtSendConsultation]);
//#UC END# *54F59B5200CD_4683A4A90094_impl*
end;//TqaMgrSearch.NeedSettings

procedure TqaMgrSearch.FinishEntering;
//#UC START# *54F59B6502ED_4683A4A90094_var*
//#UC END# *54F59B6502ED_4683A4A90094_var*
begin
//#UC START# *54F59B6502ED_4683A4A90094_impl*
 (f_QueryCard As InevControlListener).HideDroppedControl(True);  
//#UC END# *54F59B6502ED_4683A4A90094_impl*
end;//TqaMgrSearch.FinishEntering

function TqaMgrSearch.MakeGroupsSettingId: Il3CString;
//#UC START# *54F59B7303B9_4683A4A90094_var*
//#UC END# *54F59B7303B9_4683A4A90094_var*
begin
//#UC START# *54F59B7303B9_4683A4A90094_impl*
 Result := l3Fmt('%s/%s', [pi_ClosedGroups, f_FormName]);
//#UC END# *54F59B7303B9_4683A4A90094_impl*
end;//TqaMgrSearch.MakeGroupsSettingId

function TqaMgrSearch.MakeDescriptionsSettingId: Il3CString;
//#UC START# *54F59B88025A_4683A4A90094_var*
//#UC END# *54F59B88025A_4683A4A90094_var*
begin
//#UC START# *54F59B88025A_4683A4A90094_impl*
 Result := l3Fmt('%s/%s', [pi_CollapsedDescriptions, f_FormName]);
//#UC END# *54F59B88025A_4683A4A90094_impl*
end;//TqaMgrSearch.MakeDescriptionsSettingId

function TqaMgrSearch.GetCurrentEditorReq: IevReq;
//#UC START# *54F59BA10052_4683A4A90094_var*
var
 l_CustCtrl: IevCustomEditorControl;
 l_Control: IevEditorControl;
//#UC END# *54F59BA10052_4683A4A90094_var*
begin
//#UC START# *54F59BA10052_4683A4A90094_impl*
 l_CustCtrl := QueryCard.GetStateControl;
 if (l_CustCtrl <> nil) and l_CustCtrl.Visible then
 begin
  if Supports(l_CustCtrl, IevEditorControl, l_Control) then
   Result := l_Control.Req
  else
   Result := nil;
 end
 else
  Result := nil;
//#UC END# *54F59BA10052_4683A4A90094_impl*
end;//TqaMgrSearch.GetCurrentEditorReq

procedure TqaMgrSearch.IterateAttrsF(anAction: Tl3FreeAction);
//#UC START# *54F59BBE0039_4683A4A90094_var*
var
 I, J: Integer;
 l_QueryGroup: IevQueryGroup;
 l_Req: IqaReq;
//#UC END# *54F59BBE0039_4683A4A90094_var*
begin
//#UC START# *54F59BBE0039_4683A4A90094_impl*
 if Assigned(anAction) then
 try
  if (f_QueryCard <> nil) then
   for I := 0 to f_QueryCard.GroupCount - 1 do
   begin
    l_QueryGroup := f_QueryCard.QueryGroup[I];
    try
     for J := 0 to l_QueryGroup.ReqCount - 1 do
     begin
      l_Req := TqaReq.Make(Self, l_QueryGroup.Req[J]);
      try
       if not anAction(Pointer(l_Req)) then
        Exit;
      finally
       l_Req := nil;
      end;//try..finally
     end;//for J
    finally
     l_QueryGroup := nil;
    end;//try..finally
   end;//for I
 finally
  l3FreeFA(anAction);
 end;//try..finally
//#UC END# *54F59BBE0039_4683A4A90094_impl*
end;//TqaMgrSearch.IterateAttrsF

procedure TqaMgrSearch.CallModifiedChanged;
//#UC START# *54F59BCF01B2_4683A4A90094_var*
//#UC END# *54F59BCF01B2_4683A4A90094_var*
begin
//#UC START# *54F59BCF01B2_4683A4A90094_impl*
 if (f_InModifiedChanged <= 0) then
 begin
  Inc(f_InModifiedChanged);
  try
   if Assigned(f_OnModifiedChanged) then
    f_OnModifiedChanged(Self);
  finally
   Dec(f_InModifiedChanged);
  end;//try..finally
 end;//f_InModifiedChanged <= 0
//#UC END# *54F59BCF01B2_4683A4A90094_impl*
end;//TqaMgrSearch.CallModifiedChanged

procedure TqaMgrSearch.ClearAttrs;
//#UC START# *54F59BDA034F_4683A4A90094_var*
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := true;
  aReq.ReqClear;
 end;

{$IfDef Monitorings}
var
 l_CR: IqaReq;
{$EndIf Monitorings}
//#UC END# *54F59BDA034F_4683A4A90094_var*
begin
//#UC START# *54F59BDA034F_4683A4A90094_impl*
 IterateAttrsF(l3L2FA(@DoReq));
{$IfDef Monitorings}
 l_CR := ChangableReq;
 if (l_CR <> nil) then
  l_CR.MakeFieldValue;
{$EndIf Monitorings}
//#UC END# *54F59BDA034F_4683A4A90094_impl*
end;//TqaMgrSearch.ClearAttrs

procedure TqaMgrSearch.CheckAttrs;
//#UC START# *54F59BF002AF_4683A4A90094_var*
 function DoCheckReq(const aReq: IqaReq): Boolean;
 begin
  Result := true;
  aReq.CheckAttr;
 end;
//#UC END# *54F59BF002AF_4683A4A90094_var*
begin
//#UC START# *54F59BF002AF_4683A4A90094_impl*
 IterateAttrsF(l3L2FA(@DoCheckReq));
//#UC END# *54F59BF002AF_4683A4A90094_impl*
end;//TqaMgrSearch.CheckAttrs

{$If NOT Defined(Monitorings)}
procedure TqaMgrSearch.CheckMorpho;
//#UC START# *54F59BFB00BD_4683A4A90094_var*
var
 l_TotalContext: Il3StringsEx;

 function DoCollectContext(const aReq: IqaReq): Boolean;
 var
  l_Req: IqaMorphoReq;
  l_Context: Il3CString;
 begin
  Result := true;
  if Supports(aReq, IqaMorphoReq, l_Req) then
   l_Req.FillReqListAsString(l_TotalContext);
 end;
const
 c_InpharmSearches = [lg_qtInpharmSearch];
//#UC END# *54F59BFB00BD_4683A4A90094_var*
begin
//#UC START# *54F59BFB00BD_4683A4A90094_impl*
 l_TotalContext := TvcmStringList.Make;
 IterateAttrsF(l3L2FA(@DoCollectContext));
 f_FirstErrorContextReq := nil;
 try
  {$If not (defined(Monitorings) or defined(Admin))}
  if bsUtils.bsCorrectMistakes(l_TotalContext, QueryType in c_InpharmSearches, Self) and Assigned(f_FirstErrorContextReq) then
   raise EqaSilentAbort.Create(f_FirstErrorContextReq,'');
  {$Else}
  Assert(false);
  {$IfEnd}
 finally
  f_FirstErrorContextReq := nil;
 end;
//#UC END# *54F59BFB00BD_4683A4A90094_impl*
end;//TqaMgrSearch.CheckMorpho
{$IfEnd} // NOT Defined(Monitorings)

procedure TqaMgrSearch.InitFocus;
//#UC START# *54F59C0E0149_4683A4A90094_var*
//#UC END# *54F59C0E0149_4683A4A90094_var*
begin
//#UC START# *54F59C0E0149_4683A4A90094_impl*
 if NeedSettings then
  f_QueryCard.StartSetFocus;
//#UC END# *54F59C0E0149_4683A4A90094_impl*
end;//TqaMgrSearch.InitFocus

function TqaMgrSearch.Get_Query: IQuery;
//#UC START# *468395DE02D4_4683A4A90094get_var*
//#UC END# *468395DE02D4_4683A4A90094get_var*
begin
//#UC START# *468395DE02D4_4683A4A90094get_impl*
 Result := f_Query;
//#UC END# *468395DE02D4_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_Query

procedure TqaMgrSearch.Set_Query(const aValue: IQuery);
//#UC START# *468395DE02D4_4683A4A90094set_var*
{$IFDEF Monitorings}
var
 CR: IqaReq;
{$EndIF Monitorings}
//#UC END# *468395DE02D4_4683A4A90094set_var*
begin
//#UC START# *468395DE02D4_4683A4A90094set_impl*
 if (aValue <> nil) then
 begin
  if f_Query <> nil then
   f_Query.Clear;
  if not f_FromHistory then
  begin
   ClearAttrs;
   Self.QueryCard.CardClear;
  end;//not f_FromHistory
  f_Query := nil;
  f_Query := aValue;
  Load;
  f_IsQueryNew := False; //Формирование значения поля для загруженного запроса
  {$IFDEF Monitorings}
  CR := ChangableReq;
  if (CR <> nil) then
  begin
   CR.MakeFieldValue;
   InitFocus;
  end;//CR <> nil
  {$ENDIF Monitorings}
 end//aValue <> nil
 else
 begin
  f_IsQueryNew := True; //Чистая КЗ
  f_Query := nil;
 end;//aValue <> nil
//#UC END# *468395DE02D4_4683A4A90094set_impl*
end;//TqaMgrSearch.Set_Query

procedure TqaMgrSearch.FocusStartField;
 {* Устанавливает фокус на первый элемент. }
//#UC START# *47CD5FAF01CE_4683A4A90094_var*
//#UC END# *47CD5FAF01CE_4683A4A90094_var*
begin
//#UC START# *47CD5FAF01CE_4683A4A90094_impl*
 DoFocusStartField;
//#UC END# *47CD5FAF01CE_4683A4A90094_impl*
end;//TqaMgrSearch.FocusStartField

procedure TqaMgrSearch.LimitCharsReached(const aControl: IevEditorControl);
//#UC START# *47CD5FBC0170_4683A4A90094_var*
//#UC END# *47CD5FBC0170_4683A4A90094_var*
begin
//#UC START# *47CD5FBC0170_4683A4A90094_impl*
 vcmSay(err_LimitCharsReached,[aControl.MaxLength]);
//#UC END# *47CD5FBC0170_4683A4A90094_impl*
end;//TqaMgrSearch.LimitCharsReached

function TqaMgrSearch.GetTreeFromAdapter(const aReq: Il3CString): InevSimpleTree;
 {* Получает дерево с адаптера. }
//#UC START# *47CD605F001E_4683A4A90094_var*
var
 l_Filters: InsAttributeTreeFilters;
 l_Tree: Il3FilterableTree;
 l_Index: Integer;
 l_AF: TnsFilterType;
//#UC END# *47CD605F001E_4683A4A90094_var*
begin
//#UC START# *47CD605F001E_4683A4A90094_impl*
 Result := TnsAttributeTreeStruct.Make(aReq, False);
 if Supports(Result, Il3FilterableTree, l_Tree) and
    Supports(l_Tree.CloneFilters, InsAttributeTreeFilters, l_Filters) then
 begin
  l_AF := GetAdditionalFilter(aReq, QueryType);
  if (l_Filters.FilterType <> l_AF) then
   Result := l_Tree.MakeFiltered(l_Filters.SetFilterType(l_AF).SetContext(nil), nil, l_Index, True, True);
 end;//Supports(Result, Il3FilterableTree, l_Tree)..
//#UC END# *47CD605F001E_4683A4A90094_impl*
end;//TqaMgrSearch.GetTreeFromAdapter

procedure TqaMgrSearch.EscPressed(const aField: IevEditorFieldWithTree);
 {* Обработчик закрытия дерева по ESC. }
//#UC START# *47CD60AF0052_4683A4A90094_var*
{$IFDEF Monitorings}
var
 l_CR: IqaReq;
{$ENDIF Monitorings}
//#UC END# *47CD60AF0052_4683A4A90094_var*
begin
//#UC START# *47CD60AF0052_4683A4A90094_impl*
 {$IFDEF Monitorings}
 if l3SomeOf(aField.Req.ReqName, cSrc) then
 begin
  l_CR := ChangableReq;
  if (l_CR <> nil) then
   l_CR.MakeFieldValue;
 end;//l3Same(aField.Req.ReqName, cSrc[l_Index])
 {$ENDIF Monitorings}
//#UC END# *47CD60AF0052_4683A4A90094_impl*
end;//TqaMgrSearch.EscPressed

{$If NOT Defined(Monitorings)}
function TqaMgrSearch.Get_HistoryList: Il3StringsEx;
//#UC START# *47CD60F50164_4683A4A90094get_var*
//#UC END# *47CD60F50164_4683A4A90094get_var*
begin
//#UC START# *47CD60F50164_4683A4A90094get_impl*
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 Assert(Assigned(f_ContextHistory));
 Result := f_ContextHistory.History;
{$IfEnd}
//#UC END# *47CD60F50164_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_HistoryList
{$IfEnd} // NOT Defined(Monitorings)

function TqaMgrSearch.ModelListener(const aReq: IevReq): IevModelListener;
//#UC START# *47CD9AB2023F_4683A4A90094_var*
//#UC END# *47CD9AB2023F_4683A4A90094_var*
begin
//#UC START# *47CD9AB2023F_4683A4A90094_impl*
 if (aReq = nil) then
  Result := nil
 else
  Supports(TqaReq.Make(Self, aReq), IevModelListener, Result);
//#UC END# *47CD9AB2023F_4683A4A90094_impl*
end;//TqaMgrSearch.ModelListener

function TqaMgrSearch.GetPromptTreeFromAdapter: InevSimpleTree;
//#UC START# *486C765001F5_4683A4A90094_var*
//#UC END# *486C765001F5_4683A4A90094_var*
begin
//#UC START# *486C765001F5_4683A4A90094_impl*
{ if QueryType in c_InpharmSearches then
  Result := nil
 else
  Result := BaseSearchPromptTree;}
 Result := nil; // К-104432064
//#UC END# *486C765001F5_4683A4A90094_impl*
end;//TqaMgrSearch.GetPromptTreeFromAdapter

procedure TqaMgrSearch.NotifyContextWrong;
//#UC START# *4885BFB60314_4683A4A90094_var*
//#UC END# *4885BFB60314_4683A4A90094_var*
begin
//#UC START# *4885BFB60314_4683A4A90094_impl*
 nsBeepWrongContext;
//#UC END# *4885BFB60314_4683A4A90094_impl*
end;//TqaMgrSearch.NotifyContextWrong

procedure TqaMgrSearch.Correct(const aCorrectedContext: Il3StringsEx;
 const aMistakesList: Il3StringsEx);
//#UC START# *496B513C0168_4683A4A90094_var*
var
 l_ContextsIdx: Integer;

 function DoCorrectContext(const aReq: IqaReq): Boolean;

  function lp_HasErrorWords(const aContext: Il3CString): Boolean;
  var
   l_IDX: Integer;
  begin//lp_HasErrorWords
   Result := False;
   if Assigned(aMistakesList) then
    for l_IDX := 0 to aMistakesList.Count - 1 do
     if l3Pos(l3Upper(aContext), l3Upper(aMistakesList.ItemC[l_IDX])) > -1 then
     begin
      Result := True;
      Exit;
     end;//l3Pos..
  end;//lp_HasErrorWords

 var
  l_Idx: Integer;
  l_Text: Il3CString;
  l_Index: Integer;
  l_Para: InevPara;
  l_DummyText: Il3CString;
 const
  l_Opt = [ev_soGlobal, ev_soUseInternalCursor, ev_soReplaceAll, ev_soNoProgress];
 begin//DoCorrectContext
  Result := true;
  if Supports(aReq, IqaMorphoReq) then
  begin
   for l_IDX := 0 to aReq.EditorReq.FieldsCount - 1 do
    if not aReq.EditorReq.Fields[l_IDX].IsFieldEmpty then
    begin
     if (l_ContextsIdx < aCorrectedContext.Count) then // http://mdp.garant.ru/pages/viewpage.action?pageId=326773154
     begin
      if not l3Same(aReq.EditorReq.Fields[l_IDX].Text, aCorrectedContext[l_ContextsIdx]) then
       aReq.EditorReq.Fields[l_IDX].Text := aCorrectedContext[l_ContextsIdx];
     end
     else
      aReq.EditorReq.Fields[l_IDX].Text := l3CStr(''); // http://mdp.garant.ru/pages/viewpage.action?pageId=326773154
     if (f_FirstErrorContextReq = nil) then
     begin
      if lp_HasErrorWords(aReq.EditorReq.Fields[l_IDX].Text) then
       f_FirstErrorContextReq := aReq.EditorReq.Fields[l_IDX];
     end;//f_FirstErrorContextReq = nil
     l_Para := aReq.EditorReq.Fields[l_IDX].Para;
     with l_Para.AsObject.Attr[k2_tiSegments] do
      if IsValid then
      begin
       if rAtomEx([k2_tiChildren, k2_tiHandle, Ord(ev_slMistakes)], @l_Index).IsValid then
        DeleteChild(l_Index);
      end;//IsValid
     if Assigned(aMistakesList) then
     begin
      for l_Index := 0 to Pred(aMistakesList.Count) do
      begin
       evReplaceInPara(l_Para,
                       TevStrictWordSearcher.Make(l3Str(aMistakesList[l_Index]), l_Opt),
                       TevStyleReplacer.MakeForStyleID(ev_saMistake, l_Opt));
      end;//for l_Index
     end;//l_Words <> nil
     Inc(l_ContextsIdx);
     if (l_ContextsIdx >= aCorrectedContext.Count) then
      Result := False;
    end;//not aReq.EditorReq.Fields[l_IDX].IsFieldEmpty
  end;//Supports(aReq, IqaMorphoReq)
 end;//DoCorrectContext
//#UC END# *496B513C0168_4683A4A90094_var*
begin
//#UC START# *496B513C0168_4683A4A90094_impl*
 l_ContextsIdx := 0;
 IterateAttrsF(l3L2FA(@DoCorrectContext));
//#UC END# *496B513C0168_4683A4A90094_impl*
end;//TqaMgrSearch.Correct

function TqaMgrSearch.Get_QueryType: TlgQueryType;
//#UC START# *5232FFE502F6_4683A4A90094get_var*
//#UC END# *5232FFE502F6_4683A4A90094get_var*
begin
//#UC START# *5232FFE502F6_4683A4A90094get_impl*
 Result := f_QueryType;
//#UC END# *5232FFE502F6_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_QueryType

function TqaMgrSearch.Get_IsQueryNew: Boolean;
//#UC START# *5233001E0237_4683A4A90094get_var*
//#UC END# *5233001E0237_4683A4A90094get_var*
begin
//#UC START# *5233001E0237_4683A4A90094get_impl*
 Result := f_IsQueryNew;
//#UC END# *5233001E0237_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_IsQueryNew

function TqaMgrSearch.Get_Modified: Boolean;
//#UC START# *5233003601FF_4683A4A90094get_var*
//#UC END# *5233003601FF_4683A4A90094get_var*
begin
//#UC START# *5233003601FF_4683A4A90094get_impl*
 Result := (f_Modified > 0);
//#UC END# *5233003601FF_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_Modified

procedure TqaMgrSearch.Set_Modified(aValue: Boolean);
//#UC START# *5233003601FF_4683A4A90094set_var*
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := True;
  aReq.Modified := aValue;
 end;
//#UC END# *5233003601FF_4683A4A90094set_var*
begin
//#UC START# *5233003601FF_4683A4A90094set_impl*
 if (Get_Modified <> aValue) then
 begin
  Inc(f_InModifiedChanged);
  try
   IterateAttrsF(l3L2FA(@DoReq));
  finally
   Dec(f_InModifiedChanged);
  end;//try..finally
  CallModifiedChanged;
 end;//Get_Modified <> aValue
//#UC END# *5233003601FF_4683A4A90094set_impl*
end;//TqaMgrSearch.Set_Modified

function TqaMgrSearch.Get_FromHistory: Boolean;
//#UC START# *5233004F0358_4683A4A90094get_var*
//#UC END# *5233004F0358_4683A4A90094get_var*
begin
//#UC START# *5233004F0358_4683A4A90094get_impl*
 Result := f_FromHistory;
//#UC END# *5233004F0358_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_FromHistory

procedure TqaMgrSearch.Set_FromHistory(aValue: Boolean);
//#UC START# *5233004F0358_4683A4A90094set_var*
//#UC END# *5233004F0358_4683A4A90094set_var*
begin
//#UC START# *5233004F0358_4683A4A90094set_impl*
 f_FromHistory := aValue;
//#UC END# *5233004F0358_4683A4A90094set_impl*
end;//TqaMgrSearch.Set_FromHistory

function TqaMgrSearch.Get_QueryCard: IevQueryCard;
//#UC START# *52330082029F_4683A4A90094get_var*
//#UC END# *52330082029F_4683A4A90094get_var*
begin
//#UC START# *52330082029F_4683A4A90094get_impl*
 Result := f_QueryCard;
//#UC END# *52330082029F_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_QueryCard

{$If NOT Defined(Monitorings)}
function TqaMgrSearch.Get_HistoryValues: IvcmStrings;
//#UC START# *523300DC03BB_4683A4A90094get_var*
//#UC END# *523300DC03BB_4683A4A90094get_var*
begin
//#UC START# *523300DC03BB_4683A4A90094get_impl*
 Result := Get_HistoryList;
//#UC END# *523300DC03BB_4683A4A90094get_impl*
end;//TqaMgrSearch.Get_HistoryValues
{$IfEnd} // NOT Defined(Monitorings)

procedure TqaMgrSearch.FinishOpenTree(const aRoot: INodeBase;
 const aReq: IqaReq);
//#UC START# *523302260240_4683A4A90094_var*
var
 l_ReqAttr: IqaReqAttribute;
//#UC END# *523302260240_4683A4A90094_var*
begin
//#UC START# *523302260240_4683A4A90094_impl*
 QueryCard.Editor.Selection.Unselect;
 if (aReq <> nil) and Supports(FindAttr(aReq.TagName), IqaReqAttribute, l_ReqAttr) then //Его может и не быть после обновления.
 try
  l_ReqAttr.GetAttributesFromView(aRoot);
 finally
  l_ReqAttr := nil;
 end;//aReq <> nil
//#UC END# *523302260240_4683A4A90094_impl*
end;//TqaMgrSearch.FinishOpenTree

procedure TqaMgrSearch.ReadSettings;
//#UC START# *52330265006F_4683A4A90094_var*
const
 FuckMagic = 'NOT DEFINED';
var
 l_Groups: Il3CString;
 l_Index: Integer;
 l_DIdx: Integer;
 l_GroupCount: Integer;
 l_Descriptions: Il3CString;
//#UC END# *52330265006F_4683A4A90094_var*
begin
//#UC START# *52330265006F_4683A4A90094_impl*
 if NeedSettings then
 begin
  g_Dispatcher.FormDispatcher.Lock;
  try
   l_GroupCount := f_QueryCard.GroupCount - 1;
   l_Descriptions := afw.Settings.LoadString(nsAStr(MakeDescriptionsSettingId).S, '');
   for l_Index := 0 to l_GroupCount do
    with f_QueryCard.QueryGroup[l_Index] do
     for l_DIdx := 0 to DescriptionReqCount-1 do
      with DescriptionReq[l_DIdx] do
       Collapsed := (l3Pos(l_Descriptions,
                           l3Cat([nsCStr(' '),
                                  l3Upper(ReqName),
                                  nsCStr(' ')])) >= 0);
   l_Groups := afw.Settings.LoadString(nsAStr(MakeGroupsSettingId).S, FuckMagic);
   // читаем из настроек
   if (l_GroupCount = 0) then
    f_QueryCard.QueryGroup[0].Expanded := True
   else
    if (f_QueryType = lg_qtPostingOrder) then
     f_QueryCard.ChangeStateAll(True)
    else
     if not l3Same(l_Groups, FuckMagic) then
      for l_Index := 0 to l_GroupCount do
       with f_QueryCard.QueryGroup[l_Index] do
        Expanded := (l3Pos(l_Groups, GroupName) >= 0)
     // при первой загрузке "Расширенные реквизиты свернуты"
     else
     if (l_GroupCount >= 0) then
     begin
      // свернём все
      f_QueryCard.ChangeStateAll(False);
      // развернём только первую
      f_QueryCard.QueryGroup[0].Expanded := True;
     end;//l_GroupCount >= 0
  finally
   g_Dispatcher.FormDispatcher.UnLock;
  end;// g_Dispatcher.FormDispatcher.Lock;
 end;//NeedSettings
//#UC END# *52330265006F_4683A4A90094_impl*
end;//TqaMgrSearch.ReadSettings

procedure TqaMgrSearch.WriteSettings;
//#UC START# *5233030F0167_4683A4A90094_var*
var
 l_Index: Integer;
 l_DIdx: Integer;
 l_Groups: Il3CString;
 l_Descriptions: Il3CString;
 l_Group: IevQueryGroup;
//#UC END# *5233030F0167_4683A4A90094_var*
begin
//#UC START# *5233030F0167_4683A4A90094_impl*
 if NeedSettings AND (f_QueryCard <> nil) then
 begin
  l_Descriptions := nil;
  l_Groups := nil;
  // Запишем группы, которые развернуты
  for l_Index := 0 to f_QueryCard.GroupCount - 1 do
  begin
   l_Group := f_QueryCard.QueryGroup[l_Index];
   try
    for l_DIdx := 0 to l_Group.DescriptionReqCount-1 do
     with l_Group.DescriptionReq[l_DIdx] do
      if Collapsed then
       l_Descriptions := l3Cat([l_Descriptions,
                                nsCStr(' '),
                                l3Upper(ReqName),
                                nsCStr(' ')]);
    if l_Group.Expanded then
     l_Groups := l3Cat([l_Groups, l_Group.GroupName]);
   finally
    l_Group := nil;
   end;//try..finally
  end;//for l_Index
  // Запомним закрытые группы в настройках
  afw.Settings.SaveString(nsAStr(MakeGroupsSettingId).S, l_Groups);
  afw.Settings.SaveString(nsAStr(MakeDescriptionsSettingId).S, l_Descriptions);
 end;//NeedSettings
//#UC END# *5233030F0167_4683A4A90094_impl*
end;//TqaMgrSearch.WriteSettings

procedure TqaMgrSearch.InitUpdate;
//#UC START# *5233031801BE_4683A4A90094_var*
//#UC END# *5233031801BE_4683A4A90094_var*
begin
//#UC START# *5233031801BE_4683A4A90094_impl*
 f_QueryCard := nil;
//#UC END# *5233031801BE_4683A4A90094_impl*
end;//TqaMgrSearch.InitUpdate

procedure TqaMgrSearch.Clear;
//#UC START# *5233031F027E_4683A4A90094_var*
//#UC END# *5233031F027E_4683A4A90094_var*
begin
//#UC START# *5233031F027E_4683A4A90094_impl*
 if (f_QueryCard <> nil) then
 begin
  (f_QueryCard As InevControlListener).HideDroppedControl(True);
  ClearAttrs;
  Self.QueryCard.CardClear;
  f_Modified := 0;
 end;//f_QueryCard <> nil
 {$IFDEF Monitorings}
 f_Query := nil;
 nsQuery.CreateQuery(f_Query, BusinessQueryToAdapterQuery(f_QueryType));
 {$ELSE Monitorings}
 f_Query.Clear;
 {$ENDIF Monitorings}
//#UC END# *5233031F027E_4683A4A90094_impl*
end;//TqaMgrSearch.Clear

procedure TqaMgrSearch.ClearContextMistakes;
//#UC START# *5233032700CE_4683A4A90094_var*
 function DoClearMistakes(const aReq: IqaReq): Boolean;
 var
  l_Idx: Integer;
  l_Index: Integer;
  l_Para: InevPara;
 begin
  Result := true;
  if Supports(aReq, IqaMorphoReq) then
  begin
   for l_IDX := 0 to aReq.EditorReq.FieldsCount - 1 do
   begin
    l_Para := aReq.EditorReq.Fields[l_IDX].Para;
    with l_Para.AsObject.Attr[k2_tiSegments] do
     if IsValid then
     begin
      if rAtomEx([k2_tiChildren, k2_tiHandle, Ord(ev_slMistakes)], @l_Index).IsValid then
      begin
       DeleteChild(l_Index);
       evSegments_ClearSuper(l_Para, nil);
       // - по-хорошему это надо в ChildDeleted, но туда пока достучаться не можем
      end;//rAtomEx([k2_tiChildren, k2_tiHandle, ev_slMistakes], @l_Index).IsValid
     end;//IsValid
   end;  
  end;
 end;
//#UC END# *5233032700CE_4683A4A90094_var*
begin
//#UC START# *5233032700CE_4683A4A90094_impl*
 IterateAttrsF(l3L2FA(@DoClearMistakes));
//#UC END# *5233032700CE_4683A4A90094_impl*
end;//TqaMgrSearch.ClearContextMistakes

procedure TqaMgrSearch.AddValue(const aView: InevView);
//#UC START# *52330349022C_4683A4A90094_var*
var
 l_Req: IevReq;
//#UC END# *52330349022C_4683A4A90094_var*
begin
//#UC START# *52330349022C_4683A4A90094_impl*
 l_Req := GetCurrentEditorReq; 
 if l_Req <> nil then
  l_Req.AddField(aView, True);
//#UC END# *52330349022C_4683A4A90094_impl*
end;//TqaMgrSearch.AddValue

procedure TqaMgrSearch.DeleteValue(const aView: InevView);
//#UC START# *523303590369_4683A4A90094_var*
var
 l_Field: IevEditorControlField;
 l_Req: IevReq;
//#UC END# *523303590369_4683A4A90094_var*
begin
//#UC START# *523303590369_4683A4A90094_impl*
 l_Field := GetCurrentField;
 if Assigned(l_Field) then
 begin
  l_Req := GetCurrentEditorReq;
  if Assigned(l_Req) then
   l_Req.DeleteField(aView, l_Field, True);
 end;
//#UC END# *523303590369_4683A4A90094_impl*
end;//TqaMgrSearch.DeleteValue

procedure TqaMgrSearch.DeleteAll;
//#UC START# *5233037903AD_4683A4A90094_var*
var
 l_Req: IqaReq;
//#UC END# *5233037903AD_4683A4A90094_var*
begin
//#UC START# *5233037903AD_4683A4A90094_impl*
 l_Req := GetCurrentReq; 
 if l_Req <> nil then
  l_Req.ReqClear;
//#UC END# *5233037903AD_4683A4A90094_impl*
end;//TqaMgrSearch.DeleteAll

procedure TqaMgrSearch.OpenSelectWindow;
//#UC START# *5233038D008F_4683A4A90094_var*
var
 l_Req: IqaReq;
//#UC END# *5233038D008F_4683A4A90094_var*
begin
//#UC START# *5233038D008F_4683A4A90094_impl*
 l_Req := GetCurrentReq; 
 if l_Req <> nil then
  l_Req.OpenSelectWindow;
//#UC END# *5233038D008F_4683A4A90094_impl*
end;//TqaMgrSearch.OpenSelectWindow

function TqaMgrSearch.ChangableReq: IqaReq;
 {* Изменяющаеся значение при изменении реквизита }
//#UC START# *523303A90350_4683A4A90094_var*
//#UC END# *523303A90350_4683A4A90094_var*
begin
//#UC START# *523303A90350_4683A4A90094_impl*
 Result := FindAttr(nsCStr(cChangableReqName));
//#UC END# *523303A90350_4683A4A90094_impl*
end;//TqaMgrSearch.ChangableReq

function TqaMgrSearch.GetName4Query: Il3CString;
 {* Возвращают имя для запроса }
//#UC START# *523303F700C1_4683A4A90094_var*
var
 l_Field: IevEditorControlField;
 CR: IqaReq;
//#UC END# *523303F700C1_4683A4A90094_var*
begin
//#UC START# *523303F700C1_4683A4A90094_impl*
 CR := ChangableReq;
 Assert(CR <> nil);
 l_Field := CR.EditorReq.FirstField;
 if l_Field.IsFieldEmpty then
  CR.MakeFieldValue;
 Result := l_Field.Text;
//#UC END# *523303F700C1_4683A4A90094_impl*
end;//TqaMgrSearch.GetName4Query

function TqaMgrSearch.GetCurrentReq: IqaReq;
 {* Возвращает текущий реквизит для контрола }
//#UC START# *523304BF01B5_4683A4A90094_var*
var
 l_CustCtrl: IevCustomEditorControl; 
 l_Control: IevEditorControl;
//#UC END# *523304BF01B5_4683A4A90094_var*
begin
//#UC START# *523304BF01B5_4683A4A90094_impl*
 l_CustCtrl := QueryCard.GetStateControl;
 if (l_CustCtrl <> nil) and l_CustCtrl.Visible then
 begin
  if Supports(l_CustCtrl, IevEditorControl, l_Control) then
   Result := TqaReq.Make(Self, l_Control.Req)
  else
   Result := nil;
 end//(l_CustCtrl <> nil) and l_CustCtrl.Visible 
 else 
  Result := nil; 
//#UC END# *523304BF01B5_4683A4A90094_impl*
end;//TqaMgrSearch.GetCurrentReq

function TqaMgrSearch.GetCurrentField: IevEditorControlField;
 {* Возвращает текущий контрол для реквизита }
//#UC START# *523304D6011A_4683A4A90094_var*
var
 l_CustCtrl: IevCustomEditorControl;
 l_Control: IevEditorControl;
//#UC END# *523304D6011A_4683A4A90094_var*
begin
//#UC START# *523304D6011A_4683A4A90094_impl*
 l_CustCtrl := QueryCard.GetStateControl;
 if (l_CustCtrl <> nil) and l_CustCtrl.Visible then
 begin
  if Supports(l_CustCtrl, IevEditorControl, l_Control) then
   if l_Control.Field = nil then
    l_Control.QueryInterface(IevEditorControlField, Result)
   else
    Result := l_Control.Field
 end
 else
  Result := nil;
//#UC END# *523304D6011A_4683A4A90094_impl*
end;//TqaMgrSearch.GetCurrentField

procedure TqaMgrSearch.CreateTree(const aQueryCard: IevQueryCard);
//#UC START# *5233051C0075_4683A4A90094_var*
{$ifndef Admin}
var
 CR: IqaReq;
{$endif}
//#UC END# *5233051C0075_4683A4A90094_var*
begin
//#UC START# *5233051C0075_4683A4A90094_impl*
 if (aQueryCard <> f_QueryCard) then
 begin
  if (f_QueryCard <> nil) then
   f_QueryCard.LinkListener(nil);
  f_QueryCard := aQueryCard;
  f_QueryCard.LinkListener(Self);
 end;//aQueryCard <> f_QueryCard
 // Загрузим значения
 if not f_IsQueryNew then
  Load;
 {$ifndef Admin}
 CR := ChangableReq;
 if (CR <> nil) then //Значение по умолчанию для поля "Тема"
  CR.MakeFieldValue;
 {$endif}
 InitFocus;
 if (QueryCard <> nil) then
  QueryCard.CardClear;
//#UC END# *5233051C0075_4683A4A90094_impl*
end;//TqaMgrSearch.CreateTree

function TqaMgrSearch.Save(aIgnoreError: Boolean = False): Boolean;
//#UC START# *5233055D02D2_4683A4A90094_var*
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := true;
  aReq.Save;
 end;
//#UC END# *5233055D02D2_4683A4A90094_var*
begin
//#UC START# *5233055D02D2_4683A4A90094_impl*
 FinishEntering;
 Result := True;
 try
  CheckAttrs;
  {$If not (defined(Monitorings) or defined(Admin))}
  if not aIgnoreError then
   CheckMorpho;
  {$IfEnd} 
 except
  on E: EqaException do
  begin
   Result := False;
   if not aIgnoreError then
   begin
    with E.ErrorControl do
    begin
     with Req.Group do
      if not Expanded then
       Expanded := True;
     Req.SetFocus(E.ErrorControl, True);
    end;//with E.ErrorControl
    raise;
   end;//not aIgnoreError
  end;//on E: EqaException
 end;//try..except
 // При переключении конфигурации запрос мог достаться от карточки 5.х с типом
 // QT_OLD_ATTRIBUTE, поэтому создаем новый запрос
(* if f_Query.GetType = QT_OLD_ATTRIBUTE then
  {$If not defined(Admin)}
  nsQuery.CreateQuery(f_Query, BusinessQueryToAdapterQuery(f_QueryType));
  {$Else}
  Assert(false);
  {$IfEnd}*)
 f_Query.Clear;
 IterateAttrsF(l3L2FA(@DoReq));
//#UC END# *5233055D02D2_4683A4A90094_impl*
end;//TqaMgrSearch.Save

procedure TqaMgrSearch.Load;
//#UC START# *5233057001A7_4683A4A90094_var*
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := true;
  aReq.Load;
 end;

{$ifndef Admin}
var
 CR: IqaReq;
{$endif}
//#UC END# *5233057001A7_4683A4A90094_var*
begin
//#UC START# *5233057001A7_4683A4A90094_impl*
 QueryCard.StartLongOperation;
 try
  IterateAttrsF(l3L2FA(@DoReq));
{$ifndef Admin}
  CR := ChangableReq;
  if (CR <> nil) then //Значение по умолчанию для поля "Тема"
   CR.MakeFieldValue;
{$endif}
  Modified := False;
 finally
  QueryCard.EndLongOperation;
 end;// asLockedPaint;
//#UC END# *5233057001A7_4683A4A90094_impl*
end;//TqaMgrSearch.Load

function TqaMgrSearch.IsSomeFieldFilled(aElseDefaultValue: Boolean): Boolean;
//#UC START# *5233057A0279_4683A4A90094_var*
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := not aReq.IsSet(aElseDefaultValue);
  if not Result then
   IsSomeFieldFilled := true;
 end;
//#UC END# *5233057A0279_4683A4A90094_var*
begin
//#UC START# *5233057A0279_4683A4A90094_impl*
 Result := False;
 IterateAttrsF(l3L2FA(@DoReq));
//#UC END# *5233057A0279_4683A4A90094_impl*
end;//TqaMgrSearch.IsSomeFieldFilled

procedure TqaMgrSearch.ChangeStateAll(aExpand: Boolean);
//#UC START# *523305F8011B_4683A4A90094_var*
var
 l_Index: Integer;
 l_Group: IevQueryGroup;
//#UC END# *523305F8011B_4683A4A90094_var*
begin
//#UC START# *523305F8011B_4683A4A90094_impl*
 for l_Index := 0 to f_QueryCard.GroupCount - 1 do
 begin
  l_Group := f_QueryCard.QueryGroup[l_Index];
  try
   l_Group.Expanded := aExpand;
  finally
   l_Group := nil;
  end;
 end;   
//#UC END# *523305F8011B_4683A4A90094_impl*
end;//TqaMgrSearch.ChangeStateAll

procedure TqaMgrSearch.Check;
//#UC START# *5233060F0343_4683A4A90094_var*
//#UC END# *5233060F0343_4683A4A90094_var*
begin
//#UC START# *5233060F0343_4683A4A90094_impl*
 try
  CheckAttrs;
 except
  on E: EqaException do
   begin
    with E.ErrorControl do
    begin
     with Req.Group do
      if not Expanded then
       Expanded := True;
     Req.SetFocus(E.ErrorControl, True);
    end;
    raise;
   end;
 end;
//#UC END# *5233060F0343_4683A4A90094_impl*
end;//TqaMgrSearch.Check

procedure TqaMgrSearch.DateQuery(const aValue: IqaDateReq);
//#UC START# *5233063202E8_4683A4A90094_var*
var
 l_Req: IqaReq;
 l_DateField: IevEditorCalendarField;
 l_TagName: Il3CString;
 l_DateReq: IqaDateReq;
 l_Holder: IqaDateReqDataHolder;
//#UC END# *5233063202E8_4683A4A90094_var*
begin
//#UC START# *5233063202E8_4683A4A90094_impl*
 if Assigned(f_OnDateQuery) and Supports(aValue, IqaReq, l_Req) then
 begin
  l_TagName := l_Req.TagName;
  //Заплатка: после откатки поле может содержать старую дату.
  l_Req.EditorReq.FirstField.CheckDataText;
  if Supports(l_Req.EditorReq.FirstField, IevEditorCalendarField, l_DateField) then
   l_DateField.GetOtherField.CheckDataText;
  //--Заплатка
  l_Req := nil;
  l_Holder := TqaDateReqDataHolder.Make(aValue);
  f_OnDateQuery(l_Holder);
  if l_Holder.IsOk then
  begin
   l_Req := FindAttr(l_TagName);
   if Supports(l_Req, IqaDateReq, l_DateReq) then
   begin
    l_DateReq.StartDate := l_Holder.StartDate;
    l_DateReq.EndDate := l_Holder.EndDate;
    with l_Req.EditorReq do
     if l_Holder.IsStartDateEmpty and Supports(FirstField, IevEditorCalendarField, l_DateField) then
      SetFocus(l_DateField.GetOtherField)
     else
      SetFocus(l_DateField);
   end;
  end;
 end;
//#UC END# *5233063202E8_4683A4A90094_impl*
end;//TqaMgrSearch.DateQuery

procedure TqaMgrSearch.ModifiedChanged(aValue: Boolean);
//#UC START# *523306640146_4683A4A90094_var*
//#UC END# *523306640146_4683A4A90094_var*
begin
//#UC START# *523306640146_4683A4A90094_impl*
 if aValue then
  Inc(f_Modified)
 else
  Dec(f_Modified);  
 CallModifiedChanged;
//#UC END# *523306640146_4683A4A90094_impl*
end;//TqaMgrSearch.ModifiedChanged

procedure TqaMgrSearch.ExecQuery;
//#UC START# *523307F40383_4683A4A90094_var*
//#UC END# *523307F40383_4683A4A90094_var*
begin
//#UC START# *523307F40383_4683A4A90094_impl*
 if Assigned(f_OnNeedExecQuery) then
  f_OnNeedExecQuery(Self);
//#UC END# *523307F40383_4683A4A90094_impl*
end;//TqaMgrSearch.ExecQuery

function TqaMgrSearch.FindAttr(const aTagName: Il3CString): IqaReq;
 {* Возвращает атрибут по имени }
//#UC START# *5233084202DD_4683A4A90094_var*
 function DoReq(const aReq: IqaReq): Boolean;
 begin
  Result := not l3Same(aReq.TagName, aTagName, true);
  if not Result then
   FindAttr := aReq;
 end;
//#UC END# *5233084202DD_4683A4A90094_var*
begin
//#UC START# *5233084202DD_4683A4A90094_impl*
 Result := nil;
 IterateAttrsF(l3L2FA(@DoReq));
//#UC END# *5233084202DD_4683A4A90094_impl*
end;//TqaMgrSearch.FindAttr

function TqaMgrSearch.GettingFromView: Boolean;
//#UC START# *5233086001AF_4683A4A90094_var*
//#UC END# *5233086001AF_4683A4A90094_var*
begin
//#UC START# *5233086001AF_4683A4A90094_impl*
 Result := (f_GettingAttributesFromView > 0);
//#UC END# *5233086001AF_4683A4A90094_impl*
end;//TqaMgrSearch.GettingFromView

procedure TqaMgrSearch.StartGettingFromView;
//#UC START# *523308730027_4683A4A90094_var*
//#UC END# *523308730027_4683A4A90094_var*
begin
//#UC START# *523308730027_4683A4A90094_impl*
 Inc(f_GettingAttributesFromView);
 QueryCard.StartLongOperation;
//#UC END# *523308730027_4683A4A90094_impl*
end;//TqaMgrSearch.StartGettingFromView

procedure TqaMgrSearch.FinishGettingFromView;
//#UC START# *5233087C020F_4683A4A90094_var*
//#UC END# *5233087C020F_4683A4A90094_var*
begin
//#UC START# *5233087C020F_4683A4A90094_impl*
 QueryCard.EndLongOperation;
 Dec(f_GettingAttributesFromView);
//#UC END# *5233087C020F_4683A4A90094_impl*
end;//TqaMgrSearch.FinishGettingFromView

procedure TqaMgrSearch.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4683A4A90094_var*
//#UC END# *479731C50290_4683A4A90094_var*
begin
//#UC START# *479731C50290_4683A4A90094_impl*
 f_FirstErrorContextReq := nil;
 f_FormName := nil;
 {$If not Defined(Admin) AND not Defined(Monitorings)}
 f_ContextHistory := nil;
 {$IfEnd}
 if (f_QueryCard <> nil) then
  f_QueryCard.ReleaseListeners;
 f_QueryCard := nil;
 f_Query := nil;
 inherited;
//#UC END# *479731C50290_4683A4A90094_impl*
end;//TqaMgrSearch.Cleanup

procedure TqaMgrSearch.ClearFields;
begin
 QueryCard := nil;
 Query := nil;
 inherited;
end;//TqaMgrSearch.ClearFields

procedure TqaMgrSearchForNewsLine.DoFocusStartField;
//#UC START# *54F590B7028F_54F59C4D00FF_var*
var
 l_Req: IqaReq;
//#UC END# *54F590B7028F_54F59C4D00FF_var*
begin
//#UC START# *54F590B7028F_54F59C4D00FF_impl*
 l_Req := FindAttr(nsCStr(cChangableReqName));
 if (l_Req <> nil) then
  l_Req.EditorReq.FirstField.SetFocus;
//#UC END# *54F590B7028F_54F59C4D00FF_impl*
end;//TqaMgrSearchForNewsLine.DoFocusStartField

{$Include w:\common\components\gui\Garant\AFW\implementation\afwApplicationDataUpdate.imp.pas}

function TqaHistory.Get_Query: IQuery;
//#UC START# *468396BC0323_4683A6A4010Cget_var*
//#UC END# *468396BC0323_4683A6A4010Cget_var*
begin
//#UC START# *468396BC0323_4683A6A4010Cget_impl*
 Result := f_Query;
//#UC END# *468396BC0323_4683A6A4010Cget_impl*
end;//TqaHistory.Get_Query

procedure TqaHistory.Set_Query(const aValue: IQuery);
//#UC START# *468396BC0323_4683A6A4010Cset_var*
//#UC END# *468396BC0323_4683A6A4010Cset_var*
begin
//#UC START# *468396BC0323_4683A6A4010Cset_impl*
 if f_Query <> nil then
  f_Query := nil;
 f_Query := aValue;
//#UC END# *468396BC0323_4683A6A4010Cset_impl*
end;//TqaHistory.Set_Query

function TqaHistory.Get_Filter: INode;
//#UC START# *468397930156_4683A6A4010Cget_var*
//#UC END# *468397930156_4683A6A4010Cget_var*
begin
//#UC START# *468397930156_4683A6A4010Cget_impl*
 Result := f_Filter;
//#UC END# *468397930156_4683A6A4010Cget_impl*
end;//TqaHistory.Get_Filter

procedure TqaHistory.Set_Filter(const aValue: INode);
//#UC START# *468397930156_4683A6A4010Cset_var*
//#UC END# *468397930156_4683A6A4010Cset_var*
begin
//#UC START# *468397930156_4683A6A4010Cset_impl*
 f_Filter := aValue;
//#UC END# *468397930156_4683A6A4010Cset_impl*
end;//TqaHistory.Set_Filter

function TqaHistory.Get_DataReset: Boolean;
//#UC START# *5233097E0328_4683A6A4010Cget_var*
//#UC END# *5233097E0328_4683A6A4010Cget_var*
begin
//#UC START# *5233097E0328_4683A6A4010Cget_impl*
 Result := f_DataReset;
//#UC END# *5233097E0328_4683A6A4010Cget_impl*
end;//TqaHistory.Get_DataReset

function TqaHistory.Get_ConsultationSended: Boolean;
//#UC START# *5233098B027F_4683A6A4010Cget_var*
//#UC END# *5233098B027F_4683A6A4010Cget_var*
begin
//#UC START# *5233098B027F_4683A6A4010Cget_impl*
 Result := f_ConsultationSened;
//#UC END# *5233098B027F_4683A6A4010Cget_impl*
end;//TqaHistory.Get_ConsultationSended

procedure TqaHistory.Set_ConsultationSended(aValue: Boolean);
//#UC START# *5233098B027F_4683A6A4010Cset_var*
//#UC END# *5233098B027F_4683A6A4010Cset_var*
begin
//#UC START# *5233098B027F_4683A6A4010Cset_impl*
 f_ConsultationSened := aValue;
//#UC END# *5233098B027F_4683A6A4010Cset_impl*
end;//TqaHistory.Set_ConsultationSended

procedure TqaHistory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4683A6A4010C_var*
//#UC END# *479731C50290_4683A6A4010C_var*
begin
//#UC START# *479731C50290_4683A6A4010C_impl*
 f_Filter := nil;
 f_Query := nil;
 f_DataReset := False;
 f_ConsultationSened := False;
 inherited;
//#UC END# *479731C50290_4683A6A4010C_impl*
end;//TqaHistory.Cleanup

procedure TqaHistory.FinishDataUpdate;
//#UC START# *47EA4E9002C6_4683A6A4010C_var*
//#UC END# *47EA4E9002C6_4683A6A4010C_var*
begin
//#UC START# *47EA4E9002C6_4683A6A4010C_impl*
 inherited;
 f_DataReset := True;
//#UC END# *47EA4E9002C6_4683A6A4010C_impl*
end;//TqaHistory.FinishDataUpdate
{$IfEnd} // NOT Defined(Admin)

end.
