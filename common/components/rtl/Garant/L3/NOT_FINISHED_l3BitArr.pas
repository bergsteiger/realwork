unit NOT_FINISHED_l3BitArr;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3BitArr.pas"
// �����: 26.03.1998 15:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::L3::l3CoreObjects::l3BitArr
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

type
 Tl3PtrHash = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   f_MaskSize : Byte;
 end;//Tl3PtrHash

 Tl3PtrArray = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//Tl3PtrArray

 Tl3OneBytePtrHash = {$IfDef XE4}record{$Else}object{$EndIf}
 end;//Tl3OneBytePtrHash

implementation

uses
  l3BoxMemoryManagerPrim
  ;

end.