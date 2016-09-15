unit csMultiModifyDocs;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiModifyDocs.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiModifyDocs" MUID: (57DA77B80161)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2SizedMemoryPool
 , evdTasksHelpers
 , l3MarshalledTypes
 , k2Base
;

type
 TcsMultiModifyDocs = class(TncsMessage)
  protected
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
   function pm_GetFamilyID: Integer;
   procedure pm_SetFamilyID(aValue: Integer);
   function pm_GetDocIDList: DocIDListHelper;
   function pm_GetActionType: TOperActionType;
   procedure pm_SetActionType(aValue: TOperActionType);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
   property FamilyID: Integer
    read pm_GetFamilyID
    write pm_SetFamilyID;
   property DocIDList: DocIDListHelper
    read pm_GetDocIDList;
   property ActionType: TOperActionType
    read pm_GetActionType
    write pm_SetActionType;
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

function TcsMultiModifyDocs.pm_GetDocIDList: DocIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocIDListHelper.Make(TaggedData.cAtom(k2_attrDocIDList));
end;//TcsMultiModifyDocs.pm_GetDocIDList

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

class function TcsMultiModifyDocs.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiModifyDocs;
end;//TcsMultiModifyDocs.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
