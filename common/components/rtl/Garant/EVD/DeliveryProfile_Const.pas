unit DeliveryProfile_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/DeliveryProfile_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi Low Level::EVD::Standard::evdTasks::DeliveryProfile
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега DeliveryProfile .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_attrTargetFolder: Integer;

function k2_attrSourceFolder: Integer;

function k2_typDeliveryProfile: DeliveryProfileTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_DeliveryProfile : DeliveryProfileTag = nil;

// start class DeliveryProfileTag

function k2_typDeliveryProfile: DeliveryProfileTag;
begin
 if (g_DeliveryProfile = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_DeliveryProfile := TevdTasksSchema(Tk2TypeTable.GetInstance).t_DeliveryProfile;
 end;//g_DeliveryProfile = nil
 Result := g_DeliveryProfile;
end;
var
 g_k2_attrTargetFolder: Integer = -1;

function k2_attrTargetFolder: Integer;
begin
 if (g_k2_attrTargetFolder = -1) then
  g_k2_attrTargetFolder :=  Tk2Attributes.Instance.CheckIDByName('TargetFolder');
 Result := g_k2_attrTargetFolder;
end;

var
 g_k2_attrSourceFolder: Integer = -1;

function k2_attrSourceFolder: Integer;
begin
 if (g_k2_attrSourceFolder = -1) then
  g_k2_attrSourceFolder :=  Tk2Attributes.Instance.CheckIDByName('SourceFolder');
 Result := g_k2_attrSourceFolder;
end;


end.