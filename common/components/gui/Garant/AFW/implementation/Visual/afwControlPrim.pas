unit afwControlPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AFW"
// ������: "w:/common/components/gui/Garant/AFW/implementation/Visual/afwControlPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi::AFW::afwControl::TafwControlPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\Garant\AFW\afwDefine.inc}

interface

uses
  OvcBase,
  l3PureMixIns
  ;

type
//#UC START# *48BC1AC0027Cci*
 {$Define _UnknownIsComponent}
//#UC END# *48BC1AC0027Cci*
 _l3Unknown_Parent_ = TOvcBase;
 {$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}
//#UC START# *48BC1AC0027Ccit*
//#UC END# *48BC1AC0027Ccit*
 TafwControlPrim = class(_l3Unknown_)
//#UC START# *48BC1AC0027Cpubl*
 protected
   {$I l3DefineCleanup.inc}
//#UC END# *48BC1AC0027Cpubl*
 end;//TafwControlPrim

implementation

uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  ,
  SysUtils,
  l3Base,
  l3Core,
  Windows,
  l3MemUtils,
  l3Interlocked
  ;

{$Include w:\common\components\rtl\Garant\L3\l3Unknown.imp.pas}


//#UC START# *48BC1AC0027Cimpl*
type
 _Unknown_Child_ = TafwControlPrim;
{$I l3ImplCleanup.inc}
begin
end;
//#UC END# *48BC1AC0027Cimpl*

initialization
{$If not defined(NoScripts)}
// ����������� TafwControlPrim
 TtfwClassRef.Register(TafwControlPrim);
{$IfEnd} //not NoScripts

end.