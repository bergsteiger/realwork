unit Search_ScalingSupport_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View$For F1 and Monitorings"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search_ScalingSupport_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::ScalingSupport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  l3CProtoObject
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

type
 TCanChangeScale = (
   ccsUnknown
 , ccsNo
 , ccsYes
 , ccsYesIfPossible
 );//TCanChangeScale

(* Scalable = operations
  {* Масштабируемый объект }
   ['{0CE5ACBF-CAB7-4200-B628-2E6EC058514D}']
   query ChangeScale(aInc: Boolean): Boolean;
     {* Изменить масштаб }
   query CanChangeScale(anInc: Boolean): TCanChangeScale;
     {* Масштабирование запрещено }
 end;//Scalable*)

 IScalable_ChangeScale_Params = interface(IUnknown)
  {* Параметры для операции Scalable.ChangeScale }
   ['{9E4E6D77-C687-4BAE-BB0F-50404EDCFC48}']
   function Get_Inc: Boolean;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
   property Inc: Boolean
     read Get_Inc;
     {* undefined }
   property ResultValue: Boolean
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IScalable_ChangeScale_Params

 Op_Scalable_ChangeScale = class
  {* Класс для вызова операции Scalable.ChangeScale }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    aInc: Boolean): Boolean; overload; 
     {* Вызов операции Scalable.ChangeScale у сущности }
   class function Call(const aTarget: IvcmAggregate;
    aInc: Boolean): Boolean; overload; 
     {* Вызов операции Scalable.ChangeScale у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    aInc: Boolean): Boolean; overload; 
     {* Вызов операции Scalable.ChangeScale у формы }
   class function Call(const aTarget: IvcmContainer;
    aInc: Boolean): Boolean; overload; 
     {* Вызов операции Scalable.ChangeScale у контейнера }
 end;//Op_Scalable_ChangeScale

 IScalable_CanChangeScale_Params = interface(IUnknown)
  {* Параметры для операции Scalable.CanChangeScale }
   ['{4065276A-A0EE-41AB-A50F-3B65D3263E75}']
   function Get_NInc: Boolean;
   function Get_ResultValue: TCanChangeScale;
   procedure Set_ResultValue(aValue: TCanChangeScale);
   property nInc: Boolean
     read Get_NInc;
     {* undefined }
   property ResultValue: TCanChangeScale
     read Get_ResultValue
     write Set_ResultValue;
     {* undefined }
 end;//IScalable_CanChangeScale_Params

 Op_Scalable_CanChangeScale = class
  {* Класс для вызова операции Scalable.CanChangeScale }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity;
    anInc: Boolean): TCanChangeScale; overload; 
     {* Вызов операции Scalable.CanChangeScale у сущности }
   class function Call(const aTarget: IvcmAggregate;
    anInc: Boolean): TCanChangeScale; overload; 
     {* Вызов операции Scalable.CanChangeScale у агрегации }
   class function Call(const aTarget: IvcmEntityForm;
    anInc: Boolean): TCanChangeScale; overload; 
     {* Вызов операции Scalable.CanChangeScale у формы }
   class function Call(const aTarget: IvcmContainer;
    anInc: Boolean): TCanChangeScale; overload; 
     {* Вызов операции Scalable.CanChangeScale у контейнера }
 end;//Op_Scalable_CanChangeScale
{$IfEnd} //not Admin

{$If not defined(Admin)}
const
 en_Scalable = 'Scalable';
 en_capScalable = 'Масштабируемый объект';
 op_ChangeScale = 'ChangeScale';
 op_capChangeScale = 'Изменить масштаб';
 op_CanChangeScale = 'CanChangeScale';
 op_capCanChangeScale = 'Масштабирование запрещено';
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
 TScalable_ChangeScale_Params = class(Tl3CProtoObject, IScalable_ChangeScale_Params)
  {* Реализация IScalable_ChangeScale_Params }
 private
 // private fields
   f_Inc : Boolean;
   f_ResultValue : Boolean;
 protected
 // realized methods
   function Get_Inc: Boolean;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
 public
 // public methods
   constructor Create(aInc: Boolean); reintroduce;
     {* Конструктор TScalable_ChangeScale_Params }
   class function Make(aInc: Boolean): IScalable_ChangeScale_Params; reintroduce;
     {* Фабрика TScalable_ChangeScale_Params }
 end;//TScalable_ChangeScale_Params

// start class TScalable_ChangeScale_Params

