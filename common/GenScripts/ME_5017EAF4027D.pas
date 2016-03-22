{$IfNDef vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}

// ћодуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormDataSourcePrimWithFlexUseCaseControllerType.imp.pas"
// —тереотип: "Impurity"
// Ёлемент модели: "vcmFormDataSourcePrimWithFlexUseCaseControllerType" MUID: (5017EAF4027D)
// »м€ типа: "_vcmFormDataSourcePrimWithFlexUseCaseControllerType_"

{$Define vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}

{$If NOT Defined(NoVCM)}
 // _UseCaseControllerType_

 // _FormDataSourceType_

 _l3Notifier_Parent_ = Tl3ProtoObjectWithCOMQI;
 {$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}
 _vcmFormDataSourcePrimWithFlexUseCaseControllerType_ = class(_l3Notifier_, IvcmFormDataSource, IvcmFormSetDataSourceListener)
  private
   f_DisplayName: IvcmCString;
    {* ¬ычисленный заголовок контроллера области ввода }
   f_UseCaseController: _UseCaseControllerType_;
    {* ѕоле дл€ свойства UseCaseController }
  protected
   function GetIsDataAvailable: Boolean; virtual;
    {* существуют ли данные }
   procedure ClearRefs; virtual;
    {* ќчищает ссылки на различные представлени€ прецедента }
   procedure FormSetDataChanged; virtual;
   function GetIsNeedChangePosition(const aDataSource: _FormDataSourceType_): Boolean; virtual;
   function GetIsSame(const aValue: _FormDataSourceType_): Boolean; virtual;
   procedure InitRefs(const aDS: IvcmFormSetDataSource); virtual;
    {* »нициализирует ссылки на различные представлени€ прецедента }
   function MakeDisplayName: IvcmCString; virtual;
   procedure DataChanged;
    {* данные изменились }
   function IsSame(const aValue: IvcmFormDataSource): Boolean;
    {* проверка на равенство }
   function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
    {* €вл€етс€ ли форма главной в сборке }
   function IsLikeViewAreaController(const aDataSource: IvcmFormDataSource): Boolean;
    {* определим нужно ли мен€ть позицию на данные }
   function pm_GetUseCaseController: IvcmFormSetDataSource;
   function CastUCC(const aGUID: TGUID;
    out theObj;
    NeedsException: Boolean = False): Boolean;
    {* ѕриводит контроллер прецедента к заданному интерфейсу. Ёто нужно, чтобы избавитс€ от €вного знани€ о контроллере прецедента. [$122674504] }
   function Get_DisplayName: IvcmCString;
   function IsDataAvailable: Boolean;
    {* существуют ли данные в текущих услови€х. Ќапример, на текущей базе. }
   procedure Cleanup; override;
    {* ‘ункци€ очистки полей объекта. }
   procedure ClearFields; override;
  public
   constructor Create(const aDataSource: _UseCaseControllerType_); reintroduce;
   class function Make(const aDataSource: _UseCaseControllerType_): _FormDataSourceType_; reintroduce;
  protected
   property UseCaseController: _UseCaseControllerType_
    read f_UseCaseController;
    {*  онтроллер прецедента, в котором находитс€ наша область ввода }
 end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_

{$Else NOT Defined(NoVCM)}

_l3Notifier_Parent_ = Tl3ProtoObjectWithCOMQI;
{$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}
_vcmFormDataSourcePrimWithFlexUseCaseControllerType_ = _l3Notifier_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}

{$IfNDef vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp_impl}

{$Define vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include w:\common\components\rtl\Garant\L3\l3Notifier.imp.pas}

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.GetIsDataAvailable: Boolean;
 {* существуют ли данные }
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
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Make

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.ClearRefs;
 {* ќчищает ссылки на различные представлени€ прецедента }
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
 {* »нициализирует ссылки на различные представлени€ прецедента }
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
 {* данные изменились }
//#UC START# *491471F80112_5017EAF4027D_var*
//#UC END# *491471F80112_5017EAF4027D_var*
begin
//#UC START# *491471F80112_5017EAF4027D_impl*
 FormSetDataChanged;
//#UC END# *491471F80112_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.DataChanged

function _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsSame(const aValue: IvcmFormDataSource): Boolean;
 {* проверка на равенство }
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
 {* €вл€етс€ ли форма главной в сборке }
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
 {* определим нужно ли мен€ть позицию на данные }
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
 NeedsException: Boolean = False): Boolean;
 {* ѕриводит контроллер прецедента к заданному интерфейсу. Ёто нужно, чтобы избавитс€ от €вного знани€ о контроллере прецедента. [$122674504] }
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
   raise Exception.Create('Ќе удалось получить требуемый интерфейс');
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
 {* существуют ли данные в текущих услови€х. Ќапример, на текущей базе. }
//#UC START# *55097FA90148_5017EAF4027D_var*
//#UC END# *55097FA90148_5017EAF4027D_var*
begin
//#UC START# *55097FA90148_5017EAF4027D_impl*
 Result := GetIsDataAvailable;
//#UC END# *55097FA90148_5017EAF4027D_impl*
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.IsDataAvailable

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.Cleanup;
 {* ‘ункци€ очистки полей объекта. }
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

procedure _vcmFormDataSourcePrimWithFlexUseCaseControllerType_.ClearFields;
begin
 Finalize(f_UseCaseController);
 inherited;
end;//_vcmFormDataSourcePrimWithFlexUseCaseControllerType_.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp_impl}

{$EndIf vcmFormDataSourcePrimWithFlexUseCaseControllerType_imp}

