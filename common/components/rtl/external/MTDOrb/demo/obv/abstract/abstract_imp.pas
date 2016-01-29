unit abstract_imp;

interface

uses
  classes, value_int, {$IFDEF LINUX}dtypes, {$ENDIF}abstract,
  abstract_int, sysutils, orbtypes;

type

  TExample_impl = class(TExample_serv)
    procedure display(const anObject: IDescribable); override;
  end;

  TAccount_impl = class(TAccount_serv)
    function get_description: AnsiString; override;
  end;

  TCurrency_impl = class(TCurrency)
  protected
    function get_description: AnsiString; override;
  end;


  TCurrency_factory = class(TInterfacedObject,IValueFactory)
  protected
    function create_for_umarshal(): IValueBase; virtual;
    function narrow_helper(const repoid: RepositoryID): Pointer;
  end;


implementation


//***********************************************************
// TCurrency_factory
//***********************************************************
function TCurrency_factory.create_for_umarshal(): IValueBase;
begin
  result := TCurrency_impl.Create();
end;

function TCurrency_factory.narrow_helper(const repoid: RepositoryID): Pointer;
begin
  result := nil;
  if strcomp(PAnsiChar(repoid),'IDL:Currency:1.0')= 0 then
    result := Pointer( self as IValueFactory);
end;


//***********************************************************
// Example_impl
//***********************************************************
procedure TExample_impl.display(const anObject: IDescribable);
begin
  writeln(anObject.get_description)
end;

//***********************************************************
// Account_impl
//***********************************************************
function TAccount_impl.get_description: AnsiString;
begin
  result := 'Account';
end;

//***********************************************************
// TCurrency_impl
//***********************************************************
function TCurrency_impl.get_description: AnsiString;
begin
  result := 'Currency';
end;

end.