constructor TScalable_ChangeScale_Params.Create(aInc: Boolean);
 {-}
begin
 inherited Create;
 f_Inc := aInc;
end;//TScalable_ChangeScale_Params.Create

class function TScalable_ChangeScale_Params.Make(aInc: Boolean): IScalable_ChangeScale_Params;
var
 l_Inst : TScalable_ChangeScale_Params;
begin
 l_Inst := Create(aInc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TScalable_ChangeScale_Params.Get_Inc: Boolean;
 {-}
begin
 Result := f_Inc;
end;//TScalable_ChangeScale_Params.Get_Inc

function TScalable_ChangeScale_Params.Get_ResultValue: Boolean;
 {-}
begin
 Result := f_ResultValue;
end;//TScalable_ChangeScale_Params.Get_ResultValue

procedure TScalable_ChangeScale_Params.Set_ResultValue(aValue: Boolean);
 {-}
begin
 f_ResultValue := aValue;
end;//TScalable_ChangeScale_Params.Set_ResultValue
// start class Op_Scalable_ChangeScale

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmEntity;
  aInc: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TScalable_ChangeScale_Params.Make(aInc));
  aTarget.Operation(TdmStdRes.opcode_Scalable_ChangeScale, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IScalable_ChangeScale_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmAggregate;
  aInc: Boolean): Boolean;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TScalable_ChangeScale_Params.Make(aInc));
  aTarget.Operation(TdmStdRes.opcode_Scalable_ChangeScale, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IScalable_ChangeScale_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmEntityForm;
  aInc: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aInc);
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmContainer;
  aInc: Boolean): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aInc);
end;//Op_Scalable_ChangeScale.Call

type
 TScalable_CanChangeScale_Params = class(Tl3CProtoObject, IScalable_CanChangeScale_Params)
  {* Реализация IScalable_CanChangeScale_Params }
 private
 // private fields
   f_nInc : Boolean;
   f_ResultValue : TCanChangeScale;
 protected
 // realized methods
   function Get_NInc: Boolean;
   function Get_ResultValue: TCanChangeScale;
   procedure Set_ResultValue(aValue: TCanChangeScale);
 public
 // public methods
   constructor Create(anInc: Boolean); reintroduce;
     {* Конструктор TScalable_CanChangeScale_Params }
   class function Make(anInc: Boolean): IScalable_CanChangeScale_Params; reintroduce;
     {* Фабрика TScalable_CanChangeScale_Params }
 end;//TScalable_CanChangeScale_Params

// start class TScalable_CanChangeScale_Params

constructor TScalable_CanChangeScale_Params.Create(anInc: Boolean);
 {-}
begin
 inherited Create;
 f_nInc := anInc;
end;//TScalable_CanChangeScale_Params.Create

class function TScalable_CanChangeScale_Params.Make(anInc: Boolean): IScalable_CanChangeScale_Params;
var
 l_Inst : TScalable_CanChangeScale_Params;
begin
 l_Inst := Create(anInc);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TScalable_CanChangeScale_Params.Get_NInc: Boolean;
 {-}
begin
 Result := f_nInc;
end;//TScalable_CanChangeScale_Params.Get_NInc

function TScalable_CanChangeScale_Params.Get_ResultValue: TCanChangeScale;
 {-}
begin
 Result := f_ResultValue;
end;//TScalable_CanChangeScale_Params.Get_ResultValue

procedure TScalable_CanChangeScale_Params.Set_ResultValue(aValue: TCanChangeScale);
 {-}
begin
 f_ResultValue := aValue;
end;//TScalable_CanChangeScale_Params.Set_ResultValue
// start class Op_Scalable_CanChangeScale

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmEntity;
  anInc: Boolean): TCanChangeScale;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TScalable_CanChangeScale_Params.Make(anInc));
  aTarget.Operation(TdmStdRes.opcode_Scalable_CanChangeScale, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IScalable_CanChangeScale_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmAggregate;
  anInc: Boolean): TCanChangeScale;
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := TvcmExecuteParams.MakeForInternal(TScalable_CanChangeScale_Params.Make(anInc));
  aTarget.Operation(TdmStdRes.opcode_Scalable_CanChangeScale, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := IScalable_CanChangeScale_Params(Data).ResultValue;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmEntityForm;
  anInc: Boolean): TCanChangeScale;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anInc);
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmContainer;
  anInc: Boolean): TCanChangeScale;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anInc);
end;//Op_Scalable_CanChangeScale.Call
{$IfEnd} //not Admin


end.