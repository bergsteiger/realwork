unit ncsMessageExecutorFactory;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsMessageExecutorFactory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsMessageExecutorFactory" MUID: (54607384020A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ncsExecutorFactoryList
 , ncsMessageInterfaces
 , ncsMessage
;

type
 TncsDisconnectExecutor = {final} class(Tl3ProtoObject, IncsExecutor, IncsMessageExecutorFactory)
  protected
   procedure Execute(const aContext: TncsExecuteContext);
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
 end;//TncsDisconnectExecutor

 TncsMessageExecutorFactory = class(Tl3ProtoObject)
  private
   f_List: TncsExecutorFactoryList;
   f_DisconnectExecutor: TncsDisconnectExecutor;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   procedure Register(const aFactory: IncsMessageExecutorFactory);
   procedure UnRegister(const aFactory: IncsMessageExecutorFactory);
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
   class function Instance: TncsMessageExecutorFactory;
    {* Метод получения экземпляра синглетона TncsMessageExecutorFactory }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TncsMessageExecutorFactory
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Types
 , evdNcsTypes
 , l3Base
 //#UC START# *54607384020Aimpl_uses*
 //#UC END# *54607384020Aimpl_uses*
;

type
 TncsInvalidExecutor = {final} class(Tl3ProtoObject, IncsExecutor)
  protected
   procedure Execute(const aContext: TncsExecuteContext);
  public
   constructor Create; reintroduce;
   class function Make: IncsExecutor; reintroduce;
 end;//TncsInvalidExecutor

var g_TncsMessageExecutorFactory: TncsMessageExecutorFactory = nil;
 {* Экземпляр синглетона TncsMessageExecutorFactory }

procedure TncsMessageExecutorFactoryFree;
 {* Метод освобождения экземпляра синглетона TncsMessageExecutorFactory }
begin
 l3Free(g_TncsMessageExecutorFactory);
end;//TncsMessageExecutorFactoryFree

constructor TncsInvalidExecutor.Create;
//#UC START# *5464A4DE0181_5464A0E40234_var*
//#UC END# *5464A4DE0181_5464A0E40234_var*
begin
//#UC START# *5464A4DE0181_5464A0E40234_impl*
 inherited Create;
//#UC END# *5464A4DE0181_5464A0E40234_impl*
end;//TncsInvalidExecutor.Create

class function TncsInvalidExecutor.Make: IncsExecutor;
var
 l_Inst : TncsInvalidExecutor;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TncsInvalidExecutor.Make

procedure TncsInvalidExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_5464A0E40234_var*
var
 l_Reply: TncsInvalidMessage;
//#UC END# *54607DDC0159_5464A0E40234_var*
begin
//#UC START# *54607DDC0159_5464A0E40234_impl*
 l3System.Msg2Log('Не найден обработчик для ncsMessage (%s)!!', [aContext.rMessage.TaggedData.TagType.AsString]);
 if aContext.rMessage.Kind = ncs_mkMessage then
 begin
  l_Reply := TncsInvalidMessage.Create;
  try
   l_Reply.Kind := ncs_mkReply;
   l_Reply.MessageID := aContext.rMessage.MessageID;
   aContext.rTransporter.Send(l_Reply);
  finally
   FreeANdNil(l_Reply);
  end;
 end;
//#UC END# *54607DDC0159_5464A0E40234_impl*
end;//TncsInvalidExecutor.Execute

procedure TncsDisconnectExecutor.Execute(const aContext: TncsExecuteContext);
//#UC START# *54607DDC0159_547C1FB30097_var*
var
 l_Reply: TncsDisconnectReply;
//#UC END# *54607DDC0159_547C1FB30097_var*
begin
//#UC START# *54607DDC0159_547C1FB30097_impl*
 l_Reply := TncsDisconnectReply.Create(aContext.rMessage);
 try
  aContext.rTransporter.Send(l_Reply);
 finally
  FreeAndNil(l_Reply);
 end;
//#UC END# *54607DDC0159_547C1FB30097_impl*
end;//TncsDisconnectExecutor.Execute

