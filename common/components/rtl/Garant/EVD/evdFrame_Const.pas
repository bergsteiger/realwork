unit evdFrame_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/evdFrame_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::Frame
//
// Рамка вокруг объекта
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега Frame - "Рамка вокруг объекта".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idFrame = 41;

function k2_attrName: Integer;

function k2_attrForeColor: Integer;

function k2_attrFrameUp: Integer;

function k2_attrFrameDown: Integer;

function k2_attrFrameLeft: Integer;

function k2_attrFrameRight: Integer;

function k2_typFrame: FrameTag;

const
 evd_fvEmpty = 0;
  { Пустая рамка } 
 evd_fvSolid = 1111;
  { Цельная рамка } 
 evd_fvDown = 0001;
  { Нижняя рамка } 

//#UC START# *484D2BAB02BBconst_intf*
//#UC END# *484D2BAB02BBconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_Frame : FrameTag = nil;

// start class FrameTag

function k2_typFrame: FrameTag;
begin
 if (g_Frame = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_Frame := TevdNativeSchema(Tk2TypeTable.GetInstance).t_Frame;
 end;//g_Frame = nil
 Result := g_Frame;
end;
var
 g_k2_attrName: Integer = -1;

function k2_attrName: Integer;
begin
 if (g_k2_attrName = -1) then
  g_k2_attrName :=  Tk2Attributes.Instance.CheckIDByName('Name');
 Result := g_k2_attrName;
end;

var
 g_k2_attrForeColor: Integer = -1;

function k2_attrForeColor: Integer;
begin
 if (g_k2_attrForeColor = -1) then
  g_k2_attrForeColor :=  Tk2Attributes.Instance.CheckIDByName('ForeColor');
 Result := g_k2_attrForeColor;
end;

var
 g_k2_attrFrameUp: Integer = -1;

function k2_attrFrameUp: Integer;
begin
 if (g_k2_attrFrameUp = -1) then
  g_k2_attrFrameUp :=  Tk2Attributes.Instance.CheckIDByName('FrameUp');
 Result := g_k2_attrFrameUp;
end;

var
 g_k2_attrFrameDown: Integer = -1;

function k2_attrFrameDown: Integer;
begin
 if (g_k2_attrFrameDown = -1) then
  g_k2_attrFrameDown :=  Tk2Attributes.Instance.CheckIDByName('FrameDown');
 Result := g_k2_attrFrameDown;
end;

var
 g_k2_attrFrameLeft: Integer = -1;

function k2_attrFrameLeft: Integer;
begin
 if (g_k2_attrFrameLeft = -1) then
  g_k2_attrFrameLeft :=  Tk2Attributes.Instance.CheckIDByName('FrameLeft');
 Result := g_k2_attrFrameLeft;
end;

var
 g_k2_attrFrameRight: Integer = -1;

function k2_attrFrameRight: Integer;
begin
 if (g_k2_attrFrameRight = -1) then
  g_k2_attrFrameRight :=  Tk2Attributes.Instance.CheckIDByName('FrameRight');
 Result := g_k2_attrFrameRight;
end;


end.