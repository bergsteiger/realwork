unit l3_Base;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3_Base.pas"
// �����: 05.02.2008 16:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3_Base
//
// ! ������� ����� �������� ���������� L3. ������������� ��� ������������ �� ���� ���������
// ��������������� ��������. ������������ �������� �� �������������� ������ � �������������
// ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleObject,
  l3PureMixIns
  ;

type
 _l3Changing_Parent_ = Tl3SimpleObject;
 {$Include ..\L3\l3Changing.imp.pas}
 Tl3_Base = class(_l3Changing_)
  {* ! ������� ����� �������� ���������� L3. ������������� ��� ������������ �� ���� ��������� ��������������� ��������. ������������ �������� �� �������������� ������ � ������������� ��������. }
 public
 // public methods
   function OCompare(anObject: Tl3_Base): Integer; virtual;
     {* ������� ��������� ������� � ������ ��������. }
   constructor Create; reintroduce; virtual;
     {* ����������� �������. ���������� ������, �� ��������� ������ ������ 1. }
 end;//Tl3_Base

implementation

uses
  l3Base
  ;

{$Include ..\L3\l3Changing.imp.pas}

// start class Tl3_Base

function Tl3_Base.OCompare(anObject: Tl3_Base): Integer;
//#UC START# *478CEE670214_47879856035F_var*
//#UC END# *478CEE670214_47879856035F_var*
begin
//#UC START# *478CEE670214_47879856035F_impl*
 Assert(false);
 Result := -1;
//#UC END# *478CEE670214_47879856035F_impl*
end;//Tl3_Base.OCompare

constructor Tl3_Base.Create;
//#UC START# *47914F960008_47879856035F_var*
//#UC END# *47914F960008_47879856035F_var*
begin
//#UC START# *47914F960008_47879856035F_impl*
 inherited Create;
//#UC END# *47914F960008_47879856035F_impl*
end;//Tl3_Base.Create

end.