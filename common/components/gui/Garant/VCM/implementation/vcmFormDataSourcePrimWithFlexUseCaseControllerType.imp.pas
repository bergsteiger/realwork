{$IfNDef vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSourcePrimWithFlexUseCaseControllerType
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}
{$If not defined(NoVCM)}
 _l3Notifier_Parent_ = Tl3ProtoObjectWithCOMQI;
 {$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}
 _vcmFormDataSourcePrimWithFlexUseCaseControllerType_ = {mixin} class(_l3Notifier_, IvcmFormDataSource, IvcmFormSetDataSourceListener)
 private
 // private fields
   f_DisplayName : IvcmCString;
    {* Вычисленный заголовок контроллера области ввода}
   f_UseCaseController : _UseCaseControllerType_;
    {* Поле для свойства UseCaseController}
 protected
 // realized methods
   procedure DataChanged;
     {* данные изменились }
   function IsSame(const aValue: IvcmFormDataSource): Boolean;
     {* проверка на равенство }
   function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
     {* является ли форма главной в сборке }
   function IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
     {* определим нужно ли менять позицию на данные }
   function pm_GetUseCaseController: IvcmFormSetDataSource;
   function CastUCC(const aGUID: TGUID;
    out theObj;
    NeedsException: Boolean = false): Boolean;
     {* Приводит контроллер прецедента к заданному интерфейсу. Это нужно, чтобы избавится от явного знания о контроллере прецедента. [$122674504] }
   function Get_DisplayName: IvcmCString;
   function IsDataAvailable: Boolean;
     {* существуют ли данные в текущих условиях. Например, на текущей базе. }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected methods
   function GetIsDataAvailable: Boolean; virtual;
     {* существуют ли данные }
   procedure ClearRefs; virtual;
     {* Очищает ссылки на различные представления прецедента }
   procedure FormSetDataChanged; virtual;
   function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean; virtual;
   function GetIsSame(const aValue: _FormDataSourceType_): Boolean; virtual;
   procedure InitRefs(const aDS: IvcmFormSetDataSource); virtual;
     {* Инициализирует ссылки на различные представления прецедента }
   function MakeDisplayName: IvcmCString; virtual;
 public
 // public methods
   constructor Create(const aDataSource: _UseCaseControllerType_); reintroduce;
   class function Make(const aDataSource: _UseCaseControllerType_): _FormDataSourceType_; reintroduce;
 protected
 // protected properties
   property UseCaseController: _UseCaseControllerType_
     read f_UseCaseController;
     {* Контроллер прецедента, в котором находится наша область ввода }
 end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_
{$Else}

 _l3Notifier_Parent_ = Tl3ProtoObjectWithCOMQI;
 {$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}
 _vcmFormDataSourcePrimWithFlexUseCaseControllerType_ = _l3Notifier_;

{$IfEnd} //not NoVCM

{$Else vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}

{$If not defined(NoVCM)}

{$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}

// start class _vcmFormDataSourcePrimWithFlexUseCaseControllerType_

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsDataAvailable: Boolean;
//#UC START# *55097FF5008E_5017EAF4027D_var*
//#UC END# *55097FF5008E_5017EAF4027D_var*
begin
//#UC START# *55097FF5008E_5017EAF4027D_impl*
 Result := True;
//#UC END# *55097FF5008E_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsDataAvailable

constructor _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Create(const aDataSource: _UseCaseControllerType_);
//#UC START# *492ACF3D0071_5017EAF4027D_var*
//#UC END# *492ACF3D0071_5017EAF4027D_var*
begin
//#UC START# *492ACF3D0071_5017EAF4027D_impl*
 inherited Create;
 f_UseCaseController := aDataSource;
 if (UseCaseController <> nil) then
 begin
  UseCaseController.As_Il3ChangeNotifier.Subscribe(IvcmFormSetDataSourceListener(Self));
  InitRefs(UseCaseController);
 end;//UseCaseController <> nil
//#UC END# *492ACF3D0071_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Create

class function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Make(const aDataSource: _UseCaseControllerType_): _FormDataSourceType_;
var
 l_Inst : _vcmFormDataSourcePrimWithFlexUseCaseControllerType_;
begin
 l_Inst := Create(aDataSource);
 try
  Result := _Instance_R_(l_Inst);
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.ClearRefs;
//#UC START# *49786D6A01E3_5017EAF4027D_var*
//#UC END# *49786D6A01E3_5017EAF4027D_var*
begin
//#UC START# *49786D6A01E3_5017EAF4027D_impl*
 // - нечего очищать
//#UC END# *49786D6A01E3_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.ClearRefs

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.FormSetDataChanged;
//#UC START# *491482DC0216_5017EAF4027D_var*
//#UC END# *491482DC0216_5017EAF4027D_var*
begin
//#UC START# *491482DC0216_5017EAF4027D_impl*
 // - ничего не делаем
//#UC END# *491482DC0216_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.FormSetDataChanged

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean;
//#UC START# *49147B4602C0_5017EAF4027D_var*
//#UC END# *49147B4602C0_5017EAF4027D_var*
begin
//#UC START# *49147B4602C0_5017EAF4027D_impl*
 Result := false;
//#UC END# *49147B4602C0_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsNeedChangePosition

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsSame(const aValue: _FormDataSourceType_): Boolean;
//#UC START# *49147FB4028C_5017EAF4027D_var*
//#UC END# *49147FB4028C_5017EAF4027D_var*
begin
//#UC START# *49147FB4028C_5017EAF4027D_impl*
 Result := false;
