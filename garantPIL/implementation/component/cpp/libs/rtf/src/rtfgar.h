#ifndef _RTFGAR_H_
#define _RTFGAR_H_

#include "gardefs.h"
#include "rtfwrite.h"

#pragma pack(1)
struct ParaHeader {
	char   Style;
	short  Size;
	short  TextStart;
	char   LeftMargin;
	char   RightMargin;
	char   RedLine;
	char   text[1];
};
#pragma pack()

class GRTFWriter {
	protected:
		RTFWriter* rtf;

		int font_fixed;
		int font_non;
		int color_regular;
		int color_color;
		int color_abolished;
		int color_link;
		int color_comm;
		
		virtual void AddAllColors();
		virtual void AddAllFonts();

	public:
		enum GRTFPara {GP_JUST, GP_CENTER, GP_RIGHT, GP_SBS, GP_PREF};
		enum GRTFColor {C_PLAIN=0, C_COLOR=1, C_CONT=2, C_COMM=3, C_LINK=4, 
			C_NONP=5, C_ABOL=6};

		GRTFWriter(RTFWriter *new_rtf = 0): rtf(new_rtf) {};
		~GRTFWriter() {};

		int Attach(RTFWriter* new_rtf);
		RTFWriter* Detach();

		int StartRTF(const char *title, const char *author);
		virtual int AddParaText(const char *text, unsigned len, 
			GRTFPara style, int leftMargin, 
			int rightMargin, int firstMargin);
		int AddCorePara(const char *para);
		int FinishRTF();

		void	SetStatus( RTFWriter::RTFStatus aStatus ) {
			rtf->SetStatus( aStatus );
		};

		virtual void GetStyleTrans(GRTFWriter::GRTFPara gar_style, 
				RTFWriter::RTFParaStyle& para_style, 
				char& is_sbs);
		virtual void GetColorTrans(GRTFWriter::GRTFColor gar_color,
				int& font, int& font_size, 
				RTFWriter::RTFFontStyle& font_style,
				int& font_color);
};

#endif  // _RTFGAR_H_

