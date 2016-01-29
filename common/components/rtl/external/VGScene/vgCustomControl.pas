unit vgCustomControl;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgCustomControl.pas"
// Начат: 10.02.2011 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::lulin::TvgCustomControl
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  l3PureMixIns
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
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
 // public methods
   procedure Free(var Dummy: Integer);
     {* Для ловли Free }
//#UC START# *4D5416AC01D1publ*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *4D5416AC01D1publ*
 end;//TvgCustomControl
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  SysUtils
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvgCustomControl

procedure TvgCustomControl.Free(var Dummy: Integer);
//#UC START# *4D54173D03B8_4D5416AC01D1_var*
//#UC END# *4D54173D03B8_4D5416AC01D1_var*
begin
//#UC START# *4D54173D03B8_4D5416AC01D1_impl*
 Assert(false, 'Используйте FreeAndNil');
//#UC END# *4D54173D03B8_4D5416AC01D1_impl*
end;//TvgCustomControl.Free

//#UC START# *4D5416AC01D1impl*
type
 _Unknown_Child_ = TvgCustomControl;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *4D5416AC01D1impl*

{$IfEnd} //not NoVGScene

initialization
{$If not defined(NoScripts) AND not defined(NoVGScene)}
// Регистрация TvgCustomControl
 TtfwClassRef.Register(TvgCustomControl);
{$IfEnd} //not NoScripts AND not NoVGScene

end.