unit ComplectUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ComplectUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Complect
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	IOUnit
	, BaseTypesUnit
	, DynamicTreeUnit
	, SearchDefinesUnit
	//#UC START# *4423F94903C8_45744F4302BF_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_45744F4302BF_UNIT_FOR_Stream*
	;

type

IComplectInfoNode = interface;
{ - предварительное описание IComplectInfoNode. }

IVisualRepresentationList = interface;
{ - предварительное описание IVisualRepresentationList. }

IComplectInfo = interface;
{ - предварительное описание IComplectInfo. }


PComplectType = ^TComplectType;
TComplectType = (
	CT_INTERNAL
	, CT_LOCAL
	, CT_NET_ONE_USER
	, CT_NET_MANY_USERS
);

PVisualRepresentation = ^TVisualRepresentation;
TVisualRepresentation = packed record
	rName: IString;
	rPercent: AnsiChar;
end;

// Нода информации о комплекте
IComplectInfoNode = interface (INodeBase) ['{3D963480-C844-4A4A-AE68-6B68A125864D}']
	procedure GetInfo (out aRet {: IString}); stdcall;
end;

IVisualRepresentationList = interface(IInterface)
['{5484F035-B2FB-40F3-B535-86F177C5A275}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: TVisualRepresentation); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TVisualRepresentation); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TVisualRepresentation): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TVisualRepresentation); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IVisualRepresentationList

// Интерфейс получение информации о текущем комплекте баз.
IComplectInfo = interface (IInterface) ['{0B0F9913-DE64-41E4-A884-68D60D6829AE}']
	function DontUseMe: Pointer;
	procedure GetDealerInfo (out aRet {: IString}); stdcall;

	procedure GetVisualRepresentationData (
		out aRet {: IVisualRepresentationList}
	); stdcall;

	procedure GetInfo  (out aRet {: INodeBase}); stdcall;

	procedure GetOldBaseWarning (out aRet {: IString}); stdcall;

	procedure GetOwner  (out aRet {: IString}); stdcall;

	function GetType (): TComplectType; stdcall;

	procedure GetUnexistDocMessage (out aRet {: IString}); stdcall;
end;

implementation
end.