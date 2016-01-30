unit nsQueryInterfaces;
 {* Интерфейсы прецедента Поиск }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsQueryInterfaces.pas"
// Стереотип: "InternalInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , evQueryCardInt
 , l3Interfaces
 , nevBase
 , DynamicTreeUnit
 , SearchUnit
 , BaseTreeSupportUnit
 , FiltersUnit
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 , nevTools
;

type
 IqaReq = interface(IqaReqPrim)
  {* Реквизит. }
  ['{B9BA7D8C-0C61-4A22-9EDC-B70335A54A59}']
  function Get_EditorReq: IevReq;
  function Get_TagCaption: Il3CString;
  function Get_TagName: Il3CString;
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
  property EditorReq: IevReq
   read Get_EditorReq;
   {* Ссылка на внутренний атрибут. }
  property TagCaption: Il3CString
   read Get_TagCaption;
   {* Заголовок атрибута (имя метки перед полем). }
  property TagName: Il3CString
   read Get_TagName;
  property Multi: Boolean
   read Get_Multi;
 end;//IqaReq

 IqaReqAttribute = interface(InevBase)
  ['{C11BAF96-0B89-49D1-A817-4FBAB1703FC3}']
  procedure GetAttributesFromView(const aRoot: INodeBase);
   {* Вычитываем флаги операций из дерева (создаёт поля ввода) и устанавливаем фокус в последнее добавленное поле }
 end;//IqaReqAttribute

 IqaDateReq = interface(InevBase)
  ['{F6258940-B98D-46CD-BCF3-0883F5AD6D75}']
  function Get_StartDate: TDateTime;
  procedure Set_StartDate(aValue: TDateTime);
  function Get_EndDate: TDateTime;
  procedure Set_EndDate(aValue: TDateTime);
  property StartDate: TDateTime
   read Get_StartDate
   write Set_StartDate;
  property EndDate: TDateTime
   read Get_EndDate
   write Set_EndDate;
 end;//IqaDateReq

 IqaDateReqDataHolder = interface
  ['{ED3483B1-9004-4E27-B7E1-8201B5B6ED7E}']
  function Get_StartDate: TDateTime;
  procedure Set_StartDate(aValue: TDateTime);
  function Get_EndDate: TDateTime;
  procedure Set_EndDate(aValue: TDateTime);
  function Get_IsOk: Boolean;
  procedure Set_IsOk(aValue: Boolean);
  function Get_ReqCaption: Il3CString;
  function IsStartDateEmpty: Boolean;
  function IsEndDateEmpty: Boolean;
  property StartDate: TDateTime
   read Get_StartDate
   write Set_StartDate;
  property EndDate: TDateTime
   read Get_EndDate
   write Set_EndDate;
  property IsOk: Boolean
   read Get_IsOk
   write Set_IsOk;
  property ReqCaption: Il3CString
   read Get_ReqCaption;
 end;//IqaDateReqDataHolder

 IqaPhoneReq = interface(InevBase)
  ['{C2D7E151-6854-498E-BD1E-AF69559645B4}']
  function Get_Code: Il3CString;
  procedure Set_Code(const aValue: Il3CString);
  function Get_Number: Il3CString;
  procedure Set_Number(const aValue: Il3CString);
  property Code: Il3CString
   read Get_Code
   write Set_Code;
  property Number: Il3CString
   read Get_Number
   write Set_Number;
 end;//IqaPhoneReq

 TlgQueryType = (
  {* Тип запроса на поиск }
  lg_qtNone
   {* неопределенный тип запроса }
  , lg_qtKeyWord
   {* по ситуации }
  , lg_qtAttribute
   {* по реквизитам (новый) }
  , lg_qtPublishedSource
   {* по источнику опубликования }
  , lg_qtPostingOrder
   {* заказ рассылки }
  , lg_qtLegislationReview
   {* обзор законадательства }
  , lg_qtSendConsultation
   {* запрос на правовую поддержку, при этом поиск не осуществляется, запрос уходит на обработку в компанию Гарант }
  , lg_qtBaseSearch
   {* базовый поиск }
  , lg_qtInpharmSearch
   {* лекарственного препарата }
 );//TlgQueryType

 IqaHistory = interface(InevBase)
  {* интерфейс создан для сохранения TasMgrSearch в истории. }
  ['{03B3AFE7-3939-4277-8A11-B6DE67F81E57}']
  function Get_Query: IQuery;
  procedure Set_Query(const aValue: IQuery);
  function Get_Filter: INode;
  procedure Set_Filter(const aValue: INode);
  function Get_DataReset: Boolean;
  function Get_ConsultationSended: Boolean;
  procedure Set_ConsultationSended(aValue: Boolean);
  property Query: IQuery
   read Get_Query
   write Set_Query;
  property Filter: INode
   read Get_Filter
   write Set_Filter;
  property DataReset: Boolean
   read Get_DataReset;
  property ConsultationSended: Boolean
   read Get_ConsultationSended
   write Set_ConsultationSended;
 end;//IqaHistory

 InsQueryContainer = interface(InevBase)
  {* Контейнер запроса }
  ['{92581E99-13D7-4C5A-B620-A6B8DE9C471C}']
  function Get_Query: IQuery;
  procedure Set_Query(const aValue: IQuery);
  property Query: IQuery
   read Get_Query
   write Set_Query;
 end;//InsQueryContainer

 (*
 MqaMorphoReq = interface
  procedure FillReqListAsString(const aList: Il3StringsEx);
 end;//MqaMorphoReq
 *)

 TOnDateQuery = procedure(const aValue: IqaDateReqDataHolder) of object;

 InsQueryFormState = interface(InsQueryContainer)
  ['{641BDCBA-CAB1-4F91-BC99-64E5DAC1CAD4}']
  function Get_Tag: Il3CString;
  procedure Set_Tag(const aValue: Il3CString);
  function Get_Filter: IFilterFromQuery;
  procedure Set_Filter(const aValue: IFilterFromQuery);
  property Tag: Il3CString
   read Get_Tag
   write Set_Tag;
  property Filter: IFilterFromQuery
   read Get_Filter
   write Set_Filter;
 end;//InsQueryFormState

 EqaException = class(Exception)
  private
   f_ErrorControl: IevEditorControlField;
    {* Поле для свойства ErrorControl }
  protected
  public
   constructor Create(const anErrorControl: IevEditorControlField;
    const Msg: AnsiString); reintroduce;
   constructor CreateFmt(const anErrorControl: IevEditorControlField;
    const Msg: AnsiString;
    const Args: array of const); reintroduce;
   destructor Destroy; override;
  public
   property ErrorControl: IevEditorControlField
    read f_ErrorControl;
 end;//EqaException

 EqaRequiredValue = class(EqaException)
  {* Не задан обязательный реквизит }
 end;//EqaRequiredValue

 EqaDuplicateValue = class(EqaException)
  {* Дублирующееся значение ревизита }
 end;//EqaDuplicateValue

 EqaInvalidValue = class(EqaException)
  {* Неверное значение реквизита }
 end;//EqaInvalidValue

 EqaSilentAbort = class(EqaException)
 end;//EqaSilentAbort

 EaqExceptionClass = class of EqaException;

 IqaMgrSearch = interface(InevBase)
  ['{9FE88AB2-D21E-42CF-8982-B95BBA19075B}']
  function Get_Query: IQuery;
  procedure Set_Query(const aValue: IQuery);
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
  property Query: IQuery
   read Get_Query
   write Set_Query;
   {* Запрос. }
  property QueryType: TlgQueryType
   read Get_QueryType;
  property IsQueryNew: Boolean
   read Get_IsQueryNew;
   {* Является ли запрос новым, т.е. не загруженным из базы }
  property Modified: Boolean
   read Get_Modified
   write Set_Modified;
   {* Атрибут модифицирован пользователем со времени последнего сохранения }
  property FromHistory: Boolean
   read Get_FromHistory
   write Set_FromHistory;
  property QueryCard: IevQueryCard
   read Get_QueryCard;
   {* Ссылка на контейнер групп и реквизитов }
  {$If NOT Defined(Monitorings)}
  property HistoryValues: IvcmStrings
   read Get_HistoryValues;
  {$IfEnd} // NOT Defined(Monitorings)
 end;//IqaMgrSearch

 IqaMorphoReq = interface(InevBase)
  ['{359454B3-855C-4E1F-BB52-DD2D62B85936}']
  procedure FillReqListAsString(const aList: Il3StringsEx);
 end;//IqaMorphoReq
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

