unit k2Tag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2Tag.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2Tag
//
// ������� ���
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Variant
  ;

type
 Tk2Tag = {abstract} class(Tl3Tag)
  {* ������� ��� }
 protected
 // overridden protected methods
   function GetIsOrd: Boolean; override;
 end;//Tk2Tag

implementation

// start class Tk2Tag

function Tk2Tag.GetIsOrd: Boolean;
//#UC START# *532AE8F2009A_5319C00B0313_var*
//#UC END# *532AE8F2009A_5319C00B0313_var*
begin
//#UC START# *532AE8F2009A_5319C00B0313_impl*
 Result := false;
//#UC END# *532AE8F2009A_5319C00B0313_impl*
end;//Tk2Tag.GetIsOrd

end.