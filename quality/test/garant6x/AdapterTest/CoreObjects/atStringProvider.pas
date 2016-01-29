unit atStringProvider;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/CoreObjects/atStringProvider.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::CoreObjects::TatStringProvider
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

interface

type
 TatStringProvider = {abstract} class(TObject)
 private
 // private fields
   f_Random : Boolean;
    {* ���� ��� �������� Random}
   f_Looped : Boolean;
    {* ���� ��� �������� Looped}
 public
 // public methods
   function AcquireNext(out theString: AnsiString): Boolean; virtual; abstract;
   procedure Reset; virtual; abstract;
 public
 // public properties
   property Random: Boolean
     read f_Random
     write f_Random;
   property Looped: Boolean
     read f_Looped
     write f_Looped;
 end;//TatStringProvider

implementation

end.