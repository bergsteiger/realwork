unit nsStringValueMapFactoryRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Common/nsStringValueMapFactoryRes.pas"
// �����: 19.01.2012 17:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::Common::nsStringValueMapFactoryRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { ������������ ������ Local }
 str_cpClassCaptionReview : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpClassCaptionReview'; rValue : '������/���� � ���');
  { '������/���� � ���' }
 str_cpSourceCaptionReview : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'cpSourceCaptionReview'; rValue : '�����/�������� � ���');
  { '�����/�������� � ���' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_cpClassCaptionReview
 str_cpClassCaptionReview.Init;
// ������������� str_cpSourceCaptionReview
 str_cpSourceCaptionReview.Init;

end.