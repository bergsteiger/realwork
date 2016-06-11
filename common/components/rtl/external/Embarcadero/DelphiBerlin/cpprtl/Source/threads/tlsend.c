/*-----------------------------------------------------------------------*
 * filename - tlsend.c
 *
 *	 Holds a critical variable for Thread Local Storage support.
 *
 *-----------------------------------------------------------------------*/

/* Don't generate debug information for magic symbol */
//#pragma option -v-

/*----------------------------------------------------------------------
 *   The linker will bash this variable's address with the size of the
 *   TLS data in the image.  This is all data linked into the image, where
 *   the data came from the borland.tls section in the .o files.  This symbol
 *   HAS to live in a seperate module from the referent module, so that the
 *   linker will be able to see references to it.  If it lives in tls.c, then
 *   the linker will convert references to it to references to the data
 *   segment, and that will defeat the linker address hackery.
 *   tlssize.c will do additional hackery with this symbol.  The marking of
 *   the variable as __declspec(thread) is to trick the linker into avoiding
 *   making fixups to this symbol in the case of DLL linking.
 */
int __declspec(thread) __embt_tls_end;
