/* _       _             _   _              _____       _       _
  /_\   __| | __ _ _ __ | |_(_)_   _____    \_   \_ __ | |_ ___| |
 //_\\ / _` |/ _` | '_ \| __| \ \ / / _ \    / /\/ '_ \| __/ _ \ |
/  _  \ (_| | (_| | |_) | |_| |\ V /  __/ /\/ /_ | | | | ||  __/ |
\_/ \_/\__,_|\__,_| .__/ \__|_| \_/ \___| \____/ |_| |_|\__\___|_|
Author | Last Modified | Description

	Wyste | 4/20/2015 | handles the capture area at base checking
_____________________________________________________________________________*/

//Kill things VERY early cuzya know - nothing is here to check.
if (count AIO_CAPTURABLE == 0) exitWith {};

private ["_result"];
_result = [];
{
	private ["_id","_array"];
	_id = _x select 0;
	_array = _x select 1;


} forEach AIO_CAPTURABLE;


