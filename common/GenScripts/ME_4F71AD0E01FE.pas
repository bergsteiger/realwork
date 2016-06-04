unit F1Like_InternalOperations_Controls;

// Модуль: "w:\common\components\gui\Garant\VCM\View\F1Like_InternalOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "InternalOperations" MUID: (4F71AD0E01FE)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 ISwitcher_BecomeActive_Params = interface
  {* Параметры для операции Switcher.BecomeActive }
  function Get_Form: IvcmEntityForm;
  property Form: IvcmEntityForm
   read Get_Form;
 end;//ISwitcher_BecomeActive_Params

 Op_Switcher_BecomeActive = {final} class
  {* Класс для вызова операции Switcher.BecomeActive }
  public
   class function Call(const aTarget: IvcmEntity;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у сущности }
   class function Call(const aTarget: IvcmAggregate;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у формы }
   class function Call(const aTarget: IvcmContainer;
    const aForm: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.BecomeActive у контейнера }
 end;//Op_Switcher_BecomeActive

 Op_Switcher_SetFirstPageActive = {final} class
  {* Класс для вызова операции Switcher.SetFirstPageActive }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции Switcher.SetFirstPageActive у контейнера }
 end;//Op_Switcher_SetFirstPageActive

 ICommon_ShowSplitter_Params = interface
  {* Параметры для операции Common.ShowSplitter }
  function Get_Visible: Boolean;
  property Visible: Boolean
   read Get_Visible;
 end;//ICommon_ShowSplitter_Params

 Op_Common_ShowSplitter = {final} class
  {* Класс для вызова операции Common.ShowSplitter }
  public
   class function Call(const aTarget: IvcmEntity;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у формы }
   class function Call(const aTarget: IvcmContainer;
    aVisible: Boolean): Boolean; overload;
    {* Вызов операции Common.ShowSplitter у контейнера }
 end;//Op_Common_ShowSplitter

 ICommon_CheckChildZone_Params = interface
  {* Параметры для операции Common.CheckChildZone }
  function Get_Toggle: Boolean;
  property Toggle: Boolean
   read Get_Toggle;
 end;//ICommon_CheckChildZone_Params

 Op_Common_CheckChildZone = {final} class
  {* Класс для вызова операции Common.CheckChildZone }
  public
   class function Call(const aTarget: IvcmEntity;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у формы }
   class function Call(const aTarget: IvcmContainer;
    aToggle: Boolean): Boolean; overload;
    {* Вызов операции Common.CheckChildZone у контейнера }
 end;//Op_Common_CheckChildZone

const
 en_Switcher = 'Switcher';
 en_capSwitcher = 'Сущность для управления закладками формы-контейнера';
 op_BecomeActive = 'BecomeActive';
 op_capBecomeActive = '';
 op_SetFirstPageActive = 'SetFirstPageActive';
 op_capSetFirstPageActive = '';
 en_Common = 'Common';
 en_capCommon = '';
 op_ShowSplitter = 'ShowSplitter';
 op_capShowSplitter = '';
 op_CheckChildZone = 'CheckChildZone';
 op_capCheckChildZone = '';

implementation

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
 TSwitcher_BecomeActive_Params = {final} class(Tl3CProtoObject, ISwitcher_BecomeActive_Params)
  {* Реализация ISwitcher_BecomeActive_Params }
  private
   f_Form: IvcmEntityForm;
  protected
   function Get_Form: IvcmEntityForm;
   procedure ClearFields; override;
  public
   constructor Create(const aForm: IvcmEntityForm); reintroduce;
   class function Make(const aForm: IvcmEntityForm): ISwitcher_BecomeActive_Params; reintroduce;
 end;//TSwitcher_BecomeActive_Params

 TCommon_ShowSplitter_Params = {final} class(Tl3CProtoObject, ICommon_ShowSplitter_Params)
  {* Реализация ICommon_ShowSplitter_Params }
  private
   f_Visible: Boolean;
  protected
   function Get_Visible: Boolean;
  public
   constructor Create(aVisible: Boolean); reintroduce;
   class function Make(aVisible: Boolean): ICommon_ShowSplitter_Params; reintroduce;
 end;//TCommon_ShowSplitter_Params

 TCommon_CheckChildZone_Params = {final} class(Tl3CProtoObject, ICommon_CheckChildZone_Params)
  {* Реализация ICommon_CheckChildZone_Params }
  private
   f_Toggle: Boolean;
  protected
   function Get_Toggle: Boolean;
  public
   constructor Create(aToggle: Boolean); reintroduce;
   class function Make(aToggle: Boolean): ICommon_CheckChildZone_Params; reintroduce;
 end;//TCommon_CheckChildZone_Params

