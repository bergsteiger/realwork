unit k2VariantImpl;

// ������: "w:\common\components\rtl\Garant\K2\k2VariantImpl.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3DataContainerWithoutIUnknownPrim
 , k2Interfaces
 , l3Variant
 , Classes
 , l3Interfaces
;

type
 Tk2VariantImpl = class(Tl3DataContainerWithoutIUnknownPrim, Ik2Variant)
  private
   f_Tag: Tl3Variant;
   f_Stream: TStream;
   f_IStream: IStream;
  protected
   function Get_Kind: Tk2VarKind;
   function Get_AsString: Tl3PrimString;
   function Get_AsInteger: Integer;
   function Get_AsStream: TStream;
   function Get_AsVariant: Tl3Variant;
   procedure Cleanup; override;
    {* ������� ������� ����� �������. }
   {$If NOT Defined(DesignTimeLibrary)}
   class function IsCacheable: Boolean; override;
    {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
   {$IfEnd} // NOT Defined(DesignTimeLibrary)
   procedure ClearFields; override;
  public
   constructor Create(aTag: Tl3Variant); reintroduce;
   class function Make(aTag: Tl3Variant): Ik2Variant; reintroduce; overload;
   class function Make(aValue: Integer): Ik2Variant; overload;
 end;//Tk2VariantImpl

implementation

uses
 l3ImplUses
 , SysUtils
 , l3Stream
 , k2String_Const
 , k2Base
 , k2NullTagImpl
 , k2Long_Const
 , l3IID
 , l3InterfacesMisc
;

constructor Tk2VariantImpl.Create(aTag: Tl3Variant);
//#UC START# *530F2A36024A_530F1BCA00B2_var*
//#UC END# *530F2A36024A_530F1BCA00B2_var*
begin
//#UC START# *530F2A36024A_530F1BCA00B2_impl*
 inherited Create;
// Assert(aTag <> nil);
 if (aTag = nil) then
  Tk2NullTagImpl.Instance.SetRef(f_Tag)
 else
  aTag.SetRef(f_Tag);
//#UC END# *530F2A36024A_530F1BCA00B2_impl*
end;//Tk2VariantImpl.Create

class function Tk2VariantImpl.Make(aTag: Tl3Variant): Ik2Variant;
var
 l_Inst : Tk2VariantImpl;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//Tk2VariantImpl.Make

class function Tk2VariantImpl.Make(aValue: Integer): Ik2Variant;
//#UC START# *530F438C01D2_530F1BCA00B2_var*
//#UC END# *530F438C01D2_530F1BCA00B2_var*
begin
//#UC START# *530F438C01D2_530F1BCA00B2_impl*
 Result := Make(k2_typLong.MakeTag(aValue).AsObject);
//#UC END# *530F438C01D2_530F1BCA00B2_impl*
end;//Tk2VariantImpl.Make

function Tk2VariantImpl.Get_Kind: Tk2VarKind;
//#UC START# *530F1B3C029B_530F1BCA00B2get_var*
//#UC END# *530F1B3C029B_530F1BCA00B2get_var*
begin
//#UC START# *530F1B3C029B_530F1BCA00B2get_impl*
 if f_Tag.IsTransparent then
  Result := k2_vkTransparent
 else
 if f_Tag.IsOrd then
  Result := k2_vkInteger
 else
 if f_Tag.IsKindOf(k2_typString) then
  Result := k2_vkString
 else
 if f_Tag.IsStream(f_IStream) then
  Result := k2_vkStream
 else
  Result := k2_vkInteger;
//#UC END# *530F1B3C029B_530F1BCA00B2get_impl*
end;//Tk2VariantImpl.Get_Kind

function Tk2VariantImpl.Get_AsString: Tl3PrimString;
//#UC START# *530F1B6501B3_530F1BCA00B2get_var*
//#UC END# *530F1B6501B3_530F1BCA00B2get_var*
begin
//#UC START# *530F1B6501B3_530F1BCA00B2get_impl*
 Result := f_Tag As Tl3PrimString;
//#UC END# *530F1B6501B3_530F1BCA00B2get_impl*
end;//Tk2VariantImpl.Get_AsString

function Tk2VariantImpl.Get_AsInteger: Integer;
//#UC START# *530F1B86025B_530F1BCA00B2get_var*
//#UC END# *530F1B86025B_530F1BCA00B2get_var*
begin
//#UC START# *530F1B86025B_530F1BCA00B2get_impl*
 Result := f_Tag.AsLong;
//#UC END# *530F1B86025B_530F1BCA00B2get_impl*
end;//Tk2VariantImpl.Get_AsInteger

function Tk2VariantImpl.Get_AsStream: TStream;
//#UC START# *530F1BA50053_530F1BCA00B2get_var*
//#UC END# *530F1BA50053_530F1BCA00B2get_var*
begin
//#UC START# *530F1BA50053_530F1BCA00B2get_impl*
 if (f_Stream = nil) then
 begin
  if (f_IStream <> nil) then
   l3IStream2Stream(f_IStream, f_Stream)
  else
  if f_Tag.IsStream(f_IStream) then
   l3IStream2Stream(f_IStream, f_Stream);
 end;//f_Stream = nil
 Result := f_Stream;
//#UC END# *530F1BA50053_530F1BCA00B2get_impl*
end;//Tk2VariantImpl.Get_AsStream

function Tk2VariantImpl.Get_AsVariant: Tl3Variant;
//#UC START# *532AE5E5015C_530F1BCA00B2get_var*
//#UC END# *532AE5E5015C_530F1BCA00B2get_var*
begin
//#UC START# *532AE5E5015C_530F1BCA00B2get_impl*
 Result := f_Tag;
//#UC END# *532AE5E5015C_530F1BCA00B2get_impl*
end;//Tk2VariantImpl.Get_AsVariant

procedure Tk2VariantImpl.Cleanup;
 {* ������� ������� ����� �������. }
//#UC START# *479731C50290_530F1BCA00B2_var*
//#UC END# *479731C50290_530F1BCA00B2_var*
begin
//#UC START# *479731C50290_530F1BCA00B2_impl*
 FreeAndNil(f_Stream);
 FreeAndNil(f_Tag);
 inherited;
//#UC END# *479731C50290_530F1BCA00B2_impl*
end;//Tk2VariantImpl.Cleanup

{$If NOT Defined(DesignTimeLibrary)}
class function Tk2VariantImpl.IsCacheable: Boolean;
 {* ������� ������, ������������ ����� �� ������� ������� ������ �������� � ��� ���������� �������������. }
//#UC START# *47A6FEE600FC_530F1BCA00B2_var*
//#UC END# *47A6FEE600FC_530F1BCA00B2_var*
begin
//#UC START# *47A6FEE600FC_530F1BCA00B2_impl*
 Result := true;
//#UC END# *47A6FEE600FC_530F1BCA00B2_impl*
end;//Tk2VariantImpl.IsCacheable
{$IfEnd} // NOT Defined(DesignTimeLibrary)

procedure Tk2VariantImpl.ClearFields;
begin
 f_IStream := nil;
 inherited;
end;//Tk2VariantImpl.ClearFields

end.
