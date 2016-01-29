unit ReqCell_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/ReqCell_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::ReqCell
//
// ������ � ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� ReqCell - "������ � ���������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idReqCell = 131;

function k2_typReqCell: ReqCellTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ReqCell : ReqCellTag = nil;

// start class ReqCellTag

function k2_typReqCell: ReqCellTag;
begin
 if (g_ReqCell = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_ReqCell := TevNativeSchema(Tk2TypeTable.GetInstance).t_ReqCell;
 end;//g_ReqCell = nil
 Result := g_ReqCell;
end;

end.