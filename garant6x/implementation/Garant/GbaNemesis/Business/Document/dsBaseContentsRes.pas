unit dsBaseContentsRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Business"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Business/Document/dsBaseContentsRes.pas"
// �����: 27.01.2011 16:12
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 Core::Common::Business::BaseDocument::dsBaseContentsRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3StringIDEx
  ;

var
  { ������������ ������ Local }
 str_CommentStub : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'CommentStub'; rValue : '����������� �%d � ��������� %d');
  { '����������� �%d � ��������� %d' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_CommentStub
 str_CommentStub.Init;
{$IfEnd} //not Admin AND not Monitorings

end.