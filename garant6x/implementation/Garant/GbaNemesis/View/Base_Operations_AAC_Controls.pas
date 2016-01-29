unit Base_Operations_AAC_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Base_Operations_AAC_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Core::Base Operations::View::AAC
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
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  evCustomEditorWindow,
  vtScrollBar,
  vcmExternalInterfaces {a}
  ;

(* AACTextContainer = operations({, Scrollbar в правой части должен располагаться на всю высоту, вместе с плашкой "напишите нам".})
   ['{07772026-7D05-41DD-8E5C-B71C2DFAA455}']
   query GetVScrollBar(aLeft: Boolean): TvtScrollBar;
   query SetJumpTo(aJumpTo: TevJumpToEvent);
 end;//AACTextContainer*)

type
 IAACTextContainer_GetVScrollBar_Params = interface(IUnknown)
  {* Параметры для операции AACTextContainer.GetVScrollBar }
   ['{D92D17BA-66ED-45D0-A44D-46B0A151F82F}']
   function Get_Left: Boolean;
   function Get_ResultValue: TvtScrollBar;
   procedure Set_ResultValue(aValue: TvtScrollBar);
   property Left: Boolean
     read Get_Left;
     {* undefined }
   property ResultValue: TvtScrollBar
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IAACTextContainer_GetVScrollBar_Params

 Op_AACTextContainer_GetVScrollBar = class
  {* Класс для вызова операции AACTextContainer.GetVScrollBar }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aLeft: Boolean): TvtScrollBar; overload; 
     {* Вызов операции AACTextContainer.GetVScrollBar у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aLeft: Boolean): TvtScrollBar; overload; 
     {* Вызов операции AACTextContainer.GetVScrollBar у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aLeft: Boolean): TvtScrollBar; overload; 
     {* Вызов операции AACTextContainer.GetVScrollBar у формы }
   class function Call(const aTarget: IvcmContainer;
    aLeft: Boolean): TvtScrollBar; overload; 
     {* Вызов операции AACTextContainer.GetVScrollBar у контейнера }
 end;//Op_AACTextContainer_GetVScrollBar

 IAACTextContainer_SetJumpTo_Params = interface(IUnknown)
  {* Параметры для операции AACTextContainer.SetJumpTo }
   ['{AA22C948-B816-4987-8949-17CE74250FCC}']
   function Get_JumpTo: TevJumpToEvent;
   property JumpTo: TevJumpToEvent
     read Get_JumpTo;
     {* undefined }
 end;//IAACTextContainer_SetJumpTo_Params

 Op_AACTextContainer_SetJumpTo = class
  {* Класс для вызова операции AACTextContainer.SetJumpTo }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aJumpTo: TevJumpToEvent): Boolean; overload; 
     {* Вызов операции AACTextContainer.SetJumpTo у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aJumpTo: TevJumpToEvent): Boolean; overload; 
     {* Вызов операции AACTextContainer.SetJumpTo у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aJumpTo: TevJumpToEvent): Boolean; overload; 
     {* Вызов операции AACTextContainer.SetJumpTo у формы }
   class function Call(const aTarget: IvcmContainer;
    aJumpTo: TevJumpToEvent): Boolean; overload; 
     {* Вызов операции AACTextContainer.SetJumpTo у контейнера }
 end;//Op_AACTextContainer_SetJumpTo
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_AACTextContainer = 'AACTextContainer';
 en_capAACTextContainer = '';
 op_GetVScrollBar = 'GetVScrollBar';
 op_capGetVScrollBar = '';
 op_SetJumpTo = 'SetJumpTo';
 op_capSetJumpTo = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TAACTextContainer_GetVScrollBar_Params = class(Tl3CProtoObject, IAACTextContainer_GetVScrollBar_Params)
  {* Реализация IAACTextContainer_GetVScrollBar_Params }
 private
 // private fields
   f_Left : Boolean;
   f_ResultValue : TvtScrollBar;
 protected
 // realized methods
   function Get_ResultValue: TvtScrollBar;
   procedure Set_ResultValue(aValue: TvtScrollBar);
   function Get_Left: Boolean;
 public
 // public methods
   constructor Create(aLeft: Boolean); reintroduce;
     {* Конструктор TAACTextContainer_GetVScrollBar_Params }
   class function Make(aLeft: Boolean): IAACTextContainer_GetVScrollBar_Params; reintroduce;
     {* Фабрика TAACTextContainer_GetVScrollBar_Params }
 end;//TAACTextContainer_GetVScrollBar_Params

