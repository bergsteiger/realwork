unit vcmFormDataSourceRef;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM"
// Автор: Морозов М.А.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/vcmFormDataSourceRef.pas"
// Начат: 14.12.2005 17.33
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VCM::Implementation::vcmFormDataSourceRef
//
// Самоочищающаяся ссылка на бизнес объект формы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  vcmControllers,
  l3ProtoObject,
  vcmBaseTypes,
  vcmInterfaces
  ;

type
 TvcmFormDataSourceRef = class(Tl3ProtoObject, Il3ItemNotifyRecipient, IvcmFormDataSourceRef)
  {* Реализация ссылки на бизнес объект формы }
 private
 // private fields
   f_DataSource : Pointer;
   f_NeedMake : TvcmNeedMakeDS;
 protected
 // realized methods
   procedure Notify(const aNotifier: Il3ChangeNotifier;
    aOperation: Integer;
    aIndex: Integer);
     {* прошла операция. }
   procedure Clear;
     {* сбрасывает ссылку на _DataSource и NeedMake устанавливает как vcm_nmNo }
   procedure SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
     {* устанавливаем флаг если его значение vcm_nmNo }
   procedure Assign(const aSource: IvcmFormDataSourceRef);
     {* скопировать данные aSource }
   function pm_GetReferred: IvcmFormDataSource;
   procedure pm_SetReferred(const aValue: IvcmFormDataSource);
   function pm_GetNeedMake: TvcmNeedMakeDS;
   procedure pm_SetNeedMake(aValue: TvcmNeedMakeDS);
   function pm_GetIsEmpty: Boolean;
   function pm_GetCanBeClosed: Boolean;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 public
 // public methods
   constructor Create(aNeedMake: TvcmNeedMakeDS); reintroduce;
   class function Make(aNeedMake: TvcmNeedMakeDS = vcm_nmNo): IvcmFormDataSourceRef; reintroduce;
     {* Фабричный метод }
 end;//TvcmFormDataSourceRef

 TvcmViewAreaControllerRef = TvcmFormDataSourceRef;

function VcmCheckAndMake(var aRef: IvcmFormDataSourceRef;
  aNeedMake: TvcmNeedMakeDS = vcm_nmNo): IvcmFormDataSourceRef;
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
// start class TvcmFormDataSourceRef

constructor TvcmFormDataSourceRef.Create(aNeedMake: TvcmNeedMakeDS);
//#UC START# *4982B8A602BB_47EB55FD007A_var*
//#UC END# *4982B8A602BB_47EB55FD007A_var*
begin
//#UC START# *4982B8A602BB_47EB55FD007A_impl*
 inherited Create;
 pm_SetReferred(nil);
 f_NeedMake := aNeedMake;
//#UC END# *4982B8A602BB_47EB55FD007A_impl*
end;//TvcmFormDataSourceRef.Create

class function TvcmFormDataSourceRef.Make(aNeedMake: TvcmNeedMakeDS = vcm_nmNo): IvcmFormDataSourceRef;
var
 l_Inst : TvcmFormDataSourceRef;
begin
 l_Inst := Create(aNeedMake);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

procedure TvcmFormDataSourceRef.Notify(const aNotifier: Il3ChangeNotifier;
  aOperation: Integer;
  aIndex: Integer);
//#UC START# *46A4504B03C4_47EB55FD007A_var*
//#UC END# *46A4504B03C4_47EB55FD007A_var*
begin
//#UC START# *46A4504B03C4_47EB55FD007A_impl*
 Case aOperation of
  Ord(vcm_dsnDestroy):
   Clear;
 end;//case aOperation of
//#UC END# *46A4504B03C4_47EB55FD007A_impl*
end;//TvcmFormDataSourceRef.Notify

procedure TvcmFormDataSourceRef.Clear;
//#UC START# *4982B3B10155_47EB55FD007A_var*
//#UC END# *4982B3B10155_47EB55FD007A_var*
begin
//#UC START# *4982B3B10155_47EB55FD007A_impl*
 pm_SetReferred(nil);
 f_NeedMake := vcm_nmNo;
//#UC END# *4982B3B10155_47EB55FD007A_impl*
end;//TvcmFormDataSourceRef.Clear

procedure TvcmFormDataSourceRef.SetIfNeedMakeNo(aValue: TvcmNeedMakeDS);
//#UC START# *4982B40202EE_47EB55FD007A_var*
//#UC END# *4982B40202EE_47EB55FD007A_var*
begin
//#UC START# *4982B40202EE_47EB55FD007A_impl*
 if f_NeedMake = vcm_nmNo then
  f_NeedMake := aValue;
//#UC END# *4982B40202EE_47EB55FD007A_impl*
end;//TvcmFormDataSourceRef.SetIfNeedMakeNo

