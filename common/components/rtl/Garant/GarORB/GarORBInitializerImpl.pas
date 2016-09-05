unit GarORBInitializerImpl;

// Модуль: "w:\common\components\rtl\Garant\GarORB\GarORBInitializerImpl.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TGarORBInitializerImpl" MUID: (4CA0D1B8017C)

{$Include w:\common\components\rtl\Garant\GarORB\tfwDefine.inc}

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
   procedure pre_init(const info: IORBInitInfo); override;
   procedure post_init(const info: IORBInitInfo); override;
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
 //#UC START# *4CA0D1B8017Cimpl_uses*
 //#UC END# *4CA0D1B8017Cimpl_uses*
;

class procedure TGarORBInitializerImpl.Init;
//#UC START# *4CA0D2C203BE_4CA0D1B8017C_var*
//#UC END# *4CA0D2C203BE_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D2C203BE_4CA0D1B8017C_impl*
 TPIManager.RegisterOrbInitializer(Self.Create);
//#UC END# *4CA0D2C203BE_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.Init

procedure TGarORBInitializerImpl.pre_init(const info: IORBInitInfo);
//#UC START# *4CA0D24C02B9_4CA0D1B8017C_var*
//#UC END# *4CA0D24C02B9_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D24C02B9_4CA0D1B8017C_impl*
//#UC END# *4CA0D24C02B9_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.pre_init

procedure TGarORBInitializerImpl.post_init(const info: IORBInitInfo);
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
end;//TGarORBInitializerImpl.post_init
{$IfEnd} // Defined(nsTest) AND Defined(MTDORB) AND NOT Defined(NotTunedDUnit)

end.
