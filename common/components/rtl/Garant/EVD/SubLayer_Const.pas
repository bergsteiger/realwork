unit SubLayer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/SubLayer_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdNative::SubLayer
//
// Слой меток
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега SubLayer - "Слой меток".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idSubLayer = 17;

function k2_typSubLayer_Handle: SubLayer_Handle_Tag;

function k2_attrHandle: Integer;
function k2_typSubLayer: SubLayerTag;

//#UC START# *484FAF4D03CCconst_intf*
//#UC END# *484FAF4D03CCconst_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SubLayer : SubLayerTag = nil;

// start class SubLayerTag

function k2_typSubLayer: SubLayerTag;
begin
 if (g_SubLayer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_SubLayer := TevdNativeSchema(Tk2TypeTable.GetInstance).t_SubLayer;
 end;//g_SubLayer = nil
 Result := g_SubLayer;
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
 g_SubLayer_Handle : SubLayer_Handle_Tag = nil;

// start class Handle

function k2_typSubLayer_Handle: SubLayer_Handle_Tag;
begin
 if (g_SubLayer_Handle = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_SubLayer_Handle := TevdNativeSchema(Tk2TypeTable.GetInstance).t_SubLayer_Handle;
 end;//g_SubLayer = nil
 Result := g_SubLayer_Handle;
end;


end.