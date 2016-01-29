// CommonLang.ms.tpl
// ������� ��������� ��� "������������ ������"

USES
 Documentation.ms.dict
 NoStrangeSymbols.ms.dict
 arrays.ms.dict
 Generation.ms.dict
;

elem_proc DumpAsIs
 %SUMMARY '��������� ���������� ���������� �������� ������. ����������.' ;

 [
  g_CurrentGeneratorName ':'
   %REMARK '������� ��� �������� ����������. ��� �������' 
  for ( Self LIST %ST Reverted ) .Name
   %REMARK '������� ��������� ��������, ����������'
  Self .Name 
   %REMARK '������� ��� ��������'
 ] ' ' strings:CatSep OutToFile
 [
  '�������� �������� '
  for ( Self .Parents >reverted> ) .Name
  %REMARK '������� ��������� ��������, ����������'
 ] '::' strings:CatSep OutToFile
 for ( Self .Inherited ) ( .Name OutToFile )
 for ( Self .Implements ) ( .Name OutToFile )
 TRY
  Self .CallChildrenCurrentGen
  %REMARK '������� ����� ��������, ��� �� ����� �����������'
 FINALLY
  [ '; // ' Self .Name ] OutToFile
  %REMARK '������� ����������� ������ ��������'
 END
; // DumpAsIs

elem_generator dump
 %SUMMARY '��������� ��������� ���� �������� ������.' ;
 %GEN_PROPERTY Name 'dump'
 %REMARK '��� ���������� � ���������� ����� �������� �����. ����� �� ������� ���, ����� ��� ����� �� ���������'

 Self .DumpAsIs
 %REMARK '���� ������� �� "��� ����", ��� ������������� � ������� ����'
; // dump

elem_generator pas
 %SUMMARY '��������� ��������� �������� ������ � �������.' ;
 %GEN_PROPERTY Name 'pas'
 %REMARK '��� ���������� � ���������� ����� �������� �����. ����� �� ������� ���, ����� ��� ����� �� ���������'

 Self .DumpAsIs
 %REMARK '���� ������� �� "��� ����", ��� ������������� � ������� ����'
; // pas

elem_generator script
 %SUMMARY '��������� ��������� �������� ������ � ms.script.' ;
 %GEN_PROPERTY Name 'ms.script'
 %REMARK '��� ���������� � ���������� ����� �������� �����. ����� �� ������� ���, ����� ��� ����� �� ���������'

 Self .DumpAsIs
 %REMARK '���� ������� �� "��� ����", ��� ������������� � ������� ����'
; // script

elem_generator c++
 %SUMMARY '
 ��������� ��������� �������� ������ � c++. 
 ��� ����� *.h �� ����� ��������� ��������.
 ' ;
 %GEN_PROPERTY Name 'cpp'
 %REMARK '��� ���������� � ���������� ����� �������� �����. ����� �� ������� ���, ����� ��� ����� �� ���������'

 Self .DumpAsIs
 %REMARK '���� ������� �� "��� ����", ��� ������������� � ������� ����'
; // c++

elem_generator h
 %SUMMARY '
 ��������� ��������� �������� ������ � *.h. 
 ��� ����� *.h �� ����� ��������� ��������.
 ' ;
 %GEN_PROPERTY Name 'h'
 %REMARK '��� ���������� � ���������� ����� �������� �����. ����� �� ������� ���, ����� ��� ����� �� ���������'

 Self .DumpAsIs
 %REMARK '���� ������� �� "��� ����", ��� ������������� � ������� ����'
; // h
