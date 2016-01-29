unit DocSubLayer_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/DocSubLayer_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::DocSubLayer
//
// Слой меток документа
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DocSubLayer - "Слой меток документа".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idDocSubLayer = 18;

function k2_typDocSubLayer: DocSubLayerTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DocSubLayer : DocSubLayerTag = nil;

// start class DocSubLayerTag

function k2_typDocSubLayer: DocSubLayerTag;
begin
 if (g_DocSubLayer = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_DocSubLayer := TevdNativeSchema(Tk2TypeTable.GetInstance).t_DocSubLayer;
 end;//g_DocSubLayer = nil
 Result := g_DocSubLayer;
end;

end.