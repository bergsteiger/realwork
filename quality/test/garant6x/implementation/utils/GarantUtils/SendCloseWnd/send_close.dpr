program send_close;
{$APPTYPE CONSOLE}

uses
  Windows, Messages, SysUtils;

var
  w : HWND;
  pclass, pname: String;
begin
 ExitCode := 0;

 Writeln;
 Writeln('(C) 2009-2012 Garant-Service. Send WM_CLOSE to window.');

 if ParamStr(1) = '/close' then
 begin
   pclass := ParamStr(2);
   pname := ParamStr(3);
   Writeln(' Class: ' + pclass);
   Writeln('  Name: ' + pname);

   if (pclass = '') or (pclass = '-')then
     w := FindWindow(nil, PAnsiChar(pname))
   else
   if (pname = '') or (pname = '-') then
     w := FindWindow(PAnsiChar(pclass), nil)
   else
     w := FindWindow(PAnsiChar(pclass), PAnsiChar(pname));

   if w <> 0 then
   begin
     ExitCode := 1;
     PostMessage(w, WM_CLOSE, 0, 0);
   end;
 end
 else
 begin
   Writeln('Return 1 exit code if successfully else 0.');
   Writeln('Example: send_close.exe /close [WNDCLASSNAME] [WNDNAME]');
 end;

 Writeln;
end.
