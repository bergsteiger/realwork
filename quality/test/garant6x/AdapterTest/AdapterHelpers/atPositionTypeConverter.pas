unit atPositionTypeConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atPositionTypeConverter.pas"
// ���������: "SimpleClass"
// ������� ������: "TatPositionTypeConverter" MUID: (53971CFA00EF)

interface

uses
 l3IntfUses
 , DocumentUnit
 , SysUtils
;

type
 _EnumType_ = TPositionType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatPositionTypeConverter = class(_atEnumConverter_)
  public
   class function Instance: TatPositionTypeConverter;
    {* ����� ��������� ���������� ���������� TatPositionTypeConverter }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TatPositionTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , l3Base
 //#UC START# *53971CFA00EFimpl_uses*
 //#UC END# *53971CFA00EFimpl_uses*
;

var g_TatPositionTypeConverter: TatPositionTypeConverter = nil;
 {* ��������� ���������� TatPositionTypeConverter }

procedure TatPositionTypeConverterFree;
 {* ����� ������������ ���������� ���������� TatPositionTypeConverter }
begin
 l3Free(g_TatPositionTypeConverter);
end;//TatPositionTypeConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

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

class function TatPositionTypeConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatPositionTypeConverter <> nil;
end;//TatPositionTypeConverter.Exists

initialization
{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}


end.
