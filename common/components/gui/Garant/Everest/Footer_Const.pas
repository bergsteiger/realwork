unit Footer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/Footer_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::Footer
//
// ������ ����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Footer - "������ ����������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idFooter = 101;

function k2_typFooter: FooterTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Footer : FooterTag = nil;

// start class FooterTag

function k2_typFooter: FooterTag;
begin
 if (g_Footer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_Footer := TevNativeSchema(Tk2TypeTable.GetInstance).t_Footer;
 end;//g_Footer = nil
 Result := g_Footer;
end;

end.