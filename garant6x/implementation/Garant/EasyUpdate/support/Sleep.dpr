program Sleep; {$R *.RES}

{$APPTYPE GUI}
{$WARNINGS ON}

uses
 Windows
 , SysUtils
 ;

begin
 Windows.Sleep(StrToIntDef(ParamStr(1), 0)*1000*60); // minutes
end.

