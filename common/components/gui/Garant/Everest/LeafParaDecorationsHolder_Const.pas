unit LeafParaDecorationsHolder_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/LeafParaDecorationsHolder_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::LeafParaDecorationsHolder
//
// ��������� ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� LeafParaDecorationsHolder - "��������� ���������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idLeafParaDecorationsHolder = 134;

function k2_typLeafParaDecorationsHolder: LeafParaDecorationsHolderTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_LeafParaDecorationsHolder : LeafParaDecorationsHolderTag = nil;

// start class LeafParaDecorationsHolderTag

function k2_typLeafParaDecorationsHolder: LeafParaDecorationsHolderTag;
begin
 if (g_LeafParaDecorationsHolder = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_LeafParaDecorationsHolder := TevNativeSchema(Tk2TypeTable.GetInstance).t_LeafParaDecorationsHolder;
 end;//g_LeafParaDecorationsHolder = nil
 Result := g_LeafParaDecorationsHolder;
end;

end.