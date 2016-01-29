unit csAutoClassTask;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csAutoClassTask.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Tasks::TcsAutoClassTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csProcessTask,
  k2Base,
  dt_Types
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsAutoClassTask = class(TddProcessTask)
 protected
 // property methods
   function pm_GetBuilderFileName: AnsiString;
   procedure pm_SetBuilderFileName(const aValue: AnsiString);
   function pm_GetResultFileName: AnsiString;
   procedure pm_SetResultFileName(const aValue: AnsiString);
   function pm_GetSourceFolder: AnsiString;
   procedure pm_SetSourceFolder(const aValue: AnsiString);
   function pm_GetLogFileName: AnsiString;
   procedure pm_SetLogFileName(const aValue: AnsiString);
   function pm_GetEMailNotifyList: AnsiString;
   procedure pm_SetEMailNotifyList(const aValue: AnsiString);
 protected
 // overridden protected methods
   class function GetTaggedDataType: Tk2Type; override;
 public
 // overridden public methods
   constructor Create(aUserID: TUserID); override;
 public
 // public properties
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
     read pm_GetEMailNotifyList
     write pm_SetEMailNotifyList;
 end;//TcsAutoClassTask
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  AutoClassTask_Const
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsAutoClassTask

function TcsAutoClassTask.pm_GetBuilderFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrBuilderFileName]);
end;//TcsAutoClassTask.pm_GetBuilderFileName

procedure TcsAutoClassTask.pm_SetBuilderFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrBuilderFileName, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetBuilderFileName

function TcsAutoClassTask.pm_GetResultFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrResultFileName]);
end;//TcsAutoClassTask.pm_GetResultFileName

procedure TcsAutoClassTask.pm_SetResultFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrResultFileName, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetResultFileName

function TcsAutoClassTask.pm_GetSourceFolder: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrSourceFolder]);
end;//TcsAutoClassTask.pm_GetSourceFolder

procedure TcsAutoClassTask.pm_SetSourceFolder(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrSourceFolder, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetSourceFolder

function TcsAutoClassTask.pm_GetLogFileName: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrLogFileName]);
end;//TcsAutoClassTask.pm_GetLogFileName

procedure TcsAutoClassTask.pm_SetLogFileName(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attrLogFileName, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetLogFileName

function TcsAutoClassTask.pm_GetEMailNotifyList: AnsiString;
 {-}
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attreMailNotifyList]);
end;//TcsAutoClassTask.pm_GetEMailNotifyList

procedure TcsAutoClassTask.pm_SetEMailNotifyList(const aValue: AnsiString);
 {-}
begin
 TaggedData.StrW[k2_attreMailNotifyList, nil] := (aValue);
end;//TcsAutoClassTask.pm_SetEMailNotifyList

class function TcsAutoClassTask.GetTaggedDataType: Tk2Type;
 {-}
begin
 Result := k2_typAutoClassTask;
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

{$IfEnd} //not Nemesis

end.