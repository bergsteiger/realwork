unit Search_ScalingSupport_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search_ScalingSupport_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "ScalingSupport" MUID: (5278E45101D3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 TCanChangeScale = (
  ccsUnknown
  , ccsNo
  , ccsYes
  , ccsYesIfPossible
 );//TCanChangeScale

 IScalable_ChangeScale_Params = interface
  {* Параметры для операции Scalable.ChangeScale }
  function Get_Inc: Boolean;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Inc: Boolean
   read Get_Inc;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IScalable_ChangeScale_Params

 Op_Scalable_ChangeScale = {final} class
  {* Класс для вызова операции Scalable.ChangeScale }
  public
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

 IScalable_CanChangeScale_Params = interface
  {* Параметры для операции Scalable.CanChangeScale }
  function Get_nInc: Boolean;
  function Get_ResultValue: TCanChangeScale;
  procedure Set_ResultValue(aValue: TCanChangeScale);
  property nInc: Boolean
   read Get_nInc;
  property ResultValue: TCanChangeScale
   read Get_ResultValue
   write Set_ResultValue;
 end;//IScalable_CanChangeScale_Params

 Op_Scalable_CanChangeScale = {final} class
  {* Класс для вызова операции Scalable.CanChangeScale }
  public
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

const
 en_Scalable = 'Scalable';
 en_capScalable = 'Масштабируемый объект';
 op_ChangeScale = 'ChangeScale';
 op_capChangeScale = 'Изменить масштаб';
 op_CanChangeScale = 'CanChangeScale';
 op_capCanChangeScale = 'Масштабирование запрещено';
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
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
 TScalable_ChangeScale_Params = {final} class(Tl3CProtoObject, IScalable_ChangeScale_Params)
  {* Реализация IScalable_ChangeScale_Params }
  private
   f_Inc: Boolean;
   f_ResultValue: Boolean;
  protected
   function Get_Inc: Boolean;
   function Get_ResultValue: Boolean;
   procedure Set_ResultValue(aValue: Boolean);
  public
   constructor Create(aInc: Boolean); reintroduce;
   class function Make(aInc: Boolean): IScalable_ChangeScale_Params; reintroduce;
 end;//TScalable_ChangeScale_Params

 TScalable_CanChangeScale_Params = {final} class(Tl3CProtoObject, IScalable_CanChangeScale_Params)
  {* Реализация IScalable_CanChangeScale_Params }
  private
   f_nInc: Boolean;
   f_ResultValue: TCanChangeScale;
  protected
   function Get_nInc: Boolean;
   function Get_ResultValue: TCanChangeScale;
   procedure Set_ResultValue(aValue: TCanChangeScale);
  public
   constructor Create(anInc: Boolean); reintroduce;
   class function Make(anInc: Boolean): IScalable_CanChangeScale_Params; reintroduce;
 end;//TScalable_CanChangeScale_Params

constructor TScalable_ChangeScale_Params.Create(aInc: Boolean);
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
end;//TScalable_ChangeScale_Params.Make

function TScalable_ChangeScale_Params.Get_Inc: Boolean;
begin
 Result := f_Inc;
end;//TScalable_ChangeScale_Params.Get_Inc

function TScalable_ChangeScale_Params.Get_ResultValue: Boolean;
begin
 Result := f_ResultValue;
end;//TScalable_ChangeScale_Params.Get_ResultValue

procedure TScalable_ChangeScale_Params.Set_ResultValue(aValue: Boolean);
begin
 f_ResultValue := aValue;
end;//TScalable_ChangeScale_Params.Set_ResultValue

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmEntity;
 aInc: Boolean): Boolean;
 {* Вызов операции Scalable.ChangeScale у сущности }
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
 {* Вызов операции Scalable.ChangeScale у агрегации }
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
 {* Вызов операции Scalable.ChangeScale у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, aInc);
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmContainer;
 aInc: Boolean): Boolean;
 {* Вызов операции Scalable.ChangeScale у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, aInc);
end;//Op_Scalable_ChangeScale.Call

constructor TScalable_CanChangeScale_Params.Create(anInc: Boolean);
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
end;//TScalable_CanChangeScale_Params.Make

function TScalable_CanChangeScale_Params.Get_nInc: Boolean;
begin
 Result := f_nInc;
end;//TScalable_CanChangeScale_Params.Get_nInc

function TScalable_CanChangeScale_Params.Get_ResultValue: TCanChangeScale;
begin
 Result := f_ResultValue;
end;//TScalable_CanChangeScale_Params.Get_ResultValue

procedure TScalable_CanChangeScale_Params.Set_ResultValue(aValue: TCanChangeScale);
begin
 f_ResultValue := aValue;
end;//TScalable_CanChangeScale_Params.Set_ResultValue

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmEntity;
 anInc: Boolean): TCanChangeScale;
 {* Вызов операции Scalable.CanChangeScale у сущности }
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
 {* Вызов операции Scalable.CanChangeScale у агрегации }
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
 {* Вызов операции Scalable.CanChangeScale у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity, anInc);
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmContainer;
 anInc: Boolean): TCanChangeScale;
 {* Вызов операции Scalable.CanChangeScale у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm, anInc);
end;//Op_Scalable_CanChangeScale.Call
{$IfEnd} // NOT Defined(Admin)

end.
