unit kwPopEditorPasteRTF;

interface

uses
 l3IntfUses
 , kwInsertFromStreamCommon
 , tfwScriptingInterfaces
;

type
 TkwPopEditorPasteRTF = class(TkwInsertFromStreamCommon)
  {* *������:* rtf_file_name anEditorControl pop:editor:PasteRTF
*��������:* ��������� ������� �� ������ ������ ������ �� ������� ����������, ��������, ����� � ������� RTF �� ����� rtf_file_name.
*������:*
[code] 
Test.rtf  focused:control:push pop:editor:PasteRTF
[code] }
  function GetFormat(const aCtx: TtfwContext): Integer;
 end;//TkwPopEditorPasteRTF
 
implementation

uses
 l3ImplUses
 , evTypes
 , Windows
;

end.
