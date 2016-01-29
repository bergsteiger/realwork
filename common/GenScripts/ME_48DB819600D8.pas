unit evControlGroup;

interface

uses
 l3IntfUses
 , evCustomControlTool
 , evQueryCardInt
 , evReqList
 , evDescriptionReqList
 , nevTools
 , l3Interfaces
 , evdTypes
 , nevBase
;

type
 TevControlGroup = class(TevCustomControlTool, IevCustomEditorControl, IevQueryGroup)
  {* Группа реквизитов (блок параграфов) }
  function Make(const aValue: InevPara;
   const aQueryAdapter: IevQueryCard): IevQueryGroup;
  procedure Create(const aValue: InevPara;
   const aQueryAdapter: IevQueryCard);
  function IsMultiline: Boolean;
   {* Контрол содержит несколько строк и поддерживает перемещение по ним 
          с помощью стрелок (к меткам это не относится). }
  function GetControlIterator: IevControlIterator;
   {* Интерфейс "навигатора" по контролам. }
  procedure InitBoolProperty(aIdent: Integer;
   aValue: Boolean);
   {* Для установки начальных значений (не используется передача данных для 
         процессора операций). }
  procedure UpperChange;
   {* Обработчик изменения состояния кнопок. }
  function ControlName: Tl3WString;
   {* Имя контрола (тег - k2_tiName). }
  function ControlType: TevControlType;
   {* Тип контрола. }
  function Visible: Boolean;
   {* Видимость контрола. }
  function Upper: Boolean;
   {* Состояние для Flat-кнопки. }
  procedure ClickOnDisabledLabel;
  procedure AfterCollapsed;
   {* Обработчик события сворачивания группы. }
  function CanCollapsed: Boolean;
   {* Проверка может ли группа свернуться. }
  function LMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   const aMap: InevMap): Boolean;
   {* Обработка нажания на левую кнопку мыши. }
  function LMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState): Boolean;
  function FindDescriptionReq(const aReqName: Tl3WString): IevDescriptionReq;
   {* Возвращает реквизит по имени. }
  procedure InitModel(const aTag: InevPara);
   {* Инициализация модели. }
  function LastReq: IevReq;
   {* Последний реквизт в группе. }
  function FirstReq: IevReq;
   {* Первый реквизит в группе. }
  function GetNextReq(const aReq: IevReq): IevReq;
   {* Возвращает следующий реквизит. }
  function GetPrevReq(const aReq: IevReq): IevReq;
   {* Возвращает предыдущий реквизит. }
  function Req: IevReq;
   {* Список реквизитов, принадлежащих группе. }
  function ReqCount: Integer;
   {* Количество реквизитов в группе. }
  function DescriptionReq: IevDescriptionReq;
   {* Список реквизитов, принадлежащих группе. }
  function DescriptionReqCount: Integer;
   {* Количество реквизитов в группе. }
  function GroupName: Il3CString;
   {* Возвращает имя группы (k2_tiShortName). }
  function Expanded: Boolean;
   {* Возвращает True, если панель развернута, т.е. видны все реквизиты. }
  function QueryCard: IevQueryCard;
 end;//TevControlGroup
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3Types
 , l3Base
 , k2OpMisc
 , l3String
 , evReq
 , evDescriptionReq
 , nevFacade
 , ReqRow_Const
;

end.
