unit NewInterfacesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "BasicTests"
// Модуль: "w:/MDProcess/TestModel/BasicTests/NewInterfacesUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> TestModel::BasicTests::NewInterfaces
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

IBaseInterface = interface;
{ - предварительное описание IBaseInterface. }

IMySyperData = interface;
{ - предварительное описание IMySyperData. }

IDerivedInterface = interface;
{ - предварительное описание IDerivedInterface. }


INewFacet = interface (IInterface) ['{2CFA8895-40F1-4601-B8E9-52147ADB59DC}']
	function DontUseMe: Pointer;

end;

PNewStruct = ^TNewStruct;
TNewStruct = packed record
	rNewAttribute: Longint;
end;

IBaseInterface = interface (IInterface) ['{268B0A46-3C2C-4279-9154-EE5F93F50CD1}']
	function DontUseMe: Pointer;
	function GetAgrLongP (): Longint; stdcall;
	procedure SetAgrLongP (aAgrLongP: Longint); stdcall;

	procedure GetAgrStructP (out a: TNewStruct); stdcall;
	procedure SetAgrStructP (const aAgrStructP: TNewStruct); stdcall;

	function GetLnkLongP (): Longint; stdcall;
	procedure SetLnkLongP (aLnkLongP: Longint); stdcall;

	procedure GetLnkStructP (out a: TNewStruct); stdcall;
	procedure SetLnkStructP (const aLnkStructP: TNewStruct); stdcall;
end;

IMySyperData = interface(IInterface)
['{535DCDCC-E3CD-4921-AE63-3E65F3AE5DA0}']
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
    function  pm_GetItem(anIndex: Integer): Int64; stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: Int64); stdcall;
      {-}
  // public methods
    function  Add(const anItem: Int64): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: Int64); stdcall;
      {* - вставляет элемент Item по индексу Index. }
  // public properties
    property  Items[anIndex: Integer]: Int64
      read pm_GetItem
      write pm_SetItem;
      default;
      {* - элементы списка. }
end;//IMySyperData

IDerivedInterface = interface (IBaseInterface) ['{19342E98-DAAF-4338-806F-19FA17807BD7}']
	procedure MyFunc (
		const aA: IMySyperData
	); stdcall;
end;

implementation
end.