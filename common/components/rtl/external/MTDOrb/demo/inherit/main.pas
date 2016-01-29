unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  orb,orb_int,inherit,inherit_int,utils;

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
var
  dorb: IORB;
  tag1,tag2,tag3 : IObjectTag;
  obj1,obj2,obj3 : IORBObject;
  base: IBase;
  derived1,derived2 : IDerived;
  params : TStrings;
begin
  params := TStringList.Create();
  try
    split('-ORBBindAddr inet:localhost:10000',params);
    dorb := orb.ORB_Init(params);
    tag1 := dorb.string_to_tag('Base_impl');
    tag2 := dorb.string_to_tag('Derived_impl_1');
    tag3 := dorb.string_to_tag('Derived_impl_2');
    obj1 := dorb.bind('IDL:Base:1.0',tag1);
    obj2 := dorb.bind('IDL:Derived:1.0',tag2);
    obj3 := dorb.bind('IDL:Derived:1.0',tag3);
    if (obj1 <> nil) and (obj2 <> nil) and (obj3 <> nil) then
      begin
        base := TBase._narrow(obj1);
        derived1 := TDerived._narrow(obj2);
        derived2 := TDerived._narrow(obj3);
        base.BaseOp;
        derived1.BaseOp;
        derived2.BaseOp;
        derived1.DerivedOp;
        derived2.DerivedOp;
      end;
  finally
    params.free;
  end;
end;

end.
