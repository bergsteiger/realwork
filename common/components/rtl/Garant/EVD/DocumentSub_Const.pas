unit DocumentSub_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/DocumentSub_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::DocumentSub
//
// ����� � ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DocumentSub - "����� � ���������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idDocumentSub = 11;

function k2_attrObject: Integer;

function k2_typDocumentSub: DocumentSubTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DocumentSub : DocumentSubTag = nil;

// start class DocumentSubTag

function k2_typDocumentSub: DocumentSubTag;
begin
 if (g_DocumentSub = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_DocumentSub := TevdNativeSchema(Tk2TypeTable.GetInstance).t_DocumentSub;
 end;//g_DocumentSub = nil
 Result := g_DocumentSub;
end;
var
 g_k2_attrObject: Integer = -1;

function k2_attrObject: Integer;
begin
 if (g_k2_attrObject = -1) then
  g_k2_attrObject :=  Tk2Attributes.Instance.CheckIDByName('Object');
 Result := g_k2_attrObject;
end;


end.