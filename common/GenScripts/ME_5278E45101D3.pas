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
  ['{9E4E6D77-C687-4BAE-BB0F-50404EDCFC48}']
  function Get_Inc: Boolean;
  function Get_ResultValue: Boolean;
  procedure Set_ResultValue(aValue: Boolean);
  property Inc: Boolean
   read Get_Inc;
  property ResultValue: Boolean
   read Get_ResultValue
   write Set_ResultValue;
 end;//IScalable_ChangeScale_Params

 Op_Scalable_ChangeScale = class
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
  ['{4065276A-A0EE-41AB-A50F-3B65D3263E75}']
  function Get_nInc: Boolean;
  function Get_ResultValue: TCanChangeScale;
  procedure Set_ResultValue(aValue: TCanChangeScale);
  property nInc: Boolean
   read Get_nInc;
  property ResultValue: TCanChangeScale
   read Get_ResultValue
   write Set_ResultValue;
 end;//IScalable_CanChangeScale_Params

 Op_Scalable_CanChangeScale = class
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
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , l3CProtoObject
;

type
 TScalable_ChangeScale_Params = class(Tl3CProtoObject, IScalable_ChangeScale_Params)
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
    {* Конструктор TScalable_ChangeScale_Params }
   class function Make(aInc: Boolean): IScalable_ChangeScale_Params; reintroduce;
    {* Фабрика TScalable_ChangeScale_Params }
 end;//TScalable_ChangeScale_Params

 TScalable_CanChangeScale_Params = class(Tl3CProtoObject, IScalable_CanChangeScale_Params)
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
    {* Конструктор TScalable_CanChangeScale_Params }
   class function Make(anInc: Boolean): IScalable_CanChangeScale_Params; reintroduce;
    {* Фабрика TScalable_CanChangeScale_Params }
 end;//TScalable_CanChangeScale_Params

constructor TScalable_ChangeScale_Params.Create(aInc: Boolean);
 {* Конструктор TScalable_ChangeScale_Params }
//#UC START# *985CBC63003D_81AD64B9BA03_var*
//#UC END# *985CBC63003D_81AD64B9BA03_var*
begin
//#UC START# *985CBC63003D_81AD64B9BA03_impl*
 !!! Needs to be implemented !!!
//#UC END# *985CBC63003D_81AD64B9BA03_impl*
end;//TScalable_ChangeScale_Params.Create

class function TScalable_ChangeScale_Params.Make(aInc: Boolean): IScalable_ChangeScale_Params;
 {* Фабрика TScalable_ChangeScale_Params }
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
//#UC START# *24A6D91049DE_81AD64B9BA03get_var*
//#UC END# *24A6D91049DE_81AD64B9BA03get_var*
begin
//#UC START# *24A6D91049DE_81AD64B9BA03get_impl*
 !!! Needs to be implemented !!!
//#UC END# *24A6D91049DE_81AD64B9BA03get_impl*
end;//TScalable_ChangeScale_Params.Get_Inc

function TScalable_ChangeScale_Params.Get_ResultValue: Boolean;
//#UC START# *90C7E6911559_81AD64B9BA03get_var*
//#UC END# *90C7E6911559_81AD64B9BA03get_var*
begin
//#UC START# *90C7E6911559_81AD64B9BA03get_impl*
 !!! Needs to be implemented !!!
//#UC END# *90C7E6911559_81AD64B9BA03get_impl*
end;//TScalable_ChangeScale_Params.Get_ResultValue

procedure TScalable_ChangeScale_Params.Set_ResultValue(aValue: Boolean);
//#UC START# *90C7E6911559_81AD64B9BA03set_var*
//#UC END# *90C7E6911559_81AD64B9BA03set_var*
begin
//#UC START# *90C7E6911559_81AD64B9BA03set_impl*
 !!! Needs to be implemented !!!
//#UC END# *90C7E6911559_81AD64B9BA03set_impl*
end;//TScalable_ChangeScale_Params.Set_ResultValue

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmEntity;
 aInc: Boolean): Boolean;
 {* Вызов операции Scalable.ChangeScale у сущности }
//#UC START# *8A812A227C0E_25951C257B97_var*
//#UC END# *8A812A227C0E_25951C257B97_var*
begin
//#UC START# *8A812A227C0E_25951C257B97_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A812A227C0E_25951C257B97_impl*
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmAggregate;
 aInc: Boolean): Boolean;
 {* Вызов операции Scalable.ChangeScale у агрегации }
//#UC START# *BAC0EA12065E_25951C257B97_var*
//#UC END# *BAC0EA12065E_25951C257B97_var*
begin
//#UC START# *BAC0EA12065E_25951C257B97_impl*
 !!! Needs to be implemented !!!
//#UC END# *BAC0EA12065E_25951C257B97_impl*
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmEntityForm;
 aInc: Boolean): Boolean;
 {* Вызов операции Scalable.ChangeScale у формы }
