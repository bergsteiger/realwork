unit NotifyUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/NotifyUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Notify
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	BaseTypesUnit
	;

type

INotification = interface;
{ - предварительное описание INotification. }

INotifyManager = interface;
{ - предварительное описание INotifyManager. }


PNotifyType = ^TNotifyType;
TNotifyType = (
	NT_LONG_OPERATION_START
	, NT_LONG_OPERATION_END
	, NT_MONITORING_UPDATE
	, NT_SHUTDOWN
	, NT_LOGOUT
	, NT_BASE_UPDATE_START
	, NT_BASE_UPDATE_END
	, NT_BASE_UPDATE_FAILED
	, NT_CONSULTATION_RECEIVED // Получен ответ
	, NT_CONSULTATION_NOT_SENT // Консультация не отправлена
	, NT_NO_SUBSCRIPTION // Консультация не отправлена, тк не прошла валидация
	, NT_INTERNET_AVAILABLE // Приходит при успешной связи с удалёнными сервисами (СК или сервер ревизий документов)
	, NT_NEW_CHAT_MESSAGES_RECEIVED // получены новые сообщения для чата
	, NT_CHAT_CONTACT_ADDED // добавлен новый контакт для чата
	, NT_CHAT_CONTACT_REMOVED // удалён контакт чата
	, NT_INTERNET_NOT_AVAILABLE // нет доступа к серверу ревизий документов
);

// Callback на облочке для получения сообщений с адаптера
IListener = interface (IInterface) ['{DFAC9F0B-95D4-4E9B-8525-1A10739E41A9}']
	procedure Fire (
		const aNotify: INotification
	); stdcall;
end;

INotification = interface (IInterface) ['{30BDF2EC-FBC4-4477-AC3B-5BB8CBFC8A4D}']
	function DontUseMe: Pointer;
	procedure GetData (out aRet {: IVariant}); stdcall;

	function GetId (): TNotifyType; stdcall;
end;

// Менеджер, обеспечивающий обмен сообщениями между адаптером и оболочкой
INotifyManager = interface (IInterface) ['{4E4282C5-1F27-4A9E-8F8D-3CC8B00FDA97}']
	function DontUseMe: Pointer;
	procedure RegisterListenerForNotify (
		aNotifyId: TNotifyType;
		const aListener: IListener
	); stdcall;
end;

implementation
end.