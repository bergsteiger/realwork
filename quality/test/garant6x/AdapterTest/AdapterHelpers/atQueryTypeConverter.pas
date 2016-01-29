unit atQueryTypeConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atQueryTypeConverter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatQueryTypeConverter
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  SearchUnit,
  SysUtils
  ;

type
 _EnumType_ = TQueryType;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatQueryTypeConverter = class(_atEnumConverter_)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TatQueryTypeConverter;
    {- ���������� ��������� ����������. }
 end;//TatQueryTypeConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatQueryTypeConverter

var g_TatQueryTypeConverter : TatQueryTypeConverter = nil;

procedure TatQueryTypeConverterFree;
begin
 l3Free(g_TatQueryTypeConverter);
end;

class function TatQueryTypeConverter.Instance: TatQueryTypeConverter;
begin
 if (g_TatQueryTypeConverter = nil) then
 begin
  l3System.AddExitProc(TatQueryTypeConverterFree);
  g_TatQueryTypeConverter := Create;
 end;
 Result := g_TatQueryTypeConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

// start class TatQueryTypeConverter

class function TatQueryTypeConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatQueryTypeConverter <> nil;
end;//TatQueryTypeConverter.Exists

end.