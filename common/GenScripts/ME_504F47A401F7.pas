unit atControlStatusConverter;

// ������: "w:\quality\test\garant6x\AdapterTest\AdapterHelpers\atControlStatusConverter.pas"
// ���������: "SimpleClass"

interface

uses
 l3IntfUses
 , atStringToBitMaskConverterBase
;

type
 TatControlStatusConverter = class(TatStringToBitMaskConverterBase)
  protected
   procedure InitConvertMap; override;
  public
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TatControlStatusConverter;
    {* ����� ��������� ���������� ���������� TatControlStatusConverter }
 end;//TatControlStatusConverter

implementation

uses
 l3ImplUses
 , UnderControlUnit
 , SysUtils
 , l3Base
;

var g_TatControlStatusConverter: TatControlStatusConverter = nil;
 {* ��������� ���������� TatControlStatusConverter }

procedure TatControlStatusConverterFree;
 {* ����� ������������ ���������� ���������� TatControlStatusConverter }
begin
 l3Free(g_TatControlStatusConverter);
end;//TatControlStatusConverterFree

class function TatControlStatusConverter.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TatControlStatusConverter <> nil;
end;//TatControlStatusConverter.Exists

procedure TatControlStatusConverter.InitConvertMap;
//#UC START# *503E3A040395_504F47A401F7_var*
  const
    CONVERT_MAP : array [0..6] of atStringToBitMaskConverterBase.Synonyms = (
      (First : '�������� ������' ; Second : CS_DELETED),
      (First : '�������� ������� � ��������' ; Second : CS_ACTIVE),
      (First : '�������� �������' ; Second : CS_CHANGED),
      (First : '�������� ������� ����' ; Second : CS_ABOLISHED),
      (First : '�������� ��������������� � ������� ��' ; Second : CS_REGISTERED),
      (First : '��������� �������� � ����������� � ������� ��' ; Second : CS_NOT_REGISTERED),
      (First : '�������� �� ���������' ; Second : CS_NONE)
    );
//#UC END# *503E3A040395_504F47A401F7_var*
begin
//#UC START# *503E3A040395_504F47A401F7_impl*
  InitConvertMap(CONVERT_MAP);
//#UC END# *503E3A040395_504F47A401F7_impl*
end;//TatControlStatusConverter.InitConvertMap

class function TatControlStatusConverter.Instance: TatControlStatusConverter;
 {* ����� ��������� ���������� ���������� TatControlStatusConverter }
begin
 if (g_TatControlStatusConverter = nil) then
 begin
  l3System.AddExitProc(TatControlStatusConverterFree);
  g_TatControlStatusConverter := Create;
 end;
 Result := g_TatControlStatusConverter;
end;//TatControlStatusConverter.Instance

end.
