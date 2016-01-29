unit alcuService;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  alcuAutoPipeServer;

type
  TaluService = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
 private
    f_Server: TalcuServerPrim;
    procedure CreateServer;
    procedure DestroyServer;
 public
    function GetServiceController: TServiceController; override;
  end;

var
 aluService: TaluService;

implementation

{$R *.DFM}
Uses
 l3Base;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  aluService.Controller(CtrlCode);
end;

procedure TaluService.CreateServer;
begin
 l3System.Msg2Log('TalcuServerPrim.Create(nil)');
 f_Server:= TalcuServerPrim.Create(nil);
 l3System.Msg2Log('f_Server.Service:= Self;');
 f_Server.Service:= Self;
 l3System.Msg2Log('f_Server.Initialize');
 f_Server.Initialize;
 l3System.Msg2Log('Created');
end;

procedure TaluService.DestroyServer;
begin
 l3Free(f_Server);
end;

function TaluService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TaluService.ServiceAfterInstall(Sender: TService);
begin
 l3System.Msg2Log('Служба установлена');
end;

procedure TaluService.ServiceAfterUninstall(Sender: TService);
begin
 l3System.Msg2Log('Служба снята');
end;

procedure TaluService.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  // Продолжение работы
 l3System.Msg2Log('Перезапуск службы (%d)', [GetCurrentThreadId]);
 // Продолжение работы
 Continued:= f_Server.Continue;
end;

procedure TaluService.ServiceCreate(Sender: TObject);
begin
 // Создание сервиса
 l3System.Msg2Log('-= Создание службы =-(%d)', [GetCurrentThreadId]);
 // тут можно создавать необходимые объекты
 // Вызывается из другой нити, TyTech не работает
end;

procedure TaluService.ServiceDestroy(Sender: TObject);
begin
 // Уничтожение сервиса
 l3System.Msg2Log('-= Уничтожение службы =-(%d)', [GetCurrentThreadId]);
 // тут уничтожаются все объекты
 // Вызывается из другой нити, TyTech не работает
end;

procedure TaluService.ServiceExecute(Sender: TService);
begin
 l3System.Msg2Log('Выполнение службы(%d)', [GetCurrentThreadId]);
 while not Terminated do
 begin
  f_Server.Execute;
  ServiceThread.ProcessRequests(True);
 end;
end;

procedure TaluService.ServicePause(Sender: TService; var Paused: Boolean);
begin
 l3System.Msg2Log('Приостановка службы(%d)', [GetCurrentThreadId]);
 // Приостановить выполнение процессов
 Paused:= f_server.Pause;
end;

procedure TaluService.ServiceShutdown(Sender: TService);
begin
  // Выключение сервиса
  l3System.Msg2Log('Выключение службы(%d)', [GetCurrentThreadId]);
  // Тут останавливаются все процессы
end;

procedure TaluService.ServiceStart(Sender: TService; var Started: Boolean);
begin
 l3System.Msg2Log('Запуск службы(%d)', [GetCurrentThreadId]);
 // Тут нужно запустить все необходимые процессы
 CreateServer;
 Started:= f_Server.Start;
 f_Server.ChecksSetup;
end;

procedure TaluService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
 l3System.Msg2Log('Остановка службы(%d)', [GetCurrentThreadId]);
 // Тут нужно остановить все процессы
 Stopped := f_Server.Stop;
 DestroyServer;
end;

end.
