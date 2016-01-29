unit BitmapPara_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/BitmapPara_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::BitmapPara
//
// Картинка в тексте
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега BitmapPara - "Картинка в тексте".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idBitmapPara = 97;

function k2_typBitmapPara_Object: BitmapPara_Object_Tag;

function k2_attrExternalHandle: Integer;

function k2_attrInternalHandle: Integer;

function k2_attrExternalPath: Integer;

function k2_attrName: Integer;

function k2_attrShortName: Integer;

function k2_attrDPI: Integer;

function k2_attrHeight: Integer;

function k2_attrData: Integer;

function k2_attrObject: Integer;
function k2_typBitmapPara: BitmapParaTag;

//#UC START# *4858116B0355const_intf*
//#UC END# *4858116B0355const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_BitmapPara : BitmapParaTag = nil;

// start class BitmapParaTag

function k2_typBitmapPara: BitmapParaTag;
begin
 if (g_BitmapPara = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_BitmapPara := TevNativeSchema(Tk2TypeTable.GetInstance).t_BitmapPara;
 end;//g_BitmapPara = nil
 Result := g_BitmapPara;
end;
var
 g_k2_attrExternalHandle: Integer = -1;

function k2_attrExternalHandle: Integer;
begin
 if (g_k2_attrExternalHandle = -1) then
  g_k2_attrExternalHandle :=  Tk2Attributes.Instance.CheckIDByName('ExternalHandle');
 Result := g_k2_attrExternalHandle;
end;

var
 g_k2_attrInternalHandle: Integer = -1;

function k2_attrInternalHandle: Integer;
begin
 if (g_k2_attrInternalHandle = -1) then
  g_k2_attrInternalHandle :=  Tk2Attributes.Instance.CheckIDByName('InternalHandle');
 Result := g_k2_attrInternalHandle;
end;

var
 g_k2_attrExternalPath: Integer = -1;

function k2_attrExternalPath: Integer;
begin
 if (g_k2_attrExternalPath = -1) then
  g_k2_attrExternalPath :=  Tk2Attributes.Instance.CheckIDByName('ExternalPath');
 Result := g_k2_attrExternalPath;
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
 g_k2_attrShortName: Integer = -1;

function k2_attrShortName: Integer;
begin
 if (g_k2_attrShortName = -1) then
  g_k2_attrShortName :=  Tk2Attributes.Instance.CheckIDByName('ShortName');
 Result := g_k2_attrShortName;
end;

var
 g_k2_attrDPI: Integer = -1;

function k2_attrDPI: Integer;
begin
 if (g_k2_attrDPI = -1) then
  g_k2_attrDPI :=  Tk2Attributes.Instance.CheckIDByName('DPI');
 Result := g_k2_attrDPI;
end;

var
 g_k2_attrHeight: Integer = -1;

function k2_attrHeight: Integer;
begin
 if (g_k2_attrHeight = -1) then
  g_k2_attrHeight :=  Tk2Attributes.Instance.CheckIDByName('Height');
 Result := g_k2_attrHeight;
end;

var
 g_k2_attrData: Integer = -1;

function k2_attrData: Integer;
begin
 if (g_k2_attrData = -1) then
  g_k2_attrData :=  Tk2Attributes.Instance.CheckIDByName('Data');
 Result := g_k2_attrData;
end;

var
 g_k2_attrObject: Integer = -1;

function k2_attrObject: Integer;
begin
 if (g_k2_attrObject = -1) then
  g_k2_attrObject :=  Tk2Attributes.Instance.CheckIDByName('Object');
 Result := g_k2_attrObject;
end;


var
 g_BitmapPara_Object : BitmapPara_Object_Tag = nil;

// start class Object

function k2_typBitmapPara_Object: BitmapPara_Object_Tag;
begin
 if (g_BitmapPara_Object = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_BitmapPara_Object := TevNativeSchema(Tk2TypeTable.GetInstance).t_BitmapPara_Object;
 end;//g_BitmapPara = nil
 Result := g_BitmapPara_Object;
end;


end.