unit nsContextFilterEventListener;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Logging\nsContextFilterEventListener.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsContextFilterEventListener" MUID: (4B1660B9000D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsLogEvent
 {$If Defined(Nemesis)}
 , nscNewInterfaces
 {$IfEnd} // Defined(Nemesis)
 , nsContextFilterEventDataList
 , l3Interfaces
;

type
 TnsContextFilterEventListener = {final} class(TnsLogEvent{$If Defined(Nemesis)}
 , InscContextFilterListener
 {$IfEnd} // Defined(Nemesis)
 )
  private
   f_List: TnsContextFilterEventDataList;
  protected
   {$If Defined(Nemesis)}
   procedure ContextCanBeChanged(aHandle: Integer;
    const aFilterName: Il3CString;
    const aState: InscContextFilterState);
    {* событие возможной смены контекста. Генерируется при уходе фокуса из
             поля ввода и уничтожении компонента }
   {$IfEnd} // Defined(Nemesis)
   {$If Defined(Nemesis)}
   procedure FilterRemoving(aHandle: Integer);
   {$IfEnd} // Defined(Nemesis)
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class function Instance: TnsContextFilterEventListener;
    {* Метод получения экземпляра синглетона TnsContextFilterEventListener }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsContextFilterEventListener

implementation

uses
 l3ImplUses
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , LoggingUnit
 , l3String
 , SysUtils
 , nsTypes
 , l3Base
 , nsLogEventData
 , nsLogManager
 , LoggingWrapperInterfaces
 //#UC START# *4B1660B9000Dimpl_uses*
 //#UC END# *4B1660B9000Dimpl_uses*
;

var g_TnsContextFilterEventListener: TnsContextFilterEventListener = nil;
 {* Экземпляр синглетона TnsContextFilterEventListener }

procedure TnsContextFilterEventListenerFree;
 {* Метод освобождения экземпляра синглетона TnsContextFilterEventListener }
begin
 l3Free(g_TnsContextFilterEventListener);
end;//TnsContextFilterEventListenerFree

constructor TnsContextFilterEventListener.Create;
//#UC START# *4B1661450093_4B1660B9000D_var*
//#UC END# *4B1661450093_4B1660B9000D_var*
begin
//#UC START# *4B1661450093_4B1660B9000D_impl*
 inherited Create;
 f_List := TnsContextFilterEventDataList.Create;
 f_List.Sorted := True;
 nscAddContextFilterListener(Self);
//#UC END# *4B1661450093_4B1660B9000D_impl*
end;//TnsContextFilterEventListener.Create

{$If Defined(Nemesis)}
procedure TnsContextFilterEventListener.ContextCanBeChanged(aHandle: Integer;
 const aFilterName: Il3CString;
 const aState: InscContextFilterState);
 {* событие возможной смены контекста. Генерируется при уходе фокуса из
             поля ввода и уничтожении компонента }
//#UC START# *490839BA0073_4B1660B9000D_var*
var
 l_Data: InsLogEventData;

 function lp_IsNeedRegister: Boolean;
 var
  l_C : TnsContextFilterData;
  l_Index : Integer;
 begin
  Result := aState.Active;
  if Result then
  begin
   l_C := TnsContextFilterData_C(aHandle, aState.Context);
   l_Index := f_List.IndexOf(l_C);
   if l_Index < 0 then
    l_Index := f_List.Add(l_C)
   else
    Result := not l3Same(l_C.rContext, f_List[l_Index].rContext);
   f_List[l_Index] := l_C;
  end;
 end;//lp_IsNeedRegister


//#UC END# *490839BA0073_4B1660B9000D_var*
begin
//#UC START# *490839BA0073_4B1660B9000D_impl*
 if lp_IsNeedRegister then
 begin
  l_Data := MakeParamsList;
  l_Data.AddString(nsAStr(aState.Context).S);
  l_Data.AddString(nsAStr(aFilterName).S);
  GetLogger.AddEvent(LE_CONTEXT_FILTER_IN_TREE, l_Data);
 end;
//#UC END# *490839BA0073_4B1660B9000D_impl*
end;//TnsContextFilterEventListener.ContextCanBeChanged
{$IfEnd} // Defined(Nemesis)

{$If Defined(Nemesis)}
procedure TnsContextFilterEventListener.FilterRemoving(aHandle: Integer);
//#UC START# *4B165B44032D_4B1660B9000D_var*
var
 l_C : TnsContextFilterData;
//#UC END# *4B165B44032D_4B1660B9000D_var*
begin
//#UC START# *4B165B44032D_4B1660B9000D_impl*
 l_C := TnsContextFilterData_C(aHandle, nil);
 f_List.Remove(l_C);
//#UC END# *4B165B44032D_4B1660B9000D_impl*
end;//TnsContextFilterEventListener.FilterRemoving
{$IfEnd} // Defined(Nemesis)

class function TnsContextFilterEventListener.Instance: TnsContextFilterEventListener;
 {* Метод получения экземпляра синглетона TnsContextFilterEventListener }
begin
 if (g_TnsContextFilterEventListener = nil) then
 begin
  l3System.AddExitProc(TnsContextFilterEventListenerFree);
  g_TnsContextFilterEventListener := Create;
 end;
 Result := g_TnsContextFilterEventListener;
end;//TnsContextFilterEventListener.Instance

class function TnsContextFilterEventListener.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsContextFilterEventListener <> nil;
end;//TnsContextFilterEventListener.Exists

procedure TnsContextFilterEventListener.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4B1660B9000D_var*
//#UC END# *479731C50290_4B1660B9000D_var*
begin
//#UC START# *479731C50290_4B1660B9000D_impl*
 nscRemoveContextFilterListener(Self);
 FreeAndNil(f_List);
 inherited Cleanup;
//#UC END# *479731C50290_4B1660B9000D_impl*
end;//TnsContextFilterEventListener.Cleanup

end.
