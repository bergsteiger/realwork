#ifndef _RTFWRITE_H_
#define _RTFWRITE_H_

class RTFWriter
{
	public:
		enum RTFCharSet { CS_ANSI, CS_MAC, CS_PC, CS_PCA };
		
		enum RTFFontFamily { FF_NIL_ =0, FF_ROMAN_ =1, FF_SWISS_ =2, FF_MODERN_ =3 };
		enum RTFParaStyle { PA_LEFT, PA_RIGHT, PA_JUST, PA_CENTER };
		enum RTFFontStyle { FS_NORMAL=0, FS_ITALIC=1, FS_BOLD=2, FS_UNDER=3,
				FS_BOLDITALIC=4, FS_ITALICUNDER=5, FS_BOLDUNDER=6,
				FS_BOLDITALICUNDER=7,FS_STRIKE=8,
				FS_STRIKEITALIC=9, FS_STRIKEBOLD=10, FS_STRIKEUNDER=11,
				FS_STRIKEBOLDITALIC=12, FS_STRIKEITALICUNDER=13, FS_STRIKEBOLDUNDER=14,
				FS_STRIKEBOLDITALICUNDER=15};
		enum RTFStatus { ST_OK, ST_NORTFSTART, 
				ST_NOFONTTABLE, ST_OPENEDFONTTABLE,
				ST_NOCOLORTABLE, ST_OPENEDCOLORTABLE,
				ST_NOINFO, ST_OPENEDINFO,
				ST_OPENEDPARA };
			

		RTFWriter(RTFCharSet new_charset = CS_ANSI);
		~RTFWriter();

		RTFStatus GetStatus() const 
		{ 
			return status; 
		};
		// returns: 0 - ok
		//			1 - no fonts table
		//			2 - opened font table
		//			3 - no color table
		//			4 - opened color table
		//			5 - no opened par
		//			6 - opened par
		//			7 - no info
		//			8 - opened info
		
		int StartRTF();
		//return 1 if error
		int FinishRTF();
		// return 1 if error

		int OpenFontTable();
		// returns 1 if error. see GetStatus()

		int AddFont(RTFFontFamily font_family, 
				int font_charset, 
				const char *font_name); 
		// returns: font num
		// -1 if error

		int CloseFontTable();
		// return 1 if error. see GetStatus()

		int OpenColorTable();
		// return 1 if error. see GetStatus()

		int AddColor(char R, char G, char B);
		// returns color id
		// -1 if error

		int CloseColorTable();
		// returns 1 if error. see GetStatus()

		int OpenInfo();
		// return 1 if error. see OpenInfo

		int SetDocTitle(const char *title);
		// return 1 if error. see GetStatus()

		int SetDocAuthor(const char *author);
		// return 1 if error. see GetStatus()

		int CloseInfo();
		// return 1 if error. see GetStatus()

		int OutputPara(const char *text, int font, int font_size, 
			RTFFontStyle font_style, int color, RTFParaStyle style, 
			int leftMargin, int rightMargin, int firstMargin, char isSBSPara);

		int OpenPara(int leftMargin, int rightMargin, int firstMargin,
			RTFParaStyle style, char isSBSPara);
		// return 1 if error. see GetStatus()

		int ClosePara();
		// return 1 if error. see GetStatus()

		int OutputParaText(const char *text, int font, int font_size,
			RTFFontStyle font_style, int color);
		// returns 1 if error. see GetSatus()
		// 			2 - no such font
		//			3 - no such color

		void	SetStatus( RTFStatus aStatus )
		{
			status = aStatus;
		}

	protected:
		struct RTFFont {
			int FontID;
			RTFFontFamily font_family;
			int font_charset;
			char *font_name;
		};
		RTFCharSet char_set;
		struct RTFColor {
			char r;
			char g;
			char b;
		};

		RTFStatus status;
		RTFFont*  font_list;
		int		  font_count;
		RTFColor* color_list;
		int		  color_count;

		int Write(const char *buf, int size);
		// does decoding russian and escaping all specials
		// success - 0
		// error - 1
		virtual void Recode(char* buf);
		virtual int RawWrite(const char *buf, int size) { return size; };
		// writes to destination, no decoding
		// returns number of bytes written 
};
#endif
