unit ChatInterfacesUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Ѕиблиотека "GblAdapterLib"
// ћодуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ChatInterfacesUnit.pas"
// Delphi интерфейсы дл€ адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ChatInterfaces
//
// интерфейсы дл€ поддержки чата
//
//
// ¬се права принадлежат ќќќ Ќѕѕ "√арант-—ервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, DynamicTreeUnit
	, NotifyUnit
	, SecurityUnit
	//#UC START# *4423F94903C8_4A40991F003F_UNIT_FOR_Stream*
        , ActiveX
	//#UC END# *4423F94903C8_4A40991F003F_UNIT_FOR_Stream*
	;

type

IChatManager = interface;
{ - предварительное описание IChatManager. }

IMessages = interface;
{ - предварительное описание IMessages. }

IMessagesManager = interface;
{ - предварительное описание IMessagesManager. }


// информаци€ о пользователе
PUserInfo = ^TUserInfo;
TUserInfo = packed record
	rEmail: IString; // email пользовател€
	rLogin: IString; // регистрационное им€ пользовател€
	rName: IString; // им€ пользовател€
end;

// задан идентификатор неизвестного пользовател€
EUnknownUser = class (Exception);

// данные сообщени€
PMessage = ^TMessage;
TMessage = packed record
	rText: IStream; // сообщение (предполагаетс€, что в evd формате)
	rTime: TDateTime; // врем€ создани€ сообщени€
	rMy: Bytebool; // true, если сообщение послано текущим пользователем, иначе это сообщение дл€ него
end;

// управление чатом
IChatManager = interface (IInterface) ['{F9DEFC6A-0DF4-4DC4-B863-62E0A7D8E68A}']
	function DontUseMe: Pointer;
	// добавить пользовател€ в список контактов
	procedure AddUser (
		aUid: TUid
	); stdcall; // can raise EUnknownUser

	// удалить пользовател€ из списка контактов
	procedure DeleteUser (
		aUid: TUid
	); stdcall; // can raise EUnknownUser

	// получить список пользователей, добавленных в контакты
	procedure GetContactsTree (
		out aRet {: INodeBase}
	); stdcall;

	// информаци€ о пользователе с заданным идентификатором
	procedure GetUserInfo (
		aUid: TUid;
		out a: TUserInfo
	); stdcall; // can raise EUnknownUser

	// возвращает true, если на сервере обеспечена поддержка чата
	function IsEmbedChatEnabled (): Bytebool; stdcall;

	// зарегестрировать слушател€
	procedure RegisterListenerForNotify (
		const aListener: IListener
	); stdcall;
end;

IMessages = interface(IInterface)
['{AE30875B-B8F9-4132-98BC-ED5ED0D061FF}']
    function  pm_GetCount: Integer; stdcall;
    procedure pm_SetCount(aValue: Integer); stdcall;
      { - методы дл€ доступа к свойству Count. }
    procedure Clear; stdcall;
      {* очистить список. }
    procedure Delete(anIndex: Integer); stdcall;
      {* удал€ет элемент по индексу Index. }
    property Count: Integer
      read pm_GetCount
      write pm_SetCount;
       {* число элементов в хранилище. }
  // property methods
    procedure  pm_GetItem(anIndex: Integer; out aRet: TMessage); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: TMessage); stdcall;
      {-}
  // public methods
    function  Add(const anItem: TMessage): Integer; stdcall;
      {* - добавл€ет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: TMessage); stdcall;
      {* - вставл€ет элемент Item по индексу Index. }
end;//IMessages

// работа с сообщени€ми
IMessagesManager = interface (IInterface) ['{7D3435F1-68A4-4CBE-A547-240E45D9FAE4}']
	function DontUseMe: Pointer;
	// очистить историю сообщений с заданным пользователем
	procedure CleanHistory (
		aUid: TUid
	); stdcall; // can raise EUnknownUser

	// получить count последних сообщений переписки с пользователем uid. ≈сли count = 0, получить
	// полную историю переписки. ≈сли all_new = true, будут получены все непрочитанные сообщени€, даже
	// если их количество превышает count.
	procedure GetHistoryForUser (
		aCount: Longword;
		aAllNew: Bytebool;
		aUid: TUid;
		out aRet {: IMessages}
	); stdcall; // can raise EUnknownUser

	// получить непрочитанные сообщени€ от пользовател€ с заданным uid
	procedure GetUnreadedMessages (
		aUid: TUid;
		out aRet {: IMessages}
	); overload; stdcall; // can raise EUnknownUser

	// послать сообщение заданному пользователю
	procedure SendMessage (
		const aMessage: IStream;
		aUid: TUid
	); stdcall; // can raise EUnknownUser
end;

implementation
end.