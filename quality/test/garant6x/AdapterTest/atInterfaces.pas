unit atInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/atInterfaces.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> garant6x_test::AdapterTest::atInterfaces
//
// Интерфейсы.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  SysUtils
  ;

type
 IatNotification = interface(IUnknown)
   ['{D4866603-21F1-463D-AB4C-820C5BA289A4}']
   function GetData: Variant;
 end;//IatNotification

 IatNotifier = interface;
 { - предварительное описание IatNotifier. }

 IatListener = interface(IUnknown)
   ['{9E600180-97B5-4A9A-BB1E-E7C218A05CDB}']
   procedure StartListen(const notifier: IatNotifier);
   procedure StopListen; overload; 
   procedure StopListen(const notifier: IatNotifier); overload; 
   procedure Fire(sender: TObject;
    const notification: IatNotification);
 end;//IatListener

 IatNotifier = interface(IUnknown)
   ['{BE01B3ED-91B5-42D4-B9E9-97FDE66F958B}']
   procedure StartNotify(const listener: IatListener);
   procedure StopNotify; overload; 
   procedure StopNotify(const listener: IatListener); overload; 
   procedure Trigger(sender: TObject;
    const notification: IatNotification);
 end;//IatNotifier

 IatNotifyRepeater = interface(IUnknown)
   ['{4D3B14E2-C3EF-4A10-8C80-34866986AAA0}']
   function AsListener: IatListener;
   function AsNotifier: IatNotifier;
 end;//IatNotifyRepeater

 IatLogger = interface(IUnknown)
   ['{AD31BD63-D3F1-4F87-BC4F-4E00D5D3F052}']
   function Info(const msg: AnsiString): AnsiString; overload; 
   function Warning(const msg: AnsiString): AnsiString; overload; 
   function Error(const msg: AnsiString): AnsiString; overload; 
   procedure Exception(ex: Exception;
    const prefix: AnsiString = '');
   function Info(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload; 
   function Warning(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload; 
   function Error(const aFormat: AnsiString;
    const anArgs: array of const): AnsiString; overload; 
 end;//IatLogger

implementation

end.