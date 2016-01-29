
unit ieregdb;

{$R-}
{$Q-}


interface

{$I ie.inc}



procedure Register;

implementation

uses Classes, DBImageEn,dbimageenvect;

procedure Register;
begin
   {$ifdef IEINCLUDEDB}
   RegisterComponents('ImageEn', [TImageEnDBView]);
   RegisterComponents('ImageEn', [TImageEnDBVect]);
   {$endif}
end;


end.
