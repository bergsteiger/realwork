unit csAutoClassTask;

// Модуль: "w:\common\components\rtl\Garant\cs\csAutoClassTask.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsAutoClassTask" MUID: (53F46C710363)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , k2Base
 , dt_Types
;

type
 TcsAutoClassTask = class(TddProcessTask)
  protected
   function pm_GetBuilderFileName: AnsiString;
   procedure pm_SetBuilderFileName(const aValue: AnsiString);
   function pm_GetResultFileName: AnsiString;
   procedure pm_SetResultFileName(const aValue: AnsiString);
   function pm_GetSourceFolder: AnsiString;
   procedure pm_SetSourceFolder(const aValue: AnsiString);
   function pm_GetLogFileName: AnsiString;
   procedure pm_SetLogFileName(const aValue: AnsiString);
   function pm_GeteMailNotifyList: AnsiString;
   procedure pm_SeteMailNotifyList(const aValue: AnsiString);
  public
   class function GetTaggedDataType: Tk2Type; override;
   constructor Create(aUserID: TUserID); override;
  public
   property BuilderFileName: AnsiString
    read pm_GetBuilderFileName
    write pm_SetBuilderFileName;
   property ResultFileName: AnsiString
    read pm_GetResultFileName
    write pm_SetResultFileName;
   property SourceFolder: AnsiString
    read pm_GetSourceFolder
    write pm_SetSourceFolder;
   property LogFileName: AnsiString
    read pm_GetLogFileName
    write pm_SetLogFileName;
   property eMailNotifyList: AnsiString
    read pm_GeteMailNotifyList
    write pm_SeteMailNotifyList;
 end;//TcsAutoClassTask
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , AutoClassTask_Const
;

function TcsAutoClassTask.pm_GetBuilderFileName: AnsiString;
//#UC START# *F76829C0208C_53F46C710363get_var*
//#UC END# *F76829C0208C_53F46C710363get_var*
begin
//#UC START# *F76829C0208C_53F46C710363get_impl*
 !!! Needs to be implemented !!!
//#UC END# *F76829C0208C_53F46C710363get_impl*
end;//TcsAutoClassTask.pm_GetBuilderFileName

procedure TcsAutoClassTask.pm_SetBuilderFileName(const aValue: AnsiString);
//#UC START# *F76829C0208C_53F46C710363set_var*
//#UC END# *F76829C0208C_53F46C710363set_var*
begin
//#UC START# *F76829C0208C_53F46C710363set_impl*
 !!! Needs to be implemented !!!
//#UC END# *F76829C0208C_53F46C710363set_impl*
end;//TcsAutoClassTask.pm_SetBuilderFileName

function TcsAutoClassTask.pm_GetResultFileName: AnsiString;
//#UC START# *47C5C609E806_53F46C710363get_var*
//#UC END# *47C5C609E806_53F46C710363get_var*
begin
//#UC START# *47C5C609E806_53F46C710363get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C609E806_53F46C710363get_impl*
end;//TcsAutoClassTask.pm_GetResultFileName

procedure TcsAutoClassTask.pm_SetResultFileName(const aValue: AnsiString);
//#UC START# *47C5C609E806_53F46C710363set_var*
//#UC END# *47C5C609E806_53F46C710363set_var*
begin
//#UC START# *47C5C609E806_53F46C710363set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C5C609E806_53F46C710363set_impl*
end;//TcsAutoClassTask.pm_SetResultFileName

function TcsAutoClassTask.pm_GetSourceFolder: AnsiString;
//#UC START# *1020BCE9F413_53F46C710363get_var*
//#UC END# *1020BCE9F413_53F46C710363get_var*
begin
//#UC START# *1020BCE9F413_53F46C710363get_impl*
 !!! Needs to be implemented !!!
//#UC END# *1020BCE9F413_53F46C710363get_impl*
end;//TcsAutoClassTask.pm_GetSourceFolder

procedure TcsAutoClassTask.pm_SetSourceFolder(const aValue: AnsiString);
//#UC START# *1020BCE9F413_53F46C710363set_var*
//#UC END# *1020BCE9F413_53F46C710363set_var*
begin
//#UC START# *1020BCE9F413_53F46C710363set_impl*
 !!! Needs to be implemented !!!
//#UC END# *1020BCE9F413_53F46C710363set_impl*
end;//TcsAutoClassTask.pm_SetSourceFolder

function TcsAutoClassTask.pm_GetLogFileName: AnsiString;
//#UC START# *AFB23FE9D63B_53F46C710363get_var*
//#UC END# *AFB23FE9D63B_53F46C710363get_var*
begin
//#UC START# *AFB23FE9D63B_53F46C710363get_impl*
 !!! Needs to be implemented !!!
//#UC END# *AFB23FE9D63B_53F46C710363get_impl*
end;//TcsAutoClassTask.pm_GetLogFileName

procedure TcsAutoClassTask.pm_SetLogFileName(const aValue: AnsiString);
//#UC START# *AFB23FE9D63B_53F46C710363set_var*
//#UC END# *AFB23FE9D63B_53F46C710363set_var*
begin
//#UC START# *AFB23FE9D63B_53F46C710363set_impl*
 !!! Needs to be implemented !!!
//#UC END# *AFB23FE9D63B_53F46C710363set_impl*
end;//TcsAutoClassTask.pm_SetLogFileName

function TcsAutoClassTask.pm_GeteMailNotifyList: AnsiString;
//#UC START# *99C26E6A4D91_53F46C710363get_var*
//#UC END# *99C26E6A4D91_53F46C710363get_var*
begin
//#UC START# *99C26E6A4D91_53F46C710363get_impl*
 !!! Needs to be implemented !!!
//#UC END# *99C26E6A4D91_53F46C710363get_impl*
end;//TcsAutoClassTask.pm_GeteMailNotifyList

procedure TcsAutoClassTask.pm_SeteMailNotifyList(const aValue: AnsiString);
//#UC START# *99C26E6A4D91_53F46C710363set_var*
//#UC END# *99C26E6A4D91_53F46C710363set_var*
begin
//#UC START# *99C26E6A4D91_53F46C710363set_impl*
 !!! Needs to be implemented !!!
//#UC END# *99C26E6A4D91_53F46C710363set_impl*
end;//TcsAutoClassTask.pm_SeteMailNotifyList

class function TcsAutoClassTask.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53F46C710363_var*
//#UC END# *53AC03EE01FD_53F46C710363_var*
begin
//#UC START# *53AC03EE01FD_53F46C710363_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53F46C710363_impl*
end;//TcsAutoClassTask.GetTaggedDataType

constructor TcsAutoClassTask.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_53F46C710363_var*
//#UC END# *53B3D8A8011F_53F46C710363_var*
begin
//#UC START# *53B3D8A8011F_53F46C710363_impl*
 inherited;
 Description := 'Запрос на автоклассификацию';
//#UC END# *53B3D8A8011F_53F46C710363_impl*
end;//TcsAutoClassTask.Create
{$IfEnd} // NOT Defined(Nemesis)

end.
