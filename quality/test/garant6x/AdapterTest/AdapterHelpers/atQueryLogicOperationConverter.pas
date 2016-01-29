unit atQueryLogicOperationConverter;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/AdapterHelpers/atQueryLogicOperationConverter.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::AdapterHelpers::TatQueryLogicOperationConverter
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
 _EnumType_ = TQueryLogicOperation;
 {$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}
 TatQueryLogicOperationConverter = class(_atEnumConverter_)
 public
 // public methods
   class function Exists: Boolean;
     {* ��������� ������ ��������� ���������� ��� ��� }
 public
 // singleton factory method
   class function Instance: TatQueryLogicOperationConverter;
    {- ���������� ��������� ����������. }
 end;//TatQueryLogicOperationConverter

implementation

uses
  l3Base {a},
  TypInfo
  ;


// start class TatQueryLogicOperationConverter

var g_TatQueryLogicOperationConverter : TatQueryLogicOperationConverter = nil;

procedure TatQueryLogicOperationConverterFree;
begin
 l3Free(g_TatQueryLogicOperationConverter);
end;

class function TatQueryLogicOperationConverter.Instance: TatQueryLogicOperationConverter;
begin
 if (g_TatQueryLogicOperationConverter = nil) then
 begin
  l3System.AddExitProc(TatQueryLogicOperationConverterFree);
  g_TatQueryLogicOperationConverter := Create;
 end;
 Result := g_TatQueryLogicOperationConverter;
end;


{$Include w:\quality\test\garant6x\AdapterTest\CoreObjects\atEnumConverter.imp.pas}

// start class TatQueryLogicOperationConverter

class function TatQueryLogicOperationConverter.Exists: Boolean;
 {-}
begin
 Result := g_TatQueryLogicOperationConverter <> nil;
end;//TatQueryLogicOperationConverter.Exists

end.