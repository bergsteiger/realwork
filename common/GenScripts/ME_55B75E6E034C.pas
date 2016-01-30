unit LoggingWrapperInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\LoggingWrapperInterfaces.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , LoggingUnit
 , BaseTypesUnit
;

type
 InsLogEventData = interface
  ['{05D8F7D5-49AA-498E-8183-FC025550B703}']
  procedure AddDate(const aData: TDate);
  procedure AddObject(const aData: IUnknown);
  procedure AddString(aData: PAnsiChar);
  procedure AddULong(aData: Longword);
  function AsString: AnsiString;
  function AsLogEventData: ILogEventData;
 end;//InsLogEventData

 InsLogManager = interface
  ['{966DBDBB-C728-4A76-9AA5-6CF45837D11F}']
  procedure AddEvent(aLogEvent: TLogEvent;
   const aData: InsLogEventData);
 end;//InsLogManager

 InsLoggingTestService = interface
  ['{BEAE7BA4-756B-405A-8CA5-39CEEEE025E2}']
  procedure AddLogString(const aString: AnsiString);
 end;//InsLoggingTestService

implementation

uses
 l3ImplUses
;

end.
