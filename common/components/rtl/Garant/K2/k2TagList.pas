unit k2TagList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// ������: "w:/common/components/rtl/Garant/K2/k2TagList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TagList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  k2TagListPrim,
  l3Types
  ;

type
 _k2TagByIntegerSearcher_Parent_ = Tk2TagListPrim;
 {$Include ..\K2\k2TagByIntegerSearcher.imp.pas}
 Tk2TagList = class(_k2TagByIntegerSearcher_)
 end;//Tk2TagList

implementation

uses
  l3Base
  ;

type _Instance_R_ = Tk2TagList;

{$Include ..\K2\k2TagByIntegerSearcher.imp.pas}

end.