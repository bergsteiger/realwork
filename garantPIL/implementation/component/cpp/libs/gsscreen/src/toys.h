#ifndef __TOYS_H__
#define __TOYS_H__

#ifdef __cplusplus
        extern "C" {
#endif

 /*  use first param for video memory address */
 /*  Basic colors at EGA/VGA PC display */
#define FG_BLUE    0x01
#define FG_GREEN   0x02
#define FG_RED     0x04

 /*  Foreground brightness attribute */
#define FG_LIGHT   0x08

 /*  Composite colors at EGA/VGA PC display */
#define FG_CYAN    0x03
#define FG_MAGENTA 0x05
#define FG_BROWN   0x06
#define FG_GRAY    0x07

 /*  Bright composite color define for YELLOW (to avoid use of FG_BROWN | FG_LIGHT) */
#define FG_YELLOW  0x0E
#define FG_WHITE   0x0F

 /*  Background colors */

 /*  Basic colors at EGA/VGA PC display */
#define BG_BLUE    0x10
#define BG_GREEN   0x20
#define BG_RED     0x40

 /*  Foreground brightness attribute */
#define BG_LIGHT   0x80
#define BG_BLINK   0x80

 /*  Composite colors at EGA/VGA PC display */
#define BG_BLACK   0x00
#define BG_CYAN    0x30
#define BG_MAGENTA 0x50
#define BG_BROWN   0x60
#define BG_GRAY    0x70

#define FS_DESKTOP   0
#define FS_TITLE     1
#define FS_WINDOW    2
#define FS_PROGRESSD 4
#define FS_PROGRESSR 3
#define FS_DSHADOW   5
#define FS_USER1     6
#define FS_USER2     7
#define FS_USER3     8
#define FS_USER4     9
#define FS_USER5     10
#define FS_USER6     11
#define FS_USER7     12
#define FS_USER8     13
#define FS_USER9     14
#define FS_USER10    15

void clear_video(void);     /*  Clear screen */
void set_progress(short);    /*  upgrade percent indicator, set value by param */
void show_message(const char *);  /*  show message, trunc if lenght more then 50 */
void show_message2(const char *);  /*  show message, trunc if lenght more then 50 */
void hide_message(void);                   /*  clear message, string */
void hide_message2(void);                   /*  clear message, string */
void set_fill_style(int style, unsigned char bg, unsigned char fg, unsigned char fc);

#define ShowMess(s,l) show_message(s)
#define HideMess hide_message
#define UpgrPerc(v) set_progress(v)

enum Translation {
	tr_none =0,
	tr_koi8r2cp866 =1,
	tr_koi8r2w1251 =2,
	tr_tablesize = 3
};

void garant_scr(char *, const char *, enum Translation); 
 /*  Draw screen with title second param */


#ifdef __cplusplus
        }
#endif
#endif
