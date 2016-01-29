//..........................................................................................................................................................................................................................................................
program Tester2;

{%ToDo 'tester2.todo'}

uses
  Forms,
  k2Tags,
  k2Facade,
  k2Base,
  evdSchema,
  evExtFormat,
  vtStdRes,
  MAIN in 'MAIN.PAS' {TesterForm};

{$R *.RES}

begin
  Application.Title := 'Тяни-толкай';
  Application.CreateForm(TTesterForm, TesterForm);
  Application.Run;
end.
