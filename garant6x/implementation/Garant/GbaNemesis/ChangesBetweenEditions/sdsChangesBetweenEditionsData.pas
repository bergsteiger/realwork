unit sdsChangesBetweenEditionsData;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ChangesBetweenEditions$Domain"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/ChangesBetweenEditions/sdsChangesBetweenEditionsData.pas"
// Начат: 25.05.2011 16:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Пользовательские сервисы::ChangesBetweenEditions::ChangesBetweenEditions$Domain::ChangesBetweenEditionsImplementation::TsdsChangesBetweenEditionsData
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
  ChangesBetweenEditionsInterfaces
  {$If not defined(NoVCM)}
  ,
  vcmInterfaces
  {$IfEnd} //not NoVCM
  ,
  l3ProtoObject
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _IvcmRealData_ = IsdsChangesBetweenEditionsData;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 TsdsChangesBetweenEditionsData = class(_vcmData_, IsdsChangesBetweenEditionsData)
 private
 // private fields
   f_Info : InsChangesBetweenEditionsInfo;
 protected
 // realized methods
   function Get_Info: InsChangesBetweenEditionsInfo;
 protected
 // overridden protected methods
   {$If not defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} //not NoVCM
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const anInfo: InsChangesBetweenEditionsInfo); reintroduce;
   class function Make(const anInfo: InsChangesBetweenEditionsInfo): IsdsChangesBetweenEditionsData; reintroduce;
     {* Сигнатура фабрики TsdsChangesBetweenEditionsData.Make }
 end;//TsdsChangesBetweenEditionsData
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

type _Instance_R_ = TsdsChangesBetweenEditionsData;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}

// start class TsdsChangesBetweenEditionsData

constructor TsdsChangesBetweenEditionsData.Create(const anInfo: InsChangesBetweenEditionsInfo);
//#UC START# *4DDCF6AB0206_4DDCF660018A_var*
//#UC END# *4DDCF6AB0206_4DDCF660018A_var*
begin
//#UC START# *4DDCF6AB0206_4DDCF660018A_impl*
 inherited Create;
 f_Info := anInfo;
//#UC END# *4DDCF6AB0206_4DDCF660018A_impl*
end;//TsdsChangesBetweenEditionsData.Create

class function TsdsChangesBetweenEditionsData.Make(const anInfo: InsChangesBetweenEditionsInfo): IsdsChangesBetweenEditionsData;
var
 l_Inst : TsdsChangesBetweenEditionsData;
begin
 l_Inst := Create(anInfo);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TsdsChangesBetweenEditionsData.Get_Info: InsChangesBetweenEditionsInfo;
//#UC START# *4DDCF63C0353_4DDCF660018Aget_var*
//#UC END# *4DDCF63C0353_4DDCF660018Aget_var*
begin
//#UC START# *4DDCF63C0353_4DDCF660018Aget_impl*
 Result := f_Info;
//#UC END# *4DDCF63C0353_4DDCF660018Aget_impl*
end;//TsdsChangesBetweenEditionsData.Get_Info

{$If not defined(NoVCM)}
procedure TsdsChangesBetweenEditionsData.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_4DDCF660018A_var*
//#UC END# *4B16B8CF0307_4DDCF660018A_var*
begin
//#UC START# *4B16B8CF0307_4DDCF660018A_impl*
 inherited;
 f_Info := aData.Info;
//#UC END# *4B16B8CF0307_4DDCF660018A_impl*
end;//TsdsChangesBetweenEditionsData.AssignData
{$IfEnd} //not NoVCM

procedure TsdsChangesBetweenEditionsData.ClearFields;
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_Info := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TsdsChangesBetweenEditionsData.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.