constructor TSwitcher_BecomeActive_Params.Create(const aForm: IvcmEntityForm);
begin
 inherited Create;
 f_Form := aForm;
end;//TSwitcher_BecomeActive_Params.Create

class function TSwitcher_BecomeActive_Params.Make(const aForm: IvcmEntityForm): ISwitcher_BecomeActive_Params;
var
 l_Inst : TSwitcher_BecomeActive_Params;
begin
 l_Inst := Create(aForm);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TSwitcher_BecomeActive_Params.Make

function TSwitcher_BecomeActive_Params.Get_Form: IvcmEntityForm;
begin
 Result := f_Form;
end;//TSwitcher_BecomeActive_Params.Get_Form

procedure TSwitcher_BecomeActive_Params.ClearFields;
begin
 f_Form := nil;
 inherited;
end;//TSwitcher_BecomeActive_Params.ClearFields

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntity;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSwitcher_BecomeActive_Params.Make(aForm));
  aTarget.Operation(TdmStdRes.opcode_Switcher_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmAggregate;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TSwitcher_BecomeActive_Params.Make(aForm));
  aTarget.Operation(TdmStdRes.opcode_Switcher_BecomeActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntityForm;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aForm);
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmContainer;
 const aForm: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.BecomeActive у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aForm);
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Switcher_SetFirstPageActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_Switcher_SetFirstPageActive, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции Switcher.SetFirstPageActive у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Switcher_SetFirstPageActive.Call

constructor TCommon_ShowSplitter_Params.Create(aVisible: Boolean);
begin
 inherited Create;
 f_Visible := aVisible;
end;//TCommon_ShowSplitter_Params.Create

class function TCommon_ShowSplitter_Params.Make(aVisible: Boolean): ICommon_ShowSplitter_Params;
var
 l_Inst : TCommon_ShowSplitter_Params;
begin
 l_Inst := Create(aVisible);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TCommon_ShowSplitter_Params.Make

function TCommon_ShowSplitter_Params.Get_Visible: Boolean;
begin
 Result := f_Visible;
end;//TCommon_ShowSplitter_Params.Get_Visible

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmEntity;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TCommon_ShowSplitter_Params.Make(aVisible));
  aTarget.Operation(TdmStdRes.opcode_Common_ShowSplitter, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmAggregate;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TCommon_ShowSplitter_Params.Make(aVisible));
  aTarget.Operation(TdmStdRes.opcode_Common_ShowSplitter, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmEntityForm;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aVisible);
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmContainer;
 aVisible: Boolean): Boolean;
 {* Вызов операции Common.ShowSplitter у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aVisible);
end;//Op_Common_ShowSplitter.Call

constructor TCommon_CheckChildZone_Params.Create(aToggle: Boolean);
begin
 inherited Create;
 f_Toggle := aToggle;
end;//TCommon_CheckChildZone_Params.Create

class function TCommon_CheckChildZone_Params.Make(aToggle: Boolean): ICommon_CheckChildZone_Params;
var
 l_Inst : TCommon_CheckChildZone_Params;
begin
 l_Inst := Create(aToggle);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TCommon_CheckChildZone_Params.Make

function TCommon_CheckChildZone_Params.Get_Toggle: Boolean;
begin
 Result := f_Toggle;
end;//TCommon_CheckChildZone_Params.Get_Toggle

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmEntity;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TCommon_CheckChildZone_Params.Make(aToggle));
  aTarget.Operation(TdmStdRes.opcode_Common_CheckChildZone, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmAggregate;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TCommon_CheckChildZone_Params.Make(aToggle));
  aTarget.Operation(TdmStdRes.opcode_Common_CheckChildZone, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmEntityForm;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aToggle);
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmContainer;
 aToggle: Boolean): Boolean;
 {* Вызов операции Common.CheckChildZone у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aToggle);
end;//Op_Common_CheckChildZone.Call

end.
