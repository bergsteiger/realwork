unit DictEntryBlock_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/DictEntryBlock_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::DictEntryBlock
//
// ������� ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� DictEntryBlock - "������� ��������� ������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idDictEntryBlock = 48;

function k2_typDictEntryBlock: DictEntryBlockTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DictEntryBlock : DictEntryBlockTag = nil;

// start class DictEntryBlockTag

function k2_typDictEntryBlock: DictEntryBlockTag;
begin
 if (g_DictEntryBlock = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_DictEntryBlock := TevNativeSchema(Tk2TypeTable.GetInstance).t_DictEntryBlock;
 end;//g_DictEntryBlock = nil
 Result := g_DictEntryBlock;
end;

end.