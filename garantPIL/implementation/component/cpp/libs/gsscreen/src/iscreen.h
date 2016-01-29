#include <sys/types.h>
#include <stdio.h>

#include "osdep.h"

#if defined (__GO32__) && !defined (_USE_STDOUT)
void vidupdate(void);
#endif

void init_screen(char *video_addr);
void write_char(u_int16_t y, u_int16_t x, unsigned char ch, int style);
void write_str(u_int16_t row, u_int16_t col, char *s, int style);
void fill_line(u_int16_t row, u_int16_t col, u_int16_t len, int style);
void draw_window(u_int16_t left, u_int16_t top, u_int16_t right, u_int16_t bottom);
void set_fill_style(int style, unsigned char bg, unsigned char fg, unsigned char fc);

