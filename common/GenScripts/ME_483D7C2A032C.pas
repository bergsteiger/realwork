unit NOT_FINISHED_evdCustomNativeWriter;
 {* �������� ����� � ������� evd. }

// ������: "w:\common\components\rtl\Garant\EVD\NOT_FINISHED_evdCustomNativeWriter.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\EVD\evdDefine.inc}

interface

uses
 l3IntfUses
 , k2CustomFileGenerator
;

type
 TevdCustomNativeWriter = class(Tk2CustomFileGenerator)
  {* �������� ����� � ������� evd. }
 end;//TevdCustomNativeWriter

implementation

uses
 l3ImplUses
 , evdCustomNativeWriterServices
;

end.
