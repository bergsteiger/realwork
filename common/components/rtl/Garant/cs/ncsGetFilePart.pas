unit ncsGetFilePart;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsGetFilePart.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsGetFilePart
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  ncsMessage,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TncsGetFilePart = class(TncsMessage)
 protected
 // property methods
   function pm_GetTaskID: AnsiString;
   procedure pm_SetTaskID(const aValue: AnsiString);
   function pm_GetFileName: AnsiString;
   procedure pm_SetFileName(const aValue: AnsiString);
   function pm_GetOffset: Int64;
   procedure pm_SetOffset(aValue: Int64);
   function pm_GetPartSize: Int64;
   procedure pm_SetPartSize(aValue: Int64);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
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
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  csGetFilePart_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TncsGetFilePart

function TncsGetFilePart.pm_GetTaskID: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrTaskID]);
end;//TncsGetFilePart.pm_GetTaskID

procedure TncsGetFilePart.pm_SetTaskID(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrTaskID, nil] := (aValue);
end;//TncsGetFilePart.pm_SetTaskID

function TncsGetFilePart.pm_GetFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrFileName]);
end;//TncsGetFilePart.pm_GetFileName

procedure TncsGetFilePart.pm_SetFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrFileName, nil] := (aValue);
end;//TncsGetFilePart.pm_SetFileName

function TncsGetFilePart.pm_GetOffset: Int64;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrOffset]);
end;//TncsGetFilePart.pm_GetOffset

procedure TncsGetFilePart.pm_SetOffset(aValue: Int64);
 {-}
begin
 TaggedData.Int64W[k2_attrOffset, nil] := (aValue);
end;//TncsGetFilePart.pm_SetOffset

function TncsGetFilePart.pm_GetPartSize: Int64;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrPartSize]);
end;//TncsGetFilePart.pm_GetPartSize

procedure TncsGetFilePart.pm_SetPartSize(aValue: Int64);
 {-}
begin
 TaggedData.Int64W[k2_attrPartSize, nil] := (aValue);
end;//TncsGetFilePart.pm_SetPartSize

class function TncsGetFilePart.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typcsGetFilePart;
end;//TncsGetFilePart.GetTaggedDataType

{$IfEnd} //not Nemesis

end.