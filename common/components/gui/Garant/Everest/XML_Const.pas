unit XML_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/XML_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::XML
//
// XML-��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� XML - "XML-��������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idXML = 122;

function k2_typXML: XMLTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_XML : XMLTag = nil;

// start class XMLTag

function k2_typXML: XMLTag;
begin
 if (g_XML = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_XML := TevNativeSchema(Tk2TypeTable.GetInstance).t_XML;
 end;//g_XML = nil
 Result := g_XML;
end;

end.