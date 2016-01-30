unit atWordPositionConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\InteropWithL3\atWordPositionConverter.pas"
// ���������: "SimpleClass"

interface

uses
 l3IntfUses
 , l3Interfaces
 , DynamicTreeUnit
;

type
 _FirstType_ = Tl3WordPosition;
 _SecondType_ = TContextPlace;
 {$Include atEnumToEnumConverter.imp.pas}
 TatWordPositionConverter = class(_atEnumToEnumConverter_)
  protected
   procedure InitConvertMap; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TatWordPositionConverter;
    {* ����� ��������� ���������� ���������� TatWordPositionConverter }
 end;//TatWordPositionConverter

implementation

uses
 l3ImplUses
 , TypInfo
 , SysUtils
 , l3Base
;

var g_TatWordPositionConverter: TatWordPositionConverter = nil;
 {* ��������� ���������� TatWordPositionConverter }

procedure TatWordPositionConverterFree;
 {* ����� ������������ ���������� ���������� TatWordPositionConverter }
begin
 l3Free(g_TatWordPositionConverter);
end;//TatWordPositionConverterFree

{$Include atEnumToEnumConverter.imp.pas}

class function TatWordPositionConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatWordPositionConverter <> nil;
end;//TatWordPositionConverter.Exists

procedure TatWordPositionConverter.InitConvertMap;
//#UC START# *503E3A040395_503E65B1032E_var*
  const
    CONVERT_MAP : array [Tl3WordPosition] of Synonyms = (
      (First: wpAnyPathWord; Second: CP_ANY),
      (First: wpAtBeginWord; Second: CP_BEGIN_OF_WORD),
      (First: wpAtBeginString; Second: CP_BEGIN_OF_PHRASE)
    );
//#UC END# *503E3A040395_503E65B1032E_var*
begin
//#UC START# *503E3A040395_503E65B1032E_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_503E65B1032E_impl*
end;//TatWordPositionConverter.InitConvertMap

class function TatWordPositionConverter.Instance: TatWordPositionConverter;
 {* ����� ��������� ���������� ���������� TatWordPositionConverter }
begin
 if (g_TatWordPositionConverter = nil) then
 begin
  l3System.AddExitProc(TatWordPositionConverterFree);
  g_TatWordPositionConverter := Create;
 end;
 Result := g_TatWordPositionConverter;
end;//TatWordPositionConverter.Instance

end.
