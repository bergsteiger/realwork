unit Common_Rubricator_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common_Rubricator_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Rubricator" MUID: (4AA7800100B4)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DynamicTreeUnit
 , l3TreeInterfaces
 , MainMenuUnit
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IRubricator_SetListRoot_Params = interface
  {* Параметры для операции Rubricator.SetListRoot }
  function Get_Node: Il3SimpleNode;
  function Get_RootToKeep: INodeBase;
  function Get_MenuSectionItemToKeep: ISectionItem;
  property Node: Il3SimpleNode
   read Get_Node;
  property RootToKeep: INodeBase
   read Get_RootToKeep;
  property MenuSectionItemToKeep: ISectionItem
   read Get_MenuSectionItemToKeep;
 end;//IRubricator_SetListRoot_Params

 Op_Rubricator_SetListRoot = {final} class
  {* Класс для вызова операции Rubricator.SetListRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.SetListRoot у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.SetListRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.SetListRoot у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.SetListRoot у контейнера }
 end;//Op_Rubricator_SetListRoot

 IRubricator_InitListRoot_Params = interface
  {* Параметры для операции Rubricator.InitListRoot }
  function Get_Node: Il3SimpleNode;
  function Get_RootToKeep: INodeBase;
  function Get_MenuSectionItemToKeep: ISectionItem;
  property Node: Il3SimpleNode
   read Get_Node;
  property RootToKeep: INodeBase
   read Get_RootToKeep;
  property MenuSectionItemToKeep: ISectionItem
   read Get_MenuSectionItemToKeep;
 end;//IRubricator_InitListRoot_Params

 Op_Rubricator_InitListRoot = {final} class
  {* Класс для вызова операции Rubricator.InitListRoot }
  public
   class function Call(const aTarget: IvcmEntity;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.InitListRoot у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.InitListRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.InitListRoot у формы }
   class function Call(const aTarget: IvcmContainer;
    const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): Boolean; overload;
    {* Вызов операции Rubricator.InitListRoot у контейнера }
 end;//Op_Rubricator_InitListRoot

 Op_Rubricator_Synchronize = {final} class
  {* Класс для вызова операции Rubricator.Synchronize }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Rubricator.Synchronize у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Rubricator.Synchronize у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Rubricator.Synchronize у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Rubricator.Synchronize у контейнера }
 end;//Op_Rubricator_Synchronize

 IRubricator_GetRoot_Params = interface
  {* Параметры для операции Rubricator.GetRoot }
  function Get_ResultValue: Il3SimpleNode;
  procedure Set_ResultValue(const aValue: Il3SimpleNode);
  property ResultValue: Il3SimpleNode
   read Get_ResultValue
   write Set_ResultValue;
 end;//IRubricator_GetRoot_Params

 Op_Rubricator_GetRoot = {final} class
  {* Класс для вызова операции Rubricator.GetRoot }
  public
   class function Call(const aTarget: IvcmEntity): Il3SimpleNode; overload;
    {* Вызов операции Rubricator.GetRoot у сущности }
   class function Call(const aTarget: IvcmAggregate): Il3SimpleNode; overload;
    {* Вызов операции Rubricator.GetRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Il3SimpleNode; overload;
    {* Вызов операции Rubricator.GetRoot у формы }
   class function Call(const aTarget: IvcmContainer): Il3SimpleNode; overload;
    {* Вызов операции Rubricator.GetRoot у контейнера }
 end;//Op_Rubricator_GetRoot

const
 en_Rubricator = 'Rubricator';
 en_capRubricator = '';
 op_SetListRoot = 'SetListRoot';
 op_capSetListRoot = '';
 op_InitListRoot = 'InitListRoot';
 op_capInitListRoot = '';
 op_Synchronize = 'Synchronize';
 op_capSynchronize = '';
 op_GetRoot = 'GetRoot';
 op_capGetRoot = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TRubricator_SetListRoot_Params = {final} class(Tl3CProtoObject, IRubricator_SetListRoot_Params)
  {* Реализация IRubricator_SetListRoot_Params }
  private
   f_Node: Il3SimpleNode;
   f_RootToKeep: INodeBase;
   f_MenuSectionItemToKeep: ISectionItem;
  protected
   function Get_Node: Il3SimpleNode;
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
   class function Make(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): IRubricator_SetListRoot_Params; reintroduce;
 end;//TRubricator_SetListRoot_Params

 TRubricator_InitListRoot_Params = {final} class(Tl3CProtoObject, IRubricator_InitListRoot_Params)
  {* Реализация IRubricator_InitListRoot_Params }
  private
   f_Node: Il3SimpleNode;
   f_RootToKeep: INodeBase;
   f_MenuSectionItemToKeep: ISectionItem;
  protected
   function Get_Node: Il3SimpleNode;
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   procedure ClearFields; override;
  public
   constructor Create(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
   class function Make(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): IRubricator_InitListRoot_Params; reintroduce;
 end;//TRubricator_InitListRoot_Params

 TRubricator_GetRoot_Params = {final} class(Tl3CProtoObject, IRubricator_GetRoot_Params)
  {* Реализация IRubricator_GetRoot_Params }
  private
   f_ResultValue: Il3SimpleNode;
  protected
   function Get_ResultValue: Il3SimpleNode;
   procedure Set_ResultValue(const aValue: Il3SimpleNode);
   procedure ClearFields; override;
  public
   class function Make: IRubricator_GetRoot_Params; reintroduce;
 end;//TRubricator_GetRoot_Params

constructor TRubricator_SetListRoot_Params.Create(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
begin
 inherited Create;
 f_Node := aNode;
 f_RootToKeep := aRootToKeep;
 f_MenuSectionItemToKeep := aMenuSectionItemToKeep;
end;//TRubricator_SetListRoot_Params.Create

class function TRubricator_SetListRoot_Params.Make(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): IRubricator_SetListRoot_Params;
var
 l_Inst : TRubricator_SetListRoot_Params;
begin
 l_Inst := Create(aNode, aRootToKeep, aMenuSectionItemToKeep);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRubricator_SetListRoot_Params.Make

function TRubricator_SetListRoot_Params.Get_Node: Il3SimpleNode;
begin
 Result := f_Node;
end;//TRubricator_SetListRoot_Params.Get_Node

function TRubricator_SetListRoot_Params.Get_RootToKeep: INodeBase;
begin
 Result := f_RootToKeep;
end;//TRubricator_SetListRoot_Params.Get_RootToKeep

function TRubricator_SetListRoot_Params.Get_MenuSectionItemToKeep: ISectionItem;
begin
 Result := f_MenuSectionItemToKeep;
end;//TRubricator_SetListRoot_Params.Get_MenuSectionItemToKeep

procedure TRubricator_SetListRoot_Params.ClearFields;
begin
 f_Node := nil;
 f_RootToKeep := nil;
 f_MenuSectionItemToKeep := nil;
 inherited;
end;//TRubricator_SetListRoot_Params.ClearFields

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.SetListRoot у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_SetListRoot_Params.Make(aNode, aRootToKeep, aMenuSectionItemToKeep));
  aTarget.Operation(TdmStdRes.opcode_Rubricator_SetListRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.SetListRoot у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_SetListRoot_Params.Make(aNode, aRootToKeep, aMenuSectionItemToKeep));
  aTarget.Operation(TdmStdRes.opcode_Rubricator_SetListRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.SetListRoot у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.SetListRoot у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_SetListRoot.Call

constructor TRubricator_InitListRoot_Params.Create(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem);
begin
 inherited Create;
 f_Node := aNode;
 f_RootToKeep := aRootToKeep;
 f_MenuSectionItemToKeep := aMenuSectionItemToKeep;
end;//TRubricator_InitListRoot_Params.Create

class function TRubricator_InitListRoot_Params.Make(const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): IRubricator_InitListRoot_Params;
var
 l_Inst : TRubricator_InitListRoot_Params;
begin
 l_Inst := Create(aNode, aRootToKeep, aMenuSectionItemToKeep);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRubricator_InitListRoot_Params.Make

function TRubricator_InitListRoot_Params.Get_Node: Il3SimpleNode;
begin
 Result := f_Node;
end;//TRubricator_InitListRoot_Params.Get_Node

function TRubricator_InitListRoot_Params.Get_RootToKeep: INodeBase;
begin
 Result := f_RootToKeep;
end;//TRubricator_InitListRoot_Params.Get_RootToKeep

function TRubricator_InitListRoot_Params.Get_MenuSectionItemToKeep: ISectionItem;
begin
 Result := f_MenuSectionItemToKeep;
end;//TRubricator_InitListRoot_Params.Get_MenuSectionItemToKeep

procedure TRubricator_InitListRoot_Params.ClearFields;
begin
 f_Node := nil;
 f_RootToKeep := nil;
 f_MenuSectionItemToKeep := nil;
 inherited;
end;//TRubricator_InitListRoot_Params.ClearFields

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmEntity;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.InitListRoot у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_InitListRoot_Params.Make(aNode, aRootToKeep, aMenuSectionItemToKeep));
  aTarget.Operation(TdmStdRes.opcode_Rubricator_InitListRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmAggregate;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.InitListRoot у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_InitListRoot_Params.Make(aNode, aRootToKeep, aMenuSectionItemToKeep));
  aTarget.Operation(TdmStdRes.opcode_Rubricator_InitListRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmEntityForm;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.InitListRoot у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmContainer;
 const aNode: Il3SimpleNode;
 const aRootToKeep: INodeBase;
 const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {* Вызов операции Rubricator.InitListRoot у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Rubricator.Synchronize у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Rubricator_Synchronize, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Rubricator.Synchronize у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Rubricator_Synchronize, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Rubricator.Synchronize у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Rubricator.Synchronize у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Rubricator_Synchronize.Call

class function TRubricator_GetRoot_Params.Make: IRubricator_GetRoot_Params;
var
 l_Inst : TRubricator_GetRoot_Params;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TRubricator_GetRoot_Params.Make

function TRubricator_GetRoot_Params.Get_ResultValue: Il3SimpleNode;
begin
 Result := f_ResultValue;
end;//TRubricator_GetRoot_Params.Get_ResultValue

procedure TRubricator_GetRoot_Params.Set_ResultValue(const aValue: Il3SimpleNode);
begin
 f_ResultValue := aValue;
end;//TRubricator_GetRoot_Params.Set_ResultValue

procedure TRubricator_GetRoot_Params.ClearFields;
begin
 f_ResultValue := nil;
 inherited;
end;//TRubricator_GetRoot_Params.ClearFields

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmEntity): Il3SimpleNode;
 {* Вызов операции Rubricator.GetRoot у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_GetRoot_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Rubricator_GetRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IRubricator_GetRoot_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmAggregate): Il3SimpleNode;
 {* Вызов операции Rubricator.GetRoot у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_GetRoot_Params.Make);
  aTarget.Operation(TdmStdRes.opcode_Rubricator_GetRoot, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IRubricator_GetRoot_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmEntityForm): Il3SimpleNode;
 {* Вызов операции Rubricator.GetRoot у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmContainer): Il3SimpleNode;
 {* Вызов операции Rubricator.GetRoot у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Rubricator_GetRoot.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
