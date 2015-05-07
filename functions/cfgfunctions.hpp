/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author         | Last Modified | Description
Wyste + BBrown | 05/03/2015    | Creates and appends AIO_FNC to each function listed.
______________________________________________________________________________________________________________________*/
// TODO: Needs Scrubbed for functions no longer in use.

class AIO
{
  tag = "AIO";
  class functions
  {
    file = "functions";
    class findLocation {};
    class findbuildings {};
    class getenterablehouses {};
    class getsecludedlocation {};
    class addactionmp {};
    class getcountbldgpos {};
    class randbldgpos {};
    class addrandtasktosign {};

    class intelpickup {};
    class inteldrop {};
    class addKilledEH {};
    class delallspawnedintelgroup {};
        
    class aliveSideMsg {};
    class aliveaddobjtoside {};
    class alivehaltprofilesenrouteto {};
    class alivenearestobjtoignoring {};
    class aliverandompointnear {};
    class aliveremoveobjectivefromsides {};
    
    class killcache {};
    class killhvt {};
    class helofinish {};
    class friendlytankfinish {};

    class endcheck {};
  };
};

class TASK
{
  tag = "TASK";
  class TASK
  {
    file = "tasks";
    class spawnintel {};
    class T1_spawncache {};
    class T1_hvt {};
    class T1_rescuehelo {};
    class T1_friendlytank {};
  };
};

class DEBUG
{
  tag = "DEBUG";
  class debug
  {
    file = "debug";
    class debugarray {};
    class dumpParams {};
  };
};
