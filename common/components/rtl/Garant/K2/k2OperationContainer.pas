unit k2OperationContainer;

// Модуль: "w:\common\components\rtl\Garant\K2\k2OperationContainer.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2OperationContainer" MUID: (47E3C78502FB)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2OpRefList
 , k2Prim
 , l3Variant
 , k2Op
;

type
 Tk2OperationContainer = class;

 Ik2OpPackInternal = interface
  {* "Кишки" пачки операций. }
  ['{C958785E-8F8A-495C-9B19-3B0F3AABB53B}']
  procedure Put(Op: Tk2Op;
   Modify: Boolean);
   {* положить операцию. }
 end;//Ik2OpPackInternal

 Tk2OperationContainer = class(Tk2OpRefList, Ik2OpPackInternal, Il3OpPack)
  private
   f_Owner: TObject;
   f_Mode: Pointer;
   f_Code: Integer;
  private
   procedure FreeInOwner;
  protected
   function GetSaveUndo: Boolean; virtual;
   function GetNeedOptimize: Boolean; virtual;
   function DoUndo(const aProcessor: Ik2Processor): Integer; virtual;
   function DoRedo(const aProcessor: Ik2Processor): Integer; virtual;
   procedure Add(anItem: Tk2Op); virtual;
   procedure DoSetOwner(Value: TObject);
    {* метод для установки "владельца" объекта. Для перекрытия в потомках. }
   procedure MarkModified(aTarget: Tl3Variant);
   procedure InvertModified;
   function GetModified: Boolean;
   function Get_InUndo: Boolean;
   function Get_SaveUndo: Boolean;
   procedure Set_SaveUndo(aValue: Boolean);
   function pm_GetDeleteMapped: Boolean;
   procedure pm_SetDeleteMapped(aValue: Boolean);
   function pm_GetOptimize: Boolean;
   procedure pm_SetOptimize(aValue: Boolean);
   function pm_GetInIOProcess: Boolean;
   procedure pm_SetInIOProcess(aValue: Boolean);
   function pm_GetProcessor: Ik2Processor;
   function Undo(const aProcessor: Ik2Processor): Integer;
    {* откатывает все операции и возвращает их количество. }
   function Redo(const aProcessor: Ik2Processor): Integer;
    {* возвращает все операции и возвращает их количество. }
   procedure Lock;
    {* закрыть. }
   procedure Unlock;
    {* открыть. }
   function Get_Code: Integer;
   procedure Put(Op: Tk2Op;
    Modify: Boolean);
    {* положить операцию. }
   procedure CheckReadOnly;
   procedure DisableReadonly;
    {* Выключает режим проверки ReadOnly }
   procedure EnableReadOnly;
    {* Включает режим проверки ReadOnly }
   procedure pm_SetReadOnly(aValue: Boolean);
   procedure CheckOn;
   procedure CheckOff;
   function IsCheckOff: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure BeforeFree; override;
    {* функция, вызываемая при каждом уменьшении счетчика ссылок на 1. Вернув false может запретить уничтожение объекта. }
  public
   class function CheckWasExceptionInFreeInOwner: Boolean;
    {* Проверяет было ли исключение FreeInOwner и сбрасывает этот флаг }
   constructor Create(anOwner: TObject); reintroduce; virtual;
  public
   property Code: Integer
    read f_Code
    write f_Code;
 end;//Tk2OperationContainer

implementation

uses
 l3ImplUses
 , l3StringIDEx
 , SysUtils
 , l3Types
 , l3IntegerValueMapManager
 , l3Base
 , l3Const
 , l3Interfaces
 , k2NilOp
 //#UC START# *47E3C78502FBimpl_uses*
 //#UC END# *47E3C78502FBimpl_uses*
;

var g_WasExceptionInFreeInOwner: Boolean = False;
 {* Было ли исключение в методе FreeInOwner }

const
 {* Локализуемые строки Local }
 str_l3mmUndo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmUndo'; rValue : 'Откат');
  {* 'Откат' }
 str_l3mmRedo: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'l3mmRedo'; rValue : 'Возврат');
  {* 'Возврат' }

