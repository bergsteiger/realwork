unit nsContextFilterParams;
 {* Реализация хранилищя для параметров контекстной фильтрации }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsContextFilterParams.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , l3CacheableBase
 , l3TreeInterfaces
 , bsInterfaces
 , afwInterfaces
 , Il3ContextFilterParamsNotifierPtrList
 , l3Interfaces
;

type
 _afwSettingChanged_Parent_ = Tl3CacheableBase;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}
 _afwSettingsReplace_Parent_ = _afwSettingChanged_;
 {$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}
 TnsContextFilterParams = class(_afwSettingsReplace_, Il3ContextFilterParamsNotifySource, Il3ContextFilterParams, InsContextFilterParamsInfo)
  {* Реализация хранилищя для параметров контекстной фильтрации }
  private
   f_BaseSettingID: TafwSettingId;
   f_Subscribers: TIl3ContextFilterParamsNotifierPtrList;
  private
   function UseSettings: Boolean;
   procedure NotifySubscribers;
   function MakePath(const aSubSettingID: TafwSettingId): TafwSettingId;
   function IsSettingAffectUs(const aSettingID: TafwSettingId): Boolean;
  protected
   function pm_GetSettings: IafwSettings; virtual;
   function WordPosition: Tl3WordPosition;
   function WordOrder: Tl3WordOrder;
   function TreeLevelDist: Tl3TreeLevelDist;
   procedure Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
   procedure UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
   function BaseSettingID: TafwSettingId;
   function WordPositionSettingID: TafwSettingId;
   function WordOrderSettingID: TafwSettingId;
   function TreeLevelDistSettingID: TafwSettingId;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   function DoSettingChanged(const aSettingId: TafwSettingId): Boolean; override;
    {* Обработчик изменения указанной настройки }
   procedure SettingsReplaceFinish; override;
  public
   class function Make(const aBaseSettingID: TafwSettingId): Il3ContextFilterParams; reintroduce;
   constructor Create(const aBaseSettingID: TafwSettingId); reintroduce;
  private
   property Settings: IafwSettings
    read pm_GetSettings;
 end;//TnsContextFilterParams

implementation

uses
 l3ImplUses
 , SysUtils
 , afwFacade
 , afwConsts
 , afwSettingsChangePublisher
;

const
 cstTreeLevelDist = 'stTreeLevelDist';
 cstWordOrder = 'stWordOrder';
 cstWordPosition = 'stWordPosition';
 cDefaultTreeLevelDist = tldAllLevels;
 cDefaultWordOrder = woAnyOrder;
 cDefaultWordPosition = wpAnyPathWord;

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingChanged.imp.pas}

{$Include w:\common\components\gui\Garant\AFW\implementation\afwSettingsReplace.imp.pas}

function TnsContextFilterParams.pm_GetSettings: IafwSettings;
//#UC START# *49089AFB017D_4908930C0268get_var*
//#UC END# *49089AFB017D_4908930C0268get_var*
begin
//#UC START# *49089AFB017D_4908930C0268get_impl*
 Result := afw.Application.Settings;
//#UC END# *49089AFB017D_4908930C0268get_impl*
end;//TnsContextFilterParams.pm_GetSettings

class function TnsContextFilterParams.Make(const aBaseSettingID: TafwSettingId): Il3ContextFilterParams;
var
 l_Inst : TnsContextFilterParams;
begin
 l_Inst := Create(aBaseSettingID);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsContextFilterParams.Make

constructor TnsContextFilterParams.Create(const aBaseSettingID: TafwSettingId);
//#UC START# *490894CF009C_4908930C0268_var*
//#UC END# *490894CF009C_4908930C0268_var*
begin
//#UC START# *490894CF009C_4908930C0268_impl*
 inherited Create;
 f_BaseSettingID := aBaseSettingID;
//#UC END# *490894CF009C_4908930C0268_impl*
end;//TnsContextFilterParams.Create

function TnsContextFilterParams.UseSettings: Boolean;
//#UC START# *49089AD40319_4908930C0268_var*
//#UC END# *49089AD40319_4908930C0268_var*
begin
//#UC START# *49089AD40319_4908930C0268_impl*
 Result := (f_BaseSettingID <> '') and Assigned(Settings);
