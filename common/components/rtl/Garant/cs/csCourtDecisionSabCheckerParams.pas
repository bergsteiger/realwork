unit csCourtDecisionSabCheckerParams;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csCourtDecisionSabCheckerParams.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::CourtDecisionSabCheckerParams::TcsCourtDecisionSabCheckerParams
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  l3Variant,
  csCourtsListHelper,
  Classes,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TcsCourtDecisionSabCheckerParams = class(_evdTagHolder_)
 protected
 // property methods
   function pm_GetDocTypeID: Integer;
   procedure pm_SetDocTypeID(aValue: Integer);
   {$If not defined(Nemesis) AND not defined(Region)}
   function pm_GetLastUpdateDate: TDateTime;
   procedure pm_SetLastUpdateDate(aValue: TDateTime);
   {$IfEnd} //not Nemesis AND not Region
   function pm_GetNotifyList: AnsiString;
   procedure pm_SetNotifyList(const aValue: AnsiString);
   function pm_GetCourtsList: CourtsListHelper;
   function pm_GetIsParamsValid: Boolean;
   procedure pm_SetIsParamsValid(aValue: Boolean);
 public
 // realized methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property DocTypeID: Integer
     read pm_GetDocTypeID
     write pm_SetDocTypeID;
   {$If not defined(Nemesis) AND not defined(Region)}
   property LastUpdateDate: TDateTime
     read pm_GetLastUpdateDate
     write pm_SetLastUpdateDate;
   {$IfEnd} //not Nemesis AND not Region
   property NotifyList: AnsiString
     read pm_GetNotifyList
     write pm_SetNotifyList;
   property CourtsList: CourtsListHelper
     read pm_GetCourtsList;
   property IsParamsValid: Boolean
     read pm_GetIsParamsValid
     write pm_SetIsParamsValid;
 end;//TcsCourtDecisionSabCheckerParams
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CourtDecisionSabCheckerParams_Const,
  evdNativeWriter,
  l3Filer,
  l3Types,
  k2TagGen,
  evdNativeReader,
  k2DocumentBuffer,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

// start class TcsCourtDecisionSabCheckerParams

function TcsCourtDecisionSabCheckerParams.pm_GetDocTypeID: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocTypeID]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetDocTypeID

procedure TcsCourtDecisionSabCheckerParams.pm_SetDocTypeID(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrDocTypeID, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetDocTypeID

{$If not defined(Nemesis) AND not defined(Region)}
function TcsCourtDecisionSabCheckerParams.pm_GetLastUpdateDate: TDateTime;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrLastUpdateDate]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetLastUpdateDate
{$IfEnd} //not Nemesis AND not Region

{$If not defined(Nemesis) AND not defined(Region)}
procedure TcsCourtDecisionSabCheckerParams.pm_SetLastUpdateDate(aValue: TDateTime);
 {-}
begin
 TaggedData.DateTimeW[k2_attrLastUpdateDate, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetLastUpdateDate
{$IfEnd} //not Nemesis AND not Region

function TcsCourtDecisionSabCheckerParams.pm_GetNotifyList: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrNotifyList]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetNotifyList

procedure TcsCourtDecisionSabCheckerParams.pm_SetNotifyList(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrNotifyList, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetNotifyList

function TcsCourtDecisionSabCheckerParams.pm_GetCourtsList: CourtsListHelper;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TCourtsListHelper.Make(TaggedData.cAtom(k2_attrCourtsList));
end;//TcsCourtDecisionSabCheckerParams.pm_GetCourtsList

function TcsCourtDecisionSabCheckerParams.pm_GetIsParamsValid: Boolean;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsParamsValid]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetIsParamsValid

procedure TcsCourtDecisionSabCheckerParams.pm_SetIsParamsValid(aValue: Boolean);
 {-}
begin
 TaggedData.BoolW[k2_attrIsParamsValid, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetIsParamsValid

class function TcsCourtDecisionSabCheckerParams.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typCourtDecisionSabCheckerParams;
end;//TcsCourtDecisionSabCheckerParams.GetTaggedDataType

{$IfEnd} //not Nemesis

end.