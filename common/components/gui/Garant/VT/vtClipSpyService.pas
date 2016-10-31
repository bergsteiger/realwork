unit vtClipSpyService;

// Модуль: "w:\common\components\gui\Garant\VT\vtClipSpyService.pas"
// Стереотип: "ServiceImplementation"
// Элемент модели: "TvtClipSpyService" MUID: (5776300D0270)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , l3ClipSpyService
 , vtClipSpy
 , l3ClipboardSpy
;

type
 TvtClipSpyService = {final} class(Tl3ProtoObject, Il3ClipSpyService)
  private
   f_ClipSpyWnd: TClipSpyWnd;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure Subscribe(const aListner: Il3ClipListner);
   procedure Unsubscribe(const aListner: Il3ClipListner);
   class function Instance: TvtClipSpyService;
    {* Метод получения экземпляра синглетона TvtClipSpyService }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TvtClipSpyService

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 //#UC START# *5776300D0270impl_uses*
 //#UC END# *5776300D0270impl_uses*
;

var g_TvtClipSpyService: TvtClipSpyService = nil;
 {* Экземпляр синглетона TvtClipSpyService }

procedure TvtClipSpyServiceFree;
 {* Метод освобождения экземпляра синглетона TvtClipSpyService }
begin
 l3Free(g_TvtClipSpyService);
end;//TvtClipSpyServiceFree

procedure TvtClipSpyService.Subscribe(const aListner: Il3ClipListner);
//#UC START# *57762C370191_5776300D0270_var*
//#UC END# *57762C370191_5776300D0270_var*
begin
//#UC START# *57762C370191_5776300D0270_impl*
 if f_ClipSpyWnd = nil then
  f_ClipSpyWnd := TClipSpyWnd.Create(nil);
 f_ClipSpyWnd.Subscribe(aListner);
//#UC END# *57762C370191_5776300D0270_impl*
end;//TvtClipSpyService.Subscribe

procedure TvtClipSpyService.Unsubscribe(const aListner: Il3ClipListner);
//#UC START# *57762C6503A9_5776300D0270_var*
//#UC END# *57762C6503A9_5776300D0270_var*
begin
//#UC START# *57762C6503A9_5776300D0270_impl*
 if f_ClipSpyWnd = nil then Exit;
 f_ClipSpyWnd.Unsubscribe(aListner);
 //FreeAndNil(f_ClipSpyWnd);
 // - похоже, что это ошибка
//#UC END# *57762C6503A9_5776300D0270_impl*
end;//TvtClipSpyService.Unsubscribe

class function TvtClipSpyService.Instance: TvtClipSpyService;
 {* Метод получения экземпляра синглетона TvtClipSpyService }
begin
 if (g_TvtClipSpyService = nil) then
 begin
  l3System.AddExitProc(TvtClipSpyServiceFree);
  g_TvtClipSpyService := Create;
 end;
 Result := g_TvtClipSpyService;
end;//TvtClipSpyService.Instance

class function TvtClipSpyService.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvtClipSpyService <> nil;
end;//TvtClipSpyService.Exists

procedure TvtClipSpyService.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_5776300D0270_var*
//#UC END# *479731C50290_5776300D0270_var*
begin
//#UC START# *479731C50290_5776300D0270_impl*
 FreeAndNil(f_ClipSpyWnd);
 inherited;
//#UC END# *479731C50290_5776300D0270_impl*
end;//TvtClipSpyService.Cleanup

initialization
 Tl3ClipSpyService.Instance.Alien := TvtClipSpyService.Instance;
 {* Регистрация TvtClipSpyService }

end.
