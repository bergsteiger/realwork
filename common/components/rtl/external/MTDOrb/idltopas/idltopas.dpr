// **********************************************************************
//
// Copyright (c) 2001 - 2002 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
program idltopas;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  SysUtils,
{$IFDEF MSWINDOWS}
  Windows,
{$ENDIF}
{$IFDEF LINUX}
  Libc,
{$ENDIF}
  ir_int,
  orb_int,
  orb,
  ir,
  version_int,
  orbtypes,
  Classes,
  idl in 'idl.pas',
  parser in 'parser.pas',
  codebase in 'codebase.pas',
  scanner in 'scanner.pas',
  codeunit in 'codeunit.pas',
  codeutil in 'codeutil.pas',
  cpp in 'cpp.pas',
  idldb in 'idldb.pas',
  YaccLib in 'Yacclib.pas',
  LexLib in 'Lexlib.pas';

var
  name : string;
  preprocess,fname_defined: Boolean;
  omit_preprocess : Boolean;
  con: IRepository;
  params: TStrings;
  i,j,p : integer;
  db: TDB;
  ch : Char;

procedure print_usage;
begin
  writeln('usage: idltopas [<options>] [<idlfile>]');
  writeln('where <options> are: ');
  writeln('  -h, -help       : print this message');
  writeln('  -v, -version    : print version');
  writeln('  -poa            : generate code for POA');
  writeln('  -i<path>        : path for include files');
  writeln('  -p              : preprocess to stdout');
  writeln('  -any            : generate code for Any marshalling');
  writeln('  -np             : don`t preprocess');
  writeln('  -impl           : generate example implementation');
  writeln('  -notabs         : generate servants and skeletons with implementation');
  writeln('  -without-prefix : generate types names without prefix');
  writeln('  -wp<name>       : generate types names without prefix in specific module');
  writeln('  -guid           : store GUID in ini file');
  writeln('  -ns             : namespaces in file name');
  writeln('  -nu<name>       : don''t include specific name in interface uses');
  Halt(1);
end;

procedure processparam( list : TStrings; line : String; start : Integer);
var
  str,sstr : String;
begin
  str := copy(line,start,1000);
  p := 1;
  j := 1;
  while j < length(str) do
    begin
      if str[j] = ';' then
        begin
          sstr := copy(str,p,j-1);
          if sstr <> '' then list.add(sstr);
          p := j+1;
        end;
      inc(j);
    end;
  sstr := copy(str,p,j);
  if sstr <> '' then list.add(sstr);
end;

