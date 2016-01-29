unit k2TypedSmallListTag;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "K2"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/K2/k2TypedSmallListTag.pas"
// �����: 16.07.2009 16:36
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2CoreObjects::Tk2TypedSmallListTag
//
// ������ ����� � ������� ����������� �����, ������� ������ �� �������� � ������� ����� �� �����
// 32 (������������) ���������
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
  k2TypedSimpleTagListPrim,
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

 {$Define k2Tag_No_f_TagType}

 {$Define k2TagIsList}

 {$Define k2TagNoSort}

type
 _HashType_ = Tl3OneBytePtrHash;
 _k2HashTag_Parent_ = Tk2TypedSimpleTagListPrim;
 {$Include ..\K2\k2HashTag.imp.pas}
 _k2TagByIntegerSearcher_Parent_ = _k2HashTag_;
 {$Include ..\K2\k2TagByIntegerSearcher.imp.pas}
 Tk2TypedSmallListTag = class(_k2TagByIntegerSearcher_)
  {* ������ ����� � ������� ����������� �����, ������� ������ �� �������� � ������� ����� �� ����� 32 (������������) ��������� }
 end;//Tk2TypedSmallListTag

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

type _Instance_R_ = Tk2TypedSmallListTag;

{$Include ..\K2\k2HashTag.imp.pas}


{$Include ..\K2\k2TagByIntegerSearcher.imp.pas}

end.