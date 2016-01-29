unit SegmentWithChildren_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/SegmentWithChildren_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::SegmentWithChildren
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� SegmentWithChildren .
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typSegmentWithChildren: SegmentWithChildrenTag;

//#UC START# *54BE906C029Cconst_intf*
//#UC END# *54BE906C029Cconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SegmentWithChildren : SegmentWithChildrenTag = nil;

// start class SegmentWithChildrenTag

function k2_typSegmentWithChildren: SegmentWithChildrenTag;
begin
 if (g_SegmentWithChildren = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_SegmentWithChildren := TevdNativeSchema(Tk2TypeTable.GetInstance).t_SegmentWithChildren;
 end;//g_SegmentWithChildren = nil
 Result := g_SegmentWithChildren;
end;

end.