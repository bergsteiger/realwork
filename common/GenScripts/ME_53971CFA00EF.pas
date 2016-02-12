unit atPositionTypeConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atPositionTypeConverter.pas"
// ���������: "SimpleClass"

interface

uses
 l3IntfUses
 , DocumentUnit
;

type
 _EnumType_ = TPositionType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatPositionTypeConverter = class(_atEnumConverter_)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TatPositionTypeConverter;
    {* ����� ��������� ���������� ���������� TatPositionTypeConverter }
 end;//TatPositionTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatPositionTypeConverter: TatPositionTypeConverter = nil;
 {* ��������� ���������� TatPositionTypeConverter }

procedure TatPositionTypeConverterFree;
 {* ����� ������������ ���������� ���������� TatPositionTypeConverter }
begin
 l3Free(g_TatPositionTypeConverter);
end;//TatPositionTypeConverterFree

{$If not Declared(_SecondType_)}type _SecondType_ = _EnumType_;{$IfEnd}

{$If not Declared(_FirstType_)}type _FirstType_ = AnsiString;{$IfEnd}

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatPositionTypeConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatPositionTypeConverter <> nil;
end;//TatPositionTypeConverter.Exists

class function TatPositionTypeConverter.Instance: TatPositionTypeConverter;
 {* ����� ��������� ���������� ���������� TatPositionTypeConverter }
begin
 if (g_TatPositionTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatPositionTypeConverterFree);
  g_TatPositionTypeConverter := Create;
 end;
 Result := g_TatPositionTypeConverter;
end;//TatPositionTypeConverter.Instance

end.