class function Tk2OperationContainer.CheckWasExceptionInFreeInOwner: Boolean;
 {* Проверяет было ли исключение FreeInOwner и сбрасывает этот флаг }
//#UC START# *4C1A312002E3_47E3C78502FB_var*
//#UC END# *4C1A312002E3_47E3C78502FB_var*
begin
//#UC START# *4C1A312002E3_47E3C78502FB_impl*
 Result := g_WasExceptionInFreeInOwner;
 g_WasExceptionInFreeInOwner := false;
//#UC END# *4C1A312002E3_47E3C78502FB_impl*
end;//Tk2OperationContainer.CheckWasExceptionInFreeInOwner

function Tk2OperationContainer.GetSaveUndo: Boolean;
//#UC START# *4E7AF07603D9_47E3C78502FB_var*
//#UC END# *4E7AF07603D9_47E3C78502FB_var*
begin
//#UC START# *4E7AF07603D9_47E3C78502FB_impl*
 if (f_Mode = nil) then
  Result := true
 else
  Result := Il3OpPackMode(f_Mode).SaveUndo;
//#UC END# *4E7AF07603D9_47E3C78502FB_impl*
end;//Tk2OperationContainer.GetSaveUndo

function Tk2OperationContainer.GetNeedOptimize: Boolean;
//#UC START# *531075A60396_47E3C78502FB_var*
//#UC END# *531075A60396_47E3C78502FB_var*
begin
//#UC START# *531075A60396_47E3C78502FB_impl*
 if (f_Mode = nil) then
  Result := true
 else
  Result := Il3OpPackMode(f_Mode).Optimize;
//#UC END# *531075A60396_47E3C78502FB_impl*
end;//Tk2OperationContainer.GetNeedOptimize

function Tk2OperationContainer.DoUndo(const aProcessor: Ik2Processor): Integer;
//#UC START# *48AC2A7C0229_47E3C78502FB_var*

 function _OUndoOp(Op: PObject; Index: Integer): Boolean; 
 begin{_UndoOp}
  Result := true;
  Tk2Op(Op^).Undo(Self);
 end;{_UndoOp}

var
 DoUndoResult : Integer absolute Result;
 Indicator    : Il3Progress;

 function _OUndoOpEx(Op: PObject; Index: Integer): Boolean; 
 begin{_UndoOp}
  Result := true;
  Tk2Op(Op^).Undo(Self);
  if (Index mod 100 = 0) then
   Indicator.Progress(Pred(DoUndoResult) - Index);
 end;{_UndoOp}

//#UC END# *48AC2A7C0229_47E3C78502FB_var*
begin
//#UC START# *48AC2A7C0229_47E3C78502FB_impl*
 Result := Count;
 if (Result <= 0) then Exit;
 if (Result >= 200) then
  QueryInterface(Il3Progress, Indicator);
 try
  Set_SaveUndo(false);
  if Assigned(Indicator) then
  begin
   Indicator.Start(Pred(Result), str_l3mmUndo.AsCStr);
   try
    IterateBackF(Pred(Result), 0, l3L2IA(@_OUndoOpEx));
   finally
    Indicator.Finish;
   end;{try..finally}
  end//Assigned(Indicator)
  else
   IterateBackF(Pred(Result), 0, l3L2IA(@_OUndoOp));
 finally
  Indicator := nil;
 end;{try..finally}
//#UC END# *48AC2A7C0229_47E3C78502FB_impl*
end;//Tk2OperationContainer.DoUndo

function Tk2OperationContainer.DoRedo(const aProcessor: Ik2Processor): Integer;
//#UC START# *48AC2A8C0035_47E3C78502FB_var*

 function _ORedoOp(Op: PObject; Index: Integer): Boolean; 
 begin{_UndoOp}
  Result := true;
  Tk2Op(Op^).Redo(Self);
 end;{_UndoOp}

