#include <assert.h>
#include <stdio.h>
#include <string.h>
#ifndef _WINDOWS
	#include <strings.h>
#endif //_WINDOWS
#include <stdlib.h>
#include "rtfwrite.h"
#include "garutils.h"


static unsigned char Dos2Win [ 256 ] = {
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0xA4, // 0 -15
	 '>',  '<', 0x12, 0x13, 0xB6, 0xA7, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D,  '^',  124, // 16-31
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, // 32-47
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, // 48-63
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, // 64-79
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, // 80-95
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, // 96-
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F, // 112-
	0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xCB, 0xCC, 0xCD, 0xCE, 0xCF, // 128-
	0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xDB, 0xDC, 0xDD, 0xDE, 0xDF, // 144-
	0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF, // 160-
	 151,  151,  151,  124,  124,  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,   32, // 176-
	  32,  151,  151,  124,  151,  124,  151,  151,  151,  151,  151,  151,  151,  151,  151,  151, // 192-
	 151,  151,  151,  151,  151,  151,  151,  151,  151,   32,   32,  151,  151, 0xA6,  151,  151, // 208-
	0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF, // 224-
	 151, 0xB1,  151,  151,  151,  151,  151,  151, 0xB0, 0xB7, 0xB7,  151, 0x6E, 0xB2, 0xA8,  151 }; // 240

/*
	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0xA4, // 0 -15
	0x10, 0x11, 0x12, 0x13, 0xB6, 0xA7, 0x16, 0x17, 0x18, 0x19, 0x1A, 0x1B, 0x1C, 0x1D, 0x1E, 0x1F, // 16-31
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, // 32-47
	0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x3A, 0x3B, 0x3C, 0x3D, 0x3E, 0x3F, // 48-63
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, // 64-79
	0x50, 0x51, 0x52, 0x53, 0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, 0x5D, 0x5E, 0x5F, // 80-95
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, // 96-
	0x70, 0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, 0x7E, 0x7F, // 112-
	0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xC5, 0xC6, 0xC7, 0xC8, 0xC9, 0xCA, 0xCB, 0xCC, 0xCD, 0xCE, 0xCF, // 128-
	0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5, 0xD6, 0xD7, 0xD8, 0xD9, 0xDA, 0xDB, 0xDC, 0xDD, 0xDE, 0xDF, // 144-
	0xE0, 0xE1, 0xE2, 0xE3, 0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9, 0xEA, 0xEB, 0xEC, 0xED, 0xEE, 0xEF, // 160-
	0x5F, 0x5F, 0x5F, 0xA6, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, // 176-
	0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, // 192-
	0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0xA6, 0x5F, 0x5F, // 208-
	0xF0, 0xF1, 0xF2, 0xF3, 0xF4, 0xF5, 0xF6, 0xF7, 0xF8, 0xF9, 0xFA, 0xFB, 0xFC, 0xFD, 0xFE, 0xFF, // 224-
	0x5F, 0xB1, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0x5F, 0xB0, 0xB7, 0xB7, 0x5F, 0x6E, 0xB2, 0xA8, 0x5F }; // 240
*/

RTFWriter::RTFWriter(RTFCharSet new_charset) : char_set(new_charset), 
		font_count(0), color_count(0), font_list(0), color_list(0)
{
	status = ST_NORTFSTART;
}

RTFWriter::~RTFWriter()
{
	for (int i = 0; i < font_count; i++)
		if (font_list[i].font_name) free(font_list[i].font_name);
	if (font_list) free(font_list);
	if (color_list) free(color_list);
}

int RTFWriter::StartRTF()
{
	char start[50]="{\\rtf";

	if (GetStatus() != ST_NORTFSTART)
		return 1;
	switch (char_set) {
		case CS_ANSI:
			strcat(start, "\\ansi ");
			break;
		case CS_MAC:
			strcat(start, "\\mac ");
			break;
		case CS_PC:
			strcat(start, "\\ps ");
			break;
		case CS_PCA:
			strcat(start, "\\pca ");
			break;
	}
	RawWrite(start, strlen(start));
	status = ST_NOFONTTABLE;
	return 0;
}	

int RTFWriter::FinishRTF()
{
	char end[] = "}";
	
	if (GetStatus() != ST_OK)
		return 1;
	RawWrite(end, sizeof(end)-1);
	return 0;
}
	

int RTFWriter::OpenFontTable()
{
	char start[] = "{\\fonttbl ";
	if (GetStatus() != ST_NOFONTTABLE)
		return 1;
	RawWrite(start, sizeof(start)-1);
	status = ST_OPENEDFONTTABLE;
	return 0;
}

int RTFWriter::CloseFontTable()
{
	char end[] = "}";
	if (GetStatus() != ST_OPENEDFONTTABLE)
		return 1;
	RawWrite(end, sizeof(end)-1);
	status = ST_NOCOLORTABLE;
	return 0;
}

int RTFWriter::AddFont(RTFFontFamily font_family, int font_charset,
	const char *font_name)
{
	char buffer[100];
	char fam[10];

	if (GetStatus() != ST_OPENEDFONTTABLE)
		return -1;
	if (!font_count)
		font_list = (RTFFont *) malloc(sizeof(RTFFont));
	else
		font_list = (RTFFont *) realloc(font_list, 
			(font_count+1)*sizeof(RTFFont));
	font_list[font_count].font_family = font_family;
	font_list[font_count].font_charset = font_charset;
	font_list[font_count].font_name = strdup(font_name);
	switch (font_family) {
		case FF_NIL_:
			strcpy(fam, "\\fnil");
			break;
		case FF_ROMAN_:
			strcpy(fam, "\\froman");
			break;
		case FF_SWISS_:
			strcpy(fam, "\\fswiss");
			break;
		case FF_MODERN_:
			strcpy(fam, "\\fmodern");
			break;
	}
	sprintf(buffer, "{\\f%d%s\\fcharset%d %s;}", font_count,
		fam, font_charset, font_name);
	RawWrite(buffer, strlen(buffer));
	font_count++;
	return font_count-1;
}

int RTFWriter::OpenColorTable()
{
	char start[] = "{\\colortbl;";
	if (GetStatus() != ST_NOCOLORTABLE)
		return 1;
	RawWrite(start, sizeof(start)-1);
	status = ST_OPENEDCOLORTABLE;
	return 0;
}

int RTFWriter::AddColor(char R, char G, char B)
{
	char buffer[100];

	if (GetStatus() != ST_OPENEDCOLORTABLE)
		return -1;
	if (!color_list)
		color_list = (RTFColor *)malloc(sizeof(RTFColor));
	else
		color_list = (RTFColor *)realloc(color_list, 
				(color_count+1)*sizeof(RTFColor));
	color_list[color_count].r = R;
	color_list[color_count].g = G;
	color_list[color_count].b = B;
	sprintf(buffer, "\\red%d\\green%d\\blue%d;", R, G, B);
	RawWrite(buffer, strlen(buffer));
	color_count++;
	return color_count-1;
}

int RTFWriter::CloseColorTable()
{
	char end[] = "}";
	if (GetStatus() != ST_OPENEDCOLORTABLE)
		return 1;
	RawWrite(end, sizeof(end)-1);
	status = ST_NOINFO;
	return 0;
}

int RTFWriter::OpenInfo()
{
	char start[] = "{\\info";
	if (GetStatus() != ST_NOINFO)
		return 1;
	RawWrite(start, sizeof(start)-1);
	status = ST_OPENEDINFO;
	return 0;
}

int RTFWriter::SetDocTitle(const char *title)
{
	char start[] = "{\\title ";
	char end[] = "}";

	if (GetStatus() != ST_OPENEDINFO)
		return 1;
	RawWrite(start, sizeof(start)-1);
	Write(title, strlen(title));
	RawWrite(end, sizeof(end)-1);
	return 0;
}

int RTFWriter::SetDocAuthor(const char *author)
{
	char start[] = "{\\author ";
	char end[] = "}";

	if (GetStatus() != ST_OPENEDINFO)
		return 1;
	RawWrite(start, sizeof(start)-1);
	Write(author, strlen(author));
	RawWrite(end, sizeof(end)-1);
	return 0;
}

int RTFWriter::CloseInfo()
{
	char end[] = "}";
	if (GetStatus() != ST_OPENEDINFO)
		return 1;
	RawWrite(end, sizeof(end)-1);
	status = ST_OK;
	return 0;
}

int RTFWriter::OutputPara(const char *text, int font, int font_size, 
	RTFFontStyle font_style,
	int color, RTFParaStyle style,
	int leftMargin, int rightMargin, int firstMargin, char isSBSPara)
{
	int ret;

	if (GetStatus() != ST_OK)
		return 1;
	OpenPara(leftMargin, rightMargin, firstMargin, style, isSBSPara);
	ret = OutputParaText(text, font, font_size, font_style, color);
	ClosePara();
	return ret;
}

int RTFWriter::OpenPara(int leftMargin, int rightMargin, int firstMargin,
	RTFParaStyle style, char isSBSPara)
{
	char buffer[100];
	char *ptr = buffer;

	if (GetStatus() != ST_OK)
		return 1;
	ptr += sprintf(buffer, "\\par\\pard");
	switch (style) {
		case PA_LEFT:
			ptr += sprintf(ptr, "\\ql");
			break;
		case PA_RIGHT:
			ptr += sprintf(ptr, "\\qr");
			break;
		case PA_JUST:
			ptr += sprintf(ptr, "\\qj");
			break;
		case PA_CENTER:
			ptr += sprintf(ptr, "\\qc");
			break;
	}
	ptr += sprintf(ptr, "\\plain");
	if (leftMargin)
		ptr += sprintf(ptr, "\\li%d", leftMargin);
	if (rightMargin)
		ptr += sprintf(ptr, "\\ri%d", rightMargin);
	if (firstMargin)
		ptr += sprintf(ptr, "\\fi%d", firstMargin);
	if (isSBSPara)
		ptr += sprintf(ptr, "\\tqr\\tx8640");
	RawWrite(buffer, strlen(buffer));
	status = ST_OPENEDPARA;
	return 0;
}
	
int RTFWriter::ClosePara()
{
	char end[] = "}";

	if (GetStatus() != ST_OPENEDPARA)
		return 1;
//	RawWrite(end, sizeof(end)-1);
	status = ST_OK;
	return 0;
}
	
int RTFWriter::OutputParaText(const char *text, int font, int font_size, 
	RTFFontStyle font_style, int color)
{
	char buffer[8000];
	char *ptr = buffer; 

	Recode((char *)text);

	if (GetStatus() != ST_OPENEDPARA)
		return 1;
	if (font >= font_count)
		return 2;
	if (color >= color_count)
		return 3;
	ptr += sprintf(buffer, "{\\f%d\\cf%d", font, color+1);
	if (font_size) ptr += sprintf(ptr, "\\fs%d", font_size*2);

	switch(font_style) {
		case FS_NORMAL:
				ptr += sprintf(ptr, "\\ulnone\\i0\\b0");
				break;
		case FS_STRIKE:
				ptr += sprintf(ptr, "\\strike\\i0\\b0");
				break;
		case FS_ITALIC:
				ptr += sprintf(ptr, "\\ulnone\\i\\b0");
				break;
		case FS_BOLD:
				ptr += sprintf(ptr, "\\ulnone\\i0\\b");
				break;
		case FS_UNDER:
				ptr += sprintf(ptr, "\\ul\\i0\\b0");
				break;
		case FS_BOLDITALIC:
				ptr += sprintf(ptr, "\\ulnone\\i\\b");
				break;
		case FS_ITALICUNDER:
				ptr += sprintf(ptr, "\\ul\\i\\b0");
				break;
		case FS_BOLDUNDER:
				ptr += sprintf(ptr, "\\ul\\b\\i0");
				break;
		case FS_BOLDITALICUNDER:
				ptr += sprintf(ptr, "\\ul\\b\\i");
				break;
		case FS_STRIKEITALIC:
				ptr += sprintf(ptr, "\\strike\\i\\b0");
				break;
		case FS_STRIKEBOLD:
				ptr += sprintf(ptr, "\\strike\\i0\\b");
				break;
		case FS_STRIKEUNDER:
				ptr += sprintf(ptr, "\\strike\\ul\\i0\\b0");
				break;
		case FS_STRIKEBOLDITALIC:
				ptr += sprintf(ptr, "\\strike\\ulnone\\i\\b");
				break;
		case FS_STRIKEITALICUNDER:
				ptr += sprintf(ptr, "\\strike\\ul\\i\\b0");
				break;
		case FS_STRIKEBOLDUNDER:
				ptr += sprintf(ptr, "\\strike\\ul\\b\\i0");
				break;
		case FS_STRIKEBOLDITALICUNDER:
				ptr += sprintf(ptr, "\\strike\\ul\\b\\i");
				break;

	}
	
	if (*buffer != ' ') {
		ptr += sprintf(ptr," ");
	}
	RawWrite(buffer, strlen(buffer));
	int len = strlen(text);
	Write(text, len);
	strcpy(buffer, "}{}");
	//sprintf(buffer, "}{}");
	RawWrite(buffer, strlen(buffer));
	return 0;
}

int RTFWriter::Write(const char *buff, int size)
{
	const unsigned char* buf = (const unsigned char*)buff;
	char *buffer;

#ifdef	__WIN16__
	buffer = (char *)malloc(65000);
#else
	buffer = (char *)malloc(size*5);
#endif
	assert(buffer);	
	int pos = 0;

	for (int i = 0; i < size; i++) {
		if (buf[i] < 127 && buf[i] != 16 && buf[i] != 17 && buf[i] != 30 && buf[i] != 31 ) { 
			if ((buf[i] == '}') || (buf[i] == '{' ) || (buf[i] == '\\')) {
				buffer[pos] = '\\';
				pos ++;
			}
			if (buf[i] != '\t') {
				buffer[pos] = buf[i];
				pos ++;
			} else {
				pos += sprintf(buffer+pos, "\\tab ");
			}
		} else { // need decode russian
			unsigned char sym = buf[i];
#ifndef	__FreeBSD__
#ifndef	__WIN32__
			sym = Dos2Win[sym];
#endif
#endif
			pos += sprintf(buffer+pos, "\\'%2x", sym);
		}
	}
	assert(buffer);
	RawWrite(buffer, pos);
	free(buffer);
	return 0;
}

void RTFWriter::Recode(char* buf) {
#ifndef	__WIN16__
	Str2Win(buf);
#endif
}