//#UC END# *49147FB4028C_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsSame

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.InitRefs(const aDS: IvcmFormSetDataSource);
//#UC START# *49786D4E034D_5017EAF4027D_var*
//#UC END# *49786D4E034D_5017EAF4027D_var*
begin
//#UC START# *49786D4E034D_5017EAF4027D_impl*
 // - нечего инициализировать
//#UC END# *49786D4E034D_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.InitRefs

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.MakeDisplayName: IvcmCString;
//#UC START# *491476B001D3_5017EAF4027D_var*
//#UC END# *491476B001D3_5017EAF4027D_var*
begin
//#UC START# *491476B001D3_5017EAF4027D_impl*
 Result := nil;
//#UC END# *491476B001D3_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.MakeDisplayName

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.DataChanged;
//#UC START# *491471F80112_5017EAF4027D_var*
//#UC END# *491471F80112_5017EAF4027D_var*
begin
//#UC START# *491471F80112_5017EAF4027D_impl*
 FormSetDataChanged;
//#UC END# *491471F80112_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.DataChanged

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsSame(const aValue: IvcmFormDataSource): Boolean;
//#UC START# *4914723502E0_5017EAF4027D_var*
var
 l_V : _FormDataSourceType_;
//#UC END# *4914723502E0_5017EAF4027D_var*
begin
//#UC START# *4914723502E0_5017EAF4027D_impl*
 Result := l3IEQ(Self, aValue);
 if not Result then
  if Supports(aValue, _FormDataSourceType_, l_V) then
   try
    Result := GetIsSame(l_V);
   finally
    l_V := nil;
   end;//try..finally
//#UC END# *4914723502E0_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsSame

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
//#UC START# *4914724900B9_5017EAF4027D_var*
//#UC END# *4914724900B9_5017EAF4027D_var*
begin
//#UC START# *4914724900B9_5017EAF4027D_impl*
 if (UseCaseController <> nil) then
  Result := UseCaseController.IsMainInFormSet(aForm)
 else
  Result := False;
//#UC END# *4914724900B9_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsMainInFormSet

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
//#UC START# *491472720367_5017EAF4027D_var*
var
 l_DS : _FormDataSourceType_;
//#UC END# *491472720367_5017EAF4027D_var*
begin
//#UC START# *491472720367_5017EAF4027D_impl*
 if Supports(aDataSource, _FormDataSourceType_, l_DS) then
  try
   Result := GetIsNeedChangePosition(l_DS);
  finally
   l_DS := nil
  end//try..finally
 else
  Result := false;
//#UC END# *491472720367_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsLikeViewAreaController

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.pm_GetUseCaseController: IvcmFormSetDataSource;
//#UC START# *4914728A0305_5017EAF4027Dget_var*
//#UC END# *4914728A0305_5017EAF4027Dget_var*
begin
//#UC START# *4914728A0305_5017EAF4027Dget_impl*
 Result := f_UseCaseController;
//#UC END# *4914728A0305_5017EAF4027Dget_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.pm_GetUseCaseController

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.CastUCC(const aGUID: TGUID;
  out theObj;
  NeedsException: Boolean = false): Boolean;
//#UC START# *4992BD300123_5017EAF4027D_var*
//#UC END# *4992BD300123_5017EAF4027D_var*
begin
//#UC START# *4992BD300123_5017EAF4027D_impl*
 if IsEqualGUID(_UseCaseControllerType_, aGUID) then
 begin
  Result := true;
  _UseCaseControllerType_(theObj) := UseCaseController;
 end//IsEqualGUID(_UseCaseControllerType_, aGUID)
 else
 begin
  Result := Supports(UseCaseController, aGUID, theObj);
  if NeedsException AND not Result then
   raise Exception.Create('Не удалось получить требуемый интерфейс');
 end;//IsEqualGUID(_UseCaseControllerType_, aGUID)
//#UC END# *4992BD300123_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.CastUCC

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Get_DisplayName: IvcmCString;
//#UC START# *499EA548016B_5017EAF4027Dget_var*
//#UC END# *499EA548016B_5017EAF4027Dget_var*
begin
//#UC START# *499EA548016B_5017EAF4027Dget_impl*
 if (f_DisplayName = nil) then
  f_DisplayName := MakeDisplayName;
 Result := f_DisplayName;
//#UC END# *499EA548016B_5017EAF4027Dget_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Get_DisplayName

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsDataAvailable: Boolean;
//#UC START# *55097FA90148_5017EAF4027D_var*
//#UC END# *55097FA90148_5017EAF4027D_var*
begin
//#UC START# *55097FA90148_5017EAF4027D_impl*
 Result := GetIsDataAvailable;
//#UC END# *55097FA90148_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsDataAvailable

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Cleanup;
//#UC START# *479731C50290_5017EAF4027D_var*
//#UC END# *479731C50290_5017EAF4027D_var*
begin
//#UC START# *479731C50290_5017EAF4027D_impl*
 if (UseCaseController <> nil) then
 begin
  ClearRefs;
  UseCaseController.As_Il3ChangeNotifier.Unsubscribe(IvcmFormSetDataSourceListener(Self));
 end;//UseCaseController <> nil
 f_DisplayName := nil;
 CallNotify(Ord(vcm_dsnDestroy), 0);
 f_UseCaseController := nil;
 inherited;
//#UC END# *479731C50290_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Cleanup

{$IfEnd} //not NoVCM

{$EndIf vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}