var
 Indicator: Il3Progress;

 function _ORedoOpEx(Op: PObject; Index: Integer): Boolean; 
 begin{_UndoOp}
  Result := true;
  Tk2Op(Op^).Redo(Self);
  if (Index mod 100 = 0) then
   Indicator.Progress(Index);
 end;{_UndoOp}

//#UC END# *48AC2A8C0035_47E3C78502FB_var*
begin
//#UC START# *48AC2A8C0035_47E3C78502FB_impl*
 Result := Count;
 if (Result >= 200) then
  QueryInterface(Il3Progress, Indicator);
 try
  Set_SaveUndo(false);
  if Assigned(Indicator) then
  begin
   Indicator.Start(Pred(Result), str_l3mmRedo.AsCStr);
   try
    IterateAllF(l3L2IA(@_ORedoOpEx));
   finally
    Indicator.Finish;
   end;{try..finally}
  end//Assigned(Indicator)
  else
   IterateAllF(l3L2IA(@_ORedoOp));
 finally
  Indicator := nil;
 end;{try..finally}
//#UC END# *48AC2A8C0035_47E3C78502FB_impl*
end;//Tk2OperationContainer.DoRedo

procedure Tk2OperationContainer.FreeInOwner;
//#UC START# *48B2C0CA034B_47E3C78502FB_var*
var
 l_Processor : Ik2Processor;
//#UC END# *48B2C0CA034B_47E3C78502FB_var*
begin
//#UC START# *48B2C0CA034B_47E3C78502FB_impl*
 if (f_Mode <> nil) then
 begin
  l_Processor := Il3OpPackMode(f_Mode).Processor;
  if (l_Processor <> nil) then
   try
    try
     l_Processor.FinishOp(Self);
    except
     // - не позволяем падать, т.к. иначе - объект не освободится
     on El3NewOperation do
     begin
      raise;
     end;//on El3NewOperation
     else
     begin
      g_WasExceptionInFreeInOwner := true;
      // - ставим флажок для тестов (в частности)
      // http://mdp.garant.ru/pages/viewpage.action?pageId=218464444
     end;//else 
    end;//try..except
   finally
    l_Processor := nil;
   end;//try..finally
 end;//f_Mode <> nil
//#UC END# *48B2C0CA034B_47E3C78502FB_impl*
end;//Tk2OperationContainer.FreeInOwner

procedure Tk2OperationContainer.Add(anItem: Tk2Op);
//#UC START# *48B2C3ED01BB_47E3C78502FB_var*
var
 Res : Integer;
//#UC END# *48B2C3ED01BB_47E3C78502FB_var*
begin
//#UC START# *48B2C3ED01BB_47E3C78502FB_impl*
 if (Count = 0) then
  inherited Add(anItem)
 else
 begin
  try
   Res := Items[Hi].JoinWith(anItem);
   if (Res < 0) then
    inherited Add(anItem)
   else
   begin
    if (Res = l3NilLong) then
     DeleteLast;
   end;//Res < 0
  except
   on E : El3NewOperation do
   begin
    if (E.Op = Tk2NilOp.Instance) then
    begin
     DeleteLast;
    end//E.Op = Tk2NilOp.Instance
    else
    begin
     Items[Hi] := E.Op;
    end;//E.Op = Tk2NilOp.Instance
    l3Free(E.Op);
   end;//El3NewOperation
  end;//try..except
 end;//Count = 0
//#UC END# *48B2C3ED01BB_47E3C78502FB_impl*
end;//Tk2OperationContainer.Add

constructor Tk2OperationContainer.Create(anOwner: TObject);
//#UC START# *4DD3EB5A01C3_47E3C78502FB_var*
//#UC END# *4DD3EB5A01C3_47E3C78502FB_var*
begin
//#UC START# *4DD3EB5A01C3_47E3C78502FB_impl*
 inherited Create;
 DoSetOwner(anOwner);
//#UC END# *4DD3EB5A01C3_47E3C78502FB_impl*
end;//Tk2OperationContainer.Create

procedure Tk2OperationContainer.DoSetOwner(Value: TObject);
 {* метод для установки "владельца" объекта. Для перекрытия в потомках. }
