unit zsystem;
{$MODE DELPHI}
//{$mode objfpc}{$H+}
{$LONGSTRINGS ON}

interface

uses
Classes, SysUtils,Process,strutils,IniFiles,BaseUnix,unix,Logs, base64,
RegExpr  in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/RegExpr.pas',md5,
users    in '/home/dtouzeau/developpement/artica-postfix/bin/src/artica-install/users.pas',
DATEUTILS;
type
  TStringDynArray = array of string;
  type

  { MyConf }

  { Tsystem }

  Tsystem=class

private
     mem_mysql_password:string;
     MEM_TOTAL_INSTALLEE_MEMORY:integer;
     MEM_PHP5_EXTENSION_DIR:string;
     MEM_CGEXEC:string;
     mem_mysql_user:string;
     mem_mysql_server:string;
     mem_mysql_port:string;
     mem_pgrep:string;
     mem_ps_path:string;
     mem_cpulimit_value:string;
     mem_monit_bin_path:string;
     mem_ldap_admin:string;
     mem_ldap_password:string;
     mem_ldap_port:string;
     mem_ldap_server:string;
     mem_ldap_suffix:string;
     ISMemoryHiger1G_STR:string;
     cgconfigparser_mem:string;
     DisableEtcHosts:integer;
     DisableCgroups:integer;
     LXC_INSTALLED:integer;
     MONIT_CHECK_LIST:Tstringlist;
     MONIT_DEBUG:boolean;
     DEBUG:boolean;
        ArticaDirectory:string;
        ArticaBuildPath:string;
        version:string;
        ConFile:string;
        pidof_path:string;

        MEM_ADMIN_MAIL:string;
        WildCard:string;
       DisableFollowServiceHigerThan1G:integer;

       function LOCATE_PHP5_EXTENSION_INMEM():string;
       function IS_ZOMBIE(PID:string):boolean;
       function LOCATE_PHP5_EXTENSION_DIR_OLD():string;
       function LOCATE_PHP5_EXTENSION_DIR_GW():string;
       function PROCESS_MEMORY_SINGLE(PID:string):integer;
       function LIST_PID_BY_PIDFATHER(PPID:string):TstringList;

       function UIDFromName(username:string):Integer;
       function DirectoryListTstring(path:string):TstringList;
       function PidByProcessPath_PPID(pid:string):string;
       function TrimSpaces(stemp: string): string;
       function IsBinaryString(const Value: string): Boolean;
       function TransFormBinaryString(const Value: string): string;
       function GET_PPID(PID:integer):integer;
       function Explode(const Separator, S: string; Limit: Integer = 0):TStringDynArray;

       procedure CLEAN_PHP_INI(path:string);
       function  MAILLOG_FROM_SYSLOGNG():string;
       function usbType(dev:string):string;
       function DirectorySize(const dir: string): longint;
       function FileMaskSize(const mask: string): longint;
       function LOAD_CURRENT():string;
       function MAILLOG_REGEX_PATH(logconfig:string=''):string;
       function LOCATE_PHP5_EXTENSION_DIR_MANU():string;
       function FILE_TEMP():string;


public
      ProcessIDList:TstringList;
      verbosed:boolean;
      SearchSize:integer;
      PLISTPID:TstringList;
      DirListFiles:TstringList;
      constructor Create();
      function GIDFromName(group_name:string):Integer;
      function Load_DisableFollowServiceHigerThan1G():integer;
      function CHECK_PERL_MODULES_VER(ModulesToCheck:string):string;
      function GET_LANGUAGE_LOCAL():string;
      procedure Free;
      function COMMANDLINE_PARAMETERS(FoundWhatPattern:string):boolean;
      function DU_PATH():string;
       procedure BuildArticaFiles();
       procedure AddShell(username:string);
       function  MD5FromString(value:string):string;
       function  BuildPids():boolean;
       function  FileSymbolicExists(path:string):boolean;
       function  FILE_FormatSize(FS: integer): string;
       procedure FILE_DELETE(TargetPath:string);
       function  IsGroupExists(groupname:string):boolean;
       function  IsUserINGroup(groupname:string;user:string):boolean;
       procedure cpulimit(pid:string='');
       function  SYSTEM_GET_MYPID():string;
       function  SystemUserID(username:string):string;
       function  SystemGroupID(group_name:string):string;
       function  DirectoryGroupOwner(path:string):string;
       function  IsDirectory(path:string):boolean;
       function  SystemGroupName(group_id:dword):string;
       function  IsUserExists(username:string):boolean;
       procedure CreateGroup(Groupname:string);
       procedure AddUserToGroup(username:string;groupname:string;xshell:string;sHome:string);
       function  DirectoryCountFiles(FilePath: string):integer;
       function  ScanArticaFiles(FilePath:string):integer;
       procedure ShowScreen(line:string);
       function  ScanINIArticaFiles(key:string):string;
       function  ScanINIArticaFilesSave(key:string;Value:string):string;
       function  DirFiles(FilePath: string;pattern:string):TstringList;

       function DirDir(FilePath: string):TstringList;
       function DomainName():string;

       function DISKS_STATUS_DEV():string;
       function DISKS_INODE_DEV():string;
       function DISK_FORMAT_UNIX(dev:string):string;
       procedure FSTAB_ADD(dev:string;mount_point:string);
       function DISK_USB_EXISTS(uuid:string):boolean;
       function DISK_USB_DEV_SOURCE(uuid:string):string;
       function DISK_USB_TYPE(uuid:string):string;
       function DISK_USB_IS_MOUNTED(source:string;destination:string):boolean;
       function disk_build_unique_partition(dev:string;disk_label:string):string;
       function disk_fstab_target_already_set(target:string):boolean;
       function usbLabel(dev:string):string;
       procedure usb_change_disk_label(dev:string;newname:string);
       function  MD5Sum(path:string):string;
       function  SearchFilesInPath(path: string;filter:string):TstringList;
       function  GetDirectorySize(path:string):longint;
       function  GetDirectoryList(path:string):longint;
       function  DirDirRecursive(FilePath: string):TstringList;
       procedure FindDirs(ADir: string);
       function  DirFilesByls(Path: string;pattern:string):TstringList;
       function  RecusiveListFiles(path:string):TstringList;
       function  zGetUsername(gid:string):string;
       function  MembersList(groupname:string):TstringList;
       function  NetBiosName():string;
       function  FILE_TIME_BETWEEN_MIN(filepath:string):LongInt;
       function  GET_PID_FROM_PATH(pidPath:string):string;
       function  GetRemoteComputerRessources(computername:string;username:string;password:string):string;

       function  PROCESS_EXIST(pid:string):boolean;
       function  PROCESS_MEMORY(PID:string):integer;
       function  PROCESS_STATUS(PID:string):string;
       function  PROCESS_EXISTS_BY_NAME(processname:string):boolean;
       function  PROCESS_NUMBER(process:string):integer;
       function  PROCESSES_LIST(process:string):string;
       function  PROCCESS_TIME_MIN(pid:string):integer;
       function  PROCESSES_LIST_STRINGLIST(process:string):Tstringlist;
       function  PROCESS_ISCHROOTED(pid:string):boolean;
       function  PIDOF(process:string):string;
       function  PIDOF_PATTERN(pattern:string):string;
       function  PIDOF_PATTERN_PROCESS_NUMBER(pattern:string):integer;
       function  PIDOF_PATTERN_PROCESS_LIST(pattern:string):TstringList;
       function  ReadFromFile(TargetPath:string):string;

       function  ETC_SERVICES_PORT(servicename:string):integer;

       function  OPENSSL_TOOL_PATH():string;
       function  OPENSSL_CONFIGURATION_PATH():string;
       procedure OPENSSL_CERTIFCATE_CONFIG();
       function  OPENSSL_CERTIFCATE_HOSTS():string;
       function FILE_CHOWN(username:string;groupname:string;path:string):boolean;
       function PROCESS_LIST_PID(processname:string):string;
       procedure RemoveService(servicename:string);
       function FOLDER_SIZE(path:string):integer;
         function FileSize_bytes(path:string):longint;
       function FOLDER_SIZE_HUMAN(path:string):string;
       function sudo_path():string;
       function HOSTNAME_g():string;
       function ReadFileIntoString(path:string):string;
       function FileSize_ko(path:string):longint;
       function RRDTOOL_BIN_PATH():string;
       function ReadFileIntoStringHTML(path:string):string;
       procedure TEST_MECHANISM();
       procedure DeleteService(servicename:string);
       function  txt_uris(artica_port:string):string;
       function  GET_INFO(key:string):string;
       procedure set_INFOS(key:string;val:string);
       procedure set_INFO(key:string;val:string);
       procedure SET_PHP_INI(KEY:string;VALUE_NAME:string;VALUE:string);
       procedure set_CLUSTER(key:string;val:string);
       function  GET_CLUSTER(key:string):string;

       function  MYSQL_INFOS(key:string):string;
       function  MYSQL_STATUS():boolean;
       procedure set_MYSQL(key:string;val:string);

       function  GET_PERFS(key:string):string;
       procedure  SET_PERFS(key:string;value:string);
       function  GET_ENGINE(key:string):string;
       procedure SET_ENGINE(valuename:string;valuedata:string);
       function  ip_forward_enabled():boolean;
       function GET_MYSQL(key:string):string;

       //mount, usb
       function  isMountedTargetPath(path:string):boolean;
       function  usbMountPoint(target_uuid:string):string;
       function  usbExtType(target_uuid:string):string;
       function  usb_mount_point(path:string):string;
       procedure usb_change_label(uuid:string;newname:string);
       function  disk_change_fstab(dev:string;ext:string;target:string):string;
       function  isMounteddev(dev:string):boolean;
       function  GetMountedDev(dev:string):Tstringlist;
       function  LINUX_DISTRIBUTION():string;

       function WHO_LISTEN_PORT(port:string):string;

       //Netwrok
       procedure ETC_HOSTS_ADD(servername:string;ip:string);

       //processes
       function ExecPipe(commandline:string):string;
       procedure COMPILE_PROXY();
       function GET_PHP_INI(key:string):string;
       function LOCATE_OPENSSL_TOOL_PATH():string;
       function LOCATE_APACHE_INITD_PATH:string;
       function LOCATE_BRCTL():string;
       function LOCATE_SENDMAIL_CF():string;
       function LOCATE_FDISK():string;
       function LOCATE_GPG():string;
       function LOCATE_BLKID():string;
       function LOCATE_DSPAM():string;
       function LOCATE_SLAPCAT():string;
       function LOCATE_DPKG():string;
       function LOCATE_DANSGUARDIAN_BIN_PATH():string;
       function LOCATE_DPKG_QUERY():string;
       function LOCATE_mysqld_bin():string;
       function materiel_get_temperature():string;
       function LOCATE_sensors_detect():string;
       function LOCATE_NMAP():string;
       function LOCATE_mysql_bin():string;
       function LOCATE_MYSQLDUMP():string;
       function LOCATE_MYSHOTCOPY():string;
       function LOCATE_SYSLOG_CONF():string;
       function LOCATE_SYSLOG_PATH():string;
       function LOCATE_AUTHLOG_PATH():string;
       function LOCATE_OBM_SHARE():string;
       function LOCATE_PECL():string;
       function LOCATE_MAILPARSE_SO():string;
       function LOCATE_IMAP_SO():string;
       function LOCATE_POSIX_SO():string;
       function LOCATE_SESSSION_SO():string;
       function LOCATE_LDAP_SO():string;
       function LOCATE_MOUNT():string;
       function LOCATE_PHP5_EXTENSION_DIR():string;
       function LOCATE_PHP5_SESSION_PATH():string;
       function LOCATE_PHP5_BIN():string;
       function LOCATE_APT_GET():string;
       function LOCATE_MCRYPT_SO():string;
       function LOCATE_XAPIAN_SO():string;
       function LOCATE_GEOIP_SO():string;
       function LOCATE_MYSQL_SO():string;
       function LOCATE_MAPI_SO():string;
       function LOCATE_GD_SO():string;
       function LOCATE_EACCELERATOR_SO():string;
       function LOCATE_STUNNEL():string;
       function FREE_PORT():integer;
       function LOCATE_APACHE_BIN_PATH():string;
       function LOCATE_APACHE_LIBPHP5():string;
       function LOCATE_APACHE_MODSSLSO():string;
       function LOCATE_APACHE_MODULES_PATH():string;
       function LOCATE_MIME_TYPES():string;
       function LOCATE_SYSLOG_NG_PATH():string;
       function LOCATE_PHP5_EXTCONF_DIR():string;
       function LOCATE_SLAPADD():string;
       function LOCATE_SLAPINDEX():string;
       function LOCATE_APT_CACHE():string;
       function LOCATE_SU():string;
       function LOCATE_cyrreconstruct():string;
       function LOCATE_ctl_mboxlist():string;
       function LOCATE_ctl_cyrusdb():string;
       function LOCATE_DF():string;
       function LOCATE_PRELOAD():string;
       function LOCATE_POSTFIX_MAILDROP():string;
       function LOCATE_SYSLOG():string;
       function LOCATE_SMBMOUNT():string;
       function LOCATE_INETD():string;
       function LOCATE_NOHUP():string;
       function LOCATE_UPDATE_INETD():string;
       function LOCATE_INETD_INITD():string;
       function LOCATE_MAKE():string;
       function LOCATE_AUTH_LOG():string;
       function LOCATE_GCC():string;
       function LOCATE_SLAPD():string;
       function LOCATE_TAR():string;
       function LOCATE_PERL_BIN():string;
       function LOCATE_LIGHTTPD_BIN_PATH():string;
       function LOCATE_IPTABLES():string;
       function LOCATE_PHP5_CGI():string;
       function LOCATE_PHP5_CONFIG_BIN():string;
       function LOCATE_LIGHTTPD_ANGEL_BIN_PATH():string;
       function LOCATE_ZIP():string;
       function LOCATE_PIDOF():string;
       function LOCATE_MYSQL_ADMIN():string;
       function LOCATE_CUPS_ACCEPT():string;
       function LOCATE_EACCELERATOR_SO_GW():string;
       function LOCATE_AWSTATS_BIN_PATH():string;
       function LOCATE_MKFIFO():string;
       function LOCATE_SYSLOG_NG_CONF():string;
       function LOCATE_SMBCLIENT():string;
       function LOCATE_LSHW():string;
       function LOCATE_APACHECTL():string;
       function LOCATE_CYRQUOTA():string;
       function LOCATE_SHOWMOUNT():string;
       function LOCATE_PVCREATE():string;
       function LOCATE_CYRUS_SQUATTER():string;
       function LOCATE_CYRUS_IPURGE():string;
       function LOCATE_LVS():string;
       function LOCATE_PVS():string;
       function LOCATE_VGCREATE():string;
       function LOCATE_LVDISPLAY():string;
       function LOCATE_LVREMOVE():string;
       function LOCATE_LVRCREATE():string;
       function LOCATE_LVMDISKSCAN():string;
       function LOCATE_MPSTAT():string;
       function LOCATE_NDB():string;
       function LOCATE_CUT():string;
       function LOCATE_UPTIME():string;
       function LOCATE_NDB_MGMD():string;
       function LOCATE_ROTATELOGS():string;
       function LOCATE_FREE():string;
       function LOCATE_PDNS_BIN():string;
       function LOCATE_CRYPTSETUP():string;
       function LOCATE_GENERIC_BIN(StrProgram:string):string;
       function LOCATE_ZABBIX_SERVER():string;
       function LOCATE_ZABBIX_AGENT():string;
       function LOCATE_PYTHON_PACKAGE(BasePath:string):string;
       function ISMemoryHiger1G():boolean;
       function LOCATE_APC_SO():string;
       function MEM_FREE():integer;
       function locate_roundcube_main_folder():string;
       function isoverloadedTooMuch():boolean;
       function LOCATE_POSTSCREEN():string;

       procedure SecureWeb(path: string);

       function LOCATE_APACHE_STANDARD_CONF():string;
       function APACHE_STANDARD_PORT():string;
       function LOCATE_APACHE_INITD():string;
       procedure APACHE_STANDARD_PORT_CHANGE(portnumber:string);
        function CPU_NUMBER():integer;
       function LOAD_AVERAGE():string;
       procedure StripDiezes(filepath:string);

       procedure SYSTEM_ADD_MODULE(module_name:string);
       function  CHECK_PERL_MODULES(ModulesToCheck:string):boolean;
       function  CHECK_PERL_MODULES_VERSION(ModulesToCheck:string):string;
       function  SMBMOUNT_VERSION():string;
       function  APP_UNZIP_VERSION():string;
       function  croned_minutes():boolean;
       function  LOCATE_IP_TOOL():string;
       function  LOCATE_mysqld_safe():string;


       procedure ifconfig(path:string);
       function  ifconfig_text():string;
       function  ifconfig_html():string;
       function  NIC_LIST_ROUTES(eth:string):TstringList;


       function  https_uris(artica_port:string):string;
       function  LOCATE_CURL():string;
       function  FILE_TIME_BETWEEN_SEC(filepath:string):LongInt;
       function  FILE_TIME(filepath:string):string;
       function  croned_seconds(maxsec:integer):boolean;
       function  croned_minutes2(maxmin:integer):boolean;
       function  ReadFileIntoString2(path:string):string;

       //PID
       function PidByProcessPath(ExePath:string):string;
       function PidAllByProcessPath(ExePath:string):string;
       function PidByPatternInPath(pattern:string):string;
       function AllPidsByPatternInPathTstrings(pattern:string):TstringList;
       procedure THREAD_COMMAND_SET(zcommands:string);
       function CRON_CREATE_SCHEDULE(ProgrammedTime:string;Croncommand:string;name:string):boolean;
       function MAILLOG_PATH():string;
       function CPU_MHZ():string;

       //INETD
       function INETD_PID():string;
       function INETD_VERSION():string;
       FUNCTION INETD_STATUS():string;

       //MEMCHACHED
       function LOCATE_MEMCACHED_VERSION():string;
       function LOCATE_MEMCACHED():string;

       //VERSIONING
       function GET_CACHE_VERSION(APP_NAME: string):string;
       procedure SET_CACHE_VERSION(APP_NAME:string;version:string);

       //MBMON
       function  LOCATE_MBMON():string;


       //HTTP
       function  GET_HTTP_PROXY:string;
       function  WGET_DOWNLOAD_FILE(uri:string;file_path:string;JustHead:boolean=false;wgetforce:boolean=false):boolean;
       procedure SET_HTTP_PROXY(proxy_string:string);
       function  REMOVE_HTTP_PROXY:string;
       //DEBIAN
        function DEBIAN_VERSION():string;
        function FindPidByPath(path:string):string;
        function RotationSeconds(SecondsNumber:integer):boolean;
        function backports_Exists():boolean;
        function AllPidsByPatternInPath(pattern:string):string;
        function EXEC_NICE():string;
        function ARTICA_VERSION():string;
        function CHANGE_SERVICES_IP(servicename:string;port:string):string;
        function ADMIN_MAIL():string;
        function chmod_757(path:string):string;
        function isoverloaded():boolean;
        function MEM_TOTAL_INSTALLEE():integer;
        function ArrayAlreadyUsed(arrayS:Tstringlist;pattern:string):boolean;
        function IS_GLFS_MOUNTED(mounted:string):boolean;
        procedure JGrowl(subject:string;text:string);
        function TEST_IONICE():boolean;
        function VMWARE_HOST():boolean;
        procedure etc_ld_so_conf(path:string);
        function GET_CPU_POURCENT(PID:integer):integer;




        procedure DetectVerbosed();

        function LIGHTTPD_GET_USER():string;
        function LIGHTTPD_CONF_PATH:string;
        function LIGHTTPD_LISTEN_PORT():string;
        function WIRELESS_CARD():string;
        function ArchStruct():integer;
        function base64_encode(value:string):string;
        function get_LDAP(key:string):string;
        function PEAR_MODULES():string;
        function VIRTUALBOX_HOST():boolean;
        function ESCAPE_PASSWORD(password:string):string;
        function LOCAL_IP_AVAILABLE(ipstring:string):boolean;
        function LOCATE_DB_RECOVER():string;
        function IS_INSIDE_VPS():boolean;
        function SIEVE_PORT():string;
        function APACHE_IS_MOD_PROXY():boolean;
        function IPTABLES_ACCOUNTING_EXISTS():boolean;
        function DISTRIBUTION_CODE():string;
        function txt_ip_agents():string;
        function txt_ip_agents_line():string;
        function txt_ip_agents_line_port(port:string):string;
END;

implementation

constructor Tsystem.Create();
begin
   ConFile:='';
   WildCard:='*';
   MONIT_DEBUG:=false;
   ForceDirectories('/opt/artica/tmp');
   DirListFiles:=TstringList.Create();
   DetectVerbosed();
   DisableFollowServiceHigerThan1G:=Load_DisableFollowServiceHigerThan1G();
   MONIT_CHECK_LIST:=Tstringlist.Create;
   DisableEtcHosts:=0;
   LXC_INSTALLED:=0;
   if not TRyStrToInt(GET_INFO('DisableEtcHosts'),DisableEtcHosts) then DisableEtcHosts:=0;
   if not TRyStrToInt(GET_INFO('DisableCgroups'),DisableCgroups) then DisableCgroups:=0;
   if length(LOCATE_GENERIC_BIN('lxc-version'))>3 then LXC_INSTALLED:=1;
   DEBUG:=COMMANDLINE_PARAMETERS('--verbose');

end;
PROCEDURE Tsystem.Free();
begin
DirListFiles.Clear;
DirListFiles.Free;
MONIT_CHECK_LIST.free;
end;
//#############################################################################
function Tsystem.LOCAL_IP_AVAILABLE(ipstring:string):boolean;
var
   l:Tstringlist;
   i:integer;
   binpath,tmpstr:string;
   RegExpr:TRegExpr;
begin
result:=false;
tmpstr:=FILE_TEMP();
if not FileExists(tmpstr) then begin
   binpath:=LOCATE_GENERIC_BIN('ifconfig');
   fpsystem(binpath+' -a >'+tmpstr+' 2>&1');
end;

l:=TstringList.Create;
l.LoadFromFile(tmpstr);
RegExpr:=TRegExpr.Create;
ipstring:=trim(ipstring);
ipstring:=AnsiReplaceText(ipstring,'.','\.');
RegExpr.Expression:=ipstring;
for i:=0 to l.Count -1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       result:=true;
       l.free;
       RegExpr.free;
       exit(true);
    end;
end;
       l.free;
       RegExpr.free;


end;
//#############################################################################

function Tsystem.ESCAPE_PASSWORD(password:string):string;
begin
     result:=password;