// start class TAACTextContainer_GetVScrollBar_Params

constructor TAACTextContainer_GetVScrollBar_Params.Create(aLeft: Boolean);
 {-}
begin
 inherited Create;
 f_Left := aLeft;
end;//TAACTextContainer_GetVScrollBar_Params.Create

class function TAACTextContainer_GetVScrollBar_Params.Make(aLeft: Boolean): IAACTextContainer_GetVScrollBar_Params;
var
 l_Inst : TAACTextContainer_GetVScrollBar_Params;
begin
 l_Inst := Create(aLeft);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TAACTextContainer_GetVScrollBar_Params.Get_ResultValue: TvtScrollBar;
 {-}
begin
 Result := f_ResultValue;
end;//TAACTextContainer_GetVScrollBar_Params.Get_ResultValue

procedure TAACTextContainer_GetVScrollBar_Params.Set_ResultValue(aValue: TvtScrollBar);
 {-}
begin
 f_ResultValue := aValue;
end;//TAACTextContainer_GetVScrollBar_Params.Set_ResultValue

function TAACTextContainer_GetVScrollBar_Params.Get_Left: Boolean;
 {-}
begin
 Result := f_Left;
end;//TAACTextContainer_GetVScrollBar_Params.Get_Left
// start class Op_AACTextContainer_GetVScrollBar

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmEntity;
  aLeft: Boolean): TvtScrollBar;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_GetVScrollBar_Params.Make(aLeft));
  aTarget.Operation(TdmStdRes.opcode_AACTextContainer_GetVScrollBar, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IAACTextContainer_GetVScrollBar_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmAggregate;
  aLeft: Boolean): TvtScrollBar;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_GetVScrollBar_Params.Make(aLeft));
  aTarget.Operation(TdmStdRes.opcode_AACTextContainer_GetVScrollBar, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IAACTextContainer_GetVScrollBar_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmEntityForm;
  aLeft: Boolean): TvtScrollBar;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aLeft);
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmContainer;
  aLeft: Boolean): TvtScrollBar;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aLeft);
end;//Op_AACTextContainer_GetVScrollBar.Call

type
 TAACTextContainer_SetJumpTo_Params = class(Tl3CProtoObject, IAACTextContainer_SetJumpTo_Params)
  {* Реализация IAACTextContainer_SetJumpTo_Params }
 private
 // private fields
   f_JumpTo : TevJumpToEvent;
 protected
 // realized methods
   function Get_JumpTo: TevJumpToEvent;
 public
 // public methods
   constructor Create(aJumpTo: TevJumpToEvent); reintroduce;
     {* Конструктор TAACTextContainer_SetJumpTo_Params }
   class function Make(aJumpTo: TevJumpToEvent): IAACTextContainer_SetJumpTo_Params; reintroduce;
     {* Фабрика TAACTextContainer_SetJumpTo_Params }
 end;//TAACTextContainer_SetJumpTo_Params

// start class TAACTextContainer_SetJumpTo_Params

constructor TAACTextContainer_SetJumpTo_Params.Create(aJumpTo: TevJumpToEvent);
 {-}
begin
 inherited Create;
 f_JumpTo := aJumpTo;
end;//TAACTextContainer_SetJumpTo_Params.Create

class function TAACTextContainer_SetJumpTo_Params.Make(aJumpTo: TevJumpToEvent): IAACTextContainer_SetJumpTo_Params;
var
 l_Inst : TAACTextContainer_SetJumpTo_Params;
begin
 l_Inst := Create(aJumpTo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TAACTextContainer_SetJumpTo_Params.Get_JumpTo: TevJumpToEvent;
 {-}
begin
 Result := f_JumpTo;
end;//TAACTextContainer_SetJumpTo_Params.Get_JumpTo
// start class Op_AACTextContainer_SetJumpTo

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmEntity;
  aJumpTo: TevJumpToEvent): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_SetJumpTo_Params.Make(aJumpTo));
  aTarget.Operation(TdmStdRes.opcode_AACTextContainer_SetJumpTo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmAggregate;
  aJumpTo: TevJumpToEvent): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_SetJumpTo_Params.Make(aJumpTo));
  aTarget.Operation(TdmStdRes.opcode_AACTextContainer_SetJumpTo, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmEntityForm;
  aJumpTo: TevJumpToEvent): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aJumpTo);
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmContainer;
  aJumpTo: TevJumpToEvent): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aJumpTo);
end;//Op_AACTextContainer_SetJumpTo.Call
{$IfEnd} //not Admin AND not Monitorings


end.