//#UC START# *9BE14DE7BF75_25951C257B97_var*
//#UC END# *9BE14DE7BF75_25951C257B97_var*
begin
//#UC START# *9BE14DE7BF75_25951C257B97_impl*
 !!! Needs to be implemented !!!
//#UC END# *9BE14DE7BF75_25951C257B97_impl*
end;//Op_Scalable_ChangeScale.Call

class function Op_Scalable_ChangeScale.Call(const aTarget: IvcmContainer;
 aInc: Boolean): Boolean;
 {* Вызов операции Scalable.ChangeScale у контейнера }
//#UC START# *3EC6914F2E31_25951C257B97_var*
//#UC END# *3EC6914F2E31_25951C257B97_var*
begin
//#UC START# *3EC6914F2E31_25951C257B97_impl*
 !!! Needs to be implemented !!!
//#UC END# *3EC6914F2E31_25951C257B97_impl*
end;//Op_Scalable_ChangeScale.Call

constructor TScalable_CanChangeScale_Params.Create(anInc: Boolean);
 {* Конструктор TScalable_CanChangeScale_Params }
//#UC START# *8A9EA0F03618_1753199D1976_var*
//#UC END# *8A9EA0F03618_1753199D1976_var*
begin
//#UC START# *8A9EA0F03618_1753199D1976_impl*
 !!! Needs to be implemented !!!
//#UC END# *8A9EA0F03618_1753199D1976_impl*
end;//TScalable_CanChangeScale_Params.Create

class function TScalable_CanChangeScale_Params.Make(anInc: Boolean): IScalable_CanChangeScale_Params;
 {* Фабрика TScalable_CanChangeScale_Params }
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
//#UC START# *3EFDB3BD4B04_1753199D1976get_var*
//#UC END# *3EFDB3BD4B04_1753199D1976get_var*
begin
//#UC START# *3EFDB3BD4B04_1753199D1976get_impl*
 !!! Needs to be implemented !!!
//#UC END# *3EFDB3BD4B04_1753199D1976get_impl*
end;//TScalable_CanChangeScale_Params.Get_nInc

function TScalable_CanChangeScale_Params.Get_ResultValue: TCanChangeScale;
//#UC START# *AF00B961C300_1753199D1976get_var*
//#UC END# *AF00B961C300_1753199D1976get_var*
begin
//#UC START# *AF00B961C300_1753199D1976get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF00B961C300_1753199D1976get_impl*
end;//TScalable_CanChangeScale_Params.Get_ResultValue

procedure TScalable_CanChangeScale_Params.Set_ResultValue(aValue: TCanChangeScale);
//#UC START# *AF00B961C300_1753199D1976set_var*
//#UC END# *AF00B961C300_1753199D1976set_var*
begin
//#UC START# *AF00B961C300_1753199D1976set_impl*
 !!! Needs to be implemented !!!
//#UC END# *AF00B961C300_1753199D1976set_impl*
end;//TScalable_CanChangeScale_Params.Set_ResultValue

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmEntity;
 anInc: Boolean): TCanChangeScale;
 {* Вызов операции Scalable.CanChangeScale у сущности }
//#UC START# *0225FE012A4D_8565FBAA5A84_var*
//#UC END# *0225FE012A4D_8565FBAA5A84_var*
begin
//#UC START# *0225FE012A4D_8565FBAA5A84_impl*
 !!! Needs to be implemented !!!
//#UC END# *0225FE012A4D_8565FBAA5A84_impl*
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmAggregate;
 anInc: Boolean): TCanChangeScale;
 {* Вызов операции Scalable.CanChangeScale у агрегации }
//#UC START# *3265BDEFB49D_8565FBAA5A84_var*
//#UC END# *3265BDEFB49D_8565FBAA5A84_var*
begin
//#UC START# *3265BDEFB49D_8565FBAA5A84_impl*
 !!! Needs to be implemented !!!
//#UC END# *3265BDEFB49D_8565FBAA5A84_impl*
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmEntityForm;
 anInc: Boolean): TCanChangeScale;
 {* Вызов операции Scalable.CanChangeScale у формы }
//#UC START# *3B35EDE07BB7_8565FBAA5A84_var*
//#UC END# *3B35EDE07BB7_8565FBAA5A84_var*
begin
//#UC START# *3B35EDE07BB7_8565FBAA5A84_impl*
 !!! Needs to be implemented !!!
//#UC END# *3B35EDE07BB7_8565FBAA5A84_impl*
end;//Op_Scalable_CanChangeScale.Call

class function Op_Scalable_CanChangeScale.Call(const aTarget: IvcmContainer;
 anInc: Boolean): TCanChangeScale;
 {* Вызов операции Scalable.CanChangeScale у контейнера }
//#UC START# *6D9C781FFBF0_8565FBAA5A84_var*
//#UC END# *6D9C781FFBF0_8565FBAA5A84_var*
begin
//#UC START# *6D9C781FFBF0_8565FBAA5A84_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D9C781FFBF0_8565FBAA5A84_impl*
end;//Op_Scalable_CanChangeScale.Call
{$IfEnd} // NOT Defined(Admin)

end.
