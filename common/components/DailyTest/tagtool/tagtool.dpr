program tagtool;

{$APPTYPE CONSOLE}

uses
 SysUtils,
 StrUtils;

var
 l_Filename: string;
 F: TextFile;
 l_Tags: string;
 l_Cmd : string;
 l_Op  : Char;
 I : Integer;

begin
 Writeln('Confluence tag editor');
 if ParamCount < 2 then
 begin
  Writeln('Usage: tagtool <filename> +|-<tag1> [+|-<tag2>...]');
  Writeln('Example: tagtool labels.txt -dead +folder');
 end;
 l_Filename := ParamStr(1);
 if FileExists(l_FileName) then
 begin
  AssignFile(F, l_Filename);
  Reset(F);
  Readln(F, l_Tags);
  CloseFile(F);
  for I := 2 to ParamCount do
  begin
   l_Cmd := ParamStr(I);
   l_Op := l_Cmd[1];
   if l_Op in ['-','+'] then
   begin
    Delete(l_Cmd, 1, 1);
    if l_Op = '-' then
    begin
     l_Tags := AnsiReplaceText(l_Tags, l_Cmd, '');
     l_Tags := AnsiReplaceText(l_Tags, ',,', ',');
     if l_Tags[1] = ',' then
      Delete(l_Tags, 1, 1);
     if l_Tags[Length(l_Tags)] = ',' then
      Delete(l_Tags, Length(l_Tags), 1);
    end
    else
     l_Tags := l_Tags + ',' + l_Cmd;
   end
   else
    Writeln('Wrong parameter: '+l_Cmd);
  end;
  AssignFile(F, l_Filename);
  Rewrite(F);
  Write(F, l_Tags);
  CloseFile(F);
 end
 else
  Writeln('File '+l_Filename+' not found!');
end.
