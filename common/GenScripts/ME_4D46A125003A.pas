unit vtOutlinerControl;

// ������: "w:\common\components\gui\Garant\VT\vtOutlinerControl.pas"
// ���������: "GuiControl"

{$Include vtDefine.inc}

interface

uses
 l3IntfUses
 , vtOutliner
;

type
 TvtOutlinerControl = class(TvtCustomOutliner)
  protected
   procedure Invalidate;
    {* ������ �� �����������. }
 end;//TvtOutlinerControl

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

procedure TvtOutlinerControl.Invalidate;
 {* ������ �� �����������. }
//#UC START# *46A5AA4B003C_4D46A125003A_var*
//#UC END# *46A5AA4B003C_4D46A125003A_var*
begin
//#UC START# *46A5AA4B003C_4D46A125003A_impl*
 inherited Invalidate;
//#UC END# *46A5AA4B003C_4D46A125003A_impl*
end;//TvtOutlinerControl.Invalidate

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TvtOutlinerControl);
 {* ����������� TvtOutlinerControl }
{$IfEnd} // NOT Defined(NoScripts)

end.
