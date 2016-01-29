unit F1Like_InternalOperations_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/common/components/gui/Garant/VCM/View/F1Like_InternalOperations_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> Shared Delphi F1 Like Application::F1Like::View::InternalOperations
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3CProtoObject,
  vcmExternalInterfaces {a}
  ;

(* Switcher = operations
  {* Сущность для управления закладками формы-контейнера }
   ['{62B70A4A-7796-47CF-A637-933518E72425}']
   query BecomeActive(const aForm: IvcmEntityForm);
   query SetFirstPageActive;
 end;//Switcher*)

(* Common = operations
   ['{D0B715FD-AF53-458D-95BB-6B65BDD1D01D}']
   query ShowSplitter(aVisible: Boolean);
   query CheckChildZone(aToggle: Boolean);
 end;//Common*)

type
 ISwitcher_BecomeActive_Params = interface(IUnknown)
  {* Параметры для операции Switcher.BecomeActive }
   ['{EF87C1B2-C651-415F-BB29-5A3843B62AE9}']
   function Get_Form: IvcmEntityForm;
   property Form: IvcmEntityForm
     read Get_Form;
     {* undefined }
 end;//ISwitcher_BecomeActive_Params

 Op_Switcher_BecomeActive = class
  {* Класс для вызова операции Switcher.BecomeActive }
 public
 // public methods
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

 Op_Switcher_SetFirstPageActive = class
  {* Класс для вызова операции Switcher.SetFirstPageActive }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции Switcher.SetFirstPageActive у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции Switcher.SetFirstPageActive у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции Switcher.SetFirstPageActive у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции Switcher.SetFirstPageActive у контейнера }
 end;//Op_Switcher_SetFirstPageActive

 ICommon_ShowSplitter_Params = interface(IUnknown)
  {* Параметры для операции Common.ShowSplitter }
   ['{AF74D4F2-0734-4719-BBD8-5E33BA04A510}']
   function Get_Visible: Boolean;
   property Visible: Boolean
     read Get_Visible;
     {* undefined }
 end;//ICommon_ShowSplitter_Params

 Op_Common_ShowSplitter = class
  {* Класс для вызова операции Common.ShowSplitter }
 public
 // public methods
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

 ICommon_CheckChildZone_Params = interface(IUnknown)
  {* Параметры для операции Common.CheckChildZone }
   ['{C0C35601-A404-4BE5-9C4D-376FA4AA3760}']
   function Get_Toggle: Boolean;
   property Toggle: Boolean
     read Get_Toggle;
     {* undefined }
 end;//ICommon_CheckChildZone_Params

 Op_Common_CheckChildZone = class
  {* Класс для вызова операции Common.CheckChildZone }
 public
 // public methods
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
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TSwitcher_BecomeActive_Params = class(Tl3CProtoObject, ISwitcher_BecomeActive_Params)
  {* Реализация ISwitcher_BecomeActive_Params }
 private
 // private fields
   f_Form : IvcmEntityForm;
 protected
 // realized methods
   function Get_Form: IvcmEntityForm;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aForm: IvcmEntityForm); reintroduce;
     {* Конструктор TSwitcher_BecomeActive_Params }
   class function Make(const aForm: IvcmEntityForm): ISwitcher_BecomeActive_Params; reintroduce;
     {* Фабрика TSwitcher_BecomeActive_Params }
 end;//TSwitcher_BecomeActive_Params

// start class TSwitcher_BecomeActive_Params

constructor TSwitcher_BecomeActive_Params.Create(const aForm: IvcmEntityForm);
 {-}
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
end;

function TSwitcher_BecomeActive_Params.Get_Form: IvcmEntityForm;
 {-}
begin
 Result := f_Form;
end;//TSwitcher_BecomeActive_Params.Get_Form

procedure TSwitcher_BecomeActive_Params.ClearFields;
 {-}
begin
 f_Form := nil;
 inherited;
end;//TSwitcher_BecomeActive_Params.ClearFields
// start class Op_Switcher_BecomeActive

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmEntity;
  const aForm: IvcmEntityForm): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aForm);
end;//Op_Switcher_BecomeActive.Call

class function Op_Switcher_BecomeActive.Call(const aTarget: IvcmContainer;
  const aForm: IvcmEntityForm): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aForm);
end;//Op_Switcher_BecomeActive.Call
// start class Op_Switcher_SetFirstPageActive

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_Switcher_SetFirstPageActive.Call

class function Op_Switcher_SetFirstPageActive.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_Switcher_SetFirstPageActive.Call

type
 TCommon_ShowSplitter_Params = class(Tl3CProtoObject, ICommon_ShowSplitter_Params)
  {* Реализация ICommon_ShowSplitter_Params }
 private
 // private fields
   f_Visible : Boolean;
 protected
 // realized methods
   function Get_Visible: Boolean;
 public
 // public methods
   constructor Create(aVisible: Boolean); reintroduce;
     {* Конструктор TCommon_ShowSplitter_Params }
   class function Make(aVisible: Boolean): ICommon_ShowSplitter_Params; reintroduce;
     {* Фабрика TCommon_ShowSplitter_Params }
 end;//TCommon_ShowSplitter_Params

// start class TCommon_ShowSplitter_Params

constructor TCommon_ShowSplitter_Params.Create(aVisible: Boolean);
 {-}
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
end;

function TCommon_ShowSplitter_Params.Get_Visible: Boolean;
 {-}
begin
 Result := f_Visible;
end;//TCommon_ShowSplitter_Params.Get_Visible
// start class Op_Common_ShowSplitter

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmEntity;
  aVisible: Boolean): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aVisible);
end;//Op_Common_ShowSplitter.Call

class function Op_Common_ShowSplitter.Call(const aTarget: IvcmContainer;
  aVisible: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aVisible);
end;//Op_Common_ShowSplitter.Call

type
 TCommon_CheckChildZone_Params = class(Tl3CProtoObject, ICommon_CheckChildZone_Params)
  {* Реализация ICommon_CheckChildZone_Params }
 private
 // private fields
   f_Toggle : Boolean;
 protected
 // realized methods
   function Get_Toggle: Boolean;
 public
 // public methods
   constructor Create(aToggle: Boolean); reintroduce;
     {* Конструктор TCommon_CheckChildZone_Params }
   class function Make(aToggle: Boolean): ICommon_CheckChildZone_Params; reintroduce;
     {* Фабрика TCommon_CheckChildZone_Params }
 end;//TCommon_CheckChildZone_Params

// start class TCommon_CheckChildZone_Params

constructor TCommon_CheckChildZone_Params.Create(aToggle: Boolean);
 {-}
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
end;

function TCommon_CheckChildZone_Params.Get_Toggle: Boolean;
 {-}
begin
 Result := f_Toggle;
end;//TCommon_CheckChildZone_Params.Get_Toggle
// start class Op_Common_CheckChildZone

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmEntity;
  aToggle: Boolean): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aToggle);
end;//Op_Common_CheckChildZone.Call

class function Op_Common_CheckChildZone.Call(const aTarget: IvcmContainer;
  aToggle: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aToggle);
end;//Op_Common_CheckChildZone.Call

end.