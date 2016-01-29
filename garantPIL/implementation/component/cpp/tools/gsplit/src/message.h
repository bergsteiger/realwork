#ifndef __MESSAGE_H
#define __MESSAGE_H

#ifdef  __cplusplus
	extern "C" {
#endif
	void set_language(int lang);
	int get_language();
	char *get_message(int msg);
#ifdef  __cplusplus
	}
#endif


#define MSG_TITLE     0
#define MSG_DUMMY     1
#define MSG_LIMIT     2
#define MSG_NOOPEN    3
#define MSG_NOTREADY  4
#define MSG_COLLECT   5
#define MSG_ATTRS     6
#define MSG_STEP1_3   7
#define MSG_STEP2_3   8
#define MSG_STEP3_3   9
#define MSG_INDEX     10
#define MSG_STEP1_25  11
#define MSG_ADOPTED   11
#define MSG_STEP2_25  12
#define MSG_TYPE      12
#define MSG_STEP3_25  13
#define MSG_DATE      13
#define MSG_STEP4_25  14
#define MSG_NUMBER    14
#define MSG_STEP5_25  15
#define MSG_STATUS    15
#define MSG_STEP6_25  16
#define MSG_DIVISION  16
#define MSG_STEP7_25  17
#define MSG_KEYWORD   17
#define MSG_STEP8_25  18
#define MSG_RCODE     18
#define MSG_STEP9_25  19
#define MSG_RESPOND   19
#define MSG_STEP10_25 20
#define MSG_CORRESP   20
#define MSG_STEP11_25 21
#define MSG_RDATE     21
#define MSG_STEP12_25 22
#define MSG_CONTEXT   22
#define MSG_STEP13_25 23
#define MSG_NMCTX     23
#define MSG_STEP14_25 24
#define MSG_VANONCED  24
#define MSG_STEP15_25 25
#define MSG_VINCLUDED 25
#define MSG_STEP16_25 26
#define MSG_VCHANGED  26
#define MSG_STEP17_25 27
#define MSG_VABOLISH  27
#define MSG_STEP18_25 28
#define MSG_VLCONTROL 28
#define MSG_STEP19_25 29
#define MSG_CLASS     29
#define MSG_STEP20_25 30
#define MSG_SUBNAME   30
#define MSG_STEP21_25 31
#define MSG_SORTDATE  31
#define MSG_STEP22_25 32
#define MSG_SKIPDOCS  32
#define MSG_STEP23_25 33
#define MSG_SKIPREVS  33
#define MSG_STEP24_25 34
#define MSG_CATEGORY  34
#define MSG_STEP25_25 35
#define MSG_AUX       35

#define MSG_SUCCESS   70
#define MSG_VERSION   71
#define MSG_NONEXIST1 72
#define MSG_NONEXISTM 73

#endif // __MESSAGE_H
