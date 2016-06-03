unit Autoreferat_InternalOperations_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Autoreferat_InternalOperations_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "InternalOperations" MUID: (4A8ECFED02D8)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 Op_DateInterval_OpenInt = {final} class
  {* Класс для вызова операции DateInterval.OpenInt }
  public
   class function Call(const aTarget: IvcmEntity): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload;
    {* Вызов операции DateInterval.OpenInt у контейнера }
 end;//Op_DateInterval_OpenInt

const
 en_DateInterval = 'DateInterval';
 en_capDateInterval = '';
 op_OpenInt = 'OpenInt';
 op_capOpenInt = '';
 en_NewsThemes = 'NewsThemes';
 en_capNewsThemes = '';
 op_SelectCurrent = 'SelectCurrent';
 op_capSelectCurrent = '';
 op_Open = 'Open';
 op_capOpen = '';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntity): Boolean;
 {* Вызов операции DateInterval.OpenInt у сущности }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_DateInterval_OpenInt, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmAggregate): Boolean;
 {* Вызов операции DateInterval.OpenInt у агрегации }
var
 l_Params : IvcmExecuteParams;
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
 begin
  l_Params := vcmParams;
  aTarget.Operation(TdmStdRes.opcode_DateInterval_OpenInt, l_Params);
  with l_Params do
  begin
   if Done then
   begin
    Result := true;
   end;//Done
  end;//with l_Params
 end;//aTarget <> nil
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntityForm): Boolean;
 {* Вызов операции DateInterval.OpenInt у формы }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmContainer): Boolean;
 {* Вызов операции DateInterval.OpenInt у контейнера }
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_DateInterval_OpenInt.Call
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
