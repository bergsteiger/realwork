unit csCourtDecisionSabCheckerParams;

// Модуль: "w:\common\components\rtl\Garant\cs\csCourtDecisionSabCheckerParams.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsCourtDecisionSabCheckerParams" MUID: (53EDB09201BF)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , csCourtsListHelper
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TcsCourtDecisionSabCheckerParams = class(_evdTagHolder_)
  protected
   function pm_GetDocTypeID: Integer;
   procedure pm_SetDocTypeID(aValue: Integer);
   {$If NOT Defined(Region)}
   function pm_GetLastUpdateDate: TDateTime;
   {$IfEnd} // NOT Defined(Region)
   {$If NOT Defined(Region)}
   procedure pm_SetLastUpdateDate(aValue: TDateTime);
   {$IfEnd} // NOT Defined(Region)
   function pm_GetNotifyList: AnsiString;
   procedure pm_SetNotifyList(const aValue: AnsiString);
   function pm_GetCourtsList: CourtsListHelper;
   function pm_GetIsParamsValid: Boolean;
   procedure pm_SetIsParamsValid(aValue: Boolean);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property DocTypeID: Integer
    read pm_GetDocTypeID
    write pm_SetDocTypeID;
   {$If NOT Defined(Region)}
   property LastUpdateDate: TDateTime
    read pm_GetLastUpdateDate
    write pm_SetLastUpdateDate;
   {$IfEnd} // NOT Defined(Region)
   property NotifyList: AnsiString
    read pm_GetNotifyList
    write pm_SetNotifyList;
   property CourtsList: CourtsListHelper
    read pm_GetCourtsList;
   property IsParamsValid: Boolean
    read pm_GetIsParamsValid
    write pm_SetIsParamsValid;
 end;//TcsCourtDecisionSabCheckerParams
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
 , CourtDecisionSabCheckerParams_Const
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TcsCourtDecisionSabCheckerParams.pm_GetDocTypeID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocTypeID]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetDocTypeID

procedure TcsCourtDecisionSabCheckerParams.pm_SetDocTypeID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocTypeID, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetDocTypeID

{$If NOT Defined(Region)}
function TcsCourtDecisionSabCheckerParams.pm_GetLastUpdateDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrLastUpdateDate]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetLastUpdateDate
{$IfEnd} // NOT Defined(Region)

{$If NOT Defined(Region)}
procedure TcsCourtDecisionSabCheckerParams.pm_SetLastUpdateDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrLastUpdateDate, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetLastUpdateDate
{$IfEnd} // NOT Defined(Region)

function TcsCourtDecisionSabCheckerParams.pm_GetNotifyList: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrNotifyList]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetNotifyList

procedure TcsCourtDecisionSabCheckerParams.pm_SetNotifyList(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrNotifyList, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetNotifyList

function TcsCourtDecisionSabCheckerParams.pm_GetCourtsList: CourtsListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TCourtsListHelper.Make(TaggedData.cAtom(k2_attrCourtsList));
end;//TcsCourtDecisionSabCheckerParams.pm_GetCourtsList

function TcsCourtDecisionSabCheckerParams.pm_GetIsParamsValid: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsParamsValid]);
end;//TcsCourtDecisionSabCheckerParams.pm_GetIsParamsValid

procedure TcsCourtDecisionSabCheckerParams.pm_SetIsParamsValid(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsParamsValid, nil] := (aValue);
end;//TcsCourtDecisionSabCheckerParams.pm_SetIsParamsValid

class function TcsCourtDecisionSabCheckerParams.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typCourtDecisionSabCheckerParams;
end;//TcsCourtDecisionSabCheckerParams.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
