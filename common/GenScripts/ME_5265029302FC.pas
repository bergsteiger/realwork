unit kwPopEditorInsertStream;

interface

uses
 l3IntfUses
 , kwInsertFromStreamCommon
 , tfwScriptingInterfaces
;

type
 TkwPopEditorInsertStream = class(TkwInsertFromStreamCommon)
  {* *������:* aFromat file_name anEditorControl pop:editor:InsertStream
*��������:* ��������� ������� �� ������ ������ ������ �� ������� ����������, ��������, ����� � ������� aFromat  �� ����� file_name.
*������:*
[code] 
Test.rtf CF_RTF  focused:control:push pop:editor:InsertStream
[code] }
  function GetFormat(const aCtx: TtfwContext): Integer;
 end;//TkwPopEditorInsertStream
 
implementation

uses
 l3ImplUses
;

end.
