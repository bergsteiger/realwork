unit NOT_FINISHED_evResultFont;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evResultFont.pas"
// �����: 17.05.2005 12:52
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::Everest::evResultFont::evResultFont
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Tags
  ;

type
 TevFontArray = array [Tk2FontParam] of Integer;

 TevResultFont = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//TevResultFont

 PevResultFontEx = ^TevResultFontEx;

implementation

end.