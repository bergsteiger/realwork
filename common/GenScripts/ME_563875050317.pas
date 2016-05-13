unit nsBaseSearchService;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Search\nsBaseSearchService.pas"
// Стереотип: "Service"
// Элемент модели: "TnsBaseSearchService" MUID: (563875050317)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3ProtoObject
 , BaseSearchInterfaces
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

 (*
 MnsBaseSearchService = interface
  {* Контракт сервиса TnsBaseSearchService }
  function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
  procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
  procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
  function GetBaseSearchWindow(const aContainer: IvcmContainer): IvcmEntityForm;
  procedure OpenBaseSearch(const aContainer: IvcmContainer;
   aOpenKind: TnsBaseSearchOpenKind);
  function GetBaseSearchModel(const aContainer: IvcmContainer): InsBaseSearchModel;
  function GetBaseSearchController(const aContainer: IvcmContainer): InsBaseSearchController;
  procedure RegisterBaseSearchView(const aBaseSearchView: InsBaseSearchView;
   const aContainer: IvcmContainer);
  function GetBaseSearchView(const aContainer: IvcmContainer): InsBaseSearchView;
 end;//MnsBaseSearchService
 *)

type
 InsBaseSearchService = interface
  {* Интерфейс сервиса TnsBaseSearchService }
  ['{40B734EB-B07C-49D2-B51A-EC2A0B80C837}']
  function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
  procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
  procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
   const aProvider: InsBaseSearcherProvider);
  function GetBaseSearchWindow(const aContainer: IvcmContainer): IvcmEntityForm;
  procedure OpenBaseSearch(const aContainer: IvcmContainer;
   aOpenKind: TnsBaseSearchOpenKind);
  function GetBaseSearchModel(const aContainer: IvcmContainer): InsBaseSearchModel;
  function GetBaseSearchController(const aContainer: IvcmContainer): InsBaseSearchController;
  procedure RegisterBaseSearchView(const aBaseSearchView: InsBaseSearchView;
   const aContainer: IvcmContainer);
  function GetBaseSearchView(const aContainer: IvcmContainer): InsBaseSearchView;
 end;//InsBaseSearchService

 TnsBaseSearchService = {final} class(Tl3ProtoObject)
  private
   f_Alien: InsBaseSearchService;
    {* Внешняя реализация сервиса InsBaseSearchService }
  protected
   procedure pm_SetAlien(const aValue: InsBaseSearchService);
   procedure ClearFields; override;
  public
   procedure RegisterBaseSearchView(const aBaseSearchView: InsBaseSearchView;
    const aContainer: IvcmContainer);
   function GetBaseSearchController(const aContainer: IvcmContainer): InsBaseSearchController;
   function GetBaseSearchModel(const aContainer: IvcmContainer): InsBaseSearchModel;
   function GetBaseSearchView(const aContainer: IvcmContainer): InsBaseSearchView;
   function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
   procedure OpenBaseSearch(const aContainer: IvcmContainer;
    aOpenKind: TnsBaseSearchOpenKind);
   function GetBaseSearchWindow(const aContainer: IvcmContainer): IvcmEntityForm;
   procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   class function Instance: TnsBaseSearchService;
    {* Метод получения экземпляра синглетона TnsBaseSearchService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Alien: InsBaseSearchService
    write pm_SetAlien;
    {* Внешняя реализация сервиса InsBaseSearchService }
 end;//TnsBaseSearchService
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TnsBaseSearchService: TnsBaseSearchService = nil;
 {* Экземпляр синглетона TnsBaseSearchService }

procedure TnsBaseSearchServiceFree;
 {* Метод освобождения экземпляра синглетона TnsBaseSearchService }
begin
 l3Free(g_TnsBaseSearchService);
end;//TnsBaseSearchServiceFree

procedure TnsBaseSearchService.pm_SetAlien(const aValue: InsBaseSearchService);
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TnsBaseSearchService.pm_SetAlien

procedure TnsBaseSearchService.RegisterBaseSearchView(const aBaseSearchView: InsBaseSearchView;
 const aContainer: IvcmContainer);
//#UC START# *130AF2617571_563875050317_var*
//#UC END# *130AF2617571_563875050317_var*
begin
//#UC START# *130AF2617571_563875050317_impl*
 if (f_Alien <> nil) then
  f_Alien.RegisterBaseSearchView(aBaseSearchView, aContainer)
 else
  Assert(False);
//#UC END# *130AF2617571_563875050317_impl*
end;//TnsBaseSearchService.RegisterBaseSearchView

function TnsBaseSearchService.GetBaseSearchController(const aContainer: IvcmContainer): InsBaseSearchController;
//#UC START# *29D9062E385E_563875050317_var*
//#UC END# *29D9062E385E_563875050317_var*
begin
//#UC START# *29D9062E385E_563875050317_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetBaseSearchController(aContainer)
 else
 begin
  Result := nil;
  Assert(False);
 end;
//#UC END# *29D9062E385E_563875050317_impl*
end;//TnsBaseSearchService.GetBaseSearchController

function TnsBaseSearchService.GetBaseSearchModel(const aContainer: IvcmContainer): InsBaseSearchModel;
//#UC START# *3ABD99A8B9EE_563875050317_var*
//#UC END# *3ABD99A8B9EE_563875050317_var*
begin
//#UC START# *3ABD99A8B9EE_563875050317_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetBaseSearchModel(aContainer)
 else
 begin
  Result := nil;
  Assert(False);
 end;

//#UC END# *3ABD99A8B9EE_563875050317_impl*
end;//TnsBaseSearchService.GetBaseSearchModel

function TnsBaseSearchService.GetBaseSearchView(const aContainer: IvcmContainer): InsBaseSearchView;
//#UC START# *48C239B7B9E8_563875050317_var*
//#UC END# *48C239B7B9E8_563875050317_var*
begin
//#UC START# *48C239B7B9E8_563875050317_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetBaseSearchView(aContainer)
 else
 begin
  Result := nil;
  Assert(false);
 end;
//#UC END# *48C239B7B9E8_563875050317_impl*
end;//TnsBaseSearchService.GetBaseSearchView

function TnsBaseSearchService.GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
//#UC START# *4923CA8F0CFB_563875050317_var*
//#UC END# *4923CA8F0CFB_563875050317_var*
begin
//#UC START# *4923CA8F0CFB_563875050317_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetBaseSearcher(aEntityForm)
 else
  Assert(False);
//#UC END# *4923CA8F0CFB_563875050317_impl*
end;//TnsBaseSearchService.GetBaseSearcher

procedure TnsBaseSearchService.OpenBaseSearch(const aContainer: IvcmContainer;
 aOpenKind: TnsBaseSearchOpenKind);
//#UC START# *5434702F7752_563875050317_var*
//#UC END# *5434702F7752_563875050317_var*
begin
//#UC START# *5434702F7752_563875050317_impl*
 if (f_Alien <> nil) then
  f_Alien.OpenBaseSearch(aContainer, aOpenKind)
 else
  Assert(False);
//#UC END# *5434702F7752_563875050317_impl*
end;//TnsBaseSearchService.OpenBaseSearch

function TnsBaseSearchService.GetBaseSearchWindow(const aContainer: IvcmContainer): IvcmEntityForm;
//#UC START# *5E9BD918F50B_563875050317_var*
//#UC END# *5E9BD918F50B_563875050317_var*
begin
//#UC START# *5E9BD918F50B_563875050317_impl*
 if (f_Alien <> nil) then
  Result := f_Alien.GetBaseSearchWindow(aContainer)
 else
  Assert(False);
//#UC END# *5E9BD918F50B_563875050317_impl*
end;//TnsBaseSearchService.GetBaseSearchWindow

procedure TnsBaseSearchService.RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
 const aProvider: InsBaseSearcherProvider);
