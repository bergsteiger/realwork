unit k2NonAtomicTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2NonAtomicTag.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2NonAtomicTag
//
// ������� ����������� ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2Tag
  ;

type
 Tk2NonAtomicTag = {abstract} class(Tk2Tag)
  {* ������� ����������� ��� }
 protected
 // overridden protected methods
   function GetIsOrd: Boolean; override;
 end;//Tk2NonAtomicTag

implementation

// start class Tk2NonAtomicTag

function Tk2NonAtomicTag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_532080BB027A_var*
//#UC END# *532AE8F2009A_532080BB027A_var*
begin
//#UC START# *532AE8F2009A_532080BB027A_impl*
 Result := false;
//#UC END# *532AE8F2009A_532080BB027A_impl*
end;//Tk2NonAtomicTag.GetIsOrd

end.