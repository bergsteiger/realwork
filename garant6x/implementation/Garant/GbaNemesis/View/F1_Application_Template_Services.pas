unit F1_Application_Template_Services;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\F1_Application_Template_Services.pas"
// Стереотип: "VCMContracts"
// Элемент модели: "Services" MUID: (57A32ECC01AF)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , SearchUnit
 {$If NOT Defined(Admin)}
 , nsQueryInterfaces
 {$IfEnd} // NOT Defined(Admin)
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TShutdownWarningKind = (
  {* [$159367978] }
  wkShutDown
  , wkLogout
 );//TShutdownWarningKind

 (*
 MLongProcessService = interface
  {* Контракт сервиса TLongProcessService }
  function MakeUpdateMessage: IvcmEntityForm;
   {* Создаёт окно с сообщением об обновлении базы }
 end;//MLongProcessService
 *)

 ILongProcessService = interface
  {* Интерфейс сервиса TLongProcessService }
  function MakeUpdateMessage: IvcmEntityForm;
   {* Создаёт окно с сообщением об обновлении базы }
 end;//ILongProcessService

 TLongProcessService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ILongProcessService;
    {* Внешняя реализация сервиса ILongProcessService }
  protected
   procedure pm_SetAlien(const aValue: ILongProcessService);
   procedure ClearFields; override;
  public
   function MakeUpdateMessage: IvcmEntityForm;
    {* Создаёт окно с сообщением об обновлении базы }
   class function Instance: TLongProcessService;
    {* Метод получения экземпляра синглетона TLongProcessService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ILongProcessService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ILongProcessService }
 end;//TLongProcessService

 (*
 MShutdownService = interface
  {* Контракт сервиса TShutdownService }
  function MakeShutdownWindow(aCloseInterval: LongWord;
   aKind: TShutdownWarningKind): IvcmEntityForm;
   {* Создаёт окно сообщающее о закрытии приложения }
 end;//MShutdownService
 *)

 IShutdownService = interface
  {* Интерфейс сервиса TShutdownService }
  function MakeShutdownWindow(aCloseInterval: LongWord;
   aKind: TShutdownWarningKind): IvcmEntityForm;
   {* Создаёт окно сообщающее о закрытии приложения }
 end;//IShutdownService

 TShutdownService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IShutdownService;
    {* Внешняя реализация сервиса IShutdownService }
  protected
   procedure pm_SetAlien(const aValue: IShutdownService);
   procedure ClearFields; override;
  public
   function MakeShutdownWindow(aCloseInterval: LongWord;
    aKind: TShutdownWarningKind): IvcmEntityForm;
    {* Создаёт окно сообщающее о закрытии приложения }
   class function Instance: TShutdownService;
    {* Метод получения экземпляра синглетона TShutdownService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IShutdownService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IShutdownService }
 end;//TShutdownService

 (*
 MQueryOpenService = interface
  {* Контракт сервиса TQueryOpenService }
  {$If NOT Defined(Admin)}
  procedure OpenQuery(aQueryType: TlgQueryType;
   const aQuery: IQuery;
   const aContainer: IvcmContainer);
  {$IfEnd} // NOT Defined(Admin)
 end;//MQueryOpenService
 *)

 IQueryOpenService = interface
  {* Интерфейс сервиса TQueryOpenService }
  {$If NOT Defined(Admin)}
  procedure OpenQuery(aQueryType: TlgQueryType;
   const aQuery: IQuery;
   const aContainer: IvcmContainer);
  {$IfEnd} // NOT Defined(Admin)
 end;//IQueryOpenService

 TQueryOpenService = {final} class(Tl3ProtoObject)
  private
   f_Alien: IQueryOpenService;
    {* Внешняя реализация сервиса IQueryOpenService }
  protected
   procedure pm_SetAlien(const aValue: IQueryOpenService);
   procedure ClearFields; override;
  public
   {$If NOT Defined(Admin)}
   procedure OpenQuery(aQueryType: TlgQueryType;
    const aQuery: IQuery;
    const aContainer: IvcmContainer);
   {$IfEnd} // NOT Defined(Admin)
   class function Instance: TQueryOpenService;
    {* Метод получения экземпляра синглетона TQueryOpenService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: IQueryOpenService
    write pm_SetAlien;
    {* Внешняя реализация сервиса IQueryOpenService }
 end;//TQueryOpenService

 (*
 MLoggingService = interface
  {* Контракт сервиса TLoggingService }
  procedure LogUserActivity(aKind: TvcmOperationCallType);
 end;//MLoggingService
 *)

 ILoggingService = interface
  {* Интерфейс сервиса TLoggingService }
  procedure LogUserActivity(aKind: TvcmOperationCallType);
 end;//ILoggingService

 TLoggingService = {final} class(Tl3ProtoObject)
  private
   f_Alien: ILoggingService;
    {* Внешняя реализация сервиса ILoggingService }
  protected
   procedure pm_SetAlien(const aValue: ILoggingService);
   procedure ClearFields; override;
  public
   procedure LogUserActivity(aKind: TvcmOperationCallType);
   class function Instance: TLoggingService;
    {* Метод получения экземпляра синглетона TLoggingService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: ILoggingService
    write pm_SetAlien;
    {* Внешняя реализация сервиса ILoggingService }
 end;//TLoggingService

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , SysUtils
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

var g_TLongProcessService: TLongProcessService = nil;
 {* Экземпляр синглетона TLongProcessService }
var g_TShutdownService: TShutdownService = nil;
 {* Экземпляр синглетона TShutdownService }
var g_TQueryOpenService: TQueryOpenService = nil;
 {* Экземпляр синглетона TQueryOpenService }
var g_TLoggingService: TLoggingService = nil;
 {* Экземпляр синглетона TLoggingService }

procedure TLongProcessServiceFree;
 {* Метод освобождения экземпляра синглетона TLongProcessService }
begin
 l3Free(g_TLongProcessService);
end;//TLongProcessServiceFree

procedure TShutdownServiceFree;
 {* Метод освобождения экземпляра синглетона TShutdownService }
begin
 l3Free(g_TShutdownService);
end;//TShutdownServiceFree

procedure TQueryOpenServiceFree;
 {* Метод освобождения экземпляра синглетона TQueryOpenService }
begin
 l3Free(g_TQueryOpenService);
end;//TQueryOpenServiceFree

procedure TLoggingServiceFree;
 {* Метод освобождения экземпляра синглетона TLoggingService }
begin
 l3Free(g_TLoggingService);
end;//TLoggingServiceFree

procedure TLongProcessService.pm_SetAlien(const aValue: ILongProcessService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TLongProcessService.pm_SetAlien

function TLongProcessService.MakeUpdateMessage: IvcmEntityForm;
 {* Создаёт окно с сообщением об обновлении базы }
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeUpdateMessage
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TLongProcessService.MakeUpdateMessage

class function TLongProcessService.Instance: TLongProcessService;
 {* Метод получения экземпляра синглетона TLongProcessService }
begin
 if (g_TLongProcessService = nil) then
 begin
  l3System.AddExitProc(TLongProcessServiceFree);
  g_TLongProcessService := Create;
 end;
 Result := g_TLongProcessService;
end;//TLongProcessService.Instance

class function TLongProcessService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TLongProcessService <> nil;
end;//TLongProcessService.Exists

procedure TLongProcessService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TLongProcessService.ClearFields

procedure TShutdownService.pm_SetAlien(const aValue: IShutdownService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TShutdownService.pm_SetAlien

function TShutdownService.MakeShutdownWindow(aCloseInterval: LongWord;
 aKind: TShutdownWarningKind): IvcmEntityForm;
 {* Создаёт окно сообщающее о закрытии приложения }
begin
 if (f_Alien <> nil) then
  Result := f_Alien.MakeShutdownWindow(aCloseInterval, aKind)
 else
 begin
  Finalize(Result);
  System.FillChar(Result, SizeOf(Result), 0);
 end;
end;//TShutdownService.MakeShutdownWindow

class function TShutdownService.Instance: TShutdownService;
 {* Метод получения экземпляра синглетона TShutdownService }
begin
 if (g_TShutdownService = nil) then
 begin
  l3System.AddExitProc(TShutdownServiceFree);
  g_TShutdownService := Create;
 end;
 Result := g_TShutdownService;
end;//TShutdownService.Instance

class function TShutdownService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TShutdownService <> nil;
end;//TShutdownService.Exists

procedure TShutdownService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TShutdownService.ClearFields

procedure TQueryOpenService.pm_SetAlien(const aValue: IQueryOpenService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TQueryOpenService.pm_SetAlien

{$If NOT Defined(Admin)}
procedure TQueryOpenService.OpenQuery(aQueryType: TlgQueryType;
 const aQuery: IQuery;
 const aContainer: IvcmContainer);
begin
 if (f_Alien <> nil) then
  f_Alien.OpenQuery(aQueryType, aQuery, aContainer);
end;//TQueryOpenService.OpenQuery
{$IfEnd} // NOT Defined(Admin)

class function TQueryOpenService.Instance: TQueryOpenService;
 {* Метод получения экземпляра синглетона TQueryOpenService }
begin
 if (g_TQueryOpenService = nil) then
 begin
  l3System.AddExitProc(TQueryOpenServiceFree);
  g_TQueryOpenService := Create;
 end;
 Result := g_TQueryOpenService;
end;//TQueryOpenService.Instance

class function TQueryOpenService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TQueryOpenService <> nil;
end;//TQueryOpenService.Exists

procedure TQueryOpenService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TQueryOpenService.ClearFields

procedure TLoggingService.pm_SetAlien(const aValue: ILoggingService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TLoggingService.pm_SetAlien

procedure TLoggingService.LogUserActivity(aKind: TvcmOperationCallType);
begin
 if (f_Alien <> nil) then
  f_Alien.LogUserActivity(aKind);
end;//TLoggingService.LogUserActivity

class function TLoggingService.Instance: TLoggingService;
 {* Метод получения экземпляра синглетона TLoggingService }
begin
 if (g_TLoggingService = nil) then
 begin
  l3System.AddExitProc(TLoggingServiceFree);
  g_TLoggingService := Create;
 end;
 Result := g_TLoggingService;
end;//TLoggingService.Instance

class function TLoggingService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TLoggingService <> nil;
end;//TLoggingService.Exists

procedure TLoggingService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TLoggingService.ClearFields

initialization

end.
