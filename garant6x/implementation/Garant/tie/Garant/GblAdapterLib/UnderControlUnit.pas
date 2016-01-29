unit UnderControlUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/UnderControlUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  IOUnit,
  DynamicTreeUnit
  ;

type
 TControlledItemType = (
  {* Типы объектов на контроле. }
   CIT_DOCUMENT // Документ
 , CIT_LIST // Список.
 , CIT_QUERY // Запрос.
 );//TControlledItemType

const
  { Битовые значения статуса изменений. }
 CS_DELETED : Cardinal = 32;
  { Документ удален. }
 CS_ACTIVE : Cardinal = 16;
  { Документ вступил в действие }
 CS_CHANGED : Cardinal = 8;
  { Документ изменен }
 CS_ABOLISHED : Cardinal = 4;
  { Документ утратил силу }
 CS_REGISTERED : Cardinal = 2;
  { Документ зарегистрирован в Минюсте РФ }
 CS_NOT_REGISTERED : Cardinal = 1;
  { Документу отказано в регистрации в Минюсте РФ }
 CS_NONE : Cardinal = 0;
  { Документ не изменился }

type
 IControlledChangeNotifier = interface(IUnknown)
  {* Интерфейс который должен быть реализован со стороны оболочки, для нотификации ее об изменении контролируемых объектов. }
   ['{939DF9FC-3E7C-4092-8B2B-307737F2583B}']
   procedure Fire; stdcall;
     {* сообщает о том что контролируемые объекты изменились. }
 end;//IControlledChangeNotifier

 IControllable = interface(IUnknown)
  {* Интерфейс, который должна реализовывать сущность которую можно ставить "на контроль". Реализация должны быть выполнена, так что бы доступ к методам определяемым этим интерфейсам не приводила к загрузки данных самой сущности. Для функционирования всех мотодов достаточно знать лишь идентификатор сущности на сервере, с помощью которого осуществляется вся работа с серверным интерфейсом ControlManager. }
   ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
   function GetControlled: ByteBool; stdcall;
   procedure SetControlled(aValue: Boolean); stdcall;
   function GetShortName: IString; stdcall;
   function GetCanSetToControl: ByteBool; stdcall;
   function GetName: IString; stdcall;
   function GetType: TControlledItemType; stdcall;
   function GetControlStatus: Cardinal; stdcall;
     {* Возврящает текущее значение статуса изменений. }
   procedure ResetControlStatus; stdcall;
     {* Сбрасывает статус изменений в ноль. }
   procedure Open(out aRet {: IUnknown}); stdcall;
     {* Получить объект на контроле. }
   function IsSameControllable(const aOther: IControllable
    {* Сравниваемый объект на контроле.}): ByteBool; stdcall;
     {* Сравнение объектов на контроле. }
   property controlled: ByteBool
     read GetControlled
     write SetControlled;
     {* свойство определяющее, что данная сущность находится на контроле. Установка свойства в true приводит к добавлению сущности на контроль, в false соответственно к снятию. }
   property short_name: IString
     read GetShortName;
     {* Название объекта на контроле. }
   property can_set_to_control: ByteBool
     read GetCanSetToControl;
     {* Возвращает true, если разрешена постановка на контроль }
   property name: IString
     read GetName;
   property type: TControlledItemType
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

 IControlManager = interface(IUnknown)
  {* Менеджер объектов на контроле. }
   ['{5EB9D0A5-C7D0-4E98-85D3-4438B5E98AAB}']
   procedure SetControlledChangeNotifier(const aValue: IControlledChangeNotifier); stdcall;
   function GetChangedDoc: ICatalogBase; stdcall;
   procedure UpdateStatus(aForce: Boolean = false); stdcall;
     {* Обновить статусы объектов на контроле. }
   function GetUnderControlStatus(aPid;
    var aStatus: Cardinal): ByteBool; stdcall;
   procedure Add(aPid); stdcall;
   procedure Remove(aPid); stdcall;
   procedure ResetControlStatus(aPid); stdcall;
   procedure RefreshControlStatus; stdcall;
   procedure DoUpdateStatus; stdcall;
   procedure GetControlledObjects(out aRet {: IControlledObjects}); stdcall;
   property controlled_change_notifier: IControlledChangeNotifier
     write SetControlledChangeNotifier;
   property changed_doc: ICatalogBase
     read GetChangedDoc;
 end;//IControlManager

implementation

end.