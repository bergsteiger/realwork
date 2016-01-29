unit vcmWinControlActionLink;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmWinControlActionLink.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmWinControlActionLink
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  vcmExternalInterfaces
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
 {$Define _UnknownNeedsQI}

type
 _l3Unknown_Parent_ = TWinControlActionLink;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
 TvcmWinControlActionLink = class(_l3Unknown_, IvcmActionLink)
 protected
 // realized methods
   procedure ParamsChanged(const anAction: IvcmAction);
   procedure ParamsChanging(const anAction: IvcmAction);
 protected
 // protected methods
   procedure DoParamsChanged(const anAction: IvcmAction); virtual;
   procedure DoParamsChanging(const anAction: IvcmAction); virtual;
 end;//TvcmWinControlActionLink
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  Graphics,
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  Classes,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

type
  THackControl = class(TControl)
  end;//THackControl

// start class TvcmWinControlActionLink

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

{$IfEnd} //not NoVCM

end.