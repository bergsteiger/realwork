unit l3Dict;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3Dict.pas"
// �����: 11.10.1999 12:50
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3Dict
//
// �������� �������-"�������"
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3DictionaryPrim,
  l3IDIndex,
  l3Interfaces,
  l3Types
  ;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Undef l3Items_NoSort}

type
 _l3Dictionary_Parent_ = Tl3DictionaryPrim;
 {$Include ..\L3\l3Dictionary.imp.pas}
 Tl3Dictionary = class(_l3Dictionary_)
  {* �������. ������������ ��� �������������� ������ � ������������� � ��������. ����� ��� ������� ���������� }
 end;//Tl3Dictionary

implementation

uses
  l3Base,
  SysUtils,
  l3String
  ;

type _Instance_R_ = Tl3Dictionary;

{$Include ..\L3\l3Dictionary.imp.pas}

end.