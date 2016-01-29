unit l3VCLFormPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3VCLFormPtrList.pas"
// �����: 20.04.2011 15:05
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3VCLFormPtrList
//
// ������ ���������� �� ����� VCL
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  ,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except
  ;

type
 _ItemType_ = TCustomForm;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3ObjectPtrList.imp.pas}
 Tl3VCLFormPtrList = class(_l3ObjectPtrList_)
  {* ������ ���������� �� ����� VCL }
 end;//Tl3VCLFormPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3VCLFormPtrList;

{$Include ..\L3\l3ObjectPtrList.imp.pas}

end.