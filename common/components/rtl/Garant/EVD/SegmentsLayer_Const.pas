unit SegmentsLayer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/SegmentsLayer_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::SegmentsLayer
//
// Слой отрезков оформления
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега SegmentsLayer - "Слой отрезков оформления".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idSegmentsLayer = 19;

function k2_typSegmentsLayer_Handle: SegmentsLayer_Handle_Tag;

function k2_attrHandle: Integer;
function k2_typSegmentsLayer: SegmentsLayerTag;

//#UC START# *484FD1360343const_intf*
//#UC END# *484FD1360343const_intf*

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_SegmentsLayer : SegmentsLayerTag = nil;

// start class SegmentsLayerTag

function k2_typSegmentsLayer: SegmentsLayerTag;
begin
 if (g_SegmentsLayer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_SegmentsLayer := TevdNativeSchema(Tk2TypeTable.GetInstance).t_SegmentsLayer;
 end;//g_SegmentsLayer = nil
 Result := g_SegmentsLayer;
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
 g_SegmentsLayer_Handle : SegmentsLayer_Handle_Tag = nil;

// start class Handle

function k2_typSegmentsLayer_Handle: SegmentsLayer_Handle_Tag;
begin
 if (g_SegmentsLayer_Handle = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_SegmentsLayer_Handle := TevdNativeSchema(Tk2TypeTable.GetInstance).t_SegmentsLayer_Handle;
 end;//g_SegmentsLayer = nil
 Result := g_SegmentsLayer_Handle;
end;


end.