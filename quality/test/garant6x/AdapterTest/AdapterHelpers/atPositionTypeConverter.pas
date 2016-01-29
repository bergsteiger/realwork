unit atPositionTypeConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atPositionTypeConverter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatPositionTypeConverter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  DocumentUnit,
  SysUtils
  ;

type
 _EnumType_ = TPositionType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatPositionTypeConverter = class(_atEnumConverter_)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TatPositionTypeConverter;
    {- ���������� ��������� ����������. }
 end;//TatPositionTypeConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatPositionTypeConverter

var g_TatPositionTypeConverter : TatPositionTypeConverter = nil;

procedure TatPositionTypeConverterFree;
begin
 l3Free(g_TatPositionTypeConverter);
end;

class function TatPositionTypeConverter.Instance: TatPositionTypeConverter;
begin
 if (g_TatPositionTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatPositionTypeConverterFree);
  g_TatPositionTypeConverter := Create;
 end;
 Result := g_TatPositionTypeConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

// start class TatPositionTypeConverter

class function TatPositionTypeConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatPositionTypeConverter <> nil;
end;//TatPositionTypeConverter.Exists

end.