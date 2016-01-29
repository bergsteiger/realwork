#include <string.h>
#include <stdio.h>
#include <dos.h>

#include "hasp.h"
#include "labels.h"
#include "haspdefs.h"

extern hasp (int,int,int,int,int,int *,int *,int *,int *);

int     SeedCode;
static int     Pass1 = 12139;
static int     Pass2 = 9019;
int     p1, p2, p3, p4;
int	KeyType;

#define	PRODUCT_COUNT	25

char sProducts [PRODUCT_COUNT] [9] = {
	"MAXIMUM",
	"MASTER",
	"UNIVERSL",
	"CLASSIC",
	"CPRAKTIK",
	"MEDICINE",
	"ENGONE",
	"PROFESNL",
	"EMIS",
	"BUS&LAW",
	"CLASSICP",
	"UNIVERSP",
	"EXPERT",
	"ENGTWO",
	"ENGTHR",
	"UNIVCONS",
	"PROFCONS",
	"MASTCONS",
	"MAXICONS",
	"SMAXIMUM",
	"CPRACONS",
	"EXPECONS",
	"ENGFOU",
	"ENGFIV",
	"ENGSIX"
	};

int iProductID [PRODUCT_COUNT] =
	{20, 21, 22, 23, 24, 25, 10, 26, 15, 12, 0,1,2, 3,4, 5,6,7,8,9, 11, 13, 14,16,17 };

int GetProductID (char *Product)
	{
	int i;

	for (i = 0; i < PRODUCT_COUNT; i++)
		if (!strcmpi (Product, sProducts [i]))
			return iProductID [i];

	return -1;
	}

int	FindHasp (void)
	{
	int	LptNum = 0;

	hasp(IS_HASP, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (!p1)
		{
		hasp(IS_HASP, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
		if (!p1)
			return ERR_NOHASP;
		}

	p1 = CONTROL_CELL;
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p2 != CONTROL_VALUE)
		return ERR_BADHASP;

	return ERR_NOERROR;
	}

int IncreaseCount (int ComplectID, int CopyType)
	{
	int		LptNum = 0;
	unsigned int	val1, val2;
	unsigned int	cLoc, cNet, cOne, cVB;

	hasp(IS_HASP, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (!p1)
		{
		hasp(IS_HASP, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
		if (!p1)
			return ERR_NOHASP;
		}

	p1 = CONTROL_CELL;
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p2 != CONTROL_VALUE)
		return ERR_BADHASP;

	p1 = (3 * ComplectID) / 2;  /* Address */
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	val1 = p2;

	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	if (val1 != p2)
		return ERR_READHASP;

	p1 = (3 * ComplectID) / 2 + 1;  /* Address */
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	val2 = p2;

	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	if (val2 != p2)
		return ERR_READHASP;

	if (ComplectID % 2)
		{
		cLoc = val1 & 0xFF;
		cNet = (val2 & 0xFF00) >> 8;
		cOne = (val2 & 0x00F0) >> 4;
		cVB = val2 & 0x000F;
		}
	else
		{
		cLoc = (val1 & 0xFF00) >> 8;
		cNet = val1 & 0xFF;
		cOne = (val2 & 0xF000) >> 12;
		cVB = (val2 & 0x0F00) >> 8;
		}
	switch (CopyType)
		{
		case LABEL_LOC:
			cLoc++;
			if (cLoc > 255)
			  return ERR_OVERFLOW;
			break;
		case LABEL_NET:
			cNet++;
			if (cNet > 255)
			  return ERR_OVERFLOW;
			break;
		case LABEL_ONE:
			cOne++;
			if (cOne > 15)
			  return ERR_OVERFLOW;
			break;
		case LABEL_VB:
			cVB++;
			if (cVB > 15)
			  return ERR_OVERFLOW;
			break;
		}

	if (ComplectID % 2)
		{
		val1 = (val1 & 0xFF00) + cLoc;
		val2 = cNet * 0x100 + cOne * 0x10 + cVB;
		}
	else
		{
		val1 = cLoc * 0x100 + cNet;
		val2 = (val2 & 0xFF) + 0x100 * (cOne * 0x10 + cVB);
		}

	p1 = (3 * ComplectID) / 2;  // Address
	p2 = val1;
	hasp(WRITE_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_WRITEHASP;
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	if (p2 != val1)
		return ERR_WRITEHASP;

	p1 = (3 * ComplectID) / 2 + 1;  // Address
	p2 = val2;
	hasp(WRITE_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_WRITEHASP;
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	if (p2 != val2)
		return ERR_WRITEHASP;

	return ERR_NOERROR;
	}

int CheckCount (int ComplectID, int CopyType)
	{
	int		LptNum = 0;
	unsigned int	val1, val2;
	unsigned int	cLoc, cNet, cOne, cVB;

	hasp(IS_HASP, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (!p1)
		{
		hasp(IS_HASP, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
		if (!p1)
			return ERR_NOHASP;
		}

	p1 = CONTROL_CELL;
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p2 != CONTROL_VALUE)
		return ERR_BADHASP;

	p1 = (3 * ComplectID) / 2;  /* Address */
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	val1 = p2;

	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	if (val1 != p2)
		return ERR_READHASP;

	p1 = (3 * ComplectID) / 2 + 1;  /* Address */
	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	val2 = p2;

	p2 = 0;
	hasp(READ_MEMO, SeedCode, LptNum, Pass1, Pass2, &p1, &p2, &p3, &p4);
	if (p3 != 0)
		return ERR_READHASP;
	if (val2 != p2)
		return ERR_READHASP;

	if (ComplectID % 2)
		{
		cLoc = val1 & 0xFF;
		cNet = (val2 & 0xFF00) >> 8;
		cOne = (val2 & 0x00F0) >> 4;
		cVB = val2 & 0x000F;
		}
	else
		{
		cLoc = (val1 & 0xFF00) >> 8;
		cNet = val1 & 0xFF;
		cOne = (val2 & 0xF000) >> 12;
		cVB = (val2 & 0x0F00) >> 8;
		}
	switch (CopyType)
		{
		case LABEL_LOC:
			cLoc++;
			if (cLoc > 255)
			  return ERR_OVERFLOW;
			break;
		case LABEL_NET:
			cNet++;
			if (cNet > 255)
			  return ERR_OVERFLOW;
			break;
		case LABEL_ONE:
			cOne++;
			if (cOne > 15)
			  return ERR_OVERFLOW;
			break;
		case LABEL_VB:
			cVB++;
			if (cVB > 15)
			  return ERR_OVERFLOW;
			break;
		}

	return ERR_NOERROR;
	}

int	IncreaseCounter (char *Product, int CopyType)
	{
	int ProdID;

	ProdID = GetProductID (Product);
	if (-1 == ProdID)
		return ERR_NOTINLIST;

	return IncreaseCount (ProdID, CopyType);
	}

int	CheckCounter (char *Product, int CopyType)
	{
	int ProdID;

	ProdID = GetProductID (Product);
	if (-1 == ProdID)
		return ERR_NOTINLIST;

	return CheckCount (ProdID, CopyType);
	}