begin
  preprocess := false;
  omit_preprocess := false;
  params := TStringList.Create;
  fname_defined := false;
  DecimalSeparator := '.';
  for i := 1 to Paramcount do
    begin
      name := lowercase(paramstr(i));
      if (name[1] = '-') and (name[2] <> '\') and (name[2] <> '/') then
        begin
          if name = '-p' then
            preprocess := true
          else if name = '-np' then
            omit_preprocess := true
          else if (name = '-poa') or (name = '-impl') or (name = '-any') or (name = '-notabs') or (name = '-without-prefix') then
            params.add(name)
          else if pos('-i',name) = 1 then // includes search paths
            processparam(includes, name, 3)
            //WJ: duplicated code - moved to procedure
{            begin
              str := copy(name,3,1000);
              p := 1;
              j := 1;
              while j < length(str) do
                begin
                  if str[j] = ';' then
                    begin
                      sstr := copy(str,p,j-1);
                      if sstr <> '' then includes.add(sstr);
                      p := j+1;
                    end;
                  inc(j);
                end;
              sstr := copy(str,p,j);
              if sstr <> '' then includes.add(sstr);
            end}
          else if pos('-wp',name) = 1 then // module list without prefix
            processparam(ModuleWithoutPrefix, name, 4)
{            begin
              str := copy(name,4,1000);
              p := 1;
              j := 1;
              while j < length(str) do
                begin
                  if str[j] = ';' then
                    begin
                      sstr := copy(str,p,j-1);
                      if sstr <> '' then ModuleWithoutPrefix.add(sstr);
                      p := j+1;
                    end;
                  inc(j);
                end;
              sstr := copy(str,p,j);
              if sstr <> '' then ModuleWithoutPrefix.add(sstr);
            end}
          else if pos('-nu',name) = 1 then // omit specific uses
            processparam(NoUses, name, 4)
{            begin
              str := copy(name,4,1000);
              p := 1;
              j := 1;
              while j < length(str) do
                begin
                  if str[j] = ';' then
                    begin
                      sstr := copy(str,p,j-1);
                      if sstr <> '' then NoUses.add(sstr);
                      p := j+1;
                    end;
                  inc(j);
                end;
              sstr := copy(str,p,j);
              if sstr <> '' then NoUses.add(sstr);
            end}
          else if (name = '-h') or (name = '-help') then
            print_usage
          else if (name = '-v') or (name = '-version') then
            begin
              WriteLn('Product name: Idl to pascal compiler (part of the MTDORB for Delphi and Kylix)');
              WriteLn('Version:      ' + ORBVersion);
              WriteLn('Copyright:    (C) 2001 - 2004 by Millennium Group');
              Halt(1);
            end
          else if (name = '-guid') then
            begin
              StoreGUID := True;
            end
          else if (name = '-ns') then
            begin
              NameSpaces := True;
              params.add(name);
            end
          else
            begin
              writeln('unknown parameter :'+name);
              print_usage;
            end;
        end
      else if not fileexists(paramstr(i)) then
        begin
          writeln('file not found :'+paramstr(i));
          print_usage
        end
      else
        begin
          if fname_defined then
            begin
              writeln('name already defined :'+name);
              print_usage;
            end;
          fname_defined := true;
          params.Insert(0,{name}paramstr(i)); // case sensitive
          filename := {name}paramstr(i); // case sensitive
        end;
    end;
  if params.IndexOf('-poa') = -1 then
    params.Add('-poa');
  if not fname_defined then
    begin
      writeln('missing file name');
      print_usage;
    end;
  yyoutput := TMemoryStream.Create;
  //yyoutput := TFileStream.Create(filename + '.yy',fmOpenWrite);
  try
    //yyinput := TFileStream.Create(filename,fmOpenRead);
    yyinput := OpenFile(AnsiString(filename));
    if not omit_preprocess then
      begin
        try
          yyprintln('#line 1 "'+AnsiString(filename)+'"');
          yyinput.position := 0;
          cpp.yylex;
        finally
          yyinput.free;
          yyinput := nil;
        end;
        yyoutput.Position := 0;
        if preprocess then
          begin
            while yyoutput.Position < yyoutput.Size do
              begin
                yyoutput.Read(ch,1);
                write(ch);
              end;
            exit;
          end;
        yyinput := yyoutput;
      end;
    {$IFDEF MSWINDOWS}
    yyoutput := THandleStream.Create(GetStdHandle(STD_OUTPUT_HANDLE));
    {$ENDIF}
    {$IFDEF LINUX}
    yyoutput := THandleStream.Create(STDOUT_FILENO);
    {$ENDIF}
    theParser := TParser.Create;
    try
      theParser.parse(filename);
      if theParser.getRootNode <> nil then
        try
          ORB_Init(nil);
          con:= TRepository.Create;
          db := TDB.Create;
          try
            with TScanner.Create(theParser.getRootNode,con,db) do
              try
                collect;
              finally
                free;
              end;
            with TCodegen.Create(con,params,db) do
              try
                generate;
              finally
                free;
              end;
          finally
            db.free;
          end;
        except
          on e : Exception do
            {$IFDEF MSWINDOWS}
            filewrite(GetStdHandle(STD_ERROR_HANDLE),PChar(e.message)^,length(e.message));
            {$ENDIF}
            {$IFDEF LINUX}
            filewrite((STDERR_FILENO),PChar(e.message)^,length(e.message));
            {$ENDIF}
        end;
    finally
      theParser.Free;
    end;
  finally
    yyoutput.free;
    yyinput.free;
  end;
end.
