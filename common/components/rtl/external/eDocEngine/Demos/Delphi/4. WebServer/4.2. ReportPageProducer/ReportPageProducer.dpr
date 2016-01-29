program ReportPageProducer;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  WebServer in 'WebServer.pas' {wmdServer: TWebModule},
  QReDocProducer in 'QReDocProducer.pas' {frmQuickReport};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TwmdServer, wmdServer);
  Application.Run;
end.
