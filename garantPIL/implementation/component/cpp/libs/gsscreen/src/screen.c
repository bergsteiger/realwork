#include "shared/Core/fix/mpcxc.h"
/*****************************
* Toys1.C - small collection
*           for video I/O
******************************/
/* #define _USE_STDOUT */


#include "iscreen.h"

#if defined (__WIN32__)
#include <windows.h>
#endif

#include <string.h>
#include <stdlib.h>

#include "toys.h"


/* Face settings : filling chars, filling attributes for following windows:
   * desktop
   * titlebar
   * window
   * progress bar
*/

typedef struct tag_fillset {
	unsigned char bg; /* background color for symbols */
	unsigned char fg; /* foreground color for symbols */
	unsigned char fc; /* filling character */
	unsigned char fa; /* filling attribute */
} fill_set;

static fill_set std_faces[16] = {
 { BG_BLACK, FG_GRAY, 177, BG_BLACK | FG_GRAY },
 { BG_BLUE, FG_WHITE, 32, BG_BLUE | FG_WHITE },
 { BG_BLUE | BG_LIGHT, FG_WHITE, 32, (BG_BLUE | BG_LIGHT) | FG_WHITE },
 { BG_BLUE | BG_LIGHT, FG_LIGHT, '\x1d', (BG_BLUE | BG_LIGHT) | FG_LIGHT },
 { BG_BLUE | BG_LIGHT, FG_YELLOW, '\x1d', (BG_BLUE | BG_LIGHT) | FG_YELLOW },
 { BG_BLACK, FG_LIGHT, 177, BG_BLACK | FG_LIGHT },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY },
 { BG_BLACK, FG_GRAY, ' ', BG_BLACK | FG_GRAY }
};

static int drawing_style = FS_WINDOW;

#if defined(__WIN32__)
#include <windows.h>
static HANDLE hConsoleOutput;
#else
static char *VidAddr;
#endif

#if defined (__GO32__) && !defined (_USE_STDOUT)
#include <go32.h>

static char vidmem[4096];

void vidupdate(void) 
{
	movedata(_my_ds(), (unsigned)vidmem, 
		_go32_info_block.selector_for_linear_memory,
		_go32_info_block.linear_address_of_primary_screen,
		4000 );
}

#else
	#ifdef __WIN32__
		#include <windows.h>
	#else
		#include <stdio.h>
	#endif
#endif

#ifdef __WIN32__

static WORD convert_attrs(unsigned char attrs)
{
	WORD winattr=0;

	if(attrs & BG_BLUE) winattr |= BACKGROUND_BLUE;
	if(attrs & BG_GREEN) winattr |= BACKGROUND_GREEN;
	if(attrs & BG_RED) winattr |= BACKGROUND_RED;
	if(attrs & BG_LIGHT) winattr |= BACKGROUND_INTENSITY;
	if(attrs & FG_BLUE) winattr |= FOREGROUND_BLUE;
	if(attrs & FG_GREEN) winattr |= FOREGROUND_GREEN;
	if(attrs & FG_RED) winattr |= FOREGROUND_RED;
	if(attrs & FG_LIGHT) winattr |= FOREGROUND_INTENSITY;
	return winattr;
}

#endif

void init_screen(char *video_addr)
{
#ifndef __WIN32__
	#ifdef __GO32__
		VidAddr = vidmem;
	#else
		VidAddr = video_addr;
	#endif // __GO32__
#elif !defined(_USE_STDOUT)
	CONSOLE_CURSOR_INFO ci;
	hConsoleOutput = GetStdHandle(STD_OUTPUT_HANDLE);
	GetConsoleCursorInfo(hConsoleOutput, &ci);
	ci.bVisible = FALSE;
	SetConsoleCursorInfo(hConsoleOutput, &ci);
	//SetConsoleOutputCP(1251);
#endif
}

void clear_video()
{
#if !defined (__WIN32__) && !defined (_USE_STDOUT)
  register int  i, j;
  char *v, *t;

  v = VidAddr;

  for(i=0; i<= 24; i++)
    for(j=0; j<=79; j++)
    {
      t = (v + (i*160) + j*2);  // calculate adress
      *t++ = ' ';     // clearing
      *t = 0x07;  // put new attribute value
    }
#ifdef __GO32__
	vidupdate();
#endif
#else
	#ifdef __WIN32__
	WORD winattr;
	COORD cc;
	HANDLE hout;
	DWORD dw;

	cc.X = cc.Y = 0;
	winattr = 0;
	hout = GetStdHandle(STD_OUTPUT_HANDLE);
	FillConsoleOutputCharacter(hout, ' ', 2000, cc, &dw);
	FillConsoleOutputAttribute(hout, winattr, 2000, cc, &dw);
	#endif
#endif
}

