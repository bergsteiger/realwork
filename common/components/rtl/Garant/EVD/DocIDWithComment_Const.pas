unit DocIDWithComment_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/DocIDWithComment_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::DocIDWithComment
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DocIDWithComment .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrDocID: Integer;

function k2_attrDocComment: Integer;

function k2_typDocIDWithComment: DocIDWithCommentTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DocIDWithComment : DocIDWithCommentTag = nil;

// start class DocIDWithCommentTag

function k2_typDocIDWithComment: DocIDWithCommentTag;
begin
 if (g_DocIDWithComment = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DocIDWithComment := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DocIDWithComment;
 end;//g_DocIDWithComment = nil
 Result := g_DocIDWithComment;
end;
var
 g_k2_attrDocID: Integer = -1;

function k2_attrDocID: Integer;
begin
 if (g_k2_attrDocID = -1) then
  g_k2_attrDocID :=  Tk2Attributes.Instance.CheckIDByName('DocID');
 Result := g_k2_attrDocID;
end;

var
 g_k2_attrDocComment: Integer = -1;

function k2_attrDocComment: Integer;
begin
 if (g_k2_attrDocComment = -1) then
  g_k2_attrDocComment :=  Tk2Attributes.Instance.CheckIDByName('DocComment');
 Result := g_k2_attrDocComment;
end;


end.