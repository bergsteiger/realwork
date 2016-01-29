unit Para_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/Para_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::Para
//
// Базовый параграф
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Para - "Базовый параграф".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

function k2_typPara_Subs: Para_Subs_Tag;

function k2_attrRubber: Integer;

function k2_attrVisible: Integer;

function k2_attrWidth: Integer;

function k2_attrLeftIndent: Integer;

function k2_attrRightIndent: Integer;

function k2_attrSpaceBefore: Integer;

function k2_attrSpaceAfter: Integer;

function k2_attrBackColor: Integer;

function k2_attrFrame: Integer;

function k2_attrSubs: Integer;
function k2_typPara: ParaTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Para : ParaTag = nil;

// start class ParaTag

function k2_typPara: ParaTag;
begin
 if (g_Para = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Para := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Para;
 end;//g_Para = nil
 Result := g_Para;
end;
var
 g_k2_attrRubber: Integer = -1;

function k2_attrRubber: Integer;
begin
 if (g_k2_attrRubber = -1) then
  g_k2_attrRubber :=  Tk2Attributes.Instance.CheckIDByName('Rubber');
 Result := g_k2_attrRubber;
end;

var
 g_k2_attrVisible: Integer = -1;

function k2_attrVisible: Integer;
begin
 if (g_k2_attrVisible = -1) then
  g_k2_attrVisible :=  Tk2Attributes.Instance.CheckIDByName('Visible');
 Result := g_k2_attrVisible;
end;

var
 g_k2_attrWidth: Integer = -1;

function k2_attrWidth: Integer;
begin
 if (g_k2_attrWidth = -1) then
  g_k2_attrWidth :=  Tk2Attributes.Instance.CheckIDByName('Width');
 Result := g_k2_attrWidth;
end;

var
 g_k2_attrLeftIndent: Integer = -1;

function k2_attrLeftIndent: Integer;
begin
 if (g_k2_attrLeftIndent = -1) then
  g_k2_attrLeftIndent :=  Tk2Attributes.Instance.CheckIDByName('LeftIndent');
 Result := g_k2_attrLeftIndent;
end;

var
 g_k2_attrRightIndent: Integer = -1;

function k2_attrRightIndent: Integer;
begin
 if (g_k2_attrRightIndent = -1) then
  g_k2_attrRightIndent :=  Tk2Attributes.Instance.CheckIDByName('RightIndent');
 Result := g_k2_attrRightIndent;
end;

var
 g_k2_attrSpaceBefore: Integer = -1;

function k2_attrSpaceBefore: Integer;
begin
 if (g_k2_attrSpaceBefore = -1) then
  g_k2_attrSpaceBefore :=  Tk2Attributes.Instance.CheckIDByName('SpaceBefore');
 Result := g_k2_attrSpaceBefore;
end;

var
 g_k2_attrSpaceAfter: Integer = -1;

function k2_attrSpaceAfter: Integer;
begin
 if (g_k2_attrSpaceAfter = -1) then
  g_k2_attrSpaceAfter :=  Tk2Attributes.Instance.CheckIDByName('SpaceAfter');
 Result := g_k2_attrSpaceAfter;
end;

var
 g_k2_attrBackColor: Integer = -1;

function k2_attrBackColor: Integer;
begin
 if (g_k2_attrBackColor = -1) then
  g_k2_attrBackColor :=  Tk2Attributes.Instance.CheckIDByName('BackColor');
 Result := g_k2_attrBackColor;
end;

var
 g_k2_attrFrame: Integer = -1;

function k2_attrFrame: Integer;
begin
 if (g_k2_attrFrame = -1) then
  g_k2_attrFrame :=  Tk2Attributes.Instance.CheckIDByName('Frame');
 Result := g_k2_attrFrame;
end;

var
 g_k2_attrSubs: Integer = -1;

function k2_attrSubs: Integer;
begin
 if (g_k2_attrSubs = -1) then
  g_k2_attrSubs :=  Tk2Attributes.Instance.CheckIDByName('Subs');
 Result := g_k2_attrSubs;
end;


var
 g_Para_Subs : Para_Subs_Tag = nil;

// start class Subs

function k2_typPara_Subs: Para_Subs_Tag;
begin
 if (g_Para_Subs = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Para_Subs := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Para_Subs;
 end;//g_Para = nil
 Result := g_Para_Subs;
end;


end.