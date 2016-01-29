unit Autoreferat_InternalOperations_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Autoreferat_InternalOperations_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Пользовательские сервисы::Autoreferat::View::InternalOperations
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
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  vcmExternalInterfaces {a}
  ;

(* DateInterval = operations
   ['{C6020F25-AB17-44C2-A7E3-EBE1F314C861}']
   query OpenInt;
 end;//DateInterval*)

(* NewsThemes = operations
   ['{5438F88D-7BE5-4D78-A102-A3684DFE8624}']
   operation SelectCurrent;
 end;//NewsThemes*)

(* DateInterval = operations
   ['{F179CEDA-0625-4BC2-B492-4810682BD1AF}']
   operation Open;
 end;//DateInterval*)

type
 Op_DateInterval_OpenInt = class
  {* Класс для вызова операции DateInterval.OpenInt }
 public
 // public methods
   class function Call(const aTarget: IvcmEntity): Boolean; overload; 
     {* Вызов операции DateInterval.OpenInt у сущности }
   class function Call(const aTarget: IvcmAggregate): Boolean; overload; 
     {* Вызов операции DateInterval.OpenInt у агрегации }
   class function Call(const aTarget: IvcmEntityForm): Boolean; overload; 
     {* Вызов операции DateInterval.OpenInt у формы }
   class function Call(const aTarget: IvcmContainer): Boolean; overload; 
     {* Вызов операции DateInterval.OpenInt у контейнера }
 end;//Op_DateInterval_OpenInt
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

// start class Op_DateInterval_OpenInt

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmEntity): Boolean;
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
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.Entity);
end;//Op_DateInterval_OpenInt.Call

class function Op_DateInterval_OpenInt.Call(const aTarget: IvcmContainer): Boolean;
 {-}
begin
 l3FillChar(Result, SizeOf(Result));
 if (aTarget <> nil) then
  Result := Call(aTarget.AsForm);
end;//Op_DateInterval_OpenInt.Call
{$IfEnd} //not Admin AND not Monitorings


end.