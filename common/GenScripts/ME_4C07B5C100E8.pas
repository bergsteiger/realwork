unit EVDWriterTest;

interface

uses
 l3IntfUses
 , WriterTest
 , evdNativeReader
;

type
 TEVDWriterTest = class(TWriterTest)
  procedure EVDtoEVD(const aFileName: AnsiString);
  function UseFullEVDReader: Boolean;
   {* ������������ �� ������ evdReader (� ������� ������ ����) }
  function DisableParserLog: Boolean;
   {* ��������� ������� �������� � ��� }
 end;//TEVDWriterTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
 , SysUtils
 , evEvdRd
 , l3Parser
;

end.
