extern __tls_get_addr

SECTION .text
global _ZN7Sysinit7_GetTlsEv
global ___System__GetTls
___System__GetTls:
_ZN7Sysinit7_GetTlsEv:
	xor rcx, rcx
	jmp __tls_get_addr