void write_char(u_int16_t row, u_int16_t col, unsigned char ch, int style)
{
#ifndef __WIN32__ 
  unsigned char *v;

  v = (unsigned char *)VidAddr;
  v += (row*160) + col*2; /* calculating address */
  *v++ = ch;    /* symbol */
	*v = std_faces[style].fa;
#ifdef __GO32__
	vidupdate();
#endif
#else
	WORD win_attrs;
	COORD cc;
	DWORD dw;

	cc.X = col; cc.Y=row;
	win_attrs = convert_attrs(std_faces[style].fa);
	FillConsoleOutputAttribute(hConsoleOutput, win_attrs, 1, cc, &dw);
	FillConsoleOutputCharacter(hConsoleOutput, ch, 1, cc, &dw);
#endif
}

void write_str(u_int16_t row, u_int16_t col, char *s, int style)
{
#ifndef __WIN32__ 
	u_int16_t *sp; /* sp: symbol pointer (in screen buffer) */
	u_int16_t ca; /* ca: char and attr pair */

	sp = (u_int16_t *)VidAddr;
	sp += row*80 + col;
	ca = std_faces[style].fa;
	ca <<= 8;
	for(; *s; s++) *sp++ = ca+*s; /* write char */
#ifdef __GO32__
	vidupdate();
#endif
#else
	WORD win_attrs;
	COORD cc;
	DWORD dw;
	int len;
			
	cc.X = col; cc.Y=row;
	win_attrs = convert_attrs(std_faces[style].fa);
	len = strlen(s);
	WriteConsoleOutputCharacter(hConsoleOutput, s, len, cc, &dw);
	FillConsoleOutputAttribute(hConsoleOutput, win_attrs, len, cc, &dw);
#endif
}

void fill_line(u_int16_t row, u_int16_t col, u_int16_t len, int style)
{
#if !defined (__WIN32__)
  int i;
  char *s;
	
	if(len > 80) len = 80;
	s = (char *)alloca(len+1);
	s[len] = 0;
	memset(s, std_faces[style].fc, len);
	write_str(row, col, s, style);
#ifdef __GO32__
	vidupdate();
#endif
#else
	WORD win_attrs;
	COORD cc;
	DWORD dw;

	cc.X = col; cc.Y=row;
	win_attrs = convert_attrs(std_faces[style].fa);
	FillConsoleOutputAttribute(hConsoleOutput, win_attrs, len, cc, &dw);
	FillConsoleOutputCharacter(hConsoleOutput, std_faces[style].fc, len, cc, &dw);
#endif
}

void draw_window(u_int16_t left, u_int16_t top, u_int16_t right, u_int16_t bottom)
{
  int i, row;
  unsigned char *t;
  int al, ar, ad, au, alu, ald, aru, ard;

  al = 7; ar = 8; au = 5; ad = 6; alu = 1; ald = 3; aru = 2; ard = 4;

	t = (unsigned char *)alloca(right-left+2);
	t[right-left] = '\0';
  for(row=top; row<=bottom; row++) { /* draw vertical lines */
		write_char((u_int16_t)row, (u_int16_t)left, (unsigned char)al, FS_WINDOW);
		write_char((u_int16_t)row, (u_int16_t)right, (unsigned char)ar, FS_WINDOW);
		fill_line((u_int16_t)(row+1), (u_int16_t)(right+1), 2, FS_DSHADOW);
  }
  /* draw top border line */
	memset(t, au, right-left-1);
	write_str((u_int16_t)top, (u_int16_t)(left+1), (char *)t, FS_WINDOW);
	/* draw bottom border line */
	memset(t, ad, right-left-1);
	write_str((u_int16_t)bottom, (u_int16_t)(left+1), (char *)t, FS_WINDOW);
	/* draw corners */
  write_char((u_int16_t)top, (u_int16_t)left, (unsigned char)alu, FS_WINDOW);
  write_char((u_int16_t)bottom, (u_int16_t)left, (unsigned char)ald, FS_WINDOW);
  write_char((u_int16_t)top, (u_int16_t)right, (unsigned char)aru, FS_WINDOW);
  write_char((u_int16_t)bottom, (u_int16_t)right, (unsigned char)ard, FS_WINDOW);
  /* draw bottom shadow */
	fill_line((u_int16_t)(bottom+1), (u_int16_t)(left+2), (unsigned char)(right-left), FS_DSHADOW);
	/* fill window's client area */
	memset(t, ' ', right-left-1);
  for(i=top+1; i<bottom; i++)
		fill_line((u_int16_t)i, (u_int16_t)(left+1), (unsigned char)(right-left-1), FS_WINDOW);
}

void set_fill_style(int style, unsigned char bg, unsigned char fg, unsigned char fc)
{
	std_faces[style].fc = fc;
	std_faces[style].bg = bg;
	std_faces[style].fg = fg;
	std_faces[style].fa = bg | fg;
}

