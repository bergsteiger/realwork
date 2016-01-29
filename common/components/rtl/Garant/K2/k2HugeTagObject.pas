unit k2HugeTagObject;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2HugeTagObject.pas"
// �����: 15.12.1999 17:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2HugeTagObject
//
// ���� �� ���������� ��������� �����. � �������������� ����������� �������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3BitArr,
  k2NonAtomicTag,
  k2Base,
  l3Variant,
  k2TagList,
  k2Prim,
  k2BaseStruct,
  l3Interfaces,
  k2BaseTypes,
  l3Types,
  l3IID
  ;

type
 _HashType_ = Tl3PtrHash;
 _k2HashTag_Parent_ = Tk2NonAtomicTag;
 {$Include ..\K2\k2HashTag.imp.pas}
 Tk2HugeTagObject = class(_k2HashTag_)
  {* ���� �� ���������� ��������� �����. � �������������� ����������� ������� }
 end;//Tk2HugeTagObject

implementation

uses
  SysUtils,
  k2Tags,
  l3Dict,
  k2Const,
  l3Const,
  l3String,
  k2Except,
  k2Strings,
  TypInfo,
  l3Stream,
  l3Base,
  k2Facade,
  Classes,
  k2OList_Const,
  k2Dictionary,
  k2NonOptimizeContext,
  k2VariantImpl,
  k2Bool_Const,
  k2String,
  k2List,
  k2NullTagImpl,
  k2Interfaces,
  k2DictionaryPrim,
  k2InterfaceFactory
  ;

type _Instance_R_ = Tk2HugeTagObject;

{$Include ..\K2\k2HashTag.imp.pas}

end.