//#UC END# *49089AD40319_4908930C0268_impl*
end;//TnsContextFilterParams.UseSettings

procedure TnsContextFilterParams.NotifySubscribers;
//#UC START# *49089BBA0151_4908930C0268_var*
var
 l_Index : Integer;
//#UC END# *49089BBA0151_4908930C0268_var*
begin
//#UC START# *49089BBA0151_4908930C0268_impl*
 if (f_Subscribers <> nil) then
  for l_Index := 0 to Pred(f_Subscribers.Count) do
   f_Subscribers[l_Index].ParamsChanged;
//#UC END# *49089BBA0151_4908930C0268_impl*
end;//TnsContextFilterParams.NotifySubscribers

function TnsContextFilterParams.MakePath(const aSubSettingID: TafwSettingId): TafwSettingId;
//#UC START# *49089CAB0346_4908930C0268_var*
//#UC END# *49089CAB0346_4908930C0268_var*
begin
//#UC START# *49089CAB0346_4908930C0268_impl*
 if UseSettings then
  Result := f_BaseSettingID + g_afwPathSep + aSubSettingID
 else
  Result := '';
//#UC END# *49089CAB0346_4908930C0268_impl*
end;//TnsContextFilterParams.MakePath

function TnsContextFilterParams.IsSettingAffectUs(const aSettingID: TafwSettingId): Boolean;
//#UC START# *49089CB9018F_4908930C0268_var*
//#UC END# *49089CB9018F_4908930C0268_var*
begin
//#UC START# *49089CB9018F_4908930C0268_impl*
 Result := UseSettings and
  ((aSettingID = MakePath(cstTreeLevelDist)) or
   (aSettingID = MakePath(cstWordOrder)) or
   (aSettingID = MakePath(cstWordPosition))
  );
//#UC END# *49089CB9018F_4908930C0268_impl*
end;//TnsContextFilterParams.IsSettingAffectUs

function TnsContextFilterParams.WordPosition: Tl3WordPosition;
//#UC START# *47724E930100_4908930C0268_var*
//#UC END# *47724E930100_4908930C0268_var*
begin
//#UC START# *47724E930100_4908930C0268_impl*
 if UseSettings then
  Result := Tl3WordPosition(Settings.LoadInteger(WordPositionSettingID,
   Ord(cDefaultWordPosition)))
 else
  Result := cDefaultWordPosition;
//#UC END# *47724E930100_4908930C0268_impl*
end;//TnsContextFilterParams.WordPosition

function TnsContextFilterParams.WordOrder: Tl3WordOrder;
//#UC START# *47724E9D014D_4908930C0268_var*
//#UC END# *47724E9D014D_4908930C0268_var*
begin
//#UC START# *47724E9D014D_4908930C0268_impl*
 if UseSettings then
  Result := Tl3WordOrder(Settings.LoadInteger(WordOrderSettingID,
   Ord(cDefaultWordOrder)))
 else
  Result := cDefaultWordOrder;
//#UC END# *47724E9D014D_4908930C0268_impl*
end;//TnsContextFilterParams.WordOrder

function TnsContextFilterParams.TreeLevelDist: Tl3TreeLevelDist;
//#UC START# *47724EA70354_4908930C0268_var*
//#UC END# *47724EA70354_4908930C0268_var*
begin
//#UC START# *47724EA70354_4908930C0268_impl*
 if UseSettings then
  Result := Tl3TreeLevelDist(Settings.LoadInteger(TreeLevelDistSettingID,
   Ord(cDefaultTreeLevelDist)))
 else
  Result := cDefaultTreeLevelDist;
//#UC END# *47724EA70354_4908930C0268_impl*
end;//TnsContextFilterParams.TreeLevelDist

