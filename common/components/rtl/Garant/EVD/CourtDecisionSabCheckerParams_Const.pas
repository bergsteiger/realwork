unit CourtDecisionSabCheckerParams_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/CourtDecisionSabCheckerParams_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::CourtDecisionSabCheckerParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега CourtDecisionSabCheckerParams .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typCourtDecisionSabCheckerParams_CourtsList: CourtDecisionSabCheckerParams_CourtsList_Tag;

function k2_attrDocTypeID: Integer;

{$If not defined(Region)}
function k2_attrLastUpdateDate: Integer;
{$IfEnd} //not Region

function k2_attrNotifyList: Integer;

function k2_attrCourtsList: Integer;

function k2_attrIsParamsValid: Integer;
function k2_typCourtDecisionSabCheckerParams: CourtDecisionSabCheckerParamsTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_CourtDecisionSabCheckerParams : CourtDecisionSabCheckerParamsTag = nil;

// start class CourtDecisionSabCheckerParamsTag

function k2_typCourtDecisionSabCheckerParams: CourtDecisionSabCheckerParamsTag;
begin
 if (g_CourtDecisionSabCheckerParams = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CourtDecisionSabCheckerParams := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CourtDecisionSabCheckerParams;
 end;//g_CourtDecisionSabCheckerParams = nil
 Result := g_CourtDecisionSabCheckerParams;
end;
var
 g_k2_attrDocTypeID: Integer = -1;

function k2_attrDocTypeID: Integer;
begin
 if (g_k2_attrDocTypeID = -1) then
  g_k2_attrDocTypeID :=  Tk2Attributes.Instance.CheckIDByName('DocTypeID');
 Result := g_k2_attrDocTypeID;
end;

{$If not defined(Region)}
var
 g_k2_attrLastUpdateDate: Integer = -1;

function k2_attrLastUpdateDate: Integer;
begin
 if (g_k2_attrLastUpdateDate = -1) then
  g_k2_attrLastUpdateDate :=  Tk2Attributes.Instance.CheckIDByName('LastUpdateDate');
 Result := g_k2_attrLastUpdateDate;
end;
{$IfEnd} //not Region

var
 g_k2_attrNotifyList: Integer = -1;

function k2_attrNotifyList: Integer;
begin
 if (g_k2_attrNotifyList = -1) then
  g_k2_attrNotifyList :=  Tk2Attributes.Instance.CheckIDByName('NotifyList');
 Result := g_k2_attrNotifyList;
end;

var
 g_k2_attrCourtsList: Integer = -1;

function k2_attrCourtsList: Integer;
begin
 if (g_k2_attrCourtsList = -1) then
  g_k2_attrCourtsList :=  Tk2Attributes.Instance.CheckIDByName('CourtsList');
 Result := g_k2_attrCourtsList;
end;

var
 g_k2_attrIsParamsValid: Integer = -1;

function k2_attrIsParamsValid: Integer;
begin
 if (g_k2_attrIsParamsValid = -1) then
  g_k2_attrIsParamsValid :=  Tk2Attributes.Instance.CheckIDByName('IsParamsValid');
 Result := g_k2_attrIsParamsValid;
end;


var
 g_CourtDecisionSabCheckerParams_CourtsList : CourtDecisionSabCheckerParams_CourtsList_Tag = nil;

// start class CourtsList

function k2_typCourtDecisionSabCheckerParams_CourtsList: CourtDecisionSabCheckerParams_CourtsList_Tag;
begin
 if (g_CourtDecisionSabCheckerParams_CourtsList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_CourtDecisionSabCheckerParams_CourtsList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_CourtDecisionSabCheckerParams_CourtsList;
 end;//g_CourtDecisionSabCheckerParams = nil
 Result := g_CourtDecisionSabCheckerParams_CourtsList;
end;


end.