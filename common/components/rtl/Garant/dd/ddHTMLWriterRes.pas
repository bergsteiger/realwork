unit ddHTMLWriterRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/dd/ddHTMLWriterRes.pas"
// �����: 15.03.2010 18:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::dd::Writers::ddHTMLWriterRes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { ������������ ������ Local }
 str_ddmmMultiLinkTitle : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ddmmMultiLinkTitle'; rValue : '%s - ������ ������������� ������');
  { '%s - ������ ������������� ������' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_ddmmMultiLinkTitle
 str_ddmmMultiLinkTitle.Init;

end.