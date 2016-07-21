unit vcmAggregate;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmAggregate.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TvcmAggregate" MUID: (528609ED0325)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmBase
 , vcmInterfaces
 , vcmIEntityList
 , vcmExternalInterfaces
;

type
 TvcmAggregate = class(TvcmCacheableBase, IvcmAggregate)
  private
   f_List: TvcmIEntityList;
   f_GUID: TGUID;
  public
   f_CanBeCloned: Boolean;
  protected
   function DoGetCanBeCloned: Boolean; virtual;
   procedure AddEntity(const anEntity: IvcmEntity);
    {* Добавляет сущность в агрегацию }
   procedure RemoveEntity(const anEntity: IvcmEntity);
    {* удаляет сущность из агрегации }
   function Operation(const anOp: TvcmOPID;
    const aParams: IvcmExecuteParams): IvcmExecuteParams; overload;
   function Operation(const anOp: TvcmOPID): IvcmExecuteParams; overload;
   function HasForm(const aName: TvcmFormID;
    theForm: PIvcmEntityForm = nil): Boolean;
    {* Проверяет, присутствует ли указанная форма в агрегации }
   function Get_GUID: TGUID;
   function Get_Entity(anIndex: Integer): IvcmEntity;
   function Get_EntitiesCount: Integer;
   function pm_GetCanBeCloned: Boolean;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create(aGUID: PGUID = nil;
    aCanBeCloned: Boolean = True); reintroduce;
   class function Make(aGUID: PGUID = nil;
    aCanBeCloned: Boolean = True): IvcmAggregate;
 end;//TvcmAggregate
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , vcmUserControls
;

constructor TvcmAggregate.Create(aGUID: PGUID = nil;
 aCanBeCloned: Boolean = True);
//#UC START# *52860CA00075_528609ED0325_var*
//#UC END# *52860CA00075_528609ED0325_var*
begin
//#UC START# *52860CA00075_528609ED0325_impl*
 inherited Create;
 if (aGUID = nil) then
  CreateGUID(f_GUID)
 else
  f_GUID := aGUID^; 
 if (g_Dispatcher <> nil) then
  g_Dispatcher.AddAggregate(Self);
//#UC END# *52860CA00075_528609ED0325_impl*
end;//TvcmAggregate.Create

class function TvcmAggregate.Make(aGUID: PGUID = nil;
 aCanBeCloned: Boolean = True): IvcmAggregate;
//#UC START# *52860CAD0035_528609ED0325_var*
var
 l_Aggregate: TvcmAggregate;
//#UC END# *52860CAD0035_528609ED0325_var*
begin
//#UC START# *52860CAD0035_528609ED0325_impl*
 if (aGUID = nil) OR (g_Dispatcher = nil) OR
    not g_Dispatcher.FindAggregate(aGUID^, Result) then
 begin
  l_Aggregate := Create(aGUID);
  try
   Result := l_Aggregate;
  finally
   vcmFree(l_Aggregate);
  end;//try..finally
 end;//pGUID = nil..
//#UC END# *52860CAD0035_528609ED0325_impl*
end;//TvcmAggregate.Make

function TvcmAggregate.DoGetCanBeCloned: Boolean;
//#UC START# *578DDE26002B_528609ED0325_var*
//#UC END# *578DDE26002B_528609ED0325_var*
begin
//#UC START# *578DDE26002B_528609ED0325_impl*
 Result := f_CanBeCloned;
//#UC END# *578DDE26002B_528609ED0325_impl*
end;//TvcmAggregate.DoGetCanBeCloned

procedure TvcmAggregate.AddEntity(const anEntity: IvcmEntity);
 {* Добавляет сущность в агрегацию }
//#UC START# *499564DB007D_528609ED0325_var*
//#UC END# *499564DB007D_528609ED0325_var*
begin
//#UC START# *499564DB007D_528609ED0325_impl*
 if (f_List = nil) then
  f_List := TvcmIEntityList.Make;
 if f_List.IndexOf(anEntity) < 0 then
  f_List.Add(anEntity);
//#UC END# *499564DB007D_528609ED0325_impl*
end;//TvcmAggregate.AddEntity

procedure TvcmAggregate.RemoveEntity(const anEntity: IvcmEntity);
 {* удаляет сущность из агрегации }
//#UC START# *499564F80314_528609ED0325_var*
//#UC END# *499564F80314_528609ED0325_var*
begin
//#UC START# *499564F80314_528609ED0325_impl*
 if (f_List <> nil) then
  f_List.Remove(anEntity);
//#UC END# *499564F80314_528609ED0325_impl*
end;//TvcmAggregate.RemoveEntity

function TvcmAggregate.Operation(const anOp: TvcmOPID;
 const aParams: IvcmExecuteParams): IvcmExecuteParams;
//#UC START# *499565380247_528609ED0325_var*
var
 l_Done       : TvcmDoneStatus;
 l_Index      : Integer;
 l_Hi         : Integer;
 l_DoneResult : IvcmExecuteParams;
 l_PrevEntity : IvcmEntity;
 l_NewEntity  : IvcmEntity;
 l_List       : TvcmIEntityList;
