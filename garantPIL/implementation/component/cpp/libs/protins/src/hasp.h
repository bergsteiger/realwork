#ifndef __HASP_H_
#define __HASP_H_

#ifdef __cplusplus
extern "C" {
#endif

// �訡��
#define ERR_NOERROR	0	// ��� �訡��
#define ERR_NOHASP	-1	// HASP �� ������
#define ERR_READHASP	-2	// �訡�� �⥭�� HASP
#define ERR_WRITEHASP	-3	// �訡�� ����� HASP
#define ERR_BADHASP	-4	// HASP �� ᮤ�ন� �㦭�� ᨣ������
#define ERR_BADREQUEST	-5	// ���ࠢ���� ��ࠬ��� "⨯ �����"
#define ERR_OVERFLOW	-6	// ��९������� ���稪�
#define ERR_NOTINLIST	-7	// �த�� �� ������ � ᯨ᪥

int FindHasp(void);
int IncreaseCounter(char *Product, int CopyType);
int CheckCounter(char *Product, int CopyType);

#ifdef __cplusplus
}
#endif

#endif	// #ifndef __HASP_H_

