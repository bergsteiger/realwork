/*-----------------------------------------------------------------------*
 * filename - tlssize.c
 *
 *   Returns the size of the tls "segment"
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2012, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#if defined(_WIN64)
extern int __embt_tls_end;
static int *__pembt_tls_end = &__embt_tls_end;

int __tls_size(void)
{
    /*
      The variable __embt_tls_end is actually declared as a thread var in
      a different module.  The linker special cases it, and sets its address to
      the size of the TLS section.  We've redeclared __embt_tls_end above to lie
      to the compiler, so that we can get the straight address of the symbol,
      which the linker handles specially, as the symbol is marked as TLS var.
      So when we get the address, it's actually the special value that the
      linker bashed into __embt_tls_end.  Now the trick with the static pointer
      to that variable is required because all of the data references in Win64
      are PIC code, resulting in self relative relocations.  You can't have
      a self relative relocation to an absolute value.  So the trick above
      just gets the reference to __embt_tls_end to be an absolute relocation,
      rather than a self relative relocation.
     */
    int res = (int)__pembt_tls_end;
    /*
     * the linker will always bash the address of __embt_tls_end to
     * an odd number.  if it's even, then this app must not have been
     * linked with ilink.  if tls is actually required, the error will
     * be trapped later (see __System__GetTls)
     */
    if (!(res & 1))
	res = 0;

    return res;
}
#endif
