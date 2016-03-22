/*
 *
 * cvs id was here
 * Generic Garant context symbols defines
 *
 */

#ifndef	__GARANT_CONTEXT_DEFINES__
#define	__GARANT_CONTEXT_DEFINES__

// GARANT_U
#define rv_uc(x) ((unsigned char)(x))
#define lv_uc(x) ((*(unsigned char *)(void *)(&x)))

#define IS_NUMBER(ch) ((rv_uc(ch)>=rv_uc('0')&&rv_uc(ch)<=rv_uc('9')))

#define IS_R_ANUM(ch) (IS_NUMBER(ch)|| (rv_uc(ch)>=rv_uc('A')&&rv_uc(ch)<=rv_uc('Z'))|| (rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z') )|| (rv_uc(ch)>=rv_uc('�')&&rv_uc(ch)<=rv_uc('�'))|| (rv_uc(ch)>=rv_uc('�')&&rv_uc(ch)<=rv_uc('�'))|| (rv_uc(ch)>=rv_uc('�')&&rv_uc(ch)<=rv_uc('�')) || rv_uc(ch) == rv_uc('�') || rv_uc(ch) == rv_uc('�') || rv_uc(ch) == rv_uc('�') || rv_uc(ch) == rv_uc('�') )
#define IS_R_ANUM_WIN(ch) (IS_NUMBER(ch)|| (rv_uc(ch)>=rv_uc('A')&&rv_uc(ch)<=rv_uc('Z'))|| (rv_uc(ch)>=rv_uc('a')&&rv_uc(ch)<=rv_uc('z') )|| (rv_uc(ch)>=rv_uc('�')&&rv_uc(ch)<=rv_uc('�'))|| (rv_uc(ch)>=rv_uc('�')&&rv_uc(ch)<=rv_uc('�'))|| rv_uc(ch)==rv_uc('�') || rv_uc(ch)==rv_uc('�') || rv_uc(ch)==rv_uc('�') || rv_uc(ch)==rv_uc('�'))

// - (��䨧) ⥯��� ࠧ����⥫�
#define IS_CTX_CHAR(c) (IS_R_ANUM(c)||rv_uc(c)==rv_uc('/'))
// �뫮 #define IS_CTX_CHAR(c) (IS_R_ANUM(c)||(c)==rv_uc('-')||(c)==rv_uc('/'))
#define IS_CTX_CHAR_WIN(c) (IS_R_ANUM_WIN(c)||rv_uc(c)==rv_uc('/'))
// �뫮 #define IS_CTX_CHAR_WIN(c) (IS_R_ANUM_WIN(c)||(c)==rv_uc('-')||(c)==rv_uc('/'))

#define IS_CTX_CHAR_NORMLS_56(c) ((c=='%')||(rv_uc(c)>=rv_uc('�')&&rv_uc(c)<=rv_uc('�')) || (rv_uc(c)>=rv_uc('�')&&rv_uc(c)<=rv_uc('�')) || (rv_uc(c)>=rv_uc('�')&&rv_uc(c)<=rv_uc('�')) || rv_uc(c) == rv_uc('�') || rv_uc(c) == rv_uc('�') || rv_uc(c) == rv_uc('�') || rv_uc(c) == rv_uc('�') || IS_NUMBER(c)|| (rv_uc(c)>=rv_uc('A')&&rv_uc(c)<=rv_uc('Z'))|| (rv_uc(c)>=rv_uc('a')&&rv_uc(c)<=rv_uc('z') ))
#define IS_CTX_CHAR_NORMLS_62(c) ((c=='%')||(rv_uc(c)>=rv_uc('�')&&rv_uc(c)<=rv_uc('�')) || (rv_uc(c)>=rv_uc('�')&&rv_uc(c)<=rv_uc('�')) || IS_NUMBER(c) || rv_uc(c)==rv_uc('�') || rv_uc(c)==rv_uc('�') || rv_uc(c)==rv_uc('�') || rv_uc(c)==rv_uc('�') || (rv_uc(c)>=rv_uc('A')&&rv_uc(c)<=rv_uc('Z'))|| (rv_uc(c)>=rv_uc('a')&&rv_uc(c)<=rv_uc('z') ))

#endif // __GARANT_CONTEXT_DEFINES__

