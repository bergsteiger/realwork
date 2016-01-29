program PDFFormServer;

{$APPTYPE CONSOLE}

uses
  WebBroker,
  CGIApp,
  WebModule in 'WebModule.pas' {WebModule1: TWebModule};

begin
  Application.Initialize;
  Application.CreateForm(TWebModule1, WebModule1);
  Application.Run;
end.
