unit vcmAggregateContainerRegistry;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmAggregateContainerRegistry.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmAggregateContainerRegistry" MUID: (578CA6EC0255)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoObject
 , vcmInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _KeyType_ = Pointer;
 _ValueType_ = Pointer;
 {$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}
 TvcmAggregateContainerMap = class(_l3Map_)
 end;//TvcmAggregateContainerMap

 TvcmAggregateContainerRegistry = class(Tl3ProtoObject)
  private
   f_Map: TvcmAggregateContainerMap;
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
  public
   function GetAggregateContainer(const aAggregate: IvcmAggregate): IvcmContainer;
   function GetContainedAggregate(const aContainer: IvcmContainer): IvcmAggregate;
   procedure RegisterAggregate(const aAggregate: IvcmAggregate;
    const aContainer: IvcmContainer);
   procedure UnregisterAggregate(const aAggregate: IvcmAggregate);
   procedure RegisterFormAggregate(const aForm: IvcmEntityForm);
   class function Instance: TvcmAggregateContainerRegistry;
    {* Метод получения экземпляра синглетона TvcmAggregateContainerRegistry }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
  public
   property Map: TvcmAggregateContainerMap
    read f_Map;
 end;//TvcmAggregateContainerRegistry
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , vcmFormSetContainerRegistry
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
 //#UC START# *578CA6EC0255impl_uses*
 //#UC END# *578CA6EC0255impl_uses*
;

var g_TvcmAggregateContainerRegistry: TvcmAggregateContainerRegistry = nil;
 {* Экземпляр синглетона TvcmAggregateContainerRegistry }

procedure TvcmAggregateContainerRegistryFree;
 {* Метод освобождения экземпляра синглетона TvcmAggregateContainerRegistry }
begin
 l3Free(g_TvcmAggregateContainerRegistry);
end;//TvcmAggregateContainerRegistryFree

function CompareKeys(const aA: _KeyType_;
 const aB: _KeyType_): Integer;
//#UC START# *5609091B00C0_578CA7B90020_var*
//#UC END# *5609091B00C0_578CA7B90020_var*
begin
//#UC START# *5609091B00C0_578CA7B90020_impl*
 Result := Integer(aB) - Integer(aA);
//#UC END# *5609091B00C0_578CA7B90020_impl*
end;//CompareKeys

type _Instance_R_ = TvcmAggregateContainerMap;

{$Include w:\common\components\rtl\Garant\L3\l3Map.imp.pas}

function TvcmAggregateContainerRegistry.GetAggregateContainer(const aAggregate: IvcmAggregate): IvcmContainer;
//#UC START# *578CA8350324_578CA6EC0255_var*
var
 l_Index: Integer;
 l_FormSet: IvcmFormSet;
//#UC END# *578CA8350324_578CA6EC0255_var*
begin
//#UC START# *578CA8350324_578CA6EC0255_impl*
 Result := nil;
 for l_Index := 0 to Pred(f_Map.Count) do
  if (f_Map.Items[l_Index].rValue = Pointer(aAggregate)) then
  begin
   Result := IvcmContainer(f_Map.Items[l_Index].rKey);
   Break;
  end;
 if (Result = nil) then
  if Supports(aAggregate, IvcmFormSet, l_FormSet) then
   Result := TvcmFormSetContainerRegistry.Instance.GetFormSetContainer(l_FormSet);
//#UC END# *578CA8350324_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.GetAggregateContainer

function TvcmAggregateContainerRegistry.GetContainedAggregate(const aContainer: IvcmContainer): IvcmAggregate;
//#UC START# *578CAABD001E_578CA6EC0255_var*
//#UC END# *578CAABD001E_578CA6EC0255_var*
begin
//#UC START# *578CAABD001E_578CA6EC0255_impl*
 Result := nil;
 if (f_Map.Has(Pointer(aContainer))) then
  Result := IvcmAggregate(f_Map.ValueByKey(Pointer(aContainer)));
 if (Result = nil) then
  Result := TvcmFormSetContainerRegistry.Instance.GetContainedFormSet(aContainer);
