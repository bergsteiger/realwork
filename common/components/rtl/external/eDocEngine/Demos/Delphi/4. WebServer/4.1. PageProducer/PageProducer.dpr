program PageProducer;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  WebServer in 'WebServer.pas' {wmdEngineProducer: TWebModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TwmdEngineProducer, wmdEngineProducer);
  Application.Run;
end.
