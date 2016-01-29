unit TextSegment_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/TextSegment_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::TextSegment
//
// Отрезок оформления текста
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега TextSegment - "Отрезок оформления текста".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idTextSegment = 13;

function k2_attrFont: Integer;

function k2_attrVisible: Integer;

function k2_typTextSegment: TextSegmentTag;

//#UC START# *484FDC4F013Fconst_intf*
//#UC END# *484FDC4F013Fconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_TextSegment : TextSegmentTag = nil;

// start class TextSegmentTag

function k2_typTextSegment: TextSegmentTag;
begin
 if (g_TextSegment = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_TextSegment := TevdNativeSchema(Tk2TypeTable.GetInstance).t_TextSegment;
 end;//g_TextSegment = nil
 Result := g_TextSegment;
end;
var
 g_k2_attrFont: Integer = -1;

function k2_attrFont: Integer;
begin
 if (g_k2_attrFont = -1) then
  g_k2_attrFont :=  Tk2Attributes.Instance.CheckIDByName('Font');
 Result := g_k2_attrFont;
end;

var
 g_k2_attrVisible: Integer = -1;

function k2_attrVisible: Integer;
begin
 if (g_k2_attrVisible = -1) then
  g_k2_attrVisible :=  Tk2Attributes.Instance.CheckIDByName('Visible');
 Result := g_k2_attrVisible;
end;


end.