//#UC START# *B86FD3ED4532_563875050317_var*
//#UC END# *B86FD3ED4532_563875050317_var*
begin
//#UC START# *B86FD3ED4532_563875050317_impl*
 if (f_Alien <> nil) then
  f_Alien.RegisterBaseSearcherProvider(aContainer, aProvider)
 else
  Assert(False);
//#UC END# *B86FD3ED4532_563875050317_impl*
end;//TnsBaseSearchService.RegisterBaseSearcherProvider

procedure TnsBaseSearchService.UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
 const aProvider: InsBaseSearcherProvider);
//#UC START# *CB784FFDCCE4_563875050317_var*
//#UC END# *CB784FFDCCE4_563875050317_var*
begin
//#UC START# *CB784FFDCCE4_563875050317_impl*
 if (f_Alien <> nil) then
  f_Alien.UnregisterBaseSearcherProvider(aContainer, aProvider)
 else
  Assert(False);
//#UC END# *CB784FFDCCE4_563875050317_impl*
end;//TnsBaseSearchService.UnregisterBaseSearcherProvider

class function TnsBaseSearchService.Instance: TnsBaseSearchService;
 {* Метод получения экземпляра синглетона TnsBaseSearchService }
begin
 if (g_TnsBaseSearchService = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchServiceFree);
  g_TnsBaseSearchService := Create;
 end;
 Result := g_TnsBaseSearchService;
end;//TnsBaseSearchService.Instance

class function TnsBaseSearchService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsBaseSearchService <> nil;
end;//TnsBaseSearchService.Exists

procedure TnsBaseSearchService.ClearFields;
begin
 Alien := nil;
 inherited;
end;//TnsBaseSearchService.ClearFields
{$IfEnd} // NOT Defined(Admin)

end.
