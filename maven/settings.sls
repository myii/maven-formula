{% set p  = salt['pillar.get']('maven', {}) %}
{% set g  = salt['grains.get']('maven', {}) %}

{%- set maven_home         = salt['grains.get']('maven_home', salt['pillar.get']('maven_home', '/opt/maven' )) %}

{%- set version            = g.get('version', p.get('version', '3.3.9')) %}
{%- set major              = version.split('.') | first %}
{%- set mirror             = g.get('mirror', p.get('mirror', 'http://www.us.apache.org/dist/maven' )) %}

{%- set default_user       = 'undefined' %}
{%- set default_orgdomain  = 'example.com' %}
{%- set default_scmhost    = 'scmhost' %}
{%- set default_repohost   = 'repository' %}
{%- set default_archetypes = 'undefined' %}
{%- set default_prefix     = '/usr/lib' %}
{%- set default_source_url = mirror ~ '/maven-' ~ major ~ '/' ~ version ~ '/binaries/apache-maven-' ~ version ~ '-bin.tar.gz' %}
{%- set default_dl_opts    = ' -s ' %}
{%- set default_real_home  = default_prefix ~ '/apache-maven-' ~ version %}
{%- set default_m2_home    = default_real_home %}
{%- set default_symlink    = '/usr/bin/mvn' %}
{%- set default_realcmd    = maven_home ~ '/bin/mvn' %}

{% if salt['grains.get']('saltversioninfo') <= [2016, 11, 6] %}
   ###### hash for maven3.3.9 #####
   {%- set default_source_hash = "sha1=5b4c117854921b527ab6190615f9435da730ba05" %}
{% else %}
   {%- set default_source_hash = default_source_url ~ '.sha1' %}
{% endif %}

{%- set default_alt_priority = '30' %}
{%- set default_archive_type = 'tar' %}

{%- set source_url    = g.get('source_url', p.get('source_url', default_source_url)) %}
{%- if source_url == default_source_url %}
  {%- set source_hash = default_source_hash %}
{%- else %}
  {%- set source_hash = g.get('source_hash', p.get('source_hash', default_source_hash )) %}
{%- endif %}

{%- set user          = g.get('default_user', salt['pillar.get']('default_user', p.get('default_user', default_user)))%}
{%- set orgdomain     = g.get('orgdomain', p.get('orgdomain', default_orgdomain )) %}
{%- set scmhost       = g.get('scmhost', p.get('scmhost', default_scmhost )) %}
{%- set repohost      = g.get('repohost', p.get('repohost', default_repohost )) %}
{%- set archetypes    = g.get('archetypes', p.get('archetypes', default_archetypes )) %}

{%- set m2_home       = g.get('m2_home', p.get('m2_home', default_m2_home )) %}
{%- set dl_opts       = g.get('dl_opts', p.get('dl_opts', default_dl_opts)) %}
{%- set prefix        = g.get('prefix', p.get('prefix', default_prefix )) %}
{%- set real_home     = g.get('real_home', p.get('real_home', default_real_home )) %}
{%- set symlink       = g.get('symlink', p.get('symlink', default_symlink )) %}
{%- set realcmd       = g.get('realcmd', p.get('realcmd', default_realcmd )) %}
{%- set alt_priority  = g.get('alt_priority', p.get('alt_priority', default_alt_priority )) %}
{%- set archive_type  = g.get('archive_type', p.get('archive_type', default_archive_type )) %}

{%- set maven = {} %}
{%- do maven.update( {   'version'      : version,
                         'maven_home'   : maven_home,
                         'source_url'   : source_url,
                         'source_hash'  : source_hash,
                         'prefix'       : prefix,
                         'user'         : user,
                         'orgdomain'    : orgdomain,
                         'scmhost'      : scmhost,
                         'repohost'     : repohost,
                         'archetypes'   : archetypes,
                         'm2_home'      : m2_home,
                         'dl_opts'      : dl_opts,
                         'archive_type' : archive_type,
                         'real_home'    : real_home,
                         'symlink'      : symlink,
                         'realcmd'      : realcmd,
                         'alt_priority' : alt_priority,
                     }) %}
