unit vgCustomControl;

// ������: "w:\common\components\rtl\external\VGScene\vgCustomControl.pas"
// ���������: "SimpleClass"
// ������� ������: "TvgCustomControl" MUID: (4D5416AC01D1)

{$Include w:\common\components\rtl\external\VGScene\vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3PureMixIns
 //#UC START# *4D5416AC01D1intf_uses*
 //#UC END# *4D5416AC01D1intf_uses*
;

 {$Define _UnknownIsComponent}

 {$Define l3Unknown_NoIUnknown}

type
 //#UC START# *4D5416AC01D1ci*
 //#UC END# *4D5416AC01D1ci*
 _l3Unknown_Parent_ = TCustomControl;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 //#UC START# *4D5416AC01D1cit*
 //#UC END# *4D5416AC01D1cit*
 TvgCustomControl = class(_l3Unknown_)
  public
   procedure Free(var Dummy: Integer);
    {* ��� ����� Free }
 //#UC START# *4D5416AC01D1publ*
 protected
   {$I l3DefineCleanup.inc}
 //#UC END# *4D5416AC01D1publ*
 end;//TvgCustomControl
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
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
 //#UC START# *4D5416AC01D1impl_uses*
 //#UC END# *4D5416AC01D1impl_uses*
;

{$If NOT Defined(NoVCL)}
{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvgCustomControl.Free(var Dummy: Integer);
 {* ��� ����� Free }
//#UC START# *4D54173D03B8_4D5416AC01D1_var*
//#UC END# *4D54173D03B8_4D5416AC01D1_var*
begin
//#UC START# *4D54173D03B8_4D5416AC01D1_impl*
 Assert(false, '����������� FreeAndNil');
//#UC END# *4D54173D03B8_4D5416AC01D1_impl*
end;//TvgCustomControl.Free

//#UC START# *4D5416AC01D1impl*
type
 _Unknown_Child_ = TvgCustomControl;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D5416AC01D1impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvgCustomControl);
 {* ����������� TvgCustomControl }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(NoVCL)

{$IfEnd} // NOT Defined(NoVGScene)
end.