//#UC END# *578CAABD001E_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.GetContainedAggregate

procedure TvcmAggregateContainerRegistry.RegisterAggregate(const aAggregate: IvcmAggregate;
 const aContainer: IvcmContainer);
//#UC START# *578CAAD80333_578CA6EC0255_var*
//#UC END# *578CAAD80333_578CA6EC0255_var*
begin
//#UC START# *578CAAD80333_578CA6EC0255_impl*
 Assert(aContainer <> nil);
 f_Map.Add(Pointer(aContainer), Pointer(aAggregate));
//#UC END# *578CAAD80333_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.RegisterAggregate

procedure TvcmAggregateContainerRegistry.UnregisterAggregate(const aAggregate: IvcmAggregate);
//#UC START# *578CAAF1030D_578CA6EC0255_var*
var
 l_Index: Integer;
 l_AggrIndex: Integer;
//#UC END# *578CAAF1030D_578CA6EC0255_var*
begin
//#UC START# *578CAAF1030D_578CA6EC0255_impl*
 l_AggrIndex := -1;
 for l_Index := 0 to Pred(f_Map.Count) do
  if (f_Map.Items[l_Index].rValue = Pointer(aAggregate)) then
  begin
   l_AggrIndex := l_Index;
   Break;
  end;
 if (l_AggrIndex <> -1) then
  f_Map.Delete(l_AggrIndex);
//#UC END# *578CAAF1030D_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.UnregisterAggregate

procedure TvcmAggregateContainerRegistry.RegisterFormAggregate(const aForm: IvcmEntityForm);
//#UC START# *578CC3C40049_578CA6EC0255_var*
var
 l_Container: Pointer;
//#UC END# *578CC3C40049_578CA6EC0255_var*
begin
//#UC START# *578CC3C40049_578CA6EC0255_impl*
 if (not (aForm.ZoneType in [vcm_ztModal, vcm_ztManualModal, vcm_ztSimpleFloat])) then
 begin
  l_Container := Pointer(aForm.NativeMainForm);
  if f_Map.Has(l_Container) then
   f_Map.Delete(f_Map.IndexByKey(l_Container));
  f_Map.Add(l_Container, Pointer(aForm.Aggregate));
 end;
//#UC END# *578CC3C40049_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.RegisterFormAggregate

class function TvcmAggregateContainerRegistry.Instance: TvcmAggregateContainerRegistry;
 {* Метод получения экземпляра синглетона TvcmAggregateContainerRegistry }
begin
 if (g_TvcmAggregateContainerRegistry = nil) then
 begin
  l3System.AddExitProc(TvcmAggregateContainerRegistryFree);
  g_TvcmAggregateContainerRegistry := Create;
 end;
 Result := g_TvcmAggregateContainerRegistry;
end;//TvcmAggregateContainerRegistry.Instance

class function TvcmAggregateContainerRegistry.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TvcmAggregateContainerRegistry <> nil;
end;//TvcmAggregateContainerRegistry.Exists

procedure TvcmAggregateContainerRegistry.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_578CA6EC0255_var*
//#UC END# *479731C50290_578CA6EC0255_var*
begin
//#UC START# *479731C50290_578CA6EC0255_impl*
 FreeAndNil(f_Map);
 inherited;
//#UC END# *479731C50290_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.Cleanup

procedure TvcmAggregateContainerRegistry.InitFields;
//#UC START# *47A042E100E2_578CA6EC0255_var*
//#UC END# *47A042E100E2_578CA6EC0255_var*
begin
//#UC START# *47A042E100E2_578CA6EC0255_impl*
 f_Map := TvcmAggregateContainerMap.Create;
//#UC END# *47A042E100E2_578CA6EC0255_impl*
end;//TvcmAggregateContainerRegistry.InitFields
{$IfEnd} // NOT Defined(NoVCM)

end.
