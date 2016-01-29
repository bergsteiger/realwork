#include "shared/Core/fix/mpcxc.h"
#include <stdio.h>
#include "rtffile.h"

int main(int argc, char **argv)
{
	FILE *f;

	f = mpcxc_fopen("/big/clip/test.rtf", "w");
	if (!f) {
		printf("Cannot open file f\n");
		return 0;
	}
	RTFFileWriter* rtf = new RTFFileWriter(f);
	rtf->StartRTF();
	rtf->OpenFontTable();
	int fnt = rtf->AddFont(RTFWriter::FF_ROMAN, 204, "Courier New");
	rtf->CloseFontTable();

	rtf->OpenColorTable();
	int color = rtf->AddColor(255, 0, 0);
	int color1 = rtf->AddColor(0, 0, 0);
	rtf->CloseColorTable();

	rtf->OpenInfo();
	rtf->SetDocTitle("Fuck off!");
	rtf->SetDocAuthor("Ya lubimiy");
	rtf->CloseInfo();

	rtf->OpenPara(0, 0, 200, RTFWriter::PA_RIGHT, 0);
	rtf->OutputParaText("Одна сторока ", fnt, RTFWriter::FS_BOLD, color);
	rtf->OutputParaText("Другая строка ", fnt, RTFWriter::FS_ITALIC, color1);
	rtf->ClosePara();
	
	rtf->OutputPara("it's great para!!!", fnt, RTFWriter::FS_BOLD, color,
		RTFWriter::PA_JUST, 0, 0, 100, 0);
	rtf->OutputPara("it's another great para с текстом по-русски!!!", fnt, RTFWriter::FS_ITALIC, 
		color1, RTFWriter::PA_JUST, 0, 0, 100, 0);

	rtf->FinishRTF();
	delete rtf;

	fclose(f);
	return 0;
}