result:=AnsiReplaceText(result,' ','\ ');
result:=AnsiReplaceText(result,'$','\$');
result:=AnsiReplaceText(result,'&','\&');
result:=AnsiReplaceText(result,'?','\?');
result:=AnsiReplaceText(result,'#','\#');
result:=AnsiReplaceText(result,'[','\[');
result:=AnsiReplaceText(result,']','\]');
result:=AnsiReplaceText(result,'{','\{');
result:=AnsiReplaceText(result,'}','\}');
result:=AnsiReplaceText(result,'*','\*');
result:=AnsiReplaceText(result,'"','\"');
result:=AnsiReplaceText(result,'''','\''');
result:=AnsiReplaceText(result,'(','\(');
result:=AnsiReplaceText(result,')','\)');
result:=AnsiReplaceText(result,'<','\<');
result:=AnsiReplaceText(result,'>','\>');
result:=AnsiReplaceText(result,'!','\!');
result:=AnsiReplaceText(result,'+','\+')
end;


procedure Tsystem.ETC_HOSTS_ADD(servername:string;ip:string);
begin
end;




//#############################################################################
function Tsystem.get_LDAP(key:string):string;
var
   value:string;
   Ini:TMemIniFile;
   get_LDAP_logs:Tlogs;
begin

if key='admin' then begin
    if length(mem_ldap_admin)>0 then exit(mem_ldap_admin);
end;

if key='password' then begin
    if length(mem_ldap_password)>0 then exit(mem_ldap_password);
end;

if key='port' then begin
    if length(mem_ldap_port)>0 then exit(mem_ldap_port);
end;

if key='server' then begin
    if length(mem_ldap_server)>0 then exit(mem_ldap_server);
end;

if key='suffix' then begin
    if length(mem_ldap_suffix)>0 then exit(mem_ldap_suffix);
end;

if DirectoryExists('/etc/artica-postfix/ldap_settings') then begin
   if FileExists('/etc/artica-postfix/ldap_settings/'+key) then begin
      get_LDAP_logs:=Tlogs.Create;
      result:=trim(get_LDAP_logs.ReadFromFile('/etc/artica-postfix/ldap_settings/'+key));
      get_LDAP_logs.free;
      if key='admin' then mem_ldap_admin:=result;
      if key='password' then mem_ldap_password:=result;
      if key='port' then mem_ldap_port:=result;
      if key='server' then mem_ldap_server:=result;
      if key='suffix' then mem_ldap_suffix:=result;
      exit;
   end;
end;

if FileExists('/etc/artica-postfix/artica-postfix-ldap.conf') then begin
   try
      Ini:=TMemIniFile.Create('/etc/artica-postfix/artica-postfix-ldap.conf');
      except
      exit;
   end;
   value:=trim(Ini.ReadString('LDAP',key,''));
   Ini.Free;
end;
if length(value)=0 then begin
 if FileExists('/etc/artica-postfix/artica-postfix-ldap.bak.conf') then begin
    try
       Ini:=TMemIniFile.Create('/etc/artica-postfix/artica-postfix-ldap.bak.conf');
     except
      exit;
    end;
    value:=Ini.ReadString('LDAP',key,'');
    Ini.Free;
    if length(value)>0 then begin
       result:=value;
    end;
  end;
end;
    if key='server' then begin
        if length(result)=0 then result:='127.0.0.1';
    end;

    if key='port' then begin
        if length(result)=0 then result:='389';
    end;

      if key='admin' then mem_ldap_admin:=result;
      if key='password' then mem_ldap_password:=result;
      if key='port' then mem_ldap_port:=result;
      if key='server' then mem_ldap_server:=result;
      if key='suffix' then mem_ldap_suffix:=result;
result:=value;

end;
//#############################################################################


//##############################################################################
procedure Tsystem.DetectVerbosed();
begin
   if verbosed then exit;
   if not verbosed then verbosed:=COMMANDLINE_PARAMETERS('--verbose');

end;
//##############################################################################


function Tsystem.IsGroupExists(groupname:string):boolean;
var gpid:integer;
begin
gpid:=0;
 result:=False;
     try
        gpid:=GetGroupId(groupname);
        if verbosed then writeln('IsGroupExists::',groupname,':',gpid);
        if gpid>0 then exit(true);
     except
     exit();
     end;
end;
//##############################################################################
function Tsystem.Load_DisableFollowServiceHigerThan1G():integer;
begin
if not FileExists('/etc/artica-postfix/performances.conf') then exit(0);
if not TryStrToInt(GET_PERFS('DisableFollowServiceHigerThan1G'),result) then result:=0;
end;
//##############################################################################

function Tsystem.SystemUserID(username:string):string;
begin
 result:='';

  try
     result:=IntToSTr(GetUserId(username));
  except
  exit();
  end;
end;
//##############################################################################
function Tsystem.SystemGroupID(group_name:string):string;
begin
 try
    result:=IntToStr(GetGroupId(group_name));
     except
     exit();
     end;
end;
//##############################################################################
function Tsystem.GIDFromName(group_name:string):Integer;
begin
result:=0;
 try
    result:=GetGroupId(group_name);
     except
     exit();
     end;
end;
//##############################################################################
function Tsystem.UIDFromName(username:string):Integer;
begin
 result:=0;

  try
     result:=GetUserId(username);
  except
  exit();
  end;
end;
//##############################################################################
function Tsystem.DirectoryGroupOwner(path:string):string;
var info:stat;
var Guid:dword;
begin
if fpstat(path,info)=0 then  begin
  Guid:=info.st_gid;
  Result:=SystemGroupName(Guid);
end;
end;
//##############################################################################
function Tsystem.SystemGroupName(group_id:dword):string;
begin
 result:='';

  try
     result:=GetGroupName(group_id);
  except
  exit();
  end;
end;
//##############################################################################
function Tsystem.ARTICA_VERSION():string;
var
   logs:Tlogs;
begin
     logs:=Tlogs.Create;
     result:=logs.ReadFromFile('/usr/share/artica-postfix/VERSION');
end;
//##############################################################################
function Tsystem.base64_encode(value:string):string;
var
  DecodedStream: TStringStream;
  EncodedStream: TStringStream;
  Encoder: TBase64EncodingStream;
begin

DecodedStream := TStringStream.Create('Hello World!');
  EncodedStream := TStringStream.Create('');
  Encoder       := TBase64EncodingStream.Create(EncodedStream);
  Encoder.CopyFrom(DecodedStream, DecodedStream.Size);
  result := EncodedStream.DataString;
  DecodedStream.Free;
  EncodedStream.Free;
  Encoder.Free;
end;
//##############################################################################
function Tsystem.IsUserINGroup(groupname:string;user:string):boolean;
var
   l:TstringList;
   i:integer;
begin
result:=false;
if groupname=user then begin
   result:=true;
   exit(true);
end;

l:=TstringList.Create;
try
GetGroupMembers(groupname,l);
  except
  exit();
  end;

for i:=0 to l.Count-1 do begin
    if l.Strings[i]=user then begin
       result:=true;
       exit;
    end;
end;
l.free;
end;
//##############################################################################
function Tsystem.chmod_757(path:string):string;
var
mode:mode_t;
begin
try

 // fpchmod(path,&757);
except
end;
end;
//##############################################################################
function Tsystem.NetBiosName():string;
var
   txt:string;
   RegExpr:TRegExpr;
begin
result:='';
fpsystem('/bin/hostname >/tmp/hostname.txt');
    txt:=ReadFileIntoString('/tmp/hostname.txt');
    txt:=trim(result);
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='(.+?)\.';
    if RegExpr.Exec(txt) then result:=RegExpr.Match[1] else result:=trim(txt);
    RegExpr.free;
end;
//##############################################################################
function Tsystem.DomainName():string;
begin
    result:='';
    fpsystem('/bin/hostname -d >/tmp/domainname.txt');
    result:=ReadFileIntoString('/tmp/domainname.txt');
    result:=trim(result);
end;
//##############################################################################

procedure Tsystem.RemoveService(servicename:string);
begin
 if FileExists('/usr/sbin/update-rc.d') then begin
    fpsystem('/usr/sbin/update-rc.d -f '+servicename+' remove >/dev/null 2>&1');
 end;

  if FileExists('/sbin/chkconfig') then begin
     fpsystem('/sbin/chkconfig --delete '+servicename+' >/dev/null 2>&1');
  end;

end;

//##############################################################################
function Tsystem.DU_PATH():string;
begin
    if FileExists('/usr/bin/du') then exit('/usr/bin/du');

end;
//#########################################################################################
function Tsystem.LOCATE_FREE():string;
begin
    if fileExists('/usr/bin/free') then exit('/usr/bin/free');
    if fileExists('/bin/free') then exit('/bin/free');
    if fileExists('/sbin/free') then exit('/sbin/free');
    if fileExists('/usr/local/bin/free') then exit('/usr/local/bin/free');
    if fileExists('/usr/local/sbin/free') then exit('/usr/local/sbin/free');
end;
//#########################################################################################
function Tsystem.LOCATE_CRYPTSETUP():string;
begin
    if fileExists('/usr/bin/cryptsetup') then exit('/usr/bin/cryptsetup');
    if fileExists('/bin/cryptsetup') then exit('/bin/cryptsetup');
    if fileExists('/sbin/cryptsetup') then exit('/sbin/cryptsetup');
    if fileExists('/usr/local/bin/cryptsetup') then exit('/usr/local/bin/cryptsetup');
    if fileExists('/usr/local/sbin/cryptsetup') then exit('/usr/local/sbin/cryptsetup');
end;
//#########################################################################################
function Tsystem.ISMemoryHiger1G():boolean;
var
   mem:integer;
   DisableFollowServiceHigerThan1G:integer;
begin
if length(ISMemoryHiger1G_STR)>0 then begin
   if ISMemoryHiger1G_STR='TRUE' then exit(true);
   if ISMemoryHiger1G_STR='FALSE' then exit(false);
end;
if not TryStrToInt(GET_PERFS('DisableFollowServiceHigerThan1G'),DisableFollowServiceHigerThan1G) then DisableFollowServiceHigerThan1G:=0;

if DisableFollowServiceHigerThan1G=1 then begin
   ISMemoryHiger1G_STR:='TRUE';
   exit(true);
end;

  mem:=MEM_TOTAL_INSTALLEE();

  if mem=0 then exit(true);
  if mem>1012024 then begin
     ISMemoryHiger1G_STR:='TRUE';
     exit(true);
  end;

  ISMemoryHiger1G_STR:='FALSE';
  exit(false);
end;
//#########################################################################################
function Tsystem.MEM_TOTAL_INSTALLEE():integer;
var
   l:TstringList;
   RegExpr:TRegExpr;
   uioLogs:Tlogs;
   filetmp:string;
   i:integer;
   mem:integer;
   FileCache:string;
   MEM_TOTAL_INSTALLEE_LOGS:Tlogs;
   MEM_TOTAL_INSTALLEE_TEMP:string;
   D:Boolean;
   FileTimeMin:integer;
begin
result:=0;

if MEM_TOTAL_INSTALLEE_MEMORY>500 then exit(MEM_TOTAL_INSTALLEE_MEMORY);

MEM_TOTAL_INSTALLEE_LOGS:=Tlogs.Create;

    FileCache:='/etc/artica-postfix/MEMORY_INSTALLED';
    FileTimeMin:=FILE_TIME_BETWEEN_MIN(FileCache);
    if verbosed then writeln(FileCache,' -> ', FileTimeMin,'Mn');
    if FileTimeMin<380 then begin
       MEM_TOTAL_INSTALLEE_TEMP:=trim(MEM_TOTAL_INSTALLEE_LOGS.ReadFromFile(FileCache));
       if TryStrToInt(MEM_TOTAL_INSTALLEE_TEMP,i) then begin
          if i>10 then begin
             MEM_TOTAL_INSTALLEE_MEMORY:=i;
             exit(i);
             end;
          end;
       end;


    result:=1012029;
    if not FileExists('/proc/meminfo') then begin
       MEM_TOTAL_INSTALLEE_MEMORY:=result;
        exit(result);
    end;

    l:=Tstringlist.Create;
    try
       l.LoadFromFile('/proc/meminfo');
    except
          exit();
    end;


    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='MemTotal:\s+([0-9]+)';
    for i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
               if verbosed then writeln(l.Strings[i],' -> ',RegExpr.Match[1]);
              if not TryStrToInt(RegExpr.Match[1],mem) then begin
                  result:=1012029;
                  MEM_TOTAL_INSTALLEE_MEMORY:=result;
                  l.free;
                  RegExpr.free;
                  exit;
              end;
              result:=mem;
              MEM_TOTAL_INSTALLEE_MEMORY:=result;
              break;
        end;
    end;
    MEM_TOTAL_INSTALLEE_LOGS.DeleteFile(FileCache);
    MEM_TOTAL_INSTALLEE_LOGS.WriteToFile(IntTostr(result),FileCache);
    l.free;
    RegExpr.free;


end;
//#########################################################################################
function Tsystem.LOCATE_DB_RECOVER():string;
begin
result:=LOCATE_GENERIC_BIN('db4.9_recover');
if FileExists(result) then exit;
result:=LOCATE_GENERIC_BIN('db4.8_recover');
if FileExists(result) then exit;
result:=LOCATE_GENERIC_BIN('db4.7_recover');
if FileExists(result) then exit;
result:=LOCATE_GENERIC_BIN('db4.6_recover');
if FileExists(result) then exit;
result:=LOCATE_GENERIC_BIN('db4.5_recover');
if FileExists(result) then exit;
result:=LOCATE_GENERIC_BIN('db_recover');
if FileExists(result) then exit;
end;
function Tsystem.MEM_FREE():integer;
var
   l:TstringList;
   RegExpr:TRegExpr;
   uioLogs:Tlogs;
   filetmp:string;
   i:integer;
   mem:integer;
begin
result:=0;
    if not FileExists('/proc/meminfo') then exit();
    l:=Tstringlist.Create;
    try
       l.LoadFromFile('/proc/meminfo');
    except
      exit();
    end;
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='MemFree:\s+([0-9]+)';
    for i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
              if not TryStrToInt(RegExpr.Match[1],mem) then begin
                  result:=0;
                  l.free;
                  RegExpr.free;
                  exit;
              end;
              result:=mem;
              break;
        end;
    end;

    l.free;
    RegExpr.free;

end;
//#########################################################################################
function Tsystem.FOLDER_SIZE(path:string):integer;
var
   tempfile:string;
   dupath:string;
   Logs:Tlogs;
   l:TstringList;
   RegExpr:TRegExpr;
   i:integer;
   pid:string;
begin
dupath:=DU_PATH();
tempfile:='/opt/artica/logs/' + MD5FromString(path);
if not DirectoryExists(path) then exit(0);
logs:=Tlogs.Create;
if not FileExists(dupath) then begin
   logs.Debuglogs('SYSTEM_FOLDER_SIZE() unable to stat du path tool');
   exit(0);
end;

pid:=PIDOF(dupath);
if PROCESS_EXIST(pid) then begin
   logs.Debuglogs('SYSTEM_FOLDER_SIZE() : Other instance '+ pid+' pid running');
   exit;
end;


fpsystem(EXEC_NICE()+ dupath + ' -s ' + path + ' >' + tempfile + ' 2>&1');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='([0-9]+)';
if FileExists(tempfile) then begin
    l:=TstringList.Create;
    l.LoadFromFile(tempfile);
    For i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           result:=StrToInt(RegExpr.Match[1]);

           RegExpr.free;
           L.free;
           break;
        end;

    end;
end;
end;
//#########################################################################################
function Tsystem.FOLDER_SIZE_HUMAN(path:string):string;
var
   tempfile:string;
   dupath:string;
   Logs:Tlogs;
   l:TstringList;
   RegExpr:TRegExpr;
   i:integer;
begin
dupath:=DU_PATH();
tempfile:='/opt/artica/logs/' + MD5FromString(path);
if not DirectoryExists(path) then exit();
logs:=Tlogs.Create;
if not FileExists(dupath) then begin
   logs.logs('SYSTEM_FOLDER_SIZE() unable to stat du path tool');
   exit();
end;
fpsystem(dupath + ' -s -h ' + path + ' >' + tempfile + ' 2>&1');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='(.+?)\s+';
if FileExists(tempfile) then begin
    l:=TstringList.Create;
    l.LoadFromFile(tempfile);
    For i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           result:=trim(RegExpr.Match[1]);
           RegExpr.free;
           L.free;
           break;
        end;

    end;
end;
end;
//#########################################################################################
function Tsystem.GET_LANGUAGE_LOCAL():string;
var
   tempfile:string;
   binpath:string;
   Logs:Tlogs;
   l:TstringList;
   RegExpr:TRegExpr;
   i:integer;
begin
binpath:=LOCATE_GENERIC_BIN('locale');
if length(binpath)=0 then exit('en_US.utf8');
tempfile:='/tmp/artica-' + MD5FromString(binpath);
fpsystem(binpath + ' -a >' + tempfile + ' 2>&1');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='^.+?\..+?8';
if FileExists(tempfile) then begin
    l:=TstringList.Create;
    l.LoadFromFile(tempfile);
    For i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           result:=trim(l.Strings[i]);
           RegExpr.free;
           L.free;
           break;
        end;

    end;
end;
end;
//#########################################################################################
function Tsystem.LOCATE_CUT():string;
begin
if FIleExists('/usr/bin/cut') then exit('/usr/bin/cut');
if FIleExists('/bin/cut') then exit('/bin/cut');
if FIleExists('/usr/local/bin/cut') then exit('/usr/local/bin/cut');
end;
//#########################################################################################
function Tsystem.LOCATE_UPTIME():string;
begin
if FIleExists('/usr/bin/uptime') then exit('/usr/bin/uptime');
if FIleExists('/usr/local/bin/uptime') then exit('/usr/local/bin/uptime');
end;
//#########################################################################################
function Tsystem.CPU_NUMBER():integer;
var
   cpunum:integer;
   ziulogs:Tlogs;
   fileconf:string;
   catbin:string;
   grepbin:string;
   wcbin:string;
   cutbin:string;
begin
    result:=0;
    cpunum:=0;
    catbin:=LOCATE_GENERIC_BIN('cat');
    grepbin:=LOCATE_GENERIC_BIN('grep');
    wcbin:=LOCATE_GENERIC_BIN('wc');
    cutbin:=LOCATE_CUT();
    fileconf:='/etc/artica-postfix/settings/Daemons/SystemCpuNumber';
    if FileExists(fileconf) then begin
       if FILE_TIME_BETWEEN_MIN(fileconf)>500 then fpsystem('/bin/rm -f '+ fileconf);
    end;
    if not TryStrToInt(GET_INFO('SystemCpuNumber'),cpunum) then cpunum:=0;


    if cpunum=0 then begin
         fpsystem(catbin+' /proc/cpuinfo |'+grepbin+' "model name" | '+cutbin+' -d: -f2|'+wcbin+' -l >'+fileconf+' 2>&1');
         if not TryStrToInt(GET_INFO('SystemCpuNumber'),cpunum) then begin
              sleep(2);
              fpsystem(catbin+' /proc/cpuinfo |'+grepbin+' "model name" | '+cutbin+' -d: -f2|'+wcbin+' -l >'+fileconf+' 2>&1');
              TryStrToInt(GET_INFO('SystemCpuNumber'),cpunum);
              ziulogs:=Tlogs.Create;
              ziulogs.Syslogs('Tsystem.CPU_NUMBER():: unable to determine cpu number on this system');
              ziulogs.free;
              exit(0);
         end;
    end;

    result:=cpunum;

end;
//#########################################################################################
function Tsystem.IS_GLFS_MOUNTED(mounted:string):boolean;
var
   i:integer;
   tmpstr:Tstringlist;
   d:Boolean;
begin
   d:=false;
   d:=COMMANDLINE_PARAMETERS('--verbose');
   result:=false;
   tmpstr:=TstringList.Create;
   tmpstr.LoadFromFile('/proc/mounts');
   for i:=0 to tmpstr.Count-1 do begin
       if pos(mounted,tmpstr.Strings[i])>0 then begin
          result:=true;
          break;
       end else begin
          if d then writeln('NOT found ',mounted,' in ',tmpstr.Strings[i]);
       end;
   end;

  tmpstr.free;

end;

//#############################################################################
function Tsystem.LOAD_AVERAGE():string;
var
   cpunum:integer;
   ziulogs:Tlogs;
   fileconf:string;
   RegExpr:TRegExpr;
begin
    result:='0.0';
    ziulogs:=Tlogs.Create;
    fileconf:=ziulogs.FILE_TEMP();
    fpsystem(LOCATE_UPTIME()+' >'+fileconf+' 2>&1');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='load average:\s+([0-9\.]+),\s+([0-9\.]+),\s+([0-9\.]+)';
    if RegExpr.Exec(ziulogs.ReadFromFile(fileconf)) then result:=RegExpr.Match[2];
    ziulogs.DeleteFile(fileconf);
    RegExpr.free;
    ziulogs.free;
end;
//#########################################################################################
function Tsystem.FILE_TEMP():string;
var
   ziulogs:Tlogs;
begin
ziulogs:=Tlogs.Create;
result:=ziulogs.FILE_TEMP();
ziulogs.free;
end;
//#########################################################################################
function Tsystem.LOAD_CURRENT():string;
var
   cpunum:integer;
   ziulogs:Tlogs;
   fileconf:string;
   RegExpr:TRegExpr;
begin
    result:='0.0';
    ziulogs:=Tlogs.Create;
    fileconf:=ziulogs.FILE_TEMP();
    fpsystem(LOCATE_UPTIME()+' >'+fileconf+' 2>&1');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='load average:\s+([0-9\.]+),';
    if RegExpr.Exec(ziulogs.ReadFromFile(fileconf)) then result:=RegExpr.Match[1];
    ziulogs.DeleteFile(fileconf);
    RegExpr.free;
    ziulogs.free;
end;
//#########################################################################################
function Tsystem.FREE_PORT():integer;
var
   tempfile:string;
   dupath:string;
   sdLogs:Tlogs;
   l:TstringList;
   RegExpr:TRegExpr;
   i:integer;
begin
sdLogs:=TLogs.Create;
tempfile:=sdLogs.FILE_TEMP();



fpsystem(LOCATE_PHP5_BIN()+' /usr/share/artica-postfix/exec.random-port.php >'+tempfile+' 2>&1');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='<port>([0-9]+)</port>';
if FileExists(tempfile) then begin
    l:=TstringList.Create;
    l.LoadFromFile(tempfile);
    For i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           dupath:=trim(RegExpr.Match[1]);
           TryStrtoInt(dupath,result);
           RegExpr.free;
           L.free;
           break;
        end;

    end;
end;

sdLogs.free;

end;
//#########################################################################################
function Tsystem.LOCATE_APACHE_BIN_PATH():string;
begin
if FileExists('/usr/sbin/apache2') then exit('/usr/sbin/apache2');
if FileExists('/usr/sbin/apache') then exit('/usr/sbin/apache');
if FileExists('/usr/sbin/httpd') then exit('/usr/sbin/httpd');
if FileExists('/usr/sbin/httpd2') then exit('/usr/sbin/httpd2');
if FIleExists('/usr/local/obm-apache/bin/obm-apache') then exit('/usr/local/obm-apache/bin/obm-apache');
if FileExists('/usr/local/apache-groupware/bin/apache-groupware') then exit('/usr/local/apache-groupware/bin/apache-groupware');
end;
//#########################################################################################
function Tsystem.LOCATE_APACHE_INITD():string;
begin
if FileExists('/etc/init.d/apache2') then exit('/etc/init.d/apache2');
if FileExists('/etc/init.d/httpd') then exit('/etc/init.d/httpd');

end;
//#########################################################################################
function Tsystem.LOCATE_CYRQUOTA():string;
begin
if FIleExists('/usr/sbin/cyrquota') then exit('/usr/sbin/cyrquota');
if FileExists('/usr/lib/cyrus/bin/quota') then exit('/usr/lib/cyrus/bin/quota');
if FileExists('/usr/lib/cyrus-imapd/quota') then exit('/usr/lib/cyrus-imapd/quota');
end;
//#########################################################################################
function Tsystem.LOCATE_CYRUS_SQUATTER():string;
begin
if FIleExists('/usr/sbin/squatter') then exit('/usr/sbin/squatter');
if FileExists('/usr/lib/cyrus/bin/squatter') then exit('/usr/lib/cyrus/bin/squatter');
if FileExists('/usr/lib/cyrus-imapd/squatter') then exit('/usr/lib/cyrus-imapd/squatter');
end;
//#########################################################################################
function Tsystem.LOCATE_CYRUS_IPURGE():string;
begin
if FIleExists('/usr/sbin/ipurge') then exit('/usr/sbin/ipurge');
if FileExists('/usr/lib/cyrus/bin/ipurge') then exit('/usr/lib/cyrus/bin/ipurge');
if FileExists('/usr/lib/cyrus-imapd/ipurge') then exit('/usr/lib/cyrus-imapd/ipurge');
end;
//#########################################################################################
function Tsystem.LOCATE_SHOWMOUNT():string;
begin
if FIleExists('/sbin/showmount') then exit('/sbin/showmount');
if FileExists('/usr/sbin/showmount') then exit('/usr/sbin/showmount');
end;
//#########################################################################################
function Tsystem.LOCATE_ROTATELOGS():string;
begin
if FIleExists('/usr/sbin/rotatelogs') then exit('/usr/sbin/rotatelogs');
if FIleExists('/usr/local/sbin/rotatelogs') then exit('/usr/local/sbin/rotatelogs');
if FIleExists('/usr/local/bin/rotatelogs') then exit('/usr/local/bin/rotatelogs');
if FileExists('/usr/sbin/rotatelogs2') then exit('/usr/sbin/rotatelogs2');

end;
//#########################################################################################


function Tsystem.LOCATE_PVCREATE():string;
begin
if FIleExists('/sbin/pvcreate') then exit('/sbin/pvcreate');
if FileExists('/usr/sbin/pvcreate') then exit('/usr/sbin/pvcreate');
end;
//#########################################################################################
function Tsystem.LOCATE_LVS():string;
begin
if FIleExists('/usr/sbin/lvs') then exit('/usr/sbin/lvs');
if FileExists('/sbin/lvs') then exit('/sbin/lvs');
end;
//#########################################################################################
function Tsystem.LOCATE_PVS():string;
begin
if FIleExists('/usr/sbin/pvs') then exit('/usr/sbin/pvs');
if FileExists('/sbin/pvs') then exit('/sbin/pvs');
end;
//########################################################################################
function Tsystem.LOCATE_VGCREATE():string;
begin
if FIleExists('/usr/sbin/vgcreate') then exit('/usr/sbin/vgcreate');
if FileExists('/sbin/vgcreate') then exit('/sbin/vgcreate');
end;
//########################################################################################
function Tsystem.LOCATE_LVDISPLAY():string;
begin
if FIleExists('/usr/sbin/lvdisplay') then exit('/usr/sbin/lvdisplay');
if FileExists('/sbin/lvdisplay') then exit('/sbin/lvdisplay');
end;
//########################################################################################
function Tsystem.LOCATE_LVREMOVE():string;
begin
if FIleExists('/usr/sbin/lvremove') then exit('/usr/sbin/lvremove');
if FileExists('/sbin/lvremove') then exit('/sbin/lvremove');
end;
//########################################################################################
function Tsystem.LOCATE_LVRCREATE():string;
begin
if FIleExists('/usr/sbin/lvcreate') then exit('/usr/sbin/lvcreate');
if FileExists('/sbin/lvcreate') then exit('/sbin/lvcreate');
end;
//########################################################################################
function Tsystem.LOCATE_LVMDISKSCAN():string;
begin
if FIleExists('/usr/sbin/lvmdiskscan') then exit('/usr/sbin/lvmdiskscan');
if FileExists('/sbin/lvmdiskscan') then exit('/sbin/lvmdiskscan');
end;
//########################################################################################
function Tsystem.LOCATE_MPSTAT():string;
begin
if FIleExists('/usr/bin/mpstat') then exit('/usr/bin/mpstat');
end;
//########################################################################################


function Tsystem.DISK_FORMAT_UNIX(dev:string):string;
var
   fstype:string;
   zlogs:Tlogs;
   tmpstr:string;
   cmd:string;
begin
    if fileExists('/sbin/mkfs.ext4') then fstype:='ext4';
    if length(fstype)=0 then fstype:='ext3';
    zlogs:=Tlogs.Create;
    tmpstr:=zlogs.FILE_TEMP();
    cmd:='/sbin/mkfs -t '+fstype+' '+dev;
    zlogs.Debuglogs(cmd);
    fpsystem(cmd);
    zlogs.free;
end;
//########################################################################################

function Tsystem.FILE_TIME_BETWEEN_MIN(filepath:string):LongInt;
var
   fa   : Longint;
   S    : TDateTime;
   maint:TDateTime;
begin
result:=0;
if not FileExists(filepath) then exit(0);
    try
       fa:=FileAge(filepath);
       maint:=Now;
       S:=FileDateTodateTime(fa);
       result:=MinutesBetween(maint,S);
    finally
    end;
end;
//##############################################################################
function Tsystem.FILE_TIME_BETWEEN_SEC(filepath:string):LongInt;
var
   fa   : Longint;
   S    : TDateTime;
   maint:TDateTime;
begin
if not FileExists(filepath) then exit(0);
    fa:=FileAge(filepath);
    maint:=Now;
    S:=FileDateTodateTime(fa);
    result:=SecondsBetween(maint,S);
end;
//##############################################################################
function Tsystem.FILE_TIME(filepath:string):string;
var
   fa   : Longint;
   S    : TDateTime;
   maint:TDateTime;
begin
if not FileExists(filepath) then exit('');
    fa:=FileAge(filepath);
    S:=FileDateTodateTime(fa);
    if S>-1 then result:=DateTimeToStr(FileDateToDateTime(fa));
end;
//##############################################################################
function Tsystem.LOCATE_APACHE_LIBPHP5():string;
begin
if FileExists(LOCATE_APACHE_MODULES_PATH()+'/libphp5.so') then exit(LOCATE_APACHE_MODULES_PATH()+'/libphp5.so');
if FileExists('/usr/lib/apache-extramodules/mod_php5.so') then exit('/usr/lib/apache-extramodules/mod_php5.so');
end;
//##############################################################################
function Tsystem.LOCATE_APACHE_MODSSLSO():string;
begin
if FileExists(LOCATE_APACHE_MODULES_PATH()+'/mod_ssl.so') then exit(LOCATE_APACHE_MODULES_PATH()+'/mod_ssl.so');
end;
//##############################################################################
function Tsystem.APACHE_IS_MOD_PROXY():boolean;
var
   l:Tstringlist;
   i:integer;
   MODULES_PATH:string;
begin

MODULES_PATH:=LOCATE_APACHE_MODULES_PATH();
if not DirectoryExists(MODULES_PATH) then exit(false);;
l:=Tstringlist.Create;
l.add('mod_proxy.so');
l.add('mod_proxy_http.so');
l.add('mod_proxy_ftp.so');
l.add('mod_proxy_connect.so');
l.add('mod_headers.so');
l.add('mod_deflate.so');
//l.add('mod_xml2enc.so');
l.add('mod_proxy_html.so');
for i:=0 to l.Count-1 do begin
    if not FileExists( MODULES_PATH+'/'+l.Strings[i]) then begin
        if verbosed then writeln(MODULES_PATH+'/'+l.Strings[i],' no such file');
        exit(false);
    end;
end;
l.free;
exit(true);

end;
//##############################################################################

function Tsystem.LOCATE_APACHE_MODULES_PATH():string;
begin
if FileExists('/usr/lib/apache2/modules/mod_cgi.so') then exit('/usr/lib/apache2/modules');
if FileExists('/usr/lib/apache2/mod_cgi.so') then exit('/usr/lib/apache2');
if FIleExists('/usr/lib/apache2/mod_perl.so') then exit('/usr/lib/apache2');
if FileExists('/usr/lib/apache/mod_alias.so') then exit('/usr/lib/apache');
if FileExists('/usr/lib64/httpd/modules/mod_cgi.so') then exit('/usr/lib64/httpd/modules');
if FileExists('/usr/lib/httpd/modules/mod_cgi.so') then exit('/usr/lib/httpd/modules');
if FileExists('/usr/local/apache-groupware/modules/mod_cgi.so') then exit('/usr/local/apache-groupware/modules');
end;
//##############################################################################
function Tsystem.LOCATE_APACHE_STANDARD_CONF():string;
begin
    if FIleExists('/etc/apache2/apache2.conf') then exit('/etc/apache2/apache2.conf');
    if FIleExists('/etc/httpd/conf/httpd.conf') then exit('/etc/httpd/conf/httpd.conf');
end;
//##############################################################################
function Tsystem.LOCATE_GENERIC_BIN(StrProgram:string):string;
var
   l:Tstringlist;
   i:integer;
begin
   StrProgram:=trim(StrProgram);
   if StrProgram='ps' then if length(mem_ps_path)>0 then exit(mem_ps_path);
   if StrProgram='monit' then if length(mem_monit_bin_path)>0 then exit(mem_monit_bin_path);
   if StrProgram='cgconfigparser' then if length(cgconfigparser_mem)>0 then exit(cgconfigparser_mem);
   if StrProgram='cgexec' then if length(MEM_CGEXEC)>0 then exit(MEM_CGEXEC);



    l:=Tstringlist.Create;
    l.Add('/sbin');
    l.Add('/usr/sbin');
    l.Add('/bin');
    l.Add('/usr/bin');
    l.Add('/usr/local/bin');
    l.Add('/usr/local/sbin');
    l.add('/usr/kerberos/bin');
    l.add('/usr/share/artica-postfix/bin');
    l.add('/usr/libexec');


    for i:=0 to l.Count-1 do begin
       if FIleExists(l.Strings[i]+'/'+StrProgram)  then begin
          result:=l.Strings[i]+'/'+StrProgram;
       end;
    end;

   if StrProgram='ps' then mem_ps_path:=result;
   if StrProgram='cgconfigparser' then cgconfigparser_mem:=result;
   if StrProgram='cgexec' then MEM_CGEXEC:=result;
    l.free;

end;
//##############################################################################
function Tsystem.LOCATE_ZABBIX_SERVER():string;
begin
result:=LOCATE_GENERIC_BIN('zabbix_server');
end;
//##############################################################################
function Tsystem.LOCATE_ZABBIX_AGENT():string;
begin
result:=LOCATE_GENERIC_BIN('zabbix_agentd');
end;
//##############################################################################


function Tsystem.LOCATE_PYTHON_PACKAGE(BasePath:string):string;
var
   l:Tstringlist;
   i:integer;
   D:boolean;
begin
   BasePath:=trim(BasePath);
    l:=Tstringlist.Create;

    l.Add('/usr/local/lib/python2.5/dist-packages');
    l.Add('/usr/lib/python2.5/dist-packages');

    l.Add('/usr/local/lib/python2.6/dist-packages');
    l.Add('/usr/lib/python2.6/dist-packages');

    l.Add('/usr/local/lib/python2.7/dist-packages');
    l.Add('/usr/lib/python2.7/dist-packages');

    l.Add('/usr/local/lib/python2.8/dist-packages');
    l.Add('/usr/lib/python2.8/dist-packages');

    l.Add('/usr/local/lib/python2.9/dist-packages');
    l.Add('/usr/lib/python2.9/dist-packages');

    for i:=0 to l.Count-1 do begin
       if FIleExists(l.Strings[i]+'/'+BasePath)  then begin
          result:=l.Strings[i]+'/'+BasePath;
          if DEBUG then writeln('LOCATE_PYTHON_PACKAGE:: '+result+' -> TRUE');
       end else begin
           if DEBUG then writeln('LOCATE_PYTHON_PACKAGE:: '+result+' -> FALSE');
       end;
    end;
   l.free;

end;
//##############################################################################



function Tsystem.APACHE_STANDARD_PORT():string;
var
   l:TstringList;
   httpdconf:string;
   RegExpr:TRegExpr;
   i:integer;
begin
     httpdconf:=LOCATE_APACHE_STANDARD_CONF();
    if not FIleExists(httpdconf) then exit;
    l:=Tstringlist.Create;
    l.LoadFromFile(httpdconf);
    RegExpr:=TRegExpr.Create;

    for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^Listen\s+(.+?):([0-9]+)';
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=RegExpr.Match[2];
          Break;
       end;

       RegExpr.Expression:='^Listen\s+([0-9]+)$';
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=RegExpr.Match[1];
          Break;
       end;

    end;
RegExpr.free;
l.free;
if length(result)=0 then result:='80';
end;
//##############################################################################
procedure Tsystem.APACHE_STANDARD_PORT_CHANGE(portnumber:string);
var
   l:TstringList;
   httpdconf:string;
   RegExpr:TRegExpr;
   as_edit:boolean;
   i:integer;
begin
     httpdconf:=LOCATE_APACHE_STANDARD_CONF();
    if not FIleExists(httpdconf) then exit;
    l:=Tstringlist.Create;
    l.LoadFromFile(httpdconf);
    RegExpr:=TRegExpr.Create;
    as_edit:=false;


    for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^Listen\s+(.+?):([0-9]+)';
       if RegExpr.Exec(l.Strings[i]) then begin
          as_edit:=true;
          l.Strings[i]:='Listen '+RegExpr.Match[1]+':'+portnumber;
          Break;
       end;

       RegExpr.Expression:='^Listen\s+([0-9]+)$';
       if RegExpr.Exec(l.Strings[i]) then begin
          as_edit:=true;
          l.Strings[i]:='Listen '+portnumber;
          Break;
       end;

    end;


    if as_edit then begin
       l.SaveToFile(httpdconf);
    end else begin
       l.Add('Listen '+portnumber);
       l.SaveToFile(httpdconf);
    end;

    fpsystem('/usr/share/artica-postfix/bin/process1 --force --fghjkl');
    fpsystem(LOCATE_APACHE_INITD() +' restart');

RegExpr.free;
l.free;

end;
//##############################################################################


procedure Tsystem.DeleteService(servicename:string);
begin
 if FileExists('/usr/sbin/update-rc.d') then begin
    fpsystem('/usr/sbin/update-rc.d -n -f '+servicename+' remove >/dev/null 2>&1');
 end;

  if FileExists('/sbin/chkconfig') then begin
     fpsystem('/sbin/chkconfig --delete '+servicename+' >/dev/null 2>&1');
  end;
end;
//##############################################################################
function Tsystem.LOCATE_MIME_TYPES():string;
begin
if FileExists('/etc/mime.types') then exit('/etc/mime.types');
if FileExists('/etc/httpd/conf/mime.types') then exit('/etc/httpd/conf/mime.types');
end;
//##############################################################################
function Tsystem.LOCATE_LSHW():string;
begin
if FileExists('/usr/bin/lshw') then exit('/usr/bin/lshw');
exit(LOCATE_GENERIC_BIN('lshw'));
end;
//##############################################################################
function Tsystem.CHANGE_SERVICES_IP(servicename:string;port:string):string;
Var
    l:TstringList;
    i:integer;
    RegExpr:TRegExpr;
    F:boolean;
    vblogs:Tlogs;
Begin
if length(port)=0 then exit('no port specified');
if length(servicename)=0 then exit('no service name specified');
if not FileExists('/etc/services') then exit('unable to stat /etc/services');
l:=Tstringlist.Create;
l.LoadFromFile('/etc/services');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='^'+servicename+'\s+([0-9]+)';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       if RegExpr.Match[1]=port then begin
          l.free;
          RegExpr.free;
          exit('No changes...');
       end else begin
           vblogs:=TLogs.Create;
           l.Strings[i]:=servicename+chr(9)+port+'/tcp #Cyrus replication cluster';
           vblogs.WriteToFile(l.Text,'/etc/services');
           vblogs.free;
           l.free;
           RegExpr.free;
           exit('Change '+ servicename +' to '+port+' in /etc/services');
       end;
    end;
end;

l.Add(servicename+chr(9)+port+'/tcp #Cyrus replication cluster');
 vblogs:=TLogs.Create;
 vblogs.WriteToFile(l.Text,'/etc/services');
 vblogs.free;
 l.free;
 RegExpr.free;
exit('Add '+ servicename +' to '+port+' in /etc/services');


end;
//##############################################################################
procedure Tsystem.cpulimit(pid:string);
var
   cpulimit_bin:string;
   mypid:string;
   cpu:string;
   azerty:Tlogs;
begin
   if length(pid)=0 then mypid:=IntToStr(fpgetpid) else mypid:=pid;
   cpu:=GET_INFO('cpulimit');
   if length(cpu)=0 then cpu:='0';
   if cpu='0' then exit;
   cpulimit_bin:=LOCATE_GENERIC_BIN('cpulimit');
   if length(cpulimit_bin)=0 then exit;

   azerty:=Tlogs.Create;
   azerty.Debuglogs('cpulimit():: cpu limitation to '+cpu+'% for PID '+mypid);
   fpsystem(cpulimit_bin +' -p ' + mypid +' -l '+cpu+' -z >/dev/null 2>&1 &');
   azerty.free;
end;
//##############################################################################
procedure Tsystem.JGrowl(subject:string;text:string);
var
   l:tstringlist;
   filetmp:string;
   JGrowll:Tlogs;
begin
     JGrowll:=tlogs.Create;
     filetmp:='/usr/share/artica-postfix/ressources/logs/jGrowl/'+JGrowll.MD5FromString(subject+text);
     ForceDirectories(ExtractFilePath(filetmp));
     if FIleExists(filetmp) then exit;

     l:=Tstringlist.Create;
     l.Add('[LOG]');
     l.Add('date='+JGrowll.DateTimeNowSQL());
     l.Add('subject='+subject);
     l.Add('');
     l.add('<text>'+text+'</text>');
     l.add('');
     JGrowll.WriteToFile(l.Text,filetmp);
     fpsystem('/bin/chmod -R 775 /usr/share/artica-postfix/ressources/logs/jGrowl');
     l.free;
     JGrowll.free;
end;
function Tsystem.MembersList(groupname:string):TstringList;
var
   l:Tstringlist;
   i:integer;
begin
     l:=TstringList.Create;
     result:=l;
try
   GetGroupMembers(groupname,l);

   for i:=0 to l.count-1  do begin
       writeln(l.Strings[i]);
   end;

except
writeln('fatal error');
end;
result:=l;
l.free;
exit;
end;


function Tsystem.IsUserExists(username:string):boolean;
var
   s:string;
   logs:Tlogs;

begin
logs:=Tlogs.Create;
result:=false;
s:=trim(SystemUserID(username));
if verbosed then writeln('IsUserExists()::',username,':"',s,'"');
if length(s)>0 then exit(true);
end;

procedure Tsystem.CreateGroup(Groupname:string);
begin
  if FileExists('/usr/sbin/groupadd') then fpsystem('/usr/sbin/groupadd ' + Groupname + ' >/tmp/groupadd.' + Groupname + ' 2>&1 &');
end;

procedure Tsystem.AddUserToGroup(username:string;groupname:string;xshell:string;sHome:string);
var
   cmd:string;
   logs:Tlogs;
begin
    verbosed:=COMMANDLINE_PARAMETERS('--verbose');
    if verbosed then writeln('AddUserToGroup()::',username);
    logs:=Tlogs.Create;
    if length(xshell)=0 then xshell:='/bin/sh';
    cmd:='';
    if FileExists('/etc/.pwd.lock') then fpsystem('/bin/rm /etc/.pwd.lock');
    if verbosed then writeln('AddUserToGroup():: Checking:',username);
    if not IsUserExists(username) then begin

           if verbosed then writeln('AddUserToGroup():: Not exists:',username);
           if not IsGroupExists(groupname) then begin
                if verbosed then writeln('AddUserToGroup():: Not exists group:',groupname);
                CreateGroup(groupname)
           end;


           logs.Debuglogs('Tsystem.AddUserToGroup()::Creating new ' +username);
           if length(xshell)>0 then   cmd:=cmd + ' -s ' + xshell+ ' ';
           if length(sHome)>0 then   cmd:=cmd + '-d ' + sHome+ ' ';
           if IsGroupExists(groupname) then cmd:=cmd + '-g ' + groupname+ ' ';
           cmd:='/usr/sbin/useradd ' + username + cmd;
            if verbosed then writeln('AddUserToGroup()::',cmd);
           logs.Debuglogs(cmd);
           fpsystem(cmd + ' &');


    end else begin
        logs.Debuglogs('Tsystem.AddUserToGroup()::'+username +' exists...');

    end;

    if not IsGroupExists(groupname) then CreateGroup(groupname) else logs.Debuglogs('Tsystem.AddUserToGroup()::'+groupname +'exists...');


    if not IsUserINGroup(groupname,username) then begin
       cmd:='/usr/sbin/usermod -a -G '+ groupname + ' '+ username+' >/dev/null 2>&1 &';
       logs.Debuglogs(cmd);
       fpsystem(cmd);
       fpsystem('/usr/sbin/usermod -A '+ groupname + ' '+ username+' >/dev/null 2>&1 &');
       logs.Debuglogs(cmd);
       cmd:='/usr/sbin/usermod --append '+ groupname + ' '+ username;
       fpsystem(cmd + ' &');
       logs.Debuglogs(cmd);
    end;

    logs.free;
end;

//#########################################################################################
procedure Tsystem.AddShell(username:string);
var
logs:Tlogs;
cmd:string;
begin
logs:=Tlogs.Create;
  if not FileExists('/usr/sbin/usermod') then begin
       logs.Syslogs('Tsystem.AddShell():: unable to stat /usr/sbin/usermod');
       logs.free;
       exit;
  end;
  cmd:='/usr/sbin/usermod -s /bin/sh ' + username;
  logs.Debuglogs(cmd);
  fpsystem(cmd + ' &');
  logs.free;

end;
//#########################################################################################
function Tsystem.ReadFileIntoString(path:string):string;
         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;
var
   Afile:text;
   datas:string;
   datas_file:string;
   logs:Tlogs;
begin
       datas_file:='';
       if not FileExists(path) then exit;


      TRY
     assign(Afile,path);
     reset(Afile);
     while not EOF(Afile) do
           begin
           readln(Afile,datas);
           datas_file:=datas_file + datas +CRLF;
           end;

close(Afile);
             EXCEPT
              logs:=Tlogs.Create;
              logs.Debuglogs('Error:Tsystem.ReadFileIntoString -> unable to read (' + path + ')');
              logs.free;
           end;
result:=datas_file;


end;
//#########################################################################################


function Tsystem.LOCATE_PDNS_BIN():string;
begin
if FileExists('/usr/sbin/pdns_server') then exit('/usr/sbin/pdns_server');
end;

function Tsystem.ReadFileIntoString2(path:string):string;
Var Fin : File;
    NumRead : Word;
    Buf : Array[1..2048] of Char;
    i:integer;
    a:string;

begin
  result:='';
  if not FileExists(path) then exit;
  Assign (Fin, path);
  a:='';
  Reset (Fin,1);
  NumRead:=0;

  Repeat
    BlockRead (Fin,buf,Sizeof(buf),NumRead);
  Until (NumRead=0);

  for i:=0 to length(buf)-1 do begin
      a:=a+buf[i]
  end;

  close(fin);
  result:=a


end;
//#########################################################################################
function Tsystem.ReadFileIntoStringHTML(path:string):string;
         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;
var
   Afile:text;
   datas:string;
   datas_file:string;
begin
      datas_file:='';
      if not FileExists(path) then exit;
      TRY
     assign(Afile,path);
     reset(Afile);
     while not EOF(Afile) do
           begin
           readln(Afile,datas);
           datas_file:=datas_file + datas+CRLF;
           end;

close(Afile);
             EXCEPT
              writeln('Error:Tsystem.ReadFileIntoStringHTML -> unable to read (' + path + ')');
           end;
result:=datas_file


end;
//#########################################################################################
function Tsystem.DirectoryCountFiles(FilePath: string):integer;
Var Info : TSearchRec;
    Count : Longint;

Begin
  Count:=0;
  If FindFirst (FilePath+'/*',faAnyFile and faDirectory,Info)=0 then
    begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
              if Info.Attr=48 then count:=count +  DirectoryCountFiles(FilePath + '/' +Info.Name);
              if Info.Attr=16 then count:=count +  DirectoryCountFiles(FilePath + '/' +Info.Name);
              if Info.Attr=32 then Inc(Count);
              //Writeln (Info.Name:40,Info.Size:15);
         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  exit(count);
end;
//#########################################################################################
function Tsystem.LOCATE_LIGHTTPD_BIN_PATH():string;
begin
   if FileExists('/usr/sbin/lighttpd') then exit('/usr/sbin/lighttpd');
   if FileExists('/usr/local/sbin/lighttpd') then exit('/usr/local/sbin/lighttpd');
   if FileExists('/opt/artica/lighttpd/sbin/lighttpd') then exit('/opt/artica/lighttpd/sbin/lighttpd');
end;
//#########################################################################################
function Tsystem.LOCATE_LIGHTTPD_ANGEL_BIN_PATH():string;
begin
   if FileExists('/usr/sbin/lighttpd-angel') then exit('/usr/sbin/lighttpd-angel');
   if FileExists('/usr/local/sbin/lighttpd-angel') then exit('/usr/local/sbin/lighttpd-angel');
   exit(LOCATE_LIGHTTPD_BIN_PATH());
end;
//#########################################################################################

function Tsystem.DirFiles(FilePath: string;pattern:string):TstringList;
Var Info : TSearchRec;
    D:boolean;
Begin
  DirListFiles:=Tstringlist.Create;
  DirListFiles.Clear;
  D:=COMMANDLINE_PARAMETERS('debug');
  if D then ShowScreen('DirFiles:: ' + FilePath + ' ' + pattern );
  If FindFirst (FilePath+'/'+ pattern,faAnyFile,Info)=0 then begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
           if D then ShowScreen('DirFiles:: Found ' + Info.Name );
           DirListFiles.Add(Info.Name);

         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  DirFiles:=DirListFiles;
  exit();
end;
//#########################################################################################
function Tsystem.DirFilesByls(Path: string;pattern:string):TstringList;
Var logs:Tlogs;
    D:boolean;
    tmpstr:string;
    i:integer;
    RegExpr:TRegExpr;
    t:integer;
Begin
  Path:=Path+'/';
  RegExpr:=TRegExpr.create;
  DirListFiles.Clear;
  logs:=Tlogs.Create;
  tmpstr:=logs.FILE_TEMP();
  RegExpr.Expression:='^/bin/ls.+';
  fpsystem('/bin/ls -A -1 '+Path+pattern+' >'+tmpstr+' 2>&1');
  if not FileExists(tmpstr) then exit;
  DirListFiles.LoadFromFile(tmpstr);
  t:=0;
  for i:=0 to DirListFiles.Count-1 do begin
  if t>DirListFiles.Count then break;
    if RegExpr.Exec(DirListFiles.Strings[t]) then begin
        DirListFiles.Delete(t);
        continue;
    end;

    DirListFiles.Strings[t]:=ansireplaceText(DirListFiles.Strings[t],Path,'');
    t:=t+1;
    if t>DirListFiles.Count then break;
  end;
  result:=DirListFiles;
end;
//#########################################################################################
function Tsystem.GET_CACHE_VERSION(APP_NAME: string):string;
var ini:TiniFile;
begin
  if FileExists('/etc/artica-postfix/versions.cache') then begin
     if FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/versions.cache')>120  then begin
        fpsystem('/bin/rm -f /etc/artica-postfix/versions.cache');
        result:='';
        exit;
     end;
  end;

  try
     ini:=TiniFile.Create('/etc/artica-postfix/versions.cache');
  except
     exit;
  end;
  result:=ini.ReadString(APP_NAME,'VERSION','');
  ini.Free;
end;
//#########################################################################################
procedure Tsystem.SET_CACHE_VERSION(APP_NAME:string;version:string);
var ini:TiniFile;
Begin
  ini:=TiniFile.Create('/etc/artica-postfix/versions.cache');
  INI.WriteString(APP_NAME,'VERSION',version);
  ini.Free;
end;
//#########################################################################################
function Tsystem.DirDir(FilePath: string):TstringList;
Var Info : TSearchRec;
    D:boolean;
Begin
  D:=COMMANDLINE_PARAMETERS('debug');
  if D then ShowScreen('DirDir:: ' + FilePath + ' *' );
   DirListFiles:=TstringList.Create();
  If FindFirst (FilePath+'/*',faDirectory,Info)=0 then begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
           if (info.Attr=48) OR (info.Attr=49) then begin
              if D then ShowScreen('DirDir:: Found ' + Info.Name  + ' ' + IntToStr(info.Attr));
              DirListFiles.Add(Info.Name);
           end;

         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  DirDir:=DirListFiles;
  exit();
end;
//#########################################################################################
function Tsystem.DirDirRecursive(FilePath: string):TstringList;
Var Info : TSearchRec;
    D:boolean;
Begin


  D:=COMMANDLINE_PARAMETERS('debug');
  if D then ShowScreen('DirDir:: ' + FilePath + ' *' );
  DirListFiles:=Tstringlist.Create;

  If FindFirst (FilePath+'/*',faAnyFile,Info)=0 then begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
           if (info.Attr=48) or (info.Attr=49) then begin
              //;
              if D then writeln('DirDir:: Found '+FilePath + '/'+Info.Name + ' Attr=' + IntToStr(info.Attr)+ ' Size=',info.Size);
              DirListFiles.Add(FilePath + '/'+Info.Name);
              if not FileSymbolicExists(FilePath + '/'+Info.Name) then begin
                 SearchSize:=SearchSize+info.Size;
                 DirDirRecursive(FilePath + '/'+Info.Name);
              end;

              if D then writeln('SearchSize:',SearchSize);
           end else begin
              if D then writeln('DirDir:: Found '+FilePath + '/'+Info.Name + ' Attr=' + IntToStr(info.Attr)+ ' Size=',info.Size);
                DirListFiles.Add(FilePath + '/'+Info.Name);
                SearchSize:=SearchSize+info.Size;
                if D then writeln('SearchSize:',SearchSize);

           end;



         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  DirDirRecursive:=DirListFiles;
  exit();
end;
//#########################################################################################
procedure Tsystem.SecureWeb(path: string);
var
   folders:tstringlist;
   i:integer;
   RegExpr:TRegExpr;
   ext:string;
   chmodable:boolean;
   fhlogs:tlogs;
Begin
   if not DirectoryExists(path) then exit;
   folders:=Tstringlist.Create;

   folders.AddStrings(DirDirRecursive(path));
   RegExpr:=TRegExpr.Create;
   fhlogs:=tlogs.Create;

   for i:=0 to folders.Count-1 do begin
        if FileSymbolicExists(folders.Strings[i]) then begin
              RegExpr.Expression:='artica_ldap_addr';
              if RegExpr.Exec(folders.Strings[i]) then continue;
              fhlogs.Debuglogs('Warning symbolic link "'+folders.Strings[i]+'" is not acceptable in this directory ');
              try
                 fpunlink(folders.Strings[i]);
              except
               fhlogs.Debuglogs('Warning unable to remove symbolic link "'+folders.Strings[i]+'"');
              end;
        end;



        RegExpr.Expression:='\.(.+)$';
        if RegExpr.Exec(folders.Strings[i]) then begin
           chmodable:=false;
           ext:=LowerCase(RegExpr.Match[1]);
           if ext='inc.php' then chmodable:=true;
           if ext='php' then chmodable:=true;
           if ext='inc' then chmodable:=true;
           if ext='js' then chmodable:=true;
           if ext='html' then chmodable:=true;
           if ext='js.src' then chmodable:=true;
           if ext='htm' then chmodable:=true;
           if ext='png' then chmodable:=true;
           if ext='gif' then chmodable:=true;
           if ext='jpeg' then chmodable:=true;
           if ext='css' then chmodable:=true;
           if chmodable then begin
              try
                 FpChmod(folders.Strings[i],400);
              except
                fhlogs.Debuglogs('Fatal error while chmod '+folders.Strings[i]);
              end;
           end;
        END;
   end;




end;

function Tsystem.SearchFilesInPath(path: string;filter:string):TstringList;
Var Info : TSearchRec;
    D:boolean;
Begin
  D:=COMMANDLINE_PARAMETERS('debug');
  if D then ShowScreen('FoundLatestFiles:: ' + path + '(' + filter + ')' );
   DirListFiles:=TstringList.Create();
  If FindFirst (path+ '/'+ filter ,faAnyFile,Info)=0 then begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
           if D then ShowScreen('FoundLatestFiles:: Found ' + path + '/' + Info.Name );
           DirListFiles.Add(path + '/' + Info.Name);

         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  exit(DirListFiles);
  exit();
end;
//#########################################################################################

procedure Tsystem.BuildArticaFiles();
var
    BackupSrc:string;
begin




  if DirectoryExists(ArticaBuildPath + '/bin/src') then begin
       ShowScreen('ScanArticaFiles:: move source files...');
       BackupSrc:='/tmp/src_' + version;
       fpsystem('/bin/mv ' + ArticaBuildPath + '/bin/src' + ' ' +  BackupSrc);
    end;
    ShowScreen('ScanArticaFiles:: remove unecessary source files...');
    if DirectoryExists(ArticaBuildPath + '/bin') then begin
       fpsystem('/bin/rm ' + ArticaBuildPath + '/bin/*.o');
       fpsystem('/bin/rm ' + ArticaBuildPath + '/bin/*.ppu');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/ressources/settings.inc');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/01cpu*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/02loadavg*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/03mem*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/04hddio*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/05hdd*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/06proc*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/10net*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/img/mailgraph_*.png');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/ressources/databases/postfix-queue-cache.conf');
       fpsystem('/bin/rm -rf ' + ArticaBuildPath + '/ressources/databases/queue.list.*.cache');
       fpsystem('/bin/rm  ' + ArticaBuildPath + '/ressources/settings.inc');
       fpsystem('/usr/bin/strip -s ' + ArticaBuildPath + '/bin/artica-install');
       fpsystem('/usr/bin/strip -s ' + ArticaBuildPath + '/bin/artica-postfix');
    end;

    ShowScreen('ScanArticaFiles:: Compresss source folder...');
    fpsystem('cd ' + BackupSrc + ' && tar -czf /tmp/artica_src_' + version + '.tgz *');
    ShowScreen('ScanArticaFiles:: Compresss application folder...=>cd ' + ArticaBuildPath + ' && tar -czf /tmp/artica_' + version + '.tgz *');
    fpsystem('cd ' + ArticaBuildPath + ' && tar -czf /tmp/artica_' + version + '.tgz *');

    fpsystem('/bin/rm -rf ' + ArticaBuildPath);
    fpsystem('/bin/rm -rf ' + BackupSrc);

    ShowScreen('ScanArticaFiles::Done...');

end;
//#############################################################################
function Tsystem.OPENSSL_TOOL_PATH():string;
begin
if FileExists('/usr/local/ssl/bin/openssl') then exit('/usr/local/ssl/bin/openssl');
if FileExists('/usr/bin/openssl') then exit('/usr/bin/openssl');
end;

//#############################################################################
function Tsystem.OPENSSL_CONFIGURATION_PATH():string;
begin
If FileExists('/etc/artica-postfix/settings/Daemons/PostfixSSLCert') then exit('/etc/artica-postfix/settings/Daemons/PostfixSSLCert');
If FileExists('/etc/artica-postfix/ssl.certificate.conf') then exit('/etc/artica-postfix/ssl.certificate.conf');
if fileExists('/usr/share/artica-postfix/bin/install/DEFAULT-CERTIFICATE-DB.txt') then exit('/usr/share/artica-postfix/bin/install/DEFAULT-CERTIFICATE-DB.txt');
if FileExists('/etc/ssl/openssl.cnf') then exit('/etc/ssl/openssl.cnf');
if FileExists('/usr/lib/ssl/openssl.cnf') then exit('/usr/lib/ssl/openssl.cnf');
if FileExists('/usr/share/ssl/openssl.cnf') then exit('/usr/share/ssl/openssl.cnf');

end;

//#############################################################################
function Tsystem.LOCATE_SMBCLIENT():string;
begin
if FileExists('/usr/bin/smbclient') then exit('/usr/bin/smbclient');
end;
//#############################################################################




function Tsystem.ScanArticaFiles(FilePath:string):integer;
Var
   Info : TSearchRec;
    Directory:string;
    PathTo:string;
    PathFrom:string;

    FileDateNum:Longint;
    Ini:TiniFile;
    DateMD5String:string;
    IniDateMD5String,snap:string;
    TMD5 : TMD5Digest;
    NewBuild:integer;
    FileMD5:string;
Begin

  result:=0;



  if length(ArticaDirectory)=0 then begin
     ArticaDirectory:=ExtractFileDir(ParamStr(0));
     ArticaDirectory:=AnsiReplaceText(ArticaDirectory,'/bin','');
     ShowScreen('ScanArticaFiles:: ArticaDirectory="' + ArticaDirectory + '"');
  end;

  if length(ArticaBuildPath)=0 then begin
     if COMMANDLINE_PARAMETERS('build')=true then begin
      Ini:=TiniFile.Create(ArticaDirectory + '/version.ini');
      NewBuild:=ini.ReadInteger('VERSION','build',0);
      NewBuild:=NewBuild+1;
      ini.WriteInteger('VERSION','build',NewBuild);
      snap:='snapshot';
     end else begin
      Ini:=TiniFile.Create(ArticaDirectory + '/version.ini');
      NewBuild:=ini.ReadInteger('VERSION','minor',0);
      NewBuild:=NewBuild+1;
      ini.WriteInteger('VERSION','minor',NewBuild);
      fpsystem('/bin/rm /etc/artica-postfix/Builder.ini');
      snap:='full';
     end;
    version:= snap + '.' + IntToStr(ini.ReadInteger('VERSION','major',0)) + '.' +IntToStr(ini.ReadInteger('VERSION','minor',0)) + '.' + IntToStr(ini.ReadInteger('VERSION','build',0));
    ArticaBuildPath:='/tmp/artica-postfix_' + version;
    ShowScreen('ScanArticaFiles:: ArticaBuildDirectory="' + ArticaBuildPath + '"');
  end;

  if length(FilePath)=0 then FilePath:=ArticaDirectory;
  Directory:=AnsiReplaceText(FilePath,ArticaDirectory,'');



  If FindFirst (FilePath+'/*',faAnyFile and faDirectory,Info)=0 then
    begin
    Repeat
      if Info.Name<>'..' then begin
         if Info.Name <>'.' then begin
              if Info.Attr=48 then begin
                 ScanArticaFiles(FilePath + '/' +Info.Name);
              end;

              if Info.Attr=16 then begin

                  ScanArticaFiles(FilePath + '/' +Info.Name);
              end;

              if Info.Attr=32 then begin
                 PathTo:=Directory + '/' +Info.Name;
                 PathFrom:=FilePath + '/' +Info.Name;
                 FileDateNum:=FileAge(PathFrom);
                 if Copy(PathTo,0,1)='/' then PathTo:=Copy(PathTo,2,length(PathTo)-1);
                 PathTo:=ArticaBuildPath + '/' + PathTo;
                 TMD5:=MD5String(IntToSTr(FileDateNum));
                 DateMD5String:=MD5Print(TMD5);


                 TMD5:=MD5String(PathFrom);
                 FileMD5:=MD5Print(TMD5);

                 IniDateMD5String:=ScanINIArticaFiles(FileMD5);

                if DateMD5String<>IniDateMD5String then begin
                   ShowScreen('ScanArticaFiles:: ' + FileMD5 + '("' + DateMD5String + '" <> "' +IniDateMD5String + '")');
                   ForceDirectories(ExtractFileDir(PathTo));
                   fpsystem('/bin/cp ' + PathFrom + ' ' + PathTo);
                   ScanINIArticaFilesSave(FileMD5,DateMD5String);
                end;

              end;

         end;
      end;

    Until FindNext(info)<>0;
    end;
  FindClose(Info);




end;
function Tsystem.ScanINIArticaFiles(key:string):string;
var
   Ini:TStringList;
   RegExpr:TRegExpr;
   i:integer;
  begin
  result:='';
  if not FileExists('/etc/artica-postfix/Builder.ini') then exit;
  Ini:=TStringList.Create;
  Ini.LoadFromFile('/etc/artica-postfix/Builder.ini');
  RegExpr:=TRegExpr.create;
  RegExpr.Expression:=key+'=([a-z0-9]+)';
  for i:=0 to ini.Count-1 do begin;
  if RegExpr.Exec(ini.Strings[i]) then begin
     result:=RegExpr.Match[1];
     RegExpr.Free;
     Ini.Free;
     exit();
  end;
  end;
 RegExpr.Free;
     Ini.Free;

end;
function Tsystem.ScanINIArticaFilesSave(key:string;Value:string):string;
var     Ini:TiniFile;
  begin
  result:='';
  Ini:=TiniFile.Create('/etc/artica-postfix/Builder.ini');
   ini.WriteString('BUILD',key,Value);
  ini.Free;
  exit
end;
//#########################################################################################
function Tsystem.GetDirectoryList(path:string):longint;
var
   Dir:string;
   Info : TSearchRec;
   D:boolean;
begin
    D:=COMMANDLINE_PARAMETERS('debug');
    result:=0;
    path:=AnsiReplaceText(path,'//','/');
    if Copy(path,length(path),1)='/' then path:=Copy(path,0,length(path)-1);
    if Not DirectoryExists(path) then exit;

If FindFirst (path+'/*',(faAnyFile and faDirectory),Info)=0 then begin
    Repeat
       if info.Name<>'..' then begin
          if info.name<>'.' then begin
             dir:=path + '/' + info.Name;
             result:=result+info.Size;


             //writeln('[' + IntTostr(info.Size) + ' attr=' + IntToStr(info.Attr) +' ] ' + dir);
             If (info.Attr=48) or (info.Attr=49) then result:=result+GetDirectoryList(dir);
             //list.AddStrings(GetDirectoryList(dir));
          end;
       end;
    Until FindNext(info)<>0;
end;

if D then writeln(Path + '=' + IntToStr(result) );
end;
//#########################################################################################
function Tsystem.DirectoryListTstring(path:string):TstringList;
var
   Dir:string;
   Info : TSearchRec;
   f:TstringList;
begin
    f:=TstringList.Create;
    result:=f;
    path:=AnsiReplaceText(path,'//','/');
    if Copy(path,length(path),1)='/' then path:=Copy(path,0,length(path)-1);
    if Not DirectoryExists(path) then exit(f);

If FindFirst (path+'/*',(faAnyFile and faDirectory),Info)=0 then begin
    Repeat
       if info.Name<>'..' then begin
          if info.name<>'.' then begin
             dir:=path + '/' + info.Name;
//             writeln(info.name,' ',info.Attr);
              If (info.Attr=48) or (info.Attr=49) then begin
                 f.Add(dir);
              end;

          end;
       end;
    Until FindNext(info)<>0;
end;
    result:=f;
    //f.free;
end;
//#########################################################################################
function Tsystem.RecusiveListFiles(path:string):TstringList;
var
   l:TstringList;
   i:integer;
   malist:TstringList;
   D:boolean;
begin
   DirListFiles.Clear;
   l:=TstringList.Create;
   D:=COMMANDLINE_PARAMETERS('--ls');
   if not D then d:=COMMANDLINE_PARAMETERS('debug');

   if D then writeln('RecusiveListFiles:: search path: ' + path);
   FindDirs(path);
   l.AddStrings(DirListFiles);
   if D then writeln('RecusiveListFiles:: ',l.Count,' rows');
   DirListFiles.Clear;
   malist:=TStringList.Create;
   result:=malist;

    if l.Count=0 then begin
       malist.AddStrings(SearchFilesInPath(path,'*'));
       exit(malist);
    end;


     for i:=0 to l.Count-1 do begin
         malist.AddStrings(SearchFilesInPath(l.Strings[i],'*'));
     end;
    DirListFiles.AddStrings(malist);

    result:=malist;

end;





//#########################################################################################
function Tsystem.FindPidByPath(path:string):string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
Begin
  result:='';
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:=path;
  l:=TstringList.Create;
  l.AddStrings(DirectoryListTstring('/proc'));
  For i:=0 to l.Count-1 do begin
      if FileExists(l.Strings[i]+'/exe') then begin
         writeln(fpReadlink(l.Strings[i]+'/exe'),' ' ,l.Strings[i]+'/exe',' ',ReadFileIntoString(l.Strings[i]+'/cmdline'));
      end;

  end;

end;
//#########################################################################################
function Tsystem.PidByProcessPath(ExePath:string):string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   ProcessPath,PPID:string;
   pid:string;
   cmdline:string;
   org_cmdline:string;
   org_exepath:string;
   Execline,argToFound:string;
   found:boolean;
   ppdstring:string;
   D:boolean;
Begin
  D:=false;
  D:=COMMANDLINE_PARAMETERS('--verbose');



  cmdline:='';
  argToFound:='';
  org_exepath:=ExePath;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='(.+?) (.+)';
  if not RegExpr.Exec(ExePath) then begin
  pid:=trim(PIDOF(ExePath));
  RegExpr.Expression:='^([0-9]+)';
  if  RegExpr.Exec(pid) then begin
      if D then writeln('PidByProcessPath:: ',ExePath,'=',RegExpr.Match[1]);
      result:=RegExpr.Match[1];
      RegExpr.free;
      exit;
  end else begin
      if D then writeln('PidByProcessPath:: ',ExePath,':',pid,'=',RegExpr.Expression,' failed');
      RegExpr.free;
      exit;
  end;
  end;

      cmdline:=RegExpr.Match[2];
      Execline:=RegExpr.Match[1]+' ' +cmdline;
      ExePath:=RegExpr.Match[1];


  RegExpr.Expression:='(.+?) pattern=(.+)';
  if RegExpr.Exec(org_exepath) then begin
       ExePath:=RegExpr.Match[1];
       argToFound:=RegExpr.Match[2];
       Execline:='';
  end;

  if D then begin
     writeln('PidByProcessPath:: Want to found ExePath=',ExePath);
     writeln('PidByProcessPath:: argToFound=',argToFound);
     writeln('PidByProcessPath:: Execline=',Execline);
  end;
found:=false;
  RegExpr.Expression:=ExePath;
  l:=TstringList.Create;
  l.AddStrings(DirectoryListTstring('/proc'));
  For i:=0 to l.Count-1 do begin
      found:=false;
      if l.strings[I]='/proc/self' then continue;
      if FileExists(l.Strings[i]+'/exe') then begin

           ProcessPath:=fpReadlink(l.Strings[i]+'/exe');
           org_cmdline:=trim(ReadFileIntoString(l.Strings[i]+'/cmdline'));
           if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);

           if ExePath=ProcessPath then begin

                if D then begin
                   writeln('"',l.Strings[i]+'/exe" point to ',ProcessPath);
                   writeln('"ExePath=',ExePath,'"=ProcessPath="',ProcessPath,'"');
                end;



                found:=true;
                if length(Execline)>0 then begin

                    if D then begin
                       writeln('Try to find if cmdline is the same of path and full arguments...');
                       writeln('"org_cmdline=',org_cmdline,'"=Execline="',Execline,'"');
                    end;

                   if(org_cmdline=Execline) then found:=True else found:=false;
                   if D then writeln('"',org_cmdline,'"="',Execline,'"=',found);
                end;


                if length(argToFound)>0 then begin
                       RegExpr.Expression:=argToFound;
                       if RegExpr.Exec(org_cmdline) then found:=True else found:=false;
                       if D then writeln('"',RegExpr.Expression,'" "org_cmdline=',org_cmdline,'"',' ("',found,'")');
                end;


                if found then begin
                     if D then writeln('Process found, find pid now');
                     pid:=ExtractFileName(l.Strings[i]);


                     PPID:=PidByProcessPath_PPID(pid);
                     ppdstring:=fpReadlink('/proc/' + PPID+  '/exe');
                     if D then writeln('PPID=',PPID,' linked to=',ppdstring);
                     if ppdstring='/bin/bash' then begin
                         result:=pid;
                         break;
                     end;

                     if length(PPID)>0 then begin
                        if  PPID='1' then begin
                            if D then writeln('right PID=',pid);
                            result:=pid;
                            break;
                        end;
                        result:=PPID;
                     end else  begin
                       if D then writeln('right PID=',pid);
                       result:=pid;
                     end;
                       if D then writeln('Break');
                       break;
                  end;
               end;
           end;
  end;
  l.free;
  RegExpr.free;

end;
//#########################################################################################
function Tsystem.PidAllByProcessPath(ExePath:string):string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   ProcessPath:string;
   cmdline:string;
   org_cmdline:string;
   Execline:string;
   found:boolean;
Begin

  cmdline:='';
  result:='';
  RegExpr:=TRegExpr.Create;

  RegExpr.Expression:='(.+?) (.+)';
  if RegExpr.Exec(ExePath) then begin
      cmdline:=RegExpr.Match[2];
      Execline:=RegExpr.Match[1]+' ' +cmdline;
      ExePath:=RegExpr.Match[1];
  end;


  RegExpr.Expression:=ExePath;
  l:=TstringList.Create;
  l.AddStrings(DirectoryListTstring('/proc'));
  For i:=0 to l.Count-1 do begin
      found:=false;
      if FileExists(l.Strings[i]+'/exe') then begin
           ProcessPath:=fpReadlink(l.Strings[i]+'/exe');
           org_cmdline:=trim(ReadFileIntoString(l.Strings[i]+'/cmdline'));
           if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);

           if ExePath=ProcessPath then begin
              found:=true;
              if length(Execline)>0 then if(org_cmdline=Execline) then found:=True else found:=false;
              if ExtractFileName(l.Strings[i])='self' then continue;
              if found then result:=result+ ' ' +ExtractFileName(l.Strings[i]);
           end;

       end;
  end;
  l.free;
  RegExpr.free;
  result:=trim(result);
end;
//#########################################################################################
function Tsystem.AllPidsByPatternInPath(pattern:string):string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   org_cmdline:string;
   found:boolean;
   D:boolean;
Begin
  result:='';
  RegExpr:=TRegExpr.Create;
  D:=COMMANDLINE_PARAMETERS('--verbose');
  RegExpr.Expression:=pattern;
  l:=TstringList.Create;
  ProcessIDList:=TstringList.Create;
  ProcessIDList.Clear;
  l.AddStrings(DirectoryListTstring('/proc'));
  For i:=0 to l.Count-1 do begin
      found:=false;
      if FileExists(l.Strings[i]+'/exe') then begin
           org_cmdline:=trim(ReadFileIntoString(l.Strings[i]+'/cmdline'));
           if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);

           if RegExpr.Exec(org_cmdline) then begin
              if D then writeln('Found ', org_cmdline);
              found:=true;
              if found then begin
                 if ExtractFileName(l.Strings[i])<>'self' then begin
                    ProcessIDList.Add(ExtractFileName(l.Strings[i]));
                    result:=result+ ' ' +ExtractFileName(l.Strings[i]);
                 end;
              end;
           end;

       end;
  end;
  l.free;
  RegExpr.free;
  result:=trim(result);
end;
//#########################################################################################
function Tsystem.AllPidsByPatternInPathTstrings(pattern:string):TstringList;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   org_cmdline:string;
   found:boolean;
   D:boolean;
   Mres:TstringList;
Begin

  RegExpr:=TRegExpr.Create;
  Mres:=TstringList.Create;
  result:=Mres;
  D:=COMMANDLINE_PARAMETERS('--verbose');
  RegExpr.Expression:=pattern;
  l:=TstringList.Create;
  ProcessIDList:=TstringList.Create;
  ProcessIDList.Clear;
  l.AddStrings(DirectoryListTstring('/proc'));
  For i:=0 to l.Count-1 do begin
      found:=false;
      if FileExists(l.Strings[i]+'/exe') then begin
           org_cmdline:=trim(ReadFileIntoString(l.Strings[i]+'/cmdline'));
           if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);

           if RegExpr.Exec(org_cmdline) then begin
              if D then writeln('Found ', org_cmdline);
              found:=true;
              if found then begin
                 if ExtractFileName(l.Strings[i])<>'self' then begin
                    ProcessIDList.Add(ExtractFileName(l.Strings[i]));
                    Mres.Add(ExtractFileName(l.Strings[i]));
                 end;
              end;
           end;

       end;
  end;
  l.free;
  RegExpr.free;
 result:=Mres;
end;
//#########################################################################################
function Tsystem.SYSTEM_GET_MYPID():string;
begin
     result:=IntToStr(fpgetpid);
end;

function Tsystem.PidByPatternInPath(pattern:string):string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   RegExpr2:TRegExpr;
   org_cmdline:string;
   found:boolean;
   D:boolean;
   D2:boolean;
   mypid:string;
   PPID:string;
Begin


  RegExpr:=TRegExpr.Create;
  D:=COMMANDLINE_PARAMETERS('--verbose');
  D2:=COMMANDLINE_PARAMETERS('debug');
  mypid:=IntToStr(fpgetpid);
  if D2 then D:=true;
  RegExpr2:=TRegExpr.Create;

  RegExpr.Expression:=pattern;
  l:=TstringList.Create;
  l.AddStrings(DirectoryListTstring('/proc'));
  For i:=0 to l.Count-1 do begin
      found:=false;
      if FileExists(l.Strings[i]+'/exe') then begin
           org_cmdline:=trim(ReadFileIntoString(l.Strings[i]+'/cmdline'));
           if D2 then writeln('"',org_cmdline,'"',length(org_cmdline));
           if length(org_cmdline)=0 then begin
              org_cmdline:=fpReadlink(l.Strings[i]+'/exe');
           end else begin
               if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);
           end;

           if D2 then writeln(org_cmdline);



           if RegExpr.Exec(org_cmdline) then begin
              if D then writeln('Found ',RegExpr.Expression, ' in "', org_cmdline,'" "',ExtractFileName(l.Strings[i]),'"');
              found:=true;

              if D then writeln('Found /bin/su ?');
              RegExpr2.Expression:='/bin/su';

              if RegExpr2.Exec(org_cmdline) then begin
                 found:=false;
                 if D then writeln('Found /bin/su  ->yes');
              end else begin
                  if D then writeln('Found /bin/su ->No');
              end;

              if ExtractFileName(l.Strings[i])<>mypid then begin
                 if found then begin
                    if ExtractFileName(l.Strings[i])<>'self' then begin
                       result:=ExtractFileName(l.Strings[i]);
                       if D then writeln('Found '+result);
                       PPID:=IntToStr(GET_PPID(StrToInt(result)));
                       if D then writeln('PPID '+PPID);
                       if length(PPID)>0 then result:=PPID;
                       break;
                    end;
                 end else begin
                     if D then writeln('Continue...');
                 end;
              end;
           end;
       end;
  end;
  l.free;
  RegExpr.free;
  RegExpr2.free;
  result:=trim(result);
end;
//#########################################################################################
function Tsystem.LOCATE_APACHECTL():string;
begin
if FIleExists('/usr/sbin/apache2ctl') then exit('/usr/sbin/apache2ctl');
if FIleExists('/usr/sbin/apachectl') then exit('/usr/sbin/apachectl');
end;
//#########################################################################################




function Tsystem.IsBinaryString(const Value: string): Boolean;
var
  n: integer;
begin
  Result := False;
  for n := 1 to Length(Value) do
    if Value[n] in [#0..#8, #10..#31] then

    begin
      Result := True;
      Break;
    end;
end;
//#########################################################################################
function Tsystem.TransFormBinaryString(const Value: string): string;
var
  n: integer;
begin
  result:='';
  for n := 1 to Length(Value) do begin
    if Value[n] in [#0..#8, #10..#31] then
    begin
         result:=result+' ';

    end else begin
         result:=result+Value[n];
  end;
  end;
end;
//#########################################################################################


function Tsystem.TrimSpaces(stemp: string): string;
const Remove = [' ', #13, #10];
var
  i: integer;
begin
  result := '';
  for i := 1 to length(stemp) do begin
    if not (stemp[i] in remove) then
      result := result+stemp[i];
  end;
end;
//#########################################################################################
function Tsystem.PidByProcessPath_PPID(pid:string):string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
begin
   if not FileExists('/proc/'+pid+'/status') then exit;
   l:=TstringList.Create;
   try
      if not FileExists('/proc/'+pid+'/status') then exit;
      l.LoadFromFile('/proc/'+pid+'/status');
   except
     exit;
   end;
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^PPid:\s+([0-9]+)';
   For i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=RegExpr.Match[1];
          break;
       end;
   end;
   RegExpr.free;
   l.free;
end;
//#########################################################################################
function Tsystem.LOCATE_DANSGUARDIAN_BIN_PATH():string;
begin
    if FileExists('/usr/sbin/dansguardian') then exit('/usr/sbin/dansguardian');
end;
//##############################################################################


function Tsystem.GetDirectorySize(path:string):longint;
Var Info : TSearchRec;
    Count : Longint;
    DirectorySize:longint;
Begin
  result:=0;
  Count:=0;
  DirectorySize:=0;
  If FindFirst (path+'/*',faAnyFile and faDirectory,Info)=0 then
    begin
    Repeat
      Inc(Count);
      With Info do
        begin
        If (Attr and faDirectory) = faDirectory then
          Write('Dir : ');
        Writeln (Name:40,Size:15);
        DirectorySize:=DirectorySize+Size;
        end;
    Until FindNext(info)<>0;
    end;
  FindClose(Info);
  Writeln ('Finished search. Found ' + IntTostr(Count) +' matches ' + IntToStr(DirectorySize) + ' size');
end;




procedure Tsystem.ShowScreen(line:string);
 var  logs:Tlogs;
 begin
    logs:=Tlogs.Create();
    writeln('Tsystem::' + line);
    logs.Enable_echo_install:=True;
    logs.Logs('Tsystem::' + line);
    logs.free;

 END;
//#########################################################################################
function Tsystem.COMMANDLINE_PARAMETERS(FoundWhatPattern:string):boolean;
var
   i:integer;
   s:string;
   RegExpr:TRegExpr;

begin
 s:='';
 result:=false;
 if ParamCount>0 then begin
     for i:=1 to ParamCount do begin
        s:=s  + ' ' +ParamStr(i);
     end;
 end;
   FoundWhatPattern:=AnsiReplaceText(FoundWhatPattern,'-','\-');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:=FoundWhatPattern;
   //writeln(RegExpr.Expression,' -> ', s,' ParamCount:',ParamCount);
   if RegExpr.Exec(s) then begin
      RegExpr.Free;
      result:=True;
   end;


end;
//##############################################################################
function Tsystem.zGetUsername(gid:string):string;
begin
try
   result:=GetUserName(StrToInt(gid));
except
      exit;
end;
end;
//##############################################################################
procedure Tsystem.FindDirs(ADir: string);

  procedure DoRest(_ADir: string);
  var
    sr: TSearchRec;
    e: LongInt;
    Strs: TStrings;
    i: integer;
    D: boolean;
  begin
  D:=false;
  D:=COMMANDLINE_PARAMETERS('debug');
  if D then writeln(Adir);
  if Copy(_ADir,length(_ADir),1)<>'/' then _ADir:=_ADir +'/';
    if D then writeln('_ADir=',_ADir);
    if SetCurrentDir(_ADir) then begin
      if D then writeln('initialize strs');
      Strs := TStringList.Create;
      try
        e := FindFirst('*',faDirectory, sr);
        while e = 0 do begin
          if D then writeln(sr.Name[1],'=',sr.Attr);
          if (sr.Attr=48) and (sr.Name[1] <> '.') then begin
             Strs.Add(_ADir + sr.Name);
          end;
          e := FindNext(sr);
        end;
        FindClose(sr);
        if Strs.Count > 0 then
          with Strs do
            for i:=Count-1 downto 0 do begin
              DirListFiles.Add(Strs.Strings[i]);
              FindDirs(Strings[i]);
            end;
      finally
        Strs.Free;
      end;
    end;
  end;
var
  sr: TSearchRec;
  e: LongInt;
  Strs: TStrings;
  i: integer;
begin
 // ADir := AddSlash(ADir);

if Copy(ADir,length(ADir),1)<>'/' then ADir:=ADir +'/';


  if SetCurrentDir(ADir) then
  begin
    Strs := TStringList.Create;
    try
      e := FindFirst('*', faDirectory, sr);
      while e = 0 do begin
        if (sr.Attr=48) and (sr.Name[1] <> '.') then begin
          Strs.Add(ADir + sr.Name);
        end;
          e := FindNext(sr);
      end;
      FindClose(sr);
      if Strs.Count > 0 then
           for i:=Strs.Count-1 downto 0 do begin
            DirListFiles.Add(Strs.Strings[i]);
            DoRest(Strs.Strings[i]);
          end;
    finally
      Strs.Free;
    end;
  end;
end;
//#############################################################################
function Tsystem.GET_PID_FROM_PATH(pidPath:string):string;
var
   RegExpr:TRegExpr;
   logs:Tlogs;
   D:Boolean;
   pid:string;
begin
d:=verbosed;


if not FileExists(pidPath) then exit;
 RegExpr:=TRegExpr.Create;
 RegExpr.Expression:='([0-9]+)';
 logs:=Tlogs.Create;

try
   if RegExpr.Exec(ReadFromFile(pidPath)) then begin
      pid:=RegExpr.Match[1];
      if not FileExists('/etc/artica-postfix/AS_VPS_CLIENT') then begin
         result:=pid;
         RegExpr.Free;
         exit;
      end;

      if FileExists(LOCATE_GENERIC_BIN('cgconfigparser')) then begin
        result:=pid;
        RegExpr.Free;
        exit;
      end;

      if not FileExists('/proc/'+pid+'/cgroup') then  begin
        result:=pid;
        RegExpr.Free;
        exit;
      end;



      RegExpr.Expression:='[0-9]+.+?:/.+?$';
      if RegExpr.Exec(ReadFromFile('/proc/'+pid+'/cgroup')) then begin
         if D then writeln('Tsystem::GET_PID_FROM_PATH:: -> ',pid,': it is a chrooted process, return null');
         result:='';
         RegExpr.Free;
         exit;
      end;

   end;

except
   logs.Debuglogs('Error while read ' + pidPath);
end;

 if D then writeln('Tsystem::GET_PID_FROM_PATH:: ->',result, ' for ' ,pidPath);
end;
//#############################################################################
function Tsystem.ReadFromFile(TargetPath:string):string;
         const
            CR = #$0d;
            LF = #$0a;
            CRLF = CR + LF;
var
  F:textfile;
  teststr: string;
  s:string;
begin
  if not FileExists(TargetPath) then exit;
  assignfile(F,TargetPath);
 reset(F);
          repeat
                readln(F,s);
                teststr:=teststr+s+CRLF;
          until eof(F);
 closefile(F);
 result:=teststr;
end;
//###########################################################################
function Tsystem.PROCESS_ISCHROOTED(pid:string):boolean;
var
RegExpr:TRegExpr;
chrootedVPS:string;
stringspid,s:string;
cgroup_path:string;
pidint:integer;
F:textfile;
begin
   if DisableCgroups=1 then exit(false);
   if LXC_INSTALLED=0 then exit(false);
   result:=false;
   pid:=trim(pid);
   if not TryStrToInt(pid,pidint) then exit;
   if FileExists('/etc/artica-postfix/AS_VPS_CLIENT') then exit();
   if FileExists('/usr/sbin/cgconfigparser') then exit();
   if not FileExists('/proc/'+pid+'/cgroup') then exit();
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='[0-9]+.+?:/(.+?)$';
   cgroup_path:='/proc/'+pid+'/cgroup';
   if verbosed then writeln('Tsystem::PROCESS_ISCHROOTED:: -> open ',cgroup_path);
   try
      assignfile(F,cgroup_path);
      reset(F);
    repeat
       readln(F,s);
       if RegExpr.Exec(s) then begin
        chrootedVPS:=trim(RegExpr.match[1]);
        if verbosed then writeln('Tsystem::PROCESS_ISCHROOTED:: -> ',pid,': it is a chrooted process for VPS "',chrootedVPS,'" return true');
        result:=true;
        RegExpr.Free;
        closefile(F);
        exit;
      end;
    until eof(F);
    closefile(F);
    finally
   end;
   RegExpr.Free;
   exit;
end;
//###########################################################################
function Tsystem.PROCESS_EXIST(pid:string):boolean;
var
RegExpr:TRegExpr;

begin

  result:=false;
  pid:=trim(pid);
   if verbosed then writeln('PROCESS_EXIST(',pid,'): -> checks if exists...');
  if pid='0' then begin
     if verbosed then writeln('PROCESS_EXIST(',pid,'): 0 is the kernel -> FALSE');
     exit(false);
  end;

  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^([0-9]+)';
  if not RegExpr.Exec(pid) then begin
        if verbosed then writeln('PROCESS_EXIST(',pid,'): not an integer');
        RegExpr.free;
        exit(false);
  end;

  pid:=RegExpr.Match[1];
  if not fileExists('/proc/' + pid + '/exe') then begin
     if verbosed then writeln('PROCESS_EXIST(',pid,'):/proc/' + pid + '/exe does not exists...');
     if not FileExists('/proc/'+pid+'/cmdline') then begin
       if verbosed then writeln('PROCESS_EXIST(',pid,'):/proc/' + pid + '/cmdline does not exists... -> FALSE');
       exit(false);
     end;
  end;

  if fileExists('/proc/' + pid + '/exe') then begin
     if verbosed then writeln('PROCESS_EXIST(',pid,'):/proc/' + pid + '/exe exists...');
     if PROCESS_ISCHROOTED(pid) then exit(false);
     if IS_ZOMBIE(pid) then exit(false);
     exit(true);
  end;

  if verbosed then writeln('PROCESS_EXIST(',pid,'): not in memory');
  exit(false);

end;
//#############################################################################
function Tsystem.IS_ZOMBIE(PID:string):boolean;
var
RegExpr:TRegExpr;
l:Tstringlist;
i:integer;
begin
  if not FileExists('/proc/'+PID+'/status') then exit(false);
  l:=Tstringlist.Create;
  try
      if not FileExists('/proc/'+pid+'/status') then exit;
      l.LoadFromFile('/proc/'+PID+'/status');
  except
    exit();
  end;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='State:\s+([A-Z])';
  result:=false;
//  State:	Z (zombie)
  for i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           if trim(RegExpr.Match[1])='Z' then result:=true;
           break;
        end;
  end;

  l.free;
  RegExpr.free;

end;

function Tsystem.PROCESS_MEMORY(PID:string):integer;
var
   RegExpr:TRegExpr;
   i:Integer;
   FATHER:integer;
   D:Boolean;
   fils:TstringList;
   oldpid:string;
begin
D:=false;
D:=COMMANDLINE_PARAMETERS('debug');
result:=0;
oldpid:=PID;
FATHER:=0;

if D then writeln(' ************* PROCESS_MEMORY PID '+ PID + '************* ');

PID:=trim(PID);
if PID='0' then begin
   if D then writeln('PID=',PID, ' aborting...');
   exit;
end;

if length(PID)=0 then begin
  if D then writeln('PID=NULL aborting...');
   exit;
end;


  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^([0-9]+)';
  if not RegExpr.Exec(PID) then begin
     exit;
  end else begin
      PID:=RegExpr.Match[1];
  end;


  PID:=IntToStr(GET_PPID(StrToInt(PID)));

  if D then writeln('Get PPID from:',oldpid,' Father PID=',PID);

  FATHER:=PROCESS_MEMORY_SINGLE(PID);
  fils:=TstringList.Create;
  fils.Clear;
  fils.AddStrings(LIST_PID_BY_PIDFATHER(PID));
  if D then writeln('FATHER Memory (',PID,')=',FATHER, ' kb Fils number=',fils.Count);

  for i:=0 to fils.Count-1 do begin
      if D then writeln('Fils ->',fils.Strings[i]);
      FATHER:=FATHER+PROCESS_MEMORY_SINGLE(fils.Strings[i]);
  end;

  if D then writeln('Global Memory=',FATHER);


result:=FATHER;

end;
//##############################################################################
function Tsystem.LIST_PID_BY_PIDFATHER(PPID:string):TstringList;
var
   l:TstringList;
   s:TstringList;
   i,z:Integer;
   RegExpr:TRegExpr;
   lefils:string;
   raz:TstringList;
   D:boolean;
begin
   d:=false;
   D:=COMMANDLINE_PARAMETERS('debug');
   raz:=TstringList.Create;
   l:=TstringList.Create;
   l.AddStrings(DirectoryListTstring('/proc'));
   s:=TstringList.Create;
   RegExpr:=TRegExpr.Create;
   if ParamStr(1)='--fils' then D:=true;

   for i:=0 to l.Count-1 do begin

      if FileExists(l.Strings[i]+'/status') then begin
           try s.LoadFromFile(l.Strings[i]+'/status'); except  result:=raz;  exit; end;
           for z:=0 to s.Count-1 do begin
               RegExpr.Expression:='^Pid:\s+([0-9]+)';
               if RegExpr.Exec(s.Strings[z]) then lefils:=RegExpr.Match[1];
               RegExpr.Expression:='^PPid:\s+'+PPID;
               if RegExpr.Exec(s.Strings[z]) then begin
                  raz.Add(lefils);
                  if D then writeln('sub-process: ',lefils, ' ',l.Strings[i]);
                  break;
               end;
           end;
      end;
   end;
   if D then writeln('This PPID has:',raz.Count,' PID forked');
   result:=raz;
   s.free;
   l.free;
   RegExpr.free;
   //raz.free;

end;
//##############################################################################
function Tsystem.GET_PPID(PID:integer):integer;
var
   S:Tstringlist;
   RegExpr:TRegExpr;
   I:INTEGER;
   PidPath:string;
begin
  result:=PID;
  if PID=0 then exit;
  PidPath:='/proc/' + IntToStr(PID) + '/status';
if not FileExists(PidPath) then begin
       exit(0);
     end;

 try s:=TStringList.Create; except exit; end;
 try s.LoadFromFile(PidPath); except exit;end;

  RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^(PPid|PPID):\s+([0-9]+)';
     for i:=0 to s.Count-1 do begin
       if RegExpr.Exec(s.Strings[i]) then begin
          result:=StrToInt(trim(RegExpr.Match[2]));
          if Result=1 then result:=PID;
          break;
       end;
     end;
s.free;
RegExpr.free;
end;
//##############################################################################
function Tsystem.GET_CPU_POURCENT(PID:integer):integer;
var
RegExpr:TRegExpr;
begin
   result:=0;
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='([0-9]+)';
   if RegExpr.Exec(ExecPipe(LOCATE_GENERIC_BIN('ps')+' -p '+ IntToStr(PID)+' -o pcpu --no-heading')) then result:=StrToInt(RegExpr.Match[1]);
   RegExpr.free;
end;
//##############################################################################
function Tsystem.LOCATE_PIDOF():string;
begin
if FileExists('/bin/pidof') then exit('/bin/pidof');
if FileExists('/sbin/pidof') then exit('/sbin/pidof');
exit(GET_INFO('pidof'));
end;
//##############################################################################
function Tsystem.WHO_LISTEN_PORT(port:string):string;
var
   xjklogs:tLogs;
   tmpstr:string;
   l:Tstringlist;
   RegExpr:TRegExpr;
   i:Integer;
   mypid:string;
   org_cmdline:string;
begin
    xjklogs:=Tlogs.Create;
    tmpstr:=xjklogs.FILE_TEMP();
    fpsystem('netstat -p -l >'+tmpstr+' 2>&1');
    if not FileExists(tmpstr) then exit;
    l:=Tstringlist.Create;
    l.LoadFromFile(tmpstr);
    xjklogs.DeleteFile(tmpstr);
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='^[A-Za-z0-9]+\s+[0-9]+\s+[0-9]+\s+.+?:'+port+'\s+.+?LISTEN\s+([0-9]+)\/(.+?)$';
    for i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           result:='Pid:'+RegExpr.Match[1]+';Process:'+RegExpr.Match[2];
           break;
        end;
    end;

    l.free;
    RegExpr.free;
    xjklogs.free;

end;
//##############################################################################
function Tsystem.PIDOF_PATTERN(pattern:string):string;
var
   xjklogs:tLogs;
   tmpstr:string;
   ll:Tstringlist;
   RegExpr,RegExpr2:TRegExpr;
   i:Integer;
   mypid:string;
   org_cmdline:string;
   pgrep:string;
   cmdtoexec:string;
   PidDetected:string;
begin
    xjklogs:=Tlogs.Create;
    tmpstr:=xjklogs.FILE_TEMP();
    if length(mem_pgrep)=0 then begin
       pgrep:=LOCATE_GENERIC_BIN('pgrep');
       mem_pgrep:=pgrep;
    end else begin
     pgrep:=mem_pgrep;
    end;


    if not FileExists(pgrep) then begin
       xjklogs.Syslogs(' Tsystem.PIDOF_PATTERN():: unable to stat pgrep !!');
       exit;
    end;


    if pos('.+',pattern)=0 then begin
       if pos('.*',pattern)=0 then begin
          pattern:=AnsiReplaceText(pattern,'-','\-');
          pattern:=AnsiReplaceText(pattern,'.','\.');
       end;
    end;

    cmdtoexec:=pgrep+' -l -f "'+pattern+'" >'+tmpstr+' 2>&1';
    if verbosed then begin

       if DEBUG then xjklogs.Debuglogs('PIDOF_PATTERN():: Search "'+ pattern+'"');
       if DEBUG then xjklogs.Debuglogs('PIDOF_PATTERN():: cmd '+cmdtoexec);
       writeln('..............');
       fpsystem(pgrep+' -f "'+pattern+'"');
       writeln('..............');
    end;
    fpsystem(cmdtoexec);



    ll:=Tstringlist.CReate;
    if not FileExists(tmpstr) then begin
        xjklogs.debuglogs('PIDOF_PATTERN():: FATAL ERROR while reading file '+ tmpstr);
        exit;
    end;

    mypid:=IntToStr(fpgetpid);
    try
       ll.LOadFromFile(tmpstr);
    except
       xjklogs.debuglogs('PIDOF_PATTERN():: FATAL ERROR while reading file '+ tmpstr);
      exit;
    end;

     if verbosed then writeln('PIDOF_PATTERN()::',ll.Count,' lines');
    xjklogs.DeleteFile(tmpstr);
    RegExpr:=TRegExpr.Create;
    RegExpr2:=TRegExpr.Create;

    for i:=0 to ll.Count-1 do begin
        PidDetected:='';
        RegExpr.Expression:='^([0-9]+)\s+(.+)';
        if not RegExpr.Exec(ll.Strings[i]) then begin
           if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: '+ll.Strings[i]+' -> NO MATCH');
           continue;
        end;

        if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: '+RegExpr.Match[1]+' -> PID "'+RegExpr.Match[2]+'"');
        PidDetected:=RegExpr.Match[1];
        RegExpr.Expression:='pgrep';
        if RegExpr.Exec(RegExpr.Match[2]) then begin
           if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: pgrep detected -> continue;');
           continue;
        end;

        if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: READ:/proc/'+PidDetected);
        if DirectoryExists('/proc/'+PidDetected) then begin
              if RegExpr.Match[1]=mypid then continue;
              if PROCESS_ISCHROOTED(PidDetected) then continue;
              if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: READ:/proc/'+PidDetected+'/exec');
              if not FileExists('/proc/'+PidDetected+'/exec') then begin
                 if not FileExists('/proc/'+PidDetected+'/cmdline') then begin
                   if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: READ:/proc/'+PidDetected+'/cmdline no such file, pid '+PidDetected+' is not in memory');
                   continue;
                 end;
              end;

              if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: OPEN:/proc/'+PidDetected+'/cmdline');
              if FileExists('/proc/'+PidDetected+'/cmdline') then begin
                 org_cmdline:=trim(ReadFileIntoString('/proc'+'/'+PidDetected+'/cmdline'));
                 if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);
                 if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: OPEN:/proc/'+PidDetected+'/cmdline -> "'+org_cmdline+'"');
                 RegExpr2.Expression:='^/bin/sh\s+';
                 if RegExpr2.Exec(org_cmdline) then begin
                    if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: /bin/sh detected, continue -> "'+org_cmdline+'"');
                    continue;
                 end;

                 RegExpr2.Expression:='^sh -c';
                 if RegExpr2.Exec(org_cmdline) then begin
                    if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: /bin/sh detected, continue -> "'+org_cmdline+'"');
                    continue;
                 end;

              end;


              if PidDetected=mypid then begin
                   if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: '+PidDetected+' my pid is '+mypid+' ->Continue');
                   PidDetected:='';
                   continue;
              end;
              if verbosed then xjklogs.Debuglogs('PIDOF_PATTERN('+pattern+'):: Executed :'+PidDetected+' "'+org_cmdline+'"');
              result:=PidDetected;
              break;
            end;
    end;

    i:=0;


    TryStrToInt(result,i);
    if I<2 then result:='';
    ll.free;
    RegExpr.free;
    RegExpr2.free;
    xjklogs.FRee;

end;
//##############################################################################
function Tsystem.PIDOF_PATTERN_PROCESS_NUMBER(pattern:string):integer;
var
   xjklogs:tLogs;
   tmpstr:string;
   ll:Tstringlist;
   RegExpr:TRegExpr;
   i:Integer;
   mypid:string;
   cmd:string;
   pgrep:string;
begin
    mypid:=IntToStr(fpgetpid);
    xjklogs:=Tlogs.Create;
    tmpstr:=xjklogs.FILE_TEMP();
    pgrep:=LOCATE_GENERIC_BIN('pgrep');
    cmd:=pgrep+' -f "'+pattern+'" >'+tmpstr+' 2>&1';
    fpsystem(cmd);
    ll:=Tstringlist.CReate;
    try
       ll.LoadFromFile(tmpstr);
    except
      xjklogs.Syslogs('PIDOF_PATTERN_PROCESS_NUMBER():: FATAL ERROR while reading file '+ tmpstr);
      xjklogs.Syslogs('PIDOF_PATTERN_PROCESS_NUMBER():: After executing '+cmd);
      exit;
    end;

    result:=0;
    xjklogs.DeleteFile(tmpstr);
    xjklogs.free;
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='([0-9]+)';
    for i:=0 to ll.Count-1 do begin

        if RegExpr.Exec(ll.Strings[i]) then begin
           if RegExpr.Match[1]<>mypid then begin
              if PROCESS_EXIST(RegExpr.Match[1]) then inc(result);
           end;
        end;
    end;

    ll.free;
    RegExpr.free;
end;
//##############################################################################
function Tsystem.PIDOF_PATTERN_PROCESS_LIST(pattern:string):TstringList;
var
   xjklogs:tLogs;
   tmpstr:string;
   ll:Tstringlist;
   RegExpr:TRegExpr;
   i:Integer;
   s:TstringList;
   mypid:string;
   path:string;
   cmd:string;
begin
    xjklogs:=Tlogs.Create;
    mypid:=IntToStr(fpgetpid);
    tmpstr:=xjklogs.FILE_TEMP();
    cmd:='/usr/bin/pgrep -f "'+pattern+'" >'+tmpstr+' 2>&1';
    xjklogs.Debuglogs(cmd);
    fpsystem('/usr/bin/pgrep -f "'+pattern+'" >'+tmpstr+' 2>&1');
    s:=TstringList.Create;
    ll:=Tstringlist.CReate;
    try
       ll.LOadFromFile(tmpstr);
    except
      xjklogs.Syslogs('PIDOF_PATTERN_PROCESS_NUMBER():: FATAL ERROR while reading file '+ tmpstr);
      result:=s;
      exit;
    end;


    xjklogs.DeleteFile(tmpstr);

    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='([0-9]+)';

    result:=s;
    for i:=0 to ll.Count-1 do begin
        xjklogs.Debuglogs('PIDOF_PATTERN_PROCESS_LIST:: '+ll.Strings[i]);
        if RegExpr.Exec(ll.Strings[i]) then begin
           if RegExpr.Match[1]<>mypid then begin
              if PROCESS_EXIST(RegExpr.Match[1]) then begin
                 s.Add(RegExpr.Match[1]);
                 xjklogs.Debuglogs('PIDOF_PATTERN_PROCESS_LIST:: '+RegExpr.Match[1]+' ->' + fpReadlink('/proc/'+RegExpr.Match[1]+'/exec'));
              end;
           end;
        end else begin
            xjklogs.Debuglogs('PIDOF_PATTERN_PROCESS_LIST:: No match "'+ll.Strings[i]+'"');
        end;
    end;
    xjklogs.free;
    ll.free;
    RegExpr.free;
    result:=s;
end;
//##############################################################################
function Tsystem.PIDOF(process:string):string;
var
   ll:string;
   RegExpr:TRegExpr;
   strmp:string;
   i:integer;
   l:Tstringlist;
   pidint:integer;
   ppidint:integer;
   slogs:tlogs;
begin
   if length(trim(pidof_path))=0 then pidof_path:=LOCATE_GENERIC_BIN('pidof');
   if not fileExists(pidof_path) then begin
      writeln('Unable to stat pidof !!, please create a file /etc/artica-postfix/settings/Daemons/pidof');
      writeln('and put the path in this file');
      exit;
   end;
   slogs:=tlogs.Create;
   result:='';
   strmp:=slogs.FILE_TEMP();
   fpsystem(pidof_path+' -s ' + process +' >'+strmp+' 2>&1');
   result:=trim(slogs.ReadFromFile(strmp));
   slogs.DeleteFile(strmp);
   pidint:=0;
   ppidint:=0;
   if not TryStrToInt(result,pidint) then exit;
   if pidint<2 then begin
      result:='';
      exit;
   end;

   if PROCESS_ISCHROOTED(result)then begin
      result:='';
      exit;
   end;

   if FileExists('/proc/'+result+'/status') then begin
          RegExpr:=TRegExpr.Create;
          RegExpr.Expression:='PPid:\s+([0-9]+)';
          l:=Tstringlist.Create;
          l.LoadFromFile('/proc/'+result+'/status');
          for i:=0 to l.Count-1 do begin
              if RegExpr.Exec(l.Strings[i]) then begin
                   if not TryStrToInt(RegExpr.Match[1],ppidint) then break;
                   if ppidint=pidint then break;

                   if ppidint=1 then break;
                   if ppidint>1 then result:=IntToStr(ppidint);
                    break;
                   end;
              end;
   end;
end;
//##############################################################################
function Tsystem.PROCESS_NUMBER(process:string):integer;
var
   ll:string;
   exp:TStringDynArray;
begin
   if length(pidof_path)=0 then pidof_path:=LOCATE_PIDOF();
   if not fileExists(pidof_path) then begin
      writeln('Unable to stat pidof !!, please create a file /etc/artica-postfix/settings/Daemons/pidof');
      writeln('and put the path in this file');
      exit;
   end;

   result:=0;
   ll:=ExecPipe(pidof_path+' ' + process);

   exp:=explode(' ',ll);
   result:=length(exp);
end;
//##############################################################################
function Tsystem.PROCESSES_LIST(process:string):string;
var
   ll:string;
begin
   if length(pidof_path)=0 then pidof_path:=LOCATE_PIDOF();
   if not fileExists(pidof_path) then begin
      writeln('Unable to stat pidof !!, please create a file /etc/artica-postfix/settings/Daemons/pidof');
      writeln('and put the path in this file');
      exit;
   end;

   result:='';
   ll:=ExecPipe(pidof_path+' ' + process);
   result:=trim(ll);
end;
//##############################################################################
function Tsystem.PROCESSES_LIST_STRINGLIST(process:string):Tstringlist;
var
   ll:string;
   exp:TStringDynArray;
   l:TstringList;
   i:integer;
begin
   if length(pidof_path)=0 then pidof_path:=LOCATE_PIDOF();
   if not fileExists(pidof_path) then begin
      writeln('Unable to stat pidof !!, please create a file /etc/artica-postfix/settings/Daemons/pidof');
      writeln('and put the path in this file');
      exit;
   end;


   ll:=ExecPipe(pidof_path+' ' + process);
   exp:=explode(' ',ll);
   l:=Tstringlist.Create;
   result:=l;
   for i:=0 to length(exp)-1 do begin
       if length(exp[i])>0 then begin
          if PROCESS_ISCHROOTED(exp[i]) then continue;
          l.Add(exp[i]);
       end;
   end;

   result:=l;
end;
//##############################################################################


function Tsystem.CHECK_PERL_MODULES(ModulesToCheck:string):boolean;
var
   cmd:string;
   l:TstringList;
   RegExpr:TRegExpr;
   logs:Tlogs;
   tmpstr:string;
begin
result:=false;
logs:=Tlogs.Create;
tmpstr:=logs.FILE_TEMP();
if not FileExists(LOCATE_PERL_BIN()) then exit;
cmd:=LOCATE_PERL_BIN()+' -M'+ModulesToCheck+' -e ''print "$'+ModulesToCheck+'::VERSION\n"''';
logs.Debuglogs(cmd);
fpsystem(cmd + ' >'+tmpstr+' 2>&1');
 l:=TstringList.Create;
 RegExpr:=TRegExpr.Create;
 if not FileExists(tmpstr) then exit;
 l.LoadFromFile(tmpstr);
 logs.DeleteFile(tmpstr);
 RegExpr.Expression:='([0-9\.]+)';
 if RegExpr.Exec(l.Strings[0]) then begin
    if trim(RegExpr.Match[1])='.' then begin
      logs.Debuglogs('CHECK_PERL_MODULES:: failed result=' + l.Strings[0]);
      L.free;
      RegExpr.Free;
      exit;
    end;
    logs.Debuglogs('CHECK_PERL_MODULES:: success '+ModulesToCheck + ' version ' + RegExpr.Match[1]);
    result:=true;
 end else begin
 logs.Debuglogs('CHECK_PERL_MODULES:: result=' + l.Strings[0]);
 end;
 L.free;
 RegExpr.Free;
 logs.Free;
end;
//##############################################################################
function Tsystem.CHECK_PERL_MODULES_VERSION(ModulesToCheck:string):string;
var
   cmd:string;
   l:TstringList;
   RegExpr:TRegExpr;
   logs:Tlogs;
   tmpstr:string;
begin
result:='';
logs:=Tlogs.Create;
tmpstr:=logs.FILE_TEMP();
if not FileExists(LOCATE_PERL_BIN()) then exit;
cmd:=LOCATE_PERL_BIN()+' -M'+ModulesToCheck+' -e ''print "$'+ModulesToCheck+'::VERSION\n"''';
logs.Debuglogs(cmd);
fpsystem(cmd + ' >'+tmpstr+' 2>&1');
 l:=TstringList.Create;
 RegExpr:=TRegExpr.Create;
 if not FileExists(tmpstr) then exit;
 l.LoadFromFile(tmpstr);
 logs.DeleteFile(tmpstr);
 RegExpr.Expression:='([0-9\.]+)';
 if RegExpr.Exec(l.Strings[0]) then begin
    if trim(RegExpr.Match[1])='.' then begin
      logs.Debuglogs('CHECK_PERL_MODULES_VERSION:: result=' + l.Strings[0]);
       L.free;
       RegExpr.Free;
       exit;
    end;
    logs.Debuglogs('CHECK_PERL_MODULES_VERSION::'+ModulesToCheck + ' version ' + RegExpr.Match[1]);
    result:=RegExpr.Match[1];
 end else begin
 logs.Debuglogs('CHECK_PERL_MODULES_VERSION:: result=' + l.Strings[0]);
 end;
 L.free;
 RegExpr.Free;
 logs.Free;
end;
//##############################################################################
function Tsystem.LOCATE_PERL_BIN():string;
var
logs:Tlogs;
binpath:string;
begin
result:=LOCATE_GENERIC_BIN('perl');
if length(result)>2 then exit;
logs:=Tlogs.Create;
logs.Syslogs('LOCATE_PERL_BIN():: Unable to locate perl (usually in /usr/bin/perl)');
logs.Free;
end;
//##############################################################################
function Tsystem.LOCATE_NOHUP():string;
var
logs:Tlogs;
begin
if FileExists('/usr/bin/nohup') then exit('/usr/bin/nohup');
if FileExists('/usr/sbin/nohup') then exit('/usr/sbin/nohup');
if FileExists('/sbin/nohup') then exit('/sbin/nohup');
if FileExists('/bin/nohup') then exit('/bin/nohup');
if FileExists('/usr/local/bin/nohup') then exit('/usr/local/bin/nohup');
if FileExists('/usr/local/sbin/nohup') then exit('/usr/local/sbin/nohup');
logs:=Tlogs.Create;
logs.Syslogs('LOCATE_NOHUP():: Unable to locate perl (usually in /usr/bin/nohup)');
logs.Free;
end;
//##############################################################################
function Tsystem.PROCESS_MEMORY_SINGLE(PID:string):integer;
var
   S:Tstringlist;
   RegExpr:TRegExpr;
   I:INTEGER;
   D:boolean;
begin
     result:=0;
     D:=False;
     if length(PID)=0 then exit;
     if PID='0' then exit;
     D:=verbosed;


     if not FileExists('/proc/' + trim(PID) + '/status') then begin
        if D then writeln('SYSTEM_PROCESS_MEMORY_SINGLE:: Could not find /proc/' + trim(PID) + '/status');
        exit(0);
     end;

      if PROCESS_ISCHROOTED(PID) then  exit(0);


     s:=TStringList.Create;
     try S.LoadFromFile('/proc/' + trim(PID) + '/status'); except exit; end;

     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^VmRSS:\s+([0-9]+)';
     for i:=0 to s.Count-1 do begin
       if RegExpr.Exec(s.Strings[i]) then begin
          if D then writeln('/proc/' + trim(PID) + '/status ',trim(RegExpr.Match[1]),' kb');
          result:=StrToInt(trim(RegExpr.Match[1]));
          break;
       end;
     end;

s.free;
RegExpr.free;

end;
//##############################################################################
function Tsystem.MD5FromString(value:string):string;
var
Digest:TMD5Digest;
begin
Digest:=MD5String(value);
exit(MD5Print(Digest));
end;
//##############################################################################
function Tsystem.sudo_path():string;
begin
if FileExists('/usr/bin/sudo') then exit('/usr/bin/sudo');
end;
//##############################################################################
function Tsystem.PROCESS_STATUS(PID:string):string;
var
   S:Tstringlist;
   RegExpr:TRegExpr;
   I:INTEGER;
   D:boolean;
begin
     result:='';
     RegExpr:=TRegExpr.Create;

     if length(PID)=0 then exit;
     PID:=trim(PID);
     RegExpr.Expression:='^([0-9]+)';
     if PID='0' then exit;
     D:=False;
     D:=COMMANDLINE_PARAMETERS('debug');


     if D then writeln('SYSTEM_PROCESS_STATUS::->',PID);

     if RegExpr.Exec(PID) then begin
        PID:=RegExpr.Match[1];
        if D then writeln('SYSTEM_PROCESS_STATUS:: AFTER REGEX ->',PID);
     end else begin
        if D then writeln('SYSTEM_PROCESS_STATUS:: BAD MATCH REGEX ->',PID);
        exit;
     end;


     if not FileExists('/proc/' + trim(PID) + '/status') then begin
        if D then writeln('SYSTEM_PROCESS_STATUS:: Could not find /proc/' + trim(PID) + '/status');
        exit('0');
     end;
     s:=TStringList.Create;
     try S.LoadFromFile('/proc/' + trim(PID) + '/status'); except exit; end;
     if D then writeln('SYSTEM_PROCESS_STATUS:: /proc/' + trim(PID) + '/status');

     RegExpr.Expression:='^State:\s+([A-Z])\s+\(([a-zA-Z]+)\)';
     for i:=0 to s.Count-1 do begin
       if RegExpr.Exec(s.Strings[i]) then begin
          if D then writeln('SYSTEM_PROCESS_STATUS :',PID,'=',RegExpr.Match[2],': ',RegExpr.Match[1],' ',s.Strings[i]);
          result:=trim(RegExpr.Match[2]);
          break;
       end;
     end;

s.free;
RegExpr.free;

end;
//##############################################################################
function Tsystem.FILE_CHOWN(username:string;groupname:string;path:string):boolean;
var
   logs:Tlogs;
begin
   result:=false;
   logs:=Tlogs.Create;

   if path='/var/log' then exit;
   if path='/var/log/' then exit;
   if path='/var' then exit;
   if path='/var/' then exit;

   logs.Debuglogs('Tsystem.FILE_CHOWN /bin/chown -R '+ username + ':' + groupname + ' ' + path);
   fpsystem('/bin/chown -R '+ username + ':' + groupname + ' ' + path);
end;
//##############################################################################
function Tsystem.PROCESS_LIST_PID(processname:string):string;
begin
result:=trim(ExecPipe(LOCATE_PIDOF()+' "'+processname+'"'));
end;
//##############################################################################
function Tsystem.OPENSSL_CERTIFCATE_HOSTS():string;
var
   l:Tstringlist;
   conf_path:string;
   i:integer;
   subjectAltName:string;
   final:Tstringlist;
   D:boolean;
begin
   conf_path:='/etc/artica-postfix/settings/Daemons/CertificateHostsList';
   d:=COMMANDLINE_PARAMETERS('--verbose');
   if not FileExists(conf_path) then exit;
   l:=Tstringlist.Create;
   l.LoadFromFile(conf_path);
   for i:=0 to l.Count-1 do begin
      if length(trim(l.Strings[i]))=0 then continue;
      if D then writeln('OPENSSL_CERTIFCATE_HOSTS:: '+l.Strings[i]);
      subjectAltName:=subjectAltName+'DNS:'+l.Strings[i]+',';
   end;

   if length(trim(subjectAltName))=0 then exit;
   if subjectAltName[length(subjectAltName)]=',' then subjectAltName:=copy(subjectAltName,0,length(subjectAltName)-1);
   result:=subjectAltName;
end;



procedure Tsystem.OPENSSL_CERTIFCATE_CONFIG();
var
   default_conf:string;
   HostName    :string;
   FILI        :TstringList;
   RegExpr     :TRegExpr;
   i           :integer;
   CertificateMaxDays:string;
   conf:TiniFile;
   policy_match:boolean;
   HOSTS_ADDONS:string;
   countryName:string;
   stateOrProvinceName:string;
   localityName:string;
   organizationName:string;
   emailAddress:string;
begin

    default_conf:=OPENSSL_CONFIGURATION_PATH();
    if not FileExists(default_conf) then begin
       writeln('OPENSSL_CERTIFCATE_CONFIG():: OPENSSL_CONFIGURATION_PATH() function failed');
       exit;
    end;
    writeln('starting certificate.........: Using certificate path '+default_conf);
    conf:=TiniFile.Create(default_conf);

    countryName:=conf.ReadString('default_ca','countryName_value','US');
    stateOrProvinceName:=conf.ReadString('default_ca','stateOrProvinceName_value','Delaware');
    localityName:=conf.ReadString('default_ca','localityName_value','Wilmington');
    organizationName:=conf.ReadString('default_ca','organizationName_value','Apache Software Foundation');
    emailAddress:=conf.ReadString('default_ca','emailAddress_value','coyote@apache.org');

    conf.EraseSection('HOSTS_ADDONS');


    if Paramstr(2)='hostname' then begin
       HostName:=Paramstr(3);
       conf.WriteString('default_ca','commonName_value',HostName);
    end;
    if length(HostName)=0 then HostName:=conf.ReadString('default_ca','commonName_value',getHostname());
    if HostName='Tomcat Demo Root CA.local' then HostName:=getHostname();

    HOSTS_ADDONS:=OPENSSL_CERTIFCATE_HOSTS();
    if length(trim(HOSTS_ADDONS))>0 then begin
        writeln('starting certificate.........: multiple hosts detected');
        conf.WriteString('HOSTS_ADDONS','basicConstraints','critical,CA:false');
        conf.WriteString('HOSTS_ADDONS','subjectKeyIdentifier','hash');
        conf.WriteString('HOSTS_ADDONS','keyUsage','digitalSignature, keyEncipherment');
        conf.WriteString('HOSTS_ADDONS','extendedKeyUsage','serverAuth, clientAuth');
        conf.WriteString('HOSTS_ADDONS','nsCertType','server');
        conf.WriteString('HOSTS_ADDONS','nsComment','Certificate '+HostName);
        conf.WriteString('HOSTS_ADDONS','subjectAltName',HOSTS_ADDONS);
        conf.WriteString('v3_req','basicConstraints','critical,CA:false');
        conf.WriteString('v3_req','keyUsage','nonRepudiation, digitalSignature, keyEncipherment');
        conf.WriteString('v3_req','subjectAltName','@HOSTS_ADDONS');
    end;

    writeln('starting certificate.........: Hostname is "'+HostName+'"');
    conf.WriteString('CA_default','policy','policy_match');
    conf.WriteString('ca','unique_subject','no');
    conf.WriteString('default_ca','unique_subject','no');
    conf.WriteString('default_db','policy','policy_match');
    conf.WriteString('policy_match','countryName','match');
    conf.WriteString('policy_match','stateOrProvinceName','match');
    conf.WriteString('policy_match','organizationName','match');
    conf.WriteString('policy_match','organizationalUnitName','optional');
    conf.WriteString('policy_match','commonName','supplied');
    conf.WriteString('policy_match','emailAddress','optional');
    conf.WriteString('policy_anything','countryName','optional');
    conf.WriteString('policy_anything','stateOrProvinceName','optional');
    conf.WriteString('policy_anything','localityName','optional');
    conf.WriteString('policy_anything','organizationName','optional');
    conf.WriteString('policy_anything','organizationalUnitName','optional');
    conf.WriteString('policy_anything','commonName','supplied');
    conf.WriteString('policy_anything','emailAddress','optional');
    conf.WriteString('v3_ca','subjectKeyIdentifier','hash');
    conf.WriteString('v3_ca','authorityKeyIdentifier','keyid:always,issuer:always');
    conf.WriteString('v3_ca','basicConstraints','critical,CA:false');
    conf.WriteString('req','distinguished_name','default_ca');

    conf.WriteString('default_ca','countryName_value',countryName);
    conf.WriteString('default_ca','countryName_min','2');
    conf.WriteString('default_ca','countryName_max','2');

    conf.WriteString('default_ca','stateOrProvinceName','State Name');
    conf.WriteString('default_ca','stateOrProvinceName_value',stateOrProvinceName);

    conf.WriteString('default_ca','localityName','Locality Name');
    conf.WriteString('default_ca','localityName_value',localityName);

    conf.WriteString('default_ca','organizationName','organization Name');
    conf.WriteString('default_ca','organizationName_value',organizationName);

    conf.WriteString('default_ca','commonName','common Name');
    conf.WriteString('default_ca','commonName_value',HostName);

    conf.WriteString('default_ca','emailAddress','email Address');
    conf.WriteString('default_ca','emailAddress_value',emailAddress);

    conf.UpdateFile;
    conf.Free;


    RegExpr:=TRegExpr.create;
    RegExpr.Expression:='(.+?)\.(.+)';
    if Paramstr(4)<>'strict' then begin
        if not RegExpr.Exec(HostName) then  HostName:=HostName+'.local';
    end;

    CertificateMaxDays:=GET_INFO('CertificateMaxDays');
    if length(CertificateMaxDays)=0 then CertificateMaxDays:='730';
    fpsystem('/bin/rm -rf /etc/ssl/certs/new');
    forceDirectories('/etc/ssl/certs/new');

    FILI:=TstringList.Create;
    FILI.LoadFromFile(default_conf);

    for i:=0 to FILI.Count -1 do begin
        RegExpr.Expression:='basicConstraints[\s=]+';
        if RegExpr.Exec(FILI.Strings[i]) then FILI.Strings[i]:='  basicConstraints                = critical,CA:false';

        RegExpr.Expression:='default_days[\s=]+';
        if RegExpr.Exec(FILI.Strings[i]) then FILI.Strings[i]:='  default_days                = '+CertificateMaxDays;

        RegExpr.Expression:='new_certs_dir[\s=]+';
        if RegExpr.Exec(FILI.Strings[i]) then FILI.Strings[i]:='  new_certs_dir                = /etc/ssl/certs/new';

        RegExpr.Expression:='database[\s=]+';
        if RegExpr.Exec(FILI.Strings[i]) then FILI.Strings[i]:='  database                = /etc/ssl/certs/new/ca.index';

        RegExpr.Expression:='serial[\s=]+';
        if RegExpr.Exec(FILI.Strings[i]) then FILI.Strings[i]:='  serial                = /etc/ssl/certs/new/ca.serial';

        RegExpr.Expression:='policy_match[\s=]+';
        if RegExpr.Exec(FILI.Strings[i]) then policy_match:=true;

    end;


        FILI.SaveToFile('/etc/artica-postfix/ssl.certificate.conf');

        conf:=TiniFile.Create('/etc/artica-postfix/ssl.certificate.conf');
        conf.WriteString('policy','commonName','supplied');
        conf.UpdateFile;
        conf.free;

        FILI.SaveToFile(default_conf);
        forceDirectories('/etc/ssl/certs/new');
        FILI.Clear;
        FILI.Add('unique_subject=no');
        FILI.SaveToFile('/etc/ssl/certs/new/ca.index.attr');




    if not FileExists('/etc/ssl/certs/new/ca.index') then fpsystem('/bin/touch /etc/ssl/certs/new/ca.index');
    if not FileExists('/etc/ssl/certs/new/ca.serial') then fpsystem('/bin/echo "01"> /etc/ssl/certs/new/ca.serial');

    writeln('starting certificate.........: writing /etc/artica-postfix/ssl.certificate.conf');


    Fili.Free;
    RegExpr.free;
end;
//#########################################################################################
function Tsystem.HOSTNAME_g():string;
var datas:string;
begin
 datas:=GET_INFO('myhostname');
 if length(datas)>1 then begin
    result:=datas;
    exit;
 end;
 forcedirectories('/opt/artica/tmp');
 fpsystem('/bin/hostname -f >/opt/artica/tmp/hostname.txt');
 datas:=ReadFileIntoString('/opt/artica/tmp/hostname.txt');
 result:=Trim(datas);
end;
 //#############################################################################
 function Tsystem.FileSize_ko(path:string):longint;
Var
L : File Of byte;
size:longint;
ko:longint;

begin
if not FileExists(path) then begin
   result:=0;
   exit;
end;
   TRY
  Assign (L,path);
  Reset (L);
  size:=FileSize(L);
   Close (L);
  ko:=size div 1024;
  result:=ko;
  EXCEPT

  end;
end;
 //#############################################################################
  function Tsystem.FileSize_bytes(path:string):longint;
Var
L : File Of byte;
size:longint;
begin
if not FileExists(path) then begin
   result:=0;
   exit;
end;
   TRY
  Assign (L,path);
  Reset (L);
  size:=FileSize(L);
   Close (L);
  result:=size;
  EXCEPT

  end;
end;
 //#############################################################################
function Tsystem.RRDTOOL_BIN_PATH():string;
begin

  if FileExists('/usr/bin/rrdtool') then exit('/usr/bin/rrdtool');
  if FileExists('/usr/local/bin/rrdtool') then exit ('/usr/local/bin/rrdtool');
  if FileExists('/opt/artica/bin/rrdtool') then exit('/opt/artica/bin/rrdtool');
end;
//#############################################################################
function Tsystem.GET_INFO(key:string):string;
var
   str:string;
begin

if key='cpulimit' then if length(mem_cpulimit_value)>0 then exit(mem_cpulimit_value);

str:='';
   if FileExists('/etc/artica-postfix/settings/Daemons/'+key) then begin
      str:=trim(ReadFileIntoString('/etc/artica-postfix/settings/Daemons/'+key));
      if key='cpulimit' then  mem_cpulimit_value:=result;
      result:=str;
   end;

end;
//#############################################################################
function Tsystem.GET_CLUSTER(key:string):string;
var
   str:string;
begin

str:='';
   if FileExists('/etc/artica-cluster/'+key) then begin
      str:=trim(ReadFileIntoString('/etc/artica-cluster/'+key));
      result:=str;
   end;

end;
//#############################################################################
procedure Tsystem.set_INFO(key:string;val:string);
begin
try
   set_INFOS(key,val);
except
 writeln('Tsystem.set_INFO() Unable to set "'+key+'" "'+val+'"');
end;
end;
//#############################################################################
procedure Tsystem.set_INFOS(key:string;val:string);
var
   F:TEXT;
   ini:TIniFile;
begin
  ForceDirectories('/etc/artica-postfix/settings/Daemons');
  AssignFile(F,'/etc/artica-postfix/settings/Daemons/'+key);
  Rewrite(F);
  Writeln (F,val);
  CloseFile(F);




end;
//#############################################################################
procedure Tsystem.set_CLUSTER(key:string;val:string);
var
   F:TEXT;
   ini:TIniFile;
begin
  ForceDirectories('/etc/artica-cluster');
  AssignFile(F,'/etc/artica-cluster/'+key);
  Rewrite(F);
  Writeln (F,val);
  CloseFile(F);
end;
//#############################################################################
procedure Tsystem.set_MYSQL(key:string;val:string);
var F:TEXT;
ini:TIniFile;
begin
ForceDirectories('/etc/artica-postfix/settings/Mysql');
  AssignFile(F,'/etc/artica-postfix/settings/Mysql/'+key);
  Rewrite(F);
  Writeln (F,val);
  CloseFile(F);
try
ini:=TIniFile.Create('/etc/artica-postfix/artica-mysql.conf');
finally
ini.WriteString('MYSQL',key,val);
end;

end;
//#############################################################################
function Tsystem.GET_MYSQL(key:string):string;
var
   str:string;
   str2:string;
   ini:TIniFile;
begin

str:='';
   if FileExists('/etc/artica-postfix/settings/Mysql/'+key) then begin
      str:=trim(ReadFileIntoString('/etc/artica-postfix/settings/Mysql/'+key));
      result:=trim(str);
      if(key='mysql_server') then begin
          if length(result)=0 then result:='127.0.0.1';
      end;
      if(key='port') then begin
          if length(result)=0 then result:='3306';
      end;

      if key='database_password' then begin
        if FileExists('/etc/artica-postfix/settings/Mysql/database_password2') then begin
           str2:=trim(ReadFileIntoString('/etc/artica-postfix/settings/Mysql/database_password2'));
           if str2<>result then begin
              result:=str2;
              set_MYSQL('database_password',str2);
           end;
         end;
        end;
      exit;
   end;

if not FileExists('/etc/artica-postfix/artica-mysql.conf') then exit();
try
ini:=TIniFile.Create('/etc/artica-postfix/artica-mysql.conf');
result:=ini.ReadString('MYSQL',key,'');
finally
ini.Free;

      if(key='mysql_server') then begin
          if length(result)=0 then result:='127.0.0.1';
      end;
      if(key='port') then begin
          if length(result)=0 then result:='3306';
      end;

end;


end;
//#############################################################################
function Tsystem.GET_ENGINE(key:string):string;
var
  Ini:TMemIniFile;
begin
Ini:=TMemIniFile.Create('/etc/artica-postfix/artica-engine.conf');
result:=trim(Ini.ReadString('CONFIG',key,''));
Ini.Free;
end;
//#############################################################################
procedure Tsystem.SET_ENGINE(valuename:string;valuedata:string);
var
  Ini:TiniFile;
begin
Ini:=TiniFile.Create('/etc/artica-postfix/artica-engine.conf');
ini.WriteString('CONFIG',valuename,valuedata);
Ini.Free;
end;
//#############################################################################
procedure Tsystem.TEST_MECHANISM();
var
   mechanism:string;
begin
    mechanism:=GET_ENGINE('MECHANISM');
    if length(mechanism)=0 then begin
       if FileExists(LOCATE_SLAPD()) then begin
          mechanism:='ldap';
          SET_ENGINE('MECHANISM','ldap');
       end;
    end;
end;
//#############################################################################
function Tsystem.GET_PERFS(key:string):string;
var
  Ini:TMemIniFile;
begin

if not FileExists('/etc/artica-postfix/performances.conf') then begin
  fpsystem('/bin/touch /etc/artica-postfix/performances.conf');
end;
try
   Ini:=TMemIniFile.Create('/etc/artica-postfix/performances.conf');

except
  exit;
end;
   result:=trim(Ini.ReadString('PERFORMANCES',key,''));
   Ini.Free;
end;
//#############################################################################
procedure Tsystem.SET_PERFS(key:string;value:string);
var
  Ini:TinIFile;
begin

if not FileExists('/etc/artica-postfix/performances.conf') then begin
  fpsystem('/bin/touch /etc/artica-postfix/performances.conf');
end;


try
   Ini:=TinIFile.Create('/etc/artica-postfix/performances.conf');
   ini.WriteString('PERFORMANCES',key,value);
   ini.UpdateFile;

finally
Ini.Free;
end;

end;
//#############################################################################
function Tsystem.MYSQL_INFOS(key:string):string;
begin

if key='server' then key:='mysql_server';
if key='root' then key:='database_admin';
if key='password' then key:='database_password';


 if key='mysql_server' then begin
    if length(mem_mysql_server)>0 then exit(mem_mysql_server);
end;

 if key='port' then begin
    if length(mem_mysql_port)>0 then exit(mem_mysql_port);
end;

 if key='database_admin' then begin
    if length(mem_mysql_user)>0 then exit(mem_mysql_user);
end;

 if key='database_password' then begin
    if length(mem_mysql_password)>0 then exit(mem_mysql_password);
end;
try
   result:=trim(GET_MYSQL(key));
except
  result:=ReadFileIntoString('/etc/artica-postfix/settings/Mysql/'+key)
end;

if key='mysql_server' then begin
   if result='' then result:='127.0.0.1';
   mem_mysql_server:=result;
end;

if key='port' then begin
   if result='' then result:='3306';
   mem_mysql_port:=result;
end;

if key='database_admin' then begin
   if result='' then result:='root';
   mem_mysql_user:=result;
end;

if key='database_password' then begin
    mem_mysql_password:=result;
end;

end;
//#############################################################################
function Tsystem.LOCATE_MYSQL_ADMIN():string;
var ss:string;
begin
ss:=LOCATE_GENERIC_BIN('mysqladmin');
if FileExists(ss) then exit(ss);
if FileExists('/usr/bin/mysqladmin') then exit('/usr/bin/mysqladmin');
end;
//#############################################################################

function Tsystem.MYSQL_STATUS():boolean;
var
   server:string;
   port:string;
   password:string;
   root:string;
   cmd:string;
   logs:Tlogs;
   tmpstr:string;
   l:Tstringlist;
   RegExpr:TRegExpr;
   i:Integer;
begin
  result:=true;

  if not FileExists('/usr/bin/mysqladmin') then exit;
  server:=MYSQL_INFOS('server');
  port:=MYSQL_INFOS('port');
  password:=MYSQL_INFOS('database_password');
  root:=MYSQL_INFOS('database_admin');
  logs:=Tlogs.Create;
  tmpstr:=logs.FILE_TEMP();

  logs.Debuglogs('invoke status /usr/bin/mysqladmin: ' + server + ':'+port + ' ' + root+':'+password);

  if length(password)=0 then begin
       cmd:='/usr/bin/mysqladmin --host='+server+' --port='+port+' --user='+root+' status >'+tmpstr+ ' 2>&1';
  end else begin
      cmd:='/usr/bin/mysqladmin --host='+server+' --port='+port+' --user='+root+'  --password=' + password+' status >'+tmpstr+ ' 2>&1';
  end;
       logs.Debuglogs(cmd);
  fpsystem(cmd);
  l:=TstringList.Create;
  l.LoadFromFile(tmpstr);

  RegExpr:=TRegExpr.Create();

  for i:=0 to l.Count-1 do begin
     RegExpr.Expression:='^error.+?Too\s+many\s+connections';
     logs.Debuglogs(l.Strings[i]);
     if RegExpr.Exec(l.Strings[i]) then begin
        result:=false;
        break;
     end;
  end;
  logs.DeleteFile(tmpstr);

end;

//#############################################################################
function Tsystem.PROCESS_EXISTS_BY_NAME(processname:string):boolean;
var
   RegExpr:TRegExpr;
   s:TstringList;
   i:integer;
begin
     result:=false;

     if not fileexists('/bin/ps') then begin
        writeln('Unable to locate /bin/ps');
        exit;
     end;

     if length(processname)=0 then exit(false);
     forceDirectories('/opt/artica/tmp');
     fpsystem('/bin/ps -x >/opt/artica/tmp/ps2.tmp 2>&1');
     if not FileExists('/opt/artica/tmp/ps2.tmp') then exit;

     RegExpr:=TRegExpr.create;
     RegExpr.expression:=processname;
     S:=TstringList.Create;


     for i:=0 to S.Count -1 do begin
         if RegExpr.Exec(S.Strings[i]) then begin
              result:=true;
              break;
         end;

     end;

RegExpr.Free;
S.free;

end;
//##############################################################################
function Tsystem.IPTABLES_ACCOUNTING_EXISTS():boolean;
var
   RegExpr:TRegExpr;
   iptables_bin,tmpstr:string;
   s:TstringList;
   i:integer;
begin
     result:=false;
     iptables_bin:=LOCATE_GENERIC_BIN('iptables');
     if not fileexists(iptables_bin) then exit(false);
     tmpstr:=FILE_TEMP();
     fpsystem(iptables_bin+' -m account --h >'+tmpstr +' 2>&1');

     if not FileExists(tmpstr) then exit(false);

     RegExpr:=TRegExpr.create;
     RegExpr.expression:='--aaddr';
     S:=TstringList.Create;
     s.LoadFromFile(tmpstr);
     fpsystem('/bin/rm -f '+tmpstr);


     for i:=0 to S.Count -1 do begin
         if RegExpr.Exec(S.Strings[i]) then begin
              result:=true;
              break;
         end else begin
             if verbosed then writeln('Line '+S.Strings[i] +' no match');
         end;
     end;

RegExpr.Free;
S.free;

end;
//##############################################################################


function Tsystem.LOCATE_OPENSSL_TOOL_PATH():string;
begin
result:=OPENSSL_TOOL_PATH();
end;

//#############################################################################
function Tsystem.LOCATE_APACHE_INITD_PATH:string;
begin
   if FileExists('/opt/artica/bin/apachectl') then exit('/opt/artica/bin/apachectl');
end;
 //#############################################################################
function Tsystem.LOCATE_SENDMAIL_CF():string;
begin
if fileexists('/etc/sendmail.cf') then exit('/etc/sendmail.cf');
if fileexists('/etc/sendmail/sendmail.cf') then exit('/etc/sendmail/sendmail.cf');
if fileexists('/etc/mail/sendmail.cf') then exit('/etc/mail/sendmail.cf');
end;
function Tsystem.LOCATE_IP_TOOL():string;
begin
if fileexists('/bin/ip') then exit('/bin/ip');
if fileexists('/sbin/ip') then exit('/sbin/ip');
end;
 //#############################################################################
procedure Tsystem.ifconfig(path:string);
var
   RegExpr:TRegExpr;
   s:TstringList;
   t:TstringList;
   i:integer;
begin
    verbosed:=COMMANDLINE_PARAMETERS('--verbose');

    if not FileExists(LOCATE_IP_TOOL()) then begin
       if verbosed then writeln('ifconfig(): no ip tool found');
       exit;
    end;
    forceDirectories('/opt/artica');
    if verbosed then writeln(LOCATE_IP_TOOL()+' addr show >/opt/artica/tmp/ip.txt 2>&1');
    fpsystem(LOCATE_IP_TOOL()+' addr show >/opt/artica/tmp/ip.txt 2>&1');
    if not FileExists('/opt/artica/tmp/ip.txt') then begin
        if verbosed then writeln('ifconfig(): /opt/artica/tmp/ip.txt no such file');
       exit;
    end;
    s:=TstringList.Create;
    t:=TstringList.Create;
    s.LoadFromFile('/opt/artica/tmp/ip.txt');
    RegExpr:=TRegExpr.Create;
    for i:=0 to s.Count-1 do begin
      RegExpr.Expression:='^[0-9]:\s+([a-z0-9]+):';
      if RegExpr.exec(s.Strings[i]) then begin
         if verbosed then writeln('ifconfig():: Found nic ',RegExpr.Match[1]);
         t.Add('['+RegExpr.Match[1]+']');
      end;
      RegExpr.Expression:='inet\s+([0-9\.]+)';
      if RegExpr.exec(s.Strings[i]) then begin
            if verbosed then writeln('ifconfig():: Found ip ',RegExpr.Match[1]);
         t.Add('ip='+RegExpr.Match[1]);
      end;
    end;
    if verbosed then writeln('ifconfig():: Saving to '+path);
    t.SaveToFile(path);
    t.free;
    s.free;
    RegExpr.free;
    if verbosed then writeln('ifconfig():: End...');
end;
 //#############################################################################
function Tsystem.ifconfig_text():string;
var

   s:TstringList;
   t:TstringList;
   ini:TiniFile;
   i:integer;
begin
    verbosed:=COMMANDLINE_PARAMETERS('--verbose');
    if not FileExists('/etc/artica-postfix/ifconfig.conf') then ifconfig('/etc/artica-postfix/ifconfig.conf');
    if FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/ifconfig.conf')>1 then begin
        if verbosed then writeln('ifconfig_text():: FILE_TIME_BETWEEN_MIN: ',FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/ifconfig.conf'),'Mn -> ifconfig()');
       ifconfig('/etc/artica-postfix/ifconfig.conf');
    end;

    if not FileExists('/etc/artica-postfix/ifconfig.conf') then begin
        if verbosed then writeln('/etc/artica-postfix/ifconfig.conf no such file');
        exit;
    end;


    s:=TstringList.Create;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/etc/artica-postfix/ifconfig.conf');
    ini.ReadSections(t);
    if verbosed then writeln('ifconfig_text():: ReadSections: ',t.Count-1);


    for i:=0 to t.Count-1 do begin
        s.Add(t.Strings[i] + ': ' + ini.ReadString(t.Strings[i],'ip','0.0.0.0'));
    end;

    result:=s.Text;
    s.free;
    t.free;
    ini.free;
end;
 //#############################################################################
 function Tsystem.ifconfig_html():string;
var

   s:TstringList;
   t:TstringList;
   ini:TiniFile;
   i:integer;
begin
    if not FileExists('/etc/artica-postfix/ifconfig.conf') then ifconfig('/etc/artica-postfix/ifconfig.conf');
    if FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/ifconfig.conf')>1 then ifconfig('/etc/artica-postfix/ifconfig.conf');


    if not FileExists('/etc/artica-postfix/ifconfig.conf') then exit;
    s:=TstringList.Create;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/etc/artica-postfix/ifconfig.conf');
    ini.ReadSections(t);
    s.Add('<hr><H3>Server addresses</H3><table>');
    for i:=0 to t.Count-1 do begin
        s.Add('<tr><td><strong style="font-size:11px">'+t.Strings[i] + '</td><td><strong style="font-size:11px"> ' + ini.ReadString(t.Strings[i],'ip','0.0.0.0')+'</td></tr>');
    end;
    s.Add('</table>');
    result:=s.Text;
    s.free;
    t.free;
    ini.free;
end;
 //#############################################################################
 function Tsystem.LOCATE_CUPS_ACCEPT():string;
begin
    if FileExists('/usr/sbin/cupsaccept') then exit('/usr/sbin/cupsaccept');
    if FileExists('/usr/sbin/accept') then exit('/usr/sbin/accept');
end;
 //#############################################################################
 function Tsystem.LOCATE_ctl_cyrusdb():string;
begin
 if FileExists('/usr/sbin/ctl_cyrusdb') then exit('/usr/sbin/ctl_cyrusdb');
 if FileExists('/usr/lib/cyrus/bin/ctl_cyrusdb') then exit('/usr/lib/cyrus/bin/ctl_cyrusdb');
 if FileExists('/usr/lib/cyrus-imapd/ctl_cyrusdb') then exit('/usr/lib/cyrus-imapd/ctl_cyrusdb');
end;

 //#############################################################################
  function Tsystem.LOCATE_ctl_mboxlist():string;
begin

 if FileExists('/usr/sbin/ctl_mboxlist') then exit('/usr/sbin/ctl_mboxlist');
 if FileExists('/usr/lib/cyrus/bin/ctl_mboxlist') then exit('/usr/lib/cyrus/bin/ctl_mboxlist');
 if FileExists('/usr/lib/cyrus-imapd/ctl_mboxlist') then exit('/usr/lib/cyrus-imapd/ctl_mboxlist');
end;

 //#############################################################################
function Tsystem.https_uris(artica_port:string):string;
var

   s:TstringList;
   t:TstringList;
   ini:TiniFile;
   i:integer;
   ip:string;
begin
    if not FileExists('/etc/artica-postfix/ifconfig.conf') then ifconfig('/etc/artica-postfix/ifconfig.conf');
    if FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/ifconfig.conf')>1 then ifconfig('/etc/artica-postfix/ifconfig.conf');


    if not FileExists('/etc/artica-postfix/ifconfig.conf') then exit;
    s:=TstringList.Create;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/etc/artica-postfix/ifconfig.conf');
    ini.ReadSections(t);
    s.Add('<hr><H3>Artica web addresses</H3><table>');
    for i:=0 to t.Count-1 do begin
        ip:=ini.ReadString(t.Strings[i],'ip','0.0.0.0');
        if ip<>'0.0.0.0' then begin
           s.Add('<tr><td><a href="https://'+ip + ':' + artica_port+'" style="font-size:11px;font-weight:bold" target="_new">https://'+ip + ':' + artica_port+'</a></td></tR>');
        end;
    end;
    s.Add('</table>');
    result:=s.Text;
    s.free;
    t.free;
    ini.free;
end;
 //#############################################################################
function Tsystem.txt_ip_agents():string;
var

   s:TstringList;
   t:TstringList;
   ini:TiniFile;
   i:integer;
   ip:string;
begin
    ifconfig('/tmp/ifconfig.conf');
    if not FileExists('/tmp/ifconfig.conf') then exit;
    s:=TstringList.Create;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/tmp/ifconfig.conf');
    ini.ReadSections(t);
    s.Add('Network addresses:');
    for i:=0 to t.Count-1 do begin
        ip:=ini.ReadString(t.Strings[i],'ip','0.0.0.0');
        if ip<>'0.0.0.0' then begin
           if ip<>'127.0.0.1' then s.Add('IP address:'+ip);
        end;
    end;
    s.Add('');
    result:=s.Text;
    s.free;
    t.free;
    ini.free;
end;
function Tsystem.txt_ip_agents_line():string;
var
   t:TstringList;
   ini:TiniFile;
   i:integer;
   ip:string;
begin
    ifconfig('/tmp/ifconfig.conf');
    if not FileExists('/tmp/ifconfig.conf') then exit;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/tmp/ifconfig.conf');
    ini.ReadSections(t);
    for i:=0 to t.Count-1 do begin
        ip:=ini.ReadString(t.Strings[i],'ip','0.0.0.0');
        if ip<>'0.0.0.0' then begin
          if ip<>'127.0.0.1' then result:=result+ip+','
        end;
    end;
    t.free;
    ini.free;
end;
function Tsystem.txt_ip_agents_line_port(port:string):string;
var
   t:TstringList;
   ini:TiniFile;
   i:integer;
   ip:string;
begin
    ifconfig('/tmp/ifconfig.conf');
    if not FileExists('/tmp/ifconfig.conf') then exit;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/tmp/ifconfig.conf');
    ini.ReadSections(t);
    for i:=0 to t.Count-1 do begin
        ip:=ini.ReadString(t.Strings[i],'ip','0.0.0.0');
        if ip<>'0.0.0.0' then begin
          if ip<>'127.0.0.1' then result:=result+ip+':'+port+','
        end;
    end;
    t.free;
    ini.free;
end;
function Tsystem.txt_uris(artica_port:string):string;
var

   s:TstringList;
   t:TstringList;
   ini:TiniFile;
   i:integer;
   ip:string;
begin

     verbosed:=COMMANDLINE_PARAMETERS('--verbose');
     forceDirectories('/etc/artica-postfix');
     ifconfig('/etc/artica-postfix/ifconfig.conf');

    if verbosed then writeln('txt_uris():: -> File time=',FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/ifconfig.conf'),'mn');

    if FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/ifconfig.conf')>1 then begin
        if verbosed then writeln('txt_uris():: -> ifconfig()');
       ifconfig('/etc/artica-postfix/ifconfig.conf');
    end;

    if not FileExists('/etc/artica-postfix/ifconfig.conf') then begin
                if verbosed then writeln('txt_uris():: /etc/artica-postfix/ifconfig.conf  no such file');
                 exit;
end;


    s:=TstringList.Create;
    t:=TstringList.Create;
    ini:=TiniFile.Create('/etc/artica-postfix/ifconfig.conf');
    ini.ReadSections(t);
    for i:=0 to t.Count-1 do begin
        ip:=ini.ReadString(t.Strings[i],'ip','0.0.0.0');
        if ip<>'0.0.0.0' then begin
          if ip<>'127.0.0.1' then begin
             s.Add('https://'+ip + ':' + artica_port);
          end;
       end;
    end;
    if s.Count=0 then begin
       s.free;
       t.free;
       exit;
    end;
    result:=s.Text;
    s.free;
    t.free;
    ini.free;
end;
 //#############################################################################
 function Tsystem.LOCATE_GPG():string;
begin
    if FileExists('/usr/bin/gpg') then exit('/usr/bin/gpg');
end;
 //#############################################################################
 function Tsystem.LOCATE_BLKID():string;
begin
    if FileExists('/sbin/blkid') then exit('/sbin/blkid');
end;
 //#############################################################################
 function Tsystem.LOCATE_sensors_detect():string;
begin
    if FileExists('/usr/sbin/sensors-detect') then exit('/usr/sbin/sensors-detect');
end;
 //#############################################################################
 function Tsystem.LOCATE_NMAP():string;
begin
    if FileExists('/usr/bin/nmap') then exit('/usr/bin/nmap');
end;
 //#############################################################################
function Tsystem.LOCATE_APT_GET():string;
begin
if FileExists('/usr/bin/apt-get') then exit('/usr/bin/apt-get');
end;
 //#############################################################################
function Tsystem.materiel_get_temperature():string;
var
RegExpr:TRegExpr;
path:string;
begin
   if FileExists('/proc/acpi/thermal_zone/THRM/temperature') then path:='/proc/acpi/thermal_zone/THRM/temperature';
   if FileExists('/proc/acpi/thermal_zone/THM/temperature') then path:='/proc/acpi/thermal_zone/THM/temperature';
   if length(path)=0 then exit('0');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='\s+([0-9\.]+)\s+';
   if RegExpr.Exec(ReadFileIntoString(path)) then result:=RegExpr.Match[1];
   RegExpr.free;
end;
 //#############################################################################
procedure Tsystem.SYSTEM_ADD_MODULE(module_name:string);
var
   RegExpr:TRegExpr;
   i:integer;
   l:TstringList;
   found:boolean;
begin
   found:=false;
   if not FileExists('/etc/modules') then exit;
   l:=TstringList.Create;
   l.LoadFromFile('/etc/modules');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^'+module_name;
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          found:=true;
          break;
       end;
   end;

   if not found then begin
      l.Add(module_name);
      l.SaveToFile('/etc/modules');
   end;


   l.free;
   RegExpr.free;



end;
 //#############################################################################
 function Tsystem.DEBIAN_VERSION():string;
var
   l:TstringList;
begin
   if not FileExists('/etc/debian_version') then exit;
   l:=TstringList.Create;
   l.LoadFromFile('/etc/debian_version');
   result:=trim(l.Strings[0]);
   l.free;
end;
 //#############################################################################

 function Tsystem.croned_minutes():boolean;
 var MD,s:string;
 i,filetim:integer;
 begin
   result:=false;
   s:='';

         for i:=0 to ParamCount do begin
             s:=s  + ' ' +ParamStr(i);
         end;
  MD:=MD5FromString(s);
  forceDirectories('/etc/artica-postfix/croned.1');
  if not FileExists('/etc/artica-postfix/croned.1/'+MD)  then begin
     fpsystem('/bin/touch "/etc/artica-postfix/croned.1/'+MD+'"');
     result:=True;
     exit;
  end;
  filetim:=FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/croned.1/'+MD);

  if filetim>0 then begin
    fpsystem('/bin/touch "/etc/artica-postfix/croned.1/'+MD+'"');
     result:=True;
     exit;
  end;
end;
 //#############################################################################
 function Tsystem.croned_minutes2(maxmin:integer):boolean;
 var MD,s:string;
 i,filetim:integer;
 begin
   result:=false;
   s:='';

         for i:=0 to ParamCount do begin
             s:=s  + ' ' +ParamStr(i);
         end;
  MD:=MD5FromString(s);
  forceDirectories('/etc/artica-postfix/croned.1');
  if not FileExists('/etc/artica-postfix/croned.1/'+MD)  then begin
     fpsystem('/bin/touch "/etc/artica-postfix/croned.1/'+MD+'"');
     result:=True;
     exit;
  end;
  filetim:=FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/croned.1/'+MD);

  if filetim>maxmin then begin
    fpsystem('/bin/touch "/etc/artica-postfix/croned.1/'+MD+'"');
     result:=True;
     exit;
  end;
end;
 //#############################################################################
  function Tsystem.croned_seconds(maxsec:integer):boolean;
 var MD,s:string;
 i,filetim:integer;
 begin
   result:=false;
   s:='';

         for i:=0 to ParamCount do begin
             s:=s  + ' ' +ParamStr(i);
         end;
  MD:=MD5FromString(s);
  forceDirectories('/etc/artica-postfix/croned.2');
  if not FileExists('/etc/artica-postfix/croned.2/'+MD)  then begin
     fpsystem('/bin/touch "/etc/artica-postfix/croned.2/'+MD+'"');
     result:=True;
     exit;
  end;
  filetim:=FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/croned.2/'+MD);

  if filetim>maxsec then begin
    fpsystem('/bin/touch "/etc/artica-postfix/croned.2/'+MD+'"');
     result:=True;
     exit;
  end;
end;
 //#############################################################################
   function Tsystem.isoverloaded():boolean;
 var
    cpunum:integer;
    currentload:string;
    loadint:Single;
    cpunum_max:single;
    rtlogs:Tlogs;
    load:integer;
    s:string;
    i:integer;
 begin
    result:=false;
    s:='';

         for i:=1 to ParamCount do begin
             s:=s  + ' ' +ParamStr(i);
         end;
    cpunum:=CPU_NUMBER();
    currentload:=LOAD_CURRENT();
    rtlogs:=Tlogs.Create;
    if not TryStrToFloat(currentload,loadint) then begin
       loadint:=0;
       rtlogs.Debuglogs('WARNING: Tsystem.isoverloaded() fatal error while int of '+ currentload );
       rtlogs.free;
       exit(false);
    end;
    cpunum_max:=(cpunum+1);

    //rtlogs.Debuglogs('"'+s+'" system load '+ FloatToStr(loadint)+'/'+FloatToStr(cpunum_max) );
    if(loadint>cpunum_max) then begin
       rtlogs.Debuglogs('WARNING: "'+s+'" system overloaded !!: '+ FloatToStr(loadint)+'/'+FloatToStr(cpunum_max) );
       result:=true;
       exit;
    end;
   // rtlogs.Debuglogs('"'+s+'" system GOOD');
    rtlogs.free;
end;
 //#############################################################################
 function Tsystem.isoverloadedTooMuch():boolean;
 var
    cpunum:integer;
    currentload:string;
    loadint:Single;
    cpunum_max:single;
    rtlogs:Tlogs;
    load:integer;
    systemMaxOverloaded:single;
    s:string;
    i:integer;
 begin
    result:=false;
    systemMaxOverloaded:=0;
    s:='';

         for i:=1 to ParamCount do begin
             s:=s  + ' ' +ParamStr(i);
         end;
    cpunum:=CPU_NUMBER();
    currentload:=LOAD_CURRENT();
    rtlogs:=Tlogs.Create;
    if not TryStrToFloat(currentload,loadint) then begin
       loadint:=0;
       rtlogs.Debuglogs('WARNING: Tsystem.isoverloadedTooMuch() fatal error while int of '+ currentload );
       rtlogs.free;
       exit(false);
    end;
    cpunum_max:=(cpunum+1);
    cpunum_max:=cpunum_max*2;



    //rtlogs.Debuglogs('"'+s+'" system load '+ FloatToStr(loadint)+'/'+FloatToStr(cpunum_max) );

    if not TryStrToFloat(GET_INFO('systemMaxOverloaded'),systemMaxOverloaded) then begin
          systemMaxOverloaded:=cpunum_max;
          set_INFO('systemMaxOverloaded',FloatToStr(systemMaxOverloaded));
    end;

    if systemMaxOverloaded=0 then systemMaxOverloaded:=cpunum_max;

    if(loadint>cpunum_max) then begin
       rtlogs.DebugLogs('Starting......: '+'"'+s+'" system is very overloaded !!: '+ FloatToStr(loadint)+'/'+FloatToStr(cpunum_max));
       rtlogs.Debuglogs('WARNING: "'+s+'" system is very overloaded !!: '+ FloatToStr(loadint)+'/'+FloatToStr(cpunum_max) );
       result:=true;
       exit;
    end;
   // rtlogs.Debuglogs('"'+s+'" system GOOD');
    rtlogs.free;
end;
 //#############################################################################
function Tsystem.LOCATE_CURL():string;
begin
   if FileExists('/usr/local/bin/curl') then exit('/usr/local/bin/curl');
   if FileExists('/usr/bin/curl') then exit('/usr/bin/curl');
   if FileExists('/opt/artica/bin/curl') then exit('/opt/artica/bin/curl');
end;


 //#############################################################################
function Tsystem.WGET_DOWNLOAD_FILE(uri:string;file_path:string;JustHead:boolean;wgetforce:boolean=false):boolean;
var
   RegExpr:TRegExpr;
   ProxyString:string;
   ProxyCommand:string;
   ProxyUser:string;
   ProxyPassword:string;
   ProxyName:string;
   commandline_artica:string;
   command_line_curl:string;
   command_line_wget:string;
   WgetBindIpAddress_cmd_line_wget:string;
   WgetBindIpAddress_cmd_line_curl:string;
   localhost:boolean;
   LOGS:Tlogs;
   ssl:boolean;
   ForceHTTPEngineToWget:integer;
   WgetBindIpAddress:string;

   D:boolean;
   ArticaProxySettings:TiniFile;
   UseProxyFromArtica:integer;
   ArticaProxyServerEnabled_string:string;
 begin
   D:=COMMANDLINE_PARAMETERS('debug');
   LOGS:=Tlogs.Create;
   localhost:=false;
   command_line_curl:='';
   RegExpr:=TRegExpr.Create;
   ProxyString:=GET_HTTP_PROXY();
   ProxyString:=AnsiReplaceStr(ProxyString,'"','');
   ProxyString:=AnsiReplaceStr(ProxyString,'http://','');
   ProxyString:=AnsiReplaceStr(ProxyString,'https://','');
   ForceHTTPEngineToWget:=0;
   UseProxyFromArtica:=1;


   if not TryStrToInt(GET_INFO('ForceHTTPEngineToWget'),ForceHTTPEngineToWget) then ForceHTTPEngineToWget:=0;
   if FileExists('/etc/artica-postfix/settings/Daemons/ArticaProxySettings') then begin
      ArticaProxySettings:=TiniFile.Create('/etc/artica-postfix/settings/Daemons/ArticaProxySettings');
      ArticaProxyServerEnabled_string:=ArticaProxySettings.ReadString('PROXY','ArticaProxyServerEnabled','no');
      if ArticaProxyServerEnabled_string='no' then UseProxyFromArtica:=0;
      ArticaProxySettings.Free;
   end;


   if UseProxyFromArtica=0 then ProxyString:='';



   WgetBindIpAddress:=GET_INFO('WgetBindIpAddress');
   if wgetforce then ForceHTTPEngineToWget:=1;

   if length(trim(WgetBindIpAddress))>0 then begin
      WgetBindIpAddress_cmd_line_wget:=' --bind-address='+WgetBindIpAddress;
      WgetBindIpAddress_cmd_line_curl:=' --interface '+WgetBindIpAddress;
   end;

   command_line_curl:=' ';
   ssl:=false;
   command_line_curl:= command_line_curl +WgetBindIpAddress_cmd_line_curl+' --progress-bar --output ' + file_path + ' "' + uri+'"';

   RegExpr.Expression:='^https:.+';
   if RegExpr.Exec(uri) then ssl:=True;


   RegExpr.Expression:='http://127\.0\.0\.1';
   if RegExpr.Exec(uri) then localhost:=True;

 if not localhost then begin
   if length(ProxyString)>0 then begin
       RegExpr.Expression:='(.+?):(.+?)@(.+)';
       if RegExpr.Exec(ProxyString) then begin
            ProxyUser:=RegExpr.Match[1];
            ProxyPassword:=RegExpr.Match[2];
            ProxyName:=RegExpr.Match[3];
            logs.Debuglogs('WGET_DOWNLOAD_FILE:: ProxyUser: "'+ProxyUser+'"');
            logs.Debuglogs('WGET_DOWNLOAD_FILE:: ProxyName:'+ProxyName+'"');
       end else begin
           RegExpr.Expression:='(.+?)@(.+)';
           if RegExpr.Exec(ProxyString) then begin
              ProxyUser:=RegExpr.Match[1];
              ProxyName:=RegExpr.Match[3];
           end;
       end;
   end;
   if length(ProxyName)=0 then ProxyName:=ProxyString;
 end;


         {ProxyUser:=AnsiReplaceStr(ProxyUser,'@','\@');
         ProxyUser:=AnsiReplaceStr(ProxyUser,':','\:');
         ProxyPassword:=AnsiReplaceStr(ProxyPassword,'@','\@');
         ProxyPassword:=AnsiReplaceStr(ProxyPassword,':','\:');
         }

   if length(ProxyName)>0 then begin
      ProxyCommand:=' --proxy ' +  ProxyName;
      if length(ProxyUser)>0 then begin
         if length(ProxyPassword)>0 then begin
            ProxyCommand:=' --proxy ' +  ProxyName + ' --proxy-user ' + ProxyUser + ':' + ProxyPassword;
         end else begin
            ProxyCommand:=' --proxy ' +  ProxyName + ' --proxy-user ' + ProxyUser;
         end;
      end;
     command_line_curl:=ProxyCommand + ' --progress-bar --output ' + file_path + ' "' + uri+'"';

   end;


   command_line_wget:='"'+uri+'"' +WgetBindIpAddress_cmd_line_wget+'  -q --output-document=' + file_path;
   if JustHead then ForceHTTPEngineToWget:=0;


  if ForceHTTPEngineToWget=0 then begin
    if FileExists(LOCATE_CURL()) then begin
         if ssl then command_line_curl:=command_line_curl+ ' --insecure';
         if JustHead then command_line_curl:=command_line_curl+ ' --head';
         command_line_curl:=LOCATE_CURL() + command_line_curl;
         if D then writeln(command_line_curl);
         logs.Debuglogs(command_line_curl);
         fpsystem(command_line_curl);
         exit;
     end;
   end else begin
       logs.Debuglogs('WGET_DOWNLOAD_FILE:: ForceHTTPEngineToWget is enabled, skipping curl if exists');

   end;


   if JustHead then exit;


  if FileExists('/usr/bin/wget') then begin
     if length(ProxyName)>0 then begin
         logs.Debuglogs('WGET_DOWNLOAD_FILE:: Proxy "'+ProxyName+'" is enabled -> SET_HTTP_PROXY');
         SET_HTTP_PROXY(GET_HTTP_PROXY());
     end;
     command_line_wget:='/usr/bin/wget ' + command_line_wget;
     if ssl then command_line_wget:=command_line_wget + ' --no-check-certificate';
     logs.Debuglogs(command_line_wget);
     fpsystem(command_line_wget);
     exit;
  end else begin
       logs.Debuglogs('WGET_DOWNLOAD_FILE:: unable to stat /usr/bin/wget');
  end;



     if length(ProxyName)>0 then ProxyCommand:=' --proxy=on --proxy-name=' + ProxyName;
     if length(ProxyUser)>0 then ProxyCommand:=' --proxy=on --proxy-name=' + ProxyName  + ' --proxy-user=' + ProxyUser;
     if length(ProxyPassword)>0 then ProxyCommand:=' --proxy=on --proxy-name=' + ProxyName  + ' --proxy-user=' + ProxyUser + ' --proxy-passwd=' + ProxyPassword;
     commandline_artica:=ExtractFilePath(ParamStr(0)) + 'artica-get  '+ uri + ' ' + ProxyCommand + ' -q --output-document=' + file_path;
     if D then writeln(commandline_artica);
     logs.Debuglogs(commandline_artica);
     fpsystem(commandline_artica);
     result:=true;





end;
//##############################################################################
procedure  Tsystem.SET_HTTP_PROXY(proxy_string:string);
var
   l:TStringList;
   i:integer;
   RegExpr:TRegExpr;
   found_proxy:boolean;

 begin
  if not FileExists('/etc/environment') then begin
     writeln('Unable to find /etc/environment');
     exit;
  end;
 REMOVE_HTTP_PROXY();

  l:=TStringList.Create;
  l.LoadFromFile('/etc/environment');
  l.Add('http_proxy="'+ proxy_string + '"');
  l.SaveToFile('/etc/environment');
  writeln('export http_proxy="'+ proxy_string + '" --> done');
  fpsystem('export http_proxy="'+ proxy_string + '"');
  writeln('env http_proxy='+ proxy_string + '" --> done');
  fpsystem('env http_proxy='+ proxy_string);




  if FileExists('/etc/wgetrc') then begin
      RegExpr:=TRegExpr.Create;
      RegExpr.Expression:='^http_proxy(.+)';
      l.LoadFromFile('/etc/wgetrc');
      For i:=0 to l.Count-1 do begin
          if RegExpr.Exec(l.Strings[i]) then begin
             found_proxy:=true;
             l.Strings[i]:='http_proxy = ' + proxy_string;
             l.SaveToFile('/etc/wgetrc');
             break;
          end;
      end;

     if found_proxy=false then begin
          l.Add('http_proxy = ' + proxy_string);
          l.SaveToFile('/etc/wgetrc');
     end;

  end;

   l.free;

end;
//##############################################################################
function Tsystem.MD5Sum(path:string):string;
var
   text:string;
   RegExpr:TRegExpr;
begin
     text:=ExecPipe('/usr/bin/md5sum ' + path);
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='(.+?)\s+';
     if RegExpr.Exec(text) then result:=RegExpr.Match[1];
     RegExpr.Free;
end;
//##############################################################################

function  Tsystem.GET_HTTP_PROXY:string;
var
   l:TStringList;
   i:integer;
   RegExpr:TRegExpr;
   proxyString:string;

 begin
  if not FileExists('/etc/environment') then begin
     l:=TStringList.Create;
     l.Add('LANG="en_US.UTF-8"');
     l.SaveToFile('/etc/environment');
     exit;
  end;


  l:=TStringList.Create;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='(http_proxy|HTTP_PROXY)=(.+)';

  l.LoadFromFile('/etc/environment');
  for i:=0 to l.Count -1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
         proxyString:=RegExpr.Match[2];
         proxyString:=AnsiReplaceText(proxyString,'"','');
         result:=proxystring;
      end;
  end;
 l.FRee;
 RegExpr.free;

end;
//##############################################################################
function  Tsystem.REMOVE_HTTP_PROXY:string;
var
   l:TStringList;
   i:integer;
   RegExpr:TRegExpr;

 begin
  if not FileExists('/etc/environment') then begin
     writeln('Unable to find /etc/environment');
     exit;
  end;


  l:=TStringList.Create;
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='(http_proxy|HTTP_PROXY)=(.+)';

  l.LoadFromFile('/etc/environment');
  for i:=0 to l.Count -1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
          l.Delete(i);
          break;
      end;
  end;
  l.SaveToFile('/etc/environment');


  if FileExists('/etc/wgetrc') then begin
      RegExpr:=TRegExpr.Create;
      RegExpr.Expression:='^http_proxy(.+)';
      l.LoadFromFile('/etc/wgetrc');
      For i:=0 to l.Count-1 do begin
          if RegExpr.Exec(l.Strings[i]) then begin
             l.Strings[i]:='#' + l.Strings[i];
             l.SaveToFile('/etc/wgetrc');
             break;
          end;
      end;
  end;


  l.free;
  RegExpr.free;
  result:='';
end;
//##############################################################################
function Tsystem.FILE_FormatSize(FS: integer): string;
var
  sTemp: string;
begin
  if FS < 1000 then Result := IntToStr(FS)+ ' bytes'
  else
    if (FS < 1048576) then begin
      // Format KB
      sTemp := FloatToStr(FS div 1024);
      sTemp := Copy(sTemp, 1, Pos('.', sTemp)+2);
      if Length(sTemp) > 3 then begin
        if Length(Copy(sTemp, 1, Pos('.', sTemp)-1)) >= 3 then begin
          Result := Copy(sTemp, 1, 3)+ ' KB';
        end else begin
          if Length(Copy(sTemp, 1, Pos('.', sTemp)-1)) = 2 then
            Result := Copy(sTemp, 1, Pos('.', sTemp)+1)+' KB'
          else Result := sTemp+' KB';
        end;
      end else Result := sTemp+' KB';
    end
  else if (FS < 1073741824) then begin
    // Format MB
    sTemp := FloatToStr(FS div 1048576);
    sTemp := Copy(sTemp, 1, Pos('.', sTemp)+2);
    if Length(sTemp) > 3 then begin
      if Length(Copy(sTemp, 1, Pos('.', sTemp)-1)) >= 3 then begin
        Result := Copy(sTemp, 1, 3)+' MB';
      end else begin
        if Length(Copy(sTemp, 1, Pos('.', sTemp)-1)) = 2 then
          Result := Copy(sTemp, 1, Pos('.', sTemp)+1)+' MB'
        else Result := sTemp+' MB';
      end;
    end else Result := sTemp+' MB';
  end else begin
    // Format GB
    sTemp := FloatToStr(FS div 1073741824);
    sTemp := Copy(sTemp, 1, Pos('.', sTemp)+2);
    if Length(sTemp) > 3 then begin
      if Length(Copy(sTemp, 1, Pos('.', sTemp)-1)) >= 3 then begin
        Result := Copy(sTemp, 1, 3)+' GB';
      end else begin
        if Length(Copy(sTemp, 1, Pos('.', sTemp)-1)) = 2 then
          Result := Copy(sTemp, 1, Pos('.', sTemp)+1)+' GB'
        else Result := sTemp+' GB';
      end;
    end else Result := sTemp+' GB';
  end;
end;
//##############################################################################
function Tsystem.LOCATE_mysqld_safe():string;
begin
if FileExists('/usr/bin/mysqld_safe') then exit('/usr/bin/mysqld_safe');
if FileExists('/usr/bin/mysqld_safe') then exit('/usr/bin/mysqld_safe');
end;
//##############################################################################
function Tsystem.LOCATE_mysql_bin():string;
begin
   if FileExists('/opt/artica/mysql/bin/mysql') then exit('/opt/artica/mysql/bin/mysql');
   if FileExists('/opt/artica/bin/mysql') then exit('/opt/artica/bin/mysql');
   if FileExists('/usr/bin/mysql') then exit('/usr/bin/mysql');
end;
//#############################################################################
function Tsystem.LOCATE_mysqld_bin():string;
begin
if fileExists('/usr/sbin/mysqld') then exit ('/usr/sbin/mysqld');
if FileExists('/opt/artica/mysql/libexec/mysqld') then exit('/opt/artica/mysql/libexec/mysqld');
if FileExists('/usr/libexec/mysqld') then exit('/usr/libexec/mysqld');
end;
//##############################################################################
function Tsystem.CRON_CREATE_SCHEDULE(ProgrammedTime:string;Croncommand:string;name:string):boolean;
 var
    FileDatas:TstringList;
    mailadmin:string;

begin
  mailadmin:=ADMIN_MAIL();
  result:=true;
  FileDatas:=TstringList.Create;
  FileDatas.Add('PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin:/usr/share/artica-postfix/bin');
  FileDatas.Add('MAILTO="'+mailadmin+'"');
  FileDatas.Add(ProgrammedTime + ' ' + ' root ' + Croncommand + ' >/dev/null 2>&1');
  FileDatas.SaveToFile('/etc/cron.d/'+name);
  fpsystem('/bin/chmod 0640 /etc/cron.d/'+name);
  fpsystem('/bin/chown root:root /etc/cron.d/'+name);
  FileDatas.free;
end;
//#############################################################################
function Tsystem.ADMIN_MAIL():string;
 var Mailini:TiniFIle;
begin
if length(MEM_ADMIN_MAIL)>0 then exit(MEM_ADMIN_MAIL);
if not FileExists('/etc/artica-postfix/smtpnotif.conf') then exit();
Mailini:=TiniFIle.Create('/etc/artica-postfix/smtpnotif.conf');
result:=Mailini.ReadString('SMTP','smtp_dest','');
MEM_ADMIN_MAIL:=result;
Mailini.free;
end;
//#############################################################################
function Tsystem.MAILLOG_PATH():string;
var
   l:string;
begin

 l:=GET_INFO('SysMailLogPath');
 if FIleExists(l) then exit(l);


if FileExists(LOCATE_SYSLOG_NG_CONF()) then begin
   l:=MAILLOG_FROM_SYSLOGNG();
   if FIleExists(l) then exit(l);
end;

 l:=MAILLOG_REGEX_PATH();
 if FIleExists(l) then exit(l);
 if FileExists('/etc/rsyslog.conf') then l:=MAILLOG_REGEX_PATH('/etc/rsyslog.conf');
 if FIleExists(l) then exit(l);
end;


function Tsystem.MAILLOG_REGEX_PATH(logconfig:string):string;
var filedatas,ExpressionGrep:string;
RegExpr:TRegExpr;
logs:Tlogs;
D:Boolean;
begin
logs:=tlogs.Create;


 D:=COMMANDLINE_PARAMETERS('--verbose');
if length(logconfig)=0 then logconfig:=LOCATE_SYSLOG_CONF();


if D then writeln('logconfig: '+logconfig);
filedatas:=ReadFileIntoString(logconfig);
   ExpressionGrep:='mail\.=info.+?-([\/a-zA-Z_0-9\.]+)?';
   RegExpr:=TRegExpr.create;
   RegExpr.ModifierI:=True;
   RegExpr.expression:=ExpressionGrep;
   if RegExpr.Exec(filedatas) then  begin
     if D then writeln('ExpressionGrep:='+ExpressionGrep +'(' +RegExpr.Match[1]+')' );
     result:=RegExpr.Match[1];
     RegExpr.Free;
     exit;
   end;


   ExpressionGrep:='mail\.\*.+?-([\/a-zA-Z_0-9\.]+)?';
   RegExpr.expression:=ExpressionGrep;
   if RegExpr.Exec(filedatas) then   begin
     result:=RegExpr.Match[1];
     if D then writeln('ExpressionGrep:='+ExpressionGrep +'(' +RegExpr.Match[1]+')' );
     RegExpr.Free;
     exit;
   end;

   ExpressionGrep:='destination mailinfo[\s\{a-z]+\("(.+?)"';
   RegExpr.expression:=ExpressionGrep;
   if RegExpr.Exec(filedatas) then   begin
        if D then writeln('ExpressionGrep:='+ExpressionGrep +'(' +RegExpr.Match[1]+')' );
     result:=RegExpr.Match[1];
     RegExpr.Free;
     exit;
   end;

  RegExpr.Free;
end;
//##############################################################################
function Tsystem.MAILLOG_FROM_SYSLOGNG():string;
var
RegExpr:TRegExpr;
l:TstringList;
i:integer;
path:string;
begin

path:=LOCATE_SYSLOG_NG_CONF();
   if not FileExists(path) then begin
      exit;
   end;


   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^destination.+?mail\s+.+?\((.+?)\)';
   l:=TstringList.Create;
   l.LoadFromFile(path);
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=RegExpr.Match[1];
          result:=AnsireplaceText(result,'"','');
          result:=AnsireplaceText(result,'''','');
          break;
       end;
   end;

   RegExpr.free;
   l.free;
end;
//##############################################################################
function Tsystem.LOCATE_AUTH_LOG():string;
var
RegExpr:TRegExpr;
l:TstringList;
i:integer;
path:string;
begin
path:=LOCATE_SYSLOG_CONF();
   if not FileExists(path) then begin
      writeln('fail');
      exit;
   end;
RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='auth.+?\s+(.+)';
   l:=Tstringlist.Create;
   l.LoadFromFile(path);
 for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=RegExpr.Match[1];
          result:=AnsireplaceText(result,'"','');
          result:=AnsireplaceText(result,'''','');
          break;
       end;
   end;

   RegExpr.free;
   l.free;

end;
//##############################################################################



function Tsystem.LOCATE_SYSLOG_CONF():string;
begin
if FileExists('/etc/syslog.conf') then exit('/etc/syslog.conf');
if FileExists('/etc/syslog-ng/syslog-ng.conf') then exit('/etc/syslog-ng/syslog-ng.conf');
if FIleExists('/etc/rsyslog.d/50-default.conf') then exit('/etc/rsyslog.d/50-default.conf');
if FileExists('/etc/rsyslog.conf') then exit('/etc/rsyslog.conf');
end;
//##############################################################################
procedure Tsystem.COMPILE_PROXY();
var i:integer;
l:TstringList;
RegExpr:TRegExpr;
Conf:TiniFile;
add:boolean;
prox:string;
added:boolean;
begin
   if not FileExists('/etc/artica-postfix/settings/Daemons/ArticaProxySettings') then exit;
   conf:=TiniFile.Create('/etc/artica-postfix/settings/Daemons/ArticaProxySettings');
   add:=false;
   added:=false;

   if conf.ReadString('PROXY','ArticaProxyServerEnabled','no')='yes' then add:=true;
   prox:=conf.ReadString('PROXY','ArticaCompiledProxyUri','');
   conf.free;
   if length(trim(prox))=0 then exit;

   l:=Tstringlist.Create;
   l.LoadFromFile('/etc/environment');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^HTTP_PROXY';
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          if not add then begin
             l.Delete(i);
             break;
          end;

          l.Strings[i]:='HTTP_PROXY='+prox;
          added:=true;
          break;
        end;
   end;

   if add then begin
      if not added then begin
         l.Add('HTTP_PROXY='+prox);
      end;
   end;

   try
   l.SaveToFile('/etc/environment');
   except
         exit;
   end;
   l.free;
   RegExpr.free;

end;
//##############################################################################

function Tsystem.LOCATE_SYSLOG_PATH():string;
var i:integer;
l:TstringList;
RegExpr:TRegExpr;
D:boolean;
begin
D:=false;
if ParamStr(1)='--whereis-syslog' then D:=True;



   if not FileExists(LOCATE_SYSLOG_CONF()) then begin
      result:=LOCATE_SYSLOG_NG_PATH();
      exit;
   end;

   if D then writeln('LOCATE_SYSLOG_PATH:',LOCATE_SYSLOG_CONF());

   l:=TstringList.Create;
   l.LoadFromFile(LOCATE_SYSLOG_CONF());
   RegExpr:=TRegExpr.create;

   for i:=0 to l.Count-1 do begin
       if length(trim(l.Strings[i]))=0 then continue;
       RegExpr.expression:='^\*\.\*.+?-([\/a-zA-Z_0-9\.\-]+)?';
        if RegExpr.Exec(l.Strings[i]) then begin
           result:=trim(RegExpr.Match[1]);
           if D then writeln('LOCATE_SYSLOG_PATH: (1)',result);
           break;

        end;

        RegExpr.expression:='destination df_syslog.+?file\("(.+?)"';
        if RegExpr.Exec(l.Strings[i]) then begin
           result:=trim(RegExpr.Match[1]);
           if D then writeln('LOCATE_SYSLOG_PATH: (2)',result);
          break
        end;


        RegExpr.expression:='\*\.info.+?\s+(.+)$';
        if RegExpr.Exec(l.Strings[i]) then begin
             if D then writeln('LOCATE_SYSLOG_PATH: (3)',result);
             result:=trim(RegExpr.Match[1]);
             break;
        end;




   end;

   RegExpr.expression:='^-(.+)';
   if RegExpr.Exec(result) then result:=RegExpr.Match[1];

   l.free;
   RegExpr.free;

end;
//##############################################################################
function Tsystem.LOCATE_AUTHLOG_PATH():string;
var i:integer;
l:TstringList;
RegExpr:TRegExpr;
D,DD:boolean;
begin
D:=false;
if ParamStr(1)='--whereis-syslog' then D:=True;
if FileExists('/etc/rsyslog.d/artica-authpriv.conf') then exit('/var/log/auth.log');


   if not FileExists(LOCATE_SYSLOG_CONF()) then begin
      result:=LOCATE_SYSLOG_NG_PATH();
      exit;
   end;

   if D then writeln('LOCATE_AUTHLOG_PATH:',LOCATE_SYSLOG_CONF());

   l:=TstringList.Create;
   l.LoadFromFile(LOCATE_SYSLOG_CONF());
   RegExpr:=TRegExpr.create;

   for i:=0 to l.Count-1 do begin
       if length(trim(l.Strings[i]))=0 then continue;
       RegExpr.expression:='^#';
       if RegExpr.Exec(l.Strings[i]) then continue;
       RegExpr.expression:='authpriv\..*?\s+([\/a-zA-Z0-9\.\-]+)$';

        if RegExpr.Exec(l.Strings[i]) then begin
           result:=trim(RegExpr.Match[1]);
           if D then writeln('LOCATE_AUTHLOG_PATH: (1)',result);
           RegExpr.expression:='^-(.+)';
           if RegExpr.Exec(result) then result:=trim(RegExpr.Match[1]);

           if result='/var/log/auth.log' then begin
              RegExpr.free;
              l.free;
              exit;
           end;

         end else begin
             if verbosed then writeln('LOCATE_AUTHLOG_PATH:: "',l.Strings[i],'"  NO match authpriv.*?\s+([\/a-zA-Z0-9\.]+)$');
         end;
   end;

   RegExpr.expression:='^-(.+)';
   if RegExpr.Exec(result) then result:=RegExpr.Match[1];

   l.free;
   RegExpr.free;

end;
//##############################################################################



function Tsystem.LOCATE_SYSLOG_NG_PATH():string;
var i:integer;
l:TstringList;
RegExpr:TRegExpr;
path:string;
begin
   path:=LOCATE_SYSLOG_NG_CONF();
   if not FileExists(path) then begin
      writeln('Unable to stat /etc/syslog-ng.conf !!');
      exit;
   end;

   l:=TstringList.Create;
   l.LoadFromFile(path);
   RegExpr:=TRegExpr.create;
   RegExpr.expression:='^destination d_everything.+?"(.+?)"';
   for i:=0 to l.Count-1 do begin
        if RegExpr.Exec(l.Strings[i]) then begin
           result:=trim(RegExpr.Match[1]);
           break;
        end;
   end;

   l.free;
   RegExpr.free;

end;
//##############################################################################
function Tsystem.LOCATE_SYSLOG_NG_CONF():string;
begin
  if FileExists('/etc/syslog-ng/syslog-ng.conf') then exit('/etc/syslog-ng/syslog-ng.conf');
  if FileExists('/etc/syslog-ng.conf') then exit('/etc/syslog-ng.conf');
end;
//##############################################################################
function Tsystem.VMWARE_HOST():boolean;
var
   dmidecode:string;
   VMWARE_HOST_LOGS:Tlogs;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
   l:tstringlist;
begin
   result:=false;
   if FileExists('/etc/artica-postfix/VMWARE_NOHOST') then exit(false);
   if FileExists('/etc/artica-postfix/VMWARE_HOST') then exit(true);
   dmidecode:=LOCATE_GENERIC_BIN('dmidecode');
   if not FileExists( dmidecode) then exit;
   VMWARE_HOST_LOGS:=Tlogs.Create;
   tmpstr:='/etc/artica-postfix/dmidecode_type_1';
   if not FileExists(tmpstr) then fpsystem(dmidecode+' --type 1 >'+ tmpstr+' 2>&1');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='VMware Virtual Platform';
   l:=Tstringlist.Create;
   l.LoadFromFile(tmpstr);
   for i:=0 to l.Count-1 do begin
       if  RegExpr.Exec(l.Strings[i]) then begin
            VMWARE_HOST_LOGS.WriteToFile('yes' ,'/etc/artica-postfix/VMWARE_HOST');
            exit(true);
       end;

   end;
    VMWARE_HOST_LOGS.WriteToFile('no' ,'/etc/artica-postfix/VMWARE_NOHOST');
   l.free;
   RegExpr.free;
   VMWARE_HOST_LOGS.free;

end;
//##############################################################################
function Tsystem.VIRTUALBOX_HOST():boolean;
var
   dmidecode:string;
   VMWARE_HOST_LOGS:Tlogs;
   tmpstr:string;
   RegExpr:TRegExpr;
   i:integer;
   l:tstringlist;
   found:boolean;
begin
   result:=false;
   found:=false;
   if FileExists('/etc/artica-postfix/VIRTUALBOX_NOHOST') then exit(false);
   if FileExists('/etc/artica-postfix/VIRTUALBOX_HOST') then exit(true);
   dmidecode:=LOCATE_GENERIC_BIN('dmidecode');
   if not FileExists( dmidecode) then exit;
   VMWARE_HOST_LOGS:=Tlogs.Create;
   tmpstr:='/etc/artica-postfix/dmidecode_type_1';
   if not FileExists(tmpstr) then fpsystem(dmidecode+' --type 1 >'+ tmpstr+' 2>&1');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='VirtualBox';
   l:=Tstringlist.Create;
   l.LoadFromFile(tmpstr);
   for i:=0 to l.Count-1 do begin
       if  RegExpr.Exec(l.Strings[i]) then begin
            VMWARE_HOST_LOGS.WriteToFile('yes' ,'/etc/artica-postfix/VIRTUALBOX_HOST');
            found:=true;
            break;
       end;

   end;

   if not found then VMWARE_HOST_LOGS.WriteToFile('no' ,'/etc/artica-postfix/VIRTUALBOX_NOHOST');

   l.free;
   RegExpr.free;
   VMWARE_HOST_LOGS.free;

end;
//##############################################################################
function Tsystem.RotationSeconds(SecondsNumber:integer):boolean;
var
   s:string;
   i:integer;
   MD:String;
   FileS:string;
   logs:Tlogs;
   ft:integer;
begin
 result:=false;
 s:='';
 if ParamCount>0 then begin
     for i:=1 to ParamCount do begin
        s:=s  + ' ' +ParamStr(i);

     end;
     s:=trim(s);
 end;
 logs:=Tlogs.Create;
 forcedirectories('/etc/artica-postfix/croned.2');
 MD:=MD5FromString(s);
 FileS:='/etc/artica-postfix/croned.2/'+ MD;
 if not FileExists(FileS)  then begin
    fpsystem('/bin/touch '+FileS);
    exit(true);
 end;
 ft:= FILE_TIME_BETWEEN_SEC(FileS);
 if ft>SecondsNumber then begin
   fpsystem('/bin/touch '+FileS);
   exit(true);
 end;

 logs.Debuglogs('('+s+'):: Too short time to perform operation require '+IntToStr(SecondsNumber)+' seconds currently ' +IntToStr(ft)+' seconds');


end;
//##############################################################################
function Tsystem.BuildPids():boolean;
var
   s,mypid:string;
   i:integer;
   MD:String;
   FileS:string;
   logs:Tlogs;
   l:TstringList;
   pid:string;
   cmdline:string;
   ProcessPath:string;
   org_cmdline:string;
begin
 result:=false;
 cmdline:='';
 mypid:=IntToStr(fpgetpid);
 s:='';
 if ParamCount>0 then begin
     for i:=0 to ParamCount do begin
        s:=s  + ' ' +ParamStr(i);

     end;
     s:=trim(s);

 for i:=1 to ParamCount do begin
        cmdline:=cmdline  + ' ' +ParamStr(i);

     end;
     cmdline:=trim(cmdline);
 end;
 logs:=Tlogs.Create;
 forcedirectories('/etc/artica-postfix/pids');
 MD:=MD5FromString(s);
 FileS:='/etc/artica-postfix/pids/'+ MD;
 l:=TstringList.Create;
 if not FileExists(FileS)  then begin
    l.Add(mypid);
    l.SaveToFile(FileS);
    result:=true;
    logs.free;
    l.free;
    exit(true);
 end;

 pid:=Trim(ReadFileIntoString(FileS));

 if mypid=pid then begin
    result:=true;
    logs.free;
    l.free;
    exit(true)
 end;


 if not PROCESS_EXIST(pid) then begin
    l.Add(mypid);
    l.SaveToFile(FileS);
    result:=true;
    logs.free;
    l.free;
    exit(true);
 end;

 logs.Debuglogs('BuildPids(): Already instance executed:'+s+'  PID number ' + pid);
 ProcessPath:=fpReadlink('/proc'+'/'+pid+'/exe');

 if ProcessPath<>ParamStr(0) then begin
     logs.Debuglogs('BuildPids(): wrong pid for '+ParamStr(0));
     logs.Debuglogs('BuildPids(): PID report '+ProcessPath );
     l.Add(mypid);
     l.SaveToFile(FileS);
     result:=true;
     logs.free;
     l.free;
     exit(true);
 end;


 org_cmdline:=trim(ReadFileIntoString('/proc'+'/'+pid+'/cmdline'));
 if IsBinaryString(org_cmdline)  then org_cmdline:=TransFormBinaryString(org_cmdline);
 logs.Debuglogs('BuildPids(): Already instance executed:'+s+'  PID number ' + pid);
 logs.Debuglogs('BuildPids(): Process path is: ' + ProcessPath);
 logs.Debuglogs('BuildPids(): cmd is ' + org_cmdline);


 logs.free;
 l.free;
 exit(false);

end;
//##############################################################################
function Tsystem.LOCATE_DPKG():string;
begin
if FileExists('/usr/bin/dpkg') then exit('/usr/bin/dpkg');
end;
//##############################################################################
function Tsystem.backports_Exists():boolean;
 var
 i:integer;
 l:TstringList;
 RegExpr:TRegExpr;
begin
 result:=false;
 if not FileExists('/etc/apt/sources.list') then exit;
 l:=Tstringlist.Create;
 l.LoadFromFile('/etc/apt/sources.list');
 RegExpr:=TRegExpr.Create;
 RegExpr.Expression:='^deb.+?backports';
 for i:=0 to l.Count-1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
         result:=true;
         break;
      end;
 end;
 RegExpr.free;
 l.free;

end;
//##############################################################################
function Tsystem.LOCATE_MKFIFO():string;
begin
   if FileExists('/usr/bin/mkfifo') then exit('/usr/bin/mkfifo');
   if FileExists('/bin/mkfifo') then exit('/bin/mkfifo');
   exit(LOCATE_GENERIC_BIN('mkfifo'));
end;
//##############################################################################
//##############################################################################
function Tsystem.LOCATE_PHP5_BIN():string;
begin
  if FileExists('/opt/articatech/bin/php') then exit('/opt/articatech/bin/php');
  if FileExists('/usr/bin/php5') then exit('/usr/bin/php5');
  if FIleExists('/usr/bin/php') then exit('/usr/bin/php');
  if FIleExists('/usr/local/apache-groupware/php5/bin/php') then exit('/usr/local/apache-groupware/php5/bin/php');
  if FIleExists('/opt/artica-agent/bin/php') then exit('/opt/artica-agent/bin/php');

end;
//##############################################################################
function Tsystem.LOCATE_PHP5_CONFIG_BIN():string;
begin
  if FileExists('/usr/bin/php-config5') then exit('/usr/bin/php-config5');
  if FIleExists('/usr/bin/php-config') then exit('/usr/bin/php-config');
  if FileExists('/opt/articatech/bin/php-config') then exit('/opt/articatech/bin/php-config');
  if FileExists('/opt/artica-agent/bin/php-config') then exit('/opt/artica-agent/bin/php-config');
end;
//##############################################################################
function Tsystem.LOCATE_PHP5_CGI():string;
begin
   if FileExists('/usr/bin/php-cgi') then exit('/usr/bin/php-cgi');
   if FileExists('/opt/artica/lighttpd/bin/php-cgi') then exit('/opt/artica/lighttpd/bin/php-cgi');
   if FileExists('/usr/local/bin/php-cgi') then exit('/usr/local/bin/php-cgi');
   if FileExists('/opt/articatech/bin/php-cgi') then exit('/opt/articatech/bin/php-cgi');
   if FileExists('/opt/artica-agent/bin/php-cgi') then exit('/opt/artica-agent/bin/php-cgi');
end;
//##############################################################################
function Tsystem.LOCATE_PECL():string;
begin
if FileExists('/usr/bin/pecl') then exit('/usr/bin/pecl');
end;
//##############################################################################
function Tsystem.LOCATE_OBM_SHARE():string;
begin
if DirectoryExists('/usr/share/obm') then exit('/usr/share/obm');
end;
//##############################################################################
function Tsystem.LOCATE_MAILPARSE_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/mailparse.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_IMAP_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/imap.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################

function Tsystem.LOCATE_MCRYPT_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/mcrypt.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_XAPIAN_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/xapian.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_LDAP_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/ldap.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_SESSSION_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/session.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_MYSQL_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/mysql.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_GD_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/gd.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_GEOIP_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/geoip.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_POSIX_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/posix.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_EACCELERATOR_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/eaccelerator.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_MAPI_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/mapi.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_APC_SO():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/apc.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.LOCATE_EACCELERATOR_SO_GW():string;
var tmp:string;
begin
tmp:=LOCATE_PHP5_EXTENSION_DIR()+'/eaccelerator.so';
if FileExists(tmp) then exit(tmp);
end;
//##############################################################################
function Tsystem.PROCCESS_TIME_MIN(pid:string):integer;

var
logs:Tlogs;
tmpstr:string;
l:Tstringlist;
i:integer;
RegExpr:TRegExpr;
sec:integer;
begin
 result:=0;
logs:=Tlogs.Create;
tmpstr:=logs.FILE_TEMP();
fpsystem('/usr/share/artica-postfix/bin/procstat '+ pid +' >'+ tmpstr);
l:=Tstringlist.Create;
l.LoadFromFile(tmpstr);
logs.DeleteFile(tmpstr);
RegExpr:=TRegExpr.Create;
sec:=0;
RegExpr.Expression:='start_time:.+?\(([0-9]+)';
for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
         TryStrToint(RegExpr.Match[1],sec);
    end;
end;

if sec=0 then exit(0);
result:=sec div 60;


end;
//##############################################################################
function tSystem.LOCATE_PHP5_EXTENSION_DIR_GW():string;
var
  php5_extension_dir:string;
  res:string;
  logs:Tlogs;
begin


  result:=GET_CACHE_VERSION('LOCATE_PHP5_CONFIG_BIN_GW');
  if length(result)>0 then exit;

if not FileExists('/usr/local/apache-groupware/php5/bin/php-config') then begin
   exit;
end;
logs:=Tlogs.Create;
php5_extension_dir:=logs.FILE_TEMP();
fpsystem('/usr/local/apache-groupware/php5/bin/php-config --extension-dir >'+ php5_extension_dir+' 2>&1');
res:=trim(logs.ReadFromFile(php5_extension_dir));
logs.DeleteFile(php5_extension_dir);
result:=res;
SET_CACHE_VERSION('LOCATE_PHP5_CONFIG_BIN_GW',result);
end;
//##############################################################################
function tSystem.LOCATE_PHP5_EXTENSION_DIR():string;
var
  php5_extension_dir:string;
  res:string;
  logs:Tlogs;
  PHP5_CONFIG_BIN:string;
begin

result:=LOCATE_PHP5_EXTENSION_INMEM();
if length(result)>5 then begin
   if FileExists(result+'/mysql.so') then begin
       if verbosed then writeln('tSystem.LOCATE_PHP5_EXTENSION_DIR:: ',result,'/mysql.so OK');
       exit(result);
   end;
end;

if FileExists('/usr/lib/php5/20100525+lfs/mysql.so') then begin
       if verbosed then writeln('tSystem.LOCATE_PHP5_EXTENSION_DIR:: Hard coded /usr/lib/php5/20100525+lfs mysql.so OK');
       result:='/usr/lib/php5/20100525+lfs';
       exit(result);
end;



if not FileExists(LOCATE_PHP5_CONFIG_BIN()) then begin
   if verbosed then writeln('tSystem.LOCATE_PHP5_EXTENSION_DIR:: Unable to stat php5-config, try old function..');
   result:=LOCATE_PHP5_EXTENSION_DIR_OLD();
   MEM_PHP5_EXTENSION_DIR:=result;
   SET_CACHE_VERSION('LOCATE_PHP5_CONFIG_BIN',result);
   exit;
end;
logs:=Tlogs.Create;
php5_extension_dir:=logs.FILE_TEMP();
PHP5_CONFIG_BIN:=LOCATE_PHP5_CONFIG_BIN();
 if verbosed then writeln('php5-config:',PHP5_CONFIG_BIN);
fpsystem(LOCATE_PHP5_CONFIG_BIN() +' --extension-dir >'+ php5_extension_dir+' 2>&1');
res:=trim(logs.ReadFromFile(php5_extension_dir));
logs.DeleteFile(php5_extension_dir);
if length(res)=0 then begin
   if verbosed then writeln('tSystem.LOCATE_PHP5_EXTENSION_DIR:: Unable to stat php5-config, try old function..');
   result:=LOCATE_PHP5_EXTENSION_DIR_OLD();
   MEM_PHP5_EXTENSION_DIR:=result;
end else begin
  result:=res;
end;
if not FileExists(result+'/mysql.so') then begin
   if verbosed then writeln('tSystem.LOCATE_PHP5_EXTENSION_DIR:: ',result,'/mysql.so Failed -> tSystem.LOCATE_PHP5_EXTENSION_DIR_MANU()');
   result:=LOCATE_PHP5_EXTENSION_DIR_MANU();
end;
MEM_PHP5_EXTENSION_DIR:=result;
SET_CACHE_VERSION('LOCATE_PHP5_CONFIG_BIN',result);
end;
//##############################################################################
function tSystem.LOCATE_PHP5_EXTENSION_DIR_MANU():string;
begin
     if FileExists('/usr/lib/php5/20090626+lfs/mysql.so') then exit('/usr/lib/php5/20090626+lfs');
     if FileExists('/usr/lib/php5/20060613+lfs/mysql.so') then exit('/usr/lib/php5/20060613+lfs');
end;
//##############################################################################

function tSystem.LOCATE_PHP5_EXTENSION_INMEM():string;
begin
   if length(trim(MEM_PHP5_EXTENSION_DIR))>0 then begin
         If DirectoryExists(MEM_PHP5_EXTENSION_DIR) then exit(MEM_PHP5_EXTENSION_DIR);
   end;

  MEM_PHP5_EXTENSION_DIR:=GET_CACHE_VERSION('LOCATE_PHP5_CONFIG_BIN');
  if length(MEM_PHP5_EXTENSION_DIR)>0 then begin
     If DirectoryExists(MEM_PHP5_EXTENSION_DIR) then exit(MEM_PHP5_EXTENSION_DIR);
  end;

end;
//##############################################################################
function tSystem.LOCATE_PHP5_EXTENSION_DIR_OLD():string;
var
  l:TstringList;
  i:integer;
  RegExpr:TRegExpr;
  php5_extension_dir:string;
begin
if not FileExists(LOCATE_PHP5_BIN()) then begin
   writeln('tSystem.LOCATE_PHP5_EXTENSION_DIR():: unable to locate php5 !!');
   exit;
end;
php5_extension_dir:=GET_INFO('php5_extension_dir');
if length(php5_extension_dir)<5 then begin
     fpsystem(LOCATE_PHP5_BIN() + ' -i >/tmp/php.temp 2>&1');
     if not FileExists('/tmp/php.temp') then exit;
     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile('/tmp/php.temp');
     RegExpr.Expression:='^extension_dir =>\s+(.+?)\s+';
     for i:=0 To l.Count-1 do begin
         if  RegExpr.Exec(l.Strings[i]) then begin
             php5_extension_dir:=trim(RegExpr.Match[1]);
             set_INFOS('php5_extension_dir',php5_extension_dir);
             FreeAndNil(l);
             FreeAndNil(RegExpr);
             break;
         end;

     end;
end;

result:=php5_extension_dir;


end;
//##############################################################################
function tSystem.LOCATE_PHP5_EXTCONF_DIR():string;
var
  l:TstringList;
  i:integer;
  RegExpr:TRegExpr;
  php5_extension_dir:string;
begin
if not FileExists(LOCATE_PHP5_BIN()) then begin
   writeln('tSystem.LOCATE_PHP5_EXTCONF_DIR():: unable to locate php5 !!');
   exit;
end;
php5_extension_dir:=GET_INFO('php5_extconf_dir');
if not DirectoryExists(php5_extension_dir) then php5_extension_dir:='';
if length(php5_extension_dir)<3 then begin
     fpsystem(LOCATE_PHP5_BIN() + ' -i >/tmp/php.temp 2>&1');
     if not FileExists('/tmp/php.temp') then exit;
     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile('/tmp/php.temp');
     RegExpr.Expression:='^Scan\s+this\s+dir\s+for\s+additional\s+\.ini\s+files\s+=>\s+(.+)';
     for i:=0 To l.Count-1 do begin
         if  RegExpr.Exec(l.Strings[i]) then begin
             php5_extension_dir:=trim(RegExpr.Match[1]);
             set_INFOS('php5_extconf_dir',php5_extension_dir);
             FreeAndNil(l);
             FreeAndNil(RegExpr);
             break;
         end;

     end;
end;

result:=php5_extension_dir;


end;
//##############################################################################
function tSystem.LOCATE_PHP5_SESSION_PATH():string;
var
  l:TstringList;
  i:integer;
  RegExpr:TRegExpr;
  php5_session_path:string;
begin
if not FileExists(LOCATE_PHP5_BIN()) then begin
   writeln('tSystem.LOCATE_PHP5_EXTCONF_DIR():: unable to locate php5 !!');
   exit;
end;
php5_session_path:=GET_INFO('php5_session_path');
if length(php5_session_path)<3 then begin
     fpsystem(LOCATE_PHP5_BIN() + ' -i >/tmp/php.temp 2>&1');
     if not FileExists('/tmp/php.temp') then exit;
     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile('/tmp/php.temp');
     RegExpr.Expression:='^session.save_path\s+=>\s+(.+?)\s+';
     for i:=0 To l.Count-1 do begin
         if  RegExpr.Exec(l.Strings[i]) then begin
             php5_session_path:=trim(RegExpr.Match[1]);
             set_INFOS('php5_session_path',php5_session_path);
             FreeAndNil(l);
             FreeAndNil(RegExpr);
             break;
         end;

     end;
end;

result:=php5_session_path;
end;
//##############################################################################


function tSystem.LOCATE_SLAPCAT():string;
begin
    if FileExists('/usr/sbin/slapcat') then exit('/usr/sbin/slapcat');
end;
//##############################################################################
function tSystem.LOCATE_MYSQLDUMP():string;
begin
    if FileExists('/usr/bin/mysqldump') then exit('/usr/bin/mysqldump');
end;
//##############################################################################
function tSystem.LOCATE_MYSHOTCOPY():string;
begin
    if FileExists('/usr/bin/mysqlhotcopy') then exit('/usr/bin/mysqlhotcopy');
end;
//##############################################################################
function tSystem.LOCATE_SLAPADD():string;
begin
    if FileExists('/usr/sbin/slapadd') then exit('/usr/sbin/slapadd');
end;
//##############################################################################
function tSystem.LOCATE_SLAPINDEX():string;
begin
    if FileExists('/usr/sbin/slapindex') then exit('/usr/sbin/slapindex');
end;
//#############################################################################
function tSystem.FileSymbolicExists(path:string):boolean;
var
info :stat;
begin
result:=false;
if Not FileExists(path) then exit;
 if fpLStat (path,@info)=0 then
    begin
    if fpS_ISLNK(info.st_mode) then exit(true);
    exit;
      Writeln ('File is a link');
    if fpS_ISREG(info.st_mode) then
      Writeln ('File is a regular file');
    if fpS_ISDIR(info.st_mode) then
      Writeln ('File is a directory');
    if fpS_ISCHR(info.st_mode) then
      Writeln ('File is a character device file');
    if fpS_ISBLK(info.st_mode) then
      Writeln ('File is a block device file');
    if fpS_ISFIFO(info.st_mode) then
      Writeln ('File is a named pipe (FIFO)');
    if fpS_ISSOCK(info.st_mode) then
      Writeln ('File is a socket');
    end else begin
    writeln('FileSymbolicExists:: Fstat failed. Errno : ' + IntToStr(fpgeterrno));
    end;

end;
//##############################################################################
function tSystem.IsDirectory(path:string):boolean;
var
info :stat;
begin
result:=false;
if Not FileExists(path) then exit;
 if fpLStat (path,@info)=0 then
    begin
    if fpS_ISDIR(info.st_mode) then exit(true);
    exit(false);
    end;

end;
//##############################################################################
function tSystem.LOCATE_DPKG_QUERY():string;
begin
    if FileExists('/usr/bin/dpkg-query') then exit('/usr/bin/dpkg-query');
end;
//#############################################################################
function tsystem.LOCATE_APT_CACHE():string;
begin
if FileExists('/usr/bin/apt-cache') then exit('/usr/bin/apt-cache');
end;
//#############################################################################
function tsystem.LOCATE_FDISK():string;
begin
if FileExists('/sbin/fdisk') then exit('/sbin/fdisk');
end;
//#############################################################################
function tsystem.LOCATE_DF():string;
begin
if FileExists('/bin/df') then exit('/bin/df');
end;
//#############################################################################
function Tsystem.LOCATE_STUNNEL():string;
begin
if FileExists('/usr/bin/stunnel4') then exit('/usr/bin/stunnel4');
if FileExists('/usr/bin/stunnel') then exit('/usr/bin/stunnel');
end;
//#############################################################################
function Tsystem.DISKS_STATUS_DEV():string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   tmp:string;
   res:string;
   xxxlogs:tlogs;
   ss:integer;
   cmd:string;
begin
     res:='';
   xxxlogs:=Tlogs.Create;
   if not fileexists(LOCATE_FDISK()) then exit;
   tmp:=FILE_TEMP();
   cmd:=LOCATE_DF() + ' -P -h -B G >'+ tmp + ' 2>&1';
   xxxlogs.Debuglogs(cmd);
   fpsystem(cmd);
   if not FileExists(tmp) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmp);
   DeleteFile(tmp);
   RegExpr:=TRegExpr.Create;


   RegExpr.Expression:='^\/dev\/(.+?)\s+([0-9]+)G\s+([0-9]+)G\s+([0-9]+)G\s+([0-9]+)%';
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          ss:=0;
          res:=res + RegExpr.Match[1]+','+RegExpr.Match[2]+','+RegExpr.Match[3]+','+RegExpr.Match[4]+',' +RegExpr.Match[5]+ ';';
          try
          ss:=StrToInt(RegExpr.Match[5]);
          except
            xxxlogs.Debuglogs('Fatal error while try to tranfrom '+RegExpr.Match[5]);
          end;
          if ss>94 then begin
             xxxlogs.NOTIFICATION('[ARTICA]: ('+HOSTNAME_g()+') warning disk size !! on device ' + RegExpr.Match[1],'You need to check disk size, ' + RegExpr.Match[1] + ' has '+RegExpr.Match[5] +'% used','system');
          end;
      end else begin
          xxxlogs.Debuglogs(l.Strings[i]+'->Failed '+RegExpr.Expression);
       end;
   end;

   result:=res;
   FreeAndNil(l);
   FreeAndNil(RegExpr);

end;
//#############################################################################
function Tsystem.SIEVE_PORT():string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   tmp:string;
   res:string;
   xxxlogs:tlogs;
   ss:integer;
   cmd:string;
   timemin:integer;
begin
     if not FileExists('c') then exit;
     l:=tstringlist.Create;
     l.LoadFromFile('/etc/services');
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='^sieve\s+([0-9]+)';
     for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1];
            break;
         end;

     end;
     RegExpr.free;
     l.free;
end;




function Tsystem.IS_INSIDE_VPS():boolean;
var
   RegExpr:TRegExpr;
   IS_INSIDE_VPSlogs:tlogs;
   tmpstr:string;
begin
     result:=false;


     if FileExists('/proc/vz/veinfo') then exit(true);
     if FileExists('/proc/vz/version') then exit(true);
     if DirectoryExists('/proc/xen') then exit(true);
     if FIleExists('/etc/artica-postfix/AS_VPS_CLIENT') then exit(true);
     if FileExists('/proc/1/cgroup') then begin
           IS_INSIDE_VPSlogs:=tlogs.Create;
           tmpstr:=IS_INSIDE_VPSlogs.FILE_TEMP();
           fpsystem('/bin/cat /proc/1/cgroup >'+tmpstr+' 2>&1');
           IS_INSIDE_VPSlogs.DeleteFile(tmpstr);
           IS_INSIDE_VPSlogs.free;
          RegExpr:=TRegExpr.Create;
          RegExpr.Expression:='cpuset:/(.*)$';
          if RegExpr.exec(ReadFromFile(tmpstr)) then begin
             if length(RegExpr.Match[1])>2 then begin
                result:=true;
                RegExpr.free;
                exit;
             end;
         end;
         RegExpr.free;

     end;


end;





function Tsystem.DISKS_INODE_DEV():string;
var
   l:TstringList;
   i:Integer;
   RegExpr:TRegExpr;
   tmp:string;
   res:string;
   xxxlogs:tlogs;
   ss:integer;
   cmd:string;
   timemin:integer;
begin
     res:='';

   timemin:=FILE_TIME_BETWEEN_MIN('/etc/artica-postfix/inodes.caches');
 xxxlogs:=Tlogs.Create;
   if(timemin<10) then begin
      res:=trim(xxxlogs.ReadFromFile('/etc/artica-postfix/inodes.caches'));
      if verbosed then writeln('/etc/artica-postfix/inodes.caches -> ',length(res),' bytes ',timemin,'Mn/10');
      if length(res)>5 then begin
            result:=res;
            xxxlogs.free;
            exit;
      end;
   end;

   if not fileexists(LOCATE_FDISK()) then begin
      if verbosed then writeln('LOCATE_FDISK:: -> null');
      exit;
   end;


   tmp:=FILE_TEMP();
   cmd:=LOCATE_DF() + ' -i -h >'+ tmp + ' 2>&1';
   if verbosed then writeln(cmd);
   xxxlogs.Debuglogs(cmd);
   fpsystem(cmd);
   if not FileExists(tmp) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmp);
   DeleteFile(tmp);
   RegExpr:=TRegExpr.Create;

   RegExpr.Expression:='^\/dev\/(.+?)\s+([0-9,]+)([A-Z])\s+([0-9,]+)([A-Z])\s+([0-9,]+)([A-Z])\s+([0-9,]+)%';
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          ss:=0;
          res:=res + RegExpr.Match[1]+':'+RegExpr.Match[2]+RegExpr.Match[3]+':'+RegExpr.Match[4]+RegExpr.Match[5]+':'+RegExpr.Match[6]+RegExpr.Match[7]+':' +RegExpr.Match[8]+ ';';
          try
          ss:=StrToInt(RegExpr.Match[8]);
          except
            xxxlogs.Debuglogs('Fatal error while try to transfrom '+RegExpr.Match[8]);
          end;
          if ss>70 then begin
             xxxlogs.NOTIFICATION('[ARTICA]: ('+HOSTNAME_g()+') warning too many files !! on device ' + RegExpr.Match[1],'You need to check number of files on this disk, ' + RegExpr.Match[1] + ' has '+RegExpr.Match[8] +'% used','system');
          end;
      end else begin
          xxxlogs.Debuglogs(l.Strings[i]+'->Failed '+RegExpr.Expression);
       end;
   end;

   result:=res;
   xxxlogs.WriteToFile(res,'/etc/artica-postfix/inodes.caches');
   FreeAndNil(l);
   FreeAndNil(RegExpr);

end;
//#############################################################################



function Tsystem.DISK_USB_EXISTS(uuid:string):boolean;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;

   fline:string;
begin
   result:=false;
   tmpfile:=FILE_TEMP();
   fpsystem(LOCATE_BLKID() + ' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   if not FileExists(tmpfile) then exit;
   l.LoadFromFile(tmpfile);
   DeleteFile(tmpfile);
   RegExpr:=TRegExpr.Create;
for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^(.+?):(.+)';
       if RegExpr.Exec(l.Strings[i]) then begin
           fline:=RegExpr.Match[2];
           RegExpr.Expression:='UUID="(.+?)"';
           if RegExpr.Exec(fline) then begin
                 if uuid=RegExpr.Match[1] then begin
                    result:=true;
                    break;
                 end;
           end;

       end;
end;

   l.free;
   RegExpr.free;

end;
//##############################################################################
function Tsystem.DISK_USB_DEV_SOURCE(uuid:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
   fpath:string;
   fline:string;
begin
   result:='';
   tmpfile:=FILE_TEMP();
   fpsystem(LOCATE_BLKID() + ' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   if not FileExists(tmpfile) then exit;
   l.LoadFromFile(tmpfile);
   DeleteFile(tmpfile);
   RegExpr:=TRegExpr.Create;
for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^(.+?):(.+)';
       if RegExpr.Exec(l.Strings[i]) then begin
           fpath:=RegExpr.Match[1];
           fline:=RegExpr.Match[2];
           RegExpr.Expression:='UUID="(.+?)"';
           if RegExpr.Exec(fline) then begin
                 if uuid=RegExpr.Match[1] then begin
                    result:=fpath;
                    break;
                 end;
           end;

       end;
end;

   l.free;
   RegExpr.free;

end;
//##############################################################################
function Tsystem.DISK_USB_TYPE(uuid:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;

   fline:string;
begin
   result:='';
   tmpfile:=FILE_TEMP();
   fpsystem(LOCATE_BLKID() + ' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   if not FileExists(tmpfile) then exit;
   l.LoadFromFile(tmpfile);
   DeleteFile(tmpfile);
   RegExpr:=TRegExpr.Create;
for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^(.+?):(.+)';
       if RegExpr.Exec(l.Strings[i]) then begin

           fline:=RegExpr.Match[2];
           RegExpr.Expression:='UUID="(.+?)"';
           if RegExpr.Exec(fline) then begin
                 if uuid=RegExpr.Match[1] then begin
                    RegExpr.Expression:='TYPE="(.+?)"';
                    if RegExpr.Exec(fline) then begin
                        result:=RegExpr.Match[1];
                    end;
                    break;
                 end;
           end;

       end;
end;

   l.free;
   RegExpr.free;

end;
//##############################################################################
function Tsystem.DISK_USB_IS_MOUNTED(source:string;destination:string):boolean;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
begin
     result:=false;
     tmpfile:=FILE_TEMP();
     fpsystem('/bin/mount >'+tmpfile + ' 2>&1');
     if not FileExists(tmpfile) then exit;
     l:=TstringList.Create;
     if not FileExists(tmpfile) then exit;
     l.LoadFromFile(tmpfile);
     DeleteFile(tmpfile);
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^(.+?)\s+on\s+(.+?)\s+type';

for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
        if source=RegExpr.Match[1] then begin
           if  destination=RegExpr.Match[2] then begin
               result:=true;
               break;
           end;
        end;
    end;
end;

l.free;
RegExpr.free;
end;
//##############################################################################
function Tsystem.CPU_MHZ():string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
   info:string;
   D:boolean;
begin
     D:=false;
     if paramStr(1)='--cpuinfo' then D:=True;

     if paramStr(2)<>'--force' then begin
        if not FileExists('/usr/bin/x86info') then begin
           if D then writeln('could not stat /usr/bin/x86info');
            exit;
        end;
     end;

     info:=GET_INFO('x86info_mhz');
     if length(info)>0 then begin
        if D then writeln('send result by ini file...');
        result:=info;
     end;

     result:='';
     tmpfile:=FILE_TEMP();
     fpsystem('/usr/bin/x86info -mhz >'+tmpfile + ' 2>&1');
     if not FileExists(tmpfile) then begin
        if D then writeln('could not stat ',tmpfile);
        exit;
     end;
     l:=TstringList.Create;
     if not FileExists(tmpfile) then exit;
     l.LoadFromFile(tmpfile);
     DeleteFile(tmpfile);
     RegExpr:=TRegExpr.Create;
     RegExpr.Expression:='([0-9\.]+)([A-Za-z]+)\s+processor\s+\(';

for i:=0 to l.Count-1 do begin
    if RegExpr.Exec(l.Strings[i]) then begin
       if D then writeln('found line ',l.Strings[i]);
       result:=RegExpr.Match[1]+' ' +RegExpr.Match[2];
       break;
    end else begin
        if D then writeln('wrong line ',l.Strings[i]);
    end;
end;
set_INFOS('x86info_mhz',result);
l.free;
RegExpr.free;
end;
//##############################################################################
function Tsystem.TEST_IONICE():boolean;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
   info:string;
   D:boolean;
   TEST_IONICE_LOGS:Tlogs;
begin
   result:=true;
   TEST_IONICE_LOGS:=Tlogs.Create;
   tmpfile:=TEST_IONICE_LOGS.FILE_TEMP();
   if FIleExists('/usr/bin/ionice') then begin
      fpsystem('/usr/bin/ionice -c2 -n7 echo 1 >'+tmpfile+' 2>&1');
     l:=TstringList.Create;
     if not FileExists(tmpfile) then exit;
     l.LoadFromFile(tmpfile);
     DeleteFile(tmpfile);
     RegExpr:=TRegExpr.Create;


     for i:=0 to l.Count-1 do begin
         RegExpr.Expression:='ioprio_set.+?Operation not permitted';
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=false;
            break;
         end;
     end;
     l.free;
     RegExpr.free;
     end else begin
         result:=false;
     end;
     TEST_IONICE_LOGS.Free;

end;
//##############################################################################

function Tsystem.EXEC_NICE():string;
var
tmp:string;
ionice:string;
cmd_nice:string;
Nice:integer;
useIonice:integer;
ArticaInCgroups:integer;
ArticaCgroup:string;
cgroupsEnabled:integer;
cgexec:string;
begin
Nice:=0;
if not TryStrToInt(GET_INFO('useIonice'),useIonice) then useIonice:=1;
if not TryStrToInt(GET_INFO('ArticaInCgroups'),ArticaInCgroups) then ArticaInCgroups:=0;
if not TryStrToInt(GET_INFO('cgroupsEnabled'),cgroupsEnabled) then cgroupsEnabled:=0;
ArticaCgroup:=GET_INFO('ArticaCgroup');
if cgroupsEnabled=1 then begin
   if ArticaInCgroups=1 then begin
     if length(ArticaCgroup)>0 then begin
        if DirectoryExists('/cgroups/cpuacct/'+ArticaCgroup) then begin
              cgexec:=LOCATE_GENERIC_BIN('cgexec');
              if FileExists(cgexec) then begin
                 result:=cgexec+' -g *:'+ArticaCgroup+' ';
                 exit(result);
              end;
        end;
     end;
   end;
end;

tmp:=GET_PERFS('ProcessNice');
if length(trim(tmp))=0 then begin
   set_INFO('ProcessNice','19');
   tmp:='19';
end;
if not TryStrToInt(tmp,Nice) then Nice:=19;

if FIleExists('/usr/bin/ionice') then begin
   if useIonice=1 then begin
      if Nice<9 then ionice:='';
      if Nice>9 then ionice:='/usr/bin/ionice -c2 -n5 ';
      if Nice>12 then ionice:='/usr/bin/ionice -c2 -n7 ';
   end;
end;

if FileExists('/usr/bin/nice') then cmd_nice:='/usr/bin/nice -n ' + IntToStr(Nice)+' ';


result:=ionice+cmd_nice;
end;
//##############################################################################
procedure Tsystem.StripDiezes(filepath:string);
var
list,list2:TstringList;
i,n:integer;
line:string;
RegExpr:TRegExpr;
begin
 RegExpr:=TRegExpr.create;
 RegExpr.expression:='#';
    if not FileExists(filepath) then exit;
    list:=TstringList.Create();
    list2:=TstringList.Create();
    list.LoadFromFile(filepath);
    n:=-1;
    For i:=0 to  list.Count-1 do begin
        n:=n+1;
         line:=list.Strings[i];
         if length(line)>0 then begin

            if not RegExpr.Exec(list.Strings[i])  then begin
               list2.Add(list.Strings[i]);
            end;
         end;
    end;

    list2.SaveToFile(filepath);

    RegExpr.Free;
    list2.Free;
    list.Free;
end;
 //##############################################################################
function Tsystem.LOCATE_PRELOAD():string;
begin
  if FileExists('/usr/sbin/preload') then exit('/usr/sbin/preload');
end;
 //##############################################################################
function Tsystem.LOCATE_POSTFIX_MAILDROP():string;
begin
  if FileExists('/usr/bin/maildrop') then exit('/usr/bin/maildrop');
  if FileExists('/usr/local/bin/maildrop') then exit('/usr/local/bin/maildrop');
end;
 //##############################################################################
function Tsystem.LOCATE_cyrreconstruct():string;
begin
  if FileExists('/usr/sbin/cyrreconstruct') then exit('/usr/sbin/cyrreconstruct');
  if FileExists('/usr/lib/cyrus/bin/reconstruct') then exit('/usr/lib/cyrus/bin/reconstruct');
end;
 //##############################################################################
function Tsystem.LOCATE_SU():string;
begin
  if FileExists('/bin/su') then exit('/bin/su');
end;
 //##############################################################################
function Tsystem.LOCATE_SYSLOG():string;
begin
  if FileExists('/var/log/syslog') then exit('/var/log/syslog');
end;
 //##############################################################################
function Tsystem.LOCATE_SMBMOUNT():string;
begin
  if FileExists('/usr/bin/smbmount') then exit('/usr/bin/smbmount');
end;
 //##############################################################################
function Tsystem.LOCATE_INETD():string;
begin
  if FileExists('/usr/sbin/inetd') then exit('/usr/sbin/inetd');
  if FileExists('/usr/sbin/xinetd') then exit('/usr/sbin/xinetd');
end;
 //##############################################################################
function Tsystem.LOCATE_UPDATE_INETD():string;
begin
  if FileExists('/usr/sbin/update-inetd') then exit('/usr/sbin/update-inetd');
end;
 //##############################################################################
function Tsystem.LOCATE_INETD_INITD():string;
begin
    if FileExists('/etc/init.d/openbsd-inetd') then exit('/etc/init.d/openbsd-inetd');
    if FileExists('/etc/init.d/xinetd') then exit('/etc/init.d/xinetd');

end;
 //##############################################################################

function Tsystem.INETD_PID():string;
begin
   if not FileExists(LOCATE_INETD())then exit;
   if FileExists('/var/run/inetd.pid') then exit(GET_PID_FROM_PATH('/var/run/inetd.pid'));
   exit(PidByProcessPath(LOCATE_INETD()));
end;
 //##############################################################################
function Tsystem.SMBMOUNT_VERSION():string;
var
l      :TstringList;
i      :integer;
RegExpr:TRegExpr;
begin

    if not FileExists(LOCATE_SMBMOUNT()) then exit;
    fpsystem(LOCATE_SMBMOUNT() + ' -V >/opt/artica/tmp/smbmount.version 2>&1');
    if not FileExists('/opt/artica/tmp/smbmount.version') then exit;
    l:=TstringList.Create;
    l.LoadFromFile('/opt/artica/tmp/smbmount.version');
    FILE_DELETE('/opt/artica/tmp/smbmount.version');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='version:\s+([0-9\.]+)';
    for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
             result:=RegExpr.Match[1];
             break;
         end;
    end;

l.free;
RegExpr.free;


end;
//#############################################################################
function Tsystem.INETD_VERSION():string;
var
l      :TstringList;
i      :integer;
RegExpr:TRegExpr;
begin

    if not FileExists(LOCATE_UPDATE_INETD()) then exit;
    fpsystem(LOCATE_UPDATE_INETD() + ' --version >/opt/artica/tmp/inetd.version 2>&1');
    if not FileExists('/opt/artica/tmp/inetd.version') then exit;
    l:=TstringList.Create;
    l.LoadFromFile('/opt/artica/tmp/inetd.version');
    FILE_DELETE('/opt/artica/tmp/inetd.version');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='update-inetd\s+([0-9\.]+)';
    for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
             result:=RegExpr.Match[1];
             break;
         end;
    end;

l.free;
RegExpr.free;
end;
//#############################################################################
FUNCTION Tsystem.INETD_STATUS():string;
var
   ini:TstringList;
   pid:string;
begin
if not FileExists(LOCATE_INETD()) then exit;
      ini:=TstringList.Create;
      pid:=INETD_PID();

      ini.Add('[INETD]');
      if PROCESS_EXIST(pid) then ini.Add('running=1') else  ini.Add('running=0');
      ini.Add('application_installed=1');
      ini.Add('master_pid='+ pid);
      ini.Add('master_memory=' + IntToStr(PROCESS_MEMORY(pid)));
      ini.Add('master_version=' + INETD_VERSION());
      ini.Add('status='+PROCESS_STATUS(pid));
      ini.Add('service_name=APP_INETD');
      ini.Add('process_path='+LOCATE_INETD());
      ini.Add('service_cmd=');
      ini.Add('service_disabled=0');
      result:=ini.Text;
      ini.free;
end;
//#########################################################################################


procedure Tsystem.FILE_DELETE(TargetPath:string);
Var F : Text;

begin
  if not FileExists(TargetPath) then exit;
  TRY
    Assign (F,TargetPath);
    Erase (f);
  EXCEPT

  end;
end;
//#############################################################################
function Tsystem.LOCATE_MOUNT():string;
begin
if FileExists('/bin/mount') then exit('/bin/mount');
end;
//#############################################################################
function Tsystem.LOCATE_GCC():string;
 begin
     if FileExists('/usr/bin/gcc') then exit('/usr/bin/gcc');
 end;
//##############################################################################
function Tsystem.LOCATE_MAKE():string;
 begin
     if FileExists('/usr/bin/make') then exit('/usr/bin/make');
 end;
//##############################################################################
function  Tsystem.LOCATE_SLAPD():string;
begin
if FileExists('/usr/sbin/slapd') then exit('/usr/sbin/slapd');
If FileExists('/usr/lib/openldap/slapd') then exit('/usr/lib/openldap/slapd');
if FileExists('/usr/local/libexec/slapd') then exit('/usr/local/libexec/slapd');
exit(LOCATE_GENERIC_BIN('slapd'));
end;
//##############################################################################
function  Tsystem.LOCATE_TAR():string;
begin
if FileExists('/bin/tar') then exit('/bin/tar');
end;
//##############################################################################
function  Tsystem.LOCATE_MEMCACHED():string;
begin
if FileExists('/usr/bin/memcached') then exit('/usr/bin/memcached');
end;
//##############################################################################
function  Tsystem.LOCATE_MBMON():string;
begin
if FileExists('/usr/bin/mbmon') then exit('/usr/bin/mbmon');
end;
//##############################################################################
function Tsystem.LOCATE_IPTABLES():string;
begin
if FileExists('/sbin/iptables') then exit('/sbin/iptables');
end;
//##############################################################################
function Tsystem.LOCATE_DSPAM():string;
begin
if FileExists('/usr/local/bin/dspam') then exit('/usr/local/bin/dspam');
if FileExists('/usr/bin/dspam') then exit('/usr/bin/dspam');
end;
//##############################################################################
function Tsystem.LOCATE_NDB_MGMD():string;
begin
if FileExists('/usr/sbin/ndb_mgmd') then exit('/usr/sbin/ndb_mgmd');
if FileExists('/usr/local/bin/ndb_mgmd') then exit('/usr/local/bin/ndb_mgmd');
end;
//##############################################################################
function Tsystem.LOCATE_NDB():string;
begin
if FileExists('/usr/sbin/ndbd') then exit('/usr/sbin/ndbd');
if FileExists('/usr/local/bin/ndbd') then exit('/usr/local/bin/ndbd');
end;
//##############################################################################
function Tsystem.LOCATE_MEMCACHED_VERSION():string;
var
l      :TstringList;
i      :integer;
RegExpr:TRegExpr;
begin

    if not FileExists(LOCATE_MEMCACHED()) then exit;
    fpsystem(LOCATE_MEMCACHED() + ' -h >/opt/artica/tmp/memcached.version 2>&1');
    if not FileExists('/opt/artica/tmp/memcached.version') then exit;
    l:=TstringList.Create;
    l.LoadFromFile('/opt/artica/tmp/memcached.version');
    FILE_DELETE('/opt/artica/tmp/memcached.version');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='memcached\s+([0-9\.]+)';
    for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
             result:=RegExpr.Match[1];
             break;
         end;
    end;

l.free;
RegExpr.free;
end;
//#############################################################################
function Tsystem.Explode(const Separator, S: string; Limit: Integer = 0):TStringDynArray;
var
  SepLen       : Integer;
  F, P         : PChar;
  ALen, Index  : Integer;
begin
  SetLength(Result, 0);
  if (S = '') or (Limit < 0) then Exit;
  if Separator = '' then begin
    SetLength(Result, 1);
    Result[0] := S;
    Exit;
  end;
  SepLen := Length(Separator);
  ALen := Limit;
  SetLength(Result, ALen);
  Index := 0;
  P := PChar(S);
  while P^ <> #0 do begin
    F := P;
    P := StrPos(P, PChar(Separator));
    if (P = nil) or ((Limit > 0) and (Index = Limit - 1)) then P := StrEnd(F);
    if Index >= ALen then begin
      Inc(ALen, 5);
      SetLength(Result, ALen);
    end;
    SetString(Result[Index], F, P - F);
    Inc(Index);
    if P^ <> #0 then Inc(P, SepLen);
  end;
  if Index < ALen then SetLength(Result, Index); // wirkliche Länge festlegen
end;
//#########################################################################################
procedure Tsystem.SET_PHP_INI(KEY:string;VALUE_NAME:string;VALUE:string);
var
   php:TiniFile;
   l  :TstringList;
   test_string:string;
   i:integer;
begin
  l:=Tstringlist.Create;
  l.add('/etc/php.ini');
  l.Add('/etc/php5/cli/php.ini');
  l.Add('/etc/php5/cgi/php.ini');
  l.add('/etc/php5/apache2/php.ini');
  l.add('/etc/php/php.ini');

  for i:=0 to l.Count-1 do begin
      if FileExists(l.Strings[i]) then begin
         CLEAN_PHP_INI(l.Strings[i]);
         test_string:=ReadFileIntoString(l.Strings[i]);
         php:=TiniFile.Create(l.Strings[i]);
         php.WriteString(KEY,VALUE_NAME,VALUE);
         php.UpdateFile;
         php.Free;
      end;
  end;
end;
//#########################################################################################
procedure Tsystem.CLEAN_PHP_INI(path:string);
var

   l  :TstringList;
   new:TstringList;
   test_string:string;
   i:integer;
begin
  if not FileExists(path) then exit;

  new:=TstringList.Create;
  l:=Tstringlist.Create;
  l.LoadFromFile(path);
  for i:=0 to l.Count-1 do begin
      if Copy(l.Strings[i],0,1)=';' then continue;
      new.Add(l.Strings[i]);
  end;

  if new.Count>0 then new.SaveToFile(path);
  new.free;
  l.free;
end;
//#########################################################################################

function Tsystem.GET_PHP_INI(key:string):string;
var
   php:TiniFile;
   php_path:string;
   l  :TstringList;
   test_string:string;
   i:integer;
   phpconf:string;
begin
  l:=Tstringlist.Create;
  l.add('/etc/php.ini');
  l.Add('/etc/php5/cli/php.ini');
  l.Add('/etc/php5/cgi/php.ini');
  l.add('/etc/php5/apache2/php.ini');
  l.add('/etc/php/php.ini');

  for i:=0 to l.Count-1 do begin
      if FileExists(l.Strings[i]) then begin
         php_path:=l.Strings[i];
         break;
      end;
  end;

  l.free;

  if not fileExists(php_path) then begin
     writeln('SYS.GET_PHP_INI() FATAL ERROR UNABLE TO STAT PHP.INI FILE !!!!!!!!!!!!!');
     exit;
  end;


   php:=TiniFile.Create(php_path);
   result:=php.ReadString('PHP',key,'');
   php.free;
end;
//#########################################################################################
function Tsystem.LOCATE_ZIP():string;
begin
if FileExists('/usr/bin/zip') then exit('/usr/bin/zip');
end;
//#########################################################################################
function Tsystem.ip_forward_enabled():boolean;
var
   i,t:integer;
   l:TstringList;
   RegExpr:TRegExpr;
   D:boolean;
   f,s:string;
begin
i:=0;
D:=COMMANDLINE_PARAMETERS('--verbose');
result:=false;

if FileExists('/proc/sys/net/ipv4/ip_forward') then begin
      fpsystem('/bin/cat /proc/sys/net/ipv4/ip_forward >/tmp/ip_forward');
      l:=TstringList.Create;
      if D then writeln('loading /tmp/ip_forward');
      l.LoadFromFile('/tmp/ip_forward');
      RegExpr:=TRegExpr.Create;
      RegExpr.Expression:='([0-9]+)';
      for t:=0 to l.Count-1 do begin
          if RegExpr.Exec(l.Strings[t]) then
                    if D then writeln('found ', RegExpr.Match[1]);
                    if RegExpr.Match[1]='1' then begin
                       RegExpr.Free;
                       l.free;
                       exit(true);
                    end;
          end;
      end;

RegExpr.free;
l.free;
end;
//#########################################################################################
function Tsystem.isMountedTargetPath(path:string):boolean;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   D:boolean;
   Logs:Tlogs;
begin
  Logs:=Tlogs.Create;
  tmpfile:=logs.FILE_TEMP();
  fpsystem('/bin/mount -l >'+tmpfile + ' 2>&1');
  D:=false;
  D:=COMMANDLINE_PARAMETERS('debug');
  if not FileExists(tmpfile) then begin
     if D then logs.Debuglogs('SYS.isMountedTargetPath():: tmpfile "'+tmpfile+'" IS NULL');
     exit;
  end;
  result:=false;
  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^(.+?)on\s+'+path+'\s+';
  for i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        if D then logs.Debuglogs('SYS.isMountedTargetPath():: Found "'+RegExpr.Match[1]+'"');
        result:=true;
        break;
     end;
  end;

  RegExpr.free;
  l.free;

end;
//##############################################################################
function Tsystem.isMounteddev(dev:string):boolean;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   D:boolean;
   Logs:Tlogs;
begin
  Logs:=Tlogs.Create;
  tmpfile:=logs.FILE_TEMP();
  fpsystem('/bin/mount -l >'+tmpfile + ' 2>&1');
  D:=false;
  D:=COMMANDLINE_PARAMETERS('debug');
  if not FileExists(tmpfile) then begin
     if D then logs.Debuglogs('SYS.isMounteddev():: tmpfile "'+tmpfile+'" IS NULL');
     exit;
  end;
  result:=false;
  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^'+dev+'.+?on\s+(.+?)\s+type';
  for i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        if D then logs.Debuglogs('SYS.isMounteddev():: Found "'+RegExpr.Match[1]+'"');
        result:=true;
        break;
     end;
  end;

  RegExpr.free;
  l.free;

end;
//##############################################################################
function Tsystem.GetMountedDev(dev:string):Tstringlist;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   D:boolean;
   Logs:Tlogs;
   z:Tstringlist;
begin

  Logs:=Tlogs.Create;
  tmpfile:=logs.FILE_TEMP();
  fpsystem('/bin/mount -l >'+tmpfile + ' 2>&1');
  D:=false;
  D:=COMMANDLINE_PARAMETERS('debug');
  z:=Tstringlist.Create;
  result:=z;
  if not FileExists(tmpfile) then begin
     if D then logs.Debuglogs('SYS.GetMountedDev():: tmpfile "'+tmpfile+'" IS NULL');
     exit;
  end;

  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='^'+dev+'.+?on\s+(.+?)type';
  for i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        if D then logs.Debuglogs('SYS.GetMountedDev():: Found "'+RegExpr.Match[1]+'"');
        z.Add(trim(RegExpr.Match[1]));
     end;
  end;

  result:=z;
  RegExpr.free;
  l.free;

end;
//##############################################################################
function Tsystem.usbMountPoint(target_uuid:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
   fpath:string;
   fline:string;
   UUID:string;
   Logs:Tlogs;
begin
   Logs:=Tlogs.Create;
   tmpfile:=logs.FILE_TEMP();
   fpsystem(LOCATE_BLKID() + ' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmpfile);
   logs.DeleteFile(tmpfile);

   RegExpr:=TRegExpr.Create;


   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^(.+?):(.+)';
       if RegExpr.Exec(l.Strings[i]) then begin
           fpath:=RegExpr.Match[1];
           fline:=RegExpr.Match[2];
           RegExpr.Expression:='UUID="(.+?)"';
           if RegExpr.Exec(fline) then UUID:=RegExpr.Match[1];
           if target_uuid=UUID then begin
               result:=fpath;
               break;
           end;
       end;


   end;
   l.free;
   RegExpr.free;
end;
//##############################################################################
function Tsystem.usbExtType(target_uuid:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;

   fline:string;
   UUID:string;
   Logs:Tlogs;
begin
   Logs:=Tlogs.Create;
   tmpfile:=logs.FILE_TEMP();
   fpsystem(LOCATE_BLKID() + ' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmpfile);
   logs.DeleteFile(tmpfile);

   RegExpr:=TRegExpr.Create;


   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='^(.+?):(.+)';
       if RegExpr.Exec(l.Strings[i]) then begin
//           fpath:=RegExpr.Match[1];
           fline:=RegExpr.Match[2];
           RegExpr.Expression:='UUID="(.+?)"';
           if RegExpr.Exec(fline) then UUID:=RegExpr.Match[1];
           if target_uuid=UUID then begin
               RegExpr.Expression:='TYPE="(.+?)"';
                if RegExpr.Exec(fline) then result:=RegExpr.Match[1];
                break;
           end;
       end;


   end;
   l.free;
   RegExpr.free;
end;
//##############################################################################
function Tsystem.usbLabel(dev:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
   Logs:Tlogs;
   d:boolean;
begin
   Logs:=Tlogs.Create;
   tmpfile:=logs.FILE_TEMP();
   D:=COMMANDLINE_PARAMETERS('--verbose');
   fpsystem(LOCATE_BLKID() + ' -s LABEL ' + dev +' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmpfile);
   logs.DeleteFile(tmpfile);

   RegExpr:=TRegExpr.Create;


   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='LABEL="(.+?)"';
       if RegExpr.Exec(l.Strings[i]) then begin
          if d then writeln('usbLabel() -> ' + l.Strings[i]);
           result:=RegExpr.Match[1];
                break;
       end;
   end;
   l.free;
   RegExpr.free;
end;
//##############################################################################
function Tsystem.usbType(dev:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   tmpfile:string;
   Logs:Tlogs;
   d:boolean;
begin
   Logs:=Tlogs.Create;
   tmpfile:=logs.FILE_TEMP();
   D:=COMMANDLINE_PARAMETERS('--verbose');
   fpsystem(LOCATE_BLKID() + ' -s TYPE ' + dev +' >'+tmpfile + ' 2>&1');
   if not FileExists(tmpfile) then exit;
   l:=TstringList.Create;
   l.LoadFromFile(tmpfile);
   logs.DeleteFile(tmpfile);

   RegExpr:=TRegExpr.Create;


   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:='TYPE="(.+?)"';
       if RegExpr.Exec(l.Strings[i]) then begin
          if d then writeln('usbType() -> ' + l.Strings[i]);
           result:=RegExpr.Match[1];
                break;
       end;
   end;
   l.free;
   RegExpr.free;
end;
//##############################################################################


procedure Tsystem.usb_change_label(uuid:string;newname:string);
var
   logs:Tlogs;
   ExtType:string;
   mountdev:string;
   l:Tstringlist;
begin
  logs:=Tlogs.Create;
  l:=Tstringlist.Create;
  l.Add('MTOOLS_SKIP_CHECK=1');

  try
  l.SaveToFile('/root/.mtoolsrc');
  except
  logs.Debuglogs('FATAL ERROR WHILE SAVING /root/.mtoolsrc');
  exit;
  end;

  if FileExists('/usr/share/artica-postfix/ressources/usb.scan.inc') then logs.DeleteFile('/usr/share/artica-postfix/ressources/usb.scan.inc');

  ExtType:=usbExtType(uuid);
  mountdev:=usbMountPoint(uuid);

  if length(mountdev)=0 then begin
        logs.Debuglogs('usb_change_label:: mount dev is null, aborting...');
        exit;
  end;

  logs.Debuglogs('usb_change_label:: ' + uuid+': ext '+ExtType + ' dev=' +mountdev);
  logs.OutputCmd('umount ' + mountdev);

  if ExtType='vfat' then begin
     if FileExists('/usr/bin/mlabel') then logs.OutputCmd('/usr/bin/mlabel -i '+mountdev+' ::'+newname);
  end;

  if ExtType='msdos' then begin
     if FileExists('/usr/bin/mlabel') then logs.OutputCmd('/usr/bin/mlabel -i '+mountdev+' ::'+newname);
  end;


  if ExtType='ext2' then begin
     if FileExists('/sbin/e2label') then logs.OutputCmd('/sbin/e2label '+mountdev+' '+newname);
  end;

  if ExtType='ext3' then begin
     if FileExists('/sbin/e2label') then logs.OutputCmd('/sbin/e2label '+mountdev+' '+newname);
  end;
   sleep(2000);
  logs.Debuglogs('exit.....');
end;
//##############################################################################�
procedure Tsystem.usb_change_disk_label(dev:string;newname:string);
var
   logs:Tlogs;
   ExtType:string;
   l:Tstringlist;
begin
  logs:=Tlogs.Create;
  l:=Tstringlist.Create;
  l.Add('MTOOLS_SKIP_CHECK=1');

  try
  l.SaveToFile('/root/.mtoolsrc');
  except
  logs.Debuglogs('FATAL ERROR WHILE SAVING /root/.mtoolsrc');
  exit;
  end;

  if FileExists('/usr/share/artica-postfix/ressources/usb.scan.inc') then logs.DeleteFile('/usr/share/artica-postfix/ressources/usb.scan.inc');

  ExtType:=usbType(dev);

  logs.Debuglogs('usb_change_label:: ' + dev+': ext '+ExtType);
  logs.Debuglogs('usb_change_label:: New label "' + newname+'"');


  if ExtType='vfat' then begin
     logs.Debuglogs('usb_change_label:: using mlabel');
     if FileExists('/usr/bin/mlabel') then logs.OutputCmd('/usr/bin/mlabel -i '+dev+' ::'+newname);
  end;

  if ExtType='msdos' then begin
     logs.Debuglogs('usb_change_label:: using mlabel');
     if FileExists('/usr/bin/mlabel') then logs.OutputCmd('/usr/bin/mlabel -i '+dev+' ::'+newname);
  end;


  if ExtType='ext2' then begin
     logs.Debuglogs('usb_change_label:: using e2label');
     if FileExists('/sbin/e2label') then logs.OutputCmd('/sbin/e2label '+dev+' '+newname);
  end;

  if ExtType='ext3' then begin
      logs.Debuglogs('usb_change_label:: using e2label');
     if FileExists('/sbin/e2label') then logs.OutputCmd('/sbin/e2label '+dev+' '+newname);
  end;

  if ExtType='ext4' then begin
      logs.Debuglogs('usb_change_label:: using e2label');
     if FileExists('/sbin/e2label') then logs.OutputCmd('/sbin/e2label '+dev+' '+newname);
  end;
   sleep(2000);
  logs.Debuglogs('exit.....');
end;
//##############################################################################�
 function Tsystem.disk_build_unique_partition(dev:string;disk_label:string):string;
var
   logs:Tlogs;
   l:Tstringlist;
   lo:TstringList;
   tmpstr:string;
   devtest:string;
   cmd_format:string;
   ext:string;

begin

  disk_label:=AnsiReplaceText(disk_label,' ','_');
  devtest:=dev+'1';
  if usb_mount_point(devtest)='/' then exit('Warning this is the master disk !!!');

   if disk_fstab_target_already_set('/media/'+disk_label) then begin
      exit('{warning_label_already_set}');
   end;

  logs:=Tlogs.Create;
  l:=Tstringlist.Create;
  lo:=Tstringlist.Create;
  l.Add(',,L');
  tmpstr:=logs.FILE_TEMP();
  if FileExists('/tmp/sfdisk.txt') then logs.DeleteFile('/tmp/sfdisk.txt');
  l.SaveToFile('/tmp/sfdisk.txt');
  fpsystem('dd if=/dev/zero of='+dev+' bs=512 count=1');
  fpsystem('sfdisk -f '+dev+' </tmp/sfdisk.txt >'+tmpstr + ' 2>&1');
  lo.Add(logs.ReadFromFile(tmpstr));
  logs.DeleteFile(tmpstr);
  if FileExists('/sbin/mkfs.ext4') then begin
        cmd_format:='/sbin/mkfs.ext4 -Tlargefile4 '+devtest +' >'+tmpstr+' 2>&1';
        ext:='ext4';
  end;

  if FileExists('/sbin/mkfs.ext3') then begin
     cmd_format:='/sbin/mkfs.ext3 -b 4096 '+devtest +' >'+tmpstr+' 2>&1';
     ext:='ext3';
  end;

  if length(cmd_format)=0 then exit('Unable to stat mkfs.*');


  fpsystem(cmd_format);
  lo.Add(logs.ReadFromFile(tmpstr));
  logs.DeleteFile(tmpstr);
  usb_change_disk_label(devtest,disk_label);
  lo.Add('Change fstab to include new media');
  lo.Add(disk_change_fstab(devtest,ext,'/media/'+disk_label));
  fpsystem('mount '+devtest +'>'+tmpstr + ' 2>&1');
  lo.Add(logs.ReadFromFile(tmpstr));
  logs.DeleteFile(tmpstr);
  result:=lo.Text;
  lo.free;
  l.free;
end;
//##############################################################################
function Tsystem.disk_change_fstab(dev:string;ext:string;target:string):string;
var
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   devExp:string;
   found:Boolean;
   line:string;
begin
   found:=false;
   if not FileExists('/etc/fstab') then exit;

   line:=dev+'    '+target+'                 '+ext+'    rw,relatime,errors=remount-ro,user_xattr,acl  0    1';
   l:=Tstringlist.Create;
   l.LoadFromFile('/etc/fstab');
   devExp:=AnsiReplaceText(dev,'/','\/');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:=devExp+'\s+';
   ForceDirectories(target);
   for i:=0 to l.Count-1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
          found:=true;
          l.Strings[i]:=line;
          break;
      end;

    end;

   if not found then l.Add(line);
   try
   l.SaveToFile('/etc/fstab');
   except
   result:='disk_change_fstab:: fatal error while saving /etc/fstab';
   exit();
   end;
   l.free;
   RegExpr.free;


end;
//##############################################################################
function Tsystem.disk_fstab_target_already_set(target:string):boolean;
var

   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   devExp:string;
begin
 if not FileExists('/etc/fstab') then exit;
   result:=false;
   l:=Tstringlist.Create;
   l.LoadFromFile('/etc/fstab');
   devExp:=AnsiReplaceText(target,'/','\/');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:='^.+\s+'+devExp+'\s+';

   for i:=0 to l.Count-1 do begin
      if RegExpr.Exec(l.Strings[i]) then begin
          result:=true;
          break;
      end;
    end;

   l.free;
   RegExpr.free;

end;
//##############################################################################


function Tsystem.usb_mount_point(path:string):string;
var
   tmpfile:string;
   l:TstringList;
   i:integer;
   RegExpr:TRegExpr;
   logs:Tlogs;
begin

logs:=Tlogs.Create;
tmpfile:=logs.FILE_TEMP();
  fpsystem('/bin/mount -l >'+tmpfile + ' 2>&1');
  if not FileExists(tmpfile) then exit;

  l:=TstringList.Create;
  l.LoadFromFile(tmpfile);
  logs.DeleteFile(tmpfile);
  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:=path+'\s+on\s+(.+?)\s+type';
  for i:=0 to l.Count-1 do begin
     if RegExpr.Exec(l.Strings[i]) then begin
        result:=trim(RegExpr.Match[1]);
        break;
     end;
  end;

  RegExpr.free;
  l.free;

end;
//##############################################################################
function Tsystem.ExecPipe(commandline:string):string;
const
  READ_BYTES = 2048;
  CR = #$0d;
  LF = #$0a;
  CRLF = CR + LF;

var
  S: TStringList;
  M: TMemoryStream;
  P: TProcess;
  n: LongInt;
  BytesRead: LongInt;
  xRes:string;

begin
  if length(trim(commandline))=0 then exit;
  M := TMemoryStream.Create;
  xRes:='';
  BytesRead := 0;
  P := TProcess.Create(nil);
  P.CommandLine := commandline;
  P.Options := [poUsePipes];
  P.Execute;
  while P.Running do begin
    M.SetSize(BytesRead + READ_BYTES);
    n := P.Output.Read((M.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
    end
    else begin
      Sleep(100);
    end;

  end;

  repeat
    M.SetSize(BytesRead + READ_BYTES);
    n := P.Output.Read((M.Memory + BytesRead)^, READ_BYTES);
    if n > 0 then begin
      Inc(BytesRead, n);
    end;
  until n <= 0;
  M.SetSize(BytesRead);
  S := TStringList.Create;
  S.LoadFromStream(M);
  for n := 0 to S.Count - 1 do
  begin
    if length(S[n])>1 then begin

      xRes:=xRes + S[n] +CRLF;
    end;
  end;
  S.Free;
  P.Free;
  M.Free;
  exit( xRes);
end;
//##############################################################################
function Tsystem.LOCATE_BRCTL():string;
begin
if FileExists('/usr/sbin/brctl') then exit('/usr/sbin/brctl');
if FileExists('/sbin/brctl') then exit('/sbin/brctl');
end;
//##############################################################################
function Tsystem.NIC_LIST_ROUTES(eth:string):TstringList;
var
   l:Tstringlist;
   RegExpr:TRegExpr;
   logs:Tlogs;
   tmpstr:string;
   res:Tstringlist;
   i:integer;
   gateway:string;
begin
logs:=Tlogs.Create;
 res:=Tstringlist.Create;
tmpstr:=logs.FILE_TEMP();
RegExpr:=TRegExpr.Create;
fpsystem('/sbin/route -n >' +tmpstr+' 2>&1');
l:=tstringlist.Create;
l.LoadFromFile(tmpstr);
logs.DeleteFile(tmpstr);
for i:=0 to l.count-1 do begin
     RegExpr.Expression:='([0-9\.]+)\s+([0-9\.]+)\s+([0-9\.]+)\s+([A-Z]+)\s+.+?'+eth;
     if RegExpr.Exec(l.Strings[i]) then begin
        if RegExpr.Match[2]<>'0.0.0.0' then gateway:=RegExpr.Match[2];
        if RegExpr.Match[1]<>'0.0.0.0' then res.Add('NET='+RegExpr.Match[1]+chr(9)+'MASK='+RegExpr.Match[3]);
     end;
end;
   if length(gateway)>0 then res.Add('GAYTEWAY='+gateway);
   result:=res;
end;
//##############################################################################
procedure Tsystem.THREAD_COMMAND_SET(zcommands:string);
var
   FileDataCommand:TstringList;
   md5command,mdtmp:string;
   logs:Tlogs;
   Add:boolean;
   i:integer;
begin
  if Not FileExists('/usr/share/artica-postfix/bin/artica-install') then exit;
  logs:=Tlogs.Create;
  md5command:=logs.MD5FromString(trim(zcommands));
  fpsystem('/etc/init.d/artica-postfix start daemon >/dev/null 2>&1');
  Add:=true;
  FileDataCommand:=TstringList.Create;
  if fileExists('/etc/artica-postfix/background') then begin
     try
        FileDataCommand.LoadFromFile('/etc/artica-postfix/background');
     except
        logs.Syslogs(' Tsystem.THREAD_COMMAND_SET:: WARNING, UNABLE TO load /etc/artica-postfix/background');
        exit;
     end;

     for i:=0 to FileDataCommand.Count-1 do begin
          mdtmp:=logs.MD5FromString(trim(FileDataCommand.Strings[i]));
          if mdtmp=md5command then begin
                logs.Debuglogs('Tsystem.THREAD_COMMAND_SET:: "' + zcommands+'" already ordered');
                Add:=false;
                break;
          end;
     end;
  end;


  if Add then begin
     FileDataCommand.Add(zcommands);
     logs.Debuglogs('MyConf.THREAD_COMMAND_SET:: save ' + zcommands);
     try
        FileDataCommand.SaveToFile('/etc/artica-postfix/background');
     except
       logs.Syslogs(' Tsystem.THREAD_COMMAND_SET:: WARNING, UNABLE TO SAVE /etc/artica-postfix/background');
       exit;
     end;
  end;

  FileDataCommand.Free;
  logs.Debuglogs(' Tsystem.THREAD_COMMAND_SET:: done...');
end;
//##############################################################################
function Tsystem.APP_UNZIP_VERSION():string;

  var
   RegExpr:TRegExpr;
   tmpstr:string;
   l:TstringList;
   i:integer;
   path:string;
begin
path:='/usr/bin/unzip';
     if not FileExists(path) then begin
        exit;
     end;

   result:=GET_CACHE_VERSION('APP_UNZIP');
   if length(result)>0 then exit;

   tmpstr:='/tmp/unzip.version';
   fpsystem(path+' -V >'+tmpstr+' 2>&1');


     l:=TstringList.Create;
     RegExpr:=TRegExpr.Create;
     l.LoadFromFile(tmpstr);

     for i:=0 to l.Count-1 do begin
         RegExpr.Expression:='^UnZip\s+([0-9\.]+)\s+';
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1];
            break;
         end;
         RegExpr.Expression:=', version\s+([0-9\.]+)\s+';
         if RegExpr.Exec(l.Strings[i]) then begin
            result:=RegExpr.Match[1];
            if result='3.95' then result:='6.0';
            break;
         end;

     end;
l.Free;
RegExpr.free;
SET_CACHE_VERSION('APP_UNZIP',result);

end;



//#############################################################################
function Tsystem.FileMaskSize(const mask: string): longint;
var
  sr: tsearchrec;
  rc: integer;
begin
  result:= 0;
  rc:=SysUtils.FindFirst(mask,faAnyFile,sr);
  while rc=0 do begin
    inc(result,sr.size);
    rc:= SysUtils.FindNext(sr);
  end;
  SysUtils.FindClose(sr);
end;

function Tsystem.DirectorySize(const dir: string): longint;
begin
  result:= FileMaskSize(dir+'/'+WildCard);
end;
//#############################################################################
function Tsystem.ETC_SERVICES_PORT(servicename:string):integer;
var
 l:Tstringlist;
 RegExpr:TRegExpr;
 i:integer;
begin
    result:=0;
    if not FileExists('/etc/services') then exit;
    l:=Tstringlist.Create;
    l.LoadFromFile('/etc/services');
    RegExpr:=TRegExpr.Create;
    RegExpr.Expression:='^'+servicename+'\s+([0-9]+)\/tcp';
    for i:=0 to l.Count-1 do begin
         if RegExpr.Exec(l.Strings[i]) then begin
            TryStrToInt(RegExpr.Match[1],result);
            break;
         end;
    end;

end;
//#############################################################################


function Tsystem.GetRemoteCOmputerRessources(computername:string;username:string;password:string):string;
var
 l:Tstringlist;
 tmpstr:string;
 zlogs:Tlogs;
 RegExpr:TRegExpr;
 r:Tstringlist;
 i:integer;
 cmd:string;
begin
  zlogs:=Tlogs.Create;

  if username='nil' then username:='';
  if password='nil' then password:='';

  zlogs.Debuglogs('Find ressources for "'+computername+'"');
  tmpstr:=zlogs.FILE_TEMP();
  l:=Tstringlist.Create;
  r:=Tstringlist.Create;
  RegExpr:=TRegExpr.Create;
  if FileExists(LOCATE_SHOWMOUNT()) then begin

     cmd:=LOCATE_SHOWMOUNT()+' -e '+computername+' --no-headers >'+tmpstr+' 2>&1';
     zlogs.Debuglogs(cmd);
     fpsystem(cmd);
     l.LoadFromFile(tmpstr);
     for i:=0 to l.Count-1 do begin
         RegExpr.Expression:='can''t get address for';
         if RegExpr.Exec(l.Strings[i]) then break;

         RegExpr.Expression:='Timed out';
         if RegExpr.Exec(l.Strings[i]) then break;

         RegExpr.Expression:='^(.+?)\s+';
         if RegExpr.Exec(l.Strings[i]) then begin
             zlogs.Debuglogs('GetRemoteCOmputerRessources:: About "'+l.Strings[i]+'" -> '+RegExpr.Match[1]);
             r.Add('NFS;'+RegExpr.Match[1]);
         end;
     end;
  end;




  cmd:='';
  if FileExists(LOCATE_SMBCLIENT()) then begin
     l.Clear;
     if length(username)>0 then begin
        if length(password)>0 then begin
          cmd:=LOCATE_SMBCLIENT()+' -L '+computername+' -U '+username+'%'+password+' -g --timeout=1 >'+tmpstr+' 2>&1';
        end;
     end;
     if length(cmd)=0 then cmd:=LOCATE_SMBCLIENT()+' -L '+computername+' -N -g --timeout=1 >'+tmpstr+' 2>&1';
     zlogs.Debuglogs(cmd);
     fpsystem(cmd);
     l.LoadFromFile(tmpstr);
     RegExpr.Expression:='^Disk\|(.+?)\|';
     for i:=0 to l.Count-1 do begin
         zlogs.Debuglogs('GetRemoteCOmputerRessources:: About "'+l.Strings[i]+'"');
         if RegExpr.Exec(l.Strings[i]) then begin
            r.Add('SMB;'+RegExpr.Match[1]);
         end;
     end;
  end else begin


  end;

zlogs.DeleteFile(tmpstr);
result:=r.Text;
l.free;
r.free;
RegExpr.free;
 zlogs.Debuglogs('Find ressources for "'+computername+'" done...');
 zlogs.free;
end;
//#############################################################################

procedure Tsystem.FSTAB_ADD(dev:string;mount_point:string);
var
   l:Tstringlist;
   RegExpr:TRegExpr;
   devstring:string;
   mountstring:string;
   i:integer;
   zlogs:Tlogs;
   f:boolean;
   cmd:string;
begin
   if not FileExists('/etc/fstab') then exit;
   devstring:=AnsiReplaceText(dev,'/','\/');
   devstring:=AnsiReplaceText(dev,'.','\.');
   mountstring:=AnsiReplaceText(mount_point,'/','\/');
   mountstring:=AnsiReplaceText(mount_point,'.','\.');
   l:=Tstringlist.Create;
   zlogs:=Tlogs.Create;
   l.LoadFromFile('/etc/fstab');
   zlogs.Debuglogs('Tsystem.FSTAB_ADD found "'+devstring+'" AND "'+mountstring+'" in '+IntToStr(l.Count)+' lines');

   f:=false;
   RegExpr:=TRegExpr.Create;
   for i:=0 to l.Count-1 do begin
       RegExpr.Expression:=devstring;
       if RegExpr.Exec(l.Strings[i]) then begin
           zlogs.Debuglogs('Tsystem.FSTAB_ADD found "'+dev+'" line '+ IntToStr(i));
           RegExpr.Expression:=mountstring;
           if RegExpr.Exec(l.Strings[i]) then begin
              zlogs.Debuglogs('Tsystem.FSTAB_ADD found "'+mount_point+'" line '+ IntToStr(i));
              f:=true;
              break;
           end;
       end;
   end;


  if not f then begin
     cmd:=dev+chr(9)+mount_point+chr(9)+'auto'+chr(9)+'defaults'+chr(9)+'0'+chr(9)+'0';
     l.Add(cmd);
     zlogs.Debuglogs('Tsystem.FSTAB_ADD Add "'+cmd+'"');
     zlogs.WriteToFile(l.Text, '/etc/fstab');
  end;

   zlogs.Debuglogs('Tsystem.FSTAB_ADD END...');
end;
//#############################################################################
function Tsystem.ArrayAlreadyUsed(arrayS:Tstringlist;pattern:string):boolean;
var
   i:integer;
begin
     result:=false;
     for i:=0 to arrayS.Count-1 do begin
          if  arrayS.Strings[i]=pattern then exit(true);
     end;
end;
//#############################################################################
procedure Tsystem.etc_ld_so_conf(path:string);
var
   l:Tstringlist;
   RegExpr:TRegExpr;
   devstring:string;
   i:integer;
   etc_ld_so_conf_logs:Tlogs;
   f:boolean;
begin
   f:=false;
   devstring:=path;
   devstring:=AnsiReplaceText(path,'/','\/');
   devstring:=AnsiReplaceText(devstring,'.','\.');
   if not FileExists('/etc/ld.so.conf') then exit;
   l:=Tstringlist.Create;
   l.LoadFromFile('/etc/ld.so.conf');
   RegExpr:=TRegExpr.Create;
   RegExpr.Expression:=devstring;
   etc_ld_so_conf_logs:=tlogs.Create;
   for i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          etc_ld_so_conf_logs.Debuglogs('Find '+devstring+ ' line '+IntTostr(i) );
          f:=true;
          break;
       end;
   end;

   if not f then begin
      l.Add(path);
      etc_ld_so_conf_logs.Debuglogs('writing file /etc/ld.so.conf for path '+path);
      etc_ld_so_conf_logs.WriteToFile(l.Text,'/etc/ld.so.conf');
   end;
   etc_ld_so_conf_logs.free;
   RegExpr.free;
   l.free;


end;

//#############################################################################
function Tsystem.locate_roundcube_main_folder():string;
begin
if FileExists('/usr/share/roundcubemail/index.php') then exit('/usr/share/roundcubemail');
if FileExists('/usr/share/roundcube/index.php') then exit('/usr/share/roundcube');
if FileExists('/var/lib/roundcube/index.php') then exit('/var/lib/roundcube');
end;
//##############################################################################
function Tsystem.LIGHTTPD_GET_USER():string;
var
     l:TstringList;
     RegExpr:TRegExpr;
     i:integer;
     user,group:string;
begin

  user:=GET_INFO('LighttpdUserAndGroup');
  if length(user)>0 then begin
     result:=user;
     exit(user);
  end;

  if not FileExists(LIGHTTPD_CONF_PATH()) then exit;
  l:=TstringList.Create;
  RegExpr:=TRegExpr.Create;
  l.LoadFromFile(LIGHTTPD_CONF_PATH());
  for i:=0 to l.Count-1 do begin
    RegExpr.Expression:='^server\.username.+?"(.+?)"';
    if RegExpr.Exec(l.Strings[i]) then user:=RegExpr.Match[1];
    RegExpr.Expression:='^server\.groupname.+?"(.+?)"';
    if RegExpr.Exec(l.Strings[i]) then group:=RegExpr.Match[1];
  end;
  if length(user)>0 then result:=user+':'+group;
  set_INFO('LighttpdUserAndGroup',result);
  RegExpr.free;
  l.free;
end;
//##############################################################################
function Tsystem.LIGHTTPD_CONF_PATH:string;
begin
  if FileExists('/etc/lighttpd/lighttpd.conf') then exit('/etc/lighttpd/lighttpd.conf');
  if FileExists('/etc/lighttpd/lighttpd.conf') then exit('/etc/lighttpd/lighttpd.conf');
  if FileExists('/opt/artica/conf/lighttpd.conf') then exit('/opt/artica/conf/lighttpd.conf');
  if FileExists('/usr/local/etc/lighttpd.conf') then exit('/usr/local/etc/lighttpd.conf');
end;
//##############################################################################
function Tsystem.LIGHTTPD_LISTEN_PORT():string;
var
RegExpr:TRegExpr;
l:TStringList;
i:integer;
begin
if not FileExists(LIGHTTPD_CONF_PATH()) then exit;
l:=TstringList.Create;
l.LoadFromFile(LIGHTTPD_CONF_PATH());
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='^server\.port.+?=.+?([0-9]+)';
for i:=0 to l.Count-1 do begin

   if RegExpr.Exec(l.Strings[i]) then begin
   result:=RegExpr.Match[1];
   break;
   end;
end;

   RegExpr.Free;
   l.free;

end;
//##############################################################################
function Tsystem.WIRELESS_CARD():string;
var
RegExpr:TRegExpr;
l:TStringList;
i:integer;
begin
if not FileExists('/proc/net/wireless') then exit;
l:=TstringList.Create;
l.LoadFromFile('/proc/net/wireless');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='(.+?):\s+([0-9]+)';
for i:=0 to l.Count-1 do begin

   if RegExpr.Exec(l.Strings[i]) then begin
   result:=trim(RegExpr.Match[1]);
   break;
   end;
end;

   RegExpr.Free;
   l.free;

end;
//##############################################################################
function Tsystem.ArchStruct():integer;
var
   tmpstr,data:string;
   RegExpr:TRegExpr;
   ArchStructLogs:Tlogs;
begin
tmpstr:=FILE_TEMP();
ArchStructLogs:=Tlogs.Create;
fpsystem(LOCATE_GENERIC_BIN('uname')+ ' -m >'+tmpstr +' 2>&1');
data:=trim(ArchStructLogs.ReadFromFile(tmpstr));
ArchStructLogs.free;
fpsystem('/bin/rm '+tmpstr+' >/dev/null 2>&1');
RegExpr:=TRegExpr.Create;
RegExpr.Expression:='i[0-9]86';
if RegExpr.Exec(data) then begin
   RegExpr.free;
   result:=32;
   exit;
end;

RegExpr.Expression:='x86_64';

if RegExpr.Exec(data) then begin
   RegExpr.free;
   result:=64;
   exit;
end;
end;
//##############################################################################
function Tsystem.CHECK_PERL_MODULES_VER(ModulesToCheck:string):string;
var
   cmd:string;
   l:TstringList;
   RegExpr:TRegExpr;
   tmpstr:string;
begin
result:='';
tmpstr:=FILE_TEMP();
if not FileExists(LOCATE_PERL_BIN()) then exit;
cmd:=LOCATE_PERL_BIN()+' -M'+ModulesToCheck+' -e ''print "$'+ModulesToCheck+'::VERSION\n"''';
fpsystem(cmd + ' >'+tmpstr+' 2>&1');
 l:=TstringList.Create;
 RegExpr:=TRegExpr.Create;
 if not FileExists(tmpstr) then exit;
 l.LoadFromFile(tmpstr);
 fpsystem('/bin/rm -f '+tmpstr);
 RegExpr.Expression:='([0-9\.]+)';
 if RegExpr.Exec(l.Strings[0]) then begin
    if trim(RegExpr.Match[1])='.' then begin
          writeln('Failed to check ' + ModulesToCheck);
          result:='';
          exit;
    end;
    result:=RegExpr.Match[1];
 end else begin

 end;
 L.free;
 RegExpr.Free;
end;

//##############################################################################
function Tsystem.PEAR_MODULES():string;
var
   cmd:string;
   i:integer;
   l:TstringList;
   RegExpr:TRegExpr;
   tmpstr,pear_bin:string;
begin
   pear_bin:=LOCATE_GENERIC_BIN('pear');
   if not FileExists(pear_bin) then exit;
   tmpstr:=FILE_TEMP();
   fpsystem(pear_bin +' list >'+tmpstr+' 2>&1');
   l:=TstringList.Create;
   RegExpr:=TRegExpr.Create;
   if not FileExists(tmpstr) then exit;
   l.LoadFromFile(tmpstr);
   fpsystem('/bin/rm -f '+tmpstr);
   RegExpr.Expression:='(.+?)\s+[0-9\.]+\s+[a-zA-Z]+';
   For i:=0 to l.Count-1 do begin
       if RegExpr.Exec(l.Strings[i]) then begin
          result:=result+trim(RegExpr.Match[1])+';'
       end;

   end;

    RegExpr.free;
    l.free;
end;
//##############################################################################
function Tsystem.LOCATE_AWSTATS_BIN_PATH():string;
begin
if FileExists('/usr/local/awstats/cgi-bin/awstats.pl') then exit('/usr/local/awstats/cgi-bin/awstats.pl');
if FileExists('/usr/local/awstats/wwwroot/cgi-bin/awstats.pl') then exit('/usr/local/awstats/wwwroot/cgi-bin/awstats.pl');
if FileExists('/usr/lib/cgi-bin/awstats.pl') then exit('/usr/lib/cgi-bin/awstats.pl');
if FileExists('/usr/share/awstats/wwwroot/cgi-bin/awstats.pl') then exit('/usr/share/awstats/wwwroot/cgi-bin/awstats.pl');
if FileExists('/opt/artica/awstats/wwwroot/cgi-bin/awstats.pl') then exit('/opt/artica/awstats/wwwroot/cgi-bin/awstats.pl');
if FileExists('/srv/www/cgi-bin/awstats.pl') then exit('/srv/www/cgi-bin/awstats.pl');
if FileExists('/var/www/awstats/awstats.pl') then exit('/var/www/awstats/awstats.pl');
if FileExists('/usr/share/awstats/wwwroot/cgi-bin/awstats.pl') then exit('/usr/share/awstats/wwwroot/cgi-bin/awstats.pl');
if FileExists('/root/awstats-6.3/wwwroot/cgi-bin/awstats.pl') then exit('/root/awstats-6.3/wwwroot/cgi-bin/awstats.pl');
if FileExists('/home/apache/cgi-bin/awstats.pl') then exit('/home/apache/cgi-bin/awstats.pl');
if FileExists('/srv/www/cgi-bin/awstats/awstats.pl') then exit('/srv/www/cgi-bin/awstats/awstats.pl');
end;
//#############################################################################
function Tsystem.LOCATE_POSTSCREEN():string;
begin
if FileExists('/usr/libexec/postfix/postscreen') then exit('/usr/libexec/postfix/postscreen');
if FileExists('/usr/lib/postfix/postscreen') then exit('/usr/lib/postfix/postscreen');
if FIleExists('/usr/sbin/postscreen') then exit('/usr/sbin/postscreen');

end;
//#############################################################################
function Tsystem.LINUX_DISTRIBUTION():string;
var
   RegExpr:TRegExpr;
   FileTMP:TstringList;
   Filedatas:TstringList;
   i:integer;
   distri_name,distri_ver,distri_provider:string;
   D:boolean;
begin
  D:=COMMANDLINE_PARAMETERS('debug');
  if length(GET_INFO('LinuxDistribution'))>0 then begin
     exit(GET_INFO('LinuxDistribution'));
  end;

  RegExpr:=TRegExpr.Create;
  if FileExists('/etc/lsb-release') then begin
      if not FileExists('/etc/redhat-release') then begin
             if D then Writeln('/etc/lsb-release detected (not /etc/redhat-release detected)');
             fpsystem('/bin/cp /etc/lsb-release /opt/artica/logs/lsb-release');
             FileTMP:=TstringList.Create;
             FileTMP.LoadFromFile('/opt/artica/logs/lsb-release');
             for i:=0 to  FileTMP.Count-1 do begin
                 RegExpr.Expression:='DISTRIB_ID=(.+)';
                 if RegExpr.Exec(FileTMP.Strings[i]) then distri_provider:=trim(RegExpr.Match[1]);
                 RegExpr.Expression:='DISTRIB_RELEASE=([0-9\.]+)';
                 if RegExpr.Exec(FileTMP.Strings[i]) then distri_ver:=trim(RegExpr.Match[1]);
                 RegExpr.Expression:='DISTRIB_CODENAME=(.+)';
                 if RegExpr.Exec(FileTMP.Strings[i]) then distri_name:=trim(RegExpr.Match[1]);
             end;

             result:=distri_provider + ' ' +  distri_ver + ' ' +  distri_name;
             set_INFOS('LinuxDistribution',result);
             RegExpr.Free;
             FileTMP.Free;
             exit();
      end;
  end;
  Filedatas:=TstringList.Create;
  if FileExists('/etc/debian_version') then begin
       if D then Writeln('/etc/debian_version detected');
       Filedatas:=TstringList.Create;
       Filedatas.LoadFromFile('/etc/debian_version');
       RegExpr.Expression:='([0-9\.]+)';
       if RegExpr.Exec(Filedatas.Strings[0]) then begin
          Set_infos('LinuxDistribution','Debian ' + RegExpr.Match[1] +' Gnu-linux');
          result:='Debian ' + RegExpr.Match[1] +' Gnu-linux';
          RegExpr.Free;
          Filedatas.Free;
          exit();
       end;
  end;
  //Fedora
  if FileExists('/etc/redhat-release') then begin
     Filedatas:=TstringList.Create;
    try Filedatas.LoadFromFile('/etc/redhat-release') except writeln('/etc/redhat-release: FATAL error line 8305');exit; end;

     if D then Writeln('/etc/redhat-release detected -> ' + Filedatas.Strings[0]);

     RegExpr.Expression:='Fedora Core release\s+([0-9]+)';
     if RegExpr.Exec(Filedatas.Strings[0]) then begin
          Set_infos('LinuxDistribution','Fedora Core release ' + RegExpr.Match[1]);
          result:='Fedora Core release ' + RegExpr.Match[1];
          RegExpr.Free;
          Filedatas.Free;
          exit();
       end;
      RegExpr.Expression:='Fedora release\s+([0-9]+)';
      if RegExpr.Exec(Filedatas.Strings[0]) then begin
         Set_infos('LinuxDistribution','Fedora release ' + RegExpr.Match[1]);
         result:='Fedora release ' + RegExpr.Match[1];
         RegExpr.Free;
         Filedatas.Free;
         exit();
      end;

      //Mandriva
      RegExpr.Expression:='Mandriva Linux release\s+([0-9]+)';
      if RegExpr.Exec(Filedatas.Strings[0]) then begin
         Set_infos('LinuxDistribution','Mandriva Linux release ' + RegExpr.Match[1]);
         result:='Mandriva Linux release ' + RegExpr.Match[1];
         RegExpr.Free;
         Filedatas.Free;
         exit();
      end;
      //CentOS
      RegExpr.Expression:='CentOS release\s+([0-9]+)';
      if RegExpr.Exec(Filedatas.Strings[0]) then begin
         result:='CentOS release ' + RegExpr.Match[1];
         Set_infos('LinuxDistribution',result);
         RegExpr.Free;
         Filedatas.Free;
         exit();
      end;

    end;

   //Suse
   if FileExists('/etc/SuSE-release') then begin
       Filedatas:=TstringList.Create;
       Filedatas.LoadFromFile('/etc/SuSE-release');
       result:=trim(Filedatas.Strings[0]);
       Set_infos('LinuxDistribution',result);
       Filedatas.Free;
       exit;
   end;



end;
//##############################################################################
function Tsystem.DISTRIBUTION_CODE():string;
var distri:string;
  RegExpr:TRegExpr;
  D:boolean;
  DISTRINAME_CODE:string;
  DISTRINAME_VERSION:string;
  DISTRI_MAJOR:integer;
  DISTRI_MINOR:integer;
begin
  D:=COMMANDLINE_PARAMETERS('--verbose');
  distri:=LINUX_DISTRIBUTION();



  RegExpr:=TRegExpr.Create;
  RegExpr.Expression:='Ubuntu';
  if RegExpr.Exec(distri) then begin
     result:='UBUNTU';
     RegExpr.Expression:='\s+([0-9]+)\.([0-9]+)';
     if RegExpr.Exec(distri) then begin
        DISTRINAME_VERSION:=RegExpr.Match[1];
        TryStrtoInt(RegExpr.Match[1],DISTRI_MAJOR);
        TryStrtoInt(RegExpr.Match[2],DISTRI_MINOR);
        exit;
     end;

     RegExpr.Expression:='\s+([0-9]+)';
     if RegExpr.Exec(distri) then begin
        DISTRINAME_VERSION:=RegExpr.Match[1];
        TryStrtoInt(RegExpr.Match[1],DISTRI_MAJOR);
        DISTRI_MINOR:=0;
        exit;
     end;

  end;

  RegExpr.Expression:='SUSE.+?Enterprise';
  if RegExpr.Exec(distri) then begin
     result:='SUSE';
     exit;
  end;

  RegExpr.Expression:='ArchLinux';
  if RegExpr.Exec(distri) then begin
     result:='ARCHLINUX';
     exit;
  end;



  RegExpr.Expression:='openSUSE';
  if RegExpr.Exec(distri) then begin
     result:='SUSE';
     exit;
  end;

  RegExpr.Expression:='Fedora';
  if RegExpr.Exec(distri) then begin
     result:='FEDORA';
     RegExpr.Expression:='release\s+([0-9]+)';
     if RegExpr.Exec(distri) then DISTRINAME_VERSION:=RegExpr.Match[1];
     exit;
     exit;
  end;

  RegExpr.Expression:='Debian';
  if RegExpr.Exec(distri) then begin
     result:='DEBIAN';
     RegExpr.Expression:='Debian\s+([0-9]+)';
     if RegExpr.Exec(distri) then begin
        DISTRINAME_VERSION:=RegExpr.Match[1];
        RegExpr.Expression:='Debian\s+([0-9]+)\.([0-9]+)';
        if RegExpr.Exec(distri) then begin
             TryStrtoInt(RegExpr.Match[1],DISTRI_MAJOR);
             TryStrtoInt(RegExpr.Match[2],DISTRI_MINOR);
        end;
     end;
     exit;
  end;

  RegExpr.Expression:='CentOS';
  if RegExpr.Exec(distri) then begin
     result:='CENTOS';
     exit;
  end;

  RegExpr.Expression:='Mandriva';
  if RegExpr.Exec(distri) then begin
     result:='MANDRAKE';
     exit;
  end;

end;
end.

