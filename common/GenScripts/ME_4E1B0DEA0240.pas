unit kwPopEditorRepaintAndCheckWithEtalon;

interface

uses
 l3IntfUses
 , kwEditorFromStackWord
 , tfwScriptingInterfaces
 , evCustomEditorWindow
;

type
 TkwPopEditorRepaintAndCheckWithEtalon = class(TkwEditorFromStackWord)
  {* *��������:*
�������������� �������� �������� ������ �� ������������ ��� ������. ��������� ��������� �������������. ��� ������������ �� ����� ������ ���������! ��������� ���� � ������ NNN.shapes - ��� NNN - ����� ����� (��������! ��� ����� ����� ���������� � TK) . ���� �� ����� �� ������������ �������, �� �� ���������. � ��� ���������� � ����� ��������� �����. ���� ������ ��� �����������, �� ������������ ��������� ����� ������ ����� � ��������. ���� ��������� �� ������, �� �� ���� ����� �������� (���� ����� ��������� �� ���������) � ����� ������� ������� ��������� ��������� ������.
*������:*
[code]
anEditor pop:editor:RepaintCheckWithEtalon 
[code]
��� anEditor - ��������� �� ��������, � ������� ����� ������� �����������.
*������:*
[code]
focused:control:push pop:editor:RepaintCheckWithEtalon 
[code]
�������� ��������� � ���������, ��� ��������� �����. }
  procedure DoWithEditor(const aCtx: TtfwContext;
   anEditor: TevCustomEditorWindow);
 end;//TkwPopEditorRepaintAndCheckWithEtalon
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , nevTools
;

end.
