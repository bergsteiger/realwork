unit ncsServerTransporterPtrPool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsServerTransporterPtrPool.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Messages::TncsServerTransporterPtrPool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3ProtoObject,
  ncsMessageInterfaces,
  ncsServerTransporterPtrList,
  SyncObjs
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _l3CriticalSectionHolder_Parent_ = Tl3ProtoObject;
 {$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}
 TncsServerTransporterPtrPool = class(_l3CriticalSectionHolder_)
 private
 // private fields
   f_Data : TncsServerTransporterPtrList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   procedure Register(const aTransporter: IncsServerTransporter);
   procedure UnRegister(const aTransporter: IncsServerTransporter);
   function FindTransporter(const aSessionID: AnsiString): IncsServerTransporter;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TncsServerTransporterPtrPool;
    {- возвращает экземпляр синглетона. }
 end;//TncsServerTransporterPtrPool
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TncsServerTransporterPtrPool

var g_TncsServerTransporterPtrPool : TncsServerTransporterPtrPool = nil;

procedure TncsServerTransporterPtrPoolFree;
begin
 l3Free(g_TncsServerTransporterPtrPool);
end;

class function TncsServerTransporterPtrPool.Instance: TncsServerTransporterPtrPool;
begin
 if (g_TncsServerTransporterPtrPool = nil) then
 begin
  l3System.AddExitProc(TncsServerTransporterPtrPoolFree);
  g_TncsServerTransporterPtrPool := Create;
 end;
 Result := g_TncsServerTransporterPtrPool;
end;


{$Include w:\common\components\rtl\Garant\L3\l3CriticalSectionHolder.imp.pas}

// start class TncsServerTransporterPtrPool

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
 {-}
begin
 Result := g_TncsServerTransporterPtrPool <> nil;
end;//TncsServerTransporterPtrPool.Exists

procedure TncsServerTransporterPtrPool.Cleanup;
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

{$IfEnd} //not Nemesis

end.