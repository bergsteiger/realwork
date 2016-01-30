unit nsCachedEventsProcessor;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsCachedEventsProcessor.pas"
// Стереотип: "SimpleClass"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , nsPrimCachedEventsProcessor
 , LoggingInterfaces
;

type
 TnsCachedEventsProcessor = class(TnsPrimCachedEventsProcessor)
  public
   class function Make: InsCachedEventsProcessor; reintroduce;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TnsCachedEventsProcessor;
    {* Метод получения экземпляра синглетона TnsCachedEventsProcessor }
 end;//TnsCachedEventsProcessor

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsCachedEventsProcessor: TnsCachedEventsProcessor = nil;
 {* Экземпляр синглетона TnsCachedEventsProcessor }

procedure TnsCachedEventsProcessorFree;
 {* Метод освобождения экземпляра синглетона TnsCachedEventsProcessor }
begin
 l3Free(g_TnsCachedEventsProcessor);
end;//TnsCachedEventsProcessorFree

class function TnsCachedEventsProcessor.Make: InsCachedEventsProcessor;
var
 l_Inst : TnsCachedEventsProcessor;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsCachedEventsProcessor.Make

class function TnsCachedEventsProcessor.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsCachedEventsProcessor <> nil;
end;//TnsCachedEventsProcessor.Exists

class function TnsCachedEventsProcessor.Instance: TnsCachedEventsProcessor;
 {* Метод получения экземпляра синглетона TnsCachedEventsProcessor }
begin
 if (g_TnsCachedEventsProcessor = nil) then
 begin
  l3System.AddExitProc(TnsCachedEventsProcessorFree);
  g_TnsCachedEventsProcessor := Create;
 end;
 Result := g_TnsCachedEventsProcessor;
end;//TnsCachedEventsProcessor.Instance

end.
