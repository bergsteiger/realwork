unit k2CustomFileGenerator;

interface

uses
 l3IntfUses
 , k2CustomStackGeneratorEx
;

type
 Tk2CustomFileGenerator = class(Tk2CustomStackGeneratorEx)
  {* ������� �������� ����� � ����. }
  procedure OutEOL;
   {* ������� ����� ������. }
 end;//Tk2CustomFileGenerator
 
implementation

uses
 l3ImplUses
;

end.
