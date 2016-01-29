#ifndef __HASP_H_
#define __HASP_H_

#ifdef __cplusplus
extern "C" {
#endif

// Ошибки
#define ERR_NOERROR	0	// Нет ошибок
#define ERR_NOHASP	-1	// HASP не найден
#define ERR_READHASP	-2	// Ошибка чтения HASP
#define ERR_WRITEHASP	-3	// Ошибка записи HASP
#define ERR_BADHASP	-4	// HASP не содержит нужной сигнатуры
#define ERR_BADREQUEST	-5	// Неправильный параметр "тип копии"
#define ERR_OVERFLOW	-6	// Переполнение счетчика
#define ERR_NOTINLIST	-7	// Продукт не найден в списке

int FindHasp(void);
int IncreaseCounter(char *Product, int CopyType);
int CheckCounter(char *Product, int CopyType);

#ifdef __cplusplus
}
#endif

#endif	// #ifndef __HASP_H_

