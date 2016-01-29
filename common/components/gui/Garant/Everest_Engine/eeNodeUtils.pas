unit eeNodeUtils;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeNodeUtils.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For F1::Everest Engine::Nodes::eeNodeUtils
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  l3Interfaces,
  eeInterfaces
  ;

function EeDirection2l3Direction(aDirection: TeeDirection): Tl3Direction;

implementation

// unit methods

function EeDirection2l3Direction(aDirection: TeeDirection): Tl3Direction;
//#UC START# *54C4FED303A5_54C4FE950098_var*
//#UC END# *54C4FED303A5_54C4FE950098_var*
begin
//#UC START# *54C4FED303A5_54C4FE950098_impl*
 Result := Tl3Direction(Byte(aDirection));
//#UC END# *54C4FED303A5_54C4FE950098_impl*
end;//EeDirection2l3Direction

end.