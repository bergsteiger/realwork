unit vcmWinControlActionLink;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmWinControlActionLink.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , vcmExternalInterfaces
 , l3PureMixIns
;

 {$Define _UnknownNeedsQI}

type
 _l3Unknown_Parent_ = TWinControlActionLink;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmWinControlActionLink = class(_l3Unknown_, IvcmActionLink)
  protected
   procedure DoParamsChanged(const anAction: IvcmAction); virtual;
   procedure DoParamsChanging(const anAction: IvcmAction); virtual;
   procedure ParamsChanged(const anAction: IvcmAction);
   procedure ParamsChanging(const anAction: IvcmAction);
 end;//TvcmWinControlActionLink
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , Graphics
;

type
 THackControl = class(TControl)
 end;//THackControl

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

procedure TvcmWinControlActionLink.DoParamsChanged(const anAction: IvcmAction);
//#UC START# *52A8469903AF_52A845E50292_var*
//#UC END# *52A8469903AF_52A845E50292_var*
begin
//#UC START# *52A8469903AF_52A845E50292_impl*
 if (FClient is TControl) then
  if (anAction.Font <> nil) then
   with anAction.Font do
   begin
    if (BackColor <> clDefault) then
     THackControl(FClient).Color := BackColor;
    Assign2Font(THackControl(FClient).Font);
   end;//with anAction.Font
//#UC END# *52A8469903AF_52A845E50292_impl*
end;//TvcmWinControlActionLink.DoParamsChanged

procedure TvcmWinControlActionLink.DoParamsChanging(const anAction: IvcmAction);
//#UC START# *52A846AF0108_52A845E50292_var*
//#UC END# *52A846AF0108_52A845E50292_var*
begin
//#UC START# *52A846AF0108_52A845E50292_impl*
//#UC END# *52A846AF0108_52A845E50292_impl*
end;//TvcmWinControlActionLink.DoParamsChanging

procedure TvcmWinControlActionLink.ParamsChanged(const anAction: IvcmAction);
//#UC START# *476961930017_52A845E50292_var*
//#UC END# *476961930017_52A845E50292_var*
begin
//#UC START# *476961930017_52A845E50292_impl*
 DoParamsChanged(anAction);
//#UC END# *476961930017_52A845E50292_impl*
end;//TvcmWinControlActionLink.ParamsChanged

procedure TvcmWinControlActionLink.ParamsChanging(const anAction: IvcmAction);
//#UC START# *476961A40369_52A845E50292_var*
//#UC END# *476961A40369_52A845E50292_var*
begin
//#UC START# *476961A40369_52A845E50292_impl*
 DoParamsChanging(anAction);
//#UC END# *476961A40369_52A845E50292_impl*
end;//TvcmWinControlActionLink.ParamsChanging
{$IfEnd} // NOT Defined(NoVCM)

end.
