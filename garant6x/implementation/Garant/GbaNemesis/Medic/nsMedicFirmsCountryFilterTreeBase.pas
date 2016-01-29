unit nsMedicFirmsCountryFilterTreeBase;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Medic"
// Автор: Лукьянец Р.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/nsMedicFirmsCountryFilterTreeBase.pas"
// Начат: 2008/03/21 11:36:49
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Inpharm::Medic::Medic$Unit::TnsMedicFirmsCountryFilterTreeBase
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3TreeInterfaces,
  nsDataResetTreeStruct,
  bsInterfaces,
  nsMedicFirmsSubscribersList,
  DynamicTreeUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsMedicFirmsCountryFilterTreeBase = class(TnsDataResetTreeStruct, InsMedicFirmsTreeNotificationSource)
 private
 // private fields
   f_MFSubscribers : TnsMedicFirmsSubscribersList;
 private
 // private methods
   procedure NotifyMedicFirmsRecipients;
 protected
 // realized methods
   function ReAqurieUnfilteredRoot: INodeBase; override;
   procedure Subscribe(const aSubscriber: InsMedicFirmsTreeNotifyRecipient);
   procedure Unsubscribe(const aSubscriber: InsMedicFirmsTreeNotifyRecipient);
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
   procedure BeforeReset; override;
 public
 // public methods
   constructor Create; reintroduce;
   class function Make: Il3SimpleTree;
 end;//TnsMedicFirmsCountryFilterTreeBase
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  SysUtils,
  DataAdapter,
  nsTypes,
  nsConst
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsMedicFirmsCountryFilterTreeBase

constructor TnsMedicFirmsCountryFilterTreeBase.Create;
//#UC START# *49071D400235_49071BFA03A4_var*
//#UC END# *49071D400235_49071BFA03A4_var*
begin
//#UC START# *49071D400235_49071BFA03A4_impl*
 inherited Create(ReAqurieUnfilteredRoot, False);
//#UC END# *49071D400235_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.Create

class function TnsMedicFirmsCountryFilterTreeBase.Make: Il3SimpleTree;
//#UC START# *49071D53036B_49071BFA03A4_var*
Var
 l_Tree: TnsMedicFirmsCountryFilterTreeBase;
//#UC END# *49071D53036B_49071BFA03A4_var*
begin
//#UC START# *49071D53036B_49071BFA03A4_impl*
 if not defDataAdapter.IsInpharmExists then
 begin
  Result := nil;
  Exit;
 end;
 l_Tree := Create;
 try
  Result := l_Tree;
 finally;
  FreeAndNil(l_Tree);
 end;
//#UC END# *49071D53036B_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.Make

procedure TnsMedicFirmsCountryFilterTreeBase.NotifyMedicFirmsRecipients;
//#UC START# *49071EDC0216_49071BFA03A4_var*
var
 l_Index : Integer;
//#UC END# *49071EDC0216_49071BFA03A4_var*
begin
//#UC START# *49071EDC0216_49071BFA03A4_impl*
 if (f_MFSubscribers <> nil) then
  for l_Index := 0 to Pred(f_MFSubscribers.Count) do
   f_MFSubscribers[l_Index].CountryFilterResetted;
//#UC END# *49071EDC0216_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.NotifyMedicFirmsRecipients

function TnsMedicFirmsCountryFilterTreeBase.ReAqurieUnfilteredRoot: INodeBase;
//#UC START# *48FF64F60078_49071BFA03A4_var*
//#UC END# *48FF64F60078_49071BFA03A4_var*
begin
//#UC START# *48FF64F60078_49071BFA03A4_impl*
 Result := DefDataAdapter.NativeAdapter.MakeNodeBase(nsAStr(AT_PHARM_COUNTRY_FOR_FILTER));
//#UC END# *48FF64F60078_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.ReAqurieUnfilteredRoot

procedure TnsMedicFirmsCountryFilterTreeBase.Subscribe(const aSubscriber: InsMedicFirmsTreeNotifyRecipient);
//#UC START# *49071B0F0100_49071BFA03A4_var*
//#UC END# *49071B0F0100_49071BFA03A4_var*
begin
//#UC START# *49071B0F0100_49071BFA03A4_impl*
 if (f_MFSubscribers = nil) then
  f_MFSubscribers := TnsMedicFirmsSubscribersList.Make;
 f_MFSubscribers.Add(aSubscriber);
//#UC END# *49071B0F0100_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.Subscribe

procedure TnsMedicFirmsCountryFilterTreeBase.Unsubscribe(const aSubscriber: InsMedicFirmsTreeNotifyRecipient);
//#UC START# *49071B1D0098_49071BFA03A4_var*
//#UC END# *49071B1D0098_49071BFA03A4_var*
begin
//#UC START# *49071B1D0098_49071BFA03A4_impl*
 if (f_MFSubscribers <> nil) then
  f_MFSubscribers.Remove(aSubscriber);
//#UC END# *49071B1D0098_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.Unsubscribe

procedure TnsMedicFirmsCountryFilterTreeBase.Cleanup;
//#UC START# *479731C50290_49071BFA03A4_var*
//#UC END# *479731C50290_49071BFA03A4_var*
begin
//#UC START# *479731C50290_49071BFA03A4_impl*
 FreeAndNil(f_MFSubscribers);
 inherited;
//#UC END# *479731C50290_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.Cleanup

procedure TnsMedicFirmsCountryFilterTreeBase.BeforeReset;
//#UC START# *48FF64E700E5_49071BFA03A4_var*
//#UC END# *48FF64E700E5_49071BFA03A4_var*
begin
//#UC START# *48FF64E700E5_49071BFA03A4_impl*
 inherited;
 NotifyMedicFirmsRecipients;
//#UC END# *48FF64E700E5_49071BFA03A4_impl*
end;//TnsMedicFirmsCountryFilterTreeBase.BeforeReset

{$IfEnd} //not Admin AND not Monitorings

end.