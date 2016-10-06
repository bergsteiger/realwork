unit csMultiClearAttributes;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiClearAttributes.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiClearAttributes" MUID: (57EBA087012F)

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
 TcsMultiClearAttributes = class(TcsPersonificatedMessage)
  protected
   function pm_GetFamilyID: Integer;
   procedure pm_SetFamilyID(aValue: Integer);
   function pm_GetDocIDList: DocIDListHelper;
   function pm_GetAttributes: AttributesHelper;
   function pm_GetRightsNeeded: Integer;
   procedure pm_SetRightsNeeded(aValue: Integer);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property FamilyID: Integer
    read pm_GetFamilyID
    write pm_SetFamilyID;
   property DocIDList: DocIDListHelper
    read pm_GetDocIDList;
   property Attributes: AttributesHelper
    read pm_GetAttributes;
   property RightsNeeded: Integer
    read pm_GetRightsNeeded
    write pm_SetRightsNeeded;
 end;//TcsMultiClearAttributes
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiClearAttributes_Const
 //#UC START# *57EBA087012Fimpl_uses*
 //#UC END# *57EBA087012Fimpl_uses*
;

function TcsMultiClearAttributes.pm_GetFamilyID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrFamilyID]);
end;//TcsMultiClearAttributes.pm_GetFamilyID

procedure TcsMultiClearAttributes.pm_SetFamilyID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrFamilyID, nil] := (aValue);
end;//TcsMultiClearAttributes.pm_SetFamilyID

function TcsMultiClearAttributes.pm_GetDocIDList: DocIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocIDListHelper.Make(TaggedData.cAtom(k2_attrDocIDList));
end;//TcsMultiClearAttributes.pm_GetDocIDList

function TcsMultiClearAttributes.pm_GetAttributes: AttributesHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TAttributesHelper.Make(TaggedData.cAtom(k2_attrAttributes));
end;//TcsMultiClearAttributes.pm_GetAttributes

function TcsMultiClearAttributes.pm_GetRightsNeeded: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrRightsNeeded]);
end;//TcsMultiClearAttributes.pm_GetRightsNeeded

procedure TcsMultiClearAttributes.pm_SetRightsNeeded(aValue: Integer);
begin
 TaggedData.IntW[k2_attrRightsNeeded, nil] := (aValue);
end;//TcsMultiClearAttributes.pm_SetRightsNeeded

class function TcsMultiClearAttributes.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiClearAttributes;
end;//TcsMultiClearAttributes.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