function TncsDisconnectExecutor.MakeExecutor(aMessage: TncsMessage): IncsExecutor;
//#UC START# *546082B801F3_547C1FB30097_var*
//#UC END# *546082B801F3_547C1FB30097_var*
begin
//#UC START# *546082B801F3_547C1FB30097_impl*
 if aMessage is TncsDisconnect then
  Result := Self
 else
  Result := nil;
//#UC END# *546082B801F3_547C1FB30097_impl*
end;//TncsDisconnectExecutor.MakeExecutor

procedure TncsMessageExecutorFactory.Register(const aFactory: IncsMessageExecutorFactory);
//#UC START# *5460830D0295_54607384020A_var*
//#UC END# *5460830D0295_54607384020A_var*
begin
//#UC START# *5460830D0295_54607384020A_impl*
 f_List.Add(aFactory);
//#UC END# *5460830D0295_54607384020A_impl*
end;//TncsMessageExecutorFactory.Register

procedure TncsMessageExecutorFactory.UnRegister(const aFactory: IncsMessageExecutorFactory);
//#UC START# *5460832C0080_54607384020A_var*
//#UC END# *5460832C0080_54607384020A_var*
begin
//#UC START# *5460832C0080_54607384020A_impl*
 f_List.Remove(aFactory);
//#UC END# *5460832C0080_54607384020A_impl*
end;//TncsMessageExecutorFactory.UnRegister

function TncsMessageExecutorFactory.MakeExecutor(aMessage: TncsMessage): IncsExecutor;
//#UC START# *5460AEC800B8_54607384020A_var*
 function DoIt(aFactory: PIncsMessageExecutorFactory; Index: Long): Bool;
 var
  l_Executor: IncsExecutor;
 begin
  l_Executor := aFactory^.MakeExecutor(aMessage);
  if Assigned(l_Executor) then
  begin
   MakeExecutor := l_Executor;
   Result := False;
  end
  else
   Result := True;
 end;
//#UC END# *5460AEC800B8_54607384020A_var*
begin
//#UC START# *5460AEC800B8_54607384020A_impl*
 Result := nil;
 if not (aMessage is TncsInvalidMessage) then
  f_List.IterateAllF(l3L2IA(@DoIt));
 if Result = nil then
  Result := TncsInvalidExecutor.Make
//#UC END# *5460AEC800B8_54607384020A_impl*
end;//TncsMessageExecutorFactory.MakeExecutor

class function TncsMessageExecutorFactory.Instance: TncsMessageExecutorFactory;
 {* Метод получения экземпляра синглетона TncsMessageExecutorFactory }
begin
 if (g_TncsMessageExecutorFactory = nil) then
 begin
  l3System.AddExitProc(TncsMessageExecutorFactoryFree);
  g_TncsMessageExecutorFactory := Create;
 end;
 Result := g_TncsMessageExecutorFactory;
end;//TncsMessageExecutorFactory.Instance

class function TncsMessageExecutorFactory.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TncsMessageExecutorFactory <> nil;
end;//TncsMessageExecutorFactory.Exists

procedure TncsMessageExecutorFactory.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_54607384020A_var*
//#UC END# *479731C50290_54607384020A_var*
begin
//#UC START# *479731C50290_54607384020A_impl*
 Unregister(f_DisconnectExecutor);
 FreeAndNil(f_DisconnectExecutor);
 Assert(f_List.Count = 0);
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_54607384020A_impl*
end;//TncsMessageExecutorFactory.Cleanup

procedure TncsMessageExecutorFactory.InitFields;
//#UC START# *47A042E100E2_54607384020A_var*
//#UC END# *47A042E100E2_54607384020A_var*
begin
//#UC START# *47A042E100E2_54607384020A_impl*
 inherited;
 f_List := TncsExecutorFactoryList.Create;
 f_DisconnectExecutor := TncsDisconnectExecutor.Create;
 Register(f_DisconnectExecutor);
//#UC END# *47A042E100E2_54607384020A_impl*
end;//TncsMessageExecutorFactory.InitFields
{$IfEnd} // NOT Defined(Nemesis)

end.