constructor EqaException.Create(const anErrorControl: IevEditorControlField;
 const Msg: AnsiString);
//#UC START# *52330EEE0192_52330CD700F3_var*
//#UC END# *52330EEE0192_52330CD700F3_var*
begin
//#UC START# *52330EEE0192_52330CD700F3_impl*
 inherited Create(Msg);
 f_ErrorControl := anErrorControl;
//#UC END# *52330EEE0192_52330CD700F3_impl*
end;//EqaException.Create

constructor EqaException.CreateFmt(const anErrorControl: IevEditorControlField;
 const Msg: AnsiString;
 const Args: array of const);
//#UC START# *52330F130017_52330CD700F3_var*
//#UC END# *52330F130017_52330CD700F3_var*
begin
//#UC START# *52330F130017_52330CD700F3_impl*
 inherited CreateFmt(Msg, Args);
 f_ErrorControl := anErrorControl;
//#UC END# *52330F130017_52330CD700F3_impl*
end;//EqaException.CreateFmt

destructor EqaException.Destroy;
//#UC START# *48077504027E_52330CD700F3_var*
//#UC END# *48077504027E_52330CD700F3_var*
begin
//#UC START# *48077504027E_52330CD700F3_impl*
 f_ErrorControl := nil;
 inherited;
//#UC END# *48077504027E_52330CD700F3_impl*
end;//EqaException.Destroy
{$IfEnd} // NOT Defined(Admin)

end.