//#UC END# *499565380247_528609ED0325_var*
begin
//#UC START# *499565380247_528609ED0325_impl*
 Result := aParams;
 l_DoneResult := nil;
 l_Done := vcm_dsNotDone;
 {$IfNDef DesignTimeLibrary}
 if (f_List <> nil) then
 begin
  l_List := f_List.Clone;
  try
   with l_List do
   begin
    l_Index := Lo;
    l_Hi := Hi;
    l_PrevEntity := nil;
    while (l_Index <= l_Hi) do
    begin
     Result.DoneStatus := vcm_dsNotDone;
     aParams.DoneStatus := vcm_dsNotDone;
     l_NewEntity := Items[l_Index];
     if not vcmIEQ(l_PrevEntity, l_NewEntity) then
     begin
      l_PrevEntity := l_NewEntity;
      Result := aParams;
      l_PrevEntity.Operation(anOp, aParams.BasePart, vcm_omAggregateExecute);
      if Result.Done then
      begin
       l_DoneResult := Result;
       l_Done := vcm_dsDone;
      end;//Result.Done
     end;//not vcmIEQ(l_PrevEntity, l_NewEntity)
     if (l_Hi > Hi) then
      l_Hi := Hi
     else
      Inc(l_Index);
    end;//for l_Index
   end;//with l_List
  finally
   vcmFree(l_List);
  end;//try..finally
 end;//f_List <> nil
 if l_DoneResult <> nil then
 begin
  Result := l_DoneResult;
  Result.DoneStatus := vcm_dsDone;
  l_DoneResult := nil;
 end
 else
  Result.DoneStatus := l_Done;
 {$EndIf DesignTimeLibrary}
//#UC END# *499565380247_528609ED0325_impl*
end;//TvcmAggregate.Operation

function TvcmAggregate.Operation(const anOp: TvcmOPID): IvcmExecuteParams;
//#UC START# *4995656A030F_528609ED0325_var*
//#UC END# *4995656A030F_528609ED0325_var*
begin
//#UC START# *4995656A030F_528609ED0325_impl*
 Result := Operation(anOp, vcmParams);
//#UC END# *4995656A030F_528609ED0325_impl*
end;//TvcmAggregate.Operation

function TvcmAggregate.HasForm(const aName: TvcmFormID;
 theForm: PIvcmEntityForm = nil): Boolean;
 {* Проверяет, присутствует ли указанная форма в агрегации }
//#UC START# *499565DF0254_528609ED0325_var*
var
 l_Index : Integer;
 l_Form  : IvcmEntityForm;
//#UC END# *499565DF0254_528609ED0325_var*
begin
//#UC START# *499565DF0254_528609ED0325_impl*
 Result := false;
 if Assigned(theForm) then
  theForm^ := nil;
 for l_Index := 0 to Pred(Get_EntitiesCount) do
  if Supports(Get_Entity(l_Index), IvcmEntityForm, l_Form) AND
     l_Form.SameName(aName) then begin
   Result := true;
   if Assigned(theForm) then
    theForm^ := l_Form;
   break;
  end;//Supports..
//#UC END# *499565DF0254_528609ED0325_impl*
end;//TvcmAggregate.HasForm

function TvcmAggregate.Get_GUID: TGUID;
//#UC START# *499566250105_528609ED0325get_var*
//#UC END# *499566250105_528609ED0325get_var*
begin
//#UC START# *499566250105_528609ED0325get_impl*
 Result := f_GUID;
//#UC END# *499566250105_528609ED0325get_impl*
end;//TvcmAggregate.Get_GUID

function TvcmAggregate.Get_Entity(anIndex: Integer): IvcmEntity;
//#UC START# *528A07FB0004_528609ED0325get_var*
//#UC END# *528A07FB0004_528609ED0325get_var*
begin
//#UC START# *528A07FB0004_528609ED0325get_impl*
 if (f_List = nil) then
  Result := nil
 else
  Result := f_List.Items[anIndex];
//#UC END# *528A07FB0004_528609ED0325get_impl*
end;//TvcmAggregate.Get_Entity

function TvcmAggregate.Get_EntitiesCount: Integer;
//#UC START# *528A088B00F5_528609ED0325get_var*
//#UC END# *528A088B00F5_528609ED0325get_var*
begin
//#UC START# *528A088B00F5_528609ED0325get_impl*
 if (f_List = nil) then
  Result := 0
 else
  Result := f_List.Count;
//#UC END# *528A088B00F5_528609ED0325get_impl*
end;//TvcmAggregate.Get_EntitiesCount

function TvcmAggregate.pm_GetCanBeCloned: Boolean;
//#UC START# *578C8F480100_528609ED0325get_var*
//#UC END# *578C8F480100_528609ED0325get_var*
begin
//#UC START# *578C8F480100_528609ED0325get_impl*
 Result := f_CanBeCloned;
//#UC END# *578C8F480100_528609ED0325get_impl*
end;//TvcmAggregate.pm_GetCanBeCloned

procedure TvcmAggregate.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_528609ED0325_var*
//#UC END# *479731C50290_528609ED0325_var*
begin
//#UC START# *479731C50290_528609ED0325_impl*
 if (g_Dispatcher <> nil) then
  g_Dispatcher.RemoveAggregate(Self);
 vcmFree(f_List);
 inherited;
//#UC END# *479731C50290_528609ED0325_impl*
end;//TvcmAggregate.Cleanup
{$IfEnd} // NOT Defined(NoVCM)

end.
