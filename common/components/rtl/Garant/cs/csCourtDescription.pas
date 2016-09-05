unit csCourtDescription;

// Модуль: "w:\common\components\rtl\Garant\cs\csCourtDescription.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsCourtDescription" MUID: (53EDB1000048)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , csDecisionPhrasesHelper
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TcsCourtDescription = class(_evdTagHolder_)
  protected
   function pm_GetName: AnsiString;
   procedure pm_SetName(const aValue: AnsiString);
   function pm_GetSourceID: Integer;
   procedure pm_SetSourceID(aValue: Integer);
   function pm_GetNeedProcess: Boolean;
   procedure pm_SetNeedProcess(aValue: Boolean);
   function pm_GetDecisionPhrases: DecisionPhrasesHelper;
  public
   procedure Clear;
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Name: AnsiString
    read pm_GetName
    write pm_SetName;
   property SourceID: Integer
    read pm_GetSourceID
    write pm_SetSourceID;
   property NeedProcess: Boolean
    read pm_GetNeedProcess
    write pm_SetNeedProcess;
   property DecisionPhrases: DecisionPhrasesHelper
    read pm_GetDecisionPhrases;
 end;//TcsCourtDescription
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
 , CourtDescription_Const
 //#UC START# *53EDB1000048impl_uses*
 //#UC END# *53EDB1000048impl_uses*
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TcsCourtDescription.pm_GetName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrName]);
end;//TcsCourtDescription.pm_GetName

procedure TcsCourtDescription.pm_SetName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrName, nil] := (aValue);
end;//TcsCourtDescription.pm_SetName

function TcsCourtDescription.pm_GetSourceID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrSourceID]);
end;//TcsCourtDescription.pm_GetSourceID

procedure TcsCourtDescription.pm_SetSourceID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrSourceID, nil] := (aValue);
end;//TcsCourtDescription.pm_SetSourceID

function TcsCourtDescription.pm_GetNeedProcess: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrNeedProcess]);
end;//TcsCourtDescription.pm_GetNeedProcess

procedure TcsCourtDescription.pm_SetNeedProcess(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrNeedProcess, nil] := (aValue);
end;//TcsCourtDescription.pm_SetNeedProcess

function TcsCourtDescription.pm_GetDecisionPhrases: DecisionPhrasesHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDecisionPhrasesHelper.Make(TaggedData.cAtom(k2_attrDecisionPhrases));
end;//TcsCourtDescription.pm_GetDecisionPhrases

procedure TcsCourtDescription.Clear;
//#UC START# *53EDD3C40089_53EDB1000048_var*
//#UC END# *53EDD3C40089_53EDB1000048_var*
begin
//#UC START# *53EDD3C40089_53EDB1000048_impl*
 SetTaggedData(GetTaggedDataType.MakeTag.AsObject);
//#UC END# *53EDD3C40089_53EDB1000048_impl*
end;//TcsCourtDescription.Clear

class function TcsCourtDescription.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typCourtDescription;
end;//TcsCourtDescription.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
