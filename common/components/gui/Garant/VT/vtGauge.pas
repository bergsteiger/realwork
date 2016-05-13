unit vtGauge;

// ������: "w:\common\components\gui\Garant\VT\vtGauge.pas"
// ���������: "GuiControl"
// ������� ������: "TvtGauge" MUID: (53E49235000B)

{$Include w:\common\components\gui\Garant\VT\vtDefine.inc}

interface

uses
 l3IntfUses
 , Gauges
 , l3PureMixIns
 //#UC START# *53E49235000Bintf_uses*
 //#UC END# *53E49235000Bintf_uses*
;

type
 //#UC START# *53E49235000Bci*
 {$Define _UnknownIsComponent}

 {$Define l3Unknown_NoIUnknown}
 //#UC END# *53E49235000Bci*
 _l3Unknown_Parent_ = TGauge;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *53E49235000Bcit*
 //#UC END# *53E49235000Bcit*
 TvtGauge = class(_l3Unknown_)
  public
   procedure Free(var Dummy: Integer);
    {* ��� ����� Free }
 //#UC START# *53E49235000Bpubl*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *53E49235000Bpubl*
 end;//TvtGauge

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *53E49235000Bimpl_uses*
 //#UC END# *53E49235000Bimpl_uses*
;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvtGauge.Free(var Dummy: Integer);
 {* ��� ����� Free }
//#UC START# *53E494B002C7_53E49235000B_var*
//#UC END# *53E494B002C7_53E49235000B_var*
begin
//#UC START# *53E494B002C7_53E49235000B_impl*
 Assert(False, 'Use FreeAndNil, Luke!');
//#UC END# *53E494B002C7_53E49235000B_impl*
end;//TvtGauge.Free

//#UC START# *53E49235000Bimpl*
type
 _Unknown_Child_ = TvtGauge;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *53E49235000Bimpl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtGauge);
 {* ����������� TvtGauge }
{$IfEnd} // NOT Defined(NoScripts)

end.
