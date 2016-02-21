unit ncsServerTransporterPtrPool;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsServerTransporterPtrPool.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsServerTransporterPtrList
 , ncsMessageInterfaces
 , SyncObjs
;

type
 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TncsServerTransporterPtrPool = class(_l3CriticalSectionHolder_)
  private
   f_Data: TncsServerTransporterPtrList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Register(const aTransporter: IncsServerTransporter);
   procedure UnRegister(const aTransporter: IncsServerTransporter);
   function FindTransporter(const aSessionID: AnsiString): IncsServerTransporter;
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TncsServerTransporterPtrPool;
    {* Метод получения экземпляра синглетона TncsServerTransporterPtrPool }
 end;//TncsServerTransporterPtrPool
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TncsServerTransporterPtrPool: TncsServerTransporterPtrPool = nil;
 {* Экземпляр синглетона TncsServerTransporterPtrPool }

procedure TncsServerTransporterPtrPoolFree;
 {* Метод освобождения экземпляра синглетона TncsServerTransporterPtrPool }
begin
 l3Free(g_TncsServerTransporterPtrPool);
end;//TncsServerTransporterPtrPoolFree

{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

procedure TncsServerTransporterPtrPool.Register(const aTransporter: IncsServerTransporter);
//#UC START# *5492D83203D7_54917FF702A4_var*
//#UC END# *5492D83203D7_54917FF702A4_var*
begin
//#UC START# *5492D83203D7_54917FF702A4_impl*
 Lock;
 try
  if f_Data.IndexOf(aTransporter) = -1 then
   f_Data.Add(aTransporter);
 finally
  Unlock;
 end;
//#UC END# *5492D83203D7_54917FF702A4_impl*
end;//TncsServerTransporterPtrPool.Register

procedure TncsServerTransporterPtrPool.UnRegister(const aTransporter: IncsServerTransporter);
//#UC START# *5492D8470118_54917FF702A4_var*
//#UC END# *5492D8470118_54917FF702A4_var*
begin
//#UC START# *5492D8470118_54917FF702A4_impl*
 Lock;
 try
  f_Data.Remove(aTransporter);
 finally
  Unlock;
 end;
//#UC END# *5492D8470118_54917FF702A4_impl*
end;//TncsServerTransporterPtrPool.UnRegister

function TncsServerTransporterPtrPool.FindTransporter(const aSessionID: AnsiString): IncsServerTransporter;
//#UC START# *5492D85A0389_54917FF702A4_var*
var
 l_IDX: Integer;
//#UC END# *5492D85A0389_54917FF702A4_var*
begin
//#UC START# *5492D85A0389_54917FF702A4_impl*
 Result := nil;
 for l_IDX := 0 to f_Data.Count - 1 do
  if f_Data[l_IDX].SessionID = aSessionID then
  begin
   Result := f_Data[l_IDX];
   Break;
  end;
//#UC END# *5492D85A0389_54917FF702A4_impl*
end;//TncsServerTransporterPtrPool.FindTransporter

class function TncsServerTransporterPtrPool.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TncsServerTransporterPtrPool <> nil;
end;//TncsServerTransporterPtrPool.Exists

class function TncsServerTransporterPtrPool.Instance: TncsServerTransporterPtrPool;
 {* Метод получения экземпляра синглетона TncsServerTransporterPtrPool }
begin
 if (g_TncsServerTransporterPtrPool = nil) then
 begin
  l3System.AddExitProc(TncsServerTransporterPtrPoolFree);
  g_TncsServerTransporterPtrPool := Create;
 end;
 Result := g_TncsServerTransporterPtrPool;
end;//TncsServerTransporterPtrPool.Instance

procedure TncsServerTransporterPtrPool.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54917FF702A4_var*
//#UC END# *479731C50290_54917FF702A4_var*
begin
//#UC START# *479731C50290_54917FF702A4_impl*
 FreeAndNil(f_Data);
 inherited;
//#UC END# *479731C50290_54917FF702A4_impl*
end;//TncsServerTransporterPtrPool.Cleanup

procedure TncsServerTransporterPtrPool.InitFields;
//#UC START# *47A042E100E2_54917FF702A4_var*
//#UC END# *47A042E100E2_54917FF702A4_var*
begin
//#UC START# *47A042E100E2_54917FF702A4_impl*
 inherited;
 f_Data := TncsServerTransporterPtrList.Make;
//#UC END# *47A042E100E2_54917FF702A4_impl*
end;//TncsServerTransporterPtrPool.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