procedure TnsContextFilterParams.Subscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
//#UC START# *47724F120028_4908930C0268_var*
//#UC END# *47724F120028_4908930C0268_var*
begin
//#UC START# *47724F120028_4908930C0268_impl*
 if (f_Subscribers = nil) then
  f_Subscribers := TIl3ContextFilterParamsNotifierPtrList.Make;
 if f_Subscribers.IndexOf(aSubscriber) = -1 then
  f_Subscribers.Add(aSubscriber);
//#UC END# *47724F120028_4908930C0268_impl*
end;//TnsContextFilterParams.Subscribe

procedure TnsContextFilterParams.UnSubscribe(const aSubscriber: Il3ContextFilterParamsNotifier);
//#UC START# *47724F1E0180_4908930C0268_var*
//#UC END# *47724F1E0180_4908930C0268_var*
begin
//#UC START# *47724F1E0180_4908930C0268_impl*
 if (f_Subscribers <> nil) then
  f_Subscribers.Remove(aSubscriber);
//#UC END# *47724F1E0180_4908930C0268_impl*
end;//TnsContextFilterParams.UnSubscribe

function TnsContextFilterParams.BaseSettingID: TafwSettingId;
//#UC START# *490896DA03E4_4908930C0268_var*
//#UC END# *490896DA03E4_4908930C0268_var*
begin
//#UC START# *490896DA03E4_4908930C0268_impl*
 Result := f_BaseSettingID;
//#UC END# *490896DA03E4_4908930C0268_impl*
end;//TnsContextFilterParams.BaseSettingID

function TnsContextFilterParams.WordPositionSettingID: TafwSettingId;
//#UC START# *490896E600DC_4908930C0268_var*
//#UC END# *490896E600DC_4908930C0268_var*
begin
//#UC START# *490896E600DC_4908930C0268_impl*
 Result := MakePath(cstWordPosition)
//#UC END# *490896E600DC_4908930C0268_impl*
end;//TnsContextFilterParams.WordPositionSettingID

function TnsContextFilterParams.WordOrderSettingID: TafwSettingId;
//#UC START# *490896F300D8_4908930C0268_var*
//#UC END# *490896F300D8_4908930C0268_var*
begin
//#UC START# *490896F300D8_4908930C0268_impl*
 Result := MakePath(cstWordOrder)
//#UC END# *490896F300D8_4908930C0268_impl*
end;//TnsContextFilterParams.WordOrderSettingID

function TnsContextFilterParams.TreeLevelDistSettingID: TafwSettingId;
//#UC START# *49089705028B_4908930C0268_var*
//#UC END# *49089705028B_4908930C0268_var*
begin
//#UC START# *49089705028B_4908930C0268_impl*
 Result := MakePath(cstTreeLevelDist);
//#UC END# *49089705028B_4908930C0268_impl*
end;//TnsContextFilterParams.TreeLevelDistSettingID

procedure TnsContextFilterParams.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4908930C0268_var*
//#UC END# *479731C50290_4908930C0268_var*
begin
//#UC START# *479731C50290_4908930C0268_impl*
 FreeAndNil(f_Subscribers);
 inherited;
//#UC END# *479731C50290_4908930C0268_impl*
end;//TnsContextFilterParams.Cleanup

function TnsContextFilterParams.DoSettingChanged(const aSettingId: TafwSettingId): Boolean;
 {* Обработчик изменения указанной настройки }
//#UC START# *47EA863A035C_4908930C0268_var*
//#UC END# *47EA863A035C_4908930C0268_var*
begin
//#UC START# *47EA863A035C_4908930C0268_impl*
 Result := IsSettingAffectUs(aSettingID);
 if Result then
  NotifySubscribers;
//#UC END# *47EA863A035C_4908930C0268_impl*
end;//TnsContextFilterParams.DoSettingChanged

procedure TnsContextFilterParams.SettingsReplaceFinish;
//#UC START# *47EA8B9601FE_4908930C0268_var*
//#UC END# *47EA8B9601FE_4908930C0268_var*
begin
//#UC START# *47EA8B9601FE_4908930C0268_impl*
 inherited;
 NotifySubscribers;
//#UC END# *47EA8B9601FE_4908930C0268_impl*
end;//TnsContextFilterParams.SettingsReplaceFinish

end.
