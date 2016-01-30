{$IfNDef vcmFormSetDataSource_imp}

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\vcmFormSetDataSource.imp.pas"
// Стереотип: "Impurity"

{$Define vcmFormSetDataSource_imp}

{$If NOT Defined(NoVCM)}
type
 // _SetDataType_

 // _SetType_

 // _InitDataType_

 _l3Notifier_Parent_ = Tl3ProtoObjectWithCOMQI;
 {$Include l3Notifier.imp.pas}
 _vcmFormSetDataSource_ = class(_l3Notifier_, IvcmFormSetDataSource, Il3ChangeNotifier)
  {* Бизнес объект сборки }
  private
   f_RefreshCount: Integer;
   f_ForbidRefresh: Boolean;
   f_FormSet: IvcmFormSet;
    {* Поле для свойства FormSet }
   f_InInit: Boolean;
    {* Поле для свойства InInit }
   f_SetData: _SetDataType_;
    {* Поле для свойства SetData }
   f_InitialUseCaseData: _InitDataType_;
    {* Поле для свойства InitialUseCaseData }
  private
   class function MakeWithSetData(const aSetData: _SetDataType_): IvcmFormSetDataSource;
  protected
   function pm_GetSetData: _SetDataType_;
   function DoGetFormSetImageIndex: Integer; virtual;
   function DoGetTabCaption: IvcmCString; virtual;
   function DoGetTabHint: IvcmCString; virtual;
   function DoMakeClone: IvcmFormSetDataSource; virtual;
   function GetDataForClone: _InitDataType_; virtual;
   function MakeData: _SetDataType_; virtual; abstract;
    {* Данные сборки. }
   procedure DataExchange; virtual;
    {* - вызывается после получения данных инициализации. }
   function GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean; virtual;
   procedure DoPushFromHistory; virtual;
    {* сборка была выгружена из истории }
   procedure ClearRefs; virtual;
    {* Очищает ссылки на источники данных }
   procedure ClearAreas; virtual;
    {* Очищает ссылки на области ввода }
   function As_Il3ChangeNotifier: Il3ChangeNotifier;
    {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
   procedure BeginRefresh;
    {* вызывается перед началом обновления }
   procedure EndRefresh;
    {* вызывается в конце обновления }
   function IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
    {* является ли форма главной в сборке }
   function IsLikeUseCaseController(const aDataSource: IvcmFormSetDataSource): Boolean;
    {* определим нужно ли пересоздавать сборку или все отличие в позиции на данных }
   function IsRefreshing: Boolean;
    {* сборка находится в состоянии обновления }
   procedure PushFromHistory;
    {* сборка была выгружена из истории }
   procedure Refresh(const aParams: IvcmFormSetRefreshDataParams = nil);
    {* обновить представление сборки }
   function pm_GetFormSet: IvcmFormSet;
   procedure pm_SetFormSet(const aValue: IvcmFormSet);
   function pm_GetMainCaption: IvcmCString;
   function pm_GetMainImageIndex: Integer;
   function pm_GetInInit: Boolean;
   function pm_GetDataForSave: IvcmData;
   procedure pm_SetDataForSave(const aValue: IvcmData);
   function pm_GetFormSetImageIndex: Integer;
   function pm_GetTabCaption: IvcmCString;
   function pm_GetTabHint: IvcmCString;
   function MakeClone: IvcmFormSetDataSource;
   procedure PopToHistory;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor Create(const aData: _InitDataType_); reintroduce;
   class function Make(const aData: _InitDataType_): _SetType_; reintroduce;
  protected
   property InInit: Boolean
    read f_InInit;
    {* вызывается при первом обновлении сборки }
   property SetData: _SetDataType_
    read pm_GetSetData;
   property InitialUseCaseData: _InitDataType_
    read f_InitialUseCaseData;
    {* Данные инициализирующие контроллер прецедента }
  public
   property FormSet: IvcmFormSet
    read f_FormSet;
 end;//_vcmFormSetDataSource_

{$Else NOT Defined(NoVCM)}

_l3Notifier_Parent_ = Tl3ProtoObjectWithCOMQI;
{$Include l3Notifier.imp.pas}
_vcmFormSetDataSource_ = _l3Notifier_;

{$IfEnd} // NOT Defined(NoVCM)
{$Else vcmFormSetDataSource_imp}

{$IfNDef vcmFormSetDataSource_imp_impl}

{$Define vcmFormSetDataSource_imp_impl}

{$If NOT Defined(NoVCM)}
{$Include l3Notifier.imp.pas}

function _vcmFormSetDataSource_.pm_GetSetData: _SetDataType_;
//#UC START# *494163340251_47F37723017Aget_var*
//#UC END# *494163340251_47F37723017Aget_var*
begin
//#UC START# *494163340251_47F37723017Aget_impl*
 if not Assigned(f_SetData) then
  f_SetData := MakeData;
 Result := f_SetData;
//#UC END# *494163340251_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetSetData

function _vcmFormSetDataSource_.DoGetFormSetImageIndex: Integer;
//#UC START# *53B3BF9C00EF_47F37723017A_var*
//#UC END# *53B3BF9C00EF_47F37723017A_var*
begin
//#UC START# *53B3BF9C00EF_47F37723017A_impl*
 Result := -1;
//#UC END# *53B3BF9C00EF_47F37723017A_impl*
end;//_vcmFormSetDataSource_.DoGetFormSetImageIndex

function _vcmFormSetDataSource_.DoGetTabCaption: IvcmCString;
//#UC START# *54CF10260215_47F37723017A_var*
//#UC END# *54CF10260215_47F37723017A_var*
begin
//#UC START# *54CF10260215_47F37723017A_impl*
 Result := nil;
//#UC END# *54CF10260215_47F37723017A_impl*
end;//_vcmFormSetDataSource_.DoGetTabCaption

function _vcmFormSetDataSource_.DoGetTabHint: IvcmCString;
//#UC START# *54CF105502D3_47F37723017A_var*
//#UC END# *54CF105502D3_47F37723017A_var*
begin
//#UC START# *54CF105502D3_47F37723017A_impl*
 Result := nil;
//#UC END# *54CF105502D3_47F37723017A_impl*
end;//_vcmFormSetDataSource_.DoGetTabHint

function _vcmFormSetDataSource_.DoMakeClone: IvcmFormSetDataSource;
//#UC START# *555B0E0B0084_47F37723017A_var*
//#UC END# *555B0E0B0084_47F37723017A_var*
begin
//#UC START# *555B0E0B0084_47F37723017A_impl*
 Assert(False);
//#UC END# *555B0E0B0084_47F37723017A_impl*
end;//_vcmFormSetDataSource_.DoMakeClone

class function _vcmFormSetDataSource_.MakeWithSetData(const aSetData: _SetDataType_): IvcmFormSetDataSource;
//#UC START# *555B165501A4_47F37723017A_var*
var
 l_Inst: _vcmFormSetDataSource_;
//#UC END# *555B165501A4_47F37723017A_var*
begin
//#UC START# *555B165501A4_47F37723017A_impl*
 l_Inst := Create(nil);
 l_Inst.f_SetData := aSetData;
 Result := l_Inst;
//#UC END# *555B165501A4_47F37723017A_impl*
end;//_vcmFormSetDataSource_.MakeWithSetData

function _vcmFormSetDataSource_.GetDataForClone: _InitDataType_;
//#UC START# *55C1DD070354_47F37723017A_var*
//#UC END# *55C1DD070354_47F37723017A_var*
begin
//#UC START# *55C1DD070354_47F37723017A_impl*
 Result := InitialUseCaseData;
//#UC END# *55C1DD070354_47F37723017A_impl*
end;//_vcmFormSetDataSource_.GetDataForClone

procedure _vcmFormSetDataSource_.DataExchange;
 {* - вызывается после получения данных инициализации. }
//#UC START# *47F37DF001FE_47F37723017A_var*
//#UC END# *47F37DF001FE_47F37723017A_var*
begin
//#UC START# *47F37DF001FE_47F37723017A_impl*

//#UC END# *47F37DF001FE_47F37723017A_impl*
end;//_vcmFormSetDataSource_.DataExchange

constructor _vcmFormSetDataSource_.Create(const aData: _InitDataType_);
//#UC START# *47FDD4520032_47F37723017A_var*
//#UC END# *47FDD4520032_47F37723017A_var*
begin
//#UC START# *47FDD4520032_47F37723017A_impl*
 inherited Create;
 f_RefreshCount := 0;
 f_InInit := True;
 f_InitialUseCaseData := aData;
//#UC END# *47FDD4520032_47F37723017A_impl*
end;//_vcmFormSetDataSource_.Create

class function _vcmFormSetDataSource_.Make(const aData: _InitDataType_): _SetType_;
var
 l_Inst : _vcmFormSetDataSource_;
begin
 l_Inst := Create(aData);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//_vcmFormSetDataSource_.Make

function _vcmFormSetDataSource_.GetIsNeedChangePosition(const aDataSource: _SetType_): Boolean;
//#UC START# *491B02D80112_47F37723017A_var*
//#UC END# *491B02D80112_47F37723017A_var*
begin
//#UC START# *491B02D80112_47F37723017A_impl*
 Result := false;
//#UC END# *491B02D80112_47F37723017A_impl*
end;//_vcmFormSetDataSource_.GetIsNeedChangePosition

procedure _vcmFormSetDataSource_.DoPushFromHistory;
 {* сборка была выгружена из истории }
//#UC START# *491B06F000BB_47F37723017A_var*
//#UC END# *491B06F000BB_47F37723017A_var*
begin
//#UC START# *491B06F000BB_47F37723017A_impl*
 // - ничего не делаем
//#UC END# *491B06F000BB_47F37723017A_impl*
end;//_vcmFormSetDataSource_.DoPushFromHistory

procedure _vcmFormSetDataSource_.ClearRefs;
 {* Очищает ссылки на источники данных }
//#UC START# *492EEC270358_47F37723017A_var*
//#UC END# *492EEC270358_47F37723017A_var*
begin
//#UC START# *492EEC270358_47F37723017A_impl*
 // ничего не делаем
//#UC END# *492EEC270358_47F37723017A_impl*
end;//_vcmFormSetDataSource_.ClearRefs

procedure _vcmFormSetDataSource_.ClearAreas;
 {* Очищает ссылки на области ввода }
//#UC START# *4938F7E702B7_47F37723017A_var*
//#UC END# *4938F7E702B7_47F37723017A_var*
begin
//#UC START# *4938F7E702B7_47F37723017A_impl*
 // ничего не делаем
//#UC END# *4938F7E702B7_47F37723017A_impl*
end;//_vcmFormSetDataSource_.ClearAreas

function _vcmFormSetDataSource_.As_Il3ChangeNotifier: Il3ChangeNotifier;
 {* Метод приведения нашего интерфейса к Il3ChangeNotifier }
begin
 Result := Self;
end;//_vcmFormSetDataSource_.As_Il3ChangeNotifier

procedure _vcmFormSetDataSource_.BeginRefresh;
 {* вызывается перед началом обновления }
//#UC START# *491AF7CD01EB_47F37723017A_var*
//#UC END# *491AF7CD01EB_47F37723017A_var*
begin
//#UC START# *491AF7CD01EB_47F37723017A_impl*
 Inc(f_RefreshCount);
//#UC END# *491AF7CD01EB_47F37723017A_impl*
end;//_vcmFormSetDataSource_.BeginRefresh

procedure _vcmFormSetDataSource_.EndRefresh;
 {* вызывается в конце обновления }
//#UC START# *491AF7D00370_47F37723017A_var*
//#UC END# *491AF7D00370_47F37723017A_var*
begin
//#UC START# *491AF7D00370_47F37723017A_impl*
 Dec(f_RefreshCount);
 if f_InInit then
  f_InInit := False;
//#UC END# *491AF7D00370_47F37723017A_impl*
end;//_vcmFormSetDataSource_.EndRefresh

function _vcmFormSetDataSource_.IsMainInFormSet(const aForm: IvcmEntityForm): Boolean;
 {* является ли форма главной в сборке }
//#UC START# *491AF7E40336_47F37723017A_var*
//#UC END# *491AF7E40336_47F37723017A_var*
begin
//#UC START# *491AF7E40336_47F37723017A_impl*
 Result := False;
 if Assigned(f_FormSet) then
  Result := f_FormSet.IsMainInFormSet(aForm);
//#UC END# *491AF7E40336_47F37723017A_impl*
end;//_vcmFormSetDataSource_.IsMainInFormSet

function _vcmFormSetDataSource_.IsLikeUseCaseController(const aDataSource: IvcmFormSetDataSource): Boolean;
 {* определим нужно ли пересоздавать сборку или все отличие в позиции на данных }
//#UC START# *491AF7E80082_47F37723017A_var*
var
 l_DS : _SetType_;
//#UC END# *491AF7E80082_47F37723017A_var*
begin
//#UC START# *491AF7E80082_47F37723017A_impl*
 if Supports(aDataSource, _SetType_, l_DS) then
  try
   Result := GetIsNeedChangePosition(l_DS);
  finally
   l_DS := nil;
  end//try..finally
 else
  Result := false; 
//#UC END# *491AF7E80082_47F37723017A_impl*
end;//_vcmFormSetDataSource_.IsLikeUseCaseController

function _vcmFormSetDataSource_.IsRefreshing: Boolean;
 {* сборка находится в состоянии обновления }
//#UC START# *491AF8430279_47F37723017A_var*
//#UC END# *491AF8430279_47F37723017A_var*
begin
//#UC START# *491AF8430279_47F37723017A_impl*
 Result := f_RefreshCount > 0;
//#UC END# *491AF8430279_47F37723017A_impl*
end;//_vcmFormSetDataSource_.IsRefreshing

procedure _vcmFormSetDataSource_.PushFromHistory;
 {* сборка была выгружена из истории }
//#UC START# *491AF84E032A_47F37723017A_var*
//#UC END# *491AF84E032A_47F37723017A_var*
begin
//#UC START# *491AF84E032A_47F37723017A_impl*
 f_ForbidRefresh := False;
 DoPushFromHistory;
//#UC END# *491AF84E032A_47F37723017A_impl*
end;//_vcmFormSetDataSource_.PushFromHistory

procedure _vcmFormSetDataSource_.Refresh(const aParams: IvcmFormSetRefreshDataParams = nil);
 {* обновить представление сборки }
//#UC START# *491AF8610174_47F37723017A_var*
//#UC END# *491AF8610174_47F37723017A_var*
begin
//#UC START# *491AF8610174_47F37723017A_impl*
 if (not f_ForbidRefresh) and (FormSet <> nil) then
  FormSet.Refresh(aParams);
//#UC END# *491AF8610174_47F37723017A_impl*
end;//_vcmFormSetDataSource_.Refresh

function _vcmFormSetDataSource_.pm_GetFormSet: IvcmFormSet;
//#UC START# *491AF887022E_47F37723017Aget_var*
//#UC END# *491AF887022E_47F37723017Aget_var*
begin
//#UC START# *491AF887022E_47F37723017Aget_impl*
 Result := f_FormSet;
//#UC END# *491AF887022E_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetFormSet

procedure _vcmFormSetDataSource_.pm_SetFormSet(const aValue: IvcmFormSet);
//#UC START# *491AF887022E_47F37723017Aset_var*
//#UC END# *491AF887022E_47F37723017Aset_var*
begin
//#UC START# *491AF887022E_47F37723017Aset_impl*
 if f_FormSet <> aValue then
 begin
  f_FormSet := aValue;
  if f_FormSet <> nil then
   f_FormSet.DataSource := Self;
 end;//if f_FormSet <> aValue then
//#UC END# *491AF887022E_47F37723017Aset_impl*
end;//_vcmFormSetDataSource_.pm_SetFormSet

function _vcmFormSetDataSource_.pm_GetMainCaption: IvcmCString;
//#UC START# *491AF8B50315_47F37723017Aget_var*
//#UC END# *491AF8B50315_47F37723017Aget_var*
begin
//#UC START# *491AF8B50315_47F37723017Aget_impl*
 Result := FormSet.Factory.MakeMainCaption(Self);
//#UC END# *491AF8B50315_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetMainCaption

function _vcmFormSetDataSource_.pm_GetMainImageIndex: Integer;
//#UC START# *491AF8E1010C_47F37723017Aget_var*
//#UC END# *491AF8E1010C_47F37723017Aget_var*
begin
//#UC START# *491AF8E1010C_47F37723017Aget_impl*
 Result := FormSet.Factory.MakeMainImageIndex(Self);
//#UC END# *491AF8E1010C_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetMainImageIndex

function _vcmFormSetDataSource_.pm_GetInInit: Boolean;
//#UC START# *491AF8F70267_47F37723017Aget_var*
//#UC END# *491AF8F70267_47F37723017Aget_var*
begin
//#UC START# *491AF8F70267_47F37723017Aget_impl*
 Result := f_InInit;
//#UC END# *491AF8F70267_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetInInit

function _vcmFormSetDataSource_.pm_GetDataForSave: IvcmData;
//#UC START# *491AFD1E01D9_47F37723017Aget_var*
//#UC END# *491AFD1E01D9_47F37723017Aget_var*
begin
//#UC START# *491AFD1E01D9_47F37723017Aget_impl*
 Result := SetData;
//#UC END# *491AFD1E01D9_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetDataForSave

procedure _vcmFormSetDataSource_.pm_SetDataForSave(const aValue: IvcmData);
//#UC START# *491AFD1E01D9_47F37723017Aset_var*

  procedure lp_Notify;
  var
   l_Index    : Integer;
   l_Listener : IvcmFormSetDataSourceListener;
   l_Item     : IUnknown;
  begin
   if (NotifiedObjList <> nil) and (NotifiedObjList.Count > 0) then
    for l_Index := 0 to Pred(NotifiedObjList.Count) do
    begin
     l_Item := IUnknown(NotifiedObjList.Items[l_Index]);
     if Supports(l_Item, IvcmFormSetDataSourceListener, l_Listener) and
       (l_Item = l_Listener) then
      l_Listener.DataChanged;
    end;//if (NotifiedObjList <> nil)
  end;//lp_Notify

//#UC END# *491AFD1E01D9_47F37723017Aset_var*
begin
//#UC START# *491AFD1E01D9_47F37723017Aset_impl*
 if f_SetData <> aValue then
 begin
  f_SetData := aValue As _SetDataType_;
  lp_Notify;
 end;//if f_SetData <> aValue then
//#UC END# *491AFD1E01D9_47F37723017Aset_impl*
end;//_vcmFormSetDataSource_.pm_SetDataForSave

function _vcmFormSetDataSource_.pm_GetFormSetImageIndex: Integer;
//#UC START# *53B3B7D60175_47F37723017Aget_var*
//#UC END# *53B3B7D60175_47F37723017Aget_var*
begin
//#UC START# *53B3B7D60175_47F37723017Aget_impl*
 Result := DoGetFormSetImageIndex;
//#UC END# *53B3B7D60175_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetFormSetImageIndex

function _vcmFormSetDataSource_.pm_GetTabCaption: IvcmCString;
//#UC START# *54CF08350289_47F37723017Aget_var*
//#UC END# *54CF08350289_47F37723017Aget_var*
begin
//#UC START# *54CF08350289_47F37723017Aget_impl*
 Result := DoGetTabCaption;
//#UC END# *54CF08350289_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetTabCaption

function _vcmFormSetDataSource_.pm_GetTabHint: IvcmCString;
//#UC START# *54CF084A03D9_47F37723017Aget_var*
//#UC END# *54CF084A03D9_47F37723017Aget_var*
begin
//#UC START# *54CF084A03D9_47F37723017Aget_impl*
 Result := DoGetTabHint;
//#UC END# *54CF084A03D9_47F37723017Aget_impl*
end;//_vcmFormSetDataSource_.pm_GetTabHint

function _vcmFormSetDataSource_.MakeClone: IvcmFormSetDataSource;
//#UC START# *555B04350111_47F37723017A_var*
var
 l_InitialCloneData: _InitDataType_;
//#UC END# *555B04350111_47F37723017A_var*
begin
//#UC START# *555B04350111_47F37723017A_impl*
 l_InitialCloneData := GetDataForClone;
 Result := Make(l_InitialCloneData);
//#UC END# *555B04350111_47F37723017A_impl*
end;//_vcmFormSetDataSource_.MakeClone

procedure _vcmFormSetDataSource_.PopToHistory;
//#UC START# *5600F23B013D_47F37723017A_var*
//#UC END# *5600F23B013D_47F37723017A_var*
begin
//#UC START# *5600F23B013D_47F37723017A_impl*
 f_ForbidRefresh := True;
//#UC END# *5600F23B013D_47F37723017A_impl*
end;//_vcmFormSetDataSource_.PopToHistory

procedure _vcmFormSetDataSource_.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_47F37723017A_var*
//#UC END# *479731C50290_47F37723017A_var*
begin
//#UC START# *479731C50290_47F37723017A_impl*
 f_SetData := nil;
 f_InitialUseCaseData := nil;
 f_FormSet := nil;
 ClearRefs;
 inherited;
//#UC END# *479731C50290_47F37723017A_impl*
end;//_vcmFormSetDataSource_.Cleanup

procedure _vcmFormSetDataSource_.InitFields;
//#UC START# *47A042E100E2_47F37723017A_var*
//#UC END# *47A042E100E2_47F37723017A_var*
begin
//#UC START# *47A042E100E2_47F37723017A_impl*
 inherited;
 if Assigned(f_InitialUseCaseData) then
  DataExchange;
//#UC END# *47A042E100E2_47F37723017A_impl*
end;//_vcmFormSetDataSource_.InitFields

procedure _vcmFormSetDataSource_.ClearFields;
begin
 f_FormSet := nil;
 Finalize(f_SetData);
 Finalize(f_InitialUseCaseData);
 inherited;
end;//_vcmFormSetDataSource_.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

{$EndIf vcmFormSetDataSource_imp_impl}

{$EndIf vcmFormSetDataSource_imp}

