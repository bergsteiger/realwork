unit NodeGroup_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/NodeGroup_Const.pas"
// Начат: 09.06.2008 10:39
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::Everest::Standard::evNative::NodeGroup
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега NodeGroup .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

uses
  k2Base {a},
  evNative_Schema
  ;

const
 k2_idNodeGroup = 46;

function k2_typNodeGroup: NodeGroupTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_NodeGroup : NodeGroupTag = nil;

// start class NodeGroupTag

function k2_typNodeGroup: NodeGroupTag;
begin
 if (g_NodeGroup = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevNativeSchema);
  g_NodeGroup := TevNativeSchema(Tk2TypeTable.GetInstance).t_NodeGroup;
 end;//g_NodeGroup = nil
 Result := g_NodeGroup;
end;

end.