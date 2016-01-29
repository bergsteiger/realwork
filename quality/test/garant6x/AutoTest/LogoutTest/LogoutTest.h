class ThreadParam
{
public:
	ThreadParam(int s1=1,int s2=1)
	{
		sprintf(user_login, "%d",s1);
		sprintf(user_pass, "%d",s2);
	};
	ThreadParam(char s1[]= "", char s2[]= "")
	{
		sprintf(user_login, "%s",s1);
		sprintf(user_pass, "%s",s2);
	};
	ThreadParam()
	{
	};
	char user_login[100];
	char user_pass[100];
	
};