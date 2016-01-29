unit k2InterfaceMapper;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2InterfaceMapper.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2InterfaceMapper
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3IID,
  l3Variant
  ;

type
 Tk2InterfaceMapper = {abstract} class
 public
 // public methods
   class function Make(aTag: Tl3Variant;
     const IID: Tl3GUID;
     out Tool;
     const aProcessor: Ik2Processor): Boolean; virtual; abstract;
 end;//Tk2InterfaceMapper

implementation

end.