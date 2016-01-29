unit tstNSRCGenerator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "DailyTest"
// ������: "w:/common/components/rtl/Garant/Daily/tstNSRCGenerator.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Tests::DailyTest::NSRCUtils::TtstNSRCGenerator
//
// ������� ��� TddGenerator ��� ������ ������ � ������� ������ � ����������� �� � ����� ���
// ����������� ��������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ddNSRCGenerator
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 ItstNSRCListener = interface(IUnknown)
   ['{A89ABBCC-F4DD-4B5B-8AA4-50EA93C9907A}']
   procedure ExtractFileEvent(const aFileName: AnsiString);
     {* ������� ������� �������� �����. }
 end;//ItstNSRCListener

 TtstNSRCGenerator = class(TddNSRCGenerator)
  {* ������� ��� TddGenerator ��� ������ ������ � ������� ������ � ����������� �� � ����� ��� ����������� ��������. }
 private
 // private fields
   f_Listener : ItstNSRCListener;
 protected
 // overridden protected methods
   procedure SaveObjFileName(const aFileName: AnsiString); override;
 public
 // public methods
   procedure LinkNSRCListener(const aListener: ItstNSRCListener);
   procedure UnlinkNSRCListener(const aListener: ItstNSRCListener);
 end;//TtstNSRCGenerator
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TtstNSRCGenerator

procedure TtstNSRCGenerator.LinkNSRCListener(const aListener: ItstNSRCListener);
//#UC START# *4D70B25B0190_4D70B17C001C_var*
//#UC END# *4D70B25B0190_4D70B17C001C_var*
begin
//#UC START# *4D70B25B0190_4D70B17C001C_impl*
 Assert(f_Listener = nil);
 f_Listener := aListener;
//#UC END# *4D70B25B0190_4D70B17C001C_impl*
end;//TtstNSRCGenerator.LinkNSRCListener

procedure TtstNSRCGenerator.UnlinkNSRCListener(const aListener: ItstNSRCListener);
//#UC START# *4D70B2A203B9_4D70B17C001C_var*
//#UC END# *4D70B2A203B9_4D70B17C001C_var*
begin
//#UC START# *4D70B2A203B9_4D70B17C001C_impl*
 Assert(f_Listener = aListener);
 f_Listener := nil;
//#UC END# *4D70B2A203B9_4D70B17C001C_impl*
end;//TtstNSRCGenerator.UnlinkNSRCListener

procedure TtstNSRCGenerator.SaveObjFileName(const aFileName: AnsiString);
//#UC START# *4D70C8250128_4D70B17C001C_var*
//#UC END# *4D70C8250128_4D70B17C001C_var*
begin
//#UC START# *4D70C8250128_4D70B17C001C_impl*
  f_Listener.ExtractFileEvent(aFileName);
//#UC END# *4D70C8250128_4D70B17C001C_impl*
end;//TtstNSRCGenerator.SaveObjFileName

{$IfEnd} //nsTest AND not NoScripts

end.