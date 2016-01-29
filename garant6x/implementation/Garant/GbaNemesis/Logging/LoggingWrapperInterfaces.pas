unit LoggingWrapperInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Автор: Костицын
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/LoggingWrapperInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Logging::LoggingWrapperInterfaces
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
  LoggingUnit
  ;

type
 InsLogEventData = interface(IUnknown)
   ['{05D8F7D5-49AA-498E-8183-FC025550B703}']
   procedure AddDate(const aData: TDate);
   procedure AddObject(const aData: IUnknown);
   procedure AddString(aData: PAnsiChar);
   procedure AddULong(aData: Longword);
   function AsString: AnsiString;
   function AsLogEventData: ILogEventData;
 end;//InsLogEventData

 InsLogManager = interface(IUnknown)
   ['{966DBDBB-C728-4A76-9AA5-6CF45837D11F}']
   procedure AddEvent(aLogEvent: TLogEvent;
    const aData: InsLogEventData);
 end;//InsLogManager

implementation

end.