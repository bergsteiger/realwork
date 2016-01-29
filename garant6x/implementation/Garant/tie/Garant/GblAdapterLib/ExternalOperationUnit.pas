unit ExternalOperationUnit;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/ExternalOperationUnit.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x::GblAdapterLib::ExternalOperation
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit,
  BaseTreeSupportUnit
  ;

type
 IExternalOperation = interface(IUnknown)
  {* Ссылки на операции }
   ['{71ECDD4A-0455-4800-BD55-7ECB739949A7}']
   function GetId: TObjectId; stdcall;
   property id: TObjectId
     read GetId;
 end;//IExternalOperation

const
  { ExternalOperationId }
 EOI_ESTIMATION : Cardinal = 1;
  { Оценить ответ }
 EOI_PAYMENT_CONFIRM : Cardinal = 2;
  { Подтверждение оплаты }
 EOI_PAYMENT_REFUSAL : Cardinal = 3;
  { Оплата отклонена }
 EOI_OPEN_ATTRIBUTE_CARD : Cardinal = 4;
 EOI_SHOW_HELP_TOPIC : Cardinal = 5;
 EOI_CHANGE_COLLAPSED : Cardinal = 6;
 EOI_CHECK_LEGAL_ADVISE_AVAILABLE : Cardinal = 7;
 EOI_CONSULTATION_CALL_GARANT : Cardinal = 8;
  { Ссылка на www.garant.ru в уведомлении о консалтинге }
 EOI_SHOW_CONSULTATION_LIST : Cardinal = 9;
  { показать список к консультации }
 EOI_SHOW_LC_HELP : Cardinal = 10;
  { Ссылка на Справка-описание Правового календаря }
 EOI_CHANGES_INSIDE_TABLE : Cardinal = 11;

implementation

end.