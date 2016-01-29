unit ncsFileDesc;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/ncsFileDesc.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ResultDelivery::TncsFileDesc
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
  l3Variant,
  Classes,
  k2Base
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TncsFileDesc = class(_evdTagHolder_)
 protected
 // property methods
   function pm_GetName: AnsiString;
   procedure pm_SetName(const aValue: AnsiString);
   function pm_GetCRC: Cardinal;
   procedure pm_SetCRC(aValue: Cardinal);
   function pm_GetDateTime: Integer;
   procedure pm_SetDateTime(aValue: Integer);
   function pm_GetSize: Int64;
   procedure pm_SetSize(aValue: Int64);
 public
 // realized methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // public properties
   property Name: AnsiString
     read pm_GetName
     write pm_SetName;
   property CRC: Cardinal
     read pm_GetCRC
     write pm_SetCRC;
   property DateTime: Integer
     read pm_GetDateTime
     write pm_SetDateTime;
   property Size: Int64
     read pm_GetSize
     write pm_SetSize;
 end;//TncsFileDesc
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  FileDesc_Const,
  evdNativeWriter,
  l3Filer,
  l3Types,
  k2TagGen,
  evdNativeReader,
  k2DocumentBuffer,
  SysUtils
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

// start class TncsFileDesc

function TncsFileDesc.pm_GetName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrName]);
end;//TncsFileDesc.pm_GetName

procedure TncsFileDesc.pm_SetName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrName, nil] := (aValue);
end;//TncsFileDesc.pm_SetName

function TncsFileDesc.pm_GetCRC: Cardinal;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrCRC]);
end;//TncsFileDesc.pm_GetCRC

procedure TncsFileDesc.pm_SetCRC(aValue: Cardinal);
 {-}
begin
 TaggedData.IntW[k2_attrCRC, nil] := Integer(aValue);
end;//TncsFileDesc.pm_SetCRC

function TncsFileDesc.pm_GetDateTime: Integer;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDateTime]);
end;//TncsFileDesc.pm_GetDateTime

procedure TncsFileDesc.pm_SetDateTime(aValue: Integer);
 {-}
begin
 TaggedData.IntW[k2_attrDateTime, nil] := (aValue);
end;//TncsFileDesc.pm_SetDateTime

function TncsFileDesc.pm_GetSize: Int64;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrSize]);
end;//TncsFileDesc.pm_GetSize

procedure TncsFileDesc.pm_SetSize(aValue: Int64);
 {-}
begin
 TaggedData.Int64W[k2_attrSize, nil] := (aValue);
end;//TncsFileDesc.pm_SetSize

class function TncsFileDesc.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typFileDesc;
end;//TncsFileDesc.GetTaggedDataType

{$IfEnd} //not Nemesis

end.