unit Common_Rubricator_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common_Rubricator_Controls.pas"
// Начат: 09.09.2009 14:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Common::View::Rubricator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DynamicTreeUnit,
  l3TreeInterfaces,
  l3CProtoObject,
  MainMenuUnit
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* Rubricator = operations
   ['{09F613A0-79F1-413E-B0CB-7CF5046AC19A}']
   query SetListRoot(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem);
   query InitListRoot(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem);
   query Synchronize;
   query GetRoot: Il3SimpleNode;
 end;//Rubricator*)

type
 IRubricator_SetListRoot_Params = interface(IUnknown)
  {* Параметры для операции Rubricator.SetListRoot }
   ['{08AEB6DA-F51C-4D30-871E-FF19E1935A99}']
   function Get_Node: Il3SimpleNode;
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   property Node: Il3SimpleNode
     read Get_Node;
     {* undefined }
   property RootToKeep: INodeBase
     read Get_RootToKeep;
     {* undefined }
   property MenuSectionItemToKeep: ISectionItem
     read Get_MenuSectionItemToKeep;
     {* undefined }
 end;//IRubricator_SetListRoot_Params

 Op_Rubricator_SetListRoot = class
  {* Класс для вызова операции Rubricator.SetListRoot }
 public
 // public methods
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

 IRubricator_InitListRoot_Params = interface(IUnknown)
  {* Параметры для операции Rubricator.InitListRoot }
   ['{A4493419-E50F-4EFC-9B58-CA180C218275}']
   function Get_Node: Il3SimpleNode;
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   property Node: Il3SimpleNode
     read Get_Node;
     {* undefined }
   property RootToKeep: INodeBase
     read Get_RootToKeep;
     {* undefined }
   property MenuSectionItemToKeep: ISectionItem
     read Get_MenuSectionItemToKeep;
     {* undefined }
 end;//IRubricator_InitListRoot_Params

 Op_Rubricator_InitListRoot = class
  {* Класс для вызова операции Rubricator.InitListRoot }
 public
 // public methods
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

 Op_Rubricator_Synchronize = class
  {* Класс для вызова операции Rubricator.Synchronize }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Rubricator.Synchronize у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Rubricator.Synchronize у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Rubricator.Synchronize у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Rubricator.Synchronize у контейнера }
 end;//Op_Rubricator_Synchronize

 IRubricator_GetRoot_Params = interface(IUnknown)
  {* Параметры для операции Rubricator.GetRoot }
   ['{E6D245F3-C0B0-41E0-AAD9-9913FA991580}']
   function Get_ResultValue: Il3SimpleNode;
   procedure Set_ResultValue(const aValue: Il3SimpleNode);
   property ResultValue: Il3SimpleNode
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IRubricator_GetRoot_Params

 Op_Rubricator_GetRoot = class
  {* Класс для вызова операции Rubricator.GetRoot }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Il3SimpleNode; overload; 
     {* Вызов операции Rubricator.GetRoot у сущности }
   class function Call(const aTarget: IvcmAggregate): Il3SimpleNode; overload; 
     {* Вызов операции Rubricator.GetRoot у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Il3SimpleNode; overload; 
     {* Вызов операции Rubricator.GetRoot у формы }
   class function Call(const aTarget: IvcmContainer): Il3SimpleNode; overload; 
     {* Вызов операции Rubricator.GetRoot у контейнера }
 end;//Op_Rubricator_GetRoot
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TRubricator_SetListRoot_Params = class(Tl3CProtoObject, IRubricator_SetListRoot_Params)
  {* Реализация IRubricator_SetListRoot_Params }
 private
 // private fields
   f_Node : Il3SimpleNode;
   f_RootToKeep : INodeBase;
   f_MenuSectionItemToKeep : ISectionItem;
 protected
 // realized methods
   function Get_MenuSectionItemToKeep: ISectionItem;
   function Get_RootToKeep: INodeBase;
   function Get_Node: Il3SimpleNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
     {* Конструктор TRubricator_SetListRoot_Params }
   class function Make(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): IRubricator_SetListRoot_Params; reintroduce;
     {* Фабрика TRubricator_SetListRoot_Params }
 end;//TRubricator_SetListRoot_Params

// start class TRubricator_SetListRoot_Params

constructor TRubricator_SetListRoot_Params.Create(const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem);
 {-}
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
end;

function TRubricator_SetListRoot_Params.Get_MenuSectionItemToKeep: ISectionItem;
 {-}
begin
 Result := f_MenuSectionItemToKeep;
end;//TRubricator_SetListRoot_Params.Get_MenuSectionItemToKeep

function TRubricator_SetListRoot_Params.Get_RootToKeep: INodeBase;
 {-}
begin
 Result := f_RootToKeep;
end;//TRubricator_SetListRoot_Params.Get_RootToKeep

function TRubricator_SetListRoot_Params.Get_Node: Il3SimpleNode;
 {-}
begin
 Result := f_Node;
end;//TRubricator_SetListRoot_Params.Get_Node

procedure TRubricator_SetListRoot_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_RootToKeep := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_MenuSectionItemToKeep := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TRubricator_SetListRoot_Params.ClearFields
// start class Op_Rubricator_SetListRoot

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmEntity;
  const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_SetListRoot_Params.Make(aNode,aRootToKeep,aMenuSectionItemToKeep));
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_SetListRoot_Params.Make(aNode,aRootToKeep,aMenuSectionItemToKeep));
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_SetListRoot.Call

