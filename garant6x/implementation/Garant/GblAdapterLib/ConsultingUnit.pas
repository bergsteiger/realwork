unit ConsultingUnit; {$Z4}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/GblAdapterLib/ConsultingUnit.pas"
// Delphi интерфейсы для адаптера (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::Consulting
//
// Интерфейсы для работы со службой ПП
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

interface

uses
	SysUtils
	, IOUnit
	, BaseTypesUnit
	, StartUnit
	, DynamicDocListUnit
	, FoldersUnit
	, DocumentUnit
	//#UC START# *4423F94903C8_457007DB002E_UNIT_FOR_Stream*
	//#UC END# *4423F94903C8_457007DB002E_UNIT_FOR_Stream*
	;

type

IEstimation = interface;
{ - предварительное описание IEstimation. }

IParasList = interface;
{ - предварительное описание IParasList. }

IConsultation = interface;
{ - предварительное описание IConsultation. }

IConsultationManager = interface;
{ - предварительное описание IConsultationManager. }

IConsultingTemplateInfo = interface;
{ - предварительное описание IConsultingTemplateInfo. }


// Возможные оценки
PEstimationValue = ^TEstimationValue;
TEstimationValue = (
	EV_UNDEFINED // оценка не выставлена
	, EV_VERY_GOOD // супер!!!
	, EV_GOOD // хорошо
	, EV_NORMAL // сойдёт
	, EV_BAD // полная фигня...
);

// Нет списка документов в ответе
ENoDocumentList = class (Exception);

// Нет связи с сервером консультаций
ENoConnection = class (Exception);

// Нет доступа с сервису - вы не подписаны на услугу
ENoSubscription = class (Exception);

// У пользователя нет прав оплачивать консультации
EPaymentForbidden = class (Exception);

// Нельзя удалить консультацию
ENotDeleted = class (Exception);

// Консультация удалена - все операции запрещены
EDeleted = class (Exception);

// консультация старого формата
EOldFormatConsultation = class (Exception);

PConsultationStatus = ^TConsultationStatus;
TConsultationStatus = Longword;

// тип шаблона
PTemplateType = ^TTemplateType;
TTemplateType = (
	PREANSWER_TEMPLATE // шаблон запроса об оплате
	, ANSWER_TEMPLATE // шаблон ответа
	, QUERY_TEMPLATE // шаблон запроса
);

// Оценка
IEstimation = interface (IInterface) ['{DD01B380-09FE-4476-8789-20B2291FE41B}']
	function DontUseMe: Pointer;
	// комментарий к оценке
	procedure GetText (out aRet {: IString}); stdcall;
	procedure SetText (const aText: IString); stdcall;

	// оценка
	function GetValue (): TEstimationValue; stdcall;
	procedure SetValue (aValue: TEstimationValue); stdcall;
end;

IParasList = interface(IInterface)
['{216C7CF0-D3B9-4F53-B8EF-2F43725AAC07}']
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
    procedure  pm_GetItem(anIndex: Integer; out aRet: IString); stdcall;

    procedure pm_SetItem(anIndex: Integer; const anItem: IString); stdcall;
      {-}
  // public methods
    function  Add(const anItem: IString): Integer; stdcall;
      {* - добавляет элемент Item в конец. }
    procedure Insert(anIndex: Integer; const anItem: IString); stdcall;
      {* - вставляет элемент Item по индексу Index. }
end;//IParasList

