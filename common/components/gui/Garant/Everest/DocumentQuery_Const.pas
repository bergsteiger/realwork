unit DocumentQuery_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/DocumentQuery_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::DocumentQuery
//
// ������ ��� ������ ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DocumentQuery - "������ ��� ������ ���������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDocumentQuery = 138;

function k2_typDocumentQuery: DocumentQueryTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DocumentQuery : DocumentQueryTag = nil;

// start class DocumentQueryTag

function k2_typDocumentQuery: DocumentQueryTag;
begin
 if (g_DocumentQuery = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DocumentQuery := TevNativeSchema(Tk2TypeTable.GetInstance).t_DocumentQuery;
 end;//g_DocumentQuery = nil
 Result := g_DocumentQuery;
end;

end.