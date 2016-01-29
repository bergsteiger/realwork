unit PageBreak_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/PageBreak_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::PageBreak
//
// Разрыв страницы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега PageBreak - "Разрыв страницы".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idPageBreak = 103;

function k2_attrHeight: Integer;

function k2_typPageBreak: PageBreakTag;

//#UC START# *48566A8103C1const_intf*
//#UC END# *48566A8103C1const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_PageBreak : PageBreakTag = nil;

// start class PageBreakTag

function k2_typPageBreak: PageBreakTag;
begin
 if (g_PageBreak = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_PageBreak := TevdNativeSchema(Tk2TypeTable.GetInstance).t_PageBreak;
 end;//g_PageBreak = nil
 Result := g_PageBreak;
end;
var
 g_k2_attrHeight: Integer = -1;

function k2_attrHeight: Integer;
begin
 if (g_k2_attrHeight = -1) then
  g_k2_attrHeight :=  Tk2Attributes.Instance.CheckIDByName('Height');
 Result := g_k2_attrHeight;
end;


end.