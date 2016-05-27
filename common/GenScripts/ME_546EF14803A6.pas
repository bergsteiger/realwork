unit ncsTaskedFileDesc;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsTaskedFileDesc.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsTaskedFileDesc" MUID: (546EF14803A6)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsFileDesc
 , k2Base
;

type
 TncsTaskedFileDesc = class(TncsFileDesc)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetCopiedSize: Int64;
   procedure pm_SetCopiedSize(aValue: Int64);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property CopiedSize: Int64
    read pm_GetCopiedSize
    write pm_SetCopiedSize;
 end;//TncsTaskedFileDesc
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , TaskedFileDesc_Const
;

function TncsTaskedFileDesc.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsTaskedFileDesc.pm_GetTaskID

procedure TncsTaskedFileDesc.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsTaskedFileDesc.pm_SetTaskID

function TncsTaskedFileDesc.pm_GetCopiedSize: Int64;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrCopiedSize]);
end;//TncsTaskedFileDesc.pm_GetCopiedSize

procedure TncsTaskedFileDesc.pm_SetCopiedSize(aValue: Int64);
begin
 TaggedData.Int64W[k2_attrCopiedSize, nil] := (aValue);
end;//TncsTaskedFileDesc.pm_SetCopiedSize

class function TncsTaskedFileDesc.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typTaskedFileDesc;
end;//TncsTaskedFileDesc.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
