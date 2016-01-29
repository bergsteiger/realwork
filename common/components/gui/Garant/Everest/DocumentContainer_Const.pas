unit DocumentContainer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/DocumentContainer_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Atom::Class>> Shared Delphi::Everest::Standard::evNative::DocumentContainer
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DocumentContainer .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

function k2_typDocumentContainer: DocumentContainerAtom;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DocumentContainer : DocumentContainerAtom = nil;

// start class DocumentContainerAtom

function k2_typDocumentContainer: DocumentContainerAtom;
begin
 if (g_DocumentContainer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DocumentContainer := TevNativeSchema(Tk2TypeTable.GetInstance).t_DocumentContainer;
 end;//g_DocumentContainer = nil
 Result := g_DocumentContainer;
end;

end.