unit UnderControlUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UnderControlUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "UnderControl" MUID: (45EEAA800226)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , DynamicTreeUnit
;

const
 {* Битовые значения статуса изменений. }
 CS_DELETED: Cardinal = 32;
  {* Документ удален. }
 CS_ACTIVE: Cardinal = 16;
  {* Документ вступил в действие }
 CS_CHANGED: Cardinal = 8;
  {* Документ изменен }
 CS_ABOLISHED: Cardinal = 4;
  {* Документ утратил силу }
 CS_REGISTERED: Cardinal = 2;
  {* Документ зарегистрирован в Минюсте РФ }
 CS_NOT_REGISTERED: Cardinal = 1;
  {* Документу отказано в регистрации в Минюсте РФ }
 CS_NONE: Cardinal = 0;
  {* Документ не изменился }

type
 TControlledItemType = (
  {* Типы объектов на контроле. }
  CIT_DOCUMENT
   {* Документ }
  , CIT_LIST
   {* Список. }
  , CIT_QUERY
   {* Запрос. }
 );//TControlledItemType

 IControlledChangeNotifier = interface
  {* Интерфейс который должен быть реализован со стороны оболочки, для нотификации ее об изменении контролируемых объектов. }
  ['{939DF9FC-3E7C-4092-8B2B-307737F2583B}']
  procedure Fire; stdcall;
   {* сообщает о том что контролируемые объекты изменились. }
 end;//IControlledChangeNotifier

 IControllable = interface
  {* Интерфейс, который должна реализовывать сущность которую можно ставить "на контроль". Реализация должны быть выполнена, так что бы доступ к методам определяемым этим интерфейсам не приводила к загрузки данных самой сущности. Для функционирования всех мотодов достаточно знать лишь идентификатор сущности на сервере, с помощью которого осуществляется вся работа с серверным интерфейсом ControlManager. }
  ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
  function GetControlled: ByteBool; stdcall;
  procedure SetControlled(const aValue: ByteBool); stdcall;
  procedure GetShortName; stdcall;
  function GetCanSetToControl: ByteBool; stdcall;
  procedure GetName; stdcall;
  function GetType: TControlledItemType; stdcall;
  function GetControlStatus: Cardinal; stdcall;
   {* Возврящает текущее значение статуса изменений. }
  procedure ResetControlStatus; stdcall;
   {* Сбрасывает статус изменений в ноль. }
  procedure Open(out aRet
   {* IUnknown }); stdcall;
   {* Получить объект на контроле. }
  function IsSameControllable(const other: IControllable
   {* Сравниваемый объект на контроле. }): ByteBool; stdcall;
   {* Сравнение объектов на контроле. }
  property Controlled: ByteBool
   read GetControlled
   write SetControlled;
   {* свойство определяющее, что данная сущность находится на контроле. Установка свойства в true приводит к добавлению сущности на контроль, в false соответственно к снятию. }
  property ShortName: 
   read GetShortName;
   {* Название объекта на контроле. }
  property CanSetToControl: ByteBool
   read GetCanSetToControl;
   {* Возвращает true, если разрешена постановка на контроль }
  property Name: 
   read GetName;
  property Type: TControlledItemType
   read GetType;
 end;//IControllable

 IControlledObjects = array of IControllable;
  {* Список объектов папок, стоящих на контроле. }

 NotUnderControl = class
  {* Объект не на контроле. }
 end;//NotUnderControl

 AlreadyControlled = class
  {* Объект уже на контроле. }
 end;//AlreadyControlled

 IControlManager = interface
  {* Менеджер объектов на контроле. }
  ['{5EB9D0A5-C7D0-4E98-85D3-4438B5E98AAB}']
  procedure SetControlledChangeNotifier(const aValue); stdcall;
  procedure GetChangedDoc; stdcall;
  procedure UpdateStatus(force: Boolean = False); stdcall;
   {* Обновить статусы объектов на контроле. }
  function GetUnderControlStatus(const pid;
   var status: Cardinal): ByteBool; stdcall;
  procedure Add(const pid); stdcall;
  procedure Remove(const pid); stdcall;
  procedure ResetControlStatus(const pid); stdcall;
  procedure RefreshControlStatus; stdcall;
  procedure DoUpdateStatus; stdcall;
  procedure GetControlledObjects(out aRet
   {* IControlledObjects }); stdcall;
  property ControlledChangeNotifier: 
   write SetControlledChangeNotifier;
  property ChangedDoc: 
   read GetChangedDoc;
 end;//IControlManager

implementation

uses
 l3ImplUses
;

end.
