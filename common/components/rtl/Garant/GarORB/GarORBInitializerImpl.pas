unit GarORBInitializerImpl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GarORB"
// Модуль: "w:/common/components/rtl/Garant/GarORB/GarORBInitializerImpl.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::GarORB::IniAndFini::TGarORBInitializerImpl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\GarORB\tfwDefine.inc}

interface

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  pi,
  pi_int
  ;
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
type
 TGarORBInitializerImpl = class(TORBInitializer)
 protected
 // realized methods
   procedure Pre_init(const info: IORBInitInfo); override;
   procedure Post_init(const info: IORBInitInfo); override;
 public
 // public methods
   class procedure Init;
 end;//TGarORBInitializerImpl
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

implementation

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}
uses
  GarClientSecurity,
  pi_impl,
  SysUtils
  ;
{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

{$If defined(MTDORB) AND defined(nsTest) AND not defined(NotTunedDUnit)}

// start class TGarORBInitializerImpl

class procedure TGarORBInitializerImpl.Init;
//#UC START# *4CA0D2C203BE_4CA0D1B8017C_var*
//#UC END# *4CA0D2C203BE_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D2C203BE_4CA0D1B8017C_impl*
 TPIManager.RegisterOrbInitializer(Self.Create);
//#UC END# *4CA0D2C203BE_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.Init

procedure TGarORBInitializerImpl.Pre_init(const info: IORBInitInfo);
//#UC START# *4CA0D24C02B9_4CA0D1B8017C_var*
//#UC END# *4CA0D24C02B9_4CA0D1B8017C_var*
begin
//#UC START# *4CA0D24C02B9_4CA0D1B8017C_impl*
//#UC END# *4CA0D24C02B9_4CA0D1B8017C_impl*
end;//TGarORBInitializerImpl.Pre_init

procedure TGarORBInitializerImpl.Post_init(const info: IORBInitInfo);
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
end;//TGarORBInitializerImpl.Post_init

{$IfEnd} //MTDORB AND nsTest AND not NotTunedDUnit

end.