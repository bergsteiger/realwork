unit atControlStatusConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atControlStatusConverter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatControlStatusConverter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  atStringToBitMaskConverterBase
  ;

type
 TatControlStatusConverter = class(TatStringToBitMaskConverterBase)
 protected
 // realized methods
   procedure InitConvertMap; override;
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TatControlStatusConverter;
    {- ���������� ��������� ����������. }
 end;//TatControlStatusConverter

implementation

uses
  l3Base {a},
  UnderControlUnit,
  SysUtils
  ;


// start class TatControlStatusConverter

var g_TatControlStatusConverter : TatControlStatusConverter = nil;

procedure TatControlStatusConverterFree;
begin
 l3Free(g_TatControlStatusConverter);
end;

class function TatControlStatusConverter.Instance: TatControlStatusConverter;
begin
 if (g_TatControlStatusConverter = nil) then
 begin
  l3System.AddExitProc(TatControlStatusConverterFree);
  g_TatControlStatusConverter := Create;
 end;
 Result := g_TatControlStatusConverter;
end;


class function TatControlStatusConverter.Exists: Boolean;
 {-}
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

end.