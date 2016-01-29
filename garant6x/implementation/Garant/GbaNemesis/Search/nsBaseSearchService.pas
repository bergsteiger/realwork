unit nsBaseSearchService;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Search"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Search/nsBaseSearchService.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Service::Class>> F1 Common For Shell And Monitoring::Search::Search::SearchServices::TnsBaseSearchService
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject,
  BaseSearchInterfaces
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}
(*
 MnsBaseSearchService = PureMixIn
  {* Контракт сервиса TnsBaseSearchService }
   function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
   procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
 end;//MnsBaseSearchService
*)

type
 InsBaseSearchService = interface(IUnknown)
  {* Интерфейс сервиса TnsBaseSearchService }
   ['{40B734EB-B07C-49D2-B51A-EC2A0B80C837}']
  // MnsBaseSearchService
   function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
   procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
   procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
    const aProvider: InsBaseSearcherProvider);
 end;//InsBaseSearchService

 TnsBaseSearchService = {final} class(Tl3ProtoObject)
 private
 // private fields
   f_Alien : InsBaseSearchService;
    {* Поле для свойства Alien}
 protected
 // property methods
   procedure pm_SetAlien(const aValue: InsBaseSearchService);
 public
 // realized methods
   function GetBaseSearcher(const aEntityForm: IvcmEntityForm): InsBaseSearcher;
   procedure RegisterBaseSearcherProvider(const aContainer: IvcmContainer;
     const aProvider: InsBaseSearcherProvider);
   procedure UnregisterBaseSearcherProvider(const aContainer: IvcmContainer;
     const aProvider: InsBaseSearcherProvider);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // public properties
   property Alien: InsBaseSearchService
     write pm_SetAlien;
     {* Внешняя реализация сервиса InsBaseSearchService }
 public
 // singleton factory method
   class function Instance: TnsBaseSearchService;
    {- возвращает экземпляр синглетона. }
 end;//TnsBaseSearchService
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a}
  ;
{$IfEnd} //not Admin

{$If not defined(Admin)}


// start class TnsBaseSearchService

var g_TnsBaseSearchService : TnsBaseSearchService = nil;

procedure TnsBaseSearchServiceFree;
begin
 l3Free(g_TnsBaseSearchService);
end;

class function TnsBaseSearchService.Instance: TnsBaseSearchService;
begin
 if (g_TnsBaseSearchService = nil) then
 begin
  l3System.AddExitProc(TnsBaseSearchServiceFree);
  g_TnsBaseSearchService := Create;
 end;
 Result := g_TnsBaseSearchService;
end;


procedure TnsBaseSearchService.pm_SetAlien(const aValue: InsBaseSearchService);
 {-}
begin
 Assert((f_Alien = nil) OR (aValue = nil));
 f_Alien := aValue;
end;//TnsBaseSearchService.pm_SetAlien

class function TnsBaseSearchService.Exists: Boolean;
 {-}
begin
 Result := g_TnsBaseSearchService <> nil;
end;//TnsBaseSearchService.Exists

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

procedure TnsBaseSearchService.ClearFields;
 {-}
begin
 {$If not defined(Admin)}
 Alien := nil;
 {$IfEnd} //not Admin
 inherited;
end;//TnsBaseSearchService.ClearFields

{$IfEnd} //not Admin

end.