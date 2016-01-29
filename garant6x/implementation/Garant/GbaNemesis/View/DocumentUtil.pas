unit DocumentUtil;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUtil.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������ � ���������� � ������� ����������::Document::View::DocumentUtils::DocumentUtil
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
 str_IsDocumentUsefulCaption : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'IsDocumentUsefulCaption'; rValue : '������� �� ��������?');
  { '������� �� ��������?' }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3MessageID
  ;

{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings)}
// ������������� str_IsDocumentUsefulCaption
 str_IsDocumentUsefulCaption.Init;
{$IfEnd} //not Admin AND not Monitorings

end.