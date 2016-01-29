unit tstNSRCGenerator;

interface

uses
 l3IntfUses
 , ddNSRCGenerator
;

type
 ItstNSRCListener = interface
  procedure ExtractFileEvent(const aFileName: AnsiString);
   {* ������� ������� �������� �����. }
 end;//ItstNSRCListener
 
 TtstNSRCGenerator = class(TddNSRCGenerator)
  {* ������� ��� TddGenerator ��� ������ ������ � ������� ������ � ����������� �� � ����� ��� ����������� ��������. }
  procedure LinkNSRCListener(const aListener: ItstNSRCListener);
  procedure UnlinkNSRCListener(const aListener: ItstNSRCListener);
 end;//TtstNSRCGenerator
 
implementation

uses
 l3ImplUses
;

end.
