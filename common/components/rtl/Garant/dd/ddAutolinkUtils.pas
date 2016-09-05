unit ddAutolinkUtils;

{ $Id: ddAutolinkUtils.pas,v 1.4 2016/07/19 08:37:46 fireton Exp $ }

interface
uses
 l3Interfaces,
 DT_Types,
 ddAutolinkInterfaces;

function NormalizeCasecode(const aNum: Il3CString): Il3CString;

function ddFillALDocRecFromExtDocID(const aExtDocID: TDocID): TddALDocRec;
{$IFNDEF NotArchi}
function ddFillALDocRecFromIntDocID(const aIntDocID: TDocID): TddALDocRec;
{$ENDIF}

implementation
uses
 SysUtils,
 
 l3Base,
 l3RegEx,
 l3Date,
 l3String,

 daSchemeConsts

 {$IFNDEF NotArchi}
 ,DT_LinkServ
 {$ENDIF}

 ;

var
 gNormCaseCodeRE: Tl3RegularSearch;
                               
const
 cCaseCodeSearchPattern = '^{À\d+\-[0-9À-ß\-]+\/}{(\d\d\d\d)|(\d\d)}';

function NormalizeCasecode(const aNum: Il3CString): Il3CString;
var
 l_MP: Tl3MatchPosition;
begin
 if l3IsNil(aNum) then
  Result := nil
 else
 begin
  if gNormCaseCodeRE = nil then
  begin
   gNormCaseCodeRE := Tl3RegularSearch.Create;
   gNormCaseCodeRE.IgnoreCase := True;
   gNormCaseCodeRE.SearchPattern := cCaseCodeSearchPattern;
  end;
  if gNormCaseCodeRE.SearchInString(aNum.AsWStr, l_MP) then
  begin
   Result := l3Cat([l3CStr(gNormCaseCodeRE.TagParts[0]),
     l3Fmt('%d', [ExpandYear(l3StrToInt(gNormCaseCodeRE.TagParts[1].AsWStr))])])
  end
  else
   Result := aNum;
  Result := l3Upper(Result);
 end;
end;

function ddFillALDocRecFromExtDocID(const aExtDocID: TDocID): TddALDocRec;
begin
 Result.rExtDocID := aExtDocID;
 Result.rIntDocID := aExtDocID;
 {$IFNDEF NotArchi}
 LinkServer(CurrentFamily).Renum.GetRNumber(Result.rIntDocID);
 {$ENDIF}
end;

{$IFNDEF NotArchi}
function ddFillALDocRecFromIntDocID(const aIntDocID: TDocID): TddALDocRec;
begin
 Result.rIntDocID := aIntDocID;
 Result.rExtDocID := LinkServer(CurrentFamily).Renum.GetExtDocID(aIntDocID);
end;
{$ENDIF}

initialization
 gNormCasecodeRE := nil;
finalization
 FreeAndNil(gNormCasecodeRE);
end.
