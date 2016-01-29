unit nevContainers;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/nevContainers.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::Everest::nevContainers
//
// Различные контейнеры для хранения интерфейсов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3PureMixIns
  ;

type
 InevFlatSubsList = interface(IUnknown)
  {* Плоский контейнер. а-ля Il3InterfacedList }
   ['{0288488A-FBEB-4E1D-AA0C-3B2E1F3DA447}']
  // Ml3List
   function pm_GetEmpty: Boolean;
   function pm_GetFirst: IevSub;
   function pm_GetLast: IevSub;
   function pm_GetItems(anIndex: Integer): IevSub;
   property Empty: Boolean
     read pm_GetEmpty;
   property First: IevSub
     read pm_GetFirst;
     {* Первый элемент. }
   property Last: IevSub
     read pm_GetLast;
     {* Последний элемент. }
   property Items[anIndex: Integer]: IevSub
     read pm_GetItems;
     default;
  // Ml3CountHolder
   function pm_GetCount: Integer;
   property Count: Integer
     read pm_GetCount;
     {* Число элементов. }
 end;//InevFlatSubsList

implementation

end.