unit StyledLeafPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/StyledLeafPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::StyledLeafPara
//
// "Листьевой" параграф с оформлением
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега StyledLeafPara - ""Листьевой" параграф с оформлением".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

function k2_attrStyle: Integer;

function k2_attrJustification: Integer;

function k2_attrHandle: Integer;

function k2_attrLineSpacing: Integer;

function k2_typStyledLeafPara: StyledLeafParaTag;

//#UC START# *48567D1900F6const_intf*
//#UC END# *48567D1900F6const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_StyledLeafPara : StyledLeafParaTag = nil;

// start class StyledLeafParaTag

function k2_typStyledLeafPara: StyledLeafParaTag;
begin
 if (g_StyledLeafPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_StyledLeafPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_StyledLeafPara;
 end;//g_StyledLeafPara = nil
 Result := g_StyledLeafPara;
end;
var
 g_k2_attrStyle: Integer = -1;

function k2_attrStyle: Integer;
begin
 if (g_k2_attrStyle = -1) then
  g_k2_attrStyle :=  Tk2Attributes.Instance.CheckIDByName('Style');
 Result := g_k2_attrStyle;
end;

var
 g_k2_attrJustification: Integer = -1;

function k2_attrJustification: Integer;
begin
 if (g_k2_attrJustification = -1) then
  g_k2_attrJustification :=  Tk2Attributes.Instance.CheckIDByName('Justification');
 Result := g_k2_attrJustification;
end;

var
 g_k2_attrHandle: Integer = -1;

function k2_attrHandle: Integer;
begin
 if (g_k2_attrHandle = -1) then
  g_k2_attrHandle :=  Tk2Attributes.Instance.CheckIDByName('Handle');
 Result := g_k2_attrHandle;
end;

var
 g_k2_attrLineSpacing: Integer = -1;

function k2_attrLineSpacing: Integer;
begin
 if (g_k2_attrLineSpacing = -1) then
  g_k2_attrLineSpacing :=  Tk2Attributes.Instance.CheckIDByName('LineSpacing');
 Result := g_k2_attrLineSpacing;
end;


end.