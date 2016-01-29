program NonrectangularForm_sample;

uses
  Windows,
  SysUtils,
  NonrectangularForm in 'NonrectangularForm.pas';

begin
  with TNonrectangularForm.CreateNew(nil) do begin
   Color := RGB(210, 225, 246);
   SetBounds(200,200,400,100);
   ShowModal;
   Free;
  end;
end.
 