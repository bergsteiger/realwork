unit NOT_FINISHED_l3ExceptionsLog;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3$Basic Concepts"
// ������: "NOT_FINISHED_l3ExceptionsLog.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: SimpleClass::Class Shared Delphi ���������� � �������������� �����������::L3$Basic Concepts::Logging::Tl3ExceptionsLog
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

type
 Tl3ExceptionsLog = class(TObject)
 protected
 // protected methods
    {$If defined(_m0USEFORMS1)}
   procedure SetOnException; virtual;
     {* ��������� ������ SetOnException }
    {$IfEnd} //_m0USEFORMS1
    {$If defined(_m0USEFORMS1)}
   procedure ResOnException; virtual;
     {* ��������� ������ ResOnException }
    {$IfEnd} //_m0USEFORMS1
   function NeedTime: Boolean; virtual;
 end;//Tl3ExceptionsLog

implementation

// start class Tl3ExceptionsLog

{$If defined(_m0USEFORMS1)}
procedure Tl3ExceptionsLog.SetOnException;
//#UC START# *540EE287029C_540EE24702BC_var*
//#UC END# *540EE287029C_540EE24702BC_var*
begin
//#UC START# *540EE287029C_540EE24702BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *540EE287029C_540EE24702BC_impl*
end;//Tl3ExceptionsLog.SetOnException
{$IfEnd} //_m0USEFORMS1

{$If defined(_m0USEFORMS1)}
procedure Tl3ExceptionsLog.ResOnException;
//#UC START# *540EE29A0095_540EE24702BC_var*
//#UC END# *540EE29A0095_540EE24702BC_var*
begin
//#UC START# *540EE29A0095_540EE24702BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *540EE29A0095_540EE24702BC_impl*
end;//Tl3ExceptionsLog.ResOnException
{$IfEnd} //_m0USEFORMS1

function Tl3ExceptionsLog.NeedTime: Boolean;
//#UC START# *5422E8FC025D_540EE24702BC_var*
//#UC END# *5422E8FC025D_540EE24702BC_var*
begin
//#UC START# *5422E8FC025D_540EE24702BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5422E8FC025D_540EE24702BC_impl*
end;//Tl3ExceptionsLog.NeedTime

end.