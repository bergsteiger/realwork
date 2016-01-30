unit UnderControlUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\UnderControlUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

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
  procedure fire;
   {* сообщает о том что контролируемые объекты изменились. }
 end;//IControlledChangeNotifier

 IControllable = interface
  {* Интерфейс, который должна реализовывать сущность которую можно ставить "на контроль". Реализация должны быть выполнена, так что бы доступ к методам определяемым этим интерфейсам не приводила к загрузки данных самой сущности. Для функционирования всех мотодов достаточно знать лишь идентификатор сущности на сервере, с помощью которого осуществляется вся работа с серверным интерфейсом ControlManager. }
  ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
  function Get_controlled: Boolean;
  procedure Set_controlled(aValue: Boolean);
  function Get_short_name: IString;
  function Get_can_set_to_control: Boolean;
  function Get_name: IString;
  function Get_type: TControlledItemType;
  function get_control_status: Cardinal;
   {* Возврящает текущее значение статуса изменений. }
  procedure reset_control_status;
   {* Сбрасывает статус изменений в ноль. }
  function open: IUnknown;
   {* Получить объект на контроле. }
  function is_same_controllable(const other: IControllable {* Сравниваемый объект на контроле. }): Boolean;
   {* Сравнение объектов на контроле. }
  property controlled: Boolean
   read Get_controlled
   write Set_controlled;
   {* свойство определяющее, что данная сущность находится на контроле. Установка свойства в true приводит к добавлению сущности на контроль, в false соответственно к снятию. }
  property short_name: IString
   read Get_short_name;
   {* Название объекта на контроле. }
  property can_set_to_control: Boolean
   read Get_can_set_to_control;
   {* Возвращает true, если разрешена постановка на контроль }
  property name: IString
   read Get_name;
  property type: TControlledItemType
   read Get_type;
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
  procedure Set_controlled_change_notifier(const aValue: IControlledChangeNotifier);
  function Get_changed_doc: ICatalogBase;
  procedure update_status(force: Boolean = False);
   {* Обновить статусы объектов на контроле. }
  function get_under_control_status(pid;
   var status: Cardinal): Boolean;
  procedure add(pid);
  procedure remove(pid);
  procedure reset_control_status(pid);
  procedure refresh_control_status;
  procedure do_update_status;
  function get_controlled_objects: IControlledObjects;
  property controlled_change_notifier: IControlledChangeNotifier
   write Set_controlled_change_notifier;
  property changed_doc: ICatalogBase
   read Get_changed_doc;
 end;//IControlManager

class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IControlManager;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
