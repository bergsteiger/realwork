unit Bookmark_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Bookmark_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::Bookmark
//
// Закладка
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Bookmark - "Закладка".
// ! Полностью генерируется с модели. Править руками - нельзя. !

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