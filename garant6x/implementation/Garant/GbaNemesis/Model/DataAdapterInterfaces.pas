unit DataAdapterInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/DataAdapterInterfaces.pas"
// Начат: 10.02.2009 21:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::DataAdapterInterfaces
//
// Работа с адаптером
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  BaseTypesUnit,
  DocumentUnit,
  l3Interfaces
  ;

type
 InsDataAdapterListener = interface(Il3Notify)
  {* Слушатель событий данных адаптера }
   ['{FF1A9777-1D65-4D93-84E5-48F29F5B1F83}']
   procedure Updated;
     {* данные адаптера были обновлен }
 end;//InsDataAdapterListener

 TTMWarningType = (
   tmwNone
 , tmwError
 , tmwWarning
 );//TTMWarningType

 InsTimeMachine = interface(IUnknown)
   ['{02F64798-095B-406B-B75D-A4D4C9FE7C7E}']
   function pm_GetIsOn: Boolean;
   function pm_GetDate: TDate;
   procedure pm_SetDate(const aValue: TDate);
   function pm_GetDateStr: Il3CString;
   function pm_GetNotSureHelp: IDocument;
   function HasTimeMachineWarning(const aDocument: IDocument): Boolean;
   function GetTimeMachineWarning(const aDocument: IDocument;
    out aWarning: Il3CString): TTMWarningType;
   function HasNotSureWarning(const aDocument: IDocument): Boolean;
   function GetNotSureWarning(const aDocument: IDocument;
    out aComment: Il3CString): Il3CString;
   function CorrectDocumentEdition(const aDocument: IDocument): IDocument;
   procedure SwitchOff(StayInCurrentRedaction: Boolean = False);
   property IsOn: Boolean
     read pm_GetIsOn;
   property Date: TDate
     read pm_GetDate
     write pm_SetDate;
   property DateStr: Il3CString
     read pm_GetDateStr;
   property NotSureHelp: IDocument
     read pm_GetNotSureHelp;
 end;//InsTimeMachine
{$IfEnd} //not Admin AND not Monitorings

implementation

end.