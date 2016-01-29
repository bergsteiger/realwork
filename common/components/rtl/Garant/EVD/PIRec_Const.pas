unit PIRec_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/EVD/PIRec_Const.pas"
// Начат: 07.06.2008 19:47
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdNative::PIRec
//
// Источник опубликования
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега PIRec - "Источник опубликования".
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdNative_Schema
  ;

const
 k2_idPIRec = 88;

function k2_attrHandle: Integer;

function k2_attrSource: Integer;

function k2_attrStart: Integer;

function k2_attrFinish: Integer;

function k2_attrNumber: Integer;

function k2_attrComment: Integer;

function k2_attrPages: Integer;

function k2_attrLinkComment: Integer;

function k2_attrIsPeriodic: Integer;

function k2_attrFlags: Integer;

function k2_typPIRec: PIRecTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_PIRec : PIRecTag = nil;

// start class PIRecTag

function k2_typPIRec: PIRecTag;
begin
 if (g_PIRec = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdNativeSchema);
  g_PIRec := TevdNativeSchema(Tk2TypeTable.GetInstance).t_PIRec;
 end;//g_PIRec = nil
 Result := g_PIRec;
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
 g_k2_attrSource: Integer = -1;

function k2_attrSource: Integer;
begin
 if (g_k2_attrSource = -1) then
  g_k2_attrSource :=  Tk2Attributes.Instance.CheckIDByName('Source');
 Result := g_k2_attrSource;
end;

var
 g_k2_attrStart: Integer = -1;

function k2_attrStart: Integer;
begin
 if (g_k2_attrStart = -1) then
  g_k2_attrStart :=  Tk2Attributes.Instance.CheckIDByName('Start');
 Result := g_k2_attrStart;
end;

var
 g_k2_attrFinish: Integer = -1;

function k2_attrFinish: Integer;
begin
 if (g_k2_attrFinish = -1) then
  g_k2_attrFinish :=  Tk2Attributes.Instance.CheckIDByName('Finish');
 Result := g_k2_attrFinish;
end;

var
 g_k2_attrNumber: Integer = -1;

function k2_attrNumber: Integer;
begin
 if (g_k2_attrNumber = -1) then
  g_k2_attrNumber :=  Tk2Attributes.Instance.CheckIDByName('Number');
 Result := g_k2_attrNumber;
end;

var
 g_k2_attrComment: Integer = -1;

function k2_attrComment: Integer;
begin
 if (g_k2_attrComment = -1) then
  g_k2_attrComment :=  Tk2Attributes.Instance.CheckIDByName('Comment');
 Result := g_k2_attrComment;
end;

var
 g_k2_attrPages: Integer = -1;

function k2_attrPages: Integer;
begin
 if (g_k2_attrPages = -1) then
  g_k2_attrPages :=  Tk2Attributes.Instance.CheckIDByName('Pages');
 Result := g_k2_attrPages;
end;

var
 g_k2_attrLinkComment: Integer = -1;

function k2_attrLinkComment: Integer;
begin
 if (g_k2_attrLinkComment = -1) then
  g_k2_attrLinkComment :=  Tk2Attributes.Instance.CheckIDByName('LinkComment');
 Result := g_k2_attrLinkComment;
end;

var
 g_k2_attrIsPeriodic: Integer = -1;

function k2_attrIsPeriodic: Integer;
begin
 if (g_k2_attrIsPeriodic = -1) then
  g_k2_attrIsPeriodic :=  Tk2Attributes.Instance.CheckIDByName('IsPeriodic');
 Result := g_k2_attrIsPeriodic;
end;

var
 g_k2_attrFlags: Integer = -1;

function k2_attrFlags: Integer;
begin
 if (g_k2_attrFlags = -1) then
  g_k2_attrFlags :=  Tk2Attributes.Instance.CheckIDByName('Flags');
 Result := g_k2_attrFlags;
end;


end.