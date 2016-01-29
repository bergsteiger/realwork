#include "../../../libs/mrglib/src/gdbapi.h"
#include "gardefs.h"
#include <string.h>
#include <stdlib.h>

char *rus_msg[] = {
	"�������� ��������� ������� ������ ",
	"",
	"��������: ����� ������� ������ %d ���.",
	"�� ������� ������� �������� ���� %s.",
	"���� %s �� ������ ����������� ���������.",
	"�������� ������ ���������� ����� ����...", /*5*/
	"�������� ���� ������ : ��� ",
	"1 �� 3",
	"2 �� 3",
	"3 �� 3",
	"���������� ��������� �������� : ��� ", /*10*/
	"1 �� 59",
	"2 �� 59",
	"3 �� 59",
	"4 �� 59",
	"5 �� 59",
	"6 �� 59",
	"7 �� 59",
	"8 �� 59",
	"9 �� 59",
	"10 �� 59",
	"11 �� 59",
	"12 �� 59",
	"13 �� 59",
	"14 �� 59",
	"15 �� 59",
	"16 �� 59",
	"17 �� 59",
	"18 �� 59",
	"19 �� 59",
	"20 �� 59",
	"21 �� 59",
	"22 �� 59",
	"23 �� 59",
	"24 �� 59",
	"25 �� 59",
	"26 �� 59",
	"27 �� 59",
	"28 �� 59",
	"29 �� 59",
	"30 �� 59",
	"31 �� 59",
	"32 �� 59",
	"33 �� 59",
	"34 �� 59",
	"35 �� 59",
	"36 �� 59",
	"37 �� 59",
	"38 �� 59",
	"39 �� 59",
	"40 �� 59",
	"41 �� 59",
	"42 �� 59",
	"43 �� 59",
	"44 �� 59",
	"45 �� 59",
	"46 �� 59",
	"47 �� 59",
	"48 �� 59",
	"49 �� 59",
	"50 �� 59",
	"51 �� 59",
	"52 �� 59",
	"53 �� 59",
	"54 �� 59",
	"55 �� 59",
	"56 �� 59",
	"57 �� 59",
	"58 �� 59",
	"59 �� 59",
	"�������� ������ �������",
	"������ ",
	"�������� �������� �� ����� ���� ������.",
	"�������� ��������� �� ����� ���� �������."
};

char *eng_msg[] = {
	"Garant database splitter. ",
	"",
	"Warning: only %d bases will be built.",
	"Can't open source base %s",
	"Source base %s isn't ready to splitting.",
	"Collecting documents list...",
	"Building database : step ",
	"1 of 3",
	"2 of 3",
	"3 of 3",
	"Building indexes : step ",
	"1 of 59",
	"2 of 59",
	"3 of 59",
	"4 of 59",
	"5 of 59",
	"6 of 59",
	"7 of 59",
	"8 of 59",
	"9 of 59",
	"10 of 59",
	"11 of 59",
	"12 of 59",
	"13 of 59",
	"14 of 59",
	"15 of 59",
	"16 of 59",
	"17 of 59",
	"18 of 59",
	"19 of 59",
	"20 of 59",
	"21 of 59",
	"22 of 59",
	"23 of 59",
	"24 of 59",
	"25 of 59",
	"26 of 59",
	"27 of 59",
	"28 of 59",
	"29 of 59",
	"30 of 59",
	"31 of 59",
	"32 of 59",
	"33 of 59",
	"34 of 59",
	"35 of 59",
	"36 of 59",
	"37 of 59",
	"38 of 59",
	"39 of 59",
	"40 of 59",
	"41 of 59",
	"42 of 59",
	"43 of 59",
	"44 of 59",
	"45 of 59",
	"46 of 59",
	"47 of 59",
	"48 of 59",
	"49 of 59",
	"50 of 59",
	"51 of 59",
	"52 of 59",
	"53 of 59",
	"54 of 59",
	"55 of 59",
	"56 of 59",
	"57 of 59",
	"58 of 59",
	"Splitting process finished successfully",
	"Version ",
	"Error: nonexistent segments selected.",
	"Error: nonexistent segments selected."
};

char **msg_table = rus_msg;
int gsplit_language = 0;

int get_language()
{
	return gsplit_language;
}

void set_language(int lang)
{
	gsplit_language = lang;
	if(lang) msg_table = eng_msg;
	else msg_table = rus_msg;
}

char *get_message(int msg)
{
	if(msg < 0 || msg >= sizeof(rus_msg)/sizeof(*rus_msg)) return 0;
	return msg_table[msg];
}
