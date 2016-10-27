unit ncsPushFilePart;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsPushFilePart.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsPushFilePart" MUID: (548940970391)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ncsMessage
 , k2Base
;

type
 TncsPushFilePart = class(TncsMessage)
  protected
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
   function pm_GetOffset: Int64;
   procedure pm_SetOffset(aValue: Int64);
   function pm_GetPartSize: Int64;
   procedure pm_SetPartSize(aValue: Int64);
   function pm_GetData: Tk2RawData;
   procedure pm_SetData(aValue: Tk2RawData);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property TaskID: AnsiString
    read pm_GetTaskID
    write pm_SetTaskID;
   property FileName: AnsiString
    read pm_GetFileName
    write pm_SetFileName;
   property Offset: Int64
    read pm_GetOffset
    write pm_SetOffset;
   property PartSize: Int64
    read pm_GetPartSize
    write pm_SetPartSize;
   property Data: Tk2RawData
    read pm_GetData
    write pm_SetData;
 end;//TncsPushFilePart
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , csPushFilePart_Const
 //#UC START# *548940970391impl_uses*
 //#UC END# *548940970391impl_uses*
;

function TncsPushFilePart.pm_GetTaskID: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsPushFilePart.pm_GetTaskID

procedure TncsPushFilePart.pm_SetTaskID(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsPushFilePart.pm_SetTaskID

function TncsPushFilePart.pm_GetFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileName]);
end;//TncsPushFilePart.pm_GetFileName

procedure TncsPushFilePart.pm_SetFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrFileName, nil] := (aValue);
end;//TncsPushFilePart.pm_SetFileName

function TncsPushFilePart.pm_GetOffset: Int64;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrOffset]);
end;//TncsPushFilePart.pm_GetOffset

procedure TncsPushFilePart.pm_SetOffset(aValue: Int64);
begin
 TaggedData.Int64W[k2_attrOffset, nil] := (aValue);
end;//TncsPushFilePart.pm_SetOffset

function TncsPushFilePart.pm_GetPartSize: Int64;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrPartSize]);
end;//TncsPushFilePart.pm_GetPartSize

procedure TncsPushFilePart.pm_SetPartSize(aValue: Int64);
begin
 TaggedData.Int64W[k2_attrPartSize, nil] := (aValue);
end;//TncsPushFilePart.pm_SetPartSize

function TncsPushFilePart.pm_GetData: Tk2RawData;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Tk2RawData(TaggedData.cAtom(k2_attrData));
end;//TncsPushFilePart.pm_GetData

procedure TncsPushFilePart.pm_SetData(aValue: Tk2RawData);
begin
 TaggedData.AttrW[k2_attrData, nil] := (aValue);
end;//TncsPushFilePart.pm_SetData

class function TncsPushFilePart.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typcsPushFilePart;
end;//TncsPushFilePart.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
