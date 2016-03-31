unit atWordOrderConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\InteropWithL3\atWordOrderConverter.pas"
// ���������: "SimpleClass"
// ������� ������: "TatWordOrderConverter" MUID: (503E615E0377)

interface

uses
 l3IntfUses
 , l3Interfaces
 , DynamicTreeUnit
;

type
 _FirstType_ = Tl3WordOrder;
 _SecondType_ = TFindOrder;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}
 TatWordOrderConverter = class(_atEnumToEnumConverter_)
  protected
   procedure InitConvertMap; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TatWordOrderConverter;
    {* ����� ��������� ���������� ���������� TatWordOrderConverter }
 end;//TatWordOrderConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatWordOrderConverter: TatWordOrderConverter = nil;
 {* ��������� ���������� TatWordOrderConverter }

procedure TatWordOrderConverterFree;
 {* ����� ������������ ���������� ���������� TatWordOrderConverter }
begin
 l3Free(g_TatWordOrderConverter);
end;//TatWordOrderConverterFree

{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumToEnumConverter.imp.pas}

class function TatWordOrderConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatWordOrderConverter <> nil;
end;//TatWordOrderConverter.Exists

procedure TatWordOrderConverter.InitConvertMap;
//#UC START# *503E3A040395_503E615E0377_var*
  const
    CONVERT_MAP : array [Tl3WordOrder] of Synonyms = (
      (First : woAnyOrder; Second : FO_ANY),
      (First : woAsWrote; Second : FO_SEQUENCE)
    );
//#UC END# *503E3A040395_503E615E0377_var*
begin
//#UC START# *503E3A040395_503E615E0377_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503E615E0377_impl*
end;//TatWordOrderConverter.InitConvertMap

class function TatWordOrderConverter.Instance: TatWordOrderConverter;
 {* ����� ��������� ���������� ���������� TatWordOrderConverter }
begin
 if (g_TatWordOrderConverter = nil) then
 begin
  l3System.AddExitProc(TatWordOrderConverterFree);
  g_TatWordOrderConverter := Create;
 end;
 Result := g_TatWordOrderConverter;
end;//TatWordOrderConverter.Instance

end.
