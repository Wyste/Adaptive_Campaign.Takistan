/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

  Wyste | 4/20/2015 | Calls text for intel getting picked up.

______________________________________________________*/

private ["_title","_text","_msg"];

_msg = _this select 0;

_title = "<t size='1.2' color='#e5b348' shadow='1' shadowColor='#000000'>Adaptive Intel | ALiVE</t>
<img color='#ffffff' image='img_line_ca.paa' align='left' size='0.60' /><br/>";
_text = format["%1<t color='#eaeaea'>%2</t>
<br/><br/><img color='#ffffff' image='img_line_ca.paa' align='left' size='0.60' />",_title,_msg];

["openSideTop",1.4] call ALIVE_fnc_displayMenu;
["setSideTopText",_text] call ALIVE_fnc_displayMenu;