class function Op_Rubricator_SetListRoot.Call(const aTarget: IvcmContainer;
  const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_SetListRoot.Call

type
 TRubricator_InitListRoot_Params = class(Tl3CProtoObject, IRubricator_InitListRoot_Params)
  {* Реализация IRubricator_InitListRoot_Params }
 private
 // private fields
   f_Node : Il3SimpleNode;
   f_RootToKeep : INodeBase;
   f_MenuSectionItemToKeep : ISectionItem;
 protected
 // realized methods
   function Get_RootToKeep: INodeBase;
   function Get_MenuSectionItemToKeep: ISectionItem;
   function Get_Node: Il3SimpleNode;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem); reintroduce;
     {* Конструктор TRubricator_InitListRoot_Params }
   class function Make(const aNode: Il3SimpleNode;
    const aRootToKeep: INodeBase;
    const aMenuSectionItemToKeep: ISectionItem): IRubricator_InitListRoot_Params; reintroduce;
     {* Фабрика TRubricator_InitListRoot_Params }
 end;//TRubricator_InitListRoot_Params

// start class TRubricator_InitListRoot_Params

constructor TRubricator_InitListRoot_Params.Create(const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem);
 {-}
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
end;

function TRubricator_InitListRoot_Params.Get_RootToKeep: INodeBase;
 {-}
begin
 Result := f_RootToKeep;
end;//TRubricator_InitListRoot_Params.Get_RootToKeep

function TRubricator_InitListRoot_Params.Get_MenuSectionItemToKeep: ISectionItem;
 {-}
begin
 Result := f_MenuSectionItemToKeep;
end;//TRubricator_InitListRoot_Params.Get_MenuSectionItemToKeep

function TRubricator_InitListRoot_Params.Get_Node: Il3SimpleNode;
 {-}
begin
 Result := f_Node;
end;//TRubricator_InitListRoot_Params.Get_Node

procedure TRubricator_InitListRoot_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Node := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_RootToKeep := nil;
 {$IfEnd} //not Admin AND not Monitorings
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_MenuSectionItemToKeep := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TRubricator_InitListRoot_Params.ClearFields
// start class Op_Rubricator_InitListRoot

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmEntity;
  const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_InitListRoot_Params.Make(aNode,aRootToKeep,aMenuSectionItemToKeep));
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
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TRubricator_InitListRoot_Params.Make(aNode,aRootToKeep,aMenuSectionItemToKeep));
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_InitListRoot.Call

class function Op_Rubricator_InitListRoot.Call(const aTarget: IvcmContainer;
  const aNode: Il3SimpleNode;
  const aRootToKeep: INodeBase;
  const aMenuSectionItemToKeep: ISectionItem): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aNode, aRootToKeep, aMenuSectionItemToKeep);
end;//Op_Rubricator_InitListRoot.Call
// start class Op_Rubricator_Synchronize

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Rubricator_Synchronize.Call

class function Op_Rubricator_Synchronize.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Rubricator_Synchronize.Call

type
 TRubricator_GetRoot_Params = class(Tl3CProtoObject, IRubricator_GetRoot_Params)
  {* Реализация IRubricator_GetRoot_Params }
 private
 // private fields
   f_ResultValue : Il3SimpleNode;
 protected
 // realized methods
   function Get_ResultValue: Il3SimpleNode;
   procedure Set_ResultValue(const aValue: Il3SimpleNode);
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create; reintroduce;
     {* Конструктор TRubricator_GetRoot_Params }
   class function Make: IRubricator_GetRoot_Params; reintroduce;
     {* Фабрика TRubricator_GetRoot_Params }
 end;//TRubricator_GetRoot_Params

// start class TRubricator_GetRoot_Params

constructor TRubricator_GetRoot_Params.Create;
 {-}
begin
 inherited Create;
end;//TRubricator_GetRoot_Params.Create

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
end;

function TRubricator_GetRoot_Params.Get_ResultValue: Il3SimpleNode;
 {-}
begin
 Result := f_ResultValue;
end;//TRubricator_GetRoot_Params.Get_ResultValue

procedure TRubricator_GetRoot_Params.Set_ResultValue(const aValue: Il3SimpleNode);
 {-}
begin
 f_ResultValue := aValue;
end;//TRubricator_GetRoot_Params.Set_ResultValue

procedure TRubricator_GetRoot_Params.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_ResultValue := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TRubricator_GetRoot_Params.ClearFields
// start class Op_Rubricator_GetRoot

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmEntity): Il3SimpleNode;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Rubricator_GetRoot.Call

class function Op_Rubricator_GetRoot.Call(const aTarget: IvcmContainer): Il3SimpleNode;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Rubricator_GetRoot.Call
{$IfEnd} //not Admin AND not Monitorings


end.