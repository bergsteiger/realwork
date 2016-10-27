unit csMultiOperation;

// Модуль: "w:\common\components\rtl\Garant\cs\csMultiOperation.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsMultiOperation" MUID: (57EE51860032)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csPersonificatedMessage
 , k2Base
;

type
 TcsMultiOperation = class(TcsPersonificatedMessage)
  protected
   function pm_GetFamilyID: Integer;
   procedure pm_SetFamilyID(aValue: Integer);
   function pm_GetOperation: TarMultiOperation;
   procedure pm_SetOperation(aValue: TarMultiOperation);
   function pm_GetDocumentIDList: DocumentIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property FamilyID: Integer
    read pm_GetFamilyID
    write pm_SetFamilyID;
   property Operation: TarMultiOperation
    read pm_GetOperation
    write pm_SetOperation;
   property DocumentIDList: DocumentIDListHelper
    read pm_GetDocumentIDList;
 end;//TcsMultiOperation
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csMultiOperation_Const
 //#UC START# *57EE51860032impl_uses*
 //#UC END# *57EE51860032impl_uses*
;

function TcsMultiOperation.pm_GetFamilyID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrFamilyID]);
end;//TcsMultiOperation.pm_GetFamilyID

procedure TcsMultiOperation.pm_SetFamilyID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrFamilyID, nil] := (aValue);
end;//TcsMultiOperation.pm_SetFamilyID

function TcsMultiOperation.pm_GetOperation: TarMultiOperation;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TarMultiOperation(TaggedData.IntA[k2_attrOperation]);
end;//TcsMultiOperation.pm_GetOperation

procedure TcsMultiOperation.pm_SetOperation(aValue: TarMultiOperation);
begin
 TaggedData.IntW[k2_attrOperation, nil] := Ord(aValue);
end;//TcsMultiOperation.pm_SetOperation

function TcsMultiOperation.pm_GetDocumentIDList: DocumentIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDocumentIDListHelper.Make(TaggedData.cAtom(k2_attrDocumentIDList));
end;//TcsMultiOperation.pm_GetDocumentIDList

class function TcsMultiOperation.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsMultiOperation;
end;//TcsMultiOperation.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
