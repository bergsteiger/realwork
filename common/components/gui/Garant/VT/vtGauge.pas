unit vtGauge;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VT"
// Модуль: "w:/common/components/gui/Garant/VT/vtGauge.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::VT::Stuff::TvtGauge
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  Gauges,
  l3PureMixIns
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
 // public methods
   procedure Free(var Dummy: Integer);
     {* Для ловли Free }
//#UC START# *53E49235000Bpubl*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *53E49235000Bpubl*
 end;//TvtGauge

implementation

uses
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  Classes,
  l3MemUtils,
  l3Interlocked
  ;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}

// start class TvtGauge

procedure TvtGauge.Free(var Dummy: Integer);
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

end.