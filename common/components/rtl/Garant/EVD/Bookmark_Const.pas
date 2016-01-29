unit Bookmark_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/EVD/Bookmark_Const.pas"
// �����: 07.06.2008 19:47
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::Bookmark
//
// ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� Bookmark - "��������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idBookmark = 115;

function k2_typBookmark: BookmarkTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Bookmark : BookmarkTag = nil;

// start class BookmarkTag

function k2_typBookmark: BookmarkTag;
begin
 if (g_Bookmark = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Bookmark := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Bookmark;
 end;//g_Bookmark = nil
 Result := g_Bookmark;
end;

end.