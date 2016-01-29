unit DUnitTestRunner;

interface

uses
  System.SysUtils,
  TextTestRunner,
  {$IFDEF CLR}
    {$IF RTLVersion <= 20.00} // RS 2009 or earlier
    NGuiTestRunner,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF MSWINDOWS}
{$IFNDEF NEXTGEN}
  Vcl.Forms,
  GuiTestRunner,
{$ENDIF NEXTGEN}
  {$ENDIF}
  TestFramework;

procedure RunRegisteredTests;

implementation

procedure RunRegisteredTests;
begin
  {$IFDEF MSWINDOWS}
    {$IFNDEF NEXTGEN}
  Application.Initialize;
    {$ENDIF NEXTGEN}
  {$ENDIF}
  if IsConsole then
  begin
    {$IFNDEF NEXTGEN}
    with TextTestRunner.RunRegisteredTests do
      Free;
    {$ELSE NEXTGEN}
      TextTestRunner.RunRegisteredTests
    {$ENDIF NEXTGEN}
  end
  else
  begin
    {$IFDEF CLR}
      {$IF RTLVersion <= 20.00} // RS 2009 or earlier
        NGuiTestRunner.RunRegisteredTests;
      {$ELSE}
        Assert(False, 'DotNet unit test not supported');
      {$ENDIF}
    {$ENDIF}
    {$IFDEF MSWINDOWS}
    {$IFNDEF NEXTGEN}
    GuiTestRunner.RunRegisteredTests;
    {$ENDIF NEXTGEN}
    {$ENDIF}
  end;
end;

end.
