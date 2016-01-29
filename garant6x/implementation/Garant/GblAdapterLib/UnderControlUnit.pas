unit UnderControlUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/UnderControlUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::UnderControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, DynamicTreeUnit
	//#UC START# *4423F94903C8_45EEAA800226_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45EEAA800226_UNIT_FOR_Stream*
	;

type

IControlledObjects = interface;
{ - предварительное описание IControlledObjects. }

IControlManager = interface;
{ - предварительное описание IControlManager. }


// Типы объектов на контроле.
PControlledItemType = ^TControlledItemType;
TControlledItemType = (
	CIT_DOCUMENT // Документ
	, CIT_LIST // Список.
	, CIT_QUERY // Запрос.
);

// Интерфейс который должен быть реализован со стороны оболочки, для нотификации ее об изменении
// контролируемых объектов.
IControlledChangeNotifier = interface (IInterface) ['{939DF9FC-3E7C-4092-8B2B-307737F2583B}']
	// сообщает о том что контролируемые объекты изменились.
	procedure Fire (); stdcall;
end;

// Интерфейс, который должна реализовывать сущность которую можно ставить "на контроль". Реализация
// должны быть выполнена, так что бы доступ к методам определяемым этим интерфейсам не приводила к
// загрузки данных самой сущности. Для функционирования всех мотодов достаточно знать лишь
// идентификатор сущности на сервере, с помощью которого осуществляется вся работа с серверным
// интерфейсом ControlManager.
IControllable = interface (IInterface) ['{1E74D154-2B48-4F83-A502-B39E3CA72118}']
	function DontUseMe: Pointer;
	// Возвращает true, если разрешена постановка на контроль
	function GetCanSetToControl (): Bytebool; stdcall;

	// свойство определяющее, что данная сущность находится на контроле. Установка свойства в true
	// приводит к добавлению сущности на контроль, в false соответственно к снятию.
	function GetControlled (): Bytebool; stdcall;
	procedure SetControlled (aControlled: Bytebool); stdcall;

	// Возврящает текущее значение статуса изменений.
	function GetControlStatus (): Longword; stdcall;

	// Сравнение объектов на контроле.
	function IsSameControllable (
		const aOther: IControllable
	): Bytebool; stdcall;

	procedure GetName (out aRet {: IString}); stdcall;

	// Получить объект на контроле.
	procedure Open (
		out aRet {: IUnknown}
	); stdcall;

	// Сбрасывает статус изменений в ноль.
	procedure ResetControlStatus (); stdcall;

	// Название объекта на контроле.
	procedure GetShortName (out aRet {: IString}); stdcall;

	function GetType (): TControlledItemType; stdcall;
end;

// Объект не на контроле.
ENotUnderControl = class (Exception);

// Объект уже на контроле.
EAlreadyControlled = class (Exception);

IControlledObjects = interface(IInterface)
['{9AF178A2-7F24-4517-ACFF-5DD0EBB850D4}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы для доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удаляет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: IControllable); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IControllable); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IControllable): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IControllable); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IControlledObjects

// Менеджер объектов на контроле.
IControlManager = interface (IInterface) ['{5EB9D0A5-C7D0-4E98-85D3-4438B5E98AAB}']
	function DontUseMe: Pointer;
	procedure GetChangedDoc (out aRet {: ICatalogBase}); stdcall;


	procedure SetControlledChangeNotifier (const aControlledChangeNotifier: IControlledChangeNotifier); stdcall;

	procedure GetControlledObjects (
		out aRet {: IControlledObjects}
	); stdcall;

	// Обновить статусы объектов на контроле.
	procedure UpdateStatus (
		aForce: Bytebool = false
	); stdcall;
end;

const

 { Битовые значения статуса изменений. }
	CS_DELETED = Longword(32);
 { Документ удален. }
	CS_ACTIVE = Longword(16);
 { Документ вступил в действие }
	CS_CHANGED = Longword(8);
 { Документ изменен }
	CS_ABOLISHED = Longword(4);
 { Документ утратил силу }
	CS_REGISTERED = Longword(2);
 { Документ зарегистрирован в Минюсте РФ }
	CS_NOT_REGISTERED = Longword(1);
 { Документу отказано в регистрации в Минюсте РФ }
	CS_NONE = Longword(0);
 { Документ не изменился }

implementation
end.