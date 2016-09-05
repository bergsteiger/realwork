unit ncsGetFilePart;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsGetFilePart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsGetFilePart" MUID: (547583330291)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsGetFilePart = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
   function pm_GetOffset: Int64;
   procedure pm_SetOffset(aValue: Int64);
   function pm_GetPartSize: Int64;
   procedure pm_SetPartSize(aValue: Int64);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property FileName: AnsiString
    read pm_GetFileName
    write pm_SetFileName;
    {* С относительным путем (полный вычисляется от задачи) }
   property Offset: Int64
    read pm_GetOffset
    write pm_SetOffset;
   property PartSize: Int64
    read pm_GetPartSize
    write pm_SetPartSize;
 end;//TncsGetFilePart
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csGetFilePart_Const
 //#UC START# *547583330291impl_uses*
 //#UC END# *547583330291impl_uses*
;

function TncsGetFilePart.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsGetFilePart.pm_GetTaskID

procedure TncsGetFilePart.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsGetFilePart.pm_SetTaskID

function TncsGetFilePart.pm_GetFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileName]);
end;//TncsGetFilePart.pm_GetFileName

procedure TncsGetFilePart.pm_SetFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrFileName, nil] := (aValue);
end;//TncsGetFilePart.pm_SetFileName

function TncsGetFilePart.pm_GetOffset: Int64;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrOffset]);
end;//TncsGetFilePart.pm_GetOffset

procedure TncsGetFilePart.pm_SetOffset(aValue: Int64);
begin
 TaggedData.Int64W[k2_attrOffset, nil] := (aValue);
end;//TncsGetFilePart.pm_SetOffset

function TncsGetFilePart.pm_GetPartSize: Int64;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrPartSize]);
end;//TncsGetFilePart.pm_GetPartSize

procedure TncsGetFilePart.pm_SetPartSize(aValue: Int64);
begin
 TaggedData.Int64W[k2_attrPartSize, nil] := (aValue);
end;//TncsGetFilePart.pm_SetPartSize

class function TncsGetFilePart.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsGetFilePart;
end;//TncsGetFilePart.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
