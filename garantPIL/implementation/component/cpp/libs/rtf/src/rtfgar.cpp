#include "rtfgar.h"
#include "gardefs.h"
#ifdef	__FreeBSD__
#include <stdlib.h>
#else
#include "malloc.h"
#endif

#define COEFF 97

int GRTFWriter::Attach(RTFWriter* new_rtf)
{
	rtf = new_rtf;
	return 0;
}

RTFWriter* GRTFWriter::Detach()
{
	RTFWriter *ret;
	ret = rtf;
	rtf = 0;
	return ret;
}

void GRTFWriter::AddAllColors()
{
#ifdef	GKGETRTF
	color_regular   = rtf->AddColor(0, 0, 0);				// text
	color_color     = rtf->AddColor(0, 0, char(127));		// color emphasis
	color_abolished = rtf->AddColor(127, 127, 127);			// abolished text
	color_link      = rtf->AddColor(0, char(127), 0);		// link
	color_comm      = rtf->AddColor(char(127),0, char(127));// comments
#else
	color_regular   = rtf->AddColor(0, 0, 0);		  // text
	color_color     = rtf->AddColor(0, 0, char(255)); // color emphasis
	color_abolished = rtf->AddColor(125, 125, 125);   // abolished text
	color_link      = rtf->AddColor(0, char(255), 0); // link
	color_comm      = rtf->AddColor(0, char(255), 0); // comments
#endif
}

void GRTFWriter::AddAllFonts()
{
	font_fixed = rtf->AddFont(RTFWriter::FF_ROMAN_, 204, "Courier New");
	font_non = rtf->AddFont(RTFWriter::FF_ROMAN_, 204, "Times New Roman");
}

int GRTFWriter::StartRTF(const char *title, const char *author)
{
	if (!rtf) return 1;
	rtf->StartRTF();
	rtf->OpenFontTable();
	AddAllFonts();
	rtf->CloseFontTable();

	rtf->OpenColorTable();
	AddAllColors();
	rtf->CloseColorTable();

	rtf->OpenInfo();
	rtf->SetDocTitle(title);
	rtf->SetDocAuthor(author);
	rtf->CloseInfo();
	return 0;
}

int GRTFWriter::AddParaText(const char *text, unsigned len, GRTFPara style, 
	int leftMargin, int rightMargin, int firstMargin)
{
	char *buffer;
	int pos = 0;
	int current_color = color_regular;
	char stack[10];
	int stack_pos = 0;
	int link_start = 0;
	RTFWriter::RTFParaStyle rtf_style;
	RTFWriter::RTFFontStyle font_style = RTFWriter::FS_NORMAL;	
	char is_sbs = 0;
	int font_cur;
	int font_size;
	int buffer_len = len+1;

	if (!rtf) return 1;

	buffer = new char[len+1];

	GetStyleTrans(style, rtf_style, is_sbs);
	rtf->OpenPara(leftMargin*COEFF, rightMargin*COEFF, firstMargin*COEFF, rtf_style, is_sbs);
	GetColorTrans(C_PLAIN, font_cur, font_size, font_style, current_color);
#ifdef	GKGETRTF
	if ( style == GP_PREF )
	{

		font_cur = font_fixed;
		font_size = 8;
	}
#endif
	while (len--) {
		if ((unsigned char)(*text) > 6) {
			buffer[pos] = *text;
			pos++;
		} else {
			buffer[pos] = 0;
			rtf->OutputParaText(buffer, font_cur, font_size,  font_style, current_color);
			pos = 0;
			if (stack_pos) {
				if (stack[stack_pos-1] == *text) {
					stack_pos --;
				} else {
					stack[stack_pos] = *text;
					stack_pos ++;
				}
			} else {
				stack[stack_pos] = *text;
				stack_pos ++;
			}
			GetColorTrans(stack_pos ? (GRTFColor)stack[stack_pos-1] : C_PLAIN, font_cur, font_size, font_style, current_color);	
		#ifdef	GKGETRTF
			if ( style == GP_PREF )
			{

				font_cur = font_fixed;
				font_size = 8;
			}
		#endif
			if (*text == C_LINK) {
				if (link_start) {
					text++;
					len --;
					switch(*text) {
						case REFTYPE_REFLIST: {
							text++;
							len--;
							short ref_len = * (short *)text;
							text += sizeof(short);
							len -= sizeof(short);
							if (!ref_len) ref_len++;
							text += sizeof(Ref)*ref_len;
							len -= sizeof(Ref)*ref_len;
							break;
							}
						case REFTYPE_BLOB:
							{
							text++;
							len--;
							short blob_len = * (short *)text;
							text += sizeof(short);
							len -= sizeof(short);
							if (!blob_len) blob_len++;
							text += sizeof(ObjKey)*blob_len;
							len -= sizeof(ObjKey)*blob_len;
								
							break;
							}
						
						case REFTYPE_CLASS:
							while ((*text ++) && (len > 1)) len--;
							break;
					}
					text --; // workaround forward text++
					len ++;
					/*
					if (*(text+1)) {	// if next to space add one more
						buffer[pos] = ' ';
						pos ++;
					}
					*/
					link_start = 0;
				} else {
					link_start = 1;
				}
			}
		}
		text ++;
	}
	buffer[pos] = 0;
	rtf->OutputParaText(buffer, font_cur, font_size, font_style, current_color);

	rtf->ClosePara();
	delete buffer;
	return 0;
}