//#UC START# *4A60A2CF0329_47E3C78502FB_var*
var
 l_M : Il3OpPackMode;
//#UC END# *4A60A2CF0329_47E3C78502FB_var*
begin
//#UC START# *4A60A2CF0329_47E3C78502FB_impl*
 f_Mode := nil;
 if (Value = nil) then
  f_Owner := nil
 else
 if not Supports(Value, Il3OpPackMode, l_M) then
  Assert(false)
 else
 begin
  f_Owner := Value;
  f_Mode := Pointer(l_M);
 end;//not Supports(Value, Il3OpPackMode, l_M)
//#UC END# *4A60A2CF0329_47E3C78502FB_impl*
end;//Tk2OperationContainer.DoSetOwner

procedure Tk2OperationContainer.MarkModified(aTarget: Tl3Variant);
//#UC START# *46A5CE3E009A_47E3C78502FB_var*
//#UC END# *46A5CE3E009A_47E3C78502FB_var*
begin
//#UC START# *46A5CE3E009A_47E3C78502FB_impl*
 if (Self <> nil) then
  if (f_Mode <> nil) then
  begin
   if Get_SaveUndo AND not Get_InUndo then
    Il3OpPackMode(f_Mode).MarkModified(aTarget);
  end;//f_Mode <> nil
//#UC END# *46A5CE3E009A_47E3C78502FB_impl*
end;//Tk2OperationContainer.MarkModified

procedure Tk2OperationContainer.InvertModified;
//#UC START# *46A5CE5C0057_47E3C78502FB_var*
//#UC END# *46A5CE5C0057_47E3C78502FB_var*
begin
//#UC START# *46A5CE5C0057_47E3C78502FB_impl*
 if (Self <> nil) then
  if (f_Mode <> nil) then
   Il3OpPackMode(f_Mode).InvertModified;
//#UC END# *46A5CE5C0057_47E3C78502FB_impl*
end;//Tk2OperationContainer.InvertModified

function Tk2OperationContainer.GetModified: Boolean;
//#UC START# *46A5CE6A00BB_47E3C78502FB_var*
//#UC END# *46A5CE6A00BB_47E3C78502FB_var*
begin
//#UC START# *46A5CE6A00BB_47E3C78502FB_impl*
 if (f_Mode = nil) then
  Result := false
 else
  Result := Il3OpPackMode(f_Mode).GetModified;
//#UC END# *46A5CE6A00BB_47E3C78502FB_impl*
end;//Tk2OperationContainer.GetModified

function Tk2OperationContainer.Get_InUndo: Boolean;
//#UC START# *46A5CE840343_47E3C78502FBget_var*
//#UC END# *46A5CE840343_47E3C78502FBget_var*
begin
//#UC START# *46A5CE840343_47E3C78502FBget_impl*
 if (f_Mode = nil) then
  Result := false
 else
  Result := Il3OpPackMode(f_Mode).InUndo;
//#UC END# *46A5CE840343_47E3C78502FBget_impl*
end;//Tk2OperationContainer.Get_InUndo

function Tk2OperationContainer.Get_SaveUndo: Boolean;
//#UC START# *46A5CE9A03B3_47E3C78502FBget_var*
//#UC END# *46A5CE9A03B3_47E3C78502FBget_var*
begin
//#UC START# *46A5CE9A03B3_47E3C78502FBget_impl*
 Result := GetSaveUndo;
//#UC END# *46A5CE9A03B3_47E3C78502FBget_impl*
end;//Tk2OperationContainer.Get_SaveUndo

procedure Tk2OperationContainer.Set_SaveUndo(aValue: Boolean);
//#UC START# *46A5CE9A03B3_47E3C78502FBset_var*
//#UC END# *46A5CE9A03B3_47E3C78502FBset_var*
begin
//#UC START# *46A5CE9A03B3_47E3C78502FBset_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).SaveUndo := aValue;
//#UC END# *46A5CE9A03B3_47E3C78502FBset_impl*
end;//Tk2OperationContainer.Set_SaveUndo

