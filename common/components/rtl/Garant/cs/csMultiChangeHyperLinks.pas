unit csMultiChangeHyperLinks;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiChangeHyperLinks.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiChangeHyperLinks" MUID: (5800BD960017)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csPersonificatedMessage
 , evdTasksHelpers
 , k2Base
;

type
 TcsMultiChangeHyperLinks = class(TcsPersonificatedMessage)
  protected
   function pm_GetDocumentIDList: DocumentIDListHelper;
   function pm_GetOldDocID: Integer;
   procedure pm_SetOldDocID(aValue: Integer);
   function pm_GetNewDocID: Integer;
   procedure pm_SetNewDocID(aValue: Integer);
   function pm_GetFamilyID: Integer;
   procedure pm_SetFamilyID(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property DocumentIDList: DocumentIDListHelper
    read pm_GetDocumentIDList;
   property OldDocID: Integer
    read pm_GetOldDocID
    write pm_SetOldDocID;
   property NewDocID: Integer
    read pm_GetNewDocID
    write pm_SetNewDocID;
   property FamilyID: Integer
    read pm_GetFamilyID
    write pm_SetFamilyID;
 end;//TcsMultiChangeHyperLinks
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiChangeHyperLinks_Const
 //#UC START# *5800BD960017impl_uses*
 //#UC END# *5800BD960017impl_uses*
;

function TcsMultiChangeHyperLinks.pm_GetDocumentIDList: DocumentIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TcsMultiChangeHyperLinks.pm_GetDocumentIDList

function TcsMultiChangeHyperLinks.pm_GetOldDocID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrOldDocID]);
end;//TcsMultiChangeHyperLinks.pm_GetOldDocID

procedure TcsMultiChangeHyperLinks.pm_SetOldDocID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrOldDocID, nil] := (aValue);
end;//TcsMultiChangeHyperLinks.pm_SetOldDocID

function TcsMultiChangeHyperLinks.pm_GetNewDocID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrNewDocID]);
end;//TcsMultiChangeHyperLinks.pm_GetNewDocID

procedure TcsMultiChangeHyperLinks.pm_SetNewDocID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrNewDocID, nil] := (aValue);
end;//TcsMultiChangeHyperLinks.pm_SetNewDocID

function TcsMultiChangeHyperLinks.pm_GetFamilyID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrFamilyID]);
end;//TcsMultiChangeHyperLinks.pm_GetFamilyID

procedure TcsMultiChangeHyperLinks.pm_SetFamilyID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrFamilyID, nil] := (aValue);
end;//TcsMultiChangeHyperLinks.pm_SetFamilyID

class function TcsMultiChangeHyperLinks.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiChangeHyperLinks;
end;//TcsMultiChangeHyperLinks.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
