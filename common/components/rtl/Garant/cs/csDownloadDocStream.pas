unit csDownloadDocStream;

// Модуль: "w:\common\components\rtl\Garant\cs\csDownloadDocStream.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsDownloadDocStream" MUID: (57BECED40109)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csPersonificatedMessage
 , evdTasksHelpers
 , l3MarshalledTypes
 , k2Base
;

type
 TcsDownloadDocStream = class(TcsPersonificatedMessage)
  protected
   function pm_GetDocID: Integer;
   procedure pm_SetDocID(aValue: Integer);
   function pm_GetLevel: Integer;
   procedure pm_SetLevel(aValue: Integer);
   function pm_GetWithAttr: Boolean;
   procedure pm_SetWithAttr(aValue: Boolean);
   function pm_GetFoundSelector: FoundSelectorHelper;
   function pm_GetDocPart: Tm3DocPartSelector;
   procedure pm_SetDocPart(aValue: Tm3DocPartSelector);
   function pm_GetDocPartSel: TDocPartSelector;
   procedure pm_SetDocPartSel(aValue: TDocPartSelector);
   function pm_GetDocFamily: Integer;
   procedure pm_SetDocFamily(aValue: Integer);
   function pm_GetIsObjTopic: Boolean;
   procedure pm_SetIsObjTopic(aValue: Boolean);
   function pm_GetDocumentType: AnsiString;
   procedure pm_SetDocumentType(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property DocID: Integer
    read pm_GetDocID
    write pm_SetDocID;
   property Level: Integer
    read pm_GetLevel
    write pm_SetLevel;
   property WithAttr: Boolean
    read pm_GetWithAttr
    write pm_SetWithAttr;
   property FoundSelector: FoundSelectorHelper
    read pm_GetFoundSelector;
   property DocPart: Tm3DocPartSelector
    read pm_GetDocPart
    write pm_SetDocPart;
   property DocPartSel: TDocPartSelector
    read pm_GetDocPartSel
    write pm_SetDocPartSel;
   property DocFamily: Integer
    read pm_GetDocFamily
    write pm_SetDocFamily;
   property IsObjTopic: Boolean
    read pm_GetIsObjTopic
    write pm_SetIsObjTopic;
   property DocumentType: AnsiString
    read pm_GetDocumentType
    write pm_SetDocumentType;
 end;//TcsDownloadDocStream
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csDownloadDocStream_Const
 //#UC START# *57BECED40109impl_uses*
 //#UC END# *57BECED40109impl_uses*
;

function TcsDownloadDocStream.pm_GetDocID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocID]);
end;//TcsDownloadDocStream.pm_GetDocID

procedure TcsDownloadDocStream.pm_SetDocID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocID, nil] := (aValue);
end;//TcsDownloadDocStream.pm_SetDocID

function TcsDownloadDocStream.pm_GetLevel: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrLevel]);
end;//TcsDownloadDocStream.pm_GetLevel

procedure TcsDownloadDocStream.pm_SetLevel(aValue: Integer);
begin
 TaggedData.IntW[k2_attrLevel, nil] := (aValue);
end;//TcsDownloadDocStream.pm_SetLevel

function TcsDownloadDocStream.pm_GetWithAttr: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrWithAttr]);
end;//TcsDownloadDocStream.pm_GetWithAttr

procedure TcsDownloadDocStream.pm_SetWithAttr(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrWithAttr, nil] := (aValue);
end;//TcsDownloadDocStream.pm_SetWithAttr

function TcsDownloadDocStream.pm_GetFoundSelector: FoundSelectorHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TFoundSelectorHelper.Make(TaggedData.cAtom(k2_attrFoundSelector));
end;//TcsDownloadDocStream.pm_GetFoundSelector

function TcsDownloadDocStream.pm_GetDocPart: Tm3DocPartSelector;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tm3DocPartSelector(TaggedData.IntA[k2_attrDocPart]);
end;//TcsDownloadDocStream.pm_GetDocPart

procedure TcsDownloadDocStream.pm_SetDocPart(aValue: Tm3DocPartSelector);
begin
 TaggedData.IntW[k2_attrDocPart, nil] := Ord(aValue);
end;//TcsDownloadDocStream.pm_SetDocPart

function TcsDownloadDocStream.pm_GetDocPartSel: TDocPartSelector;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocPartSelector(TaggedData.IntA[k2_attrDocPartSel]);
end;//TcsDownloadDocStream.pm_GetDocPartSel

procedure TcsDownloadDocStream.pm_SetDocPartSel(aValue: TDocPartSelector);
begin
 TaggedData.IntW[k2_attrDocPartSel, nil] := Ord(aValue);
end;//TcsDownloadDocStream.pm_SetDocPartSel

function TcsDownloadDocStream.pm_GetDocFamily: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocFamily]);
end;//TcsDownloadDocStream.pm_GetDocFamily

procedure TcsDownloadDocStream.pm_SetDocFamily(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocFamily, nil] := (aValue);
end;//TcsDownloadDocStream.pm_SetDocFamily

function TcsDownloadDocStream.pm_GetIsObjTopic: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrIsObjTopic]);
end;//TcsDownloadDocStream.pm_GetIsObjTopic

procedure TcsDownloadDocStream.pm_SetIsObjTopic(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrIsObjTopic, nil] := (aValue);
end;//TcsDownloadDocStream.pm_SetIsObjTopic

function TcsDownloadDocStream.pm_GetDocumentType: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocumentType]);
end;//TcsDownloadDocStream.pm_GetDocumentType

procedure TcsDownloadDocStream.pm_SetDocumentType(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocumentType, nil] := (aValue);
end;//TcsDownloadDocStream.pm_SetDocumentType

class function TcsDownloadDocStream.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsDownloadDocStream;
end;//TcsDownloadDocStream.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
