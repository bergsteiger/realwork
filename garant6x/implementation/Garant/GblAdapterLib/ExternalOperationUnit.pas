unit ExternalOperationUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ExternalOperationUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	, BaseTreeSupportUnit
	;

type

IExternalOperation = interface;
{ - предварительное описание IExternalOperation. }



// Ссылки на операции
IExternalOperation = interface (IInterface) ['{71ECDD4A-0455-4800-BD55-7ECB739949A7}']
	function DontUseMe: Pointer;
	function GetId (): TObjectId; stdcall;
end;

const

 { ExternalOperationId }
	EOI_ESTIMATION = Longword(1);
 { Оценить ответ }
	EOI_PAYMENT_CONFIRM = Longword(2);
 { Подтверждение оплаты }
	EOI_PAYMENT_REFUSAL = Longword(3);
 { Оплата отклонена }
	EOI_OPEN_ATTRIBUTE_CARD = Longword(4);
	EOI_SHOW_HELP_TOPIC = Longword(5);
	EOI_CHANGE_COLLAPSED = Longword(6);
	EOI_CHECK_LEGAL_ADVISE_AVAILABLE = Longword(7);
	EOI_CONSULTATION_CALL_GARANT = Longword(8);
 { Ссылка на www.garant.ru в уведомлении о консалтинге }
	EOI_SHOW_CONSULTATION_LIST = Longword(9);
 { показать список к консультации }
	EOI_SHOW_LC_HELP = Longword(10);
 { Ссылка на Справка-описание Правового календаря }
	EOI_CHANGES_INSIDE_TABLE = Longword(11);

implementation
end.