function Tk2OperationContainer.pm_GetDeleteMapped: Boolean;
//#UC START# *46A5CEB0018E_47E3C78502FBget_var*
//#UC END# *46A5CEB0018E_47E3C78502FBget_var*
begin
//#UC START# *46A5CEB0018E_47E3C78502FBget_impl*
 if (f_Mode = nil) then
  Result := true
 else
  Result := Il3OpPackMode(f_Mode).DeleteMapped;
//#UC END# *46A5CEB0018E_47E3C78502FBget_impl*
end;//Tk2OperationContainer.pm_GetDeleteMapped

procedure Tk2OperationContainer.pm_SetDeleteMapped(aValue: Boolean);
//#UC START# *46A5CEB0018E_47E3C78502FBset_var*
//#UC END# *46A5CEB0018E_47E3C78502FBset_var*
begin
//#UC START# *46A5CEB0018E_47E3C78502FBset_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).DeleteMapped := aValue;
//#UC END# *46A5CEB0018E_47E3C78502FBset_impl*
end;//Tk2OperationContainer.pm_SetDeleteMapped

function Tk2OperationContainer.pm_GetOptimize: Boolean;
//#UC START# *46A5CEC900F4_47E3C78502FBget_var*
//#UC END# *46A5CEC900F4_47E3C78502FBget_var*
begin
//#UC START# *46A5CEC900F4_47E3C78502FBget_impl*
 Result := GetNeedOptimize;
//#UC END# *46A5CEC900F4_47E3C78502FBget_impl*
end;//Tk2OperationContainer.pm_GetOptimize

procedure Tk2OperationContainer.pm_SetOptimize(aValue: Boolean);
//#UC START# *46A5CEC900F4_47E3C78502FBset_var*
//#UC END# *46A5CEC900F4_47E3C78502FBset_var*
begin
//#UC START# *46A5CEC900F4_47E3C78502FBset_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).Optimize := aValue;
//#UC END# *46A5CEC900F4_47E3C78502FBset_impl*
end;//Tk2OperationContainer.pm_SetOptimize

function Tk2OperationContainer.pm_GetInIOProcess: Boolean;
//#UC START# *46A5CEF30267_47E3C78502FBget_var*
//#UC END# *46A5CEF30267_47E3C78502FBget_var*
begin
//#UC START# *46A5CEF30267_47E3C78502FBget_impl*
 if (f_mode = nil) then
  Result := true
 else
  Result := Il3OpPackMode(f_Mode).InIOProcess;
//#UC END# *46A5CEF30267_47E3C78502FBget_impl*
end;//Tk2OperationContainer.pm_GetInIOProcess

procedure Tk2OperationContainer.pm_SetInIOProcess(aValue: Boolean);
//#UC START# *46A5CEF30267_47E3C78502FBset_var*
//#UC END# *46A5CEF30267_47E3C78502FBset_var*
begin
//#UC START# *46A5CEF30267_47E3C78502FBset_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).InIOProcess := aValue;
//#UC END# *46A5CEF30267_47E3C78502FBset_impl*
end;//Tk2OperationContainer.pm_SetInIOProcess

function Tk2OperationContainer.pm_GetProcessor: Ik2Processor;
//#UC START# *46A5CF0902C3_47E3C78502FBget_var*
//#UC END# *46A5CF0902C3_47E3C78502FBget_var*
begin
//#UC START# *46A5CF0902C3_47E3C78502FBget_impl*
 if (f_Mode = nil) then
  Result := nil
 else
  Result := Il3OpPackMode(f_Mode).Processor;
//#UC END# *46A5CF0902C3_47E3C78502FBget_impl*
end;//Tk2OperationContainer.pm_GetProcessor

function Tk2OperationContainer.Undo(const aProcessor: Ik2Processor): Integer;
 {* откатывает все операции и возвращает их количество. }
//#UC START# *46A5D33D025C_47E3C78502FB_var*
var
 l_Mode : Pointer;  
//#UC END# *46A5D33D025C_47E3C78502FB_var*
begin
//#UC START# *46A5D33D025C_47E3C78502FB_impl*
 if Empty then
  Result := 0
 else
 begin
  l_Mode := f_Mode;
  try
   f_Mode := Pointer(aProcessor As Il3OpPackMode);
   Result := DoUndo(aProcessor);
  finally
   f_Mode := l_Mode;
  end;//try..finally
 end;//Empty
//#UC END# *46A5D33D025C_47E3C78502FB_impl*
end;//Tk2OperationContainer.Undo

function Tk2OperationContainer.Redo(const aProcessor: Ik2Processor): Integer;
 {* возвращает все операции и возвращает их количество. }
//#UC START# *46A5D37B0247_47E3C78502FB_var*
var
 l_Mode : Pointer;  
//#UC END# *46A5D37B0247_47E3C78502FB_var*
begin
//#UC START# *46A5D37B0247_47E3C78502FB_impl*
 if Empty then
  Result := 0
 else
 begin
  l_Mode := f_Mode;
  try
   f_Mode := Pointer(aProcessor As Il3OpPackMode);
   Result := DoRedo(aProcessor);
  finally
   f_Mode := l_Mode;
  end;//try..finally
 end;//Empty
//#UC END# *46A5D37B0247_47E3C78502FB_impl*
end;//Tk2OperationContainer.Redo

procedure Tk2OperationContainer.Lock;
 {* закрыть. }
//#UC START# *46A5D3BC0041_47E3C78502FB_var*
//#UC END# *46A5D3BC0041_47E3C78502FB_var*
begin
//#UC START# *46A5D3BC0041_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).Processor.Lock;
//#UC END# *46A5D3BC0041_47E3C78502FB_impl*
end;//Tk2OperationContainer.Lock

procedure Tk2OperationContainer.Unlock;
 {* открыть. }
//#UC START# *46A5D3D101E6_47E3C78502FB_var*
//#UC END# *46A5D3D101E6_47E3C78502FB_var*
begin
//#UC START# *46A5D3D101E6_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).Processor.Unlock;
//#UC END# *46A5D3D101E6_47E3C78502FB_impl*
end;//Tk2OperationContainer.Unlock

function Tk2OperationContainer.Get_Code: Integer;
//#UC START# *4874FC1C01D2_47E3C78502FBget_var*
//#UC END# *4874FC1C01D2_47E3C78502FBget_var*
begin
//#UC START# *4874FC1C01D2_47E3C78502FBget_impl*
 Result := f_Code;
//#UC END# *4874FC1C01D2_47E3C78502FBget_impl*
end;//Tk2OperationContainer.Get_Code

procedure Tk2OperationContainer.Put(Op: Tk2Op;
 Modify: Boolean);
 {* положить операцию. }
//#UC START# *4874FDA50243_47E3C78502FB_var*
//#UC END# *4874FDA50243_47E3C78502FB_var*
begin
//#UC START# *4874FDA50243_47E3C78502FB_impl*
 if (Op <> nil) then
  if Get_SaveUndo then
  begin
   if Modify then
    MarkModified(nil);
   Add(Op);
  end;//Get_SaveUndo
//#UC END# *4874FDA50243_47E3C78502FB_impl*
end;//Tk2OperationContainer.Put

procedure Tk2OperationContainer.CheckReadOnly;
//#UC START# *48A4297E0341_47E3C78502FB_var*
//#UC END# *48A4297E0341_47E3C78502FB_var*
begin
//#UC START# *48A4297E0341_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).CheckReadOnly;
//#UC END# *48A4297E0341_47E3C78502FB_impl*
end;//Tk2OperationContainer.CheckReadOnly

procedure Tk2OperationContainer.DisableReadonly;
 {* Выключает режим проверки ReadOnly }
//#UC START# *48A564120005_47E3C78502FB_var*
//#UC END# *48A564120005_47E3C78502FB_var*
begin
//#UC START# *48A564120005_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).DisableReadOnly;
//#UC END# *48A564120005_47E3C78502FB_impl*
end;//Tk2OperationContainer.DisableReadonly

procedure Tk2OperationContainer.EnableReadOnly;
 {* Включает режим проверки ReadOnly }
//#UC START# *48A564160056_47E3C78502FB_var*
//#UC END# *48A564160056_47E3C78502FB_var*
begin
//#UC START# *48A564160056_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).EnableReadOnly;
//#UC END# *48A564160056_47E3C78502FB_impl*
end;//Tk2OperationContainer.EnableReadOnly

procedure Tk2OperationContainer.pm_SetReadOnly(aValue: Boolean);
//#UC START# *48A570180217_47E3C78502FBset_var*
//#UC END# *48A570180217_47E3C78502FBset_var*
begin
//#UC START# *48A570180217_47E3C78502FBset_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).ReadOnly := aValue;
//#UC END# *48A570180217_47E3C78502FBset_impl*
end;//Tk2OperationContainer.pm_SetReadOnly

procedure Tk2OperationContainer.CheckOn;
//#UC START# *4CEBD62101DA_47E3C78502FB_var*
//#UC END# *4CEBD62101DA_47E3C78502FB_var*
begin
//#UC START# *4CEBD62101DA_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).CheckOn;
//#UC END# *4CEBD62101DA_47E3C78502FB_impl*
end;//Tk2OperationContainer.CheckOn

procedure Tk2OperationContainer.CheckOff;
//#UC START# *4CEBD62D01E8_47E3C78502FB_var*
//#UC END# *4CEBD62D01E8_47E3C78502FB_var*
begin
//#UC START# *4CEBD62D01E8_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Il3OpPackMode(f_Mode).CheckOff;
//#UC END# *4CEBD62D01E8_47E3C78502FB_impl*
end;//Tk2OperationContainer.CheckOff

function Tk2OperationContainer.IsCheckOff: Boolean;
//#UC START# *4CECE9470154_47E3C78502FB_var*
//#UC END# *4CECE9470154_47E3C78502FB_var*
begin
//#UC START# *4CECE9470154_47E3C78502FB_impl*
 if (f_Mode <> nil) then
  Result := Il3OpPackMode(f_Mode).IsCheckOff
 else
  Result := false; 
//#UC END# *4CECE9470154_47E3C78502FB_impl*
end;//Tk2OperationContainer.IsCheckOff

procedure Tk2OperationContainer.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47E3C78502FB_var*
//#UC END# *479731C50290_47E3C78502FB_var*
begin
//#UC START# *479731C50290_47E3C78502FB_impl*
 f_Owner := nil;
 f_Mode := nil;
 inherited;
//#UC END# *479731C50290_47E3C78502FB_impl*
end;//Tk2OperationContainer.Cleanup

procedure Tk2OperationContainer.InitFields;
//#UC START# *47A042E100E2_47E3C78502FB_var*
//#UC END# *47A042E100E2_47E3C78502FB_var*
begin
//#UC START# *47A042E100E2_47E3C78502FB_impl*
 inherited;
 pm_SetDeleteMapped(true);
 pm_SetOptimize(true);
//#UC END# *47A042E100E2_47E3C78502FB_impl*
end;//Tk2OperationContainer.InitFields

procedure Tk2OperationContainer.BeforeFree;
 {* функция, вызываемая при каждом уменьшении счетчика ссылок на 1. Вернув false может запретить уничтожение объекта. }
//#UC START# *48B2BE560115_47E3C78502FB_var*
//#UC END# *48B2BE560115_47E3C78502FB_var*
begin
//#UC START# *48B2BE560115_47E3C78502FB_impl*
 inherited;
 if (RefCount = 1) then
  FreeInOwner;
//#UC END# *48B2BE560115_47E3C78502FB_impl*
end;//Tk2OperationContainer.BeforeFree

initialization
 str_l3mmUndo.Init;
 {* Инициализация str_l3mmUndo }
 str_l3mmRedo.Init;
 {* Инициализация str_l3mmRedo }

end.
