unit Header_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/Header_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Header
//
// ������� ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Header - "������� ����������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idHeader = 100;

function k2_typHeader: HeaderTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Header : HeaderTag = nil;

// start class HeaderTag

function k2_typHeader: HeaderTag;
begin
 if (g_Header = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Header := TevNativeSchema(Tk2TypeTable.GetInstance).t_Header;
 end;//g_Header = nil
 Result := g_Header;
end;

end.