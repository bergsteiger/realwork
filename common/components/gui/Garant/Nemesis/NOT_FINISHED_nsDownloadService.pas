unit NOT_FINISHED_nsDownloadService;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nsDownloadService.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDownloadService" MUID: (57BC069B0211)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TnsDownloadService = {final} class
  public
   procedure DownloadFile(const aURL: AnsiString); virtual;
   class function Instance: TnsDownloadService;
    {* Метод получения экземпляра синглетона TnsDownloadService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsDownloadService
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , nsAsyncDownloaderList
 , nsDownloadProgressDialogList
 , SysUtils
 , l3Base
 //#UC START# *57BC069B0211impl_uses*
 //#UC END# *57BC069B0211impl_uses*
;

var g_TnsDownloadService: TnsDownloadService = nil;
 {* Экземпляр синглетона TnsDownloadService }

procedure TnsDownloadServiceFree;
 {* Метод освобождения экземпляра синглетона TnsDownloadService }
begin
 l3Free(g_TnsDownloadService);
end;//TnsDownloadServiceFree

procedure TnsDownloadService.DownloadFile(const aURL: AnsiString);
//#UC START# *57BC06C50099_57BC069B0211_var*
//#UC END# *57BC06C50099_57BC069B0211_var*
begin
//#UC START# *57BC06C50099_57BC069B0211_impl*
 !!! Needs to be implemented !!!
//#UC END# *57BC06C50099_57BC069B0211_impl*
end;//TnsDownloadService.DownloadFile

class function TnsDownloadService.Instance: TnsDownloadService;
 {* Метод получения экземпляра синглетона TnsDownloadService }
begin
 if (g_TnsDownloadService = nil) then
 begin
  l3System.AddExitProc(TnsDownloadServiceFree);
  g_TnsDownloadService := Create;
 end;
 Result := g_TnsDownloadService;
end;//TnsDownloadService.Instance

class function TnsDownloadService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsDownloadService <> nil;
end;//TnsDownloadService.Exists
{$IfEnd} // Defined(Nemesis)

end.
