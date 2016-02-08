unit GarORBInitializerImpl;

// Модуль: "w:\common\components\rtl\Garant\GarORB\GarORBInitializerImpl.pas"
// Стереотип: "SimpleClass"

{$Include tfwDefine.inc}

interface

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3IntfUses
 , pi
 , pi_int
;

type
 TGarORBInitializerImpl = class(TORBInitializer)
  protected
   procedure pre__init(const info: IORBInitInfo); override;
   procedure post__init(const info: IORBInitInfo); override;
  public
   class procedure Init;
 end;//TGarORBInitializerImpl
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

implementation

{$If Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)}
uses
 l3ImplUses
 , GarClientSecurity
 , pi_impl
 , SysUtils
;

class procedure TGarORBInitializerImpl.Init;
//#UC START# *4CA0D2C203BE_4CA0D1B8017C_var*
//#UC END# *4CA0D2C203BE_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D2C203BE_4CA0D1B8017C_impl*
 TPIManager.RegisterOrbInitializer(Self.Create);
//#UC END# *4CA0D2C203BE_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.Init

procedure TGarORBInitializerImpl.pre__init(const info: IORBInitInfo);
//#UC START# *4CA0D24C02B9_4CA0D1B8017C_var*
//#UC END# *4CA0D24C02B9_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D24C02B9_4CA0D1B8017C_impl*
//#UC END# *4CA0D24C02B9_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.pre__init

procedure TGarORBInitializerImpl.post__init(const info: IORBInitInfo);
//#UC START# *4CA0D27000D5_4CA0D1B8017C_var*
var
 l_N : String;
//#UC END# *4CA0D27000D5_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D27000D5_4CA0D1B8017C_impl*
 l_N := ChangeFileExt(ParamStr(0), '.clog');
 AssignFile(Output, l_N);
 if FileExists(l_N) then
  Append(Output)
 else
  Rewrite(Output);
 WriteLn(DateTimeToStr(Now));
 info.add_client_request_interceptor(TGarClientSecurity.Create(info));
//#UC END# *4CA0D27000D5_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.post__init
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
