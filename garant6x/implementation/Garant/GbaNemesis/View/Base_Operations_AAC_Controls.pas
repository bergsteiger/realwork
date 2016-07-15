unit Base_Operations_AAC_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Base_Operations_AAC_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "AAC" MUID: (50052359008A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , vtScrollBar
 , evCustomEditorWindow
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 IAACTextContainer_GetVScrollBar_Params = interface
  {* Параметры для операции AACTextContainer.GetVScrollBar }
  function Get_Left: Boolean;
  function Get_ResultValue: TvtScrollBar;
  procedure Set_ResultValue(aValue: TvtScrollBar);
  property Left: Boolean
   read Get_Left;
  property ResultValue: TvtScrollBar
   read Get_ResultValue
   write Set_ResultValue;
 end;//IAACTextContainer_GetVScrollBar_Params

 Op_AACTextContainer_GetVScrollBar = {final} class
  {* Класс для вызова операции AACTextContainer.GetVScrollBar }
  public
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

 IAACTextContainer_SetJumpTo_Params = interface
  {* Параметры для операции AACTextContainer.SetJumpTo }
  function Get_JumpTo: TevJumpToEvent;
  property JumpTo: TevJumpToEvent
   read Get_JumpTo;
 end;//IAACTextContainer_SetJumpTo_Params

 Op_AACTextContainer_SetJumpTo = {final} class
  {* Класс для вызова операции AACTextContainer.SetJumpTo }
  public
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

const
 en_AACTextContainer = 'AACTextContainer';
 en_capAACTextContainer = '';
 op_GetVScrollBar = 'GetVScrollBar';
 op_capGetVScrollBar = '';
 op_SetJumpTo = 'SetJumpTo';
 op_capSetJumpTo = '';

var opcode_AACTextContainer_GetVScrollBar: TvcmOPID = (rEnID : -1; rOpID : -1);
var opcode_AACTextContainer_SetJumpTo: TvcmOPID = (rEnID : -1; rOpID : -1);
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3CProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmOperationsForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmOperationStatesForRegister
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 TAACTextContainer_GetVScrollBar_Params = {final} class(Tl3CProtoObject, IAACTextContainer_GetVScrollBar_Params)
  {* Реализация IAACTextContainer_GetVScrollBar_Params }
  private
   f_Left: Boolean;
   f_ResultValue: TvtScrollBar;
  protected
   function Get_Left: Boolean;
   function Get_ResultValue: TvtScrollBar;
   procedure Set_ResultValue(aValue: TvtScrollBar);
  public
   constructor Create(aLeft: Boolean); reintroduce;
   class function Make(aLeft: Boolean): IAACTextContainer_GetVScrollBar_Params; reintroduce;
 end;//TAACTextContainer_GetVScrollBar_Params

 TAACTextContainer_SetJumpTo_Params = {final} class(Tl3CProtoObject, IAACTextContainer_SetJumpTo_Params)
  {* Реализация IAACTextContainer_SetJumpTo_Params }
  private
   f_JumpTo: TevJumpToEvent;
  protected
   function Get_JumpTo: TevJumpToEvent;
  public
   constructor Create(aJumpTo: TevJumpToEvent); reintroduce;
   class function Make(aJumpTo: TevJumpToEvent): IAACTextContainer_SetJumpTo_Params; reintroduce;
 end;//TAACTextContainer_SetJumpTo_Params

constructor TAACTextContainer_GetVScrollBar_Params.Create(aLeft: Boolean);
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
end;//TAACTextContainer_GetVScrollBar_Params.Make

function TAACTextContainer_GetVScrollBar_Params.Get_Left: Boolean;
begin
 Result := f_Left;
end;//TAACTextContainer_GetVScrollBar_Params.Get_Left

function TAACTextContainer_GetVScrollBar_Params.Get_ResultValue: TvtScrollBar;
begin
 Result := f_ResultValue;
end;//TAACTextContainer_GetVScrollBar_Params.Get_ResultValue

procedure TAACTextContainer_GetVScrollBar_Params.Set_ResultValue(aValue: TvtScrollBar);
begin
 f_ResultValue := aValue;
end;//TAACTextContainer_GetVScrollBar_Params.Set_ResultValue

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmEntity;
 aLeft: Boolean): TvtScrollBar;
 {* Вызов операции AACTextContainer.GetVScrollBar у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_GetVScrollBar_Params.Make(aLeft));
  aTarget.Operation(opcode_AACTextContainer_GetVScrollBar, l_Params);
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
 {* Вызов операции AACTextContainer.GetVScrollBar у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_GetVScrollBar_Params.Make(aLeft));
  aTarget.Operation(opcode_AACTextContainer_GetVScrollBar, l_Params);
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
 {* Вызов операции AACTextContainer.GetVScrollBar у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aLeft);
end;//Op_AACTextContainer_GetVScrollBar.Call

class function Op_AACTextContainer_GetVScrollBar.Call(const aTarget: IvcmContainer;
 aLeft: Boolean): TvtScrollBar;
 {* Вызов операции AACTextContainer.GetVScrollBar у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aLeft);
end;//Op_AACTextContainer_GetVScrollBar.Call

constructor TAACTextContainer_SetJumpTo_Params.Create(aJumpTo: TevJumpToEvent);
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
end;//TAACTextContainer_SetJumpTo_Params.Make

function TAACTextContainer_SetJumpTo_Params.Get_JumpTo: TevJumpToEvent;
begin
 Result := f_JumpTo;
end;//TAACTextContainer_SetJumpTo_Params.Get_JumpTo

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmEntity;
 aJumpTo: TevJumpToEvent): Boolean;
 {* Вызов операции AACTextContainer.SetJumpTo у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_SetJumpTo_Params.Make(aJumpTo));
  aTarget.Operation(opcode_AACTextContainer_SetJumpTo, l_Params);
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
 {* Вызов операции AACTextContainer.SetJumpTo у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TAACTextContainer_SetJumpTo_Params.Make(aJumpTo));
  aTarget.Operation(opcode_AACTextContainer_SetJumpTo, l_Params);
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
 {* Вызов операции AACTextContainer.SetJumpTo у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aJumpTo);
end;//Op_AACTextContainer_SetJumpTo.Call

class function Op_AACTextContainer_SetJumpTo.Call(const aTarget: IvcmContainer;
 aJumpTo: TevJumpToEvent): Boolean;
 {* Вызов операции AACTextContainer.SetJumpTo у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aJumpTo);
end;//Op_AACTextContainer_SetJumpTo.Call

initialization
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AACTextContainer, op_GetVScrollBar, en_capAACTextContainer, op_capGetVScrollBar, True, False, opcode_AACTextContainer_GetVScrollBar)) do
 begin
 end;
 with TvcmOperationsForRegister.AddOperation(TvcmOperationForRegister_C(en_AACTextContainer, op_SetJumpTo, en_capAACTextContainer, op_capSetJumpTo, True, False, opcode_AACTextContainer_SetJumpTo)) do
 begin
 end;

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
