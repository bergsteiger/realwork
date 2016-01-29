program Addrbook;

uses
  Forms,
  Adrbook1 in 'ADRBOOK1.PAS' {AddrForm},
  Adrbook2 in 'ADRBOOK2.PAS' {AdrAbout},
  CalUnit in 'CalUnit.pas' {CalForm};

{$R *.RES}

begin
  Application.Title := 'Address Book';
  Application.CreateForm(TAddrForm, AddrForm);
  Application.CreateForm(TAdrAbout, AdrAbout);
  Application.Run;
end.
