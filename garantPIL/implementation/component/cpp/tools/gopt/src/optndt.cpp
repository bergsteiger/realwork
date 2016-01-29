#include "shared/Core/fix/mpcxc.h"
#include <cstdio>
#include <cstdlib>

//#include <unistd.h>

#include "log.h"
#include "gopt.h"

#define MAX_PAGES 1024

static pgfile_st *psrc = 0;
static pgfile_st *pdest = 0;
static u_int32_t current_page = 0;
static u_int32_t current_count = 0;
static u_int32_t buffer_count = 0;
static u_int32_t to_write_page = 0;
static char *buffer = 0;
static char *buffree = 0;

static void load_pages();
static void flush_buffer();
// static void flush_ndt_pages(void);

void set_ndt_files(pgfile_st *_psrc, pgfile_st *_pdest)
{
	psrc = _psrc;
	pdest = _pdest;
	current_page = 0;
	current_count = 0;
	to_write_page = pgfile_size(pdest);
	if(!buffer) buffer = (char *)malloc(MAX_PAGES << psrc->pgpow);
	buffree = buffer;
}

u_int32_t move_ndt_pages(u_int32_t page, u_int16_t count)
{
	u_int32_t dest_page;
	// int add_log = 0;
	
	//return 1;
	if (!psrc) {
		printf("Init files!!!");
		return 0;
	}
	// flog("Move request: (%d, %d)\n", page, (u_int32_t)count);
	// if(page == 1657) {
		// m_log("Warning!\n Additional logging...\n");
		// add_log = 1;
	// }
	// else add_log = 0;
	dest_page = to_write_page + current_count + buffer_count;
	if (!current_page) { // No current chain : 1st call or after flush caused by overflow
		current_page = page;
		current_count = count;
		return dest_page;
	}
	if(!count) {
		if(current_count) load_pages();
		flush_buffer();
		return dest_page;
	}
	// if(add_log)
		// flog("--Advlog: page=%d, count=%d current_count=%d\n", page, (u_int32_t)count, current_count);
	if (page == current_page + current_count) { // chain continues
		current_count += count;
	}
	else { //  (page != current_page + current_count) { // flush
		load_pages();
		current_page = page;
		current_count = count;
	}
	// if(add_log)
		// flog("--Advlog: page=%d, count=%d current_count=%d\n", page, (u_int32_t)count, current_count);
	// flog ("Starting page %d returned\n", dest_page);
	return dest_page;
}

static void flush_buffer()
{
	// flog("Writing %d pages from %d\n", buffer_count, to_write_page); 
	write_pages(pdest, to_write_page, buffer_count, buffer);
	to_write_page += buffer_count;
	buffer_count = 0;
	buffree = buffer;
}

static char FormtsMsgNDT[]= "\r  Reading %06d page...                             ";
static void load_pages()
{
	u_int32_t to_read;

	// flog("Load action: (%d, %d) for %d loaded pages\n", current_page, current_count, buffer_count);
	if(current_count + buffer_count > MAX_PAGES) {
		// flog("flush action! %d pages occured.\n", current_count+buffer_count);
		// flog("page to load from: %d, pages to load: %d\n", current_page, current_count);
		to_read = MAX_PAGES - buffer_count;
		read_pages(psrc, current_page, to_read, buffree);
		buffer_count += to_read;
		current_page += to_read; current_count -= to_read;
		// flog("flushing buffer of %d pages to page(s) %d\n", buffer_count, to_write_page);
		flush_buffer();
		// flog("post-flush: page to load from: %d, pages to load: %d\n", current_page, current_count);
		to_read = (current_count > MAX_PAGES) ? MAX_PAGES : current_count;
		while(current_count > MAX_PAGES) {
			// flog("Reading %d pages from %d\n", to_read, current_page);
			printf(FormtsMsgNDT, current_page);
			read_pages(psrc, current_page, to_read, buffer);
			buffer_count = to_read;
			// flog("flushing buffer of %d pages to page(s) %d\n", buffer_count, to_write_page);
			flush_buffer();
			current_count -= to_read;
			current_page += to_read;
			to_read = (current_count > MAX_PAGES) ? MAX_PAGES : current_count;
		}
		printf(FormtsMsgNDT, current_page);
		read_pages(psrc, current_page, to_read, buffer);
		buffer_count = to_read;
		buffree = buffer + (to_read << psrc->pgpow);
	}
	else {
		read_pages(psrc, current_page, current_count, buffree);
		buffree += current_count << psrc->pgpow;
		buffer_count += current_count;
	}
}

/*
static void flush_ndt_pages(void)
{
	u_int32_t pages;

	do {
		pages = (current_count > MAX_PAGES) ? MAX_PAGES : current_count;	
		read_pages(psrc, current_page, pages, buffer);
		write_pages(pdest, to_write_page, pages, buffer);
		current_page += pages;
		to_write_page += pages;
		current_count -= pages;
	} while (current_count);
}
*/

void free_ndt_files(void)
{
	if(psrc && pdest && current_count) {
		load_pages();
		flush_buffer();
	}
	if(buffer) {
		free(buffer);
		buffer = 0;
	}
	psrc = 0;
	pdest = 0;
	current_page = 0;
	current_count = 0;
	to_write_page = 1;
}




