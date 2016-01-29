unit ContextSearchSupportUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ContextSearchSupportUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ContextSearchSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface



type

IHighlightPositionList = interface;
{ - предварительное описание IHighlightPositionList. }


// Позиции для подсветки найденных слов.
PHighlightPosition = ^THighlightPosition;
THighlightPosition = packed record
	rStart: Longword; // начало выделения
	rFinish: Longword; // конец выделения
end;

// Результат поиска по контексту.
PContextSearchResult = ^TContextSearchResult;
TContextSearchResult = packed record
	rItemIndex: Longword; // Индекс найденного элемента.
	rPositions: IHighlightPositionList; // позиции, найденные в результате поиска
end;

// Зона поиска.
PSearchStatus = ^TSearchStatus;
TSearchStatus = (
	SS_GLOBAL // Поиск по всему объекту.
	, SS_CURENT // Поиск от текущего элемента.
);

// Направление поиска.
PSearchDirection = ^TSearchDirection;
TSearchDirection = (
	SD_UP // Поис вверх.
	, SD_DOWN // Поиск вниз.
);

// Перечислимый тип, определяющий способ поиска в линейных структурах (списках, текстах и т.п.).
// Сочетание ss_Global + sd_Up - поиск с конца вверх.
// Сочетание ss_Global + sd_Down - поиск сначала вниз.
// Сочетание c ss_Current - поиск от текущего элемента вверх или вниз.
PSearchMode = ^TSearchMode;
TSearchMode = packed record
	rStatus: TSearchStatus; // результат поиска
	rDirection: TSearchDirection; // направление поиска
end;

IHighlightPositionList = interface(IInterface)
['{0311883B-7352-4AA9-8B38-B853D9B37FF8}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: THighlightPosition); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: THighlightPosition); stdcall;
      {-}
  // public methods
    function  Add(const anItem: THighlightPosition): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: THighlightPosition); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IHighlightPositionList

implementation
end.