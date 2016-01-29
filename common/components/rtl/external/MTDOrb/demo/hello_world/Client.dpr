program Client;
{$ifndef fpc}{$apptype console}{$endif}
uses
    {$ifdef unix}cthreads,{$endif}
    SysUtils,
    Classes,
    orb_int,
    orb,
    poa_int,
    poa_impl,
    exceptions,
    except_int,
    orbtypes,
    hello_int,
    hello;

procedure mainproc;
var
    dorb : IORB;
    obj: IORBObject;
    myobj: IHello;
    props: TStrings;
    i: integer;
    ex: ISystemException;
begin
    props := TStringList.Create;
    try
        for i := 1 to ParamCount do
            props.Add(ParamStr(i));
        dorb := ORB_Init(props);
    finally
        props.Free;
    end; { try/finally }
    
    obj := dorb.bind('IDL:Hello:1.0');
    
    if obj <> nil then 
    begin
        myobj := THello._narrow(obj);
        if myobj = nil then Exit;
        
        try
            myobj.say_hello('world');
            writeln('Successfully complete.');
        except
            on E: SystemException do 
            begin
                ex := SystemException.Create(E);
                writeln('Corba exception: ', SYSEXC_NAMES[ex.extype()]);
                ReadLn;
            end;
        end; { try/except }
    end
    else
    begin
        writeln('Can not bind!');
    end;
end;

begin
    mainproc;
end.
