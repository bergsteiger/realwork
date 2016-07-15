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
 , daTypes
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
   constructor Create(aUserID: TdaUserID); override;
   class function GetTaggedDataType: Tk2Type; override;
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
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrBuilderFileName]);
end;//TcsAutoClassTask.pm_GetBuilderFileName

procedure TcsAutoClassTask.pm_SetBuilderFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrBuilderFileName, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetBuilderFileName

function TcsAutoClassTask.pm_GetResultFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrResultFileName]);
end;//TcsAutoClassTask.pm_GetResultFileName

procedure TcsAutoClassTask.pm_SetResultFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrResultFileName, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetResultFileName

function TcsAutoClassTask.pm_GetSourceFolder: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceFolder]);
end;//TcsAutoClassTask.pm_GetSourceFolder

procedure TcsAutoClassTask.pm_SetSourceFolder(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrSourceFolder, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetSourceFolder

function TcsAutoClassTask.pm_GetLogFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogFileName]);
end;//TcsAutoClassTask.pm_GetLogFileName

procedure TcsAutoClassTask.pm_SetLogFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrLogFileName, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetLogFileName

function TcsAutoClassTask.pm_GeteMailNotifyList: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attreMailNotifyList]);
end;//TcsAutoClassTask.pm_GeteMailNotifyList

procedure TcsAutoClassTask.pm_SeteMailNotifyList(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attreMailNotifyList, nil] := (aValue);
end;//TcsAutoClassTask.pm_SeteMailNotifyList

constructor TcsAutoClassTask.Create(aUserID: TdaUserID);
//#UC START# *53B3D8A8011F_53F46C710363_var*
//#UC END# *53B3D8A8011F_53F46C710363_var*
begin
//#UC START# *53B3D8A8011F_53F46C710363_impl*
 inherited;
 Description := 'Запрос на автоклассификацию';
//#UC END# *53B3D8A8011F_53F46C710363_impl*
end;//TcsAutoClassTask.Create

class function TcsAutoClassTask.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typAutoClassTask;
end;//TcsAutoClassTask.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
