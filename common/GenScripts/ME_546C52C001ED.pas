unit ncsFileDesc;

// Модуль: "w:\common\components\rtl\Garant\cs\ncsFileDesc.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TncsFileDesc" MUID: (546C52C001ED)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3Variant
 , k2Base
 , Classes
;

type
 _evdTagHolder_Parent_ = Tl3Tag;
 {$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}
 TncsFileDesc = class(_evdTagHolder_)
  protected
   function pm_GetName: AnsiString;
   procedure pm_SetName(const aValue: AnsiString);
   function pm_GetCRC: Cardinal;
   procedure pm_SetCRC(aValue: Cardinal);
   function pm_GetDateTime: Integer;
   procedure pm_SetDateTime(aValue: Integer);
   function pm_GetSize: Int64;
   procedure pm_SetSize(aValue: Int64);
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
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
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , evdNativeWriter
 , l3Filer
 , l3Types
 , k2TagGen
 , evdNativeReader
 , k2DocumentBuffer
 , FileDesc_Const
;

{$Include w:\common\components\rtl\Garant\EVD\evdTagHolder.imp.pas}

function TncsFileDesc.pm_GetName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrName]);
end;//TncsFileDesc.pm_GetName

procedure TncsFileDesc.pm_SetName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrName, nil] := (aValue);
end;//TncsFileDesc.pm_SetName

function TncsFileDesc.pm_GetCRC: Cardinal;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrCRC]);
end;//TncsFileDesc.pm_GetCRC

procedure TncsFileDesc.pm_SetCRC(aValue: Cardinal);
begin
 TaggedData.IntW[k2_attrCRC, nil] := Integer(aValue);
end;//TncsFileDesc.pm_SetCRC

function TncsFileDesc.pm_GetDateTime: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDateTime]);
end;//TncsFileDesc.pm_GetDateTime

procedure TncsFileDesc.pm_SetDateTime(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDateTime, nil] := (aValue);
end;//TncsFileDesc.pm_SetDateTime

function TncsFileDesc.pm_GetSize: Int64;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.Int64A[k2_attrSize]);
end;//TncsFileDesc.pm_GetSize

procedure TncsFileDesc.pm_SetSize(aValue: Int64);
begin
 TaggedData.Int64W[k2_attrSize, nil] := (aValue);
end;//TncsFileDesc.pm_SetSize

class function TncsFileDesc.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typFileDesc;
end;//TncsFileDesc.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
