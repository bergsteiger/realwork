#include "ace/ACE.h"
#include "Garant/GblAdapter/GblAdapter.h"
#include "helpers/logs.h"
#include <map>
#include <conio.h>
#include <stdexcept>
#include <time.h>
#include <TLHELP32.H>
#include <process.h>
#include <string.h>
#include "etalontest.h"
#include "FragmentList_i.h"

#include "autotest.h"


int main(int argc, char* argv[])
{	
	AutoTest* test;
	if (argc<2)
	{
		LOG_D(("File created: %s", RESULT_FILE));
		LOG_D(("LoadAdapter;TestStruct;test_TextDocument;test_Search_by_Date;test_GetList_by_Date;test_Search_by_Frase;test_GetList_by_Fraze;test_EmptySearch;test_GetList_by_EmptyQuery;test_Search_by_Attr;test_GetList_by_Attr;test_CreateSettings;test_ReadSettings;test_ReWriteSettings"));
		try {
			test= new AutoTest("Etalon", "Etalon");
		} catch (...) {
			return -1;
		}
		if (!test->is_connected())
			return 0;
		test->Set_Number(10164072);
		test->test_TextDocument(); //����� ����� �������� ������ � ���������
									//� ������������ ����� �������� ��������
		Sleep(1000);
		test->test_GetList_by_search(test->test_Search_by_Date());
		Sleep(1000);
		test->test_GetList_by_search(test->test_Search_by_Frase());
		Sleep(1000);
		test->test_GetList_by_search(test->test_EmptySearch());
		Sleep(1000);
		test->test_GetList_by_search(test->test_Search_by_Attr());
		//Sleep(1000);
		test->test_CreateSettings();
		Sleep(1000);
		test->test_ReadSettings();
		Sleep(1000);
		test->test_ReWriteSettings();
		test->EndWriteTime();
		delete test;
		gbladapter_done();

		printf("Press any key...");
		_getch();
	} else {
		int n_test = atoi(argv[1]);
		switch (n_test)
		{
			case -1:	//����� �� ��������� ������������ ������������
				{
					try {
					test= new AutoTest("Etalon", "Etalon");
					} catch (...) {
						return -1;
					}
					test->Set_Number(10164072);
					test->test_TextDocument(); //����� ����� �������� ������ � ���������
												//� ������������ ����� �������� ��������
					Sleep(1000);
					test->test_GetList_by_search(test->test_Search_by_Date());
					Sleep(1000);
					test->test_GetList_by_search(test->test_Search_by_Frase());
					Sleep(1000);
					test->test_GetList_by_search(test->test_EmptySearch());
					Sleep(1000);
					delete test;
					gbladapter_done();

					printf("Press any key...");
					_getch();
					break;
				}
			case -2:	//����� �� ��������� ������������ ������������
				{
					try {
					test= new AutoTest("Etalon", "Etalon");
					} catch (...) {
						return -1;
					}
					test->test_GetList_by_search(test->test_Search_by_Attr());
					Sleep(1000);
					test->test_CreateSettings();
					Sleep(1000);
					test->test_ReadSettings();
					Sleep(1000);
					test->test_ReWriteSettings();
					delete test;
					gbladapter_done();

					printf("Press any key...");
					_getch();
					break;
				}
			case 1:	//���� �������� ��������� ��
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->Set_Number(10164072);
				test->test_Struct();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 2:	//���� �������� ������ ��
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->Set_Number(10164072);
				test->test_TextDocument();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 3:	//���� �������� ������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_Search_by_Date();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 4:	//���� �������� ������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_Search_by_Attr();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 5:	//���� ����������� ������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_Search_by_Frase();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 6:	//���� ��������� �������������� ������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_GetList_by_search(test->test_Search_by_Attr());
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 7:	//���� ��������� ������ ���� ����������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_GetList_by_search(test->test_EmptySearch());
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 8:	//���� �������� ����� ��������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_CreateSettings();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 9:	//���� ���������� ����� ��������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 10:	//���� ������ ����� ��������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_ReadSettings();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}
			case 11:	//���� �������� ��������
			{
				try {
					test= new AutoTest("Etalon", "Etalon");
				} catch (...) {
						return -1;
				}
				test->test_LoadAdapter();
				delete test;
				gbladapter_done();

				printf("Press any key...");
				_getch();
				break;
			}

		}
	}
	return 0;
}