procedure TvcmFormDataSourceRef.Assign(const aSource: IvcmFormDataSourceRef);
//#UC START# *4982B4280318_47EB55FD007A_var*
//#UC END# *4982B4280318_47EB55FD007A_var*
begin
//#UC START# *4982B4280318_47EB55FD007A_impl*
 if Assigned(aSource) then
 begin
  pm_SetReferred(aSource.Referred);
  pm_SetNeedMake(aSource.NeedMake);
 end;
//#UC END# *4982B4280318_47EB55FD007A_impl*
end;//TvcmFormDataSourceRef.Assign

function TvcmFormDataSourceRef.pm_GetReferred: IvcmFormDataSource;
//#UC START# *4982B449023F_47EB55FD007Aget_var*
//#UC END# *4982B449023F_47EB55FD007Aget_var*
begin
//#UC START# *4982B449023F_47EB55FD007Aget_impl*
 Result := IvcmFormDataSource(f_DataSource);
//#UC END# *4982B449023F_47EB55FD007Aget_impl*
end;//TvcmFormDataSourceRef.pm_GetReferred

procedure TvcmFormDataSourceRef.pm_SetReferred(const aValue: IvcmFormDataSource);
//#UC START# *4982B449023F_47EB55FD007Aset_var*
//#UC END# *4982B449023F_47EB55FD007Aset_var*
begin
//#UC START# *4982B449023F_47EB55FD007Aset_impl*
 if (f_DataSource <> nil) then
  IvcmFormDataSource(f_DataSource).Unsubscribe(Il3ItemNotifyRecipient(Self));
 f_DataSource := Pointer(aValue);
 if (f_DataSource <> nil) then
  IvcmFormDataSource(f_DataSource).Subscribe(Il3ItemNotifyRecipient(Self));
//#UC END# *4982B449023F_47EB55FD007Aset_impl*
end;//TvcmFormDataSourceRef.pm_SetReferred

function TvcmFormDataSourceRef.pm_GetNeedMake: TvcmNeedMakeDS;
//#UC START# *4982B4600057_47EB55FD007Aget_var*
//#UC END# *4982B4600057_47EB55FD007Aget_var*
begin
//#UC START# *4982B4600057_47EB55FD007Aget_impl*
 Result := f_NeedMake;
//#UC END# *4982B4600057_47EB55FD007Aget_impl*
end;//TvcmFormDataSourceRef.pm_GetNeedMake

procedure TvcmFormDataSourceRef.pm_SetNeedMake(aValue: TvcmNeedMakeDS);
//#UC START# *4982B4600057_47EB55FD007Aset_var*
//#UC END# *4982B4600057_47EB55FD007Aset_var*
begin
//#UC START# *4982B4600057_47EB55FD007Aset_impl*
 f_NeedMake := aValue;
//#UC END# *4982B4600057_47EB55FD007Aset_impl*
end;//TvcmFormDataSourceRef.pm_SetNeedMake

function TvcmFormDataSourceRef.pm_GetIsEmpty: Boolean;
//#UC START# *4982B4940122_47EB55FD007Aget_var*
//#UC END# *4982B4940122_47EB55FD007Aget_var*
begin
//#UC START# *4982B4940122_47EB55FD007Aget_impl*
 Result := not Assigned(f_DataSource);
//#UC END# *4982B4940122_47EB55FD007Aget_impl*
end;//TvcmFormDataSourceRef.pm_GetIsEmpty

function TvcmFormDataSourceRef.pm_GetCanBeClosed: Boolean;
//#UC START# *4982B4A501A0_47EB55FD007Aget_var*
//#UC END# *4982B4A501A0_47EB55FD007Aget_var*
begin
//#UC START# *4982B4A501A0_47EB55FD007Aget_impl*
 Result := f_NeedMake = vcm_nmForce;
//#UC END# *4982B4A501A0_47EB55FD007Aget_impl*
end;//TvcmFormDataSourceRef.pm_GetCanBeClosed

procedure TvcmFormDataSourceRef.Cleanup;
//#UC START# *479731C50290_47EB55FD007A_var*
//#UC END# *479731C50290_47EB55FD007A_var*
begin
//#UC START# *479731C50290_47EB55FD007A_impl*
 pm_SetReferred(nil);
 inherited;
//#UC END# *479731C50290_47EB55FD007A_impl*
end;//TvcmFormDataSourceRef.Cleanup

function VcmCheckAndMake(var aRef: IvcmFormDataSourceRef;
  aNeedMake: TvcmNeedMakeDS = vcm_nmNo): IvcmFormDataSourceRef;
//#UC START# *4982B743016E_4982B6510327_var*
//#UC END# *4982B743016E_4982B6510327_var*
begin
//#UC START# *4982B743016E_4982B6510327_impl*
 if (aRef = nil) then
  aRef := TvcmFormDataSourceRef.Make(aNeedMake);
 Result := aRef;
//#UC END# *4982B743016E_4982B6510327_impl*
end;//VcmCheckAndMake
{$IfEnd} //not NoVCM

end.