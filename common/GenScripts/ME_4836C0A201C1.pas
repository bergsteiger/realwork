unit NOT_FINISHED_evCustomNSRCWriter;
 {* ������ ��� ������ ������ � ������� NSRC. }

// ������: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evCustomNSRCWriter.pas"
// ���������: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , evCustomTextPainter
;

type
 TevCustomNSRCWriter = class(TevCustomTextPainter)
  {* ������ ��� ������ ������ � ������� NSRC. }
  protected
   procedure CheckDigitalSeparatorAlignment; virtual;
    {* ������������� ����� �� ������� ������������ �� �����������. }
 end;//TevCustomNSRCWriter

implementation

uses
 l3ImplUses
 , evNSRWrt
;

procedure TevCustomNSRCWriter.CheckDigitalSeparatorAlignment;
 {* ������������� ����� �� ������� ������������ �� �����������. }
//#UC START# *4E3924CE03A3_4836C0A201C1_var*
//#UC END# *4E3924CE03A3_4836C0A201C1_var*
begin
//#UC START# *4E3924CE03A3_4836C0A201C1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E3924CE03A3_4836C0A201C1_impl*
end;//TevCustomNSRCWriter.CheckDigitalSeparatorAlignment

end.
