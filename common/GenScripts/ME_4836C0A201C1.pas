unit evCustomNSRCWriter;

interface

uses
 l3IntfUses
 , evCustomTextPainter
;

type
 TevCustomNSRCWriter = class(TevCustomTextPainter)
  {* ������ ��� ������ ������ � ������� NSRC. }
  procedure CheckDigitalSeparatorAlignment;
   {* ������������� ����� �� ������� ������������ �� �����������. }
 end;//TevCustomNSRCWriter
 
implementation

uses
 l3ImplUses
 , evNSRWrt
;

end.
