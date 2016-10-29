unit csMultiModifyDocs;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiModifyDocs.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiModifyDocs" MUID: (57DA77B80161)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csPersonificatedMessage
 , k2SizedMemoryPool
 , l3MarshalledTypes
 , evdTasksHelpers
 , k2Base
;

type
 TcsMultiModifyDocs = class(TcsPersonificatedMessage)
  protected
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
   function pm_GetFamilyID: Integer;
   procedure pm_SetFamilyID(aValue: Integer);
   function pm_GetActionType: TOperActionType;
   procedure pm_SetActionType(aValue: TOperActionType);
   function pm_GetAnouncedDate: TDateTime;
   procedure pm_SetAnouncedDate(aValue: TDateTime);
   function pm_GetDocumentIDList: DocumentIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
   property FamilyID: Integer
    read pm_GetFamilyID
    write pm_SetFamilyID;
   property ActionType: TOperActionType
    read pm_GetActionType
    write pm_SetActionType;
   property AnouncedDate: TDateTime
    read pm_GetAnouncedDate
    write pm_SetAnouncedDate;
   property DocumentIDList: DocumentIDListHelper
    read pm_GetDocumentIDList;
 end;//TcsMultiModifyDocs
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiModifyDocs_Const
 //#UC START# *57DA77B80161impl_uses*
 //#UC END# *57DA77B80161impl_uses*
;

function TcsMultiModifyDocs.pm_GetData: Tk2RawData;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tk2RawData(TaggedData.cAtom(k2_attrData));
end;//TcsMultiModifyDocs.pm_GetData

procedure TcsMultiModifyDocs.pm_SetData(aValue: Tk2RawData);
begin
 TaggedData.AttrW[k2_attrData, nil] := (aValue);
end;//TcsMultiModifyDocs.pm_SetData

function TcsMultiModifyDocs.pm_GetFamilyID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrFamilyID]);
end;//TcsMultiModifyDocs.pm_GetFamilyID

procedure TcsMultiModifyDocs.pm_SetFamilyID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrFamilyID, nil] := (aValue);
end;//TcsMultiModifyDocs.pm_SetFamilyID

function TcsMultiModifyDocs.pm_GetActionType: TOperActionType;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TOperActionType(TaggedData.IntA[k2_attrActionType]);
end;//TcsMultiModifyDocs.pm_GetActionType

procedure TcsMultiModifyDocs.pm_SetActionType(aValue: TOperActionType);
begin
 TaggedData.IntW[k2_attrActionType, nil] := Ord(aValue);
end;//TcsMultiModifyDocs.pm_SetActionType

function TcsMultiModifyDocs.pm_GetAnouncedDate: TDateTime;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.DateTimeA[k2_attrAnouncedDate]);
end;//TcsMultiModifyDocs.pm_GetAnouncedDate

procedure TcsMultiModifyDocs.pm_SetAnouncedDate(aValue: TDateTime);
begin
 TaggedData.DateTimeW[k2_attrAnouncedDate, nil] := (aValue);
end;//TcsMultiModifyDocs.pm_SetAnouncedDate

function TcsMultiModifyDocs.pm_GetDocumentIDList: DocumentIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TcsMultiModifyDocs.pm_GetDocumentIDList

class function TcsMultiModifyDocs.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiModifyDocs;
end;//TcsMultiModifyDocs.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
