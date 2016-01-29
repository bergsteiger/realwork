{***********************************************************}
{   This file is part of the DORB project.                  }
{                                                           }
{   See the file License, included in this distribution,    }
{   for details about the copyright.                        }
{                                                           }
{   Send comments and/or bug reports to: vic@inec.ru        }
{***********************************************************}
program nserver;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  SysUtils,
  orb_int,
  poa_int,
  orb,
  poa,
  orbtypes,
  poa_impl,
  classes,
  policy_int,
  naming_impl in 'naming_impl.pas';

procedure print_help;
begin
  writeln('usage: nserver [<options>]');
  writeln('where <options> are:');
  writeln('   /?,-help         this help');
  writeln('   -ior <filename>  save IOR into specified file');
end;

var
  dorb : IORB;
  list: TStrings;
  i : integer;
  obj : IORBObject;
  p : IPOA;
  pm, rcmgr: IPOAManager;
  pstr,ior_file_name : AnsiString;
  root_naming_context : TNamingContextExt_impl;
  root_context_poa, nc_poa : IPOA;
  fl : TextFile;
  plist : PolicyList;
begin
  ior_file_name := '';
  list := TStringList.Create;
  try
    i := 1;
    while i < ParamCount+1 do
      begin
        pstr := AnsiString(ParamStr(i));
        if (pstr = '/?')  or (pstr = '-help') then
          begin
            print_help;
            exit;
          end
        else if pstr = '-ior' then
          begin
            inc(i);
            ior_file_name := AnsiString(ParamStr(i));
            inc(i);
          end
        else
          begin
            list.Add(ParamStr(i));
            inc(i);
          end;
      end;
    list.add('-POAImplName');
    list.Add('NameService');
    dorb := ORB_Init(list);
  finally
    list.free;
  end;
  obj := dorb.resolve_initial_reference('RootPOA');
  assert(obj <> nil);
  p := POA_narrow(obj);
  assert(p <> nil);
  pm := p.the_POAManager;

  setLength(plist,1);
  plist[0] := p.create_lifespan_policy(PERSISTENT);

  nc_poa := p.create_POA('NamingContexts',nil,plist);
  rcmgr := nc_poa.the_POAManager;

  root_context_poa := p.create_POA('NameService',rcmgr,plist);
  root_naming_context := TNamingContextExt_impl.Create(dorb,p);
  root_context_poa.activate_object_with_id('NameService',root_naming_context);

  if ior_file_name <> '' then
    begin
      AssignFile(fl,String(ior_file_name));
      Rewrite(fl);
      obj := root_context_poa.servant_to_reference(root_naming_context);
      pstr := dorb.object_to_string(obj);
      write(fl,pstr);
      CloseFile(fl);
    end;

  rcmgr.activate;
  root_context_poa.the_POAManager.activate;
  pm.activate;
  dorb.run;
end.