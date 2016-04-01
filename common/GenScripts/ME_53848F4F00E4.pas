unit ddTaskClassManager;

// Модуль: "w:\common\components\rtl\Garant\cs\ddTaskClassManager.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TddTaskClassManager" MUID: (53848F4F00E4)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
 , ddTaskRecordList
 , ddServerTask
 , csTaskTypes
;

type
 TddTaskClassManager = class(Tl3ProtoObject)
  private
   f_ClassList: TddTaskRecordList;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function GetClass(aClassType: TcsTaskType;
    out aDescription: AnsiString): TddTaskClass;
   procedure RegisterClass(aType: TcsTaskType;
    aClass: TddTaskClass;
    const aDescription: AnsiString);
   function Registered(aTaskType: TcsTaskType): Boolean;
   class function Instance: TddTaskClassManager;
    {* Метод получения экземпляра синглетона TddTaskClassManager }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TddTaskClassManager
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , ddTaskRecord
 , l3Base
;

var g_TddTaskClassManager: TddTaskClassManager = nil;
 {* Экземпляр синглетона TddTaskClassManager }

procedure TddTaskClassManagerFree;
 {* Метод освобождения экземпляра синглетона TddTaskClassManager }
begin
 l3Free(g_TddTaskClassManager);
end;//TddTaskClassManagerFree

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

class function TddTaskClassManager.Instance: TddTaskClassManager;
 {* Метод получения экземпляра синглетона TddTaskClassManager }
begin
 if (g_TddTaskClassManager = nil) then
 begin
  l3System.AddExitProc(TddTaskClassManagerFree);
  g_TddTaskClassManager := Create;
 end;
 Result := g_TddTaskClassManager;
end;//TddTaskClassManager.Instance

class function TddTaskClassManager.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TddTaskClassManager <> nil;
end;//TddTaskClassManager.Exists

procedure TddTaskClassManager.Cleanup;
 {* Функция очистки полей объекта. }
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
{$IfEnd} // NOT Defined(Nemesis)

end.
