unit atQueryTypeConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atQueryTypeConverter.pas"
// ���������: "SimpleClass"
// ������� ������: "TatQueryTypeConverter" MUID: (50045BDB00CA)

interface

uses
 l3IntfUses
 , SearchUnit
 , SysUtils
;

type
 _EnumType_ = TQueryType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatQueryTypeConverter = class(_atEnumConverter_)
  public
   class function Instance: TatQueryTypeConverter;
    {* ����� ��������� ���������� ���������� TatQueryTypeConverter }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TatQueryTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , l3Base
 //#UC START# *50045BDB00CAimpl_uses*
 //#UC END# *50045BDB00CAimpl_uses*
;

var g_TatQueryTypeConverter: TatQueryTypeConverter = nil;
 {* ��������� ���������� TatQueryTypeConverter }

procedure TatQueryTypeConverterFree;
 {* ����� ������������ ���������� ���������� TatQueryTypeConverter }
begin
 l3Free(g_TatQueryTypeConverter);
end;//TatQueryTypeConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatQueryTypeConverter.Instance: TatQueryTypeConverter;
 {* ����� ��������� ���������� ���������� TatQueryTypeConverter }
begin
 if (g_TatQueryTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatQueryTypeConverterFree);
  g_TatQueryTypeConverter := Create;
 end;
 Result := g_TatQueryTypeConverter;
end;//TatQueryTypeConverter.Instance

class function TatQueryTypeConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatQueryTypeConverter <> nil;
end;//TatQueryTypeConverter.Exists

initialization
{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}


end.
