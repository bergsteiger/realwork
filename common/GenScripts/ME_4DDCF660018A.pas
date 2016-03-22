unit sdsChangesBetweenEditionsData;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\ChangesBetweenEditions\sdsChangesBetweenEditionsData.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TsdsChangesBetweenEditionsData" MUID: (4DDCF660018A)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ChangesBetweenEditionsInterfaces
 , l3ProtoObject
 {$If NOT Defined(NoVCM)}
 , vcmInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

type
 _IvcmRealData_ = IsdsChangesBetweenEditionsData;
 {$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}
 TsdsChangesBetweenEditionsData = class(_vcmData_, IsdsChangesBetweenEditionsData)
  private
   f_Info: InsChangesBetweenEditionsInfo;
  protected
   function Get_Info: InsChangesBetweenEditionsInfo;
   {$If NOT Defined(NoVCM)}
   procedure AssignData(const aData: _IvcmRealData_); override;
   {$IfEnd} // NOT Defined(NoVCM)
   procedure ClearFields; override;
  public
   constructor Create(const anInfo: InsChangesBetweenEditionsInfo); reintroduce;
   class function Make(const anInfo: InsChangesBetweenEditionsInfo): IsdsChangesBetweenEditionsData; reintroduce;
 end;//TsdsChangesBetweenEditionsData
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

{$If NOT Defined(NoVCM)}
type _Instance_R_ = TsdsChangesBetweenEditionsData;

{$Include w:\common\components\gui\Garant\VCM\implementation\vcmData.imp.pas}

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
end;//TsdsChangesBetweenEditionsData.Make

function TsdsChangesBetweenEditionsData.Get_Info: InsChangesBetweenEditionsInfo;
//#UC START# *4DDCF63C0353_4DDCF660018Aget_var*
//#UC END# *4DDCF63C0353_4DDCF660018Aget_var*
begin
//#UC START# *4DDCF63C0353_4DDCF660018Aget_impl*
 Result := f_Info;
//#UC END# *4DDCF63C0353_4DDCF660018Aget_impl*
end;//TsdsChangesBetweenEditionsData.Get_Info

procedure TsdsChangesBetweenEditionsData.AssignData(const aData: _IvcmRealData_);
//#UC START# *4B16B8CF0307_4DDCF660018A_var*
//#UC END# *4B16B8CF0307_4DDCF660018A_var*
begin
//#UC START# *4B16B8CF0307_4DDCF660018A_impl*
 inherited;
 f_Info := aData.Info;
//#UC END# *4B16B8CF0307_4DDCF660018A_impl*
end;//TsdsChangesBetweenEditionsData.AssignData

procedure TsdsChangesBetweenEditionsData.ClearFields;
begin
 f_Info := nil;
 inherited;
end;//TsdsChangesBetweenEditionsData.ClearFields
{$IfEnd} // NOT Defined(NoVCM)

{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)
end.
