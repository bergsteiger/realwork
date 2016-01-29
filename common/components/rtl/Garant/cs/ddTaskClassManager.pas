unit ddTaskClassManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ddTaskClassManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ArchiClientServer::TddTaskClassManager
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
  ddServerTask,
  csTaskTypes,
  ddTaskRecordList
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TddTaskClassManager = class(Tl3ProtoObject)
 private
 // private fields
   f_ClassList : TddTaskRecordList;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure InitFields; override;
 public
 // public methods
   function GetClass(aClassType: TcsTaskType;
     out aDescription: AnsiString): TddTaskClass;
   procedure RegisterClass(aType: TcsTaskType;
     aClass: TddTaskClass;
     const aDescription: AnsiString);
   function Registered(aTaskType: TcsTaskType): Boolean;
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TddTaskClassManager;
    {- возвращает экземпляр синглетона. }
 end;//TddTaskClassManager
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  l3Base {a},
  SysUtils,
  ddTaskRecord
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}


// start class TddTaskClassManager

var g_TddTaskClassManager : TddTaskClassManager = nil;

procedure TddTaskClassManagerFree;
begin
 l3Free(g_TddTaskClassManager);
end;

class function TddTaskClassManager.Instance: TddTaskClassManager;
begin
 if (g_TddTaskClassManager = nil) then
 begin
  l3System.AddExitProc(TddTaskClassManagerFree);
  g_TddTaskClassManager := Create;
 end;
 Result := g_TddTaskClassManager;
end;


function TddTaskClassManager.GetClass(aClassType: TcsTaskType;
  out aDescription: AnsiString): TddTaskClass;
//#UC START# *538490A701EF_53848F4F00E4_var*
var
  I: Integer;
//#UC END# *538490A701EF_53848F4F00E4_var*
begin
//#UC START# *538490A701EF_53848F4F00E4_impl*
 Result := nil;
 for I := 0 to f_ClassList.Count - 1 do
 begin
  if (f_ClassList[I].TaskType = aClassType) then
  begin
   Result := f_ClassList[I].TaskClass;
   aDescription := f_ClassList[I].Description;
   Exit;
  end;//f_ClassList[I].TaskType = aClassType
 end;//for I
//#UC END# *538490A701EF_53848F4F00E4_impl*
end;//TddTaskClassManager.GetClass

procedure TddTaskClassManager.RegisterClass(aType: TcsTaskType;
  aClass: TddTaskClass;
  const aDescription: AnsiString);
//#UC START# *538490D80145_53848F4F00E4_var*
var
 l_ClassRef: TddTaskRecord;
//#UC END# *538490D80145_53848F4F00E4_var*
begin
//#UC START# *538490D80145_53848F4F00E4_impl*
 l_ClassRef:= TddTaskRecord.Create;
 try
  l_ClassRef.TaskType := aType;
  l_ClassRef.TaskClass := aClass;
  l_ClassRef.Description := aDescription;
  f_ClassList.Add(l_ClassRef);
 finally
  FreeAndNil(l_ClassRef);
 end;//try..finally
//#UC END# *538490D80145_53848F4F00E4_impl*
end;//TddTaskClassManager.RegisterClass

function TddTaskClassManager.Registered(aTaskType: TcsTaskType): Boolean;
//#UC START# *5384910E011E_53848F4F00E4_var*
var
 l_Descript: AnsiString;
//#UC END# *5384910E011E_53848F4F00E4_var*
begin
//#UC START# *5384910E011E_53848F4F00E4_impl*
 Result:= GetClass(aTaskType, l_Descript) <> nil;
//#UC END# *5384910E011E_53848F4F00E4_impl*
end;//TddTaskClassManager.Registered

class function TddTaskClassManager.Exists: Boolean;
 {-}
begin
 Result := g_TddTaskClassManager <> nil;
end;//TddTaskClassManager.Exists

procedure TddTaskClassManager.Cleanup;
//#UC START# *479731C50290_53848F4F00E4_var*
//#UC END# *479731C50290_53848F4F00E4_var*
begin
//#UC START# *479731C50290_53848F4F00E4_impl*
 FreeAndNil(f_ClassList);
 inherited;
//#UC END# *479731C50290_53848F4F00E4_impl*
end;//TddTaskClassManager.Cleanup

procedure TddTaskClassManager.InitFields;
//#UC START# *47A042E100E2_53848F4F00E4_var*
//#UC END# *47A042E100E2_53848F4F00E4_var*
begin
//#UC START# *47A042E100E2_53848F4F00E4_impl*
 inherited;
 f_ClassList := TddTaskRecordList.Create;
//#UC END# *47A042E100E2_53848F4F00E4_impl*
end;//TddTaskClassManager.InitFields

{$IfEnd} //not Nemesis

end.