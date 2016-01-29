program Server;
{$ifndef fpc}{$apptype console}{$endif}
uses
    {$ifdef linux}cthreads,{$endif}
    SysUtils,
    Classes,
    orb_int,
    orb,
    poa_int,
    poa_impl,
    code_int,
    intercept,
    Intercept_int,
    env_int,
    exceptions,
    orbtypes,
    hello_int,
    hello;

type
    THello_impl = class(THello_serv)
    protected
        procedure say_hello(const msg: AnsiString); override;
    end;

var
    dorb : IORB;

procedure mainproc;
var
    obj: IORBObject;
    props: TStrings;
    i: integer;
    p: IPOA;
begin
    props := TStringList.Create;
    try
        for i := 1 to ParamCount do
            props.Add(ParamStr(i));
        dorb := ORB_Init(props);
    finally
        props.Free;
    end; { try/finally }
    obj := dorb.resolve_initial_reference('RootPOA');
    p := TPOA_impl._narrow(obj);
    p.activate_object(THello_impl.Create());
    p.the_POAManager.activate;
    dorb.run();
end;

{ THello_impl }

procedure THello_impl.say_hello(const msg: AnsiString);
begin
    writeln('Hello, ' + msg + '!');
end;

begin
    mainproc;
end.
