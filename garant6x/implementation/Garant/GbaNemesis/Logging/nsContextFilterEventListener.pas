unit nsContextFilterEventListener;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Logging"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Logging/nsContextFilterEventListener.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Базовые определения предметной области::LegalDomain::Logging::Logging::TnsContextFilterEventListener
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If defined(Nemesis)}
  ,
  nscNewInterfaces
  {$IfEnd} //Nemesis
  ,
  nsLogEvent,
  nsContextFilterEventDataList,
  l3Interfaces
  ;

type
 TnsContextFilterEventListener = {final} class(TnsLogEvent {$If defined(Nemesis)}, InscContextFilterListener{$IfEnd} //Nemesis
 )
 private
 // private fields
   f_List : TnsContextFilterEventDataList;
 protected
 // realized methods
   {$If defined(Nemesis)}
   procedure ContextCanBeChanged(aHandle: Integer;
    const aFilterName: Il3CString;
    const aState: InscContextFilterState);
     {* событие возможной смены контекста. Генерируется при уходе фокуса из
             поля ввода и уничтожении компонента }
   {$IfEnd} //Nemesis
   {$If defined(Nemesis)}
   procedure FilterRemoving(aHandle: Integer);
   {$IfEnd} //Nemesis
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create; reintroduce;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TnsContextFilterEventListener;
    {- возвращает экземпляр синглетона. }
 end;//TnsContextFilterEventListener

implementation

uses
  l3Base {a}
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  LoggingUnit,
  l3String,
  SysUtils,
  nsTypes,
  nsLogEventData,
  nsLogManager,
  LoggingWrapperInterfaces
  ;


// start class TnsContextFilterEventListener

var g_TnsContextFilterEventListener : TnsContextFilterEventListener = nil;

procedure TnsContextFilterEventListenerFree;
begin
 l3Free(g_TnsContextFilterEventListener);
end;

class function TnsContextFilterEventListener.Instance: TnsContextFilterEventListener;
begin
 if (g_TnsContextFilterEventListener = nil) then
 begin
  l3System.AddExitProc(TnsContextFilterEventListenerFree);
  g_TnsContextFilterEventListener := Create;
 end;
 Result := g_TnsContextFilterEventListener;
end;


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

class function TnsContextFilterEventListener.Exists: Boolean;
 {-}
begin
 Result := g_TnsContextFilterEventListener <> nil;
end;//TnsContextFilterEventListener.Exists

{$If defined(Nemesis)}
procedure TnsContextFilterEventListener.ContextCanBeChanged(aHandle: Integer;
  const aFilterName: Il3CString;
  const aState: InscContextFilterState);
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
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
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
{$IfEnd} //Nemesis

procedure TnsContextFilterEventListener.Cleanup;
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