int GRTFWriter::AddCorePara(const char *para)
{
//	ParaHeader* head = (ParaHeader *)para;
	GRTFPara style;
	int lm, rm, lrm;

	lm = para[5];
	rm = para[6];
	lrm = para[7];

	switch(*para) {
		case PS_PREFORMATTED:
			style = GP_PREF;
			break;
		case PS_CENTERED:
			style = GP_CENTER;
			break;
		case PS_JUSTIFIED:
			style = GP_JUST;
			break;
		case PS_RIGHT:
			style = GP_RIGHT;
			break;
		case PS_SIDEBYSIDE:
			style = GP_SBS;
			break;
	}
	short textSize = *(short *)(para+1) - *(short *)(para+3) +3;
	AddParaText(para + *(short *)(para+3), textSize, style, lm, rm, lrm);

	return 0;
}

int GRTFWriter::FinishRTF()
{
	return rtf->FinishRTF();
}

void GRTFWriter::GetStyleTrans(GRTFPara gar_style, 
		RTFWriter::RTFParaStyle& para_style, 
		char& is_sbs)
{
	//RTFWriter::RTFParaStyle para_style; 

	switch (gar_style) {
		case GP_JUST:
			para_style = RTFWriter::PA_JUST;
			break;
		case GP_CENTER:
			para_style = RTFWriter::PA_CENTER;
			break;
		case GP_RIGHT:
			para_style = RTFWriter::PA_RIGHT;
			break;
		case GP_SBS:
			para_style = RTFWriter::PA_LEFT;
			is_sbs = 1;
			break;
		case GP_PREF:
			para_style = RTFWriter::PA_LEFT;
			break;
	}
}

void GRTFWriter::GetColorTrans(GRTFWriter::GRTFColor gar_color,
		int& font,
		int& font_size, 
		RTFWriter::RTFFontStyle& font_style, int& font_color)
{
	font_size = 9;
	font = font_non;
	font_style = RTFWriter::FS_NORMAL;	
	switch(gar_color) {
		case C_PLAIN:
			font_color = color_regular;
			break;
		case C_COLOR:
			font_color = color_color;
			break;
		case C_CONT:
			font_color = color_link;
			break;
		case C_COMM:
			font_color = color_comm;
			break;
		case C_LINK:
			font_color = color_link;
			font_style = (RTFWriter::RTFFontStyle)(RTFWriter::FS_NORMAL | 
					RTFWriter::FS_UNDER);
			break;
		case C_NONP:
			break;
		case C_ABOL:
			font_color = color_abolished;
			break;
	}		
}