// Консультация
IConsultation = interface (IEntityBase) ['{69D87373-CAC1-4228-9F26-4E46D2A8CBE9}']
	// создать оценку
	procedure CreateEstimation (
		out aRet {: IEstimation}
	); stdcall;

	// Дата создания
	procedure GetCreationDate (out a: TDateTime); stdcall;

	procedure GetExpertInfo (out aRet {: IParasList}); stdcall;

	procedure GetExpertName (out aRet {: IString}); stdcall;

	// Получить уведомление или ответ на запрос
	procedure GetAnswer (
		out aRet {: IDocument}
	); stdcall; // can raise EDeleted, EOldFormatConsultation

	procedure GetAnswerData (
		out aIsEvd: Bytebool;
		out aRet {: IParasList}
	); stdcall;

	// Получить список документов ответа
	procedure GetDocumentList (
		out aRet {: IDynList}
	); stdcall; // can raise ENoDocumentList, EDeleted, EOldFormatConsultation

	// Получить запрос
	procedure GetQuery (
		out aRet {: IDocument}
	); stdcall; // can raise EDeleted, EOldFormatConsultation

	// получить запрос в виде списка параграфов
	procedure GetQueryByParas (
		out aRet {: IParasList}
	); stdcall;

	function HasEstimation (): Bytebool; stdcall; // can raise EDeleted

	function HasList (): Bytebool; stdcall; // can raise EDeleted

	function HasPaymentInformation (): Bytebool; stdcall; // can raise EDeleted

	// Идентификатор консультации
	procedure GetId (out aRet {: IString}); stdcall;

	// Дата последнего изменения статуса
	procedure GetModificationDate (out a: TDateTime); stdcall;

	// Имя консультации (текст запроса)
	procedure GetName (out aRet {: IString}); stdcall;

	// Подвердить (answer = true)/отказаться (false) от оплаты
	procedure PaymentConfirm (
		aAnswer: Bytebool
	); stdcall; // can raise ENoConnection, EPaymentForbidden

	procedure GetQueryData (out aRet {: IString}); stdcall;

	// Помечают консультацию как прочитанную
	procedure Read (); stdcall; // can raise EDeleted

	procedure GetReplyDate (out a: TDate); stdcall;

	// Отправить оценку
	procedure SendEstimation (
		const aValue: IEstimation
	); stdcall; // can raise ENoConnection, ENoSubscription, EDeleted

	// Статус консультации
	function GetStatus (): TConsultationStatus; stdcall;

	procedure GetUserName (out aRet {: IString}); stdcall;
end;

// Менеджер консультаций
IConsultationManager = interface (IInterface) ['{713794D3-0F90-4EE5-AF5D-644D9091DA0C}']
	function DontUseMe: Pointer;
	// Сообщает о невозможности получать ответы (true - когда лампочку надо включать)
	function CantReceiveAnswer (): Bytebool; stdcall;

	// Проверка досутпности консультационных услуг
	function CheckConsultingAvailable (): Bytebool; stdcall;

	// Проверка интернет канала
	function CheckInternetChannel (): Bytebool; stdcall;

	// Создание уведомления пользователя о консалтинге
	procedure CreateQueryWithNoticeUser (); stdcall;

	// Удалить консультацию
	procedure DeleteConsultation (
		const aForDelete: IConsultation
	); stdcall; // can raise ENotDeleted, EDeleted

	// загрузить консультацию из файла
	procedure LoadFromXml (
		const aFileName: PAnsiChar
	); stdcall; // can raise EAccessDenied, EInvalidXMLType

	// Возвращает количество непрочитанных консультаций
	function UpdateNotReadedConsultations (): Longword; stdcall;
end;

// Информация для шаблонов консалтинга. Сейчас в базе есть 2 шаблона (preanswer и answer). Какой
// шаблон нужен для консультации спрашиваем у get_template_type
IConsultingTemplateInfo = interface (IInterface) ['{3613E72E-8CD0-4D45-B517-BD45F9764A82}']
	function DontUseMe: Pointer;
	procedure GetAnswerTemplate (
		out aRet {: IStream}
	); stdcall;

	// информация о комплекте, которая может быть нужна для шаблона. См. [$100008775]
	procedure GetDealerInfo (
		out aRet {: IString}
	); stdcall;

	procedure GetPreanswerTemplate (
		out aRet {: IStream}
	); stdcall;

	// получить шаблон для запроса
	procedure GetQueryTemplate (
		out aRet {: IStream}
	); stdcall;

	// определяет какой шаблон нужен для отображения консультации
	function GetTemplateType (
		const aConsultation: IConsultation
	): TTemplateType; stdcall; // can raise EDeleted
end;

const

 { Статусы консультаций }
	CS_SENT = TConsultationStatus(1024);
 { Отправлена }
	CS_PAYMENT_REQUEST = TConsultationStatus(1);
 { Запрос на оплату }
	CS_ANSWER_RECEIVED = TConsultationStatus(2);
 { Получен ответ }
	CS_READ = TConsultationStatus(4);
	CS_ESTIMATION_SENT = TConsultationStatus(8);
 { Отправлена оценка }
	CS_DRAFTS = TConsultationStatus(16);
 { Создана, но не отправлена }
	CS_PAYMENT_REFUSAL = TConsultationStatus(32);
 { Оплата отклонена }
	CS_PAYMENT_CONFIRM = TConsultationStatus(64);
	CS_VALIDATION_FAILED = TConsultationStatus(128);
	CS_ANSWER_NOT_CONFIRM = TConsultationStatus(256);
	CS_READ_NOT_CONFIRM = TConsultationStatus(512);

implementation
end.