unit CommentPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Everest/CommentPara_Const.pas"
// �����: 09.06.2008 10:39
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::CommentPara
//
// ���� ����������������� �����������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ��������� ��� �������� ���� CommentPara - "���� ����������������� �����������".
// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idCommentPara = 120;

function k2_typCommentPara: CommentParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_CommentPara : CommentParaTag = nil;

// start class CommentParaTag

function k2_typCommentPara: CommentParaTag;
begin
 if (g_CommentPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_CommentPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_CommentPara;
 end;//g_CommentPara = nil
 Result := g_CommentPara;
end;

end.