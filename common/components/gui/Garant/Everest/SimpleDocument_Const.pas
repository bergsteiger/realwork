unit SimpleDocument_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/SimpleDocument_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::SimpleDocument
//
// ������� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SimpleDocument - "������� ��������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idSimpleDocument = 105;

function k2_typSimpleDocument: SimpleDocumentTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SimpleDocument : SimpleDocumentTag = nil;

// start class SimpleDocumentTag

function k2_typSimpleDocument: SimpleDocumentTag;
begin
 if (g_SimpleDocument = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_SimpleDocument := TevNativeSchema(Tk2TypeTable.GetInstance).t_SimpleDocument;
 end;//g_SimpleDocument = nil
 Result := g_SimpleDocument;
end;

end.