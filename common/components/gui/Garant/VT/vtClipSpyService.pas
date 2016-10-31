unit vtClipSpyService;

// ������: "w:\common\components\gui\Garant\VT\vtClipSpyService.pas"
// ���������: "ServiceImplementation"
// ������� ������: "TvtClipSpyService" MUID: (5776300D0270)

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
    {* ������� ������� ����� �������. }
  public
   procedure Subscribe(const aListner: Il3ClipListner);
   procedure Unsubscribe(const aListner: Il3ClipListner);
   class function Instance: TvtClipSpyService;
    {* ����� ��������� ���������� ���������� TvtClipSpyService }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
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
 {* ��������� ���������� TvtClipSpyService }

procedure TvtClipSpyServiceFree;
 {* ����� ������������ ���������� ���������� TvtClipSpyService }
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
 // - ������, ��� ��� ������
//#UC END# *57762C6503A9_5776300D0270_impl*
end;//TvtClipSpyService.Unsubscribe

class function TvtClipSpyService.Instance: TvtClipSpyService;
 {* ����� ��������� ���������� ���������� TvtClipSpyService }
begin
 if (g_TvtClipSpyService = nil) then
 begin
  l3System.AddExitProc(TvtClipSpyServiceFree);
  g_TvtClipSpyService := Create;
 end;
 Result := g_TvtClipSpyService;
end;//TvtClipSpyService.Instance

class function TvtClipSpyService.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TvtClipSpyService <> nil;
end;//TvtClipSpyService.Exists

procedure TvtClipSpyService.Cleanup;
 {* ������� ������� ����� �������. }
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
 {* ����������� TvtClipSpyService }

end.
