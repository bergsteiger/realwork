rem	����७�� ���ॡ����� ����� � ����ᨬ��� �� ࠧ����� ����⢨�

rem	�������� ����樨 (mem_test_op):
rem 		����⨥_���㬥�⮢
rem		����⨥_ᯨ᪮�
rem		���᪨_��_���
rem		���᪨_��_���_1_���⥪��
rem		�����_������_�����_���짮��⥫��


rem ***************************************************************************

rem	****** ����⨥ ���㬥�⮢ ******

rem	�⠢�� ���� ����ன��
call common.do_clean_settings.bat

rem ��᪠�� ���
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=����⨥_���㬥�⮢ iter_count=350

rem 	****** ���᪨ �� ��� ******

rem	�⠢�� ���� ����ன��
call common.do_clean_settings.bat

rem �⠢�� ��।������ ����ன��
rem

rem ��᪠�� ���
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=���᪨_��_��� iter_count=70

rem 	****** ���᪨ �� ��� � ����� ���⥪�⮬ ******

rem	�⠢�� ���� ����ன��
call common.do_clean_settings.bat

rem �⠢�� ��।������ ����ன��
rem

rem ��᪠�� ���
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=���᪨_��_���_1_���⥪�� iter_count=50

rem 	****** �����/������ 1 ���짮��⥫�� ******

rem	�⠢�� ���� ����ன��
call common.do_clean_settings.bat

rem ��᪠�� ���
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=�����_������_�����_���짮��⥫�� iter_count=50

rem 	****** ����⨥ ᯨ᪮� ******

rem	�⠢�� ���� ����ன��
call common.do_clean_settings.bat

rem ��᪠�� ���
%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=����⨥_ᯨ᪮� iter_count=200

rem 	****** ���뫠�� ���� ******

%TC_PATH% /run /project:MemoryUsing /unit:MemoryUsing /routine:Main /exit /SilentMode "%TC_PROJECT_PATH%\memoryusing.mds" ps_tools_path=%PS_TOOLS_PATH% mem_test_op=��᫠��_����