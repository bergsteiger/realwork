unit atListNodeTypeConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atListNodeTypeConverter.pas"
// ���������: "SimpleClass"
// ������� ������: "TatListNodeTypeConverter" MUID: (539700E901EB)

interface

uses
 l3IntfUses
 , BaseTypesUnit
 , SysUtils
;

type
 _EnumType_ = TListNodeType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatListNodeTypeConverter = class(_atEnumConverter_)
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TatListNodeTypeConverter;
    {* ����� ��������� ���������� ���������� TatListNodeTypeConverter }
 end;//TatListNodeTypeConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , l3Base
;

var g_TatListNodeTypeConverter: TatListNodeTypeConverter = nil;
 {* ��������� ���������� TatListNodeTypeConverter }

procedure TatListNodeTypeConverterFree;
 {* ����� ������������ ���������� ���������� TatListNodeTypeConverter }
begin
 l3Free(g_TatListNodeTypeConverter);
end;//TatListNodeTypeConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

class function TatListNodeTypeConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatListNodeTypeConverter <> nil;
end;//TatListNodeTypeConverter.Exists

class function TatListNodeTypeConverter.Instance: TatListNodeTypeConverter;
 {* ����� ��������� ���������� ���������� TatListNodeTypeConverter }
begin
 if (g_TatListNodeTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatListNodeTypeConverterFree);
  g_TatListNodeTypeConverter := Create;
 end;
 Result := g_TatListNodeTypeConverter;
end;//TatListNodeTypeConverter.Instance

end.
