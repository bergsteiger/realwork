program F1ConsultingChecker;

{$APPTYPE GUI}
{$R *.RES}

{.$DEFINE USE_MULTIFILE_ENCODER}

uses
 Windows
 , SysUtils
{$IFDEF USE_MULTIFILE_ENCODER}
 , Classes
 , Controls
 , FileCtrl
{$ENDIF USE_MULTIFILE_ENCODER}
 , Forms
 , IniFiles
 , LocaleMessages in 'i18n\LocaleMessages.pas'
{$IFDEF USE_MULTIFILE_ENCODER}
 , MultiFileEncoder in 'logs\MultiFileEncoder.pas'

 , FolderNotExist in 'forms\FolderNotExist.pas'
 , WaitMessage in 'forms\WaitMessage.pas'
{$ENDIF USE_MULTIFILE_ENCODER}
 ;

const
 c_Application = 'garant.exe';

 c_CommandLine = 'F1ConsultingChecker';
{$IFDEF USE_MULTIFILE_ENCODER}
 c_CommandLinePrefix = '-WaitForExit ';
{$ELSE USE_MULTIFILE_ENCODER}
 c_CommandLinePrefix = '';
{$ENDIF USE_MULTIFILE_ENCODER}

 c_LevelPrefix = '..';

 c_Locale_I18N = '$(UserDefaultLocale)';

 c_Locale_ForceEnglish_Item = 'CommandLine';
 c_Locale_ForceEnglish_Section = 'F1ConsultingChecker';
 c_Locale_ForceEnglish_SubString = ' -eng ';
 c_Locale_ForceEnglish_Value = 'en';

{$IFDEF USE_MULTIFILE_ENCODER}
 c_RunningCopyMutexName = '{0CF308C5-671E-4CD2-B989-97C29522B08D}';
 c_StorageFileName = 'F1GARANT';
{$ENDIF USE_MULTIFILE_ENCODER}

{$I 'shared.inc'}

