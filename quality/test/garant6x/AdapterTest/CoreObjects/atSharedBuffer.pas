unit atSharedBuffer;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atSharedBuffer.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatSharedBuffer
//
// ����� ��� �������� ������ ������, ������ ��� ���������� ��������� �� ����� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

uses
  l3_Base,
  Windows
  ;

type
 TatSharedBuffer = class(Tl3_Base)
  {* ����� ��� �������� ������ ������, ������ ��� ���������� ��������� �� ����� ������. }
 private
 // private fields
   f_FileMapping : THandle;
   f_MappingAddress : Pointer;
   f_Size : LongWord;
    {* ���� ��� �������� Size}
 protected
 // property methods
   function pm_GetValue: Pointer; virtual;
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* ������� ������� ����� �������. }
 public
 // public methods
   constructor Create(const aName: AnsiString;
    aSize: LongWord); reintroduce;
 public
 // public properties
   property Value: Pointer
     read pm_GetValue;
     {* ��������� �� �����. }
   property Size: LongWord
     read f_Size;
     {* ������ ������. }
 end;//TatSharedBuffer

implementation

uses
  SysUtils
  ;

// start class TatSharedBuffer

function TatSharedBuffer.pm_GetValue: Pointer;
//#UC START# *491D881000F6_491D776401B4get_var*
//#UC END# *491D881000F6_491D776401B4get_var*
begin
//#UC START# *491D881000F6_491D776401B4get_impl*
  Result := f_MappingAddress;
//#UC END# *491D881000F6_491D776401B4get_impl*
end;//TatSharedBuffer.pm_GetValue

constructor TatSharedBuffer.Create(const aName: AnsiString;
  aSize: LongWord);
//#UC START# *491D78AD03E4_491D776401B4_var*
  var
    isNewMapping : boolean;
//#UC END# *491D78AD03E4_491D776401B4_var*
begin
//#UC START# *491D78AD03E4_491D776401B4_impl*
  inherited Create;
  f_Size := aSize;
  // ������� ����������� � ���� ��������
  f_FileMapping := CreateFileMapping(
    $FFFFFFFF, nil, PAGE_READWRITE OR SEC_COMMIT, 0, f_Size, PAnsiChar('{5D573166-D8D3-4419-97CE-83DDF40C9831}_' + aName)
  );
  isNewMapping := (GetLastError() = 0); // ���� �� ��� ������������, �� GetLastError ��������� �� ERROR_ALREADY_EXISTS
  if (f_FileMapping = 0) then
    Raise Exception.Create('����� CreateFileMapping �� ������!');
  // ������ ����� � �������� ������������
  f_MappingAddress := MapViewOfFile(f_FileMapping, FILE_MAP_ALL_ACCESS, 0, 0, f_Size);
  if (f_MappingAddress = nil) then
    Raise Exception.Create('����� MapViewOfFile �� ������!');
  if isNewMapping then
    FillChar(f_MappingAddress^, f_Size, 0);
//#UC END# *491D78AD03E4_491D776401B4_impl*
end;//TatSharedBuffer.Create

procedure TatSharedBuffer.Cleanup;
//#UC START# *479731C50290_491D776401B4_var*
//#UC END# *479731C50290_491D776401B4_var*
begin
//#UC START# *479731C50290_491D776401B4_impl*
  UnmapViewOfFile(f_MappingAddress);
  CloseHandle(f_FileMapping);
  inherited;
//#UC END# *479731C50290_491D776401B4_impl*
end;//TatSharedBuffer.